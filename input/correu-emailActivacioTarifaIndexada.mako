<%
from mako.template import Template
from datetime import datetime

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
p_obj = object.pool.get('res.partner')
nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.titular.name)['nom']

date_activacio = datetime.strptime(object.modcontractuals_ids[0].data_inici, '%Y-%m-%d').strftime('%d/%m/%Y')
%>


<!doctype html>
<html>
% if object.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${text_legal}
</html>


<%def name="correu_cat()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${object.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Adreça punt subministrament: ${object.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Codi CUPS: ${object.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <br>
        Hola,<br>
        <br>
        <p>La <b><span style="color: #008000;">modificació contractual de tarifa ha estat ACTIVADA</span></b>, amb data ${date_activacio}.</p>
        <br>
        <p>Les condicions contractuals actuals del teu contracte amb Som Energia són:</p>
        <br>
        <b>Tarifa comercialitzadora: ${object.llista_preu.name}</b>
        <br>
        <p>Recorda que a la propera factura ja començarem a aplicar-te la nova tarifa.</p>
        <br>
        <p>Estem en contacte per a qualsevol dubte o consulta.</p>
        <br>
        Atentament,<br>
        <br>
        <p>
            Equip de Som Energia <br>
            <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
            <a href="www.somenergia.coop/ca">www.somenergia.coop</a>
        </p>
    </body>
</%def>

<%def name="correu_es()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${object.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Dirección punto suministro: ${object.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Código CUPS: ${object.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <br>
        Hola,<br>
        <br>
        <p>La <b><span style="color: #008000;">modificación contractual de tarifa ha sido ACTIVADA</span></b> con fecha ${date_activacio}.</p>
        <br>
        <p>Las condiciones contractuales actuales de tu contrato con Som Energia son:</p>
        <br>
        <b>Tarifa: comercializadora: ${object.llista_preu.name}</b>
        <br>
        <p>Recuerda que en la próxima factura ya empezaremos a aplicar-te la nueva tarifa.</p>
        <br>
        <p>Estamos en contacto para cualquier duda o consulta.</p>
        <br>
        Atentamente,<br>
        <br>
        <p>
            Equipo de Som Energia <br>
            <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
            <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
        </p>
    </body>
</%def>