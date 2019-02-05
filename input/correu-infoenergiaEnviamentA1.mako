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
Amb l’estiu et fem arribar un informe energètic diferent! Un document pensat per conèixer millor la influència d’aquesta estació sobre el teu ús elèctric. <br>
<br>
Durant l’any tenim previst fer-ne dos, d’informes amb aquesta orientació estacional, un per a l’època estival i l’altre per a l’hivernal. Hi analitzarem quina relació hi ha entre l’ús elèctric i una determinada estació de l’any (el que s’anomena <b>dependència climàtica</b>). D’aquesta manera, pots ser més conscient d’aquesta situació i plantejar-te com actuar en conseqüència.<br>
<br>
Ara, doncs, si es detecta que l’estiu provoca un augment del teu ús, mirem d’orientar-te amb alguns consells bàsics a tenir en compte per estalviar energia.<br>
<br>
${env['user']._context.get('body_personal')}.<br>
<br>
En aquest informe mostrem l’ús que vas fer durant l’estiu passat, els dies entre setmana i els del cap de setmana, per tal de convidar-te a la reflexió, a més d’un recordatori de com reduir els usos permanents (stand-by).<br>
<br>
Qualsevol comentari, observació o suggeriment, ens els pots fer arribar responent a aquest mateix correu.<br>
<br>
Bona Energia!<br>
<br>
Equip de Som Energia<br>
infoenergia@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
<br>
% endif
% if  object.pagador.lang  != "ca_ES":
<br>
Hola ${object.direccio_pagament.name.split(',')[-1]}, <br>
<br>
¡Con el verano te enviamos un informe energético diferente! Un documento pensado para conocer mejor la influencia del verano sobre tu uso eléctrico.<br>
<br>
Durante el año tenemos previsto hacer dos informes con esta orientación estacional, uno para la época estival y el otro para la invernal. En estos informes analizaremos qué relación existe entre el uso eléctrico y la estación del año correspondiente (lo que se denomina <b>dependencia climática</b>).De esta manera puedes ser más consciente de esta situación y plantearte cómo actuar en consecuencia.<br>
<br>
A partir de ahí, si se detecta que el verano provoca un aumento en tu uso, trataremos de orientarte con algunos consejos básicos a tener en cuenta para ahorrar energía.<br>
<br>
${env['user']._context.get('body_personal')}.<br>
<br>
En el informe también mostramos el uso de los días entre semana y los del fin de semana, para invitarte a la reflexión, además de un recordatorio de cómo reducir los usos permanentes (stand-by).<br>
<br>
Cualquier comentario, observación o sugerencia nos los puedes hacer llegar respondiendo a este mismo correo.<br>
<br>
¡Buena Energía!<br>
<br>
Equipo de Som Energia<br>
infoenergia@somenergia.coop<br>
<a href="www.somenergia.coop/es">www.somenergia.coop</a>
<br>
% endif
${text_legal}
</body>
</html>
