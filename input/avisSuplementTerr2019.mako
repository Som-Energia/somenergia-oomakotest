<%!
    from mako.template import Template
%>

<%
    CCAAs_cat = ['09']
%>

<%
    pol_obj = object.pool.get('giscedata.polissa')
    pol_ids = pol_obj.search(object._cr, object._uid,[('cups','like',object.cups[:20])])

    if len(pol_ids) != 1:
        raise Exception("Sense polissa associada!")

    polissa = pol_obj.browse(object._cr, object._uid,pol_ids[0])
    language = polissa.pagador.lang
    zone = polissa.cups.id_municipi.state.comunitat_autonoma.codi
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
                        object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_legal_footer'
                    )[1]
    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        polissa
    )
%>

<%
    try:
        p_obj = object.pool.get('res.partner')
        if not p_obj.vat_es_empresa(object._cr, object._uid,'polissa.pagador.vat'):
            nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,polissa.pagador.name)['nom']
        else:
            nom_pagador = ''
    except:
        nom_pagador = ''
%>

<!doctype html>
<html>
% if language == 'ca_ES':
    ${header_cat()}
    %if zone in CCAAs_cat:
        ${correu_CAT_cat()}
    % else:
        ${correu_RES_cat()}
    % endif
    ${footer_cat()}
% else:
    ${header_es()}
    %if zone in CCAAs_cat:
        ${correu_CAT_es()}
    % else:
        ${correu_RES_es()}
    % endif
    ${footer_es()}
% endif
${text_legal}
</html>

<%def name="correu_CAT_cat()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        <br>
    </body>
</%def>

<%def name="correu_CAT_es()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        <br>
    </body>
</%def>

<%def name="correu_RES_cat()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        <br>
    </body>
</%def>

<%def name="correu_RES_es()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        <br>
    </body>
</%def>

<%def name="footer_cat()">
    <body>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="http://ca.support.somenergia.coop">Centre de Suport</a><br>
        factura@somenergia.coop<br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
        <br>
    </body>
</%def>

<%def name="footer_es()">
    <body>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="http://es.support.somenergia.coop">Centro de Ayuda</a><br>
        factura@somenergia.coop<br>
        <a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
        <br>
    </body>
</%def>

<%def name="header_cat()">
    <head>
        <meta charset="utf-8" />
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Adreça punt subministrament: ${polissa.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Codi CUPS: ${polissa.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100% >
                    <font size=1>Titular: ${polissa.titular.name}</font>
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
                    <font size=2><strong>Contrato Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Dirección punto suministro: ${polissa.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Código CUPS: ${polissa.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100% >
                    <font size=1>Titular: ${polissa.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>
