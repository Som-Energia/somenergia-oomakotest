<!doctype html>
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
<html>
<body>
<br>
% if object.pagador.lang  == "ca_ES":
<br>
Hola ${object.direccio_pagament.name.split(',')[-1]}, <br>
<br>
Et fem arribar un nou informe del servei Infoenergia de la cooperativa!<br>
<br>
Aquest és el segon informe dels 5 previstos per aquest any 2018. Potser per tu és el primer que reps perquè anem incorporant contractes al servei quan tenim prou informació (mínim 6 mesos de dades consolidades).<br>
<br>
En aquest informe revisem com has fet servir l’energia aquest primer trimestre del 2018, també identifiquem quin és <a href="https://ca.support.somenergia.coop/article/755-com-reduir-els-usos-permanents-delectricitat">el teu ús permanent d’energia</a>, és a dir, l’standby de casa teva, i a quines hores fas els pics d’energia per tal de poder-los reduir.  <br>
<br>
A la part final de l’informe calculem l’impacte econòmic i energètic de les modificacions de contracte, si n’has sol·licitat alguna darrerament.<br>
<br>
${env['user']._context.get('body_personal')}.<br>
<br>
Amb aquest servei la cooperativa vol ajudar a les persones sòcies i clientes de Som Energia, a entendre millor el nostre ús elèctric i oferir informació que ens permeti prendre decisions per assolir un major nivell d'estalvi i eficiència energètica.<br>
<br>
Moltes gràcies per la teva confiança i qualsevol comentari, observació o suggeriment ens el pots fer arribar responent a aquest mateix correu.<br>
<br>
Bona Energia!<br>
<br>
% endif
% if  object.pagador.lang  != "ca_ES":
<br>
Hola ${object.direccio_pagament.name.split(',')[-1]}, <br>
<br>
El servicio de Infoenergia de la cooperativa nos trae un nuevo informe!<br>
<br>
Este es el segundo informe de los 5 previstos para este año 2018. Quizás para ti sea  primero que recibes porque vamos incorporando contratos a la "Rueda de Momentos” del servicio de Infoenergia, en el momento que tenemos suficientes datos (mínimo 6 meses de datos consolidados ).<br>
<br>
En este informe revisamos cómo has utilizado la energía este primer trimestre de 2018. También identificamos cuál es <b>tu uso permanente de energía</b>, es decir, el standby de tu casa y a qué horas generas los picos de uso de energía a fin de poder reducirlos.<br>
<br>
En la parte final del informe revisamos <b>el impacto de las modificaciones de contrato</b>, si has realizado alguna últimamente, tanto en términos de energía como económico.<br>
<br>
${env['user']._context.get('body_personal')}.<br>
<br>
Con este servicio la cooperativa quiere ayudar a las personas socias y clientes de Som Energia, a entender mejor nuestro uso eléctrico y ofrecer información que nos permita tomar decisiones para alcanzar un mayor nivel de ahorro y eficiencia energética.<br>
<br>
Muchas gracias por tu confianza y cualquier comentario, observación o sugerencia nos lo puedes hacer llegar respondiendo a este mismo correo.<br>
<br>
Buena Energía!<br>
<br>
% endif
${text_legal}
</body>
</html>
