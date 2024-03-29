<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
% endif
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
  normal_fact_ids = fact_obj.search(object._cr, object._uid,[('polissa_id','=', object.id),('state','=','open'),('type','=','out_invoice')])
  normal_num_factures = len(normal_fact_ids)
  ab_fact_ids = fact_obj.search(object._cr, object._uid,[('polissa_id','=', object.id),('state','=','open'),('type','=','out_refund')])
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
  diff_amount = normal_amount - ab_amount
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
<p>
 <br/>
</p>
<p>
 Hola${nom_pagador},
</p>
% if object.titular.lang != "es_ES":
<p>
 T'escrivim perquè hem revisat les últimes factures del teu contracte i hem detectat que han estat incorrectes a causa d'una estimació incorrecta.
</p>
<p>
 Si fa més de dos mesos que no rebies cap factura de Som Energia, aprofitem aquests moviments per posar la facturació al dia fins la darrera lectura que ens consta a la nostra base de dades.
 <br/>
</p>
<p>
 Per posar en ordre la situació hem fet el següent:
 <br/>
</p>
<ul>
 <li>
  Hem anul·lat ${ab_num_factures} factura/es, que van des del ${ab_data_inici} fins al ${ab_data_final}. El seu import suma ${ab_amount} €.
 </li>
 <li>
  Hem emès ${normal_num_factures} factura/es noves fins al ${normal_data_final}, amb què regularitzem la facturació. L'import total de les noves factures és de ${normal_amount} €.
 </li>
</ul>
<p>
 <br/>
</p>
<p>
 En resum, el resultat final d'aquesta rectificació és una diferència de ${diff_amount} €. La següent setmana, podràs veure els moviments en el teu compte bancari.
</p>
<p>
 En el cas que prefereixis efectuar el pagament de forma esglaonada (en terminis), et demanem que responguis aquest mateix correu al més aviat possible i ens ho demanis.
 <br/>
</p>
<p>
 <br/>
</p>
<p>
 Et recordem que a l'
 <a href="https://oficinavirtual.somenergia.coop/ca/login/">
  Oficina Virtual
 </a>
 podràs consultar totes les factures que s'han generat, per si les vols revisar.
</p>
<p>
 Moltes gràcies per la teva comprensió i disculpa les molèsties ocasionades. Seguim en contacte per a qualsevol dubte.
 <br/>
</p>
<p>
 Salutacions,
 <br/>
</p>
<p>
 <br/>
</p>
<p>
 Equip de Som Energia
</p>
<p>
 factura@somenergia.coop
</p>
<p>
 <a href="www.somenergia.coop/ca">
  www.somenergia.coop
 </a>
</p>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
<p>
 ----------------------------------------------------------------------------------------------------
</p>
% endif
% if  object.titular.lang != "ca_ES":
<p>
 Te escribimos porque hemos revisado las últimas facturas de tu contrato y hemos detectado que han sido incorrectas debido a una estimación incorrecta.
</p>
<p>
 Si hace más de dos meses que no recibes ninguna factura de Som Energia, aprovechamos estos movimientos para poner la facturación al día hasta la última lectura que nos consta en nuestra base de datos.
</p>
<p>
 Para poner en orden la situación hemos hecho lo siguiente:
</p>
<ul>
 <li>
  ​
  <span>
   Hemos anulado ${ab_num_factures} factura/as, que van desde el ${ab_data_inici} hasta el ${ab_data_final}. Su importe suma ${ab_amount} €.
  </span>
  ​
 </li>
 <li>
  <span>
   Hemos emitido ${normal_num_factures} factura/as nuevas hasta el ${normal_data_final}, con las que regularizamos la facturación. El importe total de las nuevas facturas es de ${normal_amount} €.
  </span>
 </li>
</ul>
<p>
 <br/>
</p>
<p>
 En resumen, el resultado final de esta rectificación es una diferencia de ${diff_amount} €. La siguiente semana podrás ver los movimientos en tu cuenta bancaria.
 <br/>
</p>
<p>
 En el caso que prefieras regularizar la situación con varios pagos o en otras fechas, nos lo puedes comunicar respondiendo este mismo correo.
 <br/>
</p>
<p>
 <br/>
</p>
<p>
 Te recordamos que en la
 <a href="https://oficinavirtual.somenergia.coop/ca/login/">
  Oficina Virtual
 </a>
 podrás consultar todas las facturas que se han generado, por si las quieres revisar.
</p>
<p>
 Muchas gracias por tu comprensión y disculpa las molestias ocasionadas. Seguimos en contacto para cualquier duda.
</p>
<p>
 Saludos,
</p>
<p>
 <br/>
</p>
<p>
 <br/>
</p>
<p>
 Equipo de Som Energia
</p>
<p>
 factura@somenergia.coop
</p>
<p>
 <a>
  www.somenergia.coop
 </a>
</p>
% endif
<p>
 ${text_legal}
</p>
