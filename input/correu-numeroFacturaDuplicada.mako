<!doctype html>
<html>
<head><meta charset='utf8'></head>
<body>
<table width="100%" frame="below" BGCOLOR="#F2F2F2">
% if object.invoice_id.partner_id.lang == "ca_ES":
<tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td>
<td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr>
<tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr>
% else:
<tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td>
<td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr>
<tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr>
% endif
</table>
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
template_id = md_obj.get_object_reference(
                    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                )[1]
text_legal = render(t_obj.read(
    object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.polissa_id.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object.polissa_id._cr, object.polissa_id._uid,object.polissa_id.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>

<br>
Hola${nom_pagador},<br>
% if object.invoice_id.partner_id.lang != "es_ES":
<br>
Ens posem en contacte amb tu perquè hem detectat una incidència informàtica que ha generat factures amb el número de factura erroni.<br>
<br>
La factura que has rebut recentment és una de les afectades per aquesta incidència.<br>
<br>
L’hem rectificat, canviant tan sols el número de factura, la resta és exactament igual. T’adjuntem en aquest correu la factura corregida.<br>
<br>
Disculpa les molèsties.<br>
<br>
Per a qualsevol qüestió, seguim en contacte.<br>
<br>
<br>
Salutacions,<br>
<br>
Equip de Som Energia<br>
factura@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
<br>
Nos ponemos en contacto contigo porque hemos detectado una incidencia informática que ha generado facturas con el número de factura erróneo.<br>
<br>
La factura que ha recibido recientemente es una de las afectadas por esta incidencia.<br>
<br>
Lo hemos rectificado, cambiando únicamente el número de factura, el resto es exactamente igual. Te adjuntamos en este correo la factura corregida.<br>
<br>
Disculpa las molestias.<br>
<br>
Para cualquier cuestión, seguimos en contacto.<br>
<br>
<br>
Saludos,<br>
<br>
Equipo de Som Energia<br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop/">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>