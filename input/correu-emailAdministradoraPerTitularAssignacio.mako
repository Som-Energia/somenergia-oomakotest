<!doctype html>
<html>
<body>
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

rp_obj = object.pool.get('res.partner')
def get_clean_name(composed_name, vat, name_only):
    if rp_obj.vat_es_empresa(object._cr, object._uid, vat):
        return composed_name
    name = rp_obj.separa_cognoms(object._cr, object._uid, composed_name)
    if name_only:
        return name['nom']
    return '{} {}{}{}'.format(name['nom'],name['cognoms'][0],'' if name['fuzzy'] else ' ',name['cognoms'][1])

permissions = {
    'readonly': {'ca_ES':'visualitzar',
                 'es_ES':'visualizar'},
    'manage':   {'ca_ES':'gestionar',
                 'es_ES':'gestionar'}
}

final = {
    True: { 'ca_ES':'dels següents contractes',
            'es_ES':'de los siguientes contratos'},
    False: {'ca_ES':'del següent contracte',
            'es_ES':'del siguiente contrato'}
}

action = {
    True: { 'ca_ES':'modificat',
            'es_ES':'modificado'},
    False: {'ca_ES':'assignat',
            'es_ES':'asignado'}
}

mail_lang = object.receptor.lang
titular = get_clean_name(object.receptor.name, object.receptor.vat, True)
contractes = []
for mod in object.modification:
    contractes.append((
        mod.polissa_id.name,
        get_clean_name(mod.new_administradora.name, mod.new_administradora.vat, False),
        permissions[mod.permissions][mail_lang],
        action[bool(mod.old_administradora)][mail_lang],
    ))
plural = len(contractes)>1
%>
<br>
Hola ${titular},<br>
<br>
% if mail_lang != "es_ES":
T’enviem aquest correu per a confirmar-te que has modificat les opcions d’administració de l’Oficina Virtual ${final[plural][mail_lang]}:<br>
<ul>
% for (contracte, administradora, permission, action) in contractes:
    <li>Contracte ${contracte}: s’ha ${action} a la persona administradora ${administradora} per a ${permission} el contracte.</li>
% endfor
</ul>
Per a qualsevol dubte seguim en contacte.<br>
<br>
Equip de Som Energia<br>

% endif
% if mail_lang != "ca_ES" and mail_lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if mail_lang != "ca_ES":
Te enviamos este correo para confirmarte que has modificado las opciones de administración de la Oficina Virtual ${final[plural][mail_lang]}:<br>
<ul>
% for (contracte, administradora, permission, action) in contractes:
    <li>Contrato ${contracte}: se ha ${action} a la persona administradora ${administradora} para ${permission} el contrato.</li>
% endfor
</ul>
Para cualquier duda seguimos en contacto. <br>
<br>
Equipo de Som Energia<br>
% endif
<a href="https://www.somenergia.coop/">www.somenergia.coop</a><br>
<br>
${text_legal}
</body>
</html>
