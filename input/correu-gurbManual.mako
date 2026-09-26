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
import_gurb = '50 € '
p_obj = object.pool.get('res.partner')
nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.partner_id.name)['nom']
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
<th align="right"><span style="font-weight: 400;"><img style="height: 85px;" src="https://www.somenergia.coop/logo/logo_fosc_100px.png" alt="SOM Energia"></span></th>
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
<p class="f-fallback" style="line-height: 1.5;"><br>Hola, ${nom_titular},</p>
<p class="f-fallback" style="line-height: 1.5;">Moltes gràcies pel teu interès amb el nostre nou servei ${object.gurb_cau_id.gurb_group_id.name}!</p>
<p class="f-fallback" style="line-height: 1.5;">Hem rebut la teva sol·licitud de modificació del contracte ${object.polissa_id.name} amb Som Energia per incorporar el servei de ${object.gurb_cau_id.gurb_group_id.name}, i hem validat que compleixes tots els requisits necessaris.</p>
<br>
<p class="f-fallback" style="line-height: 1.5;"><strong>Les dades del contracte que vols modificar són:</strong></p>
<table class="purchase" role="presentation" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td colspan="2">
<table class="purchase_content" style="height: 181.969px;" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">CUPS</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.polissa_id.cups.name}</p>
</td>
</tr>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">Adreça</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.polissa_id.cups.direccio}</p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<br>
<p>Per formalitzar la teva contractació, cal que:</p>
<p style="padding-left: 40px;">1. Emplenis i signis els documents que t’adjuntem en aquest enllaç de signaturit i fer el pagament del cost d’Adhesió a ${object.gurb_cau_id.gurb_group_id.name} que t’indiquem a continuació:</p>
<p style="padding-left: 40px;">Número de compte: ES82 1491 0001 2920 2709 8223<br>Referència: ${str(object.gurb_cau_id.gurb_group_id.name).upper()} + el teu nom i cognoms<br>Import Cost d’Adhesió GURB (IVA inclòs): ${import_gurb}</p>

<table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center">
<table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>F
<tr>
<td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener"><span style="color: #000000;">Firmar documents!</span></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

<p style="padding-left: 40px;">2. Contesta aquest correu aportant una fotografia del teu DNI (ambdues cares) per poder iniciar el tràmit de l’acord de repartiment, un cop tinguem tots els participants definitius.</p>

<p>Un cop haguem rebut el contracte signat, i la confirmació del pagament i la fotografia del teu DNI, t’enviarem un correu electrònic per informar-te que has completat el procés per sol·licitar la modificació contractual del teu contracte de subministrament per tal d’incorporar el servei ${object.gurb_cau_id.gurb_group_id.name} contractat.</p>
<p>Si no ets conscient que s’ha realitzat aquesta sol·licitud i s’ha fet contra la teva voluntat, respon aquest mateix correu i procedirem a anul·lar qualsevol acció al respecte.</p>
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
<table class="header" role="presentation" width="570" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<th align="right"><img style="height: 85px;" src="https://www.somenergia.coop/logo/logo_fosc_100px.png" alt="SOM Energia"></th>
<th class="sublogo sublogo-bold" align="left">GURB</th>
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
<p class="f-fallback" style="line-height: 1.5;"><br>Hola, ${nom_titular},</p>
<p class="f-fallback" style="line-height: 1.5;">¡Muchas gracias por tu interés en nuestro nuevo servicio ${object.gurb_cau_id.gurb_group_id.name}!</p>
<p class="f-fallback" style="line-height: 1.5;">Hemos recibido tu solicitud de modificación del contrato ${object.polissa_id.name} con Som Energia para incorporar el servicio de ${object.gurb_cau_id.gurb_group_id.name}, y hemos validado que cumples todos los requisitos necesarios. </p>
<br>
<p class="f-fallback" style="line-height: 1.5;"><strong id="docs-internal-guid-8ad42f62-7fff-fd26-8101-77b1f76eecb1">Los datos del contrato que quieres modificar son:</strong></p>
<table class="purchase" role="presentation" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td colspan="2">
<table class="purchase_content" style="height: 181.969px;" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">CUPS</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.polissa_id.cups.name}</p>
</td>
</tr>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">Dirección</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.polissa_id.cups.direccio}</p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<br>
<p>Para formalizar tu contratación, debes:</p>
<p style="padding-left: 40px;">1. Rellenar y firmar los documentos que te adjuntamos en este enlace de signaturit y realizar el pago del Coste de Adhesión a ${object.gurb_cau_id.gurb_group_id.name} que te indicamos a continuación:</p>
<p style="padding-left: 40px;">Número de cuenta: ES82 1491 0001 2920 2709 8223<br>Referencia: ${str(object.gurb_cau_id.gurb_group_id.name).upper()} + tu nombre y apellidos<br>Importe Coste de Adhesión GURB (IVA incluido): ${import_gurb}</p>

<table class="body-action" role="presentation" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center">
<table role="presentation" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="center"><a class="f-fallback button" href="${env['signature']['signature_url']}" target="_blank" rel="noopener">Firmar documentos!</a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

<p>Una vez recibido el contrato firmado y la confirmación del pago, te enviaremos un correo electrónico para informarte de que has completado el proceso para solicitar la modificación contractual de tu contrato de suministro para incorporar el servicio ${object.gurb_cau_id.gurb_group_id.name} contratado.</p>
<p>Si no eres consciente de que se ha realizado esta solicitud y se ha hecho contra tu voluntad, responde a este mismo correo y procederemos a anular cualquier acción al respecto.</p>
<p><a href="http://www.somenergia.coop">www.somenergia.coop</a></p>
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
