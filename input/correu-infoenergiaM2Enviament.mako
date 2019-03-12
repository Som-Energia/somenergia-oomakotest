<!doctype html>
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
<html>
<body>
% if object.pagador.lang  == "ca_ES":
<br>
Hola ${object.direccio_pagament.name.split(',')[-1]},<br>
<br>
${env['user']._context.get('body_personal')}.<br>
<br>
Moltes gràcies per la teva confiança i qualsevol comentari, observació o suggeriment ens el pots fer arribar responent a aquest mateix correu.<br>
<br>
Bona Energia!<br>
<br>
% endif
% if  object.pagador.lang  != "ca_ES":
<br>
Hola ${object.direccio_pagament.name.split(',')[-1]},<br>
<br>
${env['user']._context.get('body_personal')}.<br>
<br>
Muchas gracias por tu confianza y cualquier comentario, observación o sugerencia nos lo puedes hacer llegar respondiendo a este mismo correo.<br>
<br>
Buena Energía!<br>
<br>
% endif
${text_legal}
</body>
</html>
