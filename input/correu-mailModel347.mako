<%
    email_o = object.pool.get('report.backend.347.email')
    data = email_o.get_data(object._cr, object._uid, object.id)
    from mako.template import Template
    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
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
    % if object.partner_id.lang == "ca_ES":
        ${cabecera_cat()}
        <body>
        ${missatge_cat()}
        ${footer_cat()}
    % else:
        ${cabecera_es()}
        <body>
        ${missatge_es()}
        ${footer_es()}
    % endif
    ${text_legal}
    </body>
</html>


<%def name="cabecera_cat()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=1>CIF: ${data['cif_partner']}</font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>${data['nom_partner']}</font>
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
                    <font size=1>CIF: ${data['cif_partner']}</font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>${data['nom_partner']}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>

<%def name="missatge_cat()">
    <p>
        Bon dia,
    </p>
    <p>
        Us informem de l'import de les ${"compres" if object.operation_key == "A" else "vendes"} (iva inclòs) realitzades per SOM ENERGIA a ${data['nom_partner']}, amb NIF ${data['cif_partner']} durant l'exercici ${data['any_exercici']}, pel compliment del resum anual Model 347 (declaració de clients i proveïdors, amb volum superior a ${data['limit']} euros):
    </p>
    <p>
        Trimestre 1:    ${data['trimestre_1']} €<br>
        Trimestre 2:    ${data['trimestre_2']} €<br>
        Trimestre 3:    ${data['trimestre_3']} €<br>
        Trimestre 4:    ${data['trimestre_4']} €<br>
        <br>
        <b>Import anual:    ${data['total']} €</b>
        <br><br>
        Les nostres dades fiscals són: SOM ENERGIA SCCL
        NIF F55091367
    </p>
</%def>

<%def name="missatge_es()">
    <p>
        Buenos días,
    </p>
    <p>
        Os informamos del importe de las ${"compras" if object.operation_key == "A" else "ventas"} (iva incluido) efectuadas por SOM ENERGIA a ${data['nom_partner']}, con NIF ${data['cif_partner']} durante el ejercicio ${data['any_exercici']}, para la cumplimentación del resumen anual Modelo 347 (declaración de clientes y proveedores con volumen superior a ${data['limit']} euros):
    </p>
    <p>
        Trimestre 1:    ${data['trimestre_1']} €<br>
        Trimestre 2:    ${data['trimestre_2']} €<br>
        Trimestre 3:    ${data['trimestre_3']} €<br>
        Trimestre 4:    ${data['trimestre_4']} €<br>
        <br>
        <b>Importe anual:    ${data['total']} €</b>
        <br><br>
        Nuestros datos fiscales son: SOM ENERGIA SCCL
        CIF F55091367
    </p>
</%def>

<%def name="footer_cat()">
    Atentament,<br>
    <br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
    <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
</%def>

<%def name="footer_es()">
    Atentamente,<br>
    <br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
    <a href="https://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
