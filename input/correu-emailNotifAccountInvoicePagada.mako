<%
  from mako.template import Template

  def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )

  pol_obj = object.pool.get('giscedata.polissa')
  polissa_id = pol_obj.search(object._cr, object._uid, [('name', '=', object.name)], context={'active_test': False})
  polissa = pol_obj.browse(object._cr, object._uid, polissa_id[0])

  t_obj = object.pool.get('poweremail.templates')
  md_obj = object.pool.get('ir.model.data')
  template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
  template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
  plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
  plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, polissa.pagador.vat):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid, polissa.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>

${plantilla_header}

% if object.lang_partner!= "es_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${polissa.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${polissa.cups.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${polissa.cups.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;"> Titular: ${polissa.titular.name} </span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola ${nom_pagador},<br/>
<br/>
Avui hem rebut la teva transferència com a pagament de la factura <b>${object.number}</b>. Aquesta factura ha quedat regularitzada.<br/>
<br/>
Per a qualsevol consulta seguim en contacte.<br/>
<br/>
Salutacions,<br/>
<br/>
Equip de Som Energia<br/>
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre de Suport</a><br/>
cobraments@somenergia.coop<br/>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if object.lang_partner != "ca_ES" and object.lang_partner != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.lang_partner != "ca_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${polissa.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${polissa.cups.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${polissa.cups.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${polissa.titular.name} </span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola${nom_pagador},<br/>
<br/>
Hoy hemos recibido tu transferencia como pago de la factura <b>${object.number}</b>. Esta factura ha quedado regularizada.<br/>
<br/>
Para cualquier duda o consulta seguimos en contacto.<br/>
<br/>
Un saludo,<br/>
<br/>
Equipo de Som Energia<br/>
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a><br/>
cobraments@somenergia.coop<br/>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
${plantilla_footer}
