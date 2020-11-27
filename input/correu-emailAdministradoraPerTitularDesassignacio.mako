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

final = {
    True: { 'ca_ES':'dels següents contractes',
            'es_ES':'de los siguientes contratos'},
    False: {'ca_ES':'del següent contracte',
            'es_ES':'del siguiente contrato'}
}

mail_lang = object.receptor.lang
titular = get_clean_name(object.receptor.name, object.receptor.vat, True)
contractes = []
for mod in object.modification:
    if mod.error:
        continue
    contractes.append((
        mod.polissa_id.name,
        get_clean_name(mod.old_administradora.name, mod.old_administradora.vat, False),
    ))
plural = len(contractes)>1
%>
<br>
Hola ${titular},<br>
<br>
% if mail_lang != "es_ES":
T’enviem aquest correu per a confirmar-te que s'han modificat les opcions d’administració de l’Oficina Virtual ${final[plural][mail_lang]}:<br>
<ul>
% for (contracte, administradora) in contractes:
    <li>Contracte ${contracte}: s’ha desassignat a la persona administradora ${administradora}.</li>
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
Te enviamos este correo para confirmarte que se han modificado las opciones de administración de la Oficina Virtual ${final[plural][mail_lang]}:<br>
<ul>
% for (contracte, administradora) in contractes:
    <li>Contrato ${contracte}: se ha desasignado a la persona administradora ${administradora}.</li>
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
