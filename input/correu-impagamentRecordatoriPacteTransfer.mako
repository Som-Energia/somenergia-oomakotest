<!doctype html>
<html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
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
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.polissa_id.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.polissa_id.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>
Hola${nom_pagador},<br/>
<br/>
% if object.invoice_id.partner_id.lang != "es_ES":
Tal i com havíem acordat, encara està pendent el pagament de la factura <b>${object.number}</b> amb import <b>${object.invoice_id.amount_total}€</b>.Esperem rebre la teva transferència durant els pròxims dies. Moltes gràcies.<br/>
<br/>
Et recordem el número de compte de Som Energia:<br/>
<br/>
<B>ES82 1491 0001 29 2027098223</B><br/>
<br/>
Per a qualsevol dubte o incidència, t’agrairem que et posis en contacte.<br/>
<br/>
Salutacions,<br/>
<br/>
Equip de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<br/>----------------------------------------------------------------------------------------------------<br/>
% endif
% if object.partner_id.lang != "ca_ES":
Tal como habíamos acordado, aun está pendiente el pago de la factura <b>${object.number}</b> de importe <b>${object.invoice_id.amount_total}€</b>. Esperamos recibir tu transferencia durante los próximos días. Muchas gracias.<br/>
<br/>
Te recordamos el número de cuenta de Som Energia:<br/>
<br/>
<B>ES82 1491 0001 29 2027098223</B><br/>
<br/>
Para cualquier duda o incidencia, agradeceremos que te pongas en contacto.<br/>
<br/>
Un saludo,<br/>
<br/>
Equipo de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
</body>
</html>
