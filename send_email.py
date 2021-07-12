import sys
import configdb; import ooop; O = ooop.OOOP(**configdb.ooop)
from yamlns import namespace as ns

if len(sys.argv) < 3:
	print "USAGE: testcasesfile.yaml nomdelaplantilla [ mail_to ]"
	exit(1)

if O.uri != 'http://192.168.1.28':
	print "Not on testing!!!"
	exit(1)

testcases = ns.load(sys.argv[1])
plantilla = getattr(testcases, sys.argv[2])

if len(sys.argv) >  3:
    mail_to = sys.argv[3]

template_id = plantilla.poweremailId
if not isinstance(template_id, int):
    module_name, poweremail_id = template_id.split(".")
    template_id = O.IrModelData.get_object_reference(
        module_name, poweremail_id
    )[1]

model = plantilla.model

case_list = list(plantilla.cases)
question = "Which case you want to select?\n> "
for i, case in enumerate(case_list):
	print str(i), "-", case
i = input(question)
case_key = case_list[i]
case_value = getattr(plantilla.cases, case_key)
print "Selected case %s: %d" % (case_key, case_value)

ctx = {
    'active_ids': [case_value],
    'active_id': case_value,
    'template_id': template_id,
    'src_model': model,
    'src_rec_ids': [case_value],
    'from': 16,
    'state': 'single',
    'priority': 0,
    'empowering_channel': 'test1',
    'extra_render_values': {'notificacio_text': 'Text de notificacio rebuig'}
}
params = {
    'state': 'single',
    'priority': 0,
    'from': 16,
    'bcc': '',
}
if mail_to:
    ctx['to'] = mail_to
    params['to'] = mail_to

print "======"
print "CTX:"
print ctx
print "======"
print "PARAMS:"
print params
print "======"
wz_id = O.PoweremailSendWizard.create(params, ctx)
result = O.PoweremailSendWizard.send_mail([wz_id], ctx)
