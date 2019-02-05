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
% if object.pagador.lang  == "ca_ES":
<br>
Hola ${object.direccio_pagament.name.split(',')[-1]},<br> 
<br> 
Ens plau reprendre el servei Infoenergia de la cooperativa!<br> 
<br> 
Després de les proves de finals d'any (potser ja vas rebre un informe) ara podem iniciar de nou el servei.<br>  
<br> 
En aquest correu doncs reps el primer informe dels 5 previstos per tot l’any.<br> 
<br> 
Aquest primer informe et mostrarà un resum de com has usat l’electricitat els últims 24 mesos (o del període del que en tenim dades), i t’ajudarà a valorar si ha estat un ús correcte o no, i quines mesures et convenen per a reduir el teu cost energètic i l'ús d’electricitat.<br> 
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
Hola ${object.direccio_pagament.name.split(',')[-1]},<br> 
<br> 
Nos complace reanudar el servicio Infoenergía de la cooperativa!<br> 
<br> 
Después de las pruebas de fin de año (tal vez ya recibiste un informe) ahora podemos iniciar de nuevo el servicio.<br> 
<br> 
En este correo recibes el primer informe de los 5 previstos para todo el año.<br> 
<br> 
Este primer informe te mostrará un resumen de cómo has usado la electricidad en los últimos 24 meses (o del período del que tengamos datos) y te ayudará a valorar si ha sido un uso correcto o no, y qué medidas te convienen para reducir tu coste energético y el uso de electricidad.<br> 
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
