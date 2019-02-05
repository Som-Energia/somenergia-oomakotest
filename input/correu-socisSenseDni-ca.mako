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
Benvolgut/da,<br>
<br>
Hem detectat que a la teva fitxa de soci/a ens hi <b>manca el teu número de DNI.</b><br>
<br>
Aquest fet impedeix que puguis fer el tràmit de contractar amb la cooperativa, si així ho desitges, tenir accés a l'Oficina Virtual de Som Energia o altres gestions per a les que és necessari fer constar aquesta dada.<br>
<br>
Així doncs, per poder completar la teva fitxa de soci/a, et demanem que ens facis arribar el teu número de DNI directament contestant a aquest mateix correu.<br>
<br>
De la fitxa en qüestió, consta:<br>
- Persona sòcia: <b>${object.name} </b><br>
- Número de soci/a: <b> ${num_soci} </b><br>
<br>
Moltes gràcies,<br>
<br>
Salutacions i seguim en contacte,<br>
<br>
Equip de Som Energia<br>
info@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
${text_legal}
</body>
</html>
</html>
