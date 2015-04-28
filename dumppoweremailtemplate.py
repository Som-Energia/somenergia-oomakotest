#!/usr/bin/env python
#--**-- encoding: utf-8 --**--

from namespace import namespace as ns
import sys
import argparse

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
subparsers.add_parser('download', help="Baixa de l'entorn de producció la plantilla indicada")
subparsers.add_parser('list', help="Lista els casos de test disponibles")
subparsers.add_parser('status', help="Lista els casos de test disponibles")
parser.add_argument(
	'testcases',
	metavar='TESTCASE',
	nargs='*',
	)

args = parser.parse_args(sys.argv[1:])

sys.argv = sys.argv[:1]

import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),"../erp/server/bin")))

from cfg import config as cfg, dbconfig as dbcfg
import codecs

uid=1

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

from contextlib import closing

def renderMako(template, model, id):

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



from consolemsg import step, error, success
import glob
import shutil
import subprocess


if args.subcommand in ('upload','download'):
	sys.argv.remove(args.subcommand)
	consolemsg.error("Command '{}' not yet implemented".format(args.subcommand))
	sys.exit(-1)


if args.subcommand == 'upload':
	sys.argv.remove('download')
	consolemsg.error("download command not yet implemented")

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






