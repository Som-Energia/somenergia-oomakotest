<!doctype html>
<html>
<head><meta charset="utf-8"/></head>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
% if object.partner_id.lang != "es_ES":

Hola ${object.partner_id.name.split(',')[-1]},

Ahir ens va venir retornat el rebut de ${object.amount_total} € que et vam girar fa uns dies corresponent a la teva inversió en Generation kWh amb referència ${object.origin}

Si segueixes interessat en aquesta inversió tens dues opcions:
Transferir aquesta quantitat al següent número de compte de Som Energia: ES19 3025 0016 12 1400005159, indicant el teu nom 
Dir-nos a partir de quina data et podem tornar a girar aquest rebut al teu banc.


Si pel contrari, ja no estàs interessat en aquesta inversió t'agraïrem que ens ho comuniquis.

Salut,


Som Energia, SCCL
<a href="http://www.somenergia.coop/ca/">www.somenergia.coop</a>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.partner_id.lang != "ca_ES":

Hola ${object.partner_id.name.split(',')[-1]},

Ayer nos vino devuelto el recibo de ${object.amount_total} € que te giramos hace unos dias correspondiente a tu inversión en Generation kWh con referencia ${object.origin}

Si sigues interesado en esta inversión tienes dos opciones:
 Hacer una  transferencia al siguiente número de cuenta de Som Energia: ES19 3025 0016 12 1400005159, indicando tu nombre
 Decirnos a partir de  que fecha podemos volver a girar el recibo en tu banco.

Si por el contrario ya no estás interesado en esta inversión te agradeceremos que nos lo comuniques.

Salut,


Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>
