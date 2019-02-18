<!doctype html>
<html>
<head><meta charset="utf-8"/></head>
<body>
% if object.invoice_id.partner_id.lang == "ca_ES":
<table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table>
% else:
<table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table>
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
Hola${nom_pagador},<br/>
% if object.invoice_id.partner_id.lang != "es_ES":

<b>============PLANTILLA EN BLANC============</b>
<b>ESBORRA AQUEST MISSATGE I POSA-HI EL TEU TEXT</b>
<b>POTS UTILITZAR LES VARIABLES SEGÜENTS</b>
<br/>
factura ${object.number}<br/>
Adreça punt subministrament: ${object.cups_id.direccio}<br/>
Titular: ${object.polissa_id.titular.name}<br/>
Codi CUPS: ${object.cups_id.name}<br/>
Número de factura: ${object.number}<br/>
Data factura: ${object.invoice_id.date_invoice}<br/>
Període de lla factura: ${object.data_inici} al ${object.data_final}<br/>
Import de la factura: ${object.invoice_id.amount_total}€<br/>
<br/>
<b>RECORDA FER-HO TAMBÉ EN CASTELLÀ, ESTA MES ABAIX</b>
<b>============FINAL============</b>
<br/>
Salutacions,<br/>
<br/>
Equip de Som Energia<br/>
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre de Suport</a><br/>
factura@somenergia.coop<br/>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
<br/>
<b>============PLANTILLA EN BLANCO============</b>
<b>BORRA ESTE MENSAJE Y PON EL TUYO</b>
<b>PUEDES UTILIZAR LAS VARIABLES SIGUIENTES</b>
<br/>
factura ${object.number}<br/>
Dirección punto suministro: ${object.cups_id.direccio}<br/>
Titular: ${object.polissa_id.titular.name}<br/>
Código CUPS: ${object.cups_id.name}<br/>
Número factura: ${object.number}<br/>
Fecha factura: ${object.invoice_id.date_invoice}<br/>
Periodo de la factura:  ${object.data_inici} al  ${object.data_final}<br/>
Importe de la factura: ${object.invoice_id.amount_total}€<br/>
<br/>
<b>============FINAL============</b>

<br/>
Un saludo,<br/>
<br/>
Equipo de Som Energia<br/>
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a><br/>
factura@somenergia.coop<br/>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
</body>
</html>