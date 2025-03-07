<%!
    from mako.template import Template
    from datetime import datetime, timedelta

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_autoconsum_description(object_, auto_consum, lang):
        M205 = object_.pool.get('giscedata.switching.m2.05')
        tipus_autoconsum = dict(M205.fields_get(object_._cr, object_._uid, context={'lang': lang})['tipus_autoconsum']['selection'])

        return auto_consum + " - " + tipus_autoconsum[auto_consum]
%>

<%
    md_obj = object.pool.get('ir.model.data')
    M205 = object.pool.get('giscedata.switching.m2.05')
    pas05 = object.step_ids[-1].pas_id if len(object.step_ids) > 0 else None
    pas01 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None

    mapaTarifes = dict(M205.fields_get(object._cr, object._uid)['tarifaATR']['selection'])
    tarifaATR = mapaTarifes[pas05.tarifaATR]

    pot_deseada_ca = '\n'.join((
        '&nbsp;&nbsp;&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
        for p in pas05.header_id.pot_ids
        if p.potencia != 0
    ))
    pot_deseada_es = pot_deseada_ca
    if tarifaATR == "2.0TD":
        pot_deseada_ca = pot_deseada_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
        pot_deseada_es = pot_deseada_es.replace("P1:", "Punta:").replace("P2:", "Valle:")
    polissa = object.cups_polissa_id

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, polissa.titular.name
        )['nom']) if not object.vat_enterprise() else ''


    new_contract_number = object.cups_polissa_id.name
    date_activacio = datetime.strptime(pas05.data_activacio, '%Y-%m-%d').strftime('%d/%m/%Y')

    autoconsum_description = get_autoconsum_description(object, pas05.tipus_autoconsum, object.cups_polissa_id.titular.lang)

    t_obj = object.pool.get('poweremail.templates')

    template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]

    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
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
                    <font size=2><strong> Contracte Som Energia nº ${polissa.name}</strong></font>
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
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${nom_titular},
        </p>
        ${pot_gen_es()}
        Atentament,<br>
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
                    <font size=2><strong> Contracte Som Energia nº ${polissa.name}</strong></font>
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
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${nom_titular},
        </p>
        ${pot_gen_es()}
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_gen_ca()">
    <p>
        La sol·licitud de la modificació contractual ha estat ACTIVADA, amb data ${date_activacio}.
    </p>
    <p>
        Les condicions contractuals actuals del teu contracte amb Som Energia són:
    </p>
    <ul>
        <li>Tarifa: ${tarifaATR}</li>
        <li>Potència: ${pot_deseada_ca}</li>
        <li>Autoconsum:
            <ul>
                <li>Modalitat: ${autoconsum_description}</li>
                <li>Potència generació:  kW</li>
            </ul>
        </li>
    </ul>

    <p>
        Les dades del contracte que s'ha fet la modificació contractual són les següents:
    </p>
    <ul>
        <li>Titular del contracte: ${object.cups_polissa_id.titular.name}</li>
        <li>Adreça: ${object.cups_polissa_id.cups_direccio}</li>
        <li>CUPS: ${object.cups_id.name}</li>
        <li>Número de contracte amb Som Energia: ${object.cups_polissa_id.name}</li>
        <li>Soci/a Som Energia: ${object.cups_polissa_id.soci.name}</li>
    </ul>
    <p>
        Estem en contacte per a qualsevol dubte o consulta.
    </p>
</%def>

<%def name="pot_gen_es()">
    <p>
        La solicitud de la modificación contractual ha sido ACTIVADA con fecha ${date_activacio}.
    </p>
    <p>
        Las condiciones contractuales actuales de tu contrato con Som Energia son:
    </p>
    <ul>
        <li>Tarifa: ${tarifaATR}</li>
        <li>Potencia: ${pot_deseada_es}</li>
        <li>Autoconsumo:
            <ul>
                <li>Modalidad: ${autoconsum_description}</li>
                <li>Potencia generación:  kW</li>
            </ul>
        </li>
    </ul>

    <p>
        Los datos del contrato con el que se ha hecho la modificación contractual son los siguientes:
    </p>
    <ul>
        <li>Titular del contrato: ${object.cups_polissa_id.titular.name}</li>
        <li>Dirección: ${object.cups_polissa_id.cups_direccio}</li>
        <li>CUPS: ${object.cups_id.name}</li>
        <li>Número de contrato con Som Energia: ${object.cups_polissa_id.name}</li>
        <li>Soci/a Som Energia: ${object.cups_polissa_id.soci.name}</li>
    </ul>
    <p>
        Estamos en contacto para cualquier duda o consulta.
    </p>
</%def>
