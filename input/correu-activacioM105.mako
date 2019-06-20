<%!
    from mako.template import Template
    from datetime import datetime, timedelta

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_contract_number_by_cups(object_, cups):
        Polissa = object_.pool.get('giscedata.polissa')
        new_contract_id = Polissa.search(
            object_._cr, object_._uid, [('cups.name', '=', cups)]
        )[-1]
        return Polissa.read(object_._cr, object_._uid, new_contract_id, [])['name']
%>

<%
    M105 = object.pool.get('giscedata.switching.m1.05')
    pas05 = object.step_ids[-1].pas_id if len(object.step_ids) > 0 else None

    is_canvi_tit = object.step_ids[0].pas_id.sollicitudadm == 'S'
    is_pot_tar = object.step_ids[0].pas_id.sollicitudadm == 'N'

    mapaTarifes = dict(M105.fields_get(object._cr, object._uid)['tarifaATR']['selection'])
    tarifaATR = mapaTarifes[pas05.tarifaATR]

    if tarifaATR == '3.0A':
        lineesDePotencia = '\n'.join((
            '&nbsp;&nbsp;&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
            for p in pas05.header_id.pot_ids
            if p.potencia != 0
        ))
    else:
        for p in pas05.header_id.pot_ids:
            if p.potencia == 0: continue
            potencia = p.potencia
            break

    pot_deseada = lineesDePotencia if tarifaATR == '3.0A' else potencia

    polissa = object.polissa_ref_id if is_canvi_tit else object.cups_polissa_id

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, polissa.titular.name
        )['nom']) if not object.vat_enterprise() else ''


    # new_contract_number = get_contract_number_by_cups(object, object.cups_id.name)
    new_contract_number = object.polissa_ref_id.name
    date_activacio = datetime.strptime(pas05.data_activacio, '%Y-%m-%d').strftime('%d/%m/%Y')

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')

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
        %if is_pot_tar:
            ${pot_tar_cat()}
        %elif is_canvi_tit:
            ${canvi_tit_cat()}
        %endif
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_tar_cat()">
    <p>
        La sol·licitud de la <font color="green"><strong> modificació contractual ha estat ACTIVADA</strong></font>, amb data ${date_activacio}.
    </p>

    <p>
        Les <b>condicions contractuals actuals</b> del teu contracte amb Som Energia són:<br>
        <br>
        &nbsp;&nbsp; <strong> Tarifa: ${tarifaATR}</strong> <br>
        %if tarifaATR == '3.0A':
            &nbsp;&nbsp; <strong> Potència: </strong> <br>
            ${pot_deseada}
        %else:
            &nbsp;&nbsp; <strong> Potència: ${pot_deseada} W</strong><br>
        %endif
    </p>

    <p>
        A la propera factura es veurà reflectida la modificació, i a la oficina virtual en els següents dies.
    </p>

    <p>
        Les dades del contracte  que s'ha fet la modificació contractual són les següents: <br>
        &nbsp;&nbsp;- Titular del contracte: ${object.cups_polissa_id.titular.name}<br>
        &nbsp;&nbsp;- Adreça: ${object.cups_polissa_id.cups_direccio}<br>
        &nbsp;&nbsp;- CUPS: ${object.cups_id.name}<br>
        &nbsp;&nbsp;- Número de contracte amb Som Energia: ${object.cups_polissa_id.name}<br>
        &nbsp;&nbsp;- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
    </p>
    <p>
        Estem en contacte per a qualsevol dubte o consulta.
    </p>
</%def>

<%def name="canvi_tit_cat()">
    <p>
        El <b>canvi de titular del contracte ${new_contract_number}</b> i adreça de subministrament ${object.cups_polissa_id.cups_direccio} ha estat realitzat amb èxit.
    </p>
    <p>
        Així doncs, des del <b>${date_activacio}</b> ets la nova persona titular del contracte. Ho veuràs reflectit en las factures i a la teva Oficina Virtual en els propers dies.
    </p>
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
        %if is_pot_tar:
            ${pot_tar_es()}
        %elif is_canvi_tit:
            ${canvi_tit_es()}
        %endif
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_tar_es()">
    <p>
        La solicitud de  <font color="green"><strong>la modificación contractual ha sido ACTIVADA</strong></font> con fecha ${date_activacio}.
    </p>
    <p>
        Las <b>condiciones contractuales actuales</b> de tu contrato con Som Energia son:<br>

        &nbsp;&nbsp;<strong> Tarifa: ${tarifaATR}</strong><br>
        %if tarifaATR == '3.0A':
            &nbsp;&nbsp;<strong> Potencia: </strong><br>
            ${pot_deseada}
        %else:
            &nbsp;&nbsp;<strong> Potencia: ${pot_deseada} W</strong>
        %endif
    </p>
    <p>
        En la próxima factura se verá reflejada la modificación, y en la oficina virtual en los siguientes días.
    </p>
    <p>
        Los datos del contrato son los siguientes:<br>
        &nbsp;&nbsp;- Titular del contrato: ${object.cups_polissa_id.titular.name}<br>
        &nbsp;&nbsp;- Dirección: ${object.cups_polissa_id.cups_direccio}<br>
        &nbsp;&nbsp;- CUPS: ${object.cups_id.name}<br>
        &nbsp;&nbsp;- Número de contrato con Som Energia: ${object.cups_polissa_id.name}<br>
        &nbsp;&nbsp;- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
    </p>
    <p>
        Estamos en contacto para cualquier duda o consulta.
    </p>
</%def>

<%def name="canvi_tit_es()">
    <p>
        El <b>cambio de titular del contrato ${new_contract_number}</b> y dirección de suministro ${object.cups_polissa_id.cups_direccio} ha sido llevado a cabo con éxito.
    </p>
    <p>
        Así pues, desde la fecha <b>${date_activacio}</b> eres la nueva persona titular del contrato. Lo verás reflejado en las próximas facturas y en tu Oficina Virtual durante los próximos días.
    </p>
</%def>

