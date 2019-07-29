<!doctype html>
<html>
<head><meta charset='utf8'></head><body>
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
<div align="right"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
% if object.partner_id.lang != "es_ES":
<p><br>
Benvolgut/da,<br>
<br>
T'enviem la <b>factura</b> de Som Energia. <br>
<br>
Si tens qualsevol dubte o consulta seguim en contacte,<br>
</p>
<br>
Atentament,<br>
<br>
Equip de Som Energia<br>
<a href="mailto:compres@somenergia.coop">compres@somenergia.coop</a><br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
<p><br>
Hola,<br>
<br>
Te enviamos la <b>factura</b> de Som Energia. <br>
<br>
Si tienes cualquier duda o consulta, seguimos en contacto,
</p>
<br>
Saludos,<br>
<br>
Equipo de Som Energia<br>
<a href="mailto:compres@somenergia.coop">compres@somenergia.coop</a><br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
