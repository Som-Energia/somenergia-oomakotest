<%
from babel.numbers import format_currency

Investment = object.pool.get('generationkwh.investment')
IrModelData = object.pool.get('ir.model.data')
investment_name = object.origin
investment_id = Investment.search(object._cr, object._uid, [('name','=', investment_name)])
investment_obj = Investment.read(object._cr, object._uid, investment_id)
date_investment = investment_obj[0]['purchase_date']

from datetime import datetime, timedelta
date = datetime.strptime(date_investment, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')
date_invoice = datetime.strptime(object.date_invoice, '%Y-%m-%d')
previous_year = (date_invoice + timedelta(weeks=-52)).year
member_id = investment_obj[0]['member_id'][0]
irpf_values = Investment.get_irpf_amounts(object._cr, object._uid, investment_id[0], member_id, previous_year)
amort_product_id = IrModelData.get_object_reference(object._cr, object._uid, 'som_generationkwh', 'genkwh_product_amortization')[1]
amort_value = 0

for line in object.invoice_line:
    if line.product_id.id == amort_product_id:
        amort_value += line.price_subtotal

amort_value = abs(amort_value)

nominal_amount = investment_obj[0]['nshares']*100
amount_amortization = nominal_amount*4/100
num_amortization = int(investment_obj[0]['amortized_amount']/amount_amortization)
partner_bank = object.partner_bank.iban
bank_account = ' '.join(partner_bank[i:i+4] for i in xrange(0,len(partner_bank),4))

Invoice = object.pool.get('account.invoice')
invoice_obj = Invoice.browse(object._cr, object._uid, object.id)
invoice_data = invoice_obj.investmentAmortization_notificationData_asDict()
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
<!doctype html>
<head><meta charset="utf-8"/></head>
<body>
<table width="100%">
<tbody>
<tr>
<td rowspan="4" align="right" valign="TOP"><img src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png" width="130" height="65"></td>
</tr>
</tbody>
</table>
% if object.partner_id.lang == "es_ES":
<p><br>Hola, ${object.partner_id.name.split(',')[-1]},</p>
<p>El proyecto Generation kWh, en el que participas desde el día ${date}, te permite acceder a la tarifa Generation kWh. Dado que esta tarifa no depende del mercado, sino de la gesti&oacute;n y mantenimiento de nuestras plantas, el a&ntilde;o pasado fue considerablemente m&aacute;s econ&oacute;mica que la tarifa est&aacute;ndar, que sufri&oacute; la subida de los precios de la energ&iacute;a en el mercado.</p>
<p>As&iacute; pues, y aunque <a href="https://es.support.somenergia.coop/article/594-aportacion-generation-ahorro?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=castellano">no es el objetivo</a> del proyecto Generation kWh, gracias a tu participaci&oacute;n en ${previous_year} te <strong>ahorraste</strong> ${format_currency(irpf_values['irpf_saving'],'EUR', locale='es_ES')}. Este ahorro, que la ley considera rendimiento en especie, debe declararse a Hacienda y pagar la <strong>retenci&oacute;n correspondiente</strong> del IRPF, en caso de personas f&iacute;sicas, y del impuesto de sociedades, en caso de empresas. En ambos casos, esta retenci&oacute;n es del 19% sobre el ahorro obtenido. Desde Som Energia, y de acuerdo a las Condiciones Generales del contrato de adhesión al proyecto Generation kWh, ya efectuamos este pago en el mes de enero, por lo que pasaremos a hacerte la liquidaci&oacute;n correspondiente en los pr&oacute;ximos d&iacute;as.</p>
<p>&nbsp;</p>
<p>Por otro lado, debemos hacerte el <strong>retorno parcial</strong> de la aportaci&oacute;n que hiciste al Generation kWh. En este caso, es la liquidaci&oacute;n n&uacute;mero ${num_amortization} de 24, y es de ${format_currency(amort_value,'EUR', locale='es_ES')}:</p>
<p><strong>Aportaci&oacute;n:</strong> ${format_currency(nominal_amount,'EUR', locale='es_ES')}<br><strong>Referencia de la aportaci&oacute;n:</strong> ${investment_name or ''}<br><strong>Importe del retorno parcial:</strong> ${format_currency(amort_value,'EUR', locale='es_ES')}<br><strong>N&uacute;mero de pago: </strong>${num_amortization} de 24.</p>
<p>&nbsp;</p>
<p>Aprovecharemos para hacerlo todo en una misma operaci&oacute;n. Por lo tanto, quedar&aacute; de esta manera:</p>
<p dir="ltr"><strong>Retenci&oacute;n para Hacienda por el ahorro:</strong> ${format_currency(irpf_values['irpf_amount'],'EUR', locale='es_ES')}<br><strong>Retorno parcial del pr&eacute;stamo Generation kWh:</strong> ${format_currency(amort_value,'EUR', locale='es_ES')}&nbsp;</p>
% if object.type == "in_invoice":
<p dir="ltr"><strong><strong id="docs-internal-guid-9d67b90b-7fff-7f01-5c3b-2cd6c4e651ca">Pendiente de devolverte&nbsp;</strong>(${format_currency(amort_value,'EUR', locale='es_ES')} - ${format_currency(irpf_values['irpf_amount'],'EUR', locale='es_ES')}): ${format_currency(object.amount_total,'EUR', locale='es_ES')}.&nbsp;</strong></p>
<p dir="ltr">&nbsp;</p>
<p dir="ltr">En los pr&oacute;ximos d&iacute;as procederemos a hacer efectivo el pago del importe a la siguiente cuenta bancaria: ${bank_account}.</p>
% else:
<p><strong><strong id="docs-internal-guid-8017ceb8-7fff-a43b-779b-8e916dbb4e3d">Pendiente de devolver a Som Energia</strong> (${format_currency(irpf_values['irpf_amount'],'EUR', locale='es_ES')} - ${format_currency(amort_value,'EUR', locale='es_ES')}): ${format_currency(object.amount_total,'EUR', locale='es_ES')}.&nbsp;</strong></p>
<p>&nbsp;</p>
<p>En los pr&oacute;ximos d&iacute;as procederemos a hacer efectivo el cobro del importe a la siguiente cuenta bancaria: ${bank_account}.</p>
% endif
<p>Por favor, verifica que el n&uacute;mero de cuenta bancaria es correcto. Si no lo es, responde con la mayor brevedad posible este correo indicando en qu&eacute; cuenta quieres que hagamos la operaci&oacute;n.</p>
<p dir="ltr">Para cualquier duda o aclaraci&oacute;n, antes de responder a este correo, te recomendamos visitar <a href="https://es.support.somenergia.coop/category/595-generation-kwh">el apartado del Generation kWh</a> de nuestro Centro de Ayuda, donde est&aacute;n listadas las principales preguntas que nos han ido llegando.</p>
<p dir="ltr">Aprovechamos para agradecerte, una vez m&aacute;s, tu apoyo y tu implicaci&oacute;n con Som Energia. Conjuntamente tenemos m&aacute;s fuerza a la hora de trabajar por un modelo energ&eacute;tico 100% renovable, distribuido, justo y en manos de la ciudadan&iacute;a.</p>
<p dir="ltr">&nbsp;</p>
<p dir="ltr">Salud y buena energ&iacute;a,</p>
<p dir="ltr">&nbsp;</p>
<p>Som Energia, SCCL<br><a href="https://www.somenergia.coop">www.somenergia.coop</a></p>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<p><br>----------------------------------------------------------------------------------------------------<br><br></p>
% endif
% if object.partner_id.lang == "ca_ES":
<p><br>Hola, ${object.partner_id.name.split(',')[-1]},</p>
<p>El projecte Generation kWh, en el qual participes des del dia ${date}, et permet accedir a la tarifa Generation kWh. Com que aquesta tarifa no dep&egrave;n del mercat, sin&oacute; de la gesti&oacute; i manteniment de les nostres plantes, l'any passat va ser considerablement m&eacute;s econ&ograve;mica que la tarifa est&agrave;ndard, que va patir la pujada dels preus de l'energia al mercat.</p>
<p>Aix&iacute; doncs, i tot i que <a href="https://ca.support.somenergia.coop/article/587-aportacio-generation-estalvi">no &eacute;s l&rsquo;objectiu</a> del projecte Generation kWh, gr&agrave;cies a la teva participaci&oacute;, el ${previous_year} et vas <strong>estalviar</strong> ${format_currency(irpf_values['irpf_saving'],'EUR', locale='es_ES')}.&nbsp;Aquest estalvi, que la llei considera guany en esp&egrave;cie, s&rsquo;ha de declarar a Hisenda i pagar la corresponent <strong>retenci&oacute;</strong> de l&rsquo;IRPF, en cas de persones f&iacute;siques, i de l&rsquo;impost de societats, en cas d&rsquo;empreses. En els dos casos aquesta retenci&oacute; &eacute;s del 19% sobre l&rsquo;estalvi obtingut. Des de Som Energia, i d'acord a les Condicions Generals del contracte d'adhesió al projecte Generation kWh, ja vam efectuar aquest pagament el mes de gener, per tant, en els pr&ograve;xims dies passarem a fer-te&rsquo;n la liquidaci&oacute; corresponent.</p>
<p>&nbsp;</p>
<p>D'altra banda, t'hem de fer el&nbsp;<strong>retorn parcial</strong> de l'aportaci&oacute; que vas fer al Generation kWh. En aquest cas, &eacute;s la liquidaci&oacute; n&uacute;mero ${num_amortization} de 24, i &eacute;s de ${format_currency(amort_value,'EUR', locale='ca_ES')}:</p>
<p><strong>Aportaci&oacute;:</strong> ${format_currency(nominal_amount,'EUR', locale='ca_ES')}<br><strong>Refer&egrave;ncia de l'aportaci&oacute;: </strong>${investment_name or ''}<br><strong>Import del retorn parcial:</strong> ${format_currency(amort_value,'EUR', locale='ca_ES')}<br><strong>N&uacute;mero de pagament: </strong>${num_amortization} de 24.</p>
<p>&nbsp;</p>
<p>Aprofitarem per fer-ho tot en una mateixa operaci&oacute;. Per tant, quedar&agrave; d&rsquo;aquesta manera:</p>
<p><strong>Retenci&oacute; per a Hisenda per l'estalvi:</strong> ${format_currency(irpf_values['irpf_amount'],'EUR', locale='ca_ES')}<br><strong>Retorn parcial del pr&eacute;stec Generation kWh: </strong>${format_currency(amort_value,'EUR', locale='ca_ES')}</p>
% if object.type == "in_invoice":
<p dir="ltr"><strong><strong id="docs-internal-guid-9d67b90b-7fff-7f01-5c3b-2cd6c4e651ca"><strong id="docs-internal-guid-6db616c4-7fff-d322-d19b-49802294163c">Pendent de retornar-te</strong> </strong>(${format_currency(amort_value,'EUR', locale='es_ES')} - ${format_currency(irpf_values['irpf_amount'],'EUR', locale='es_ES')}): ${format_currency(object.amount_total,'EUR', locale='es_ES')}.&nbsp;</strong></p>
<p dir="ltr">&nbsp;</p>
<p dir="ltr">En els propers dies procedirem a fer efectiu el pagament de l&rsquo;import al compte bancari seg&uuml;ent: ${bank_account}.</p>
% else:
<p><strong>Pendent de retornar a Som Energia&nbsp;(${format_currency(irpf_values['irpf_amount'],'EUR', locale='es_ES')} - ${format_currency(amort_value,'EUR', locale='es_ES')}): ${format_currency(object.amount_total,'EUR', locale='es_ES')}.&nbsp;</strong></p>
<p>&nbsp;</p>
<p>En els propers dies procedirem a fer efectiu el cobrament de l&rsquo;import al compte bancari seg&uuml;ent: ${bank_account}.</p>
% endif
<p dir="ltr">Si us plau, <strong>verifica que el n&uacute;mero de compte bancari &eacute;s correcte</strong>. Si no ho &eacute;s, respon al m&eacute;s aviat possible aquest correu indicant en quin compte vols que fem l&rsquo;operaci&oacute;.</p>
<p dir="ltr">Per a qualsevol dubte o aclariment, abans de respondre aquest correu, et recomanem visitar <a href="https://ca.support.somenergia.coop/category/580-generation-kwh">l&rsquo;apartat del Generation kWh</a> del nostre Centre d&rsquo;Ajuda, on hi ha llistades les principals preguntes que ens han anat arribant.</p>
<p dir="ltr">Aprofitem per agrair-te, una vegada m&eacute;s, el teu suport i implicaci&oacute; amb Som Energia. Conjuntament tenim m&eacute;s for&ccedil;a a l&rsquo;hora de treballar per un model energ&egrave;tic 100% renovable, distribu&iuml;t, just i en mans de la ciutadania.</p>
<p dir="ltr">&nbsp;</p>
<p dir="ltr">Salut i bona energia,</p>
<p dir="ltr">&nbsp;</p>
<p dir="ltr">Som Energia.</p>
<p dir="ltr"><a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ0zr-2BDJKbwOfu4-2Bz9vzCUm2Y2-2BZtOmBDzJmVgy6-2BaBwvtE-Sc_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WarvZHNGJ83OumvxPwFYGS2A5XdMPsZj-2F0rH59cywyKNs3-2FjrwYs-2FcMamy-2F7O7fWg-2BtDSX3kuEJj4YWosMLyowg4sOjqlmw3GUxDASn9hA1QxwVnArFDUiEiSKn7wME9PYdDwIX-2FASv4W5xulqjTKsQ2KkL-2FHHgIfk0iBncmog161XmbLAwdUz45UDvWghEaJ">www.somenergia.coop</a></p>
% endif
<p>&nbsp;</p>
<p>${text_legal}</p>
</body>
</html>