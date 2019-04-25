<%!
    from datetime import datetime
    from mako.template import Template
%>

<%
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

    try:
        p_obj = object.pool.get('res.partner')
        if not p_obj.vat_es_empresa(object._cr, object._uid,'object.pagador.vat'):
            nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.cups_polissa_id.pagador.name)['nom']
        else:
            nom_pagador = ''
    except:
        nom_pagador = ''
%>

<!doctype html>
<html>
% if object.cups_polissa_id.pagador.lang == 'ca_ES':
    ${header_cat()}
    ${correu_cat()}
% else:
    ${header_es()}
    ${correu_es()}
% endif
${text_legal}
</html>


<%def name="correu_cat()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        Seguint les teves indicacions, acabem de tramitar la reclamació "El comptador que apareix a la factura no correspon amb l'instal·lat" pel punt de subministrament situat a <b>${object.cups_id.direccio}</b>.<br>
        <br>
        La distribuïdora de la teva zona, a qui hem fet arribar la reclamació, ens informarà del número de referència de la reclamació en un termini màxim de 5 dies hàbils.<br>
        <br>
    </body>
</%def>

<%def name="correu_es()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        Siguiendo tus indicaciones, hemos tramitado la reclamación "Contador en factura no corresponde con instalado" para el punto de suministro situado en <b>${object.cups_id.direccio}</b>.<br>
        <br>
        La distribuidora eléctrica de tu zona, a quien hemos enviado la reclamación, nos informará del número de referencia de la reclamación en un plazo máximo de 5 días hábiles.<br>
        <br>
    </body>
</%def>

<%def name="header_cat()">
    <head>
        <meta charset="utf-8" />
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
                <td height=2px width=100% >
                    <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>

<%def name="header_es()">
    <head>
        <meta charset="utf-8" />
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
                <td height=2px width=100% >
                    <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>

