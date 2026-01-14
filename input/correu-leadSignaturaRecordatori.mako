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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>
<div>${plantilla_header}</div>
% if object.partner_id.lang == "ca_ES":
<table class="email-wrapper" role="presentation" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center">
<table class="email-content" role="presentation" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="email-masthead">
<table class="header" role="presentation" width="570" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<th align="right"><span style="font-weight: 400;"><img style="height: 85px;" src="https://i1.wp.com/blog.somenergia.coop/wp-content/uploads/2014/08/gravatar.png" alt="SOM Energia"></span></th>
<th class="sublogo sublogo-bold" align="left"><span style="font-weight: 400;">Alta</span></th>
</tr>
</tbody>
</table>
</td>
</tr>
<!-- Email Body -->
<tr>
<td class="email-body" width="570">
<table class="email-body_inner" role="presentation" width="570" cellspacing="0" cellpadding="0" align="center"><!-- Body content -->
<tbody>
<tr>
<td class="content-cell">
<p class="f-fallback" style="line-height: 1.5;"><br>Hola,</p>
<p class="f-fallback" style="line-height: 1.5;">Us recordem que està pendent la signatura del contracte de llum amb Som Energia.</p>
<br>
<p class="f-fallback" style="line-height: 1.5;">El termini per la firma del contracte acaba d'aquí a set dies. Si passat aquest temps no s’ha procedit a la signatura es cancel·larà el procés de contractació.</p>
<br>

<table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center">
<table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener"><span style="color: #000000;">Firmar documents!</span></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

<p class="f-fallback" style="line-height: 1.5;">
    Per qualsevol dubte, us podeu posar en contacte al correu empresa@somenergia.coop.
</p>

<p>Salutacions,</p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
% else:
<table class="email-wrapper" role="presentation" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center">
<table class="email-content" role="presentation" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="email-masthead">
<table class="header" role="presentation" width="570" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<th align="right"><img style="height: 85px;" src="https://i1.wp.com/blog.somenergia.coop/wp-content/uploads/2014/08/gravatar.png" alt="SOM Energia"></th>
<th class="sublogo sublogo-bold" align="left">Alta</th>
</tr>
</tbody>
</table>
</td>
</tr>
<!-- Email Body -->
<tr>
<td class="email-body" width="570">
<table class="email-body_inner" role="presentation" width="570" cellspacing="0" cellpadding="0" align="center"><!-- Body content -->
    <tbody>
        <tr>
        <td class="content-cell">
        <p class="f-fallback" style="line-height: 1.5;"><br>Hola,</p>
        <p class="f-fallback" style="line-height: 1.5;">Os recordamos que está pendiente la signatura del contrato de luz con Som Energia.</p>
        <br>
        <p class="f-fallback" style="line-height: 1.5;">El plazo para la firma del contrato acaba en siete días. Si pasado este tiempo no se ha procedido a la signatura se cancelará el proceso de contratación.</p>
        <br>

        <table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
        <tbody>
        <tr>
        <td align="center">
        <table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
        <tbody>
        <tr>
        <td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener"><span style="color: #000000;">Firmar documentos!</span></a></td>
        </tr>
        </tbody>
        </table>
        </td>
        </tr>
        </tbody>
        </table>

        <p class="f-fallback" style="line-height: 1.5;">
            Para cualquier duda, os podéis poner en contacto en el correo empresa@somenergia.coop.
        </p>

        <p>Salutacions,</p>
        </td>
        </tr>
        </tbody>
        </table>
        </td>
        </tr>
        </tbody>
        </table>
        </td>
        </tr>
        </tbody>
        </table>
% endif
<div>${plantilla_footer}</div>
