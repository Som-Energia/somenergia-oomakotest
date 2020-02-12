<%
    nom_partner = object.partner_id.name
    cif_partner = object.partner_vat
    trimestre_1 = object.first_quarter
    trimestre_2 = object.second_quarter
    trimestre_3 = object.third_quarter
    trimestre_4 = object.fourth_quarter
    total = object.amount
    report_obj = object.pool.get('l10n.es.aeat.mod347.report')
    report = report_obj.browse(object._cr, object._uid, object.report_id)
    any_exercici = object.report_id.fiscalyear_id.name
  
%>


<!doctype html>
<html>
    % if object.partner_id.lang == "ca_ES":
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
        % if object.partner_id.lang == "ca_ES":
            ${missatge_cat()}
        % else:
            ${missatge_es()}
        % endif
        % if object.partner_id.lang == "ca_ES":
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
                <td height=2px>
                    <font size=1>CIF: ${cif_partner}</font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>${nom_partner}</font>
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
                    <font size=1>CIF: ${cif_partner}</font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>${nom_partner}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>

<%def name="missatge_cat()">
    <p>
    Resum de la facturació anual agrupada per trimestres l'any: ${any_exercici}, <br>
    </p>
    <p>
    ${nom_partner} amb CIF: ${cif_partner} <br>
    </p>
    <p>
    Per tal de donar compliment a la disposició vigent del ministeri d'Hisenda, en la relació dels nostres clients en la qual la nostra facturació hagi superat l'import de 3.005,06€ durant l'any ${any_exercici}, indiquem a continuació el total que tenim enregistrat: <br>
    Trimestre 1:    ${trimestre_1}€<br>
    Trimestre 2:    ${trimestre_2}€<br>
    Trimestre 3:    ${trimestre_3}€<br>
    Trimestre 4:    ${trimestre_4}€<br>
    <br>
    <b>Total:    ${total}€</b>
    <br>
    </p>
    
</%def>

<%def name="missatge_es()">
    <p>
    Resum de la facturació anual agrupada per trimestres l'any: ${any_exercici}, <br>
    </p>
    <p>
    ${nom_partner} amb CIF: ${cif_partner} <br>
    </p>
    <p>
    Per tal de donar compliment a la disposició vigent del ministeri d'Hisenda, en la relació dels nostres clients en la qual la nostra facturació hagi superat l'import de 3.005,06€ durant l'any ${any_exercici}, indiquem a continuació el total que tenim enregistrat: <br>
    Trimestre 1:    ${trimestre_1}€<br>
    Trimestre 2:    ${trimestre_2}€<br>
    Trimestre 3:    ${trimestre_3}€<br>
    Trimestre 4:    ${trimestre_4}€<br>
    <br>
    <b>Total:    ${total}€</b>
    <br>
    </p>

</%def>

<%def name="footer_cat()">
    <p>
    Els agrairíem que en cas de no coincidir amb el seu registres, ens ho notifiquin el més aviat possible.<br>
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
    Els agrairíem que en cas de no coincidir amb el seu registres, ens ho notifiquin el més aviat possible.<br>
    </p>
    Atentamente,<br>
    <br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
    <a href="https://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
