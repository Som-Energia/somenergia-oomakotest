<!doctype html><html><head><meta charset="utf-8"/></head><body><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr></table>
<%
Investment = object.pool.get('generationkwh.investment')
investment_name = object.origin
investment_id = Investment.search(object._cr, object._uid, [('name','=', investment_name)])
investment_obj = Investment.read(object._cr, object._uid, investment_id)
date_investment = investment_obj[0]['purchase_date']
from datetime import datetime, timedelta
date = datetime.strptime(date_investment, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')

nominal_amount = investment_obj[0]['nshares']*100
amount_amortization = nominal_amount*4/100
num_amortization = int(investment_obj[0]['amortized_amount']/amount_amortization)
partner_bank = object.partner_bank.iban
bank_account = ' '.join(partner_bank[i:i+4] for i in xrange(0,len(partner_bank),4))
%>
% if object.partner_id.lang == "es_ES":

Hola ${object.partner_id.name.split(',')[-1]},

Te adjuntamos la liquidación ${num_amortization} de 24 correspondiente al retorno parcial del préstamo Generation kWh que hiciste el ${date}. 

El importe amortizado será transferido, en los próximos días, a esta cuenta bancaria: <b>${bank_account}</b>.

Por favor, <b>verifica que el número de cuenta bancaria de abono es correcto</b>. En caso de no serlo, responde de forma urgente este correo indicando a qué cuenta quieres la transferencia.

<b>Resumen de la liquidación</b>
· Titular:  ${object.partner_id.name}
· Inversion:  ${nominal_amount}€
· Referencia:  ${object.name or ''}
· <b>Retorno parcial:</b>  ${object.amount_total}€
· <b>Pago número:</b> ${num_amortization} de 24

Para cualquier duda o aclaración antes de responder este correo te recomendamos visitar primero el <a href="http://es.support.somenergia.coop/category/595-generation-kwh">centro de ayuda de la Generación kWh</a> donde hay listadas las principales preguntas que nos han ido llegando.

Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de alcanzar un modelo energético 100% renovable. Cuantas más seamos, más energía verde generamos. ¡Que corra la voz!

Salud y buena energía,


Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang == "ca_ES":

Hola ${object.partner_id.name.split(',')[-1]},

T'adjuntem la liquidació ${num_amortization} de 24 corresponent al retorn parcial del préstec Generation kWh que vas fer el ${date}. 

L'import amortitzat et serà transferit, en els propers dies, al següent compte bancari: <b>${bank_account}</b>.

Si us plau, <b>verifica que el número de compte bancari d’abonament és correcte</b>. En cas de no ser-ho, respon de forma urgent aquest correu indicant a quin compte vols que et fem la transferència.

<b>Resum de la liquidació</b>
· Titular:  ${object.partner_id.name}
· Inversió:  ${nominal_amount}€
· Referència:  ${object.name or ''}
· <b>Retorn parcial:</b>  ${object.amount_total}€
· <b>Pagament número:</b> ${num_amortization} de 24

Per a qualsevol dubte o aclariment abans de respondre aquest correu et recomanem visitar el <a href="http://ca.support.somenergia.coop/category/580-generation-kwh">centre d’ajuda de la Generació kWh</a> on hi ha llistades les principals preguntes que ens han anat arribant.

Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable. Quantes més siguem, més energia verda generarem. Que corri la veu!

Salut i bona energia,


Som Energia, SCCL
<a href="http://www.somenergia.coop/ca/">www.somenergia.coop</a>
% endif
</body>
</html>
