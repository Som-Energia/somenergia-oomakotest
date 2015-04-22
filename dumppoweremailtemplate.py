#!/usr/bin/env python
import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),"../erp/server/bin")))

from cfg import config as cfg, dbconfig as dbcfg
import codecs

#from ooop import OOOP
#O = OOOP(**config)


model_id = 67
model = 'giscedata.polissa'
makofile = 'correu-canviPagador.mako'

model_id = 20033
model = 'giscedata.switching'
makofile = 'correuM105.mako'

uid=1

import netsvc
#logger = netsvc.Logger()
import tools
tools.config.parse()
tools.config['db_name'] = dbcfg.dbname
tools.config['db_host'] = dbcfg.host
tools.config['db_user'] = dbcfg.user
tools.config['db_password'] = dbcfg.pwd
tools.config['db_port'] = dbcfg.port
tools.config['root_path'] = "../erp/server"
tools.config['addons_path'] = "../erp/server/bin/addons"
tools.config['verbose'] = False

import pooler
import osv

#import workflow
#import report
#import service
#import sql_db

osv_ = osv.osv.osv_pool()
db,pool = pooler.get_db_and_pool(tools.config['db_name'])
netsvc.SERVICES['im_a_worker'] = True

from contextlib import closing

def renderMako(template, model, id):

	with closing(db.cursor()) as cursor:

		with codecs.open(template,'r','utf8') as f:
			makoinput = f.read()

		for obj in pool.get(model).browse(cursor,uid,[id]):
			print obj, obj.fields_get()

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
				return str(e)


#print renderMako(makofile, model, model_id)


from namespace import namespace as ns

testcases = ns.load("testcases.yaml")

for key, fixture in testcases.items() :
	print key
	for case, id in fixture.cases.items():
		print key,case
		output = renderMako(fixture.template, fixture.model, id)
		print output



