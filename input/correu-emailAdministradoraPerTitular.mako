<!doctype html>
<html>
<%
mail_lang = object.titular.lang
%>
% if mail_lang == "ca_ES":
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia núm. ${object.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
% endif
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

titular = get_clean_name(object.titular.name, object.titular.vat, True)
administradora = get_clean_name(object.administradora.name, object.administradora_nif, False)

p_obj = object.pool.get('giscedata.polissa')
c_ids = p_obj.search(object._cr, object._uid, [
    ('titular.id','=',object.titular.id),
    ('administradora.id','=',object.administradora.id)])
c_data = p_obj.read(object._cr, object._uid, c_ids , ['name'])
contractes = [c['name'] for c in c_data]

def compose(text, separator, contracts):
    return text + ', '.join(contracts[:-1])+separator+contracts[-1]

if len(contractes) > 1:
    if mail_lang != "es_ES":
        contractes_str = compose('dels contractes nº ', ' i ', contractes)
    else:
        contractes_str = compose('de los contratos nº ', ' y ', contractes)
else:
    if mail_lang != "es_ES":
        contractes_str = 'del contracte nº ' + contractes[0]
    else:
        contractes_str = 'del contrato nº ' + contractes[0]
%>
<br>
Hola ${titular},<br>
<br>
% if mail_lang != "es_ES":
T’enviem aquest correu per a confirmar-te que hem rebut la teva sol·licitud, realitzada a través de l'oficina virtual, per tal que ${administradora} pugui veure i gestionar la informació ${contractes_str} que tens amb Som Energia.<br>
<br>
Per a qualsevol dubte seguim en contacte.<br>
<br>
Equip de Som Energia<br>
% endif
% if mail_lang != "ca_ES" and mail_lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if mail_lang != "ca_ES":
Te enviamos este correo para confirmarte que hemos recibido tu solicitud, realizada a través de la oficina virtual, para que ${administradora} pueda ver y gestionar la información ${contractes_str} que tienes con Som Energia.<br>
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
