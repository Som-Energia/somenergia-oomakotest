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
% if object.partner_id.lang != "es_ES":
<br>
Hola,<br>
<br>
Ens posem amb contacte amb tu per informar-te que hem tramitat correctament la teva baixa de persona sòcia.<br>
<br>
En data d'avui hem fet la devolució dels 100 € del capital social.<br>
<br>
T’agraïm el temps que has passat amb nosaltres ajudant-nos a canviar el model energètic actual.<br>
<br>
Desitgem que ens retrobem en un futur.<br>
<br>
Salut i bona energia!<br>
<br>
Equip de Som Energia<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
info@somenergia.coop
<a href="http://ca.support.somenergia.coop/article/470-com-puc-contactar-amb-la-cooperativa-mail-telefon-etc">Contactar amb Som Energia</a>
% endif

% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif

% if object.partner_id.lang != "ca_ES":
<br>
Hola,<br>
<br>
Nos ponemos en contacto contigo para informarte que hemos tramitado correctamente tu baja de persona socia.<br>
<br>
En fecha de hoy hemos efectuado la devolución de los 100 € del capital social.<br>
<br>
Te agradecemos el tiempo que has pasado con nosotros ayudándonos a cambiar el modelo energético actual.<br>
<br>
Deseamos reencontrarnos en un futuro.<br>
<br>
Salud y buena energía!<br>
<br>
Equipo de Som Energia<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
info@somenergia.coop
<a href="https://es.support.somenergia.coop/article/471-como-puedo-contactar-con-la-cooperativa-mail-telefono-etc">Contactar con Som Energia</a>
% endif
${text_legal}
</body>
</html>

                