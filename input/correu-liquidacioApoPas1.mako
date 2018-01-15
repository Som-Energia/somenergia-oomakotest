<!doctype html>
<html><body>
<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"

<%
partner_bank = object.partner_bank.iban
iban = ' '.join(partner_bank[i:i+4] for i in xrange(0,len(partner_bank),4))
%>

% if object.partner_id.lang != "es_ES":

Benvolgut/da,

T'adjuntem la liquidació d’interessos de l’any 2016 corresponent a la teva aportació
voluntària al capital social de SOM ENERGIA SCCL

L'import d'aquesta liquidació et serà transferit els propers dies.

Verifica que el número de compte bancari d’abonament sigui el correcte i sinó escriu-nos urgentment en aquest mateix correu

<u>Resum de la liquidació</u>
Número liquidació: ${object.number or ''}
Titular: ${object.partner_id.name}
Període del ${object.invoice_line[0].name.split(' ')[1]} al ${object.invoice_line[-1].name.split(' ')[3]}
<strong>Import total: ${object.amount_total}€</strong>

Núm. c.c.: ${iban}

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

Te enviamos la liquidación de intereses del año 2016 correspondiente a tu aportación
voluntaria al capital social de SOM ENERGIA SCCL

El importe de esta liquidación será transferido en tu cuenta bancaria durante los próximos
dias.

Verifica que la cuenta de abono sea la correcta y sino escríbenos urgentemente en este mismo correo.

<u>Resumen de la liquidación</u>
Número liquidación:: ${object.number or ''}
Titular: ${object.partner_id.name}
Período del ${object.invoice_line[0].name.split(' ')[1]} al ${object.invoice_line[-1].name.split(' ')[3]}
<strong>Importe total: ${object.amount_total}€</strong>

Núm. c.c.: ${iban}

Aprovechamos para agradecerte una vez más tu implicación con nuestro proyecto.


Atentamente,

Equipo de Som Energia
invertir@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
