#!/usr/bin/env python
import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),"../erp/server/bin")))

#from ooop import OOOP
from cfg import config as cfg, dbconfig as dbcfg
import codecs


#O = OOOP(**config)

model_id = 34987
model_id = 1
#pool = O.GiscedataSwitching
model = 'giscedata.switching'
model = 'res.users'
makofile = 'correuM105.mako'
uid=1
contextid=1

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

import pooler

from tools import config
import osv
import workflow
import report
import service
import sql_db
osv_ = osv.osv.osv_pool()
db,pool = pooler.get_db_and_pool(config['db_name'])
netsvc.SERVICES['im_a_worker'] = True


cursor = db.cursor()

with codecs.open(makofile,'r','utf8') as f:
	makoinput = f.read()

obj = pool.get(model).browse(cursor,uid,model_id)
print obj, obj.fields_get()

env = {
	'user':pool.get('res.users').browse(cursor,uid,uid),
	'db': cfg.dbname,
}

import mako.template

reply = mako.template.Template(makoinput).render_unicode(
	object=obj,
	peobject=obj,
	env=env,
	format_exceptions=True,
	)
print reply


