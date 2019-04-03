<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia núm. ${object.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
% endif
<body>
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

try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''

try:
  from datetime import datetime,date

  today = date.today().strftime('%Y-%m-%d')
  #today = '2019-01-01'

  condition = [('polissa_id','=', object.id),('state','in',['draft','open']),('date_invoice','>=',today)]
  fields = ['amount_total','data_inici','data_final','date_due']
  fact_obj = object.pool.get('giscedata.facturacio.factura')

  normal_fact_ids = fact_obj.search(object._cr, object._uid,condition+[('type','=','out_invoice')])
  normal_num_factures = len(normal_fact_ids)
  normal_fact_reads = fact_obj.read(object._cr, object._uid, normal_fact_ids,fields)

  ab_fact_ids = fact_obj.search(object._cr, object._uid,condition +[('type','=','out_refund')])
  ab_num_factures = len(ab_fact_ids)
  ab_fact_reads = fact_obj.read(object._cr, object._uid, ab_fact_ids,fields)

  due_dates = {}
  def add_to_due_dates(due_date,amount):
    if due_date not in due_dates:
      due_dates[due_date] = amount
    else:
      due_dates[due_date] += amount

  ab_data_inici = '2100-01-01'
  ab_data_final = '1900-01-01'
  ab_amount = 0.0
  for ab_fact_read in ab_fact_reads:
    if ab_fact_read['data_inici'] < ab_data_inici:
      ab_data_inici = ab_fact_read['data_inici']
    if ab_fact_read['data_final'] > ab_data_final:
      ab_data_final = ab_fact_read['data_final']
    ab_amount += ab_fact_read['amount_total']
    add_to_due_dates(ab_fact_read['date_due'],ab_fact_read['amount_total'] * (-1))

  normal_data_inici = '2100-01-01'
  normal_data_final = '1900-01-01'
  normal_amount = 0.0
  for normal_fact_read in normal_fact_reads:
    if normal_fact_read['data_inici'] < normal_data_inici:
      normal_data_inici = normal_fact_read['data_inici']
    if normal_fact_read['data_final'] > normal_data_final:
      normal_data_final = normal_fact_read['data_final']
    normal_amount += normal_fact_read['amount_total']
    add_to_due_dates(normal_fact_read['date_due'],normal_fact_read['amount_total'])

  diff_amount = normal_amount - ab_amount

  data_inici = min(ab_data_inici,normal_data_inici)
  data_final = min(ab_data_final,normal_data_final)
  if data_inici != '2100-01-01' and data_final != '1900-01-01':
    data_inici_dt = datetime.strptime(data_inici,'%Y-%m-%d')
    data_final_dt = datetime.strptime(data_final,'%Y-%m-%d')
    payment_moths = (data_final_dt.year - data_inici_dt.year) *12 + data_final_dt.month - data_inici_dt.month + 1
  else:
    payment_moths = 0

  def date_print(date):
      date_dt = datetime.strptime(date,'%Y-%m-%d')
      return date_dt.strftime('%d/%m/%Y')

  def amout_print(amount):
      return "{0:.2f}".format(amount).replace('.',',')

  ab_data_inici = date_print(ab_data_inici)
  ab_data_final = date_print(ab_data_final)
  normal_data_final = date_print(normal_data_final)
  ab_amount = amout_print(ab_amount)
  normal_amount = amout_print(normal_amount)
  diff_amount = amout_print(diff_amount)  

  due_date_list = []
  last_date = None
  for key in sorted(due_dates):
    if due_dates[key]:
      due_date_list.append((date_print(key),amout_print(due_dates[key])))
      last_date = key
except excetion as e:
  print e
  ab_num_factures = "----"
  normal_num_factures = "----"
  ab_data_inici = "----"
  ab_data_final = "----"
  normal_data_final = "----"
  ab_amount = "----"
  normal_amount = "----"
  diff_amount = "----"
  due_date_list = []
  payment_moths = 0
%>
<br>
Hola${nom_pagador},<br>
<br>
% if object.titular.lang != "es_ES":
Ens posem en contacte amb tu perquè hem revisat el teu contracte i hem detectat que la facturació ha estat aturada durant els últims mesos a causa de XXXXXXXXXXX.<br>
<br>
Ho hem solucionat i hem emès les factures dels ${payment_moths} últims mesos, que sumen ${diff_amount} €.<br>
<br>
Entenent que s’han ajuntat més d’una factura, et proposem efectuar el pagament de manera esglaonada durant aquests propers mesos. La proposta quedaria així:<br>
<br>
% for date_due,amount in due_date_list:
- ${date_due}: cobrament de ${amount} €<br>
% endfor
<br>
Tingues present que, a partir del mes vinent, aquests cobraments coincidiran amb els de les factures del mes vigent. D’ara endavant esperem poder emetre-les mensualment i sense més incidències.<br>
<br>
En el cas que prefereixis regularitzar la situació amb un sol pagament o bé en unes altres dates, ens ho pots comunicar responent aquest mateix correu.<br>
<br>
Pots consultar totes les factures emeses a la teva <b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b>.<br>
<br>
Moltes gràcies per la comprensió i disculpa les molèsties ocasionades.<br>
<br>
Salutacions,<br>
<br>
Equip de Som Energia<br>
<br>
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre d'Ajuda</a><br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":
Nos ponemos en contacto contigo porque hemos revisado tu contrato y hemos detectado que la facturación ha estado parada durante los últimos meses a causa de XXXXXXXXXXXXXXXXXX​​.<br>
<br>
Hemos solucionado la incidencia y hemos emitido las facturas de los ${payment_moths} últimos meses, que suman ${diff_amount} €.<br>
<br>
Entendiendo que se han juntado más de una factura, te proponemos efectuar el pago de manera escalonada durante los próximos meses. La propuesta es la siguiente:<br>
<br>
% for date_due,amount in due_date_list:
- ${date_due}: cobro de ${amount} €<br>
% endfor
<br>
Ten en cuenta que a partir del próximo mes estos cobros coincidirán con los de las facturas del mes vigente. De ahora en adelante esperamos poder emitirlas mensualmente y sin más incidencias.<br>
<br>
En el caso que prefieras regularizar la situación con un solo pago o en otras fechas, nos lo puedes comunicar respondiendo este mismo correo.<br>
<br>
Puedes consultar todas las facturas emitidas en tu <b><a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a></b>.<br>
<br>
Muchas gracias por tu comprensión y disculpa las molestias ocasionadas.<br>
<br>
Un saludo,<br>
<br>
Equipo de Som Energia<br>
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a><br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
