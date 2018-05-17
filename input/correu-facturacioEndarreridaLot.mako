<!doctype html>
<html>
% if object.polissa_id.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia núm. ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.polissa_id.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.polissa_id.distribuidora.name}</font></td></tr></table></head><body>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.polissa_id.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.polissa_id.distribuidora.name}</font></td></tr></table></head><body>
% endif
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.polissa_id.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.polissa_id.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''

from datetime import datetime
last_invoiced_date = datetime.strptime(object.polissa_id.data_ultima_lectura or object.polissa_id.data_alta, '%Y-%m-%d')
last_invoiced_date_formatted = last_invoiced_date.strftime('%d/%m/%Y')
%>
Hola${nom_pagador},

% if object.polissa_id.titular.lang != "es_ES":
T’escrivim en relació a la facturació del teu contracte ${object.polissa_id.name} amb Som Energia. A causa d’una incidència informàtica, la facturació va quedar encallada fa uns mesos.

Et demanem disculpes i ara solucionem la causa d’aquest bloqueig.

En els propers 2-3 dies rebràs les factures que posen al dia la facturació. Et preguem que esperes a rebre-les totes per a revisar-les.

Com que se t’han ajuntat vàries factures, pots demanar un fraccionament del cobrament, responent aquest correu abans de 10 dies.

Et recordem que a partir d’ara, donat que ja hem solucionat el problema, rebràs les factures mensualment com és el nostre procediment habitual.

Recorda que, una vegada actualitzada la facturació, també podràs consultar les factures a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b>.

Salutacions,

Equip de Som Energia
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre d'Ajuda</a>
factura@somenergia.coop
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if  object.polissa_id.titular.lang != "ca_ES" and  object.polissa_id.pagador.lang != "es_ES":

% endif
% if  object.polissa_id.titular.lang != "ca_ES":
Te escribimos en relación a tu contrato ${object.polissa_id.name} con Som Energia. Debido a una incidencia informática, la facturación quedó bloqueada desde hace unos meses.

Te pedimos disculpas y ahora solucionamos la causa de este bloqueo.

En los próximos 2-3 días recibirás las facturas que ponen al día la facturación. Te pedimos que esperes a recibirlas todas para revisarlas.

Como se te habrán juntado varias facturas, puedes solicitar un fraccionamiento del pago, respondiendo a este correo antes de 10 días.

Te recordamos que a partir de ahora, dado que ya hemos solucionado el problema, recibirás las facturas mensualmente, como es nuestro procedimiento habitual.

Recuerda que, una vez actualizada la facturacióm, también podrás consultar las facturas en la <b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b>.

Un saludo,

Equipo de Som Energia
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a>
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
