<!doctype html>
<html><body>
<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">
% if object.partner_id.lang != "es_ES":
Benvolgut/da,

T'adjuntem la liquidació d’interessos fins a 30 de juny de 2013 corresponent a la teva inversió en títols participatius de SOM ENERGIA SCCL

L'import d'aquesta liquidació et serà transferit els propers dies.

Verifica que el número de compte bancari d’abonament sigui el correcte i sinó escriu-nos urgentment en aquest mateix correu

<u>Resum de la liquidació</u>
Número liquidació: ${object.number or ''}
Titular: ${object.partner_id.name}
Període del ${object.invoice_line[0].name.split(' ')[1]} al ${object.invoice_line[-1].name.split(' ')[3]}
<strong>Import total: ${object.amount_total}€</strong>

Núm. c.c.: ${(object.partner_bank.acc_number or '').replace(' ', '-')}

Aprofitem per agrair-te una vegada més la teva implicació amb el nostre projecte.


Atentament,

Equip Som Energia
invertir@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
Saludos,

Te enviamos la liquidación de intereses hasta el 30 de Junio del 2014 correspondiente a tu inversión en titulos participativos de SOM ENERGIA SCCL

El importe de esta liquidación será transferido en tu cuenta bancaria durante los próximos
dias.

Verifica que la cuenta de abono sea la correcta y sino escríbenos urgentemente en este mismo correo.

<u>Resumen de la liquidación</u>
Número liquidación:: ${object.number or ''}
Titular: ${object.partner_id.name}
Período del ${object.invoice_line[0].name.split(' ')[1]} al ${object.invoice_line[-1].name.split(' ')[3]}
<strong>Importe total: ${object.amount_total}€</strong>

Nº c.c.: ${(object.partner_bank.acc_number or '').replace(' ', '-')}

Aprovechamos para agradecerte una vez más tu implicación con nuestro proyecto.


Atentamente,

Equipo de Som Energia
invertir@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>