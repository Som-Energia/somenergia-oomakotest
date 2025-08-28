<%
import sys
cups_obj = object.pool.get('giscedata.cups.ps')

def get_autoconsum_pot_gen(object_, dades_cau):
    sumatori_pot = 0
    for cau in dades_cau:
        for inst in cau.dades_instalacio_gen:
            sumatori_pot += inst.pot_installada_gen
    pot_installada = sumatori_pot or ' '
    return pot_installada

def get_autoconsum_is_collectiu(object_, dades_cau):
    for cau in dades_cau:
        if cau.collectiu:
            return True
    return False

for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    # Deprecated method
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if model.startswith('giscedata.switching.c1.05') or model.startswith('giscedata.switching.c2.05') or model.startswith('giscedata.switching.c2.07'):
    pas05 = obj
    break
try:
  from datetime import datetime, timedelta
  date = datetime.strptime(pas05.data_activacio, '%Y-%m-%d')
  data_activacio = date.strftime('%d/%m/%Y')
except:
  data_activacio = ''

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

TarifaATR=dict(object.pool.get(model).fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas05.tarifaATR]
lineesDePotencia_ca = '\n'.join((
  '\t- <strong> %s: </strong>%s W'%(p.name, p.potencia)
  for p in pas05.header_id.pot_ids
  if p.potencia != 0
  ))
lineesDePotencia_es = lineesDePotencia_ca

if TarifaATR == "2.0TD":
  lineesDePotencia_ca = lineesDePotencia_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
  lineesDePotencia_es = lineesDePotencia_es.replace("P1:", "Punta:").replace("P2:", "Valle:")

autoconsum_description = False
if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False and pas05.dades_cau[0].tipus_autoconsum != '00':
  autoconsum_description = cups_obj.get_autoconsum_description(object._cr, object._uid, pas05.dades_cau[0].tipus_autoconsum, object.cups_polissa_id.titular.lang)
  if pas05.dades_cau[0].tipus_subseccio:
    tipus_subseccio_description = cups_obj.get_auto_tipus_subseccio_description(object._cr, object._uid, pas05.dades_cau[0].tipus_subseccio, object.cups_polissa_id.titular.lang)
  else:
    tipus_subseccio_description = ' '
  if pas05.dades_cau[0].dades_instalacio_gen:
    potencia_generacio_desc = get_autoconsum_pot_gen(object, pas05.dades_cau)
  else:
    potencia_generacio_desc = ' '
  colectiu_desc = get_autoconsum_is_collectiu(object, pas05.dades_cau)

subministrament_essencial = False
if object.cups_polissa_id.titular_nif[2] in ['P','Q','S'] or object.cups_polissa_id.cnae.name in ['3600', '4910', '4931', '4939', '5010', '5110', '5221', '5222', '5223', '5229', '8621', '8622', '8690', '8610', '9603']:
  subministrament_essencial = True

if object.cups_polissa_id.modcontractuals_ids:
  tarifaComer = object.cups_polissa_id.modcontractuals_ids[0].llista_preu.nom_comercial or object.cups_polissa_id.modcontractuals_ids[0].llista_preu.name
else:
  tarifaComer = object.cups_polissa_id.llista_preu.nom_comercial or object.cups_polissa_id.llista_preu.name

from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>

${plantilla_header}

% if object.cups_polissa_id.titular.lang != "es_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia n&ordm; ${object.cups_polissa_id.name}</strong></span></td>
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
<p><br>Hola${nom_titular},<br></p>
<p>Ens plau comunicar-te que el proc&eacute;s de canvi de comercialitzadora ha finalitzat, <strong>el contracte est&agrave; activat amb Som Energia</strong> des del ${data_activacio}.<br><br>Per a qualsevol consulta o aclariment, aquestes s&oacute;n les teves dades:</p>
<ul>
<li><strong>N&uacute;mero de contracte amb Som Energia: </strong>${object.cups_polissa_id.name}</li>
<li><strong>CUPS: </strong>${object.cups_id.name}</li>
<li><strong>Adre&ccedil;a del punt de subministrament: </strong>${object.cups_id.direccio}</li>
<li><strong>Titular: </strong>${object.cups_polissa_id.titular.name}</li>
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
<li><strong>Soci/a vinculat/da: </strong>${object.cups_polissa_id.soci.name}</li>
<li><strong> Tarifa: </strong>${tarifaComer}</li>
<li><strong> Pot&egrave;ncia: </strong>${lineesDePotencia_ca}</li>
</ul>
%if autoconsum_description:
<ul>
<li><strong> Modalitat autoconsum: </strong> ${autoconsum_description}</li>
<li><strong> Subsecció: </strong> ${tipus_subseccio_description}</li>
<li><strong> Potència generació: </strong> ${potencia_generacio_desc}</li>
%if colectiu_desc:
<li><strong> Coŀlectiu: </strong> Sí</li>
%endif
</ul>
<p>Si la teva modalitat d&rsquo;autoconsum &eacute;s amb compensaci&oacute; d&rsquo;excedents, tamb&eacute; s&rsquo;ha activat el&nbsp;<a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar">Flux Solar</a>.&nbsp;</p>
%endif

% if object.cups_polissa_id.mode_facturacio == "index":
<p>T&rsquo;adjuntem les condicions particulars, generals i espec&iacute;fiques. Recorda que el contracte <strong> s'activa amb les mateixes pot&egrave;ncies que tenies amb l'anterior comercialitzadora. </strong> Si vols modificar-les pots fer-ho a trav&eacute;s de la teva <a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a>.</p>
% else:
<p>T&rsquo;adjuntem les condicions particulars i generals. Recorda que el contracte <strong> s'activa amb les mateixes pot&egrave;ncies que tenies amb l'anterior comercialitzadora. </strong> Si vols modificar-les pots fer-ho a trav&eacute;s de la teva <a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a>.</p>
% endif
<p><br>A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> tamb&eacute; pots consultar les dades del contracte i veure totes les teves factures.<br><br></p>
%if subministrament_essencial:
<p>Si aquest contracte de llum correspon a un <a href="https://ca.support.somenergia.coop/article/1226-subministraments-essencials">subministrament essencial</a>, per tal de disposar d&rsquo;una protecci&oacute; especial i que no es pugui suspendre el subministrament el&egrave;ctric, cal que ens ho indiqueu responent aquest mateix correu.<br><br></p>
%endif
<p>Si tens algun dubte, trobar&agrave;s les preguntes m&eacute;s freq&uuml;ents al <a href="https://ca.support.somenergia.coop/">Centre de Suport</a>.<br><br><br>Atentament,<br><br>Equip de Som Energia<br>comercialitzacio@somenergia.coop<br><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a></p>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
<p><br>----------------------------------------------------------------------------------------------------</p>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
<table width="100%" frame="below">
<tbody>
<tr>
<td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia n&ordm; ${object.cups_polissa_id.name}</strong></span></td>
</tr>
<tr>
<td height="2px"><span style="font-size: xx-small;">Direcci&oacute;n punto suministro: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
<td height="2px"><span style="font-size: xx-small;">C&oacute;digo CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
<td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${object.cups_polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
<p><br>Hola${nom_titular},<br></p>
<p>Nos complace informarte que el proceso de cambio de comercializadora ha finalizado, <strong>tu contrato con Som Energia est&aacute; activado </strong> desde el ${data_activacio}.<br><br>Los datos del nuevo contrato son:</p>
<ul>
<li><strong>N&uacute;mero de contrato con Som Energia: </strong>${object.cups_polissa_id.name}</li>
<li><strong>CUPS: </strong>${object.cups_id.name}</li>
<li><strong>Direcci&oacute;n del punto de suministro: </strong>${object.cups_id.direccio}</li>
<li><strong>Titular del contrato: </strong>${object.cups_polissa_id.titular.name}</li>
<li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
<li><strong>Socio/a vinculado/a: </strong>${object.cups_polissa_id.soci.name}</li>
<li><strong> Tarifa: </strong>${tarifaComer}</li>
<li><strong> Potencia: </strong>${lineesDePotencia_es}</li>
</ul>
%if autoconsum_description:
<ul>
<li><strong> Modalidad autoconsumo: </strong> ${autoconsum_description}</li>
<li><strong> Subsección: </strong> ${tipus_subseccio_description}</li>
<li><strong> Potencia generación: </strong> ${potencia_generacio_desc}</li>
%if colectiu_desc:
<li><strong> Colectivo: </strong> Sí</li>
%endif
</ul>
<p>Si tu modalidad de autoconsumo es con compensaci&oacute;n de excedentes, tambi&eacute;n se ha activado el <a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar">Flux Solar</a>.&nbsp;</p>
%endif

% if object.cups_polissa_id.mode_facturacio == "index":
<p>Te adjuntamos las condiciones particulares, generales y espec&iacute;ficas. Recuerda que el contrato <strong> se ha activado con las mismas potencias que ten&iacute;as con la anterior comercializadora. </strong> Si quieres modificarlas puedes hacerlo a trav&eacute;s de tu <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>.</p>
% else:
<p>Te adjuntamos las condiciones particulares y generales. Recuerda que el contrato <strong> se ha activado con las mismas potencias que ten&iacute;as con la anterior comercializadora. </strong> Si quieres modificarlas puedes hacerlo a trav&eacute;s de tu <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>.</p>
% endif
<p><br>En la <a href="https://oficinavirtual.somenergia.coop/es/login/"> Oficina Virtual </a> tambi&eacute;n puedes consultar los datos del contrato y ver todas tus facturas. <br><br></p>
%if subministrament_essencial:
<p>Si este contrato de luz corresponde a un <a href="https://es.support.somenergia.coop/article/1227-suministros-esenciales">suministro esencial</a>, para disponer de una protecci&oacute;n especial y que no se pueda suspender el suministro el&eacute;ctrico, es necesario que nos lo indiqu&eacute;is respondiendo este mismo correo.<br><br></p>
%endif
<p>Si tienes alguna duda, encontrar&aacute;s las preguntas m&aacute;s frecuentes en el <a href="https://es.support.somenergia.coop/"> Centro de Apoyo </a>.<br><br><br>Atentamente,<br><br>Equipo de Som Energia<br>comercializacion@somenergia.coop<br><a href="https://www.somenergia.coop">www.somenergia.coop</a></p>
% endif

${plantilla_footer}

