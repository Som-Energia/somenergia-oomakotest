<!doctype html><html><head><meta charset="utf-8"/><html>
<html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head><body>
% else:
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head><body>
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
Malgrat l'enviament de diferents e-mails de reclamació, a data d’avui no hem rebut cap resposta per part teva, per la qual cosa et tornem a requerir el pagament d’aquesta factura. 

En cas que no puguis abonar aquest import t’oferim la possibilitat de negociar uns terminis de pagament que satisfacin les dues parts i que solucionin aquesta situació d'impagament. 

Si no rebem cap comunicació per part teva, entendrem que no hi ha voluntat de pagar i iniciarem les accions legals oportunes en defensa del interessos de la cooperativa.

Per tal de pagar aquest deute, ens has de transferir l'import de la factura al següent número de compte corrent:

<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0">
<tr><td><fieldset><P ALIGN=center><B>nº c.c. : ES82 1491-0001-29-2027098223
Titular: SOM ENERGIA SCCL</P></B></fieldset></td></tr></table>



<U>Resum de la teva factura</U>
- Adreça punt subministrament: ${object.cups_id.direccio}
- Codi CUPS: ${object.cups_id.name}
- Titular: ${object.polissa_id.titular.name}
- Número de factura: ${object.number}
- Data factura: ${object.invoice_id.date_invoice}
- Període del  ${object.data_inici} al  ${object.data_final}
-<B> Import total: ${object.invoice_id.amount_total}</B>€ 

Atentament,

Equip de Som Energia
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>

<font size="2">Avís a les persones en situació de <b>RISC D'EXCLUSIÓ RESIDENCIAL</b>:
Les persones que presenten una mancança de recursos econòmics poden obtenir ajudes de les administracions públiques (locals i autonòmiques) que els hi permeti seguir tenint accés als subministraments bàsics: aigua potable, gas i electricitat.
Si et trobes en aquesta situació, et recomanem que contactis amb els serveis socials del teu municipi; ells et diran si pots acollir-te a aquestes ajudes i quins són els passos que has de seguir per poder beneficar-te'n.
Abans de donar avís per tallar el subministrament elèctric sol·licitarem a Serveis Socials de l'ajuntament on vius que ens informin si n'ets usuari/a o et trobes en una de les situacions de risc d'exclusió residencial.

Informació al consumidor:
La persona titular del contracte pot acollir-se al mercat regulat (PVPC) on, en el cas de complir amb els requisits i les condicions previstes en la normativa vigent, podrà sol·licitar el bo social que s’aplicarà a les factures de subministrament d’electricitat. El bo social únicament pot ser ofert per les comercialitzadores de referència.</font>

% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
Después de diferentes correos de reclamación, a fecha de hoy, no hemos recibido ninguna respuesta por tu parte, por lo que te volvemos a requerir el pago de esta factura.

En el supuesto que no puedas abonar este importe te ofrecemos la posibilidad de negociar unos fraccionamientos de pago que se satisfaga a las dos partes y que solucionen esta situación de impago 

Si no recibimos ninguna comunicación por tu parte, entenderemos que no hay voluntad de pagar e iniciaremos las acciones legales opotunas en defensa de los intereses de nuestra cooperativa. 

Para pagar esta deuda, nos tienes que transferir el importe de la factura al siguiente número de cuenta:


<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0">
<tr><td><fieldset><P ALIGN=center><B>nº c.c. : ES82 1491-0001-29-2027098223
Titular: SOM ENERGIA SCCL</P></B></fieldset></td></tr></table>

<U>Resumen de la factura</U>
- Dirección punto suministro: ${object.cups_id.direccio}
- Titular: ${object.polissa_id.titular.name}
- Codigo CUPS: ${object.cups_id.name}
- Número factura: ${object.number}
- Fecha factura: ${object.invoice_id.date_invoice}
- Periodo del  ${object.data_inici} al  ${object.data_final}
- <B>Importe total: ${object.invoice_id.amount_total}</B>€

Atentamente,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>

<font size="2">Aviso a las personas en situación de <b>RIESGO DE EXCLUSIÓN RESIDENCIAL</b>:
Las personas que presentan una falta de recursos económicos pueden obtener ayudas de las administraciones públicas (locales o autonómicas) que les permitan seguir teniendo acceso a los suministros básicos: agua potable, gas y electricidad.
Si te encuentras en esta situación, te recomendamos que contactes con los servicios sociales de tu municipio; ellos te informarán de estas ayudas y qué pasos debes seguir para poder beneficiarte.
Antes de dar aviso para que corten el suministro eléctrico solicitaremos a Servicios Sociales del ayuntamiento donde vives que nos informen si eres usuario/a de estos servicios o si te encuentras en alguna de las situaciones de riesgo de exclusión residencial.

Información al consumidor:
La persona titular del contrato puede acogerse al mercado regulado (PVPC) donde, en el caso de cumplir con los requisitos y las condiciones previstas en la normativa vigente, podrá solicitar el bono social que se aplicará en las facturas de suministro de electricidad. El bono social únicamente puede ser ofertado por las comercializadoras de referencia.</font>

% endif
</body>
</html>
</html>
