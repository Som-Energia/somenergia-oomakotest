<!doctype html>
<html>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
<br/><br/>
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
% if object.partner_id.lang != "es_ES":
<br/>
Benvolgut/da ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Volem informar-te que a data d'avui hem girat l'import ${int(abs(object.amount_total))} € corresponent a la teva aportació voluntària al capital social de la cooperativa Som Energia SCCL i per tant, en dos o tres dies (laborables) es realitzarà el càrrec al teu compte. <br/>
<br/>
T'adjuntem les condicions de la teva aportació i et recordem que per a qualsevol dubte o aclariment en relació a l’aportació realitzada pots enviar una mail a <a href="mailto:aporta@somenergia.coop">aporta@somenergia.coop</a> o consultar el web <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a>. <br/>
<br/>
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
Queremos informarte que a fecha de hoy hemos girado el importe de ${int(abs(object.amount_total))} € correspondiente a tu aportación voluntaria al capital social de la cooperativa Som EnergiaSCCL y en dos o tres días (laborables) se realizará el cargo a tu cuenta.<br/>
<br/>
Adjuntamos el contrato con las condiciones de tu aportación y te recordamos que para cualquier duda o aclaración en relación a la aportación realizada puedes enviar una mail a <a href="mailto:aporta@somenergia.coop">aporta@somenergia.coop</a> o consultar la web <a href="https://www.somenergia.coop">www.somenergia.coop</a>. <br/>
<br/>
Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de lograr un modelo energético 100% renovable.<br/>
<br/>
¡Muchas gracias y buena energía!<br/>
<br/>
Atentamente,<br/>
<br/>
Equipo de Som Energia,<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
</body>
</html>