<!doctype html>
<html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% endif
<body>
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
<br/>
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
Hola ${nom_pagador},<br/>
<br/>
% if object.invoice_id.partner_id.lang != "es_ES":
% if data_baixa:
T'escrivim per recordar-te el contracte ${object.polissa_id.name} ubicat a ${object.cups_id.direccio} es va donar de baixa de Som Energia amb data ${data_baixa}, deixant 1 o més factures pendents de pagament.<br>
<br>
Després de diversos intents sense èxit per regularitzar aquesta situació, el proper ${data_juridic} passarem el cas als nostres serveis jurídics perquè emprenguin les accions que considerin oportunes.<br>
<br>
<br>
% endif
A continuació trobaràs un resum de la factura pendent i les instruccions per regularitzar-la.<br> 
<br/>
Resum de la teva factura<br/>
<br/>
- Adreça punt subministrament: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Codi CUPS: ${object.cups_id.name}<br/>
- Número de factura: <B>${object.number}</B><br/>
- Data factura: ${object.invoice_id.date_invoice}<br/>
- Període del  ${object.data_inici} al  ${object.data_final}<br/>
- <B>Import total: ${object.invoice_id.amount_total}€</B> <br/>
<br/>
Per tal de regularitzar-la, pots fer-ho mitjançant:<br/>
<br/>
<ul>
  <li>Targeta de dèbit/crèdit a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>. Si no hi has accedit mai, pots consultar <a href="https://ca.support.somenergia.coop/article/109-com-puc-accedir-a-l-oficina-virtual">aquest article.</a></li>
  <li>El document adjunt amb codi de barres: online amb targeta mitjançant l’enllaç que trobaràs sota el codi de barres del document o bé en els caixers de l'entitat <a href="https://www3.caixabank.es/apl/localizador/caixamaps/index_ca.html">CaixaBank</a>. </li>
</ul>
<br/>
Al següent article t’expliquem amb més detall com funcionen aquests dos mètodes de pagament: <a href="https://ca.support.somenergia.coop/article/773-pagament-mitjancant-codi-de-barres-n57">Com fer el pagament mitjançant codi de barres?</a><br/>
<br/>
% if data_baixa:
    T'informem que rebràs tants correus com factures tinguis pendents de pagament.<br>
    <br>
    Seguim en contacte per a qualsevol dubte o aclariment.<br>
    <br>
%endif
Salutacions,<br/>
<br/>
Equip de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br/>
<br/>
<br/>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
% if data_baixa:
Te escribimos para recordarte que el contrato ${object.polissa_id.name} ubicado en ${object.cups_id.direccio} se dio de baja con Som Energia con fecha ${data_baixa}, dejando 1 o más facturas pendientes de pago.<br>
<br>
Después de varios intentos sin éxito para regularizar la situación, el próximo ${data_juridic} pasaremos el caso a nuestros servicios jurídicos para que emprendan las acciones que consideren oportunas.<br>
<br>
Te informamos que también comunicaremos esta deuda a los servicios de información sobre solvencia patrimonial y de crédito (ASNEF), de acuerdo con la normativa aplicable a este efecto.<br>
<br>
A continuación te pasamos un resumen de las facturas impagadas y nuestro número de cuenta bancaria como última oportunidad para saldar las deudas pendientes antes de pasar el caso a nuestros abogados.<br>
<br>
% endif
<br/>
A continuación encontrarás un resúmen de la factura pendiente de pago y las instrucciones para regularizarla.
<br/>
Resumen de tu factura<br/>
<br/>
- Dirección punto suministro: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Código CUPS: ${object.cups_id.name}<br/>
- Número factura: <B>${object.number}</B><br/>
- Fecha factura: ${object.invoice_id.date_invoice}<br/>
- Periodo del  ${object.data_inici} al  ${object.data_final}<br/>
- <B>Importe total: ${object.invoice_id.amount_total}</B>€<br/>
<br/>
Para regularizar la factura tienes estas dos opciones:<br/>
<br/>
<ul>
  <li>Tarjeta de débito/crédito a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</>a. Si no has accedido nunca, puedes consultar <a href="https://es.support.somenergia.coop/article/165-como-puedo-acceder-a-la-oficina-virtual?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">este artículo.</a></li>
  <li>El documento adjunto con código de barras: online con tarjeta mediante el enlace que encontrarás bajo el código de barras del documento o bien en los cajeros de la entidad <a href="https://www2.caixabank.es/apl/localizador/caixamaps/index_es.html">CaixaBank</a>. </li>
</ul>
<br/>
En el siguiente artículo te explicamos con más detalle como funcionan estos dos métodos de pago: <a href="https://es.support.somenergia.coop/article/774-pago-mediante-codigo-de-barras-n57?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">¿Como hacer el pago mediante código de barras?</a>

% if data_baixa:
Te informamos que recibirás tantos correos como facturas tengas pendientes de pago.<br>
<br>
Seguimos en contacto para cualquier duda o aclaración.<br>
<br>
% endif
Un saludo,<br/>
<br/>
Equipo de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br/>
<br/>
<br/>
% endif
${text_legal}
</body>
</html>