<!doctype html>
<html><body>
<img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"
<%
partner_bank = object.invoice_id.partner_bank.iban
iban = ' '.join(partner_bank[i:i+4] for i in xrange(0,len(partner_bank),4))
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
<br />
% if object.invoice_id.partner_id.lang != "es_ES":
<br />
Benvolgut/da,<br/>
<br />
T'adjuntem la liquidació d'interessos del període 01/07/2021 - 30/06/2022 de la teva aportació voluntària al capital social de SOM ENERGIA SCCL.<br/>
<br />
L'import d'aquesta liquidació et serà transferit a finals de mes.<br />
<br />
Verifica que el número de compte bancari d'abonament sigui el correcte i sinó escriu-nos urgentment en aquest mateix correu.<br />
<br />
<u>Resum de la liquidació</u><br />
Número liquidació: ${object.invoice_id.number or ''}<br />
Titular: ${object.invoice_id.partner_id.name}<br />
Període del ${object.invoice_id.invoice_line[0].name.split(' ')[3]} al ${object.invoice_id.invoice_line[0].name.split(' ')[6]}<br />
<strong>Import total: ${object.invoice_id.amount_total}€</strong><br />
<br />
Núm. IBAN: ${iban}<br />
<br />
Aprofitem per agrair-te una vegada més la teva implicació amb el nostre projecte.<br />
<br />
Atentament,<br />
<br />
Equip Som Energia<br />
aporta@somenergia.coop<br />
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br />
<br />
% endif
% if object.invoice_id.partner_id.lang != "ca_ES" and object.invoice_id.partner_id.lang != "es_ES":
<br />----------------------------------------------------------------------------------------------------<br />
% endif
% if object.invoice_id.partner_id.lang != "ca_ES":
<br />
Saludos,<br />
<br />
Te enviamos la liquidación de intereses del periodo 01/07/2021 - 30/06/2022 de tu aportación voluntaria al capital social de SOM ENERGIA SCCL<br />
<br />
El importe de esta liquidación será transferido a tu cuenta bancaria a finales de mes.<br />
<br />
Verifica que la cuenta de abono sea la correcta y sino escríbenos urgentemente en este mismo correo.<br />
<br />
<u>Resumen de la liquidación</u><br />
Número liquidación: ${object.invoice_id.number or ''}<br />
Titular: ${object.invoice_id.partner_id.name}<br />
Período del ${object.invoice_id.invoice_line[0].name.split(' ')[3]} al ${object.invoice_id.invoice_line[0].name.split(' ')[6]}<br />
<strong>Importe total: ${object.invoice_id.amount_total}€</strong><br />
<br />
Núm. IBAN: ${iban}<br />
<br />
Aprovechamos para agradecerte una vez más tu implicación con nuestro proyecto.<br />
<br />
Atentamente,<br />
<br />
Equipo de Som Energia<br />
aporta@somenergia.coop<br />
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br />
<br />
% endif
${text_legal}
</body>
