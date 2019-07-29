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
T'informem que comunicarem aquest deute als serveis d'informació sobre solvència patrimonial i de crèdit (ASNEF), d'acord amb la normativa aplicable a aquest efecte.<br>
<br>
A continuació et passem un resum de la factura pendent i les instruccions de pagament com a última oportunitat per saldar el deute pendent abans de passar el cas als nostres advocats.<br>
<br>
% endif
Per regularitzar la següent factura, has fer el pagament mitjançant el document adjunt amb codi de barres. <br/>
<br/>
Pots realitzar-lo des del següent  <a href="https://www4.caixabank.es/apl/pagos/codigoBarras_ca.html">enllaç</a> o bé en els caixers de l’entitat <a href="https://www3.caixabank.es/apl/localizador/caixamaps/index_ca.html">CaixaBank</a>. Si tens qualsevol dubte consulta l’enllaç: <a href="https://ca.support.somenergia.coop/article/773-pagament-mitjancant-codi-de-barres-n57">Com fer el pagament mitjançant codi de barres?</a><br/>
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
Para regularizar la siguiente factura, debes hacer el pago mediante el documento adjunto con código de barras.<br/>
<br/>
Puedes realizarlo desde el siguiente <a href="https://www4.caixabank.es/apl/pagos/codigoBarras_es.html">enlace</a> o bien en los cajeros de la entidad <a href="https://www3.caixabank.es/apl/localizador/caixamaps/index_es.html">CaixaBank</a>. Si tienes cualquier duda consulta el enlace: <a href="https://es.support.somenergia.coop/article/774-pago-mediante-codigo-de-barras-n57">Cómo hacer el pago mediante código de barras?</a><br/>

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
