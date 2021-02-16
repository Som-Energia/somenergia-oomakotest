<html>
% if object.cups_polissa_id.titular.lang == "ca_ES":
<head><meta charset="utf-8"/><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% else:
<head><meta charset="utf-8"/><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% endif
<head></head>
<body>
<%
import sys
for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    # Deprecated method
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if model == 'giscedata.switching.a3.05':
    pas5 = obj
    break
try:
  from datetime import datetime, timedelta
  date = datetime.strptime(pas5.data_activacio, '%Y-%m-%d')
  data_activacio = date.strftime('%d/%m/%Y')
except:
  data_activacio = ''

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

TarifaATR=dict(object.pool.get(model).fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas5.tarifaATR]
if TarifaATR == '3.0A':
  lineesDePotencia = '\n'.join((
    '\t- <strong> %s: </strong>%s W'%(p.name, p.potencia)
    for p in pas5.header_id.pot_ids
    if p.potencia != 0
    ))
else:
  for p in pas5.header_id.pot_ids:
    if p.potencia == 0: continue
    potencia = p.potencia
    break

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
Hola${nom_titular},<br />
<br />
% if object.cups_polissa_id.titular.lang != "es_ES":
Ens plau comunicar-te que el procés d'alta de subministrament ha finalitzat,  <FONT COLOR="green"><strong>el contracte està activat amb Som Energia</strong></FONT> des del ${data_activacio}.<br />
<br />
Per a qualsevol consulta o aclariment, aquestes són les teves dades:<br />
<ul><br />
<li><strong>Número de contracte amb Som Energia: </strong>${object.cups_polissa_id.name}</li><br />
<li><strong>CUPS: </strong>${object.cups_id.name}</li><br />
<li><strong>Direcció del punt de subministrament: </strong>${object.cups_id.direccio}</li><br />
<li><strong>Titular: </strong>${object.cups_polissa_id.titular.name}</li><br />
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li><br />
<li><strong>Soci/a vinculat/da: </strong>${object.cups_polissa_id.soci.name}</li><br />
<li><strong> Tarifa: </strong>${TarifaATR}</li><br />
%if TarifaATR == '3.0A':
<li><strong> Potència: </strong><br />
${lineesDePotencia}</li><br />
%else:
<li><strong> Potència: </strong>${potencia} W</li><br />
%endif
</ul><br />
Aproximadament en el termini d’un mes, rebràs la primera factura, que inclourà els costos regulats per la tramitació de l’alta (i que cobra la distribuïdora).<br />
<br />
A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> pots consultar les dades del contracte, <a href="https://ca.support.somenergia.coop/article/265-puc-facilitar-jo-la-lectura">facilitar-nos les lectures</a> i veure totes les teves factures. També podràs sol·licitar modificar la potència o la tarifa contractada.<br />
<br />
Si tens algun dubte, trobaràs les preguntes més freqüents al <a href="https://ca.support.somenergia.coop/">Centre de Suport</a>.<br />
<br />
<br />
Atentament,<br />
<br />
Equip de Som Energia<br />
comercialitzacio@somenergia.coop<br />
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br />
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
<br />----------------------------------------------------------------------------------------------------<br />
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
Nos complace informarte que el proceso de alta de suministro ha finalizado, <FONT COLOR="green"><strong>tu contrato con Som Energia está activado </strong></FONT> desde el ${data_activacio}.<br />
<br />
Los datos del nuevo contrato son:<br />
<ul><br />
<li><strong>Número de contrato con Som Energia: </strong>${object.cups_polissa_id.name}</li><br />
<li><strong>CUPS: </strong>${object.cups_id.name}</li><br />
<li><strong>Dirección del punto de suministro: </strong>${object.cups_id.direccio}</li><br />
<li><strong>Titular del contrato: </strong>${object.cups_polissa_id.titular.name}</li><br />
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li><br />
<li><strong>Socio/a vinculado/a: </strong>${object.cups_polissa_id.soci.name}</li><br />
<li><strong> Tarifa: </strong>${TarifaATR}</li><br />
%if TarifaATR == '3.0A':
<li><strong> Potencia: </strong><br />
${lineesDePotencia}</li><br />
%else:
<li><strong> Potència: </strong>${potencia} W</li><br />
%endif
</ul><br />
Aproximadamente en el plazo de un mes, recibirás la primera factura, que incluirá  los costes regulados de la tramitación del alta (y que cobra la distribuidora).<br />
<br />
En la <a href="https://oficinavirtual.somenergia.coop/es/login/"> Oficina Virtual </a> puedes consultar los datos del contrato, <a href = "https://es.support.somenergia.coop/article/535-como-puedo-facilitar-la-lectura"> facilitarnos las lecturas </a> y ver todas tus facturas. También podrás solicitar modificar la potencia o la tarifa contratada.<br />
<br />
Si tienes alguna duda, encontrarás las preguntas más frecuentes en el  <a href="https://es.support.somenergia.coop/">Centro de Ayuda</a> .<br />
<br />
<br />
Atentamente,<br />
<br />
Equipo de Som Energia<br />
comercializacion@somenergia.coop<br />
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br />
% endif
<br />
${text_legal}
</body>
</html>
