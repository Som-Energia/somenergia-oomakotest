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
this_contract_text = {
    True: { 'ca_ES':'aquests contractes',
            'es_ES':'estos contratos'},
    False: {'ca_ES':'aquest contracte',
            'es_ES':'este contrato'}
}

mail_lang = object.receptor.lang
administradora = get_clean_name(object.receptor.name, object.receptor.vat, True)
contractes = []
for mod in object.modification:
    contractes.append((
        mod.polissa_id.name,
        get_clean_name(mod.polissa_id.titular.name, mod.polissa_id.titular.vat, False),
        permissions[mod.permissions][mail_lang],
    ))
plural = len(contractes)>1
%>
<br>
Hola ${administradora},<br>
<br>
% if mail_lang != "es_ES":
T’enviem aquest correu per informar-te de les opcions d’administració de l’Oficina Virtual ${final[plural][mail_lang]}:<br>
<ul>
% for (contracte, titular, permission) in contractes:
    <li>Contracte ${contracte}: ${titular} t’ha assignat com a persona administradora per a ${permission} el contracte.</li>
% endfor
</ul>
<br>
Així doncs, podràs ${permission} ${this_contract_text[plural][mail_lang]} des de la teva Oficina Virtual, encara que no en siguis la persona titular. El fet que siguis administradora no implica que en siguis el/la responsable legal.
<br>
<br>
Si no has accedit mai a l'Oficina Virtual, <a href="https://ca.support.somenergia.coop/article/109-com-puc-accedir-a-l-oficina-virtual">aquí</a> t’expliquem com fer-ho.
<br>
<br>
Per a qualsevol dubte seguim en contacte.<br>
<br>
Equip de Som Energia<br>

% endif
% if mail_lang != "ca_ES" and mail_lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if mail_lang != "ca_ES":
Te enviamos este correo para informarte de las opciones de administración de la Oficina Virtual ${final[plural][mail_lang]}:<br>
<ul>
% for (contracte, titular, permission) in contractes:
    <li>Contrato ${contracte}: ${titular} te ha asignado como persona administradora para ${permission} el contrato.</li>
% endfor
</ul>
<br>
Por lo tanto, podrás ${permission} ${this_contract_text[plural][mail_lang]} desde tu Oficina Virtual, aunque no seas la persona titular. El hecho de que seas administradora no implica que seas el/la responsable legal.
<br>
<br>
Si no has accedido nunca a la oficina virtual, <a href="https://es.support.somenergia.coop/article/165-como-puedo-acceder-a-la-oficina-virtual">aquí</a> te explicamos cómo hacerlo.
<br>
<br>
Para cualquier duda seguimos en contacto. <br>
<br>
Equipo de Som Energia<br>
% endif
<a href="https://www.somenergia.coop/">www.somenergia.coop</a><br>
<br>
${text_legal}
</body>
</html>
