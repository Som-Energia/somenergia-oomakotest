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
% if object.partner_id.lang != "es_ES":
<br/>
Hola ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Ahir ens va venir retornat el rebut de ${object.amount_total} € que et vam girar fa uns dies corresponent a la teva inversió en Generation kWh amb referència ${object.origin}<br/>
<br/>
Si segueixes interessat en aquesta inversió tens dues opcions:<br/>
Transferir aquesta quantitat al següent número de compte de Som Energia: ES19 3025 0016 12 1400005159, indicant el teu nom.<br/>
Dir-nos a partir de quina data et podem tornar a girar aquest rebut al teu banc.<br/>
<br/>
Si pel contrari, ja no estàs interessat en aquesta inversió t'agraïrem que ens ho comuniquis.<br/>
<br/>
Salut,<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a><br/>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if  object.partner_id.lang != "ca_ES":
<br/>
Hola ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Ayer nos vino devuelto el recibo de ${object.amount_total} € que te giramos hace unos dias correspondiente a tu inversión en Generation kWh con referencia ${object.origin}<br/>
<br/>
Si sigues interesado en esta inversión tienes dos opciones:<br/>
 Hacer una  transferencia al siguiente número de cuenta de Som Energia: ES19 3025 0016 12 1400005159, indicando tu nombre.<br/>
 Decirnos a partir de  que fecha podemos volver a girar el recibo en tu banco.<br/>
<br/>
Si por el contrario ya no estás interesado en esta inversión te agradeceremos que nos lo comuniques.<br/>
<br/>
Salud,<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${plantilla_footer}
