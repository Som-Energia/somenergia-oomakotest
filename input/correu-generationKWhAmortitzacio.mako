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
<%
from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_id = md_obj.get_object_reference(
                    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                )[1]
text_legal = render(t_obj.read(
    object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
%>
% if object.partner_id.lang == "es_ES":
<br/>
Hola ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Te adjuntamos la liquidación ${num_amortization} de 24 correspondiente al retorno parcial del préstamo Generation kWh que hiciste el ${date}. <br/>
<br/>
El importe amortizado será transferido, en los próximos días, a esta cuenta bancaria: <b>${bank_account}</b>.<br/>
<br/>
Por favor, <b>verifica que el número de cuenta bancaria de abono es correcto</b>. En caso de no serlo, responde de forma urgente este correo indicando a qué cuenta quieres la transferencia.<br/>
<br/>
<b>Resumen de la liquidación</b><br/>
· Titular:  ${object.partner_id.name}<br/>
· Inversion:  ${nominal_amount}€<br/>
· Referencia:  ${object.name or ''}<br/>
· <b>Retorno parcial:</b>  ${object.amount_total}€<br/>
· <b>Pago número:</b> ${num_amortization} de 24<br/>
<br/>
Para cualquier duda o aclaración antes de responder este correo te recomendamos visitar primero el <a href="https://es.support.somenergia.coop/category/595-generation-kwh">centro de ayuda de la Generación kWh</a> donde hay listadas las principales preguntas que nos han ido llegando.<br/>
<br/>
Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de alcanzar un modelo energético 100% renovable.<br/>
<br/>
Salud y buena energía,<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<br/>
----------------------------------------------------------------------------------------------------<br/>
<br/>
% endif
% if object.partner_id.lang == "ca_ES":
<br/>
Hola ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
T'adjuntem la liquidació ${num_amortization} de 24 corresponent al retorn parcial del préstec Generation kWh que vas fer el ${date}. <br/>
<br/>
L'import amortitzat et serà transferit, en els propers dies, al següent compte bancari: <b>${bank_account}</b>.<br/>
<br/>
Si us plau, <b>verifica que el número de compte bancari d’abonament és correcte</b>. En cas de no ser-ho, respon de forma urgent aquest correu indicant a quin compte vols que et fem la transferència.<br/>
<br/>
<b>Resum de la liquidació</b><br/>
· Titular:  ${object.partner_id.name}<br/>
· Inversió:  ${nominal_amount}€<br/>
· Referència:  ${object.name or ''}<br/>
· <b>Retorn parcial:</b>  ${object.amount_total}€<br/>
· <b>Pagament número:</b> ${num_amortization} de 24<br/>
<br/>
Per a qualsevol dubte o aclariment abans de respondre aquest correu et recomanem visitar el <a href="https://ca.support.somenergia.coop/category/580-generation-kwh">centre d’ajuda de la Generació kWh</a> on hi ha llistades les principals preguntes que ens han anat arribant.<br/>
<br/>
Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable.<br/>
<br/>
Salut i bona energia,<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
<br/>
</body>
</html>