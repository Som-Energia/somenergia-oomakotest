<!doctype html>
<html>
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
% if  object.polissa_id.titular.lang != "es_ES":
<head><meta charset="utf-8" />
<table width="100%" frame="below" BGCOLOR="#E8F1D4">
<tr>
    <td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}: </strong></font></td>
    <td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td>
</tr>
<tr>
    <td height = 2px><FONT SIZE=1>Direcció punt de subministrament: ${object.polissa_id.cups.direccio}</font></td>
</tr>
<tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.polissa_id.cups.name}</font></td></tr>
<tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr>
</table>
</head>
<body>
<br>
<br>
<p>Benvolgudes i benvolguts,</p>
<br>
<p>Estem a punt de fer el canvi d'any amb una situació al mercat elèctric mai vista fins ara. En aquest correu expliquem quin és el context del mercat elèctric, com aquest escenari afecta Som Energia i quines mesures es prendran per fer-hi front.</p>

<p>Com ja vam comentar a <a href="https://blog.somenergia.coop/som-energia/2021/10/obrim-de-nou-les-aportacions-voluntaries-al-capital-social-2/" title="Aportacions al capital social" target="_blank">mitjans d'octubre</a>, els preus elevats de l'energia al mercat majorista, que ja es van començar a enfilar a mitjans de març, estan tensant la tresoreria de les comercialitzadores com nosaltres. La causa és l'augment considerable, quatre vegades més, de la quantitat de diners que ens cal avançar davant diferents organismes per seguir subministrant energia als consumidors i consumidores de la cooperativa.</p>

<p>Els projectes cooperatius com el nostre, basats en les necessitats comunes de consum i no en el lucre, poden tenir una resiliència més gran per afrontar situacions adverses. En els onze anys d'història de Som Energia, podem dir que aquest és un dels moments més difícils. És un bon moment per demostrar que el futur serà cooperatiu!</p>
<br>
<p><b>Què està passant?</b></p>

<p>Les raons són múltiples i diverses, des de les tensions geopolítiques globals del mercat gasístic o el preu de cotització dels drets d'emissió de CO&#8322; fins a altres elements especulatius i interessats. Tot plegat pot concloure amb una reconcentració de poder en les grans companyies, que tenen molta més capacitat i mitjans per fer front a una situació inesperada com l'actual.</p>

<p>Sentim als mitjans notícies que parlen sobre l'increment de l'índex de preus de consum o l'endarreriment en la provisió de béns o matèries, i el mercat elèctric, tal com està constituït ara mateix, no és aliè a aquesta situació global.</p>

<p>Gràcies a la flexibilitat que com a cooperativa tenim a l'hora d'adaptar-nos als canvis de preu, la viabilitat de Som Energia no està en qüestió, el balanç és robust i està sanejat. Tot i haver aconseguit augmentar de manera molt considerable la nostra capacitat de finançament (<a href="https://blog.somenergia.coop/som-energia/2021/11/assolim-10-milions-deuros-daportacions-voluntaries-per-afrontar-les-dificultats-del-mercat-energetic/" title="Gràcies per les aportacions realitzades" target="_blank">gràcies</a> als més de 12 M€ en aportacions voluntàries al capital social i a les línies de crèdit o préstecs que hem aconseguit els darrers mesos per part de <a href="https://coop57.coop/ca/catalunya/coop57-concedeix-2-milions-d%E2%80%99euros-som-energia-lluitar-contra-la-pujada-de-preus-en-el" title="Article on comparteixen l'aportació" target="_blank">Coop57</a>, Fiare, Caixa d'Enginyers i Cajamar, entre d'altres), el context segueix essent exigent i veiem amb preocupació els primers mesos de l'any vinent. Si fa poc prevèiem preus al mercat de 250 €/MWh, set vegades més alts que fa un any, ara ja treballem en l'escenari dels 400 €/MWh, amb la tensió que això comportarà a la tresoreria de la cooperativa.</p>
<br>
<p><b>Accions per fer-hi front</b></p>

<p>Per fer-hi front, amb la voluntat de seguir mantenint la sostenibilitat de la cooperativa, hem començat a treballar en diferents línies d'acció:</p>

<p>Per una banda, <b>contenir el volum d'energia que comercialitzem</b>.</p>

<p>Amb els preus disparats, tot kWh no previst o cobert anteriorment, representa ara una despesa molt gran, tenint en compte que la cooperativa avança la compra d'energia unes quatre setmanes abans de facturar-la. Preveiem que en les pròximes setmanes haurem de fer moviments de compra d'energia per valor de 30 M€, quan el passat mes d'agost el volum setmanal era de prop dels 4 M€.</p>

<p>Per tant, les decisions que s'han pres i que ara portarem a terme són:</p>
<ul>
<li>Als contractes de gran consum que tenim acordats amb unes condicions especials, els demanarem un dipòsit de garantia (equivalent a un mes de facturació) per sostenir millor els requisits necessaris per a la compra de la seva demanda energètica. En el cas que no ho considerin adequat, caldrà que busquin una altra opció de mercat que els sigui més favorable.</li>

<li>Als contractes de tarifes no domèstiques existents, no els podrem aplicar la renovació de contracte si no venen acompanyats del dipòsit de garantia corresponent.</li>
</ul>

<p>Alhora, activem mesures per <b>equilibrar els ingressos amb els pagaments</b>.</p>
<ul>
<li>Accelerarem, malgrat les <a href="https://blog.somenergia.coop/som-energia/2021/09/moment-excepcional-en-el-servei-de-comercialitzacio-de-som-energia/" title="Moment exepcional a comercialització" target="_blank">dificultats amb què ens trobem</a> amb algunes distribuïdores, el ritme d'emissió de factures i centrarem els esforços a enviar les factures endarrerides que s'acumulen des de l'entrada dels nous peatges del mes de juny. Focalitzar-nos en aquest sentit repercuteix en l'atenció que podem donar via telèfon i correu electrònic, per això et demanem paciència i agraïm la teva comprensió.</li>

<li>Actualitzarem les tarifes a dia 1 de febrer per ajustar-les al cost de l'energia actual. Durant les pròximes hores enviarem un correu electrònic amb la nova informació i publicarem més detalls al <a href="https://blog.somenergia.coop/" title="On Som Energia publica les notícies" target="_blank">blog de Som Energia</a>.</li>
</ul>
<p>I per completar, tirarem endavant accions encaminades a <b>augmentar el capital social de la cooperativa</b>.</p>
<ul>
<li>Els 100 € de capital inicial que cal aportar per esdevenir soci/a de la cooperativa són de vital importància per donar solidesa a la tresoreria de la cooperativa.</li>
<ul>
<li><b>Si ja ets soci/a</b>: Anima les persones titulars dels teus contractes vinculats, <a href="https://www.somenergia.coop/ca/fes-te-n-soci-a/" title="Web on et pots fer sòcia" target="_blank">a fer el pas</a> i esdevinguin persones sòcies de Som Energia.</li>

<li><b>Si encara no ets soci/a</b>: Si has arribat a Som Energia gràcies a una persona sòcia, o per alguna campanya de Nadal o per altres tràmits amb els contractes, <a href="https://www.somenergia.coop/ca/fes-te-n-soci-a/" title="Web on et pots fer sòcia" target="_blank">fes el pas d'associar-t'hi</a> i dona suport al projecte.</li>
</ul>
<li>Seguirem impulsant les aportacions voluntàries al capital social que vam iniciar el mes de setembre.</li>
<ul>
    <li><b>Si ja ets soci/a</b>: <a href="https://www.somenergia.coop/ca/produeix-energia-renovable/aporta-al-capital-social/" title="Web on pots aportar" target="_blank">Fes la teva aportació</a> voluntària al capital social per reforçar la cooperativa en aquests moments complicats. Actualment som més de 76.000 persones sòcies i, si cadascuna de nosaltres fes una mínima aportació, la cooperativa sortiria molt i molt reforçada.</li>
</ul>
</ul>
<br>
<p><b>Per què cal actuar</b></p>

<p>Totes aquestes mesures les prenem amb una premissa clara: actuar per mantenir la viabilitat de la cooperativa i assegurar les millors condicions a totes les persones consumidores, siguin sòcies o no de Som Energia.</p>

<p>Som Energia ha esdevingut un referent en el canvi de model energètic, per aquest motiu ens sentim responsables de continuar existint com a alternativa a l'oligopoli. Aquest moment excepcional ens fa prendre mesures rellevants que no havíem valorat fins ara. Seguim confiant que posar el focus en el benefici col·lectiu i la transició energètica transformadora és el camí.</p>

<p>Aquests mesos són complicats, sens dubte, però amb el suport i la comprensió de totes les persones sòcies que confieu en el projecte de Som Energia, sabem que en sortirem més enfortides i amb canvis estructurals que ens facin ser més resilients per a futures situacions de tensió com aquesta. Perquè aquesta no serà l'última. Les resistències al canvi del model fòssil i centralitzat cap al model renovable i en mans de la ciutadania, ens faran passar per dificultats cada vegada que es guanyi una mica de terreny.</p>

<p>Ara, les amenaces per qui fa anys que remena les cireres del sector són més fortes. No deixaran que els canvis com l'aposta clara per l'autoproducció (individual o compartida), les comunitats energètiques com a espais de participació i acció ciutadana i altres iniciatives es donin fàcilment. Per tant, ens hem de seguir reforçant per demostrar que no som aquí per fer només pessigolles, sinó per promoure un canvi transformador de veritat.</p>

<p>L'entrega de l'equip tècnic i el Consell Rector per atendre aquesta situació també està sent intensa, així que reconeixem i agraïm el compromís de tots i totes les que fem possible Som Energia i et desitgem que acabis de tenir una bona sortida d'any per entomar el proper amb més i millor energia.</p>
<br>
<p>Salut i bona energia,</p>

<br>
<p> Equip de Som Energia</p>
<p> <a href="https://www.somenergia.coop/ca/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.polissa_id.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
<body>
<br>
<br>
<p>Estimadas y estimados,</p>
<br>
<p>Estamos a punto de cambiar de año con una situación en el mercado eléctrico nunca vista hasta ahora. En este correo te explicamos cuál es el contexto del mercado eléctrico, cómo este escenario afecta a Som Energia y qué medidas se tomarán para hacer frente a esta situación.</p>

<p>Como ya comentamos a <a href="https://blog.somenergia.coop/som-energia/2021/10/abrimos-de-nuevo-las-aportaciones-voluntarias-al-capital-social-2/" title="Aportaciones al capital social" target="_blank">mediados de octubre</a>, los precios elevados de la energía en el mercado mayorista, que ya empezaron a subir a mediados de marzo, están tensando la tesorería de las comercializadoras como la nuestra. La causa es el aumento considerable, cuatro veces más, de la cantidad de dinero que debemos adelantar ante diferentes organismos para seguir suministrando energía a los consumidores y consumidoras de la cooperativa.</p>

<p>Los proyectos cooperativos como el nuestro, basados ​​en las necesidades comunes de consumo y no en el lucro, pueden tener mayor resiliencia para afrontar situaciones adversas. En los once años de historia de Som Energia, podemos decir que este es uno de los momentos más difíciles. ¡Es un buen momento para demostrar que el futuro será cooperativo!</p>
<br>
<p><b>¿Qué está pasando?</b></p>

<p>Las razones son múltiples y diversas, desde las tensiones geopolíticas globales del mercado gasístico o el precio de cotización de los derechos de emisión de CO2 hasta  otros elementos especulativos e interesados. Todo ello puede concluir con una reconcentración de poder en las grandes compañías, que tienen mucha mayor capacidad y medios para hacer frente a una situación inesperada como la actual.</p>

<p>Oímos en los medios noticias que hablan sobre el incremento del índice de precios de consumo o el retraso en el abastecimiento  de bienes o materias, y el mercado eléctrico, tal y como está constituido ahora mismo, no es ajeno a esta situación global.</p>

<p>Gracias a la flexibilidad que como cooperativa tenemos a la hora de adaptarnos a los cambios de precio, la viabilidad de Som Energia no está en cuestión, el balance es robusto y está saneado. Aunque hayamos conseguido aumentar de forma muy considerable nuestra capacidad de financiación (<a href="https://blog.somenergia.coop/som-energia/2021/11/alcanzamos-10-millones-de-euros-de-aportaciones-voluntarias-para-afrontar-las-dificultades-del-mercado-energetico/" title="Gracias por las aportaciones realizadas" target="_blank">gracias</a> a los más de 12 M€ en aportaciones voluntarias al capital social y a las líneas de crédito o préstamos que hemos conseguido en los últimos meses por parte de <a href="https://coop57.coop/es/catalunya/coop57-concede-2-millones-de-euros-som-energia-para-luchar-contra-la-subida-de-precios-en" title="Artículo donde comparten la aportación" target="_blank">Coop57</a>, Fiare, Caja de Ingenieros y Cajamar entre otros), el contexto sigue siendo exigente y vemos con preocupación los primeros meses del próximo año. Si hace poco preveíamos precios en el mercado de 250 €/MWh, siete veces más altos que hace un año, ahora ya trabajamos en el escenario de los 400 €/MWh, con la tensión que ello conllevará a la tesorería de la cooperativa.</p>
<br>
<p><b>Acciones para hacer frente a la situación</b></p>

<p>Para hacer frente a la situación, con la voluntad de seguir manteniendo la sostenibilidad de la cooperativa, hemos empezado a trabajar en diferentes líneas de acción:</p>

<p>Por un lado, <b>contener el volumen de energía que comercializamos</b>.</p>

<p>Con los precios disparados, todo kWh no previsto o no cubierto anteriormente representa ahora un gasto muy elevado, teniendo en cuenta que la cooperativa adelanta la compra de energía unas cuatro semanas antes de facturarla. Prevemos que en las próximas semanas deberemos realizar movimientos de compra de energía por valor de 30 M€, cuando el pasado mes de agosto el volumen semanal era de cerca de los 4 M€.</p>

<p>Por lo tanto, las decisiones que se han tomado y que ahora llevaremos a cabo son:</p>
<ul>
<li>A los contratos de gran consumo que tenemos acordados con condiciones especiales, les pediremos un depósito de garantía (equivalente a un mes de facturación) para sostener mejor los requisitos necesarios para la compra de su demanda energética. En caso de que no lo consideren adecuado, tendrán que buscar otra opción de mercado que les sea más favorable.</li>

<li>A los contratos de tarifas no domésticas existentes, no se les podrá aplicar la renovación si no vienen acompañados del depósito de garantía correspondiente.</li>
</ul>

<p>Al mismo tiempo, activamos medidas para <b>equilibrar los ingresos con los pagos</b>.</p>
<ul>
<li>Aceleraremos, a pesar de las <a href="https://blog.somenergia.coop/som-energia/2021/09/momento-excepcional-en-el-servicio-de-comercializacion-de-som-energia/" title="Momento excepcional a comercialitzación" target="_blank">dificultades que tenemos</a> con algunas distribuidoras, el ritmo de emisión de facturas y centraremos los esfuerzos en enviar las facturas atrasadas que se acumulan desde la entrada de los nuevos peajes de junio. Focalizarnos en este sentido repercute en la atención que podemos dar vía teléfono y correo electrónico, por lo que te pedimos paciencia y agradecemos tu comprensión.</li>

<li>Actualizaremos las tarifas a 1 de febrero para ajustarlas al coste de la energía actual. Durante las próximas horas enviaremos un correo electrónico con la nueva información y publicaremos más detalles en el <a href="https://blog.somenergia.coop/" title="Donde Som Energia publica las noticias" target="_blank">blog de Som Energia</a>.</li>
</ul>

<p>Y para completar, acciones encaminadas a <b>aumentar el capital social de la cooperativa</b>.</p>
<ul>
<li>Los 100 € de capital inicial que hay que aportar para convertirse en socio/a de la cooperativa son de vital importancia para dar solidez a la tesorería de la cooperativa.</li>
<ul>
<li><b>Si ya eres socio/a</b>: Anima a las personas titulares de tus contratos vinculados a <a href="https://www.somenergia.coop/es/hazte-socio-a/" title="Web donde te puedes hacer socia" target="_blank">dar el paso</a> y que se conviertan en personas socias de Som Energia.</li>

<li><b>Si todavía no eres socio/a</b>: Si has llegado a Som Energia gracias a una persona socia, o por alguna campaña de Navidad u otros trámites con los contratos, <a href="https://www.somenergia.coop/es/hazte-socio-a/" title="Web donde te puedes hacer socia" target="_blank">hazte socio/a</a> y apoya el proyecto.</li>
</ul>
<li>Seguiremos impulsando las aportaciones voluntarias al capital social que iniciamos en septiembre.</li>
<ul>
    <li><b>Si ya eres socio/a:</b> <a href="https://www.somenergia.coop/es/produce-energia-renovable/aporta-al-capital-social/" title="Web donde puedes aportar" target="_blank">Haz tu aportación</a> voluntaria al capital social para reforzar la cooperativa en estos momentos complicados. Actualmente, somos más de 76.000 personas socias y, si cada una de nosotros hiciera una mínima aportación, la cooperativa saldría muy reforzada.</li>
</ul>
</ul>
<br>
<p><b>Por qué hay que actuar</b></p>

<p>Todas estas medidas las tomamos con una premisa clara: actuar para mantener la viabilidad de la cooperativa y asegurar las mejores condiciones a todas las personas consumidoras, sean socias o no de Som Energia.</p>

<p>Som Energia se ha convertido en un referente en el cambio de modelo energético, por este motivo nos sentimos responsables de seguir existiendo como alternativa al oligopolio. Este momento excepcional nos lleva a tomar medidas relevantes que no habíamos valorado hasta ahora. Seguimos confiando en que poner el foco en el beneficio colectivo y la transición energética transformadora es el camino.</p>

<p>Estos meses son complicados, sin duda, pero con el apoyo y la comprensión de todas las personas socias que confían en el proyecto de Som Energia, sabemos que saldremos más fortalecidas y con cambios estructurales que nos harán más resilientes para futuras situaciones de tensión como esta. Porque esta no será la última. Las resistencias al cambio del modelo fósil y centralizado hacia el modelo renovable y en manos de la ciudadanía nos harán pasar por dificultades cada vez que se gane algo de terreno.</p>

<p>Ahora, las amenazas de quien lleva la batuta en el sector desde hace años son más fuertes. No dejarán que se den fácilmente cambios como la apuesta clara por la autoproducción (individual o compartida), las comunidades energéticas como espacios de participación y acción ciudadana, y otras iniciativas. Por tanto, debemos seguir reforzándonos para demostrar que no estamos aquí para hacer solo cosquillas, sino para promover un cambio transformador de verdad.</p>

<p>La entrega del equipo técnico y el Consejo Rector para atender esta situación también está siendo intensa, así que reconocemos y agradecemos el compromiso de todos y todas las que hacemos posible Som Energia y te deseamos que acabes de tener una buena salida de año para tomar el próximo con más y mejor energía.</p>
<br>
<p>Salud y buena energía,</p>

<br>
<p> Equipo de Som Energia</p>
<p> <a href="https://www.somenergia.coop/es/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
<p> ${text_legal}</p>
</body>
</html>