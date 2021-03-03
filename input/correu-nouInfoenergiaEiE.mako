<!doctype html>
<%
from mako.template import Template

def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )

def get_clean_name(object_, composed_name, vat, name_only):
    rp_obj = object_.pool.get('res.partner')
    if rp_obj.vat_es_empresa(object_._cr, object_._uid, vat):
        return composed_name
    name = rp_obj.separa_cognoms(object_._cr, object_._uid, composed_name)
    if name_only:
        return name['nom']
    return '{} {}{}{}'.format(name['nom'],name['cognoms'][0],'' if name['fuzzy'] else ' ',name['cognoms'][1])

t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_id = md_obj.get_object_reference(
    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
)[1]

text_legal = render(t_obj.read(
    object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
nom = get_clean_name(object, object.polissa_id.titular.name,
    object.polissa_id.titular.vat, True
)
%>
<html>
<body>

% if object.polissa_id.titular.lang != "es_ES":
<br>
Hola ${nom},<br>
<br>
${object.body_text}
<br>
Equip de Som Energia<br>
<a href="https://ca.support.somenergia.coop/article/672-servei-infoenergia">Centre d'ajuda</a><br>
empresa@somenergia.coop<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif

% if object.polissa_id.titular.lang != "ca_ES" and object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif

% if object.polissa_id.titular.lang != "ca_ES":
<br>
Hola ${nom},<br>
<br>
${object.body_text}
<br>
Equipo de Som Energia<br>
<a href="https://es.support.somenergia.coop/article/673-el-servicio-infoenergia">Centro de Ayuda</a><br>
empresa@somenergia.coop<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif

${text_legal}
</body>
</html>

