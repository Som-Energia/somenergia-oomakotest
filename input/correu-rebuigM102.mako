<%
    from mako.template import Template
    from gestionatr.utils import get_description

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    pas01 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None
    PasM101 = object.pool.get('giscedata.switching.m1.01')

    is_canvi_tit = pas01.sollicitudadm == 'S'
    is_pot_tar = pas01.sollicitudadm == 'N'

    mapaTarifes = dict(PasM101.fields_get(object._cr, object._uid)['tarifaATR']['selection'])
    tarifaATR = mapaTarifes[pas01.tarifaATR]

    cont_telefon = pas01.cont_telefons and pas01.cont_telefons[0].numero or object.tel_pagador_polissa

    pot_deseada_ca = '\n'.join((
        '&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
        for p in pas01.header_id.pot_ids
        if p.potencia != 0
    ))
    pot_deseada_es = pot_deseada_ca

    pot_polissa = {}
    pot_solicitud = {}

    for pot in object.step_ids[0].pas_id.pot_ids:
        pot_polissa[pot.name] = pot.potencia

    for pot in object.polissa_ref_id.potencies_periode:
        pot_solicitud[pot.periode_id.name] = pot.potencia * 1000

    is_canvi_pot = pot_polissa != pot_solicitud
    is_canvi_ten = object.step_ids[0].pas_id.solicitud_tensio == 'S'
    is_canvi_tar = object.polissa_ref_id.tarifa_codi != tarifaATR
    is_canvi_auto = object.step_ids[0].pas_id.tipus_autoconsum != object.polissa_ref_id.autoconsumo

    if is_canvi_auto:
        codi_auto = object.step_ids[0].pas_id.tipus_autoconsum
        descripcio_auto = get_description(codi_auto,"TABLA_113")

    if is_canvi_ten:
        nom_tensio = get_description(object.step_ids[0].pas_id.tensio_solicitada,"TABLA_64")

        if nom_tensio[0] == '1':
            ten_deseada_ca = "Monofàsica"
            ten_deseada_es = "Monofásica"
        elif  nom_tensio[0] == '3':
            ten_deseada_ca = "Trifàsica"
            ten_deseada_es = "Trifásica"
        else:
            ten_deseada_ca = nom_tensio
            ten_deseada_es = nom_tensio

    if tarifaATR == "2.0TD":
        pot_deseada_ca = pot_deseada_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
        pot_deseada_es = pot_deseada_es.replace("P1:", "Punta:").replace("P2:", "Valle:")

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ""

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
    % if object.cups_polissa_id.titular.lang == "ca_ES":
        ${cabecera_cat()}
    % else:
        ${cabecera_es()}
    % endif
    <body>
        <br>
        <br>
        % if object.cups_polissa_id.titular.lang == "ca_ES":
            ${salutacio_cat()}
        % else:
            ${salutacio_es()}
        % endif
        ${notificacio_text}
        % if object.cups_polissa_id.titular.lang == "ca_ES":
            ${footer_cat()}
        % else:
            ${footer_es()}
        % endif
        ${text_legal}
    </body>
</html>


<%def name="cabecera_cat()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
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
            %if is_pot_tar:
                <tr>
                    <td height=2px width=100%>
                        <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                    </td>
                </tr>
            %endif
        </table>
    </head>
</%def>

<%def name="cabecera_es()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
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
            %if is_pot_tar:
                <tr>
                    <td height=2px width=100%>
                        <font size=1>Titular:${object.cups_polissa_id.titular.name}</font>
                    </td>
                </tr>
            %endif
        </table>
    </head>
</%def>

<%def name="salutacio_cat()">
    %if is_canvi_tit:
        <p>
            Hola,
        </p>
        <p>
            Fa uns dies vàrem iniciar els tràmits de canvi de titular del contracte.
        </p>
    %elif is_pot_tar:
        <p>
            Hola${nom_titular}, <br>
        </p>
        <p>
            Fa uns dies vas sol·licitar una modificació contractual per aquest punt de subministrament:
        </p>
        <p>
       %if is_canvi_pot:
            Potència desitjada: <br />
            ${pot_deseada_ca}
        %endif
        %if is_canvi_ten:
            Tensió: ${ten_deseada_ca} <br />
        %endif
        %if is_canvi_tar:
            Tarifa desitjada: ${tarifaATR} <br />
        %endif
        %if is_canvi_auto:
            Autoconsum: [${codi_auto}] - ${descripcio_auto} <br />
        %endif
        </p>
    %endif
</%def>

<%def name="salutacio_es()">
    %if is_canvi_tit:
        <p>
            Hola,
        </p>
        <p>
            Hace unos días iniciamos el trámite de cambio de titular del contrato.
        </p>
    %elif is_pot_tar:
        <p>
            Hola${nom_titular}, <br>
        </p>
        <p>
            Recientemente has solicitado una modificación contractual para este punto de suministro:
        </p>
        <p>
        %if is_canvi_pot:
            Potència desitjada: <br />
            ${pot_deseada_ca}
        %endif
        %if is_canvi_ten:
            Tensió: ${ten_deseada_ca} <br />
        %endif
        %if is_canvi_tar:
            Tarifa desitjada: ${tarifaATR} <br />
        %endif
        %if is_canvi_auto:
            Autoconsum: [${codi_auto}] - ${descripcio_auto} <br />
        %endif
        </p>
    %endif
</%def>

<%def name="footer_cat()">
    <p>
        Gràcies per la teva atenció, estem en contacte per a qualsevol dubte o consulta.<br>
    </p>
    Atentament,<br>
    <br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
    <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
</%def>

<%def name="footer_es()">
    <p>
        Muchas gracias por tu atención, estamos en contacto para cualquier duda o consulta.<br>
    </p>
    Atentamente,<br>
    <br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
