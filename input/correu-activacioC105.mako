<!doctype html>
<html>
% if object.cups_polissa_id.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGcolor="#E8F1D4"><tr><td height = 2px><font SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><font SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><font SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><font SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGcolor="#E8F1D4"><tr><td height = 2px><font SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><font SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><font SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><font SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% endif
<body>
<%
import sys

def get_autoconsum_description(object_, auto_consum, lang):
    C105 = object_.pool.get('giscedata.switching.c1.05')
    tipus_autoconsum = dict(C105.fields_get(object_._cr, object_._uid, context={'lang': lang})['tipus_autoconsum']['selection'])

    return auto_consum + " - " + tipus_autoconsum[auto_consum]

for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    # Deprecated method
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if model.startswith('giscedata.switching.c1.05') or model.startswith('giscedata.switching.c2.05') or model.startswith('giscedata.switching.c2.07'):
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
lineesDePotencia = '\n'.join((
  '\t- <strong> %s: </strong>%s W'%(p.name, p.potencia)
  for p in pas5.header_id.pot_ids
  if p.potencia != 0
  ))
if TarifaATR == "2.0TD":
    lineesDePotencia = lineesDePotencia.replace("P1:", "P1-2:").replace("P2:", "P3:")
autoconsum_description = False
if pas5.tipus_autoconsum != '00' and pas5.tipus_autoconsum:
  autoconsum_description = get_autoconsum_description(object, pas5.tipus_autoconsum, object.cups_polissa_id.titular.lang)
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
Ens plau comunicar-te que el procés de canvi de comercialitzadora ha finalitzat,  <font color="green"><strong>el contracte està activat amb Som Energia</strong></font> des del ${data_activacio}.<br />
<br />
Per a qualsevol consulta o aclariment, aquestes són les teves dades:<br />
<ul>
<li><strong>Número de contracte amb Som Energia: </strong>${object.cups_polissa_id.name}</li>
<li><strong>CUPS: </strong>${object.cups_id.name}</li>
<li><strong>Direcció del punt de subministrament: </strong>${object.cups_id.direccio}</li>
<li><strong>Titular: </strong>${object.cups_polissa_id.titular.name}</li>
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
<li><strong>Soci/a vinculat/da: </strong>${object.cups_polissa_id.soci.name}</li>
<li><strong> Tarifa: </strong>${TarifaATR}</li>
<li><strong> Potència: </strong>
${lineesDePotencia}</li>
%if autoconsum_description:
    <li><strong> Modalitat autoconsum: </strong> ${autoconsum_description}</li>
%endif
</ul>
%if autoconsum_description:
T'agrairem que ens facis arribar les següents dades referents al teu autoconsum:
<ul>
  <li>Codi autoconsum (CAU)</li>
  <li>Instal·lació col·lectiva o individual</li>
  <li>Tecnologia de producció</li>
  <li>Potència instal·lada kWp</li>
  <li>Tipus instal·lació: Interior / interior diversos consumidors / pròxima a través de xarxa</li>
  <li>Serveis auxiliars SI o NO</li>
</ul>
%endif
<br />
T’adjuntem les condicions particulars i generals. Recorda que el contracte <strong> s'activa amb les mateixes condicions contractuals (tarifa i potència) que tenies amb l'anterior comercialitzadora. </strong>  Si vols modificar-les pots fer-ho a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a>.<br />
<br />
A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> també pots consultar les dades del contracte i veure totes les teves factures.<br />
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
Nos complace informarte que el proceso de cambio de comercializadora ha finalizado, <font color="green"><strong>tu contrato con Som Energia está activado </strong></font> desde el ${data_activacio}.<br />
<br />
Los datos del nuevo contrato son:<br />
<ul>
<li><strong>Número de contrato con Som Energia: </strong>${object.cups_polissa_id.name}</li>
<li><strong>CUPS: </strong>${object.cups_id.name}</li>
<li><strong>Dirección del punto de suministro: </strong>${object.cups_id.direccio}</li>
<li><strong>Titular del contrato: </strong>${object.cups_polissa_id.titular.name}</li>
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
<li><strong>Socio/a vinculado/a: </strong>${object.cups_polissa_id.soci.name}</li>
<li><strong> Tarifa: </strong>${TarifaATR}</li>
<li><strong> Potencia: </strong>
${lineesDePotencia}</li>

%if autoconsum_description:
    <li><strong> Modalidad autoconsumo: </strong> ${autoconsum_description}</li>
%endif
</ul>
%if autoconsum_description:
Te agradeceremos que nos hagas llegar los siguientes datos referentes a tu autoconsumo:
<ul>
  <li>Código autoconsumo (CAU)</li>
  <li>Instalación colectiva o individual</li>
  <li>Tecnología de producción</li>
  <li>Potencia instalada kWp</li>
  <li>Tipo instalación: Interior / interior varios consumidores / próxima a través de red</li>
  <li>Servicios auxiliares SI o NO</li>
</ul>
%endif
<br />
Te adjuntamos las condiciones particulares y generales. Recuerda que el contrato <strong> se activa con las mismas condiciones contractuales (tarifa y potencia) que tenías con el anterior comercializadora. </strong> Si quieres modificarlas puedes hacerlo a través de tu <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>. <br />
<br />
En la <a href="https://oficinavirtual.somenergia.coop/es/login/"> Oficina Virtual </a> también puedes consultar los datos del contrato y ver todas tus facturas. <br />
<br />
Si tienes alguna duda, encontrarás las preguntas más frecuentes en el <a href="https://es.support.somenergia.coop/"> Centro de Apoyo </a>.<br />
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
