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

    nom_soci = get_nom_cognoms(object, object.polissa_ref_id.soci) if object.polissa_ref_id.soci else False

    cut_vat = hide_code(pas01.codi_document, 2, 4)
    cut_iban = hide_code(pas01.bank.iban, 0, 8)

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')

    template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]

    text_legal = render(
        t_obj.read(object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        object
    )
%>

<!doctype html>
<html>
    <head>
        <meta charset='utf-8'>
    </head>
    % if object.cups_polissa_id.titular.lang == "ca_ES":
        ${correu_cat()}
    % else:
        ${correu_es()}
    % endif
    ${text_legal}
</html>


<%def name="correu_cat()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Adreça punt subministrament: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codi CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
        </table>
        <p>
		    Benvolguts/des,
        </p>
        <p>
            Us informem que hem rebut correctament la sol·licitud d'un canvi de titular pel contracte número ${object.cups_polissa_id.name} amb el CUPS: ${object.cups_id.name} i del qual, fins ara, el titular és en/na ${object.cups_polissa_id.titular.name}.
        </p>
        <p>
            Si es tracta d'un canvi de titularitat degut a la defunció de la persona titular actual o bé detecteu un error en el resum de dades següent, contesteu aquest correu.<br>
            <b>Si tot és correcte no és necessari que contesteu</b> i la gestió es durà a terme en un màxim de cinc dies hàbils.<br>
            És important tenir en compte que en les properes setmanes, la persona que ha estat titular fins ara, rebrà una última factura fins a la data d’activació del contracte amb la nova persona titular.<br>
        </p>
		    <p>
		        Les dades de la nova persona titular són:<br>
		        - Nom: ${nom_nou_titular}<br/>
		        - NIF, NIE o CIF: ${cut_vat}<br>
		        - Número de compte: ${cut_iban}<br>
		    </p>
        <p>
		        El contracte estarà associat al soci/a: ${nom_soci or u'Encara sense persona sòcia vinculada'}.<br>
        </p>
        Salutacions,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>


<%def name="correu_es()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Dirección del punto de suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codigo CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
        </table>
        <p>
            Estimados/as,
        </p>
        <p>
		        Os informamos que hemos recibido correctamente la solicitud de cambio de titular del contrato número ${object.cups_polissa_id.name} con el CUPS: ${object.cups_id.name} y del cual, hasta ahora el titular es ${object.cups_polissa_id.titular.name}.
		    </p>
        <p>
		        Si se trata de un cambio de titularidad debido a la defunción de la persona titular actual o bien detectáis un error en el resumen de datos siguiente, contestad este correo.<br/>
		        <b>Si todo es correcto no es necesario que lo hagáis</b> y la gestión se llevará a cabo en un plazo máximo de cinco días hábiles.<br/>
		        Es importante tener en cuenta que en las próximas semanas, la persona que ha sido titular hasta ahora, recibirá una última factura hasta la fecha de activación del contrato con la nueva persona titular.<br/>
        </p>
        <p>
		        Los datos de la nueva persona titular son:<br/>
		        - Nombre: ${nom_nou_titular}<br/>
		        - NIF, NIE o CIF: ${cut_vat}<br/>
		        - Número de cuenta: ${cut_iban}<br/>
        </p>
        <p>
            El contrato estará asociado al socio/a: ${nom_soci or u'Todavía sin persona socia asociada'}.<br>
        </p>
		    Saludos,<br/>
		    <br/>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>
