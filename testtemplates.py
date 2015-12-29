#!/usr/bin/env python
#--**-- encoding: utf-8 --**--

import sys
import os
import argparse
import codecs
import unittest
from namespace import namespace as ns
from consolemsg import step, error, success, fail, warn

from cfg import config as remoteErpConfig
from cfg import psycopg as dbcfg


testcases = ns.load("testcases.yaml")

parser = argparse.ArgumentParser(
	description=
		"Manega els testos d'esquena contra esquena (b2b) de "
		"les plantilles en Mako de correu de l'OpenERP",
	epilog=
		"Si no s'especifica cap testcase es fan tots",
	)
subparsers = parser.add_subparsers(help='sub-command help', dest='subcommand')
for nargs, command, help in [
	('*', 'test', "Executa els testos indicats contra l'entorn de proves"),
	('*', 'accept', "Accepta les sortides dels testos indicats"),
	('+', 'upload', "Puja a l'entorn de producció la plantilla indicada"),
	('+', 'download', "Descarrega plantilla de l'entorn de producció"),
	('',  'list', "Llista els casos de test disponibles"),
	('',  'listtemplates', "Lista els templates al servidor"),
	('*', 'status', "Mostra l'estat dels casos"),
	('*', 'import', "Importa els templates"),
	] :
	sub = subparsers.add_parser(command, help=help)
	if nargs:
		sub.add_argument('testcases', metavar='TESTCASE', nargs=nargs,)

args = parser.parse_args(sys.argv[1:])
sys.argv = sys.argv[:1]


def iterTestCases():
	for testCaseName, fixture in testcases.items():
		for testMethod, id in fixture.cases.items():
			yield testCaseName+'.'+testMethod, fixture, id



def loadErp(dbcfg):
	sys.path.append(os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),"../erp/server/bin")))

	import netsvc
	import tools
	tools.config['db_name'] = dbcfg.database
	tools.config['db_host'] = dbcfg.host
	tools.config['db_user'] = dbcfg.user
	tools.config['db_password'] = dbcfg.password
	tools.config['db_port'] = dbcfg.port
	tools.config['root_path'] = "../erp/server"
	tools.config['addons_path'] = "../erp/server/bin/addons"
	tools.config['log_level'] = None #'warn'
	tools.config['log_file'] = open('/dev/null','w')
	#tools.config['log_handler'] = [':WARNING']
	tools.config['init'] = []
	tools.config['demo'] = []
	tools.config['update'] = []

	import pooler
	import osv

	osv_ = osv.osv.osv_pool()
	db,pool = pooler.get_db_and_pool(tools.config['db_name'])
	netsvc.SERVICES['im_a_worker'] = True

	return db, pool

db=None
pool=None


def renderMako(template, model, id, uid=1):
	from contextlib import closing

	global db, pool
	if db is None or pool is None :
		db, pool = loadErp(dbcfg)
	with closing(db.cursor()) as cursor:

		with codecs.open(template,'r','utf8') as f:
			makoinput = f.read()

		for obj in pool.get(model).browse(cursor,uid,[id]):
			env = {
				'user':pool.get('res.users').browse(cursor,uid,uid),
				'db': dbcfg.database,
			}
			import mako.template
			return mako.template.Template(makoinput).render_unicode(
				object=obj,
				peobject=obj,
				env=env,
				format_exceptions=True,
				)



def test():
	unittest.TestCase.__str__ = unittest.TestCase.id
	sys.argv.append("--verbose"); print sys.argv
	unittest.main()

def download():
	for case in args.testcases:
		case in testcases or fail(
			"El cas {} no esta a testcases.yaml"
			.format(case))

	from ooop import OOOP
	O = OOOP(**remoteErpConfig)
	for name, fixture in testcases.items():
		if 'poweremailId' not in fixture: continue
		if args.testcases and name not in args.testcases:
			continue
		template = O.PoweremailTemplates.get(fixture.poweremailId)
		step("Fetching {}...".format(name))
		with codecs.open(fixture.template, 'w', 'utf8') as f:
			f.write(template.def_body_text)
		if fixture.get('model') != template.model_int_name:
			warn("Compte, el model hauria de ser '{}'"
				.format(template.model_int_name))
		
def download():
	for case in args.testcases:
		case in testcases or fail(
			"El cas {} no esta a testcases.yaml"
			.format(case))

	from ooop import OOOP
	O = OOOP(**remoteErpConfig)
	for name, fixture in testcases.items():
		if 'poweremailId' not in fixture: continue
		if args.testcases and name not in args.testcases:
			continue
		template = O.PoweremailTemplates.get(fixture.poweremailId)
		step("Fetching {}...".format(name))
		with codecs.open(fixture.template, 'w', 'utf8') as f:
			f.write(template.def_body_text)
		if fixture.get('model') != template.model_int_name:
			warn("Compte, el model hauria de ser '{}'"
				.format(template.model_int_name))

def upload():
	from ooop import OOOP
	O = OOOP(**remoteErpConfig)
	if not args.testcases:
		fail("Cal especificar un o mes templates (pel nom de testCase.yaml)")
	step("Uploading to {uri}:{port} as {user}".format(**remoteErpConfig))
	for case in args.testcases:
		step("Uploading {}...".format(case))
		fixture = testcases[case]
		template = O.PoweremailTemplates.get(fixture.poweremailId)
		with codecs.open(fixture.template, 'r', 'utf8') as f:
			newContent = f.read()
		def write(filename, content):
			with codecs.open(filename, 'w', 'utf8') as f:
				f.write(content)
		write("backup-{}.mako".format(case), template.def_body_text)
		template.def_body_text = newContent
		template.save()
		for translation in O.IrTranslation.filter(
				name='poweremail.templates,def_body_text',
				res_id=template.id,
				): 
			step("Uploading {} translation {}...".format(case,translation.lang))
			#write("backup-{}-translation-src-{}.mako".format(case,translation.lang), translation.src)
			#translation.src=newContent
			write("backup-{}-translation-{}.mako".format(case,translation.lang), translation.value)
			translation.value=newContent
			translation.save()


def list():
	for testCase, fixture, id in iterTestCases():
		print testCase


def listtemplates():
	from ooop import OOOP
	O = OOOP(**remoteErpConfig)
	for t in O.PoweremailTemplates.all():
		print u'{} {} "{}"'.format(t.id, t.model_int_name, t.name)

def accept() :
	import shutil
	for testCaseName, fixture in testcases.items() :
		for testMethod, id in fixture.cases.items():
			testcase = testCaseName+'.'+testMethod
			resultFilename = os.path.join('b2bdata',testcase+'-result.html')
			expectedFilename = os.path.join('b2bdata',testcase+'-expected.html')
			if not os.access(resultFilename, os.R_OK) : continue
			step("Accepting "+testcase)
			shutil.move(resultFilename, expectedFilename)


def makeB2bTestCase(testCaseName, id) :
	def b2bTestCase(self):
		self.maxDiff = None
		resultFilename = os.path.join('b2bdata',testCaseName+'-result.html')
		expectedFilename = os.path.join('b2bdata',testCaseName+'-expected.html')
		if os.access(resultFilename, os.R_OK) :
			os.unlink(resultFilename)

		output = renderMako(self.fixture.template, self.fixture.model, id)

		try:
			with codecs.open(expectedFilename,'r', 'utf8') as expectedfile:
				expected = expectedfile.read()
		except:
			expected = None

		if expected != output :
			with codecs.open(resultFilename,'w', 'utf8') as outputfile:
				outputfile.write(output)

		if expected is None :
			self.fail(
				"No expectation for the testMethod, use the 'accept' "
				"subcommand to accept the current result as good '{}'"
				.format(resultFilename))

		self.assertMultiLineEqual(expected, output,
			"B2B data missmatch, use the 'accept' "
			"subcommand to accept the current result as good '{}'"
			.format(resultFilename))

	return b2bTestCase


def addDataDrivenTestCases():
	for testCase, fixture in testcases.items() :
		klassname = 'Test_B2B_{0}'.format(testCase)
		# Dynamically create a TestCase Subclass with all the test
		testMethods = dict([
			('test_{0}'.format(testMethod), 
				makeB2bTestCase(
					testCase+'.'+testMethod, data))
			for testMethod, data in fixture.cases.items()
			]+[
				('longMessage', True),
				('fixture', fixture),
			])

		globals()[klassname] = type( klassname, (unittest.TestCase,), testMethods)

addDataDrivenTestCases()


if __name__ == '__main__' :
	if args.subcommand not in globals() :
		error("Command '{}' not yet implemented".format(args.subcommand))
		sys.exit(-1)

	globals()[args.subcommand]()
	sys.exit(0)








