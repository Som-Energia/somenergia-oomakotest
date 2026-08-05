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
    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

    template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_rejection_text'
    )[1]
%>

${plantilla_header}

% if object.lang == "ca_ES":
    <p>Hola!</p>
    <p>Moltes gràcies per fer el pas amb nosaltres! Ja tenim quasi a punt la teva contractació amb Som energia.</p>
    <p>Per poder-la finalitzar, només cal que facis clic a l’enllaç següent per revisar i signar la documentació:</p>

<table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center">
<table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener"><span style="color: #000000;">Signar documents!</span></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

    <p>Per la teva seguretat: si tu no has demanat aquesta alta, respon directament a aquest correu tan aviat com puguis i ho aturarem de seguida.</p>
    <p>Moltes gràcies per sumar-te a l’energia 100% renovable!</p>
    <p>Atentament,</p>
    <p>Equip de Som Energia<br><a href="comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a></p>
% else:
    <p>¡Hola!</p>
    <p>¡Muchas gracias por dar el paso con nosotros! Ya tenemos casi lista tu contratación con Som Energia.</p>
    <p>Para poder finalizarla, solo necesitas hacer clic en el siguiente enlace para revisar y firmar la documentación:</p>

<table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center">
<table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener"><span style="color: #000000;">¡Firmar documentos!</span></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

    <p>Por tu seguridad: si tú no has solicitado esta alta, responde directamente a este correo lo antes posible y lo pararemos de inmediato).</p>
    <p>¡Muchas gracias por sumarte a la energía 100% renovable!</p>
    <p>Atentamente,</p>
    <p>Equipo de Som Energia<br><a href="comercialitzacio@somenergia.coop">comercializacion@somenergia.coop</a><br><a href="https://www.somenergia.coop">www.somenergia.coop</a></p>
% endif

${plantilla_footer}
