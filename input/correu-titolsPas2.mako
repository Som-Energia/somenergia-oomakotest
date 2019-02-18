<!doctype html>
<html>
<body>
<img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">
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
<br />
Benvolgut/da,<br />
<br />
En data d'avui s'ha enviat el rebut domiciliat corresponent a la teva subscripció de títols participatius de SOM ENERGIA SCCL.<br />
<br />
T'adjuntem el contracte amb les condicions generals de la subscripció  i et recordem que per qualsevol dubte o aclariment en relació a la compra efectuada pots enviar una e-mail a <a href="mailto:invertir@somenergia.coop">invertir@somenergia.coop</a><br />
<br />
Aprofitem per agraïr-te una vegada més la teva implicació amb el nostre projecte.<br />
 <br />
L'equip de Som Energia, SCCL<br />
<br />
${text_legal}
</body>
</html>
