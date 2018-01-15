<!doctype html>
<html>
<head></head>
<body>
<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">

Benvolgut/da,

T'adjuntem la liquidació d’interessos de l’any 2014 corresponent a la teva aportació
voluntària al capital social de SOM ENERGIA SCCL

L'import d'aquesta liquidació et serà transferit els propers dies.

Verifica que el número de compte bancari d’abonament sigui correcte i si tens qualsevol
dubte escriu-nos en aquest mateix correu.

<u>Resum de la liquidació</u>
Número liquidació: ${object.number or ''}
Titular: ${object.partner_id.name}
Perídoe del ${object.invoice_line[0].name.split(' ')[1]} al ${object.invoice_line[-1].name.split(' ')[3]}
<strong>Import total: ${object.amount_total}€</strong>

Núm. c.c.: ${(object.partner_bank.acc_number or '').replace(' ', '-')}

Aprofitem per agrair-te una vegada més la teva implicació amb el nostre projecte.

L'equip de SOM ENERGIA SCCL

</body>
</html>