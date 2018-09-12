<%
    is_canvi_tit = object.step_ids[0].pas_id.sollicitudadm == 'S'

    is_pot_tar = object.step_ids[0].pas_id.sollicitudadm == 'N'

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ""
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
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
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
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular:${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>

<%def name="salutacio_cat()">
    <p>
        Hola${nom_titular}, <br>
    </p>
    %if is_canvi_tit:
        <p>
            Fa uns dies vàrem iniciar els tràmits de canvi de titular del contracte.
        </p>
    %elif is_pot_tar:
        <p>
            Fa uns dies vàrem iniciar els tràmits de canvi de tarifa i/o potència del teu contracte.
        </p>
    %endif
</%def>

<%def name="salutacio_es()">
    <p>
        Hola${nom_titular}, <br>
    </p>
    %if is_canvi_tit:
        <p>
            Hace unos días iniciamos el trámite de cambio de titular del contrato
        </p>
    %elif is_pot_tar:
        <p>
            Hace unos días iniciamos el trámite de cambio de tarifa y/o potencia de tu contrato.
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
