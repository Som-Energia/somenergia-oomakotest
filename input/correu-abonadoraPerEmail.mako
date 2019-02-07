<!doctype html><html><head><meta charset='utf8'></head><body>
<table width="100%" frame="below" BGCOLOR="#F2F2F2">
% if object.invoice_id.partner_id.lang == "ca_ES":
<tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td>
<td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr>
<tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr>
% else:
<tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td>
<td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr>
<tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr>
% endif
</table>
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

% if object.invoice_id.partner_id.lang != "es_ES":
Benvolgut/da ${object.polissa_id.direccio_pagament.name},<br>
<br>
Li abonem una factura anterior <B>${object.ref.number}</B> que compren el període de <B>${object.data_inici.replace('-', '/')}</B> al <B>${object.data_final.replace('-', '/')}</B> és de <B> ${object.invoice_id.amount_total}€</B>.<br>
<br>
Si us plau, trobi adjunta la factura en format PDF.<br>
<br>
Atentament,<br>
<br>
${object.invoice_id.company_id.name}<br>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
Estimado/da ${object.polissa_id.direccio_pagament.name},<br>
<br>
Le abonamos una factura anterior <B>${object.ref.number}</B> que comprende el período desde <B>${object.data_inici.replace('-', '/')}</B> a <B>${object.data_final.replace('-', '/')}</B> es de <B> ${object.invoice_id.amount_total}€</B>.<br>
<br>
Por favor, encuentre adjunta la factura en formato PDF.<br>
<br>
Atentamente,<br>
<br>
${object.invoice_id.company_id.name}<br>
% endif
${text_legal}
</body>
</html>