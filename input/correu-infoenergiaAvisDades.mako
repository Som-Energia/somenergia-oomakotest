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
<head></head>
<body>
% if object.cups_polissa_id.titular.lang == "ca_ES":
<br>
Benvolgut/da,<br>
<br>
A la cooperativa tenim la voluntat d'acompanyar les persones sòcies a entendre millor els conceptes i el funcionament del mercat elèctric. I al mateix temps, creiem que la cooperativa ha d’ajudar a reduir el nostre ús d’energia, també en la seva faceta com a comercialitzadora.<br>
<br>
És per tot això que posem en marxa el nou servei d’<strong>informació energètica personalitzada</strong>.<br>
<br>
Aquest servei es realitzarà principalment a través d’aquests dos canals:<br>
<ul>
<li> Un <strong>informe mensual amb comparatives</strong> respecte a consums anteriors, a llars similars i <strong>consells personalitzats</strong>, document que rebrem via per correu electrònic amb una presentació atractiva de les dades i la informació relacionada.</li><br>
<br>
<li> Un <strong>espai a l'Oficina Virtual</strong> on serà possible accedir a la <strong>informació ampliada de l’informe i amb dades sobre els consums horaris</strong> en el cas de disposar d'un comptador amb telegestió activada.</li><br>
</ul>
Aquest servei ajuda a saber com és el nostre ús elèctric en relació amb les altres persones de Som Energia, ens ofereix més informació de la que mostrem a la factura i consells per ajudar-nos a usar menys electricitat.<br>
<br>
Tot plegat per tal que les persones sòcies i clientes tinguin més coneixement de l'electricitat que usen (i paguen!) i així millorar la seva eficiència energètica.<br>
<br>
<h2>Tractament de les dades </h2>
Per tal de tractar les dades de consum i fer els informes corresponents, col·laborem amb el projecte BeeData, que realitza l’anàlisi de les dades que els comuniquem (dades de consum  del contracte, codi postal, CNAE, potència, tarifa contractada i les dades que la persona introdueixi en el formulari del servei a l’Oficina Virtual).<br>
<br>
Considerem que no es tracta d'una <strong>comunicació de dades personals, ja que aquestes no inclouen el domicili, nom, DNI, telèfon, etc.  de la persona</strong>.<br>
<br>
La Llei orgànica 15/1999 de protecció de dades de caràcter personal i el Reglament 1720/2007 que desenvolupa la mencionada llei indiquen que són dades personals aquelles que permetin identificar-ne la persona titular sempre que aquesta identificació no requereixi de terminis o activitats desproporcionades.<br>
<br>
Però de totes maneres, considerem que cal que tothom n’estigui informat i que pugui exercir el dret de donar-se de baixa del servei si ho considera oportú.<br>
<br>
Així doncs, si no estàs interessat/da  a utilitzar aquest servei,  tens un termini de 30 dies per manifestar la teva negativa a aquesta comunicació i tractament de les dades per part de BeeData. En cas contrari entendrem que dónes el consentiment a la seva comunicació.<br>
<br>
Per tal de manifestar la teva negativa pots omplir el següent formulari:  <a href="https://docs.google.com/a/somenergia.coop/forms/d/1jgh6An2YI9W57AyzrBjKtppwIKj8B4FtHazkgKdwvgw/viewform">‘Negativa a la comunicació de dades a BeeData</a>.<br>
<br>
Pots resoldre qualsevol dubte podeu contactar amb <a href="mailto:infoenergia@somenergia.coop">infoenergia@somenergia.coop</a><br>
<br>
Equip Tècnic de Som Energia<br>
info@somenergia.coop<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
<br>
% endif
% if object.cups_polissa_id.titular.lang == "es_ES":
<br>
Estimado/a,<br>
<br>
En la cooperativa tenemos la voluntad de acompañar a las personas socias en una mayor comprensión de los conceptos y del funcionamiento del mercado eléctrico. Y al mismo tiempo, creemos que la cooperativa debe ayudar a reducir nuestro uso de energía, también desde su faceta como comercializadora.<br>
<br>
Es por todo ello que ponemos en marcha el nuevo servicio de <strong>información energética personalizada</strong>.<br>
<br>
Este servicio se realizará principalmente a través de estos dos canales<br>  
<ul>
<li>Un <strong>informe mensual con comparativas</strong> respecto a consumos anteriores, a hogares similares y <strong>consejos personalizados</strong>, documento que recibiremos vía correo electrónico con una presentación atractiva de los datos y la información relacionada.</li>

<li>Un <strong>espacio en la Oficina Virtual</strong> donde será posible acceder a la <strong>información ampliada del informe y con información sobre los consumos horarios</strong> en el caso de disponer de un contador con telegestión activada.</li>
</ul>
Este servicio ayuda a conocer cómo es nuestro uso eléctrico en relación a las otras personas de Som Energia, nos ofrece más información de la que mostramos en la factura y ofrece consejos para ayudarnos a usar menos electricidad.<br>
<br>
Todo ello para que las personas socias y clientes tengan más conocimiento de la electricidad que usan (y pagan!) y así mejorar su eficiencia energética.<br>
Tratamiento de los datos<br>
<br>
Con el fin de tratar los datos de consumo y hacer los informes correspondientes, colaboramos con el proyecto BeeData, que realiza el análisis de los datos que les comunicamos (datos de consumo del contrato, código postal, CNAE, potencia, tarifa contratada y los datos que introduzcas en el formulario del servicio en la Oficina Virtual).<br>
<br>
Consideramos que <strong>no se trata de una comunicación de datos personales ya que estos no incluyen el domicilio, nombre, DNI, teléfono, etc. de la persona</strong>.<br>
<br>
La Ley Orgánica 15/1999 de protección de datos de carácter personal y el Reglamento 1720/2007 que desarrolla la mencionada ley indican que son datos personales aquellos que permitan identificar a la persona titular de las mismas siempre que esta identificación no requiera de plazos o actividades desproporcionadas.<br>
<br>
Pero de todos modos, consideramos que es necesario que todo el mundo esté informado y que pueda ejercer el derecho de darse de baja del servicio si lo considera oportuno.<br>
<br>
Así pues si no estás interesado/a en utilizar este servicio, tienes un plazo de 30 días para manifestar tu negativa a esta comunicación y tratamiento de los datos por parte de BeeData. De lo contrario entenderemos que das el  consentimiento a la comunicación de los mismos.<br>
<br>
Para manifestar tu negativa puedes rellenar el siguiente formulario: <a href="https://docs.google.com/a/somenergia.coop/forms/d/1ym8JuM_cVJAPPvYVZDtYF1D3Peo45tMfm58lyJbphDs/viewform">Negativa a la comunicación de datos a BeeData</a>.<br>
<br>
Para resolver cualquier duda puedes contactar con <a href="mailto:infoenergia@somenergia.coop">infoenergia@somenergia.coop</a><br>
<br>
Equipo Técnico de Som Energia<br>
info@somenergia.coop<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
<br>
% endif

${text_legal}

</body>
</html>
