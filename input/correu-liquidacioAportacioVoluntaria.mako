<%
from babel.numbers import format_currency
partner_id = object.partner_id.id
partner_obj = object.pool.get('res.partner')
data = partner_obj.report_liquidacions_unificat_data(object._cr, object._uid, partner_id)
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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>

${plantilla_header}
% if object.partner_id.lang != "es_ES":
<p><br>Benvolgut/da,<br>
<br>Com cada juliol, t'informem de la liquidació anual d'interessos de les teves aportacions voluntàries al capital social de Som Energia. En aquest cas, fan referència al període entre l'01/07/${str(data['year'])} i el 30/06/${str(data['year']+1)}, i són de ${format_currency(data['total_amount_untaxed'], 'EUR', locale='es_ES')} abans d'impostos.<br>
<br>Farem les transferències de les liquidacions al llarg del mes de juliol.<br>
<br>Verifica que el número de compte bancari d'abonament sigui el correcte i, si no ho és, escriu-nos urgentment responent aquest mateix correu.<br>
<br></p>
%for number, invoice in data['invoices'].iteritems():
<% casted_iban = invoice['partner_iban'][-4:].rjust(len(invoice['partner_iban']), '*')%>
<p>Número liquidació: ${invoice['number'] or ''}<br>Titular: ${data['partner_name']}<br>Període del ${invoice['lines'][0]['date_ini']} al ${invoice['lines'][0]['date_end']}<br>Import de l'aportació voluntària: ${format_currency(invoice['lines'][0]['quantity'], 'EUR', locale='es_ES')}<br>Tipus d'interès: 2,00 %<br>Interessos generats: ${format_currency(invoice['amount_untaxed'], 'EUR', locale='es_ES')}<br>Núm. IBAN: ${casted_iban}<br>
<br></p>
%endfor
<p>T'agraïm un cop més la teva confiança en Som Energia. Entre totes i tots ho fem possible!<br>
<br>Salutacions cordials,<br>
<br>Equip Som Energia<br>aporta@somenergia.coop<br><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
<br></p>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<p><br>----------------------------------------------------------------------------------------------------</p>
% endif
% if object.partner_id.lang != "ca_ES":
<p><br>Hola,</p>
<p>Como cada mes de Julio, te informamos de la liquidación anual de intereses de tus aportaciones voluntarias al capital social de Som Energia. En este caso hacen referencia al periodo entre el 01/07/${str(data['year'])} hasta el 30/06/${str(data['year']+1)}, y son de ${format_currency(data['total_amount_untaxed'], 'EUR', locale='es_ES')} antes de impuestos.<br>
<br>Haremos las transferencias de las liquidaciones durante el mes de Julio.<br>
<br>Verifica que el número de cuenta bancario donde se abonarán los intereses sea correcto, si no lo es, responde este correo con la nueva cuenta.<br>
<br></p>
%for number, invoice in data['invoices'].iteritems():
<% casted_iban = invoice['partner_iban'][-4:].rjust(len(invoice['partner_iban']), '*')%>
<p>Número liquidación: ${invoice['number'] or ''}<br>Titular: ${data['partner_name']}<br>Periodo del ${invoice['lines'][0]['date_ini']} al ${invoice['lines'][0]['date_end']}<br>Importe de la aportación voluntaria: ${format_currency(invoice['lines'][0]['quantity'], 'EUR', locale='es_ES')}<br>Tipo de interés: 2,00 %<br>Intereses generados: ${format_currency(invoice['amount_untaxed'], 'EUR', locale='es_ES')}<br>Núm. IBAN: ${casted_iban}<br>
<br></p>
%endfor
<p>Te agradecemos una vez más tu confianza en Som Energia. ¡Entre todas y todos lo hacemos posible!<br>
<br>Saludos,<br>
<br>Equipo de Som Energia<br>aporta@somenergia.coop<br><a href="https://www.somenergia.coop">www.somenergia.coop</a><br>
<br></p>
% endif
${plantilla_footer}
