<%
    is_canvi_tit = object.step_ids[0].pas_id.sollicitudadm == 'S'

    is_pot_tar = object.step_ids[0].pas_id.sollicitudadm == 'N'

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ''
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
                    <font size=2> Adreça punt subministrament: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=2> Codi CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=2> Titular: ${object.cups_polissa_id.titular.name} </font>
                </td>
            </tr>
            %endif
        </table>
        <br>
        %if is_pot_tar:
            ${pot_tar_cat()}
        %elif is_canvi_tit:
            ${canvi_tit_cat()}
        %endif
        <br>
        <br>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        modifica@somenergia.coop<br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_tar_cat()">
    Hola${nom_titular},<br>
    <br>
    <strong> La modificació contractual que vares sol·licitar ha estat acceptada.</strong><br>
    <br>
    En cas que la telegestió del teu comptador no estigui activa, <strong>durant els propers 15 dies hàbils, vindrà un operari de <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">l'empresa de distribució elèctrica</a></strong> de la teva zona per a realitzar la modificació sol·licitada.
    <br>
    Si el comptador no està accessible, l’operari de l'empresa distribuïdora es posarà en contacte amb tu prèviament a través del telèfon de contacte que has facilitat mitjançant el formulari.<br>
    <br>
    Quan tinguem la confirmació per part de la distribuïdora t’enviarem un correu electrònic indicant la data exacta d'<strong>activació de la modificació.</strong><br>
    <br>
    Les dades del contracte modificat són les següents:<br>
    - Adreça: ${object.cups_polissa_id.cups_direccio}<br>
    - CUPS: ${object.cups_id.name}<br>
</%def>

<%def name="canvi_tit_cat()">
    Hola,<br>
    <br>
    <strong> El canvi de titular que vares sol·licitar ha estat acceptat. </strong>.<br>
    <br>
    Aquest es veurà reflectit a la propera factura, i, en els següents dies, a l'oficina virtual.<br>
    <br>
    Les dades del contracte modificat són les següents:<br>
    - Adreça: ${object.cups_polissa_id.cups_direccio}<br>
    - CUPS: ${object.cups_id.name}<br>
</%def>

<%def name="correu_es()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=2>Dirección punto suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=2>Código CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=2> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <br>
        %if is_pot_tar:
            ${pot_tar_es()}
        %elif is_canvi_tit:
            ${canvi_tit_es()}
        %endif
        <br>
        <br>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        modifica@somenergia.coop<br>
        <a href="http://www.somenergia.coop">www.somenergia.coop</a>

    </body>
</%def>

<%def name="pot_tar_es()">
    Hola${nom_titular},<br>
    <br>
    <strong> La modificación contractual que solicitaste ha sido aceptada. </strong><br>
    <br>
    En el caso que la telegestión de tu contador no esté activa, <strong>urante los próximos 15 días hábiles, vendrá un operario de la <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">la empresa de distribución eléctricaa</a></strong> de tu zona para realizar la modificación solicitada.
    <br>
    Si el contador no está accesible el operario de la empresa distribuidora se pondrá en contacto contigo préviamente a través del teléfono de contacto facilitado mediante el formulario..<br>
    <br>
    En el momento que tengamos la confirmación por parte de la distribuidora, te enviaremos un correo electrónico indicando la fecha exacta de <strong>activación de la modificación.</strong><br>
    <br>
    Los datos del contrato son los siguientes:<br>
    - Dirección: ${object.cups_polissa_id.cups_direccio}<br>
    - CUPS: ${object.cups_id.name}<br>
</%def>

<%def name="canvi_tit_es()">
    Hola, <br>
    <br>
    <strong> El cambio de titularidad que solicitaste ha sido aceptado. </strong>.<br>
    <br>
    Este cambio se verá reflejado en la próxima factura, y, durante los siguientes días, en la oficina virtual.<br>
    <br>
    Los datos del contrato son los siguientes:<br>
    - Dirección: ${object.cups_polissa_id.cups_direccio}<br>
    - CUPS: ${object.cups_id.name}<br>
</%def>
