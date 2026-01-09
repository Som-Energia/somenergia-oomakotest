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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>

${plantilla_header}

% if object.invoice_id.partner_id.lang != "es_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;"> Titular: ${object.polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola,<br/>
<br/>
Aquest correu electrònic és per recordar-te, en nom i representació de Som Energia, SCCL, i per tal d’interrompre el termini de prescripció, que queden per pagar les factures següents ${object.number} a favor de Som Energia. Et reiterem que, per tal de procedir al pagament, et pots posar en contacte amb <a href="mailto:cobraments@somenergia.coop">cobraments@somenergia.coop</a>.<br />
<br />
Cordialment,<br />
<br />
Equip de Som Energia<br />
cobraments@somenergia.coop<br />
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br />
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<br />----------------------------------------------------------------------------------------------------<br />
% endif
% if object.partner_id.lang != "ca_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${object.polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola,<br/>
<br/>
Este correo electrónico es para recordarte, en nombre y representación de Som Energia, SCCL, y al objeto de interrumpir el plazo de prescripción, que quedan por pagar las siguientes facturas ${object.number} a favor de Som Energia. Te reiteramos que, para proceder al pago, te puedes poner en contacto con <a href="mailto:cobros@somenergia.coop">cobros@somenergia.coop</a><br />
<br />
Cordialmente,<br />
<br />
Equipo de Som Energia<br />
cobros@somenergia.coop<br />
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br />
% endif
${plantilla_footer}
