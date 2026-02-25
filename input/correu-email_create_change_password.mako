<%
mail_lang = object.lang
from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'somre_ov_module', 'common_template_legal_footer_representa')[1]
plantilla_footer = render(t_obj.read(
    object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'],
    object
)
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
rp_obj = object.pool.get('res.partner')
def get_clean_name(composed_name, vat, name_only):
    if rp_obj.vat_es_empresa(object._cr, object._uid, vat):
        return composed_name
    name = rp_obj.separa_cognoms(object._cr, object._uid, composed_name)
    if name_only:
        return name['nom']
    return '{} {}{}{}'.format(name['nom'],name['cognoms'][0],'' if name['fuzzy'] else ' ',name['cognoms'][1])

titular = get_clean_name(object.name, object.vat, False)

ovu_obj = object.pool.get('somre.ov.users')
es_comer = ovu_obj.get_execution_environment_values(object._cr, object._uid)['type'] == 'comer'
ov_link = 'https://ovrepresenta.somenergia.coop/' if es_comer else 'https://ovrepresenta.somrenovables.com/'
%>
${plantilla_header}
% if  mail_lang == "ca_ES":
<table width="100%" frame="below">
    <tr>
        <td height=2px>
            <span style="font-size: small;"><strong> Representació en el mercat elèctric</strong></span>
        </td>
    </tr>
</table>
<br>
Hola, ${titular},<br>
<br>
<p>Reps aquest correu perquè o bé hem donat d’alta el teu usuari perquè puguis accedir a l’<a target="_blank" href=${ov_link}>Oficina Virtual del servei de Som Energia per representar-te en el mercat elèctric</a> o bé has sol·licitat recuperar la contrasenya.</p>

<p>Per accedir-hi, has d’iniciar sessió amb el teu nom d’usuari i la teva contrasenya.</p>

<p>De moment, t’hem assignat una contrasenya temporal. Et recomanem que la modifiquis una vegada hagis començat la sessió.</p>

<ul><li>Contrasenya temporal: <b>${object.initial_password}</b></li></ul>

<p>El teu nom d'usuari, en cas que no el sàpigues o l'hagis oblidat, és el <b>${object.vat[2:]}</b>.</p>

<p>Gràcies per utilitzar el servei.</p>

<br>
<br>
------------------------------------------------------------
<br>
Som Energia - Representació en el mercat elèctric <br>
<a target="_blank" href="https://www.somenergia.coop/">www.somenergia.coop</a><br>
<a href="mailto:representa@somenergia.coop">representa@somenergia.coop</a><br>
<br>
% else:
<br>
Hola, ${titular},<br>
<br>
<table width="100%" frame="below">
    <tr>
        <td height=2px>
            <span style="font-size: small;"><strong> Representación en el mercado eléctrico</strong></span>
        </td>
    </tr>
</table>
<p>Recibes este correo porque o bien hemos dado de alta a tu usuario para que puedas acceder a la <a target="_blank" href=${ov_link} >Oficina Virtual del servicio de Som Energia para representarte en el mercado eléctrico</a> o bien has solicitado recuperar la contraseña.</p>

<p>Para acceder, tienes que iniciar la sesión con tu nombre de usuario y tu contraseña.</p>

<p>De momento, te hemos asignado una contraseña temporal. Te recomendamos que la modifiques cuando hayas comenzado la sesión.</p>

<ul><li>Contraseña temporal: <b>${object.initial_password}</b></li></ul>

<p>Tu nombre de usuario, en caso de que no lo sepas o lo hayas olvidado, es el <b>${object.vat[2:]}</b>.</p>

<p>Gracias por utilizar el servicio.</p>

<br>
<br>
-----------------------------------------------------------------
<br>
Som Energia - Representación en el mercado eléctrico <br>
<a target="_blank" href="https://www.somenergia.coop/">www.somenergia.coop</a><br>
<a href="mailto:representa@somenergia.coop">representa@somenergia.coop</a><br>
<br>
% endif
</body>
${plantilla_footer}
</html>