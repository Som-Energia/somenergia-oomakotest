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
%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''

from datetime import datetime
last_invoiced_date = datetime.strptime(object.data_ultima_lectura or object.data_alta, '%Y-%m-%d')
last_invoiced_date_formatted = last_invoiced_date.strftime('%d/%m/%Y')
%>
<br>
Hola${nom_pagador},<br>
<br>
% if object.titular.lang != "es_ES":
T’escrivim en relació a la facturació del teu contracte ${object.name} amb Som Energia. A causa d’una incidència informàtica, la facturació va quedar encallada fa uns mesos.<br>
<br>
Et demanem disculpes i ara solucionem la causa d’aquest bloqueig.<br>
<br>
En els propers 2-3 dies rebràs les factures que posen al dia la facturació. <b>Et preguem que esperes a rebre-les totes per a revisar-les abans de respondre aquest correu.</b><br>
<br>
Com que se t’han ajuntat vàries factures, pots demanar un fraccionament del cobrament, responent aquest correu abans de 10 dies.<br>
<br>
Et recordem que a partir d’ara, donat que ja hem solucionat el problema, rebràs les factures mensualment com és el nostre procediment habitual.<br>
<br>
Recorda que, una vegada actualitzada la facturació, també podràs consultar les factures a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b>.<br>
<br>
Salutacions,<br>
<br>
Equip de Som Energia<br>
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre d'Ajuda</a><br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":

% endif
% if  object.titular.lang != "ca_ES":
Te escribimos en relación a tu contrato ${object.name} con Som Energia. Debido a una incidencia informática, la facturación quedó bloqueada desde hace unos meses.<br>
<br>
Te pedimos disculpas y ahora solucionamos la causa de este bloqueo.<br>
<br>
En los próximos 2-3 días recibirás las facturas que ponen al día la facturación. <b>Te pedimos que esperes a recibirlas todas para revisarlas antes de responder este correo. </b><br>
<br>
Como se te habrán juntado varias facturas, puedes solicitar un fraccionamiento del pago, respondiendo a este correo antes de 10 días.<br>
<br>
Te recordamos que a partir de ahora, dado que ya hemos solucionado el problema, recibirás las facturas mensualmente, como es nuestro procedimiento habitual.<br>
<br>
Recuerda que, una vez actualizada la facturacióm, también podrás consultar las facturas en la <b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b>.<br>
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
