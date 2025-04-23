<!doctype html>
<html>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"><br/>
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
Hola ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Volem informar-te que a data d'avui hem girat l’import ${int(abs(object.amount_total))} € corresponent a la teva participació a la Generació kWh i, per tant, en dos o tres dies (laborables) es passarà el càrrec al teu compte bancari.<br/>
<br/>
Et recordem que per a qualsevol dubte o aclariment en relació amb la teva aportació pots respondre aquest correu, escriure a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a> o consultar el <a href="https://ca.support.somenergia.coop/category/580-generation-kwh">centre d’ajuda</a> de la web.<br/>
<br/>
Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable! <br/>
<br/>
<br/>
Moltes gràcies i bona energia!<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a><br/>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if  object.partner_id.lang != "ca_ES":
<br/>
Hola ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Queremos informarte que a fecha de hoy hemos girado el importe de ${int(abs(object.amount_total))} € correspondiente a tu participación en la Generación kWh y, por tanto, en dos o tres días (laborables) se pasará el cargo a tu cuenta bancaria.<br/>
<br/>
Te recordamos que para cualquier duda o aclaración en relación a tu aportación puedes responder a este correo, escribir a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a> o consultar el <a href = "https://es.support.somenergia.coop/category/595-generation-kwh">centro de ayuda</a> de la web.<br/>
<br/>
Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de alcanzar un modelo energético 100% renovable.<br/>
<br/>
<br/>
¡Muchas gracias y buena energía!<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
</body>
</html>
