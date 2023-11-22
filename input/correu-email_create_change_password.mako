<!doctype html>
<html>
<%
mail_lang = object.lang
%>
% if mail_lang == "ca_ES":
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Representació en el mercat elèctric</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr></table></head>
% else:
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Representación en el mercado eléctrico</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr></table></head>
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
                    object._cr, object._uid,  'som_users', 'common_template_legal_footer_representa'
                )[1]
text_legal_representa = render(t_obj.read(
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

titular = get_clean_name(object.name, object.vat, False)

def get_password(comment):
    start_key = 'generated_ov_password='
    end_key = '(generated_ov_password)\n'
    password = False
    if start_key in comment:
        password = comment.split(start_key)[1]
        password = password.split(end_key)[0]
    return password

PASSWORD = get_password(object.comment)
%>
<br>
Hola, ${titular},<br>
<br>
% if  mail_lang == "ca_ES":
<p>Reps aquest correu perquè o bé el teu usuari ha estat donat d’alta a l’<a href=https://ov-representa.somenergia.coop/>Oficina virtual del servei de representació a mercat de Som Energia</a> o bé has sol·licitat recuperar la contrasenya.</p>

<p>Per accedir-hi, has d’iniciar sessió amb el teu nom d’usuari i la teva contrasenya.</p>

<p>De moment, t’hem assignat una contrasenya temporal que et recomanem que modifiquis una vegada hagis iniciat sessió.</p>

% if PASSWORD != False:
<p>Contrasenya temporal: <b>${PASSWORD}</b></p>
% endif

<p>El teu nom d'usuari, en cas que no el sàpigues o l'hagis oblidat, és el ${object.vat}.</p>

<p>Gràcies per utilitzar el servei.</p>

<br>
<br>
-------------------------------------------------
Representació en el mercat elèctric - Som Energia
<a href="https://www.somenergia.coop/">www.somenergia.coop</a><br>
representa@somenergia.coop

% else:
<p>Email en español</p>
% endif
</body>
${text_legal_representa}
</html>