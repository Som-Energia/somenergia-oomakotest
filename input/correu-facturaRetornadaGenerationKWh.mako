<!doctype html><html><head><meta charset="utf-8"/></head><body><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr></table>
% if object.partner_id.lang != "ca_ES":
Saludos ${object.partner_id.name},

El banco nos ha devuelto el recibo del Generation kWh XXGKWHXXX que nos realizaste el ${object.date_invoice} a la cuenta ${(object.partner_bank.acc_number or '').replace(' ', '-')}
 
Te agradecemos que nos indiques como hacer el pago.

Atentamente,

Equipo de Som Energia
invertir@somenergia.coop
www.somenergia.coop
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "es_ES":
Salutacions ${object.partner_id.name},

El banc ens ha retornart el rebut del Generartion kWh XXGKWHXXX que ens vas fer el ${object.date_invoice} al compte ${(object.partner_bank.acc_number or '').replace(' ', '-')}

T'agraim que ens indiquis com fer el pagament.

Atentament,

Equip de Som Energia
invertir@somenergia.coop
www.somenergia.coop
% endif
</body>
</html>
