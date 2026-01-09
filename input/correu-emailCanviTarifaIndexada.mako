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
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_modi_rejection_text'
    )[1]

text_desistiment = render(
    t_obj.read(object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
p_obj = object.pool.get('res.partner')
nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.titular.name)['nom']
tarifaComer = object.modcontractuals_ids[0].llista_preu.nom_comercial or object.modcontractuals_ids[0].llista_preu.name
%>


${plantilla_header}
% if object.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${plantilla_footer}


<%def name="correu_cat()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contracte Som Energia nº ${object.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Adreça punt subministrament: ${object.cups.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Codi CUPS: ${object.cups.name}</span>
            </td>
        </tr>
        %if is_pot_tar:
        <tr>
            <td height=2px width=100%>
                <span style="font-size: xx-small;"> Titular: ${object.titular.name}</span>
            </td>
        </tr>
        %endif
    </table>

    <br>
    Hola${nom_titular},<br>
    <br>
    <p>Hem rebut una sol·licitud de modificació del contracte ${object.name} amb Som Energia:</p>
    <b>Dades del contracte:</b>
    <ul>
    <li> CUPS: ${object.cups.name} </li>
    <li> Adreça: ${object.cups.direccio} </li>
    </ul>

    <b>Dades de la sol·licitud:</b>
    <ul>
    <li>Modificació de tarifa comercialitzadora: <b>${tarifaComer}</b> </li>
    </ul>
    <p>T'enviarem un nou correu electrònic quan se't comenci a aplicar la nova tarifa.</p>
    <br>

    <p><b>Informació rellevant en el procés de contractació:</b></p>
    ${text_desistiment}
    <br>
    <br>
    Salutacions,<br>
    <br>
    <p>
        Equip de Som Energia <br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a>
    </p>

</%def>

<%def name="correu_es()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contrato Som Energia nº ${object.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Dirección del punto de suministro: ${object.cups.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Codigo CUPS: ${object.cups.name}</span>
            </td>
        </tr>
        %if is_pot_tar:
        <tr>
            <td height=2px width=100%>
                <span style="font-size: small;"> Titular: ${object.titular.name}</span>
            </td>
        </tr>
        %endif
    </table>

    <br>
    Hola${nom_titular},<br>
    <br>
    <p>Hemos recibido una solicitud de modificación del contrato ${object.name} con Som Energia:</p><br>

    <b>Datos del contrato:</b>
    <ul>
    <li>CUPS: ${object.cups.name} </li>
    <li>Dirección: ${object.cups.direccio} </li>
    </ul>

    <b>Datos de la solicitud:</b>
    <ul>
    <li>Modificación de tarifa comercializadora: <b>${tarifaComer}</b> </li>
    </ul>

    <p>Te enviaremos un nuevo correo electrónico cuando se te empiece a aplicar la nueva tarifa. </p><br>
    <p><b>Información referente al proceso de contratación:</b></p>
    ${text_desistiment}
    <br>
    Un saludo,<br>
    <br>
    <p>
        Equipo de Som Energia <br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </p>
</%def>
