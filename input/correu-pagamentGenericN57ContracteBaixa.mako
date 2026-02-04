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
%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.partner_id.vat'):
    nom_pagador =' ' + object.partner_id.name.split(',')[1].lstrip()
  else:
    nom_pagador = ''
except:
  nom_pagador = ''

from datetime import datetime, timedelta
data_juridic = datetime.strftime(datetime.now()+timedelta(days=7), '%d/%m/%Y')
if not object.polissa_id.data_baixa:
  data_baixa = False
else:
  date = datetime.strptime(object.polissa_id.data_baixa, '%Y-%m-%d')
  data_baixa = date.strftime('%d/%m/%Y')
%>

${plantilla_header}

% if object.invoice_id.partner_id.lang != "es_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;"> Titular: ${object.polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola ${nom_pagador},<br/>
<br/>
T'escrivim per recordar-te el contracte ${object.polissa_id.name} ubicat a ${object.cups_id.direccio} es va donar de baixa de Som Energia amb data ${data_baixa}, deixant una o més factures pendents de pagament.<br>
<br>
Després de diversos intents sense èxit per regularitzar aquesta situació, el proper ${data_juridic} passarem el cas al servei extern de recobraments perquè emprenguin les accions que considerin oportunes.<br>
<br>
A continuació et passem un resum de la factura pendent i les instruccions de pagament com a última oportunitat per saldar el deute pendent abans de passar el cas al servei extern de recobraments. <br>
<br>
<U>Resum de la factura</U><br/>
<br/>
- Número de factura: ${object.number}<br/>
- Data factura: ${object.invoice_id.date_invoice}<br/>
- Període del  ${object.data_inici} al  ${object.data_final}<br/>
- Import total: ${object.invoice_id.amount_total}€<br/>
% if object.invoice_id.amount_total != object.invoice_id.residual:
- Import pendent: ${object.invoice_id.residual}€<<br/>
% endif
<br/>
Per tal de regularitzar-la, pots fer-ho mitjançant:<br/>
<ul>
  <li>Targeta de dèbit/crèdit a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>. Si no hi has accedit mai, pots consultar <a href="https://ca.support.somenergia.coop/article/109-com-puc-accedir-a-l-oficina-virtual">aquest article.</a></li><br/>
  <li>El document adjunt amb codi de barres: online amb targeta mitjançant l’enllaç que trobaràs sota el codi de barres del document o bé en els caixers de l'entitat <a href="https://www3.caixabank.es/apl/localizador/caixamaps/index_ca.html">CaixaBank</a>. </li>
</ul>
Al següent article t’expliquem amb més detall com funcionen aquests dos mètodes de pagament: <a href="https://ca.support.somenergia.coop/article/773-pagament-mitjancant-codi-de-barres-n57">Què fer si una factura queda impagada?</a><br/>
<br/>
T'informem que rebràs tants correus com factures tinguis pendents de pagament.<br>
<br>
Seguim en contacte per a qualsevol dubte o aclariment.<br>
<br>
Cordialment,<br/>
<br/>
Equip de Som Energia<br/>
cobraments@somenergia.coop<br/>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br/>
<br/>
<br/>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${object.polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola${nom_pagador},<br/>
<br/>
Te escribimos para recordarte que el contrato ${object.polissa_id.name} ubicado en ${object.cups_id.direccio} se dio de baja con Som Energia con fecha ${data_baixa}, dejando una o más facturas pendientes de pago.<br>
<br>
Después de varios intentos sin éxito para regularizar la situación, el próximo ${data_juridic} pasaremos el caso al servicio externo de recobros para que emprendan las acciones que consideren oportunas.<br>
<br>
A continuación te pasamos un resumen de las facturas impagadas y nuestro número de cuenta bancaria como última oportunidad para saldar las deudas pendientes antes de pasar el caso al servicio externo de recobros.<br>
<br>
<U>Resumen de la factura</U><br/>
<br/>
- Número factura: ${object.number}<br/>
- Fecha factura: ${object.invoice_id.date_invoice}<br/>
- Periodo del  ${object.data_inici} al  ${object.data_final}<br/>
- Importe total: ${object.invoice_id.amount_total}€<br/>
% if object.invoice_id.amount_total != object.invoice_id.residual:
- Importe pendiente: ${object.invoice_id.residual}€<br/>
% endif
<br/>
Para regularizarla puedes hacerlo mediante:<br/>
<ul>
  <li>Tarjeta de débito/crédito a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>. Si no has accedido nunca, puedes consultar <a href="https://es.support.somenergia.coop/article/165-como-puedo-acceder-a-la-oficina-virtual">este artículo.</a></li><br/>
  <li>El documento adjunto con código de barras: online con tarjeta mediante el enlace que encontrarás bajo el código de barras del documento o bien en los cajeros de la entidad <a href="https://www2.caixabank.es/apl/localizador/caixamaps/index_es.html">CaixaBank</a>. </li>
</ul>
En el siguiente artículo te explicamos con más detalle como funcionan estos dos métodos de pago: <a href="https://es.support.somenergia.coop/article/774-pago-mediante-codigo-de-barras-n57">¿Qué hacer si una factura queda impagada?</a><br>
<br>
Te informamos que recibirás tantos correos como facturas tengas pendientes de pago.<br>
<br>
Seguimos en contacto para cualquier duda o aclaración.<br>
<br>
Saludos,<br/>
<br/>
Equipo de Som Energia<br/>
cobros@somenergia.coop<br/>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br/>
<br/>
<br/>
% endif
${plantilla_footer}