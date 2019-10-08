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

from datetime import datetime

try:
  fact_obj = object.pool.get('giscedata.facturacio.factura')

  normal_fact_ids = fact_obj.search(object._cr, object._uid,[('polissa_id','=', object.id),('state','=','draft'),('type','=','out_invoice')])
  normal_num_factures = len(normal_fact_ids)


  ab_fact_ids = fact_obj.search(object._cr, object._uid,[('polissa_id','=', object.id),('state','=','draft'),('type','=','out_refund')])
  ab_num_factures = len(ab_fact_ids)

  normal_fact_reads = fact_obj.read(object._cr, object._uid, normal_fact_ids,['amount_total','data_inici','data_final'])
  ab_fact_reads = fact_obj.read(object._cr, object._uid, ab_fact_ids,['amount_total','data_inici','data_final'])
  ab_data_inici = '2100-01-01'
  ab_data_final = '1900-01-01'
  ab_amount = 0.0
  for ab_fact_read in ab_fact_reads:
    if ab_fact_read['data_inici'] < ab_data_inici:
      ab_data_inici = ab_fact_read['data_inici']
    if ab_fact_read['data_final'] > ab_data_final:
      ab_data_final = ab_fact_read['data_final']
    ab_amount += ab_fact_read['amount_total']
  normal_data_final = '1900-01-01'
  normal_amount = 0.0
  for normal_fact_read in normal_fact_reads:
    if normal_fact_read['data_final'] > normal_data_final:
      normal_data_final = normal_fact_read['data_final']
    normal_amount += normal_fact_read['amount_total']
  diff_amount = abs(normal_amount - ab_amount)
  from datetime import datetime
  ab_data_inici_dt = datetime.strptime(ab_data_inici,'%Y-%m-%d')
  ab_data_inici = ab_data_inici_dt.strftime('%d/%m/%Y')
  ab_data_final_dt = datetime.strptime(ab_data_final,'%Y-%m-%d')
  ab_data_final = ab_data_final_dt.strftime('%d/%m/%Y')
  normal_data_final_dt = datetime.strptime(normal_data_final,'%Y-%m-%d')
  normal_data_final = normal_data_final_dt.strftime('%d/%m/%Y')
  total_factures = ab_num_factures + normal_num_factures

except:
  ab_num_factures = "----"
  normal_num_factures = "----"
  ab_data_inici = "----"
  ab_data_final = "----"
  normal_data_final = "----"
  ab_amount = "----"
  normal_amount = "----"
  diff_amount = "----"

%>
<br>
Hola${nom_pagador},<br>
<br>
% if object.titular.lang != "es_ES":
Ens posem en contacte amb tu perquè hem revisat el teu contracte i hem detectat que la facturació ha estat aturada durant els últims mesos.<br>
<br>
Ho hem solucionat i hem emès les factures dels últims mesos, que sumen ${diff_amount} €.<br>
<br>
Durant els pròxims dies sol·licitarem el cobrament domiciliat d’aquestes factures i d’aquesta manera la situació quedarà regularitzada. Si prefereixes efectuar el pagament de forma esglaonada (en terminis), si us plau, respon aquest correu tan aviat com sigui possible i fes-nos-ho saber.<br>
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
Nos ponemos en contacto contigo porque hemos revisado tu contrato y hemos detectado que la facturación ha estado parada durante los últimos meses.<br>
<br>
Lo hemos solucionado y hemos emitido las facturas de los últimos meses, que suman ${diff_amount} €.<br>
<br>
Durante los próximos días solicitaremos el cobro domiciliado de estas facturas de forma agrupada en un solo cargo y de esta manera la situación quedará regularizada. Si prefieres efectuar el pago de forma escalonada (en plazos), por favor, responde este correo con la mayor brevedad posible solicitándolo.<br>
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
