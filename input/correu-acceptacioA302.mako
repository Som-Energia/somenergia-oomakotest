<%!
    from datetime import datetime
%>

<%
    data_act = datetime.strptime(
        object.step_ids[1].pas_id.data_activacio, '%Y-%m-%d'
    ).strftime('%d-%m-%Y') if len(object.step_ids) > 1 else ""

    p_obj = object.pool.get('res.partner')

    nom_titular = p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom'] if not object.vat_enterprise() else ""
%>

<!doctype html>
<html>
% if object.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
</html>


<%def name="correu_cat()">
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
                    <font size=1><strong>Adreça punt subministrament: ${object.cups_id.direccio}</strong></font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1><strong>Codi CUPS: ${object.cups_id.name}</strong></font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1><strong>Titular: ${object.cups_polissa_id.titular.name}</strong></font>
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
            L’empresa distribuïdora ens informa que entorn el día ${data_act} realitzarà les gestions necessàries per fer efectiva l’alta de subministrament. Si fos necessari, la distribuïdora contactarà amb tu al telèfon que vares indicar en emplenar el formulari.<br>
            <br>
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
            - Potència: ${object.cups_polissa_id.potencia} kW<br>
            - Tarifa: ${object.cups_polissa_id.tarifa.name}<br>
        </p>
        <br>
        <br>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        comercialitzacio@somenergia.coop<br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
    </body>
</%def>

<%def name="correu_es()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=1><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td VALIGN=TOP rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1><strong>Dirección punto suministro: ${object.cups_id.direccio}</strong></font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1><strong>Código CUPS: ${object.cups_id.name}</strong></font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%><strong>
                    <font size=1>Titular:${object.cups_polissa_id.titular.name}</strong></font>
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
            - Potencia: ${object.cups_polissa_id.potencia} kW<br>
            - Tarifa: ${object.cups_polissa_id.tarifa.name}<br>
        </p>
        <br>
        <br>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        comercializacion@somenergia.coop<br>
        <a href="http://www.somenergia.coop">www.somenergia.coop</a>
    </body>
</%def>
