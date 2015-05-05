<!doctype html>
<html>
<head></head>
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
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.polissa_id.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object.polissa_id._cr, object.polissa_id._uid,object.polissa_id.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>
Hola${nom_pagador},
% if object.invoice_id.partner_id.lang != "es_ES":

T'enviem l'<B>abonament</B> d'una factura anterior d'electricitat de Som Energia, ja que les lectures facturades no eren correctes.

Aquesta factura d'abonament anul·la la que havíem emès anteriorment per al mateix període.
Durant els propers dies rebràs la factura rectificada on hi consten les noves dades de les que disposem.

<U>Resum de la teva factura</U>
- Adreça punt subministrament: ${object.cups_id.direccio}
- Codi CUPS: ${object.cups_id.name}
- Titular: ${object.polissa_id.titular.name}
- Número de factura: ${object.number}
- Data factura: ${object.invoice_id.date_invoice}
- Període del  ${object.data_inici} al  ${object.data_final}
-<B> Import total: ${object.invoice_id.amount_total}</B>€ 

I la setmana vinent realitzarem els moviments bancaris corresponents (retorn de l'abonament i cobrament de la factura rectificada).

Si tens qualsevol dubte, pots respondre aquest mateix correu.

Recorda que pots consultar totes les teves factures a l'Oficina Virtual.
Enllaços que et poden ser d'ajuda:
<a href="http://ca.support.somenergia.coop/article/109-com-puc-accedir-a-l-oficina-virtual">Com puc accedir a l’Oficina Virtual?</a>
<a href="http://ca.support.somenergia.coop/article/267-on-puc-consultar-les-meves-factures">On puc consultar les meves factures?</a>


Atentament,

Equip de Som Energia
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":

Te enviamos el <B>abono</B> de una factura anterior de electricidad de Som Energia, ya que las lecturas facturadas no eran correctas. 
Esta factura de abono anula la que habíamos emitido anteriormente para el mismo periodo.

<U>Resumen de la factura</U>
- Dirección punto suministro: ${object.cups_id.direccio}
- Titular: ${object.polissa_id.titular.name}
- Codigo CUPS: ${object.cups_id.name}
- Número factura: ${object.number}
- Fecha factura: ${object.invoice_id.date_invoice}
- Periodo del  ${object.data_inici} al  ${object.data_final}
- <B>Importe total: ${object.invoice_id.amount_total}</B>€

Durante los próximos días recibirás la factura rectificada donde constan los nuevos datos de los que disponemos.

Y la próxima semana realizaremos los movimientos bancarios correspondientes (retorno del abono y cobro de la factura rectificada).

Si tienes cualquier duda, puedes responder este mismo correo.

Recuerda que puedes consultar todas tus facturas en la Oficina Virtual.
Enlaces que pueden ser útiles:
<a href="http://es.support.somenergia.coop/article/165-como-puedo-acceder-a-la-oficina-virtual">¿Cómo puedo acceder a la Oficina Virtual?</a>
<a href="http://es.support.somenergia.coop/article/280-donde-puedo-consultar-mis-facturas">¿Dónde puedo consultar mis facturas?</a>


Atentamente,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop/">www.somenergia.coop</a>
% endif
</body>
</html>
</html>
