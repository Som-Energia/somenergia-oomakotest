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
    template_header_id = md_obj.get_object_reference(
        object._cr, object._uid, 'som_poweremail_common_templates',
        'common_template_header_v2'
    )[1]
    template_footer_id = md_obj.get_object_reference(
        object._cr, object._uid, 'som_poweremail_common_templates',
        'common_template_footer_v2'
    )[1]
    plantilla_header = render(
        t_obj.read(
            object._cr, object._uid, [template_header_id], ['def_body_text']
        )[0]['def_body_text'], object
    )
    plantilla_footer = render(
        t_obj.read(
            object._cr, object._uid, [template_footer_id], ['def_body_text']
        )[0]['def_body_text'], object
    )
%>

${plantilla_header}

% if object.titular.lang == "ca_ES":
    <p>Hola,</p>
    <p>Gràcies per contactar amb nosaltres.</p>
    <p>En relació amb la teva petició de canvi de compte bancari del contracte
    ${object.name} situat a ${object.cups.direccio},
    t'informem que per finalitzar l'actualització d'aquesta dada, cal que facis
    clic a l'enllaç següent per signar el document SEPA:</p>

<table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center">
<table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener"><span style="color: #000000;">👉 Signar document SEPA</span></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

    <p>Per la teva seguretat: si tu no has demanat aquesta modificació, respon
    directament a aquest correu tan aviat com puguis i ho aturarem de seguida.</p>
    <p>Cordialment,</p>
% else:
    <p>Hola,</p>
    <p>¡Gracias por contactar con nosotros!</p>
    <p>En relación con tu petición de cambio de cuenta bancaria del contrato
    ${object.name} situado en ${object.cups.direccio},
    te informamos que para finalizar la actualización de este dato, solo
    necesitas hacer clic en el siguiente enlace para firmar el documento SEPA:</p>

<table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center">
<table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener"><span style="color: #000000;">👉 Firmar documento SEPA</span></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

    <p>Para tu seguridad: si tú no has solicitado esta modificación, responde
    directamente a este correo lo antes posible y lo pararemos de inmediato.</p>
    <p>Saludos,</p>
% endif

${plantilla_footer}
