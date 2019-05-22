<%!
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

    subtipus_msg = {}
    subtipus_msg['003'] = {'ca_ES':u"Incidència en equips de mesura", 'es_ES':u'Incidencia en equipos de medida'}
    subtipus_msg['004'] = {'ca_ES':u"Danys originats per equips de mesura", 'es_ES':u'Daños originados por equipo de medida'}
    subtipus_msg['005'] = {'ca_ES':u"Comptador a factura no correspon amb l'instal·lat", 'es_ES':u'Contador en factura no corresponde con instalado'}
    subtipus_msg['020'] = {'ca_ES':u"Qualitat d'ona", 'es_ES':u'Calidad de onda'}
    subtipus_msg['021'] = {'ca_ES':u"Reclamacions amb petició d'indemnització", 'es_ES':u'Con petición de indemnización'}
    subtipus_msg['022'] = {'ca_ES':u"Reclmacions sense petició d'indemnització", 'es_ES':u'Sin petición de indemnización'}
    subtipus_msg['023'] = {'ca_ES':u"Endarreriment en l'abonament de la indemnització", 'es_ES':u'Retraso en pago indemnización'}
    subtipus_msg['024'] = {'ca_ES':u"Danys a tercers per instal·lacions", 'es_ES':u'Daños a terceros por instalaciones'}
    subtipus_msg['026'] = {'ca_ES':u"Reclamacions sobre instal·lacions de distribució", 'es_ES':u'Reclamaciones sobre instalaciones de distribución'}
    subtipus_msg['028'] = {'ca_ES':u"Execució indeguda de tall de subminsitrament", 'es_ES':u'Ejecución indebida de corte'}
    subtipus_msg['029'] = {'ca_ES':u"Retràs en l'atenció a reclamacions", 'es_ES':u'Retraso en la atención a reclamaciones'}
    subtipus_msg['039'] = {'ca_ES':u"Sol·licitud de certificat - informe de qualitat", 'es_ES':u'Solicitud de certificado / informe de calidad'}
    subtipus_msg['041'] = {'ca_ES':u"Sol·licitud d'actuació sobre instal·lacions", 'es_ES':u'Solicitud de actuación sobre instalaciones'}
    subtipus_msg['042'] = {'ca_ES':u"Sol·licitud de descàrrec", 'es_ES':u'Solicitud de descargo'}
    subtipus_msg['043'] = {'ca_ES':u"Petició de precintat-desprecintat d'equips de mesura", 'es_ES':u'Petición de precintado / desprecintado de equipos'}
    subtipus_msg['045'] = {'ca_ES':u"Actualització de punt de subministrament", 'es_ES':u'Actualización dirección punto de suministro'}
    subtipus_msg['046'] = {'ca_ES':u"Certificat de lectura", 'es_ES':u'Certificado de lectura'}
    subtipus_msg['067'] = {'ca_ES':u"Verificació de comptador", 'es_ES':u'Verificación de contador'}

    def get_object(text_object):
        model,id = text_object.split(',')
        model_obj = object.pool.get(model)
        return model_obj.browse(object._cr, object._uid, int(id))

    try:
        pas01 = get_object(object.step_ids[0].pas_id)
        subtipus = pas01.subtipus_id.name
        subtipus_txt = subtipus_msg[subtipus][object.cups_polissa_id.pagador.lang]
    except:
        subtipus_txt = ""
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
        Seguint les teves indicacions, acabem de tramitar la reclamació "${subtipus_txt}" pel punt de subministrament situat a <b>${object.cups_id.direccio}</b>.<br>
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
        Siguiendo tus indicaciones, hemos tramitado la reclamación "${subtipus_txt}" para el punto de suministro situado en <b>${object.cups_id.direccio}</b>.<br>
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

