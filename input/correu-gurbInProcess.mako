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
<th class="sublogo sublogo-bold" align="left"><span style="font-weight: 400;">GURB</span></th>
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
<p class="f-fallback" style="line-height: 1.5;"><br>Hola, ${object.partner_id.name},</p>
<p class="f-fallback" style="line-height: 1.5;">Reps aquest correu en relació amb el projecte ${object.gurb_id.name} al qual t’has inscrit.</p>
<p class="f-fallback" style="line-height: 1.5;">En aquest moment ja hem completat el nombre de sol·licituds necessàries i procedim a iniciar els tràmits de modificació del teu contracte per l’aplicació de l’autoproducció col·lectiva. </p>
<p>Tingues en compte que aquest tràmit pot ser lent. Et recordem que no et cobrarem la quota mensual del servei fins que el tràmit no estigui completat i el teu contracte ja tingui l’autoproducció activada.</p>
<p>Quan tinguem la confirmació per part de la distribuïdora t'enviarem un correu electrònic indicant la data exacta d'activació de la modificació.</p>
<p>Salutacions, </p>
<p>Equip de Som Energia</p>
<p><a href="http://www.somenergia.coop"><span style="color: #000000;">www.somenergia.coop</span></a></p>
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
<table class="header" style="height: 91.25px;" role="presentation" width="570" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr style="height: 91.25px;">
<th style="height: 91.25px;" align="right"><span style="font-weight: 400;"><img style="height: 85px;" src="https://i1.wp.com/blog.somenergia.coop/wp-content/uploads/2014/08/gravatar.png" alt="SOM Energia"></span></th>
<th class="sublogo sublogo-bold" style="height: 91.25px;" align="left"><span style="font-weight: 400;">GURB</span></th>
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
<p class="f-fallback" style="line-height: 1.5;"><br>Hola, ${object.partner_id.name},</p>
<p class="f-fallback" style="line-height: 1.5;">Recibes este correo en relación con el proyecto ${object.gurb_id.name} al que te has inscrito.</p>
<p>En este momento ya hemos completado el número de solicitudes necesarias y procedemos a iniciar los trámites de modificación de tu contrato para la aplicación de la autoproducción colectiva.</p>
<p>Ten en cuenta que este trámite puede ser lento. Te recordamos que no te cobraremos la cuota mensual del servicio hasta que el trámite no esté completado y tu contrato tenga ya la autoproducción activada.</p>
<p>Cuando tengamos la confirmación por parte de la distribuidora te enviaremos un correo electrónico indicando la fecha exacta de activación de la modificación.</p>
<p>Saludos,</p>
<p>Equipo de Som Energia</p>
<p><a href="http://www.somenergia.coop"><span style="color: #000000;"><span style="color: #000000;">www.somenergia.coop</span></span></a></p>
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
