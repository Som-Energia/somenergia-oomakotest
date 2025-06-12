<%!
    from datetime import datetime
    from mako.template import Template
%>

<%
    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
        )

    data_act = datetime.strptime(
        object.step_ids[1].pas_id.data_activacio, '%Y-%m-%d'
    ).strftime('%d-%m-%Y') if len(object.step_ids) > 1 else ''

    p_obj = object.pool.get('res.partner')

    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ''

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    pas01 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None
    pot_deseada_ca = '\n'.join((
        '&nbsp;&nbsp;&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
        for p in pas01.header_id.pot_ids
        if p.potencia != 0
    ))
    pot_deseada_es = pot_deseada_ca
    if object.cups_polissa_id.tarifa.name == "2.0TD":
        pot_deseada_ca = pot_deseada_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
        pot_deseada_es = pot_deseada_es.replace("P1:", "Punta:").replace("P2:", "Valle:")

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>

${plantilla_header}

% if object.cups_polissa_id.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

${plantilla_footer}

<%def name="correu_cat()">
    <head>
        <table width="100%" frame="below">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Adreça punt subministrament: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Codi CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <br>
        <br>
        <p>
            Hola${nom_titular},<br>
        </p>
        <p>
            <strong>Ens plau comunicar-te que la sol·licitud d'alta de subministrament ha estat acceptada.</strong><br>
        </p>
        <p>
            L’empresa distribuïdora ens informa que als voltants del dia ${data_act} realitzarà les gestions necessàries per fer efectiva l’alta de subministrament. Si fos necessari, la distribuïdora contactarà amb tu al telèfon que vares indicar en emplenar el formulari.<br>
        </p>
        <p>
            <strong>T'enviarem un últim e-mail per comunicar-te  la data efectiva de l’alta de subministrament.</strong><br>
        </p>
        <p>
            Les dades del contracte són les següents:<br>
            - Número de contracte amb Som Energia: ${object.cups_polissa_id.name}<br>
            - Titular del contracte: ${object.cups_polissa_id.titular.name}<br>
            - Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
            <br>
            - Adreça: ${object.cups_polissa_id.cups_direccio}<br>
            - CUPS: ${object.cups_id.name}<br>
            - Potència: <br>${pot_deseada_ca}
        </p>
        <br>
        <br>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
    </body>
</%def>

<%def name="correu_es()">
    <head>
        <table width="100%" frame="below">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Dirección punto suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Código CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <br>
        <br>
        <p>
            Hola${nom_titular},
        </p>
        <p>
            <strong>Nos complace comunicarte que la solicitud de alta de suministro ha sido aceptada.</strong><br>
        </p>
        <p>
            La empresa distribuidora nos informa que sobre el día ${data_act} realizará las gestiones necesarias para hacer efectiva el alta de suministro. Si fuera necesario, la distribuidora contactará contigo en el teléfono que indicaste al rellenar el formulario.<br>
        </p>
        <p>
            <strong>Te enviaremos un último e-mail para comunicarte la fecha efectiva del alta.</strong><br>
        </p>
        <p>
            Los datos del contrato son los siguientes:<br>
            - Número de contrato con Som Energia: ${object.cups_polissa_id.name}<br>
            - Titular del contrato: ${object.cups_polissa_id.titular.name}<br>
            - Socio/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
            <br>
            - Dirección: ${object.cups_polissa_id.cups_direccio}<br>
            - CUPS: ${object.cups_id.name}<br>
            - Potencia: <br>${pot_deseada_es}
        </p>
        <br>
        <br>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>
