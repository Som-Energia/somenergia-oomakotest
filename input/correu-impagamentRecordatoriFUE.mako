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
Hola,<br />
<br />
% if object.invoice_id.partner_id.lang != "es_ES":
Aquest correu electrònic és per recordar-te, en nom i representació de Som Energia, SCCL, i per tal d’interrompre el termini de prescripció, que queden per pagar les factures següents ${object.number} a favor de Som Energia. Et reiterem que, per tal de procedir al pagament, et pots posar en contacte amb <a href="mailto:cobraments@somenergia.coop">cobraments@somenergia.coop</a>.<br />
<br />
Cordialment,<br />
<br />
Equip de Som Energia<br />
cobraments@somenergia.coop<br />
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br />
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<br />----------------------------------------------------------------------------------------------------<br />
% endif
% if object.partner_id.lang != "ca_ES":
Este correo electrónico es para recordarte, en nombre y representación de Som Energia, SCCL, y al objeto de interrumpir el plazo de prescripción, que quedan por pagar las siguientes facturas ${object.number} a favor de Som Energia. Te reiteramos que, para proceder al pago, te puedes poner en contacto con <a href="mailto:cobros@somenergia.coop">cobros@somenergia.coop</a><br />
<br />
Cordialmente,<br />
<br />
Equipo de Som Energia<br />
cobraments@somenergia.coop<br />
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br />
% endif
<br />
${text_legal}
</body>
</html>
