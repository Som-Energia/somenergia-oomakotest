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
        <p>
        Hola,<br>
        </p>
        <p>
        El <b>canvi de titular del contracte ${object.cups_polissa_id.name}</b> i adreça de subministrament ${object.cups_polissa_id.cups_direccio} ha estat realitzat amb èxit.
        </p>
        <p>
        Així doncs, has deixat de ser titular d’aquest contracte a data <b>${data_activacio}</b>.
        </p>
        <p>
        Recorda que rebràs una última factura fins aquesta data.
        </p>
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
        <p>
        Hola,<br>
        </p>
        <p>
        El <b>cambio de titular del contrato ${object.cups_polissa_id.name}</b> y dirección de suministro ${object.cups_polissa_id.cups_direccio} ha sido llevado a cabo con éxito.
        </p>
        <p>
        Así pues, ya no eres titular de este contrato desde la fecha <b>${data_activacio}</b>.
        </p>
        <p>
        Recuerda que recibirás una última factura hasta esta fecha.
        </p>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop">www.somenergia.coop</a>

    </body>
</%def>

