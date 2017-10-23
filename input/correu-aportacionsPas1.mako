<!doctype html>
<html>
<head><meta charset="utf-8"/></head><br/>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">


% if object.partner_id.lang != "es_ES":
Benvolgut/da ${object.partner_id.name.split(',')[-1]},

Et confirmem que hem rebut correctament la teva sol•licitud per fer una aportació voluntària al capital social de Som Energia, amb les següents dades:

Soci/Sòcia: ${object.partner_id.name}
Compte de càrrec: ${object.bank_id.printable_iban[:-4]}****
Import aportació: ${int(abs(object.amount_currency))} €

En els propers dies rebràs el càrrec bancari en aquest compte, siusplau verifica que totes les dades facilitades són correctes i que disposes dels diners que vols invertir, per tal que no hi hagi cap incidència en el gir del rebut.

Un cop verificada la validesa del pagament realitzat rebràs una nova notificació confirmant l'aportació realitzada i detallant les condicions particulars de la teva aportació.

Agrair la teva implicació amb la cooperativa i informar-te que per a qualsevol dubte o aclariment pots consultar el web <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a> o bé mitjançant un mail a <a href="mailto:invertir@somenergia.coop">invertir@somenergia.coop</a>.

Recorda que també pots participar de la Generació kWh per generar la teva energia a partir de nous projectes col•lectius de generació. Consulta el web <a href="https://www.generationkwh.org/ca">www.generationkwh.org</a>.

Pots fer córrer la veu explicant el projecte a familiars i amics/gues. Com més siguem, més energia verda generarem!

Moltes gràcies i bona energia!

Atentament,


Som Energia, SCCL
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.partner_id.lang != "ca_ES":
Apreciado/a ${object.partner_id.name.split(',')[-1]},

Te confirmamos que hemos recibido correctamente tu solicitud para realizar una aportación voluntaria al capital social de Som Energia, con los siguientes datos:

Socio/a: ${object.partner_id.name}
Cuenta de cargo: ${object.bank_id.printable_iban[:-4]}****
Importe aportación: ${int(abs(object.amount_currency))} €

En los próximos dias recibirás el cargo bancario en esta cuenta, por favor verifica que todos los datos facilitados sean correctos y dispones del dinero que quieres invertir, para evitar cualquier incidencia en el giro del recibo.

Una vez verificada la validez del pago realizado recibirás una nueva notificación confirmando la aportación realizada y detallando las condiciones particulares de tu aportación.

Agradecer tu implicación con la cooperativa y informarte que para cualquier duda o aclaración puedes consultar nuestra web <a href="https://www.somenergia.coop">www.somenergia.coop</a> o enviarnos un correo electrónico a <a href="mailto:invertir@somenergia.coop">invertir@somenergia.coop</a>
Recuerda que también puedes participar de la Generación kWh para generar tu energía con nuevos proyectos colectivos de generación. Consulta la web <a href="https://www.generationkwh.org/es">www.generationkwh.org</a>.

Haz que corra la voz explicando el proyecto a familiares y amigos. Cuantos más seamos, más energía verde generaremos!

¡Muchas gracias y buena energía!

Atentamente,


Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
