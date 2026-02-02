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
% if lang == "ca_ES":
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
<p class="f-fallback" style="line-height: 1.5;"><br>Hola, ${object.partner_id.name},</p>
<p class="f-fallback" style="line-height: 1.5;">Et confirmem que hem rebut correctament la teva sol·licitud per participar en el projecte d’autoproducció col·lectiva ${object.gurb_id.name}, organitzat per Som Energia.</p>
<p class="f-fallback" style="line-height: 1.5;">Aquest és el resum de les dades facilitades en el formulari de contractació del servei GURB:</p>
<br>
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
<tr style="height: 19.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">Persona titular</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.partner_id.name}</p>
</td>
</tr>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">DNI, NIE o CIF</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.partner_id.cifnif}</p>
</td>
</tr>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">Participació corresponent % (Beta) (1)</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.beta_percentage}</p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<br>
<p>Et recordem que GURB és un projecte col·lectiu i el procés d’incorporació de totes les persones autoconsumidores pot trigar un temps.</p>
<p>Quan tinguem totes les inscripcions necessàries formalitzades iniciarem el tràmit de modificació del teu contracte de subministrament elèctric a autoproducció col·lectiva i t’informarem mitjançant correu electrònic.</p>
<p>Adjunt en aquest correu trobaràs la documentació que has firmat durant el formulari d’inscripció al servei GURB:</p>
<ul>
<li>
<p>Contracte </p>
</li>
<li>
<p>Designació de la representació de l’autoconsum col·lectiu</p>
</li>
<li>
<p>Consentiment de baixa del servei GURB.</p>
</li>
</ul>
<p>A més a més, adjuntem la factura del cost d’adhesió del servei.</p>
<p>T'informem que disposes de 14 dies naturals des de la data d’emplenament  del formulari d'inscripció per desistir de la teva participació en el servei GURB. En cas que vulguis desistir, és necessari que ens ho notifiquis per correu electrònic a gurb@somenergia.coop, o per correu postal a:</p>
<p>SOM ENERGIA SCCL<br>C/ Pic de Peguera, 11<br>17003 Girona</p>
<p>Si vols, pots utilitzar el text de desistiment que tens en aquesta plantilla. En cas de desistir, et tornarem la quota d’inscripció a tot tardar en 14 dies naturals a partir de la data en què ens ho comuniquis. Efectuarem el reemborsament, al número de compte que ens indiquis en el moment de fer el desistiment.</p>
<p>Si tens qualsevol dubte, pots respondre aquest correu electrònic. </p>
<p>(1) La normativa indica que el sumatori total de les betes ha de sumar 100%, per aquest motiu Som energia es reserva el dret de modificar la teva beta amb un marge de 0,01%.</p>
<p>Equip de Som Energia</p>
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
<p class="f-fallback" style="line-height: 1.5;"><br>Hola, ${object.partner_id.name},</p>
<p class="f-fallback" style="line-height: 1.5;">Et confirmem que hem rebut correctament la teva sol·licitud per participar en el projecte d’autoproducció col·lectiva ${object.gurb_id.name}, organitzat per Som Energia.</p>
<p class="f-fallback" style="line-height: 1.5;">Aquest és el resum de les dades facilitades en el formulari de contractació del servei GURB:</p>
<br>
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
<tr style="height: 19.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">Persona titular</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.partner_id.name}</p>
</td>
</tr>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">DNI, NIE o CIF</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 19.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.partner_id.cifnif}</p>
</td>
</tr>
<tr style="height: 47.5938px;">
<td class="purchase_footer" style="width: 50.0885%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback purchase_total purchase_total--label">Participació corresponent % (Beta) (1)</p>
</td>
<td class="purchase_footer" style="width: 49.9115%; height: 47.5938px;" valign="middle" width="50%">
<p class="f-fallback">${object.beta_percentage}</p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<br>
<p>Et recordem que GURB és un projecte col·lectiu i el procés d’incorporació de totes les persones autoconsumidores pot trigar un temps.</p>
<p>Quan tinguem totes les inscripcions necessàries formalitzades iniciarem el tràmit de modificació del teu contracte de subministrament elèctric a autoproducció col·lectiva i t’informarem mitjançant correu electrònic.</p>
<p>Adjunt en aquest correu trobaràs la documentació que has firmat durant el formulari d’inscripció al servei GURB:</p>
<ul>
<li>
<p>Contracte </p>
</li>
<li>
<p>Designació de la representació de l’autoconsum col·lectiu</p>
</li>
<li>
<p>Consentiment de baixa del servei GURB.</p>
</li>
</ul>
<p>A més a més, adjuntem la factura del cost d’adhesió del servei.</p>
<p>T'informem que disposes de 14 dies naturals des de la data d’emplenament  del formulari d'inscripció per desistir de la teva participació en el servei GURB. En cas que vulguis desistir, és necessari que ens ho notifiquis per correu electrònic a gurb@somenergia.coop, o per correu postal a:</p>
<p>SOM ENERGIA SCCL<br>C/ Pic de Peguera, 11<br>17003 Girona</p>
<p>Si vols, pots utilitzar el text de desistiment que tens en aquesta plantilla. En cas de desistir, et tornarem la quota d’inscripció a tot tardar en 14 dies naturals a partir de la data en què ens ho comuniquis. Efectuarem el reemborsament, al número de compte que ens indiquis en el moment de fer el desistiment.</p>
<p>Si tens qualsevol dubte, pots respondre aquest correu electrònic. </p>
<p>(1) La normativa indica que el sumatori total de les betes ha de sumar 100%, per aquest motiu Som energia es reserva el dret de modificar la teva beta amb un marge de 0,01%.</p>
<p>Equip de Som Energia</p>
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
