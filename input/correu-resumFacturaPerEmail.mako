<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia núm. ${object.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
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
  abonar = True
  if normal_amount > ab_amount:
    abonar = False
  from datetime import datetime
  ab_data_inici_dt = datetime.strptime(ab_data_inici,'%Y-%m-%d')
  ab_data_inici = ab_data_inici_dt.strftime('%d/%m/%Y')
  ab_data_final_dt = datetime.strptime(ab_data_final,'%Y-%m-%d')
  ab_data_final = ab_data_final_dt.strftime('%d/%m/%Y')
  normal_data_final_dt = datetime.strptime(normal_data_final,'%Y-%m-%d')
  normal_data_final = normal_data_final_dt.strftime('%d/%m/%Y')

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
% if object.titular.lang != "es_ES":
Benvolgut/da ${nom_pagador},

Hem rectificat les últimes factures del teu contracte degut a modificacions a les lectures reals del teu comptador

S'han realitzat les següents tasques:

- Hem anul·lat ${ab_num_factures} factures, que van des del ${ab_data_inici} fins al ${ab_data_final}. El seu import suma ${ab_amount} €.
- Hem emès ${normal_num_factures} factures noves fins al ${normal_data_final}, amb les que regularitzem la facturació. L'import total de les noves factures és de ${normal_amount} €.

% if abonar:
El resultat final d'aquesta rectificació és una diferència de ${diff_amount} €, que ingressarem al teu compte properament.
% else:
El resultat final d'aquesta rectificació és una diferència de ${diff_amount} €, que girarem al teu compte properament.
% endif

Atentament,

${object.comercialitzadora.name}
% endif
% if object.titular.lang != "ca_ES":
Estimado/da ${nom_pagador},

Hemos rectificado las últimas facturas de tu contrato debido a modificaciones en las lecturas reales de tu contador

Se han realizado las siguientes tareas:

- Hemos anulado ${ab_num_factures} facturas, que van desde el ${ab_data_inici} hasta el ${ab_data_final}. Su importe suma ${ab_amount} €.
- Hemos emitido ${normal_num_factures} factures nueves hasta el ${normal_data_final}, con las que regularizamos la facturación. El importe total de las nuevas facturas es de ${normal_amount} €.

% if abonar:
El resultado final de esta rectificación es una diferencia de ${diff_amount} €, que ingresaremos en su cuenta próximamente.
% else:
El resultado final de esta rectificación es una diferencia de ${diff_amount} €, que giraremos en su cuenta próximamente.
% endif

Atentamente,

${object.comercialitzadora.name}
% endif
${text_legal}
</body>
</html>
