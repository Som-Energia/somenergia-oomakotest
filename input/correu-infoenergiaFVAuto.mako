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
% if object.titular.lang  == "ca_ES":
<br>
Hola ${object.titular.name.split(',')[-1]},<br>
<br>
Et fem arribar un informe sobre <b>quin potencial tens per fer autoproducció solar a casa teva</b>.<br>
<br>
Una de les fites que tenim a la cooperativa actualment és facilitar i impulsar l’autoproducció fotovoltaica entre les persones sòcies. Més enllà de produir energia renovable de manera col·lectiva, per assolir un model 100 % renovable i eficient també és necessari que s’incorpori la generació distribuïda a tots nivells, allà on sigui possible. I les nostres teulades són un lloc idoni per acostar la producció d’energia allà on s’utilitza.<br>
<br>
<b>L’informe que ara reps és una aproximació</b> d'acord amb el teu ús elèctric de 2019 i la zona climàtica on vius, per instal·lacions monofàsiques. Tot i això, no té en consideració alguns aspectes tècnics i si realment pots instal·lar plaques fotovoltaiques a casa, perquè no sabem si tens teulada o terrat per fer-ho.<br>
<br>
Amb la col·laboració del  <a href="https://ca.support.somenergia.coop/article/627-els-grups-locals-de-som-energia">grup local de la teva zona</a>, <b>hem obert les inscripcions per a una <a href="https://www.somenergia.coop/ca/produeix-energia-renovable/autoproduccio/">compra col·lectiva a la comarca on vius</a></b>; t’enviem aquest informe, que et pot servir d’orientació per veure si t’interessa sumar-te a la compra o valorar altres opcions d’autoproducció.<br>
<br>
Esperem que aquest informe desperti el teu interès per ser més autosuficient energèticament amb l’ús de les renovables.<br>
<br>
Moltes gràcies per la teva confiança; per fer-nos arribar qualsevol comentari, observació o suggeriment pots respondre aquest mateix correu.<br>
<br>
Bona energia!<br>
<br>
*******<br>
<br><i>
<b>Les compres col·lectives</b> se sustenten en un procés de selecció de l’enginyeria i instal·ladora que oferirà el servei integral, des del projecte detallat fins a la legalització de la instal·lació, a totes les persones sòcies que s’inscriguin a aquesta compra. L’objectiu són 100 instal·lacions en total en cada compra. Fent-ho d’aquesta manera col·lectiva, <b>busquem aconseguir un servei i producte amb garanties</b>, a bon preu i amb aspectes que també considerem importants a la cooperativa, com són la proximitat, els valors de l’empresa i la voluntat de servei.
Pots trobar més informació sobre la compra col·lectiva de la teva zona als enllaços que hi ha en el mateix informe.</i><br>
<br>
*******<br>
<br>
% endif
% if  object.titular.lang  != "ca_ES":
<br>
Hola ${object.titular.name.split(',')[-1]},<br>
<br>
Te mandamos un informe sobre <b>el potencial que tienes para hacer autoproducción solar en tu casa</b>.<br>
<br>
Uno de los objetivos que tenemos en la cooperativa actualmente es facilitar e impulsar la autoproducción fotovoltaica entre las personas socias. Más allá de producir energía renovable de manera colectiva, para alcanzar un modelo 100 % renovable y eficiente es necesario  que se incorpore la generación distribuida en todos los niveles, allí donde sea posible. Y nuestros tejados son un lugar idóneo para acercar la producción de energía allí donde se utiliza.<br>
<br>
<b>El informe que ahora recibes es una aproximación</b> basada en tu uso eléctrico de 2019 y la zona climática donde vives, para instalaciones monofásicas. Aun así, no tiene en consideración algunos aspectos técnicos ni si realmente tienes tejado o azotea para instalar placas fotovoltaicas en casa.<br>
<br>
Con la colaboración del <a href="https://es.support.somenergia.coop/article/628-los-grupos-locales-de-som-energia">grupo local de tu zona</a>, <b>hemos abierto las inscripciones para una <a href="https://www.somenergia.coop/es/produce-energia-renovable/autoproduccion/">compra colectiva en la comarca donde vives</a></b>; con este informe puedes orientarte si te interesa sumarte a la compra o valorar otras opciones de autoproducción.<br>
<br>
Esperamos que este informe te despierte el interés por ser más autosuficiente energéticamente con el uso de las renovables.<br>
<br>
Muchas gracias por tu confianza; puedes hacernos llegar cualquier comentario, observación o sugerencia respondiendo a este mismo correo.<br>
<br>
¡Buena energía!<br>
<br>
*******<br>
<i><b>Las compras colectivas</b> se sustentan en un proceso de selección de la ingeniería e instaladora que ofrecerá el servicio integral, desde el proyecto detallado hasta la legalización de la instalación, a todas las personas socias que se inscriban a esta compra. El objetivo son 100 instalaciones en total en cada compra. Haciéndolo de manera colectiva, <b>buscamos conseguir un servicio y producto con garantías</b>, a buen precio y con aspectos que también consideramos importantes en la cooperativa como son la proximidad, los valores de la empresa y la voluntad de servicio.
Puedes encontrar más información sobre la compra colectiva de tu zona en los enlaces que encontrarás en el mismo informe.</i><br>
<br>
*******<br>
<br>
% endif
${text_legal}
</body>
</html>