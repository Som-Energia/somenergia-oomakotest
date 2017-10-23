<!doctype html>
<html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#F2soF2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head><body>
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
Et tornem a recordar l'impagament d'aquesta factura, no hem rebut la transferència cancel.lant el deute, t’agrairíem que regularitzis la situació en la major brevetat possible. 

Com saps la nostra cooperativa té uns recursos limitats i els hem de gestionar de la manera més eficient possible, els  impagaments poden posar en perill la continuïtat de la nostra cooperativa.

Per tal de cancel·lar aquest deute, per tal d'efectuar el pagament, has de fer una transferència per l'import de la factura al següent número de compte corrent:

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

Avís a les persones en situació de <b> RISC D’EXCLUSIÓ RESIDENCIAL</b>:

Les persones que presenten una mancança de recursos econòmics poden obtenir ajudes de les administracions públiques (locals i autonòmiques) que els hi permeti seguir tenint accés als subministraments bàsics: aigua potable, gas i electricitat.

Si et trobes en aquesta situació, et recomanem que contactis amb els serveis socials del teu municipi; ells et diran si  pots acollir-te a aquestes ajudes i quins són els passos que has de seguir per poder beneficar-te’n.

Abans de donar avís per tallar el subministrament elèctric sol·licitarem a Serveis Socials de l'ajuntament on vius que ens informin si n'ets usuari/a o et trobes en una de les situacions de risc d'exclusió residencial.

Atentament,

Equip de Som Energia
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
Te volvemos a recordar el impago de esta factura, no hemos recibido la transferencia cancelando la deuda, te agradeceriamos que regularices la situación en la mayor brevedad posible. 

Como sabes nuestra cooperativa tiene unos recusros limitados, y tenemos que gestionarlos de la manera más eficiente posible. Los impagos pueden poner en peligro la continuadad de nuestra cooperativa.

Para cancelar la deuda, tienes que transferir el importe de la factura al siguiente número de cuenta:

<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0">
<tr><td><fieldset><P ALIGN=center><B>nº c.c. : ES82 1491-0001-29-2027098223
Titular: SOM ENERGIA SCCL</P></B></fieldset></td></tr></table>

<U>Resumen de la factura</U>
- Dirección punto suministro: ${object.cups_id.direccio}
- Titular: ${object.polissa_id.titular.name}
- Código CUPS: ${object.cups_id.name}
- Número factura: ${object.number}
- Fecha factura: ${object.invoice_id.date_invoice}
- Periodo del  ${object.data_inici} al  ${object.data_final}
- <B>Importe total: ${object.invoice_id.amount_total}</B>€

Aviso a las personas en situación de <b>RIESGO DE EXCLUSIÓN RESIDENCIAL</b>:

Las personas que presentan una falta de recursos económicos pueden obtener ayudas de las administraciones públicas (locales o autonómicas) que les permita seguir teniendo acceso a los suministros basicos: agua potable, gas y electricidad.

Si te encuentras en esta situación, te recomendamos que contactes con los servicios sociales de tu municipio; ellos te diran si te puedes acoger a estas ayudas y cuales son los pasos que has de seguir para poder benerficiarte. 

Antes de dar aviso para que corten el suministo eléctrico solicitaremos a Servicios Sociales del ayuntamiento donde vives que nos informen si eres usuario/a de estos servicios o si te encuentras en una de las situaciones de riesgo de exclusión residencial.

Atentamente,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>
