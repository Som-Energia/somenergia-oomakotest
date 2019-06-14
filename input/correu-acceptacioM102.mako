<%!
    from mako.template import Template
    from datetime import datetime

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
        )
%>

<%
    is_canvi_tit = object.step_ids[0].pas_id.sollicitudadm == 'S'

    is_pot_tar = object.step_ids[0].pas_id.sollicitudadm == 'N'

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ''

    data_activacio = datetime.strptime(
        object.step_ids[-1].pas_id.data_activacio, '%Y-%m-%d'
    ).strftime('%d/%m/%Y')

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
        <br>
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
        Hola${nom_titular},<br>
    </p>
    <p>
        <strong> La modificació contractual que vares sol·licitar ha estat acceptada.</strong><br>
    </p>
    <p>
        En cas que la telegestió del teu comptador no estigui activa, <strong>durant els propers 15 dies hàbils, vindrà un operari de <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">l'empresa de distribució elèctrica</a></strong> de la teva zona per a realitzar la modificació sol·licitada.
        <br>
        Si el comptador no està accessible, l’operari de l'empresa distribuïdora es posarà en contacte amb tu prèviament a través del telèfon de contacte que has facilitat mitjançant el formulari.<br>
        <br>
        Quan tinguem la confirmació per part de la distribuïdora t’enviarem un correu electrònic indicant la data exacta d'<strong>activació de la modificació.</strong><br>
    </p>
    <p>
        Les dades del contracte modificat són les següents:<br>
        - Adreça: ${object.cups_polissa_id.cups_direccio}<br>
        - CUPS: ${object.cups_id.name}<br>
    </p>
</%def>

<%def name="canvi_tit_cat()">
    <p>
        Hola,<br>
    </p>
    <p>
        El <b>canvi de titular del contracte ${object.cups_polissa_id.name}</b> i adreça de subministrament ${object.cups_polissa_id.cups_direccio} ha estat realitzat amb èxit.
    </p>
    <p>
        Així doncs, des del <b>${data_activacio}</b> ets la nova persona titular del contracte. Ho veuràs reflectit en les factures i a la teva Oficina Virtual en els propers dies.
    </p>
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
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
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
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop">www.somenergia.coop</a>

    </body>
</%def>

<%def name="pot_tar_es()">
    <p>
        Hola${nom_titular},<br>
    </p>
    <p>
        <strong> La modificación contractual que solicitaste ha sido aceptada. </strong><br>
    </p>
    <p>
        En el caso que la telegestión de tu contador no esté activa, <strong>durante los próximos 15 días hábiles, vendrá un operario de <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">la empresa de distribución eléctrica</a></strong> de tu zona para realizar la modificación solicitada.
        <br>
        Si el contador no está accesible el operario de la empresa distribuidora se pondrá en contacto contigo préviamente a través del teléfono de contacto facilitado mediante el formulario..<br>
        <br>
        En el momento que tengamos la confirmación por parte de la distribuidora, te enviaremos un correo electrónico indicando la fecha exacta de <strong>activación de la modificación.</strong><br>
    </p>
    <p>
        Los datos del contrato son los siguientes:<br>
        - Dirección: ${object.cups_polissa_id.cups_direccio}<br>
        - CUPS: ${object.cups_id.name}<br>
    </p>

</%def>

<%def name="canvi_tit_es()">
    <p>
        Hola,<br>
    </p>
    <p>
        El <b>cambio de titular del contrato ${object.cups_polissa_id.name}</b> y dirección de suministro ${object.cups_polissa_id.cups_direccio} ha sido llevado a cabo con éxito.
    </p>
    <p>
        Así pues, desde la fecha <b>${data_activacio}</b> eres la nueva persona titular del contrato. Lo verás reflejado en las próximas facturas y en tu Oficina Virtual durante los próximos días.
    </p>
</%def>
