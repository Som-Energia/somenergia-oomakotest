<!doctype html><html><head><meta charset="utf-8"/></head><body><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr></table>
% if object.partner_id.lang != "ca_ES":
Saludos ${object.partner_id.name},

Te enviamos la liquidación correspondiente al retorno parcial del préstamo Generation kWh XXGKWHXXX que nos realizaste el ${object.date_invoice}

Haremos la transferencia del importe amortizado a tu cuenta bancaria durante los próximos días.

Es muy importante que verifiques que la cuenta de abono sea la correcta y sino escríbenos urgentemente a este mismo correo informando cuál tiene que ser la cuenta bancaria para realizar la transferencia.

Resumen de la liquidación
Número liquidación:: ${object.number or ''}
Titular: ${object.partner_id.name}
Pago número: 1 de 24
Importe total: ${object.amount_total}€

Nº c.c.: ${(object.partner_bank.acc_number or '').replace(' ', '-')}

Te agradecemos, una vez más, tu implicación con el objetivo compartido de conseguir un modelo energético 100% renovable  y te recordamos que para cualquier duda o aclaración puedes consultar el web: www.generationkwh.org.


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

T'adjuntem la liquidació corresponent al retorn parcial del crèdit Generation kWh XXGKWHXXX que ens vas fer el ${object.date_invoice}

L'import amortitzat et serà transferit al teu compte bancari en els propers dies.

És molt important que verifiquis que el número de compte bancari d’abonament sigui el correcte i sinó escriu-nos urgentment en aquest mateix correu informant de quin ha de ser el compte on et realitzem la transferència.

Resum de la liquidació
Número liquidació: ${object.number or ''}
Titular: ${object.partner_id.name}
Pagament nº:  1 de 24
Import total: ${object.amount_total}€

Núm. c.c.: ${(object.partner_bank.acc_number or '').replace(' ', '-')}


Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable i et recordem que pel qualsevol dubte o aclariment pots consultar el web: www.generationkwh.cat


Atentament,

Equip de Som Energia
invertir@somenergia.coop
www.somenergia.coop
% endif
</body>
</html>
