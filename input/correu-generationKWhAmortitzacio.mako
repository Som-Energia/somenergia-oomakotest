<!doctype html><html><head><meta charset="utf-8"/></head><body><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr></table>
<%
Investment = object.pool.get('generationkwh.investment')
print "Dins: "
investment_name = object.origin
print investment_name
investment_id = Investment.search(object._cr, object._uid, [('name','=', investment_name)])
investment_obj = Investment.read(object._cr, object._uid, investment_id)
print investment_obj
date_investment = investment_obj[0]['first_effective_date']
from datetime import datetime, timedelta
date = datetime.strptime(date_investment, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')

nominal_amount = investment_obj[0]['nshares']*100
amount_amortization = nominal_amount*4/100
num_amortization = int(investment_obj[0]['amortized_amount']/amount_amortization)

%>
% if object.partner_id.lang == "es_ES":
Saludos ${object.partner_id.name.split(',')[-1]},

Te enviamos la liquidación correspondiente al retorno parcial del préstamo Generation kWh ${object.origin} que nos realizaste el ${date}

Haremos la transferencia del importe amortizado a tu cuenta bancaria durante los próximos días.

Es muy importante que verifiques que la cuenta de abono sea la correcta y sino escríbenos urgentemente a este mismo correo informando cuál tiene que ser la cuenta bancaria para realizar la transferencia.

Resumen de la liquidación
Número liquidación:: ${object.name or ''}
Titular: ${object.partner_id.name}
Pago número: ${num_amortization} de 24
Importe total: ${object.amount_total}€

Nº c.c.: ${object.partner_bank.iban} 

Te agradecemos, una vez más, tu implicación con el objetivo compartido de conseguir un modelo energético 100% renovable  y te recordamos que para cualquier duda o aclaración puedes consultar el web: <a href="http://www.generationkwh.es">www.generationkwh.es</a>.


Atentamente,

Equipo de Som Energia
<a href="http://www.somenergia.coop">ww.somenergia.coop</a>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang == "ca_ES":

Salutacions ${object.partner_id.name.split(',')[-1]},

T'adjuntem la liquidació corresponent al retorn parcial del crèdit Generation kWh ${object.origin} que ens vas fer el ${date}

L'import amortitzat et serà transferit al teu compte bancari en els propers dies.

És molt important que verifiquis que el número de compte bancari d’abonament sigui el correcte i sinó escriu-nos urgentment en aquest mateix correu informant de quin ha de ser el compte on et realitzem la transferència.

Resum de la liquidació
Número liquidació: ${object.name or ''}
Titular: ${object.partner_id.name}
Pagament nº: ${num_amortization} de 24
Import total: ${object.amount_total}€

Núm. c.c.: ${object.partner_bank.iban}


Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable i et recordem que pel qualsevol dubte o aclariment pots consultar el web: <a href="http://www.generationkwh.cat">www.generationkwh.cat</a>.


Atentament,


Equip de Som Energia
<a href="http://www.somenergia.coop/ca/">ww.somenergia.coop</a>
% endif
</body>
</html>
