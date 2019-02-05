<!doctype html>
<html>
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
num_soci = object.ref[2:]
%>
<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"><br>
<br>
Estimado/a,<br> 
<br> 
Hemos detectado que en tu ficha de socio/a nos falta tu número de DNI.<br> 
<br> 
Este hecho impide que puedas hacer el trámite de contratar con la cooperativa, si así lo deseas, tener acceso a la Oficina Virtual de Som Energia u otras gestiones para las que es necesario hacer constar este dato.<br> 
<br> 
Así pues, para poder completar tu ficha de socio/a, te pedimos que nos hagas llegar tu número de DNI directamente contestando a este mismo correo.<br> 
<br> 
De la ficha en cuestión, consta:<br> 
- Persona socia: : <b>${object.name}</b><br>
- Número de socio/a : <b>${num_soci}</b><br>
<br> 
<br> 
Muchas gracias,<br> 
<br> 
Saludos y seguimos en contacto,<br> 
<br> 
Equipo de Som Energia<br> 
info@somenergia.coop<br> 
<a href="www.somenergia.coop">www.somenergia.coop</a><br> 
</body>
${text_legal}
</html>
</html>
