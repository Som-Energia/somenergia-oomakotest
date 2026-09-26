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
<th align="right"><span style="font-weight: 400;"><img style="height: 85px;" src="https://www.somenergia.coop/logo/logo_fosc_100px.png" alt="SomEnergia"></span></th>
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
<p class="f-fallback" style="line-height: 1.5;"><br>Hola,</p>
<p class="f-fallback" style="line-height: 1.5;">Enhorabona! El teu contracte ja té activada l'autoproducció col·lectiva amb data ${datetime.strptime(object.start_date, '%Y-%m-%d').strftime('%d-%m-%Y')}. A partir d'aquest moment començaràs a rebre els kWh que et corresponen per la teva participació en l'autoproducció col·lectiva, corresponent al projecte ${object.gurb_cau_id.gurb_group_id.name}.</p>
<p>Les <b>condicions contractuals actuals</b> del teu contracte amb Som Energia són:</p>
<p>Autoconsum col·lectiu amb compensació d’excedents</p>
<p>Potència GURB: ${str(object.beta_kw).replace('.', ',')} kW</p>
<p>A partir de la data d'activació inclourem a la teva factura mensual la quota del servei GURB.</p>
<p>Salutacions i bona energia!</p>
<p>Equip de Som Energia</p>
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
<th style="height: 91.25px;" align="right"><span style="font-weight: 400;"><img style="height: 85px;" src="https://www.somenergia.coop/logo/logo_fosc_100px.png" alt="SomEnergia"></span></th>
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
<p class="f-fallback" style="line-height: 1.5;"> <br>Hola,</p>
<p class="f-fallback" style="line-height: 1.5;">¡Enhorabuena! Tu contrato ya tiene activada la autoproducción colectiva con fecha ${datetime.strptime(object.start_date, '%Y-%m-%d').strftime('%d-%m-%Y')}. A partir de este momento empezarás a recibir los kWh que te corresponden por tu participación en la autoproducción colectiva, correspondiente al proyecto ${object.gurb_cau_id.gurb_group_id.name}.</p>
<p>Las <b>condiciones contractuales actuales</b> de tu contrato con Som Energia son:</p>
<p>Autoconsumo colectivo con compensación de excedentes</p>
<p>Potencia GURB:  ${str(object.beta_kw).replace('.', ',')} kW</p>
<p>A partir de de la fecha de activación incluiremos en tu factura mensual la cuota del servicio GURB.</p>
<p>¡Saludos y buena energía!</p>
<p>Equipo de Som Energia</p>
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
% endif
<div>${plantilla_footer}</div>
