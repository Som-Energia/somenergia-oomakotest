<html>
% if object.cups_polissa_id.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td height = 2px><font SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><font SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><font SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><font SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td height = 2px><font SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><font SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><font SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><font SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head>
% endif
<body>
<%
for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    # Deprecated method
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if model.startswith('giscedata.switching.c1.06') or model.startswith('giscedata.switching.c2.06'):
    pas6 = obj

from datetime import datetime, timedelta
date = datetime.strptime(pas6.data_activacio, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

%>
<%
from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_id = md_obj.get_object_reference(
                    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                )[1]
text_legal = render(t_obj.read(
    object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
%>
<br />
<br />
Hola${nom_titular}, <br />
<br />
% if object.cups_polissa_id.titular.lang != "es_ES":
T’escrivim per informar-te que ens han comunicat la baixa del teu contracte amb Som Energia. La data de canvi de companyia és el <strong>${date}</strong><br />
<br />
No cal que facis cas d’aquest missatge si realment vols passar el contracte de Som Energia a una altra comercialitzadora.<br />
 <br />
Però si no eres conscient que s’ha realitzat aquesta sol·licitud i s’ha fet contra la teva voluntat, respon a aquest mateix correu i t'informarem dels passos a seguir perquè tornis a tenir el contracte amb la cooperativa.<br />
<br />
Gràcies.<br />
<br />
Salutacions,<br />
<br />
Equip de Som Energia<br />
comercialitzacio@somenergia.coop<br />
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br />
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
<br />----------------------------------------------------------------------------------------------------<br />
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
Te escribimos para informarte que nos han comunicado la baja de tu contrato con Som Energia. La fecha de cambio de compañia es el <strong>${date}</strong><br />
<br />
No es necesario que atiendas a este mensaje si realmente quieres pasar el contrato de Som Energia a otra comercializadora. <br />
 <br />
Pero si no eres consciente de que se realizó esta solicitud y se hizo contra tu voluntad, responde a este mismo correo y te informaremos de los pasos a seguir para que vuelvas a tener el contrato con la cooperativa.<br />
<br />
Gracias. <br />
<br />
Un saludo,<br />
<br />
Equipo de Som Energia<br />
comercializacion@somenergia.coop<br />
<a href="https://www.somenergia.coop/es">www.somenergia.coop</a><br />
% endif
<br />
${text_legal}
</body>
</html>
