<%
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
    <%
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
    <p>
        Fa uns dies vàrem iniciar la sol·licitud d'alta de subministrament.
    </p>
</%def>

<%def name="salutacio_es()">
    <p>
        Hola${nom_titular}, <br>
    </p>
    <p>
        Hace unos días iniciamos la solicitud de alta de suministro.
    </p>
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
    <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
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
    <a href="https://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
