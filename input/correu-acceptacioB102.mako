<%!
    from datetime import datetime
%>

<%
    p_obj = object.pool.get('res.partner')

    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ''
%>

<!doctype html>
<html>
% if object.cups_polissa_id.titular.lang == 'ca_ES':
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
            Hem sol·licitat la baixa amb tall de subministrament del contracte corresponent a ${object.cups_polissa_id.cups_direccio} i ha estat acceptada.<br>
        </p>
        <p>
            <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L'empresa de distribució elèctrica</a> té 5 dies hàbils per donar de baixa aquest punt de subministrament i que deixi d'haver-hi llum.<br>
        </p>
        <p>
            Recorda que la cooperativa emetrà una última factura fins que la baixa sigui efectiva.<br>
        </p>
        <p>
            De seguida que ens comuniquin la data, us informarem.<br>
        </p>
        <br>
        <br>
        Atentament,<br>
        <br>
        Equip de Som Energia <br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="correu_es()">
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
            Hemos solicitado la baja con corte de suministro del contrato correspondiente a la dirección ${object.cups_polissa_id.cups_direccio} y ha sido aceptada.<br>
        </p>
        <p>
            <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa de distribución eléctrica</a> tiene 5 días hábiles para dar de baja este punto de suministro y que deje de haber luz.<br>
        </p>
        <p>
            Recuerda que la cooperativa emitirá una última factura hasta que la baja sea efectiva.<br>
        </p>
        <p>
            En cuanto nos comuniquen la fecha exacta, os informaremos.<br>
        </p>
        <br>
        <br>
        Atentamente,<br>
        <br>
        Equipo de Som Energia <br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>
