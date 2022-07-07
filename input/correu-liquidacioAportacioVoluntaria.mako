<!doctype html>
<html><body>
<img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"
<%
partner_bank = object.partner_bank.iban
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
% if object.partner_id.lang != "es_ES":
<br />
Hola,<br />
<br />
Com recordaràs, l'Assemblea General de l'any passat va aprovar que el període de liquidació d'interessos s'ajustés al nostre calendari cooperatiu i que enlloc de seguir l'any natural agafaríem el període comprès entre 01/07 i el 30/06 de l'any següent. Per tal d'ajustar-nos a aquest canvi, l'any passat, el mes de juliol, vàrem va fer una liquidació d'interessos de només 6 mesos (01/01/2021 a 30/06/2021). Preparant les liquidacions d'interessos pel període 01/07/2021 a 30/06/2022 ens hem adonat que a tu no t'haviem liquidat encara aquests 6 mesos. T'adjuntem la liquidació d'interessos de l'any 2018 corresponent a la teva aportació voluntària al capital social de SOM ENERGIA SCCL.<br />
<br />
T'adjuntem ara la liquidació, perdona per l'errada. Revisa si us plau que el número de compte bancari d'abonament sigui el correcte i, en cas que hi hagi algun error, escriu-nos urgentment a aquest mateix correu (aporta@somenergia.coop).<br />
<br />
Aquesta interessos seran transferits a partir del dia 15/07<br />
<br />
<u>Resum de la liquidació</u><br />
Número liquidació: ${object.number or ''}<br />
Titular: ${object.partner_id.name}<br />
Període del ${object.invoice_line[0].name.split(' ')[1]} al ${object.invoice_line[-1].name.split(' ')[3]}<br />
<strong>Import total: ${object.amount_total}€</strong><br />
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
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<br />----------------------------------------------------------------------------------------------------<br />
% endif
% if object.partner_id.lang != "ca_ES":
<br />
Hola,<br />
<br />
Como recordarás, la Asamblea General del año pasado aprobó que el periodo de liquidación de intereses se ajustara a nuestro calendario cooperativo y que en lugar de seguir el año natural tomaríamos de referencia el periodo comprendido entre el 01/07 y el 30/06 del año siguiente. Para ajustarnos a este cambio, el año pasado (en julio) hicimos una liquidación de intereses de sólo 6 meses (01/01/2021 a 30/06/2021). Ahora, preparando las liquidaciones de intereses del periodo 01/07/2021 a 30/06/2022 nos hemos percatado que a ti no te habíamos liquidado aún estos 6 meses.<br />
<br />
Te adjuntamos ahora la liquidación, perdona por el error. Revisa por favor que el número de cuenta bancaria sea el correcto y, en caso que haya algún error, escribenos urgentemente a este mismo correo (aporta@somenergia.coop).<br />
<br />
Estos intereses se transferirán a partir del día 15/07<br />
<br />
<u>Resumen de la liquidación</u><br />
Número liquidación:: ${object.number or ''}<br />
Titular: ${object.partner_id.name}<br />
Período del ${object.invoice_line[0].name.split(' ')[1]} al ${object.invoice_line[-1].name.split(' ')[3]}<br />
<strong>Importe total: ${object.amount_total}€</strong><br />
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
