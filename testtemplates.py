#!/usr/bin/env python
#--**-- encoding: utf-8 --**--

from namespace import namespace as ns
import sys
import os
import argparse
import codecs

testcases = ns.load("testcases.yaml")

parser = argparse.ArgumentParser(
	description=
		"Manega els testos d'esquena contra esquena (b2b) de "
		"les plantilles en Mako de correu de l'OpenERP",
	epilog=
		"Si no s'especifica cap testcase es fan tots",
	)
subparsers = parser.add_subparsers(help='sub-command help', dest='subcommand')
subparsers.add_parser('test', help="Executa els testos indicats contra l'entorn de proves")
subparsers.add_parser('accept', help="Accepta les sortides dels testos indicats")
subparsers.add_parser('upload', help="Puja a l'entorn de producció la plantilla indicada")
downloadSubcommand=subparsers.add_parser('download', help="Baixa de l'entorn de producció la plantilla indicada")
subparsers.add_parser('list', help="Lista els casos de test disponibles")
subparsers.add_parser('status', help="Lista els casos de test disponibles")
downloadSubcommand.add_argument(
	'testcases',
	metavar='TESTCASE',
	nargs='*',
	)

def iterTestCases():
	for testCaseName, fixture in testcases.items():
		for testMethod, id in fixture.cases.items():
			yield testCaseName+'.'+testMethod, fixture, id

args = parser.parse_args(sys.argv[1:])

sys.argv = sys.argv[:1]

if args.subcommand == 'list':
	for testCase, fixture, id in iterTestCases():
		print testCase
	sys.exit(-1)

from cfg import config as remotecfg
from cfg import dbconfig as dbcfg



def loadErp(dbcfg):
	sys.path.append(os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),"../erp/server/bin")))

	import netsvc
	import tools
	tools.config.parse()
	tools.config['db_name'] = dbcfg.dbname
	tools.config['db_host'] = dbcfg.host
	tools.config['db_user'] = dbcfg.user
	tools.config['db_password'] = dbcfg.pwd
	tools.config['db_port'] = dbcfg.port
	tools.config['root_path'] = "../erp/server"
	tools.config['addons_path'] = "../erp/server/bin/addons"
	tools.config['log_level'] = 'warn'
	tools.config['log_file'] = open('/dev/null','w')
	#tools.config['log_handler'] = [':WARNING']

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
				'db': dbcfg.dbname,
			}
			import mako.template
			return mako.template.Template(makoinput).render_unicode(
				object=obj,
				peobject=obj,
				env=env,
				format_exceptions=True,
				)



from consolemsg import step, error, success, fail, warn
import glob
import shutil
import subprocess


if args.subcommand in ('upload'):
	sys.argv.remove(args.subcommand)
	consolemsg.error("Command '{}' not yet implemented".format(args.subcommand))
	sys.exit(-1)

def download():
	for case in args.testcases:
		case in testcases or fail(
			"El cas {} no esta a testcases.yaml"
			.format(case))

	from ooop import OOOP
	O = OOOP(**remotecfg)
	for name, fixture in testcases.items():
		if 'poweremailId' not in fixture: continue
		if args.testcases and name not in args.testcases:
			continue
		template = O.PoweremailTemplates.get(fixture.poweremailId)
		step("Fetching {}...".format(name))
		with codecs.open(fixture.template, 'w', encoding='utf8') as f:
			f.write(template.def_body_text)
		if fixture.get('model') != template.model_int_name:
			warn("Compte, el model hauria de ser '{}'"
				.format(template.model_int_name))
		
	sys.exit(0)


if args.subcommand == 'download':
	download()





if args.subcommand == 'accept':
	for testCaseName, fixture in testcases.items() :
		for testMethod, id in fixture.cases.items():
			testcase = testCaseName+'.'+testMethod
			resultFilename = os.path.join('b2bdata',testcase+'-result.html')
			expectedFilename = os.path.join('b2bdata',testcase+'-expected.html')
			if not os.access(resultFilename, os.R_OK) : continue
			step("Accepting "+testcase)
			shutil.move(resultFilename, expectedFilename)
	sys.exit()




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

import unittest

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
	unittest.main()







