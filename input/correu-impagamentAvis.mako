<!doctype html>
<html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head><body>
% else:
<head><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head><body>
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
Vam enviar el rebut de la teva factura d'electricitat a l'entitat bancària per tal que fos carregat al número de compte que ens vas informar però ens ha estat retornat.

Per tal d'efectuar el pagament, pots realitzar una transferència per l'import de la factura al següent número de compte corrent:

<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0">
<tr><td><fieldset><P ALIGN=center><B>nº c.c. : ES82 1491-0001-29-2027098223
Titular: SOM ENERGIA SCCL</P></B></fieldset></td></tr></table>

Si ho prefereixes podem tornar a passar-la pel banc quan ens diguis.

<U>Resum de la teva factura</U>
- Adreça punt subministrament: ${object.cups_id.direccio}
- Codi CUPS: ${object.cups_id.name}
- Titular: ${object.polissa_id.titular.name}
- Número de factura: ${object.number}
- Data factura: ${object.invoice_id.date_invoice}
- Període del  ${object.data_inici} al  ${object.data_final}
-<B> Import total: ${object.invoice_id.amount_total}</B>€ 



Salutacions,

Equip de Som Energia
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
Hace unos días enviamos el recibo de tu <B>factura de electricidad </B> a la entidad bancaria para que fuera cargado al número de cuenta que nos informaste pero nos ha sido devuelto.

Para efectuar el pago puedes realizar una transferencia por el importe de la factura al siguiente número de cuenta corriente:

<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0">
<tr><td><fieldset><P ALIGN=center><B>nº c.c. : ES82 1491-0001-29-2027098223
Titular: SOM ENERGIA SCCL</P></B></fieldset></td></tr></table>

O si lo prefieres podemos volver a pasarla por el banco cuandos nos digas.

<U>Resumen de la factura</U>
- Dirección punto suministro: ${object.cups_id.direccio}
- Titular: ${object.polissa_id.titular.name}
- Codigo CUPS: ${object.cups_id.name}
- Número factura: ${object.number}
- Fecha factura: ${object.invoice_id.date_invoice}
- Periodo del  ${object.data_inici} al  ${object.data_final}
- <B>Importe total: ${object.invoice_id.amount_total}</B>€


Un saludo,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>
