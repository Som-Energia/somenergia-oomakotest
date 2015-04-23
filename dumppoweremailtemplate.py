#!/usr/bin/env python
import os
import sys
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
tools.config['verbose'] = 1

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
				'db': cfg.dbname,
			}
			try:
				import mako.template
				return mako.template.Template(makoinput).render_unicode(
					object=obj,
					peobject=obj,
					env=env,
					format_exceptions=True,
					)

			except Exception as e:
				import traceback
				return traceback.format_exc()


#print renderMako(makofile, model, model_id)


from namespace import namespace as ns
from consolemsg import step, error, success
import glob
import shutil
import subprocess

testcases = ns.load("testcases.yaml")

if 'accept' in sys.argv:
	for key, fixture in testcases.items() :
		for case, id in fixture.cases.items():
			testcase = key+'.'+case
			resultFilename = os.path.join('b2bdata',testcase+'-result.html')
			expectedFilename = os.path.join('b2bdata',testcase+'-expected.html')
			if not os.access(resultFilename, os.R_OK) : continue
			step("Accepting "+testcase)
			shutil.move(resultFilename, expectedFilename)
	sys.exit()

if 'test' in sys.argv:
	for key, fixture in testcases.items() :
		for case, id in fixture.cases.items():
			testcase = key+'.'+case
			step(testcase)
			resultFilename = os.path.join('b2bdata',testcase+'-result.html')
			expectedFilename = os.path.join('b2bdata',testcase+'-expected.html')
			if os.access(resultFilename, os.R_OK) :
				os.unlink(resultFilename)

			output = renderMako(fixture.template, fixture.model, id)
			try:
				with codecs.open(expectedFilename,'r', 'utf8') as expectedfile:
					expected = expectedfile.read()
			except:
				expected = ''

			if expected != output :
				error("failed testcase: "+testcase)
				with codecs.open(resultFilename,'w', 'utf8') as outputfile:
					outputfile.write(output)
				subprocess.call(['diff', expectedFilename, resultFilename])
			else:
				success("Passed")



