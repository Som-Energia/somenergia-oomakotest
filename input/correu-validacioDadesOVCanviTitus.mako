<%!
    from mako.template import Template
    from datetime import datetime, timedelta


    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )


    def get_nom_cognoms(object_, owner):
        partner_obj = object_.pool.get('res.partner')
        name_dict = partner_obj.separa_cognoms(object_._cr, object_._uid, owner.name)

        if partner_obj.vat_es_empresa(object_._cr, object_._uid, owner.vat):
            return name_dict['nom']

        return "{0} {1}".format(name_dict['nom'], ' '.join(name_dict['cognoms']))


    def hide_code(code, start, hidden_factor):
        return code[start:].replace(code[-hidden_factor:], '*' * hidden_factor)


    def is_soci(object_, partner_id):
        soci_obj = object_.pool.get('somenergia.soci')
        return bool(search([
            ('partner_id','=',partner_id),
        ]))
%>

<%
    pas01 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None
    nom_antic_tiular = get_nom_cognoms(object, object.cups_polissa_id.titular)

    nom_nou_titular = get_nom_cognoms(object, pas01.dades_client)

    cut_vat = hide_code(pas01.codi_document, 0, 4)
    cut_iban = hide_code(pas01.bank.iban, 0, 8)

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    text_rejection_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_rejection_text')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
    text_rejection = render(t_obj.read(object._cr, object._uid, [text_rejection_id], ['def_body_text'])[0]['def_body_text'], object)


%>

    ${plantilla_header}
    % if pas01.dades_client and pas01.dades_client.lang == "ca_ES":
        ${correu_cat()}
    % else:
        ${correu_es()}
    % endif
    ${plantilla_footer}


<%def name="correu_cat()">
    <table width="100%" frame="below">
    <tbody>
    <tr>
    <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.polissa_ref_id.name}</strong></span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${object.cups_id.direccio}</span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.cups_id.name}</span></td>
    </tr>
    </tbody>
    </table>
    <p>
        Benvolguts/des,
    </p>
    <p>
        Us informem que hem rebut correctament la sol·licitud de contractació ${object.polissa_ref_id.name} per canvi de titular del punt de subministrament amb CUPS ${object.cups_id.name}.
    </p>
    <p>
        En el cas que detecteu qualsevol error en el resum de dades següent agraïrem que ens ho comuniqueu el més aviat possible contestant aquest mateix correu.
    </p>
    <p>
        <b>Si tot és correcte no és necessari que contesteu</b> i la gestió es durà a terme en un màxim de cinc dies hàbils.<br>
    </p>
    <p>
        Et recordem que, com es detalla a les nostres <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/">Condicions Generals</a>, el contracte de subministrament té caràcter personal, de forma que la persona titular manifesta i garanteix que és la usuària efectiva de l’energia elèctrica subministrada.
    </p>
    <p>
        És important tenir en compte que en les properes setmanes, la persona que ha estat titular fins ara, rebrà una última factura fins a la data d’activació del contracte amb la nova persona titular.
    </p>
        <p>
            Les dades de la nova persona titular són:<br>
            - Nom: ${nom_nou_titular}<br/>
            - NIF, NIE o CIF: ${cut_vat}<br>
            - Número de compte: ${cut_iban}<br>
        </p>
    <br>
    ${text_rejection}
    <br><br>
    Salutacions,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
</%def>


<%def name="correu_es()">
    <table width="100%" frame="below">
    <tbody>
    <tr>
    <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${object.polissa_ref_id.name}</strong></span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${object.cups_id.direccio}</span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${object.cups_id.name}</span></td>
    </tr>
    </tbody>
    </table>
    <p>
        Estimados/as,
    </p>
    <p>
            Os informamos que hemos recibido correctamente la solicitud de contratación ${object.polissa_ref_id.name} por cambio de titular del punto de suministro con CUPS ${object.cups_id.name}.
        </p>
    <p>
            En caso de detectar cualquier error en el resumen de datos siguiente agradeceremos que nos lo comuniquen lo antes posible contestando este mismo correo.
    </p>
    <p>
            <b>Si todo es correcto no es necesario que lo hagáis</b> y la gestión se llevará a cabo en un plazo máximo de cinco días hábiles.
    </p>
    <p>
            Te recordamos que, como recogen nuestras <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/">Condiciones Generales</a>, el contrato de suministro tiene carácter personal, de forma que la persona titular manifiesta y garantiza que es la usuaria efectiva de la energía eléctrica suministrada.
    </p>
    <p>
            Es importante tener en cuenta que en las próximas semanas, la persona que ha sido titular hasta ahora, recibirá una última factura hasta la fecha de activación del contrato con la nueva persona titular.
    </p>
    <p>
            Los datos de la nueva persona titular son:<br/>
            - Nombre: ${nom_nou_titular}<br/>
            - NIF, NIE o CIF: ${cut_vat}<br/>
            - Número de cuenta: ${cut_iban}<br/>
    </p>
    <br>
    ${text_rejection}
    <br>
    <br>
        Saludos,<br/>
        <br/>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
