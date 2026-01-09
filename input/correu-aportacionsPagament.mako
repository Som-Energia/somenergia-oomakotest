
<%
from mako.template import Template

GenerationkwhInvestment = object.pool.get('generationkwh.investment')

investment_id = GenerationkwhInvestment.search(object._cr, object._uid, [('name', '=', object.origin)])
investment_data = GenerationkwhInvestment.read(object._cr, object._uid, investment_id[0], ['emission_id','member_id'])
emission_id = investment_data['emission_id'][0]
soci_id = investment_data['member_id'][0]
total_amount_in_emission = GenerationkwhInvestment.get_investments_amount(object._cr, object._uid, soci_id, emission_id=emission_id)
is_higher_20k = total_amount_in_emission > 20000

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
<br/>
Benvolgut/da ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Volem informar-te que a data d'avui hem girat l'import ${int(abs(object.amount_total))} € corresponent a la teva aportació voluntària al capital social de la cooperativa Som Energia SCCL i per tant, en dos o tres dies (laborables) es realitzarà el càrrec al teu compte. <br/>
<br/>
T'adjuntem les condicions de la teva aportació i et recordem que per a qualsevol dubte o aclariment en relació a l’aportació realitzada pots enviar una mail a <a href="mailto:aporta@somenergia.coop">aporta@somenergia.coop</a> o consultar el web <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a>. <br/>
<br/>
% if is_higher_20k:
Recordar-te que d’acord amb la nostra política de prevenció de blanqueig de capitals, a partir de 20.000 euros d’aportació en una sola emissió, és necessari verificar l'origen dels fons aportats a Som Energia. És per això que més endavant (d’aqui unes setmanes) t’enviarem un formulari d’identificació perquè ens el signis aixi com la sol.licitud d’una serie de documentació identificativa (DNI, escriptura constitució en cas de societats…)<br/>
<br/>
En cas que no ens puguèssis aportar aquesta informació, i d’acord amb aquesta política, hauriem de reemborsar-te l’import de la teva aportació.<br/>
<br/>
% endif
Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable!<br/>
<br/>
Moltes gràcies i bona energia!<br/>
<br/>
Atentament,<br/>
<br/>
Equip de Som Energia,<br/>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if  object.partner_id.lang != "ca_ES":
<br/>
Apreciado/a ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Queremos informarte que a fecha de hoy hemos girado el importe de ${int(abs(object.amount_total))} € correspondiente a tu aportación voluntaria al capital social de la cooperativa Som Energia SCCL y en dos o tres días (laborables) se realizará el cargo a tu cuenta.<br/>
<br/>
Adjuntamos el contrato con las condiciones de tu aportación y te recordamos que para cualquier duda o aclaración en relación a la aportación realizada puedes enviar una mail a <a href="mailto:aporta@somenergia.coop">aporta@somenergia.coop</a> o consultar la web <a href="https://www.somenergia.coop">www.somenergia.coop</a>. <br/>
<br/>
% if is_higher_20k:
Recordarte que de acuerdo con nuestra política de prevención de blanqueo de capitales, a partir de 20.000 euros de aportación por emisión, es necesario verificar el orígen de los fondos aportados a Som Energia. Es por eso que en unas semanas, te enviaremos un formulario de identificación para que nos firmes así como la solicitud de la documentación identificativa (DNI, escrituras constitución en caso de sociedades…)<br/>
<br/>
En caso de que no pudieras aportar esta información, y de acuerdo con nuestra política en materia de prevención del blanqueo de capitales, tendríamos que reembolsarte el importe de tu aportación.<br/>
<br/>
% endif
Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de lograr un modelo energético 100% renovable.<br/>
<br/>
¡Muchas gracias y buena energía!<br/>
<br/>
Atentamente,<br/>
<br/>
Equipo de Som Energia,<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
${plantilla_footer}