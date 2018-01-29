<!doctype html><html><head><meta charset="utf-8"/><html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head><body>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head><body>
% endif
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.polissa_id.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.polissa_id.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>
Hola${nom_pagador},
% if object.invoice_id.partner_id.lang != "es_ES":

<b>============PLANTILLA EN BLANC============</b>
<b>ESBORRA AQUEST MISSATGE I POSA-HI EL TEU TEXT</b>
<b>POTS UTILITZAR LES VARIABLES SEGÜENTS</b>

factura ${object.number}
Adreça punt subministrament: ${object.cups_id.direccio}
Titular: ${object.polissa_id.titular.name}
Codi CUPS: ${object.cups_id.name}
Número de factura: ${object.number}
Data factura: ${object.invoice_id.date_invoice}
Període de lla factura: ${object.data_inici} al ${object.data_final}
Import de la factura: ${object.invoice_id.amount_total}€

<b>RECORDA FER-HO TAMBÉ EN CASTELLÀ, ESTA MES ABAIX</b>
<b>============FINAL============</b>

Salutacions,

Equip de Som Energia
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre de Suport</a>
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":

<b>============PLANTILLA EN BLANCO============</b>
<b>BORRA ESTE MENSAJE Y PON EL TUYO</b>
<b>PUEDES UTILIZAR LAS VARIABLES SIGUIENTES</b>

factura ${object.number}
Dirección punto suministro: ${object.cups_id.direccio}
Titular: ${object.polissa_id.titular.name}
Código CUPS: ${object.cups_id.name}
Número factura: ${object.number}
Fecha factura: ${object.invoice_id.date_invoice}
Periodo de la factura:  ${object.data_inici} al  ${object.data_final}
Importe de la factura: ${object.invoice_id.amount_total}€

<b>============FINAL============</b>

Un saludo,

Equipo de Som Energia
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a>
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>