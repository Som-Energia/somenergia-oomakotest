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
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: small;">Adreça punt subministrament: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: small;">Codi CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: small;">Factura: ${object.number}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: small;">Estat pendent: ${object.pending_state.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: small;"> Titular: ${object.polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
  Aquest missatge és un avís a l'equip de Cobraments pel pagament d'una factura des de la OV.<br/>
<br/>
${plantilla_footer}