<!doctype html>
<html>

% if object.cups_polissa_id.titular.lang == "ca_ES":
<table width="100%" frame="below" bgcolor="#E8F1D4">
<tbody>
<tr>
<td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia n&ordm; ${object.cups_polissa_id.name}</strong></span></td>
<td rowspan="4" valign="TOP"><img src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png" width="130" height="65"></td>
</tr>
<tr>
<td height="2px"><span style="font-size: xx-small;">Adre&ccedil;a punt subministrament: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
<td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
<td width="100%" height="2px"><span style="font-size: xx-small;"> Titular: ${object.cups_polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
% else:
<table width="100%" frame="below" bgcolor="#E8F1D4">
<tbody>
<tr>
<td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia n&ordm; ${object.cups_polissa_id.name}</strong></span></td>
<td rowspan="4" valign="TOP"><img src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png" width="130" height="65"></td>
</tr>
<tr>
<td height="2px"><span style="font-size: xx-small;">Direcci&oacute;n punto suministro: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
<td height="2px"><span style="font-size: xx-small;">C&oacute;digo CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
<td width="100%" height="2px"><span style="font-size: xx-small;">Titular:${object.cups_polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
% endif
<%
import sys

def get_autoconsum_description(object_, auto_consum, lang):
  C205 = object_.pool.get('giscedata.switching.c2.05')
  tipus_autoconsum = dict(C205.fields_get(object_._cr, object_._uid, context={'lang': lang})['tipus_autoconsum']['selection'])

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
lineesDePotencia_ca = '\n'.join((
  '\t- <strong> %s: </strong>%s W'%(p.name, p.potencia)
  for p in pas5.header_id.pot_ids
  if p.potencia != 0
  ))
lineesDePotencia_es = lineesDePotencia_ca
if TarifaATR == "2.0TD":
  lineesDePotencia_ca = lineesDePotencia_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
  lineesDePotencia_es = lineesDePotencia_es.replace("P1:", "Punta:").replace("P2:", "Valle:")
autoconsum_description = False
if pas5.tipus_autoconsum != '00' and pas5.tipus_autoconsum:
  autoconsum_description = get_autoconsum_description(object, pas5.tipus_autoconsum, object.cups_polissa_id.titular.lang)

subministrament_essencial = False
if object.cups_polissa_id.titular_nif[2] in ['P','Q','S'] or object.cups_polissa_id.cnae.name in ['3600', '4910', '4931', '4939', '5010', '5110', '5221', '5222', '5223', '5229', '8621', '8622', '8690', '8610', '9603']:
  subministrament_essencial = True
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
tarifaComer = object.cups_polissa_id.modcontractuals_ids[0].llista_preu.nom_comercial or object.cups_polissa_id.modcontractuals_ids[0].llista_preu.name
%>

<br>
<br>
Hola${nom_titular},<br>
<br>
% if object.cups_polissa_id.titular.lang != "es_ES":
Ens plau comunicar-te que el procés de canvi de comercialitzadora ha finalitzat,  <font COLOR="green"><strong>el contracte està activat amb Som Energia</strong></font> des del ${data_activacio}.<br>
<br>
Per a qualsevol consulta o aclariment, aquestes són les teves dades:<br>
<ul>
<li><strong>N&uacute;mero de contracte amb Som Energia: </strong>${object.cups_polissa_id.name}</li>
<li><strong>CUPS: </strong>${object.cups_id.name}</li>
<li><strong>Direcci&oacute; del punt de subministrament: </strong>${object.cups_id.direccio}</li>
<li><strong>Titular: </strong>${object.cups_polissa_id.titular.name}</li>
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
<li><strong>Soci/a vinculat/da: </strong>${object.cups_polissa_id.soci.name}</li>
<li><strong> Tarifa: </strong>${tarifaComer}</li>
<li><strong> Potència: </strong>
${lineesDePotencia_ca}</li>
%if autoconsum_description:
<ul>
<li><strong> Modalitat autoconsum: </strong> ${autoconsum_description}</li>
</ul>

<br>
% if object.cups_polissa_id.mode_facturacio == "index":
T’adjuntem les condicions particulars, generals i específiques. Recorda que el contracte <strong> s'activa amb les mateixes potències que tenies amb l'anterior comercialitzadora. </strong>  Si vols modificar-les pots fer-ho a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a>.<br>
% else:
T’adjuntem les condicions particulars i generals. Recorda que el contracte <strong> s'activa amb les mateixes potències que tenies amb l'anterior comercialitzadora. </strong>  Si vols modificar-les pots fer-ho a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a>.<br>
% endif
<br>
A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> també pots consultar les dades del contracte i veure totes les teves factures.<br>
<br>
%if subministrament_essencial:
Si aquest contracte de llum correspon a un <a href="https://ca.support.somenergia.coop/article/1226-subministraments-essencials">subministrament essencial</a>, per tal de disposar d’una protecció especial i que no es pugui suspendre el subministrament elèctric, cal que ens ho indiqueu responent aquest mateix correu.<br>
<br>
%endif
Si tens algun dubte, trobaràs les preguntes més freqüents al <a href="https://ca.support.somenergia.coop/">Centre de Suport</a>.<br>
<br>
<br>
Atentament,<br>
<br>
Equip de Som Energia<br>
comercialitzacio@somenergia.coop<br>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
<br>----------------------------------------------------------------------------------------------------<br>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
Nos complace informarte que el proceso de cambio de comercializadora ha finalizado, <font COLOR="green"><strong>tu contrato con Som Energia está activado </strong></font> desde el ${data_activacio}.<br>
<br>
Los datos del nuevo contrato son:<br>
<ul>
<li><strong>N&uacute;mero de contrato con Som Energia: </strong>${object.cups_polissa_id.name}</li>
<li><strong>CUPS: </strong>${object.cups_id.name}</li>
<li><strong>Direcci&oacute;n del punto de suministro: </strong>${object.cups_id.direccio}</li>
<li><strong>Titular del contrato: </strong>${object.cups_polissa_id.titular.name}</li>
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
<li><strong>Socio/a vinculado/a: </strong>${object.cups_polissa_id.soci.name}</li>
<li><strong> Tarifa: </strong>${tarifaComer}</li>
<li><strong> Potencia: </strong>
${lineesDePotencia_es}</li>
%if autoconsum_description:
<ul>
<li><strong> Modalidad autoconsumo: </strong> ${autoconsum_description}</li>
</ul>
<br>
% if object.cups_polissa_id.mode_facturacio == "index":
Te adjuntamos las condiciones particulares, generales y específicas. Recuerda que el contrato <strong> se ha activado con las mismas potencias que tenías con la anterior comercializadora. </strong> Si quieres modificarlas puedes hacerlo a través de tu <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>. <br>
% else:
Te adjuntamos las condiciones particulares y generales. Recuerda que el contrato <strong> se ha activado con las mismas potencias que tenías con la anterior comercializadora. </strong> Si quieres modificarlas puedes hacerlo a través de tu <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>. <br>
% endif
<br>
En la <a href="https://oficinavirtual.somenergia.coop/es/login/"> Oficina Virtual </a> también puedes consultar los datos del contrato y ver todas tus facturas. <br>
<br>
%if subministrament_essencial:
Si este contrato de luz corresponde a un <a href="https://es.support.somenergia.coop/article/1227-suministros-esenciales">suministro esencial</a>, para disponer de una protección especial y que no se pueda suspender el suministro eléctrico, es necesario que nos lo indiquéis respondiendo este mismo correo.<br>
<br>
%endif
Si tienes alguna duda, encontrarás las preguntas más frecuentes en el <a href="https://es.support.somenergia.coop/"> Centro de Apoyo </a>.<br>
<br>
<br>
Atentamente,<br>
<br>
Equipo de Som Energia<br>
comercializacion@somenergia.coop<br>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br>
% endif
<br>
${text_legal}
<br>
</body>
</html>
