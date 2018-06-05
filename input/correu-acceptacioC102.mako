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
        Hola ${nom_titular},

        Ens plau comunicar-te que <strong>la sol·licitud del canvi ha estat acceptada</strong>.<br>
        % if data_act:
        La data de l’activació serà aproximadament el dia ${data_act}.<br>
        % endif
        T'enviarem un e-mail per comunicar-te que el contracte ja està actiu amb la cooperativa.

        Tingues en compte que encara t'arribarà una factura (la darrera) de la companyia actual.
        Les dades del contracte són les següents:
        - Número de contracte amb Som Energia: ${object.cups_polissa_id.name}
        - Titular del contracte: ${object.cups_polissa_id.titular.name}
        - Soci/a Som Energia: ${object.cups_polissa_id.soci.name}

        - Adreça: ${object.cups_polissa_id.cups_direccio}
        - CUPS: ${object.cups_id.name}


        Atentament,

        Equip de Som Energia
        comercialitzacio@somenergia.coop
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a>
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
        Hola ${nom_titular},

        Nos complace comunicarte que <strong>la solicitud del cambio ha sido aceptada</strong>.<br>
        % if data_act:
        La fecha de activación será aproximadamente el día ${data_act}.<br>
        % endif
        Cuando nos lo comuniquen, te enviaremos un e-mail indicando que el contrato ya es activo con la cooperativa.

        En cualquier caso, todavía te llegará una factura (la última) de la compañía actual.

        Los datos del contrato son los siguientes:
        - Número de contrato con Som Energia: ${object.cups_polissa_id.name}
        - Titular del contrato: ${object.cups_polissa_id.titular.name}
        - Socio/a Som Energia: ${object.cups_polissa_id.soci.name}

        - Dirección: ${object.cups_polissa_id.cups_direccio}
        - CUPS: ${object.cups_id.name}


        Atentamente,

        Equipo de Som Energia
        comercializacion@somenergia.coop
        <a href="http://www.somenergia.coop">www.somenergia.coop</a>
    </body>
</%def>
