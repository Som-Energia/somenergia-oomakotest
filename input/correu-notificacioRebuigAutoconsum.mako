<%!
    from mako.template import Template

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_partner_name(object_):
        p_obj = object_.pool.get('res.partner')
        if not object_.vat_enterprise():
            nom_titular =' ' + p_obj.separa_cognoms(object_._cr, object_._uid, object_.cups_polissa_id.titular.name)['nom']
        else:
            nom_titular = ''
        return nom_titular
%>
<%
    polissa = object.cups_polissa_id

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)


%>
${plantilla_header}
% if object.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${plantilla_footer}

<%def name="correu_cat()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contracte Som Energia nº ${polissa.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Adreça punt subministrament: ${object.cups_id.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Codi CUPS: ${object.cups_id.name}</span>
            </td>
        </tr>
    </table>
    <p>
        Hola${get_partner_name(object)},
    </p>
    <p>
        Ens ha arribat la notificació que no estàs d’acord amb les dades que ens ha passat l’empresa de distribució elèctrica referent a la teva instal·lació d’autoconsum associada al CUPS ${object.cups_id.name} amb direcció de subministrament ${object.cups_id.direccio}.
    </p>
    <p>
        Enviem el rebuig, amb el detall del motiu de desacord que ens has indicat a través de la teva oficina virtual, a la distribuïdora.
    </p>
    <p>
        Caldrà que contactis directament amb el departament corresponent de la teva Comunitat Autònoma per tal de modificar la informació registrada i que comenci el procés novament.
    </p>
    <p>
        Qualsevol dubte seguim en contacte.
    </p>
    Salutacions,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
</%def>
<%def name="correu_es()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contrato Som Energia nº ${polissa.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Dirección del punto de suministro: ${object.cups_id.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Codigo CUPS: ${object.cups_id.name}</span>
            </td>
        </tr>
    </table>
    <p>
        Hola${get_partner_name(object)},
    </p>
    <p>
        Nos ha llegado la notificación que no estás de acuerdo con los datos que nos ha pasado la empresa de distribución eléctrica referente a tu instalación de autoconsumo asociada al CUPS ${object.cups_id.name} con dirección de suministro ${object.cups_id.direccio}.
    </p>
    <p>
        Enviamos el rechazo, con el detalle del motivo de desacuerdo que nos has indicado a través de tu oficina virtual, a la distribuidora.
    </p>
    <p>
        Hará falta que contactes directamente con el departamento correspondiente de tu Comunidad Autónoma para modificar la información registrada y que empiece el proceso nuevamente.
    </p>
    <p>
        Cualquier duda seguimos en contacto.
    </p>
    Saludos,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>