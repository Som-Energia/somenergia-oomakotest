<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
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

  normal_data_final = '1900-01-01'
  normal_amount = 0.0
  for normal_fact_read in normal_fact_reads:
    if normal_fact_read['data_final'] > normal_data_final:
      normal_data_final = normal_fact_read['data_final']
    normal_amount += normal_fact_read['amount_total']
    add_to_due_dates(normal_fact_read['date_due'],normal_fact_read['amount_total'])

  diff_amount = abs(normal_amount - ab_amount)

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

  if last_date:
    last_date_dt = datetime.strptime(last_date,'%Y-%m-%d')
    today_date_dt = datetime.strptime(today,'%Y-%m-%d')
    payment_moths = (last_date_dt.year - today_date_dt.year) *12 + last_date_dt.month - today_date_dt.month + 1
  else:
    payment_moths = 0
except excetion as e:
  print e
  ab_num_factures = "----"
  ab_data_inici = "----"
  ab_data_final = "----"
  ab_amount = "----"
  normal_num_factures = "----"
  normal_data_final = "----"
  normal_amount = "----"
  diff_amount = "----"
  due_date_list = []
  payment_moths = 0
%>
<br>
Hola${nom_pagador},<br>
<br>
% if object.titular.lang != "es_ES":
Ens posem en contacte amb tu perquè hem revisat el teu contracte i hem detectat un error en la facturació a causa de XXXXXXX,<br>
<br>
Si fa més de dos mesos que no reps cap factura nostra, aprofitem aquests moviments per posar la facturació al dia fins l’última lectura que es consta a la nostra base de dades.<br>
<br>
Per posar en ordre la situació hem fet el següent:<br>
<br>
- Hem anul·lat ${ab_num_factures} factures, que van des del ${ab_data_inici} fins al ${ab_data_final}. El seu import suma ${ab_amount} €.<br>
- Hem emès ${normal_num_factures} factures noves que corresponen al consum realitzat fins el ${normal_data_final}, amb què regularitzem la facturació. L'import total de les noves factures és de ${normal_amount} €.<br>
<br>
En resum, el resultat final d'aquesta rectificació és una diferència de ${diff_amount} €.<br>
<br>
Entenent que es tracta d'un import elevat, et proposem efectuar el pagament de manera esglaonada durant aquests propers ${payment_moths} mesos. La proposta quedaria així:<br>
<br>
% for date_due,amount in due_date_list:
- ${date_due}: cobrament de ${amount} €<br>
% endfor
<br>
En el cas que prefereixis regularitzar la situació en un sol pagament, o que vulguis unes dates de cobrament diferents, només ens has de respondre aquest mateix correu amb la teva petició.<br>
<br>
Tingues present que a partir del primer cobrament, els següents s’ajuntaran amb els de la factura del mes vigent. D’ara en endavant confiem en emetre les factures cada mes i sense més incidències.<br>
<br>
A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> podràs consultar totes les factures que s'han generat.<br>
<br>
Disculpa les molèsties ocasionades i seguim en contacte per aquesta o qualsevol altra qüestió.<br>
<br>
Salutacions,<br>
<br>
Equip de Som Energia<br>
factura@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":
Nos ponemos en contacto contigo porque hemos revisado tu contrato y hemos detectado un error en la facturación a causa de XXXXXXXXX.<br>
<br>
Si hace más de dos meses que no recibes ninguna factura de Som Energia, aprovechamos estos movimientos para poner la facturación al día hasta la última lectura que nos consta en nuestra base de datos.<br>
<br>
Para poner en orden la situación hemos hecho lo siguiente:<br>
<br>
- Hemos anulado ${ab_num_factures} facturas, que van desde el ${ab_data_inici} hasta el ${ab_data_final}. Su importe suma ${ab_amount} €.<br>
- Hemos emitido ${normal_num_factures} facturas nuevas que corresponden al consumo realizado hasta el ${normal_data_final}, con las que regularizamos la facturación. El importe total de las nuevas facturas es de ${normal_amount} €.<br>
<br>
En resumen, el resultado final de esta rectificación es una diferencia de ${diff_amount} €.<br>
<br>
Entendiendo que se trata de un importe elevado, te proponemos efectuar el pago de manera escalonada durante los próximos ${payment_moths} meses. La propuesta es la siguiente:<br>
<br>
% for date_due,amount in due_date_list:
- ${date_due}: cobro de ${amount} €<br>
% endfor
<br>
En el caso que prefieras regularizar la situación con un solo pago o en otras fechas, nos lo puedes comunicar respondiendo este mismo correo.<br>
<br>
Ten en cuenta que a partir del próximo mes estos cobros coincidirán con los de las facturas del mes vigente. De ahora en adelante esperamos poder emitirlas mensualmente y sin más incidencias.<br>
<br>
En la <a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> podrás consultar todas las facturas que se han generado.<br>
<br>
Disculpa las molestias y seguimos en contacto.<br>
<br>
Saludos,<br>
<br>
Equipo de Som Energia<br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop/">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
</html>