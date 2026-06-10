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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_rejection_text'
    )[1]

text_desistiment = render(
    t_obj.read(object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
tarifa_a_mostrar = ""

from gestionatr.defs import TABLA_113
from som_polissa.models.giscedata_cups import TABLA_113_dict
autoconsum_description = False
if object.autoconsumo != '00':
    autoconsum_description = object.autoconsumo + ' - '
    if object.titular.lang == 'ca_ES':
        autoconsum_description += TABLA_113_dict[object.autoconsumo]
    else:
        autoconsum_description += dict(TABLA_113)[object.autoconsumo]

try:
    lang = object.titular.lang
    pol_o = object.pool.get('giscedata.polissa')
    llista_preu_o = object.pool.get('product.pricelist')

    tarifes_ids = llista_preu_o.search(object._cr, object._uid, [])
    llista_preus = pol_o.escull_llista_preus(object._cr, object._uid, object.id, tarifes_ids, context={'lang': lang})

    tarifa_a_mostrar = llista_preus.nom_comercial or llista_preus.name
except Exception as error:
    pass

%>

${plantilla_header}

            % if object.titular.lang == "ca_ES":
<p>Hola!</p>
<p><strong>Ja has completat la sol·licitud per a contractar el teu subministrament elèctric a través de la cooperativa Som Energia. Moltes gràcies per sumar-te al canvi!</strong></p>
<p>T'adjuntem les condicions generals i particulars del teu contracte.</p>
<p>Aquest és el resum de les dades facilitades en el formulari de contractació d'electricitat:</p>
<ul>
<li>Persona sòcia de Som Energia: ${object.soci.name}</li>
<li>Titular del contracte d'electricitat: ${object.titular.name}</li>
<li>Adreça punt subministrament: ${object.cups_direccio}</li>
<li>Codi CUPS: ${object.cups.name}</li>
<li>Tarifa: ${tarifa_a_mostrar}</li>
% if object.donatiu:
<li>Donatiu Voluntari (0,01€/kWh): Si</li>
%endif
</ul>
%if autoconsum_description:
<ul>
<li>Modalitat autoconsum: ${autoconsum_description}</li>
</ul>
%endif
<p>Recorda que la persona titular del contracte de subministrament ha de ser l'usuària efectiva de l'electricitat contractada i ha de disposar d'un just títol (contracte d'arrendament, propietat etc.) sobre el punt de subministrament.</p>
<h3>Quins són els següents passos?</h3>
<p><img alt="Esquema cambio comercialitzadora" src="https://www.somenergia.coop/wpsom/static/email/esquema_canvi_comer_CA.png" style="width: 475px;"/></p>
            % if not object.observacions or 'proces: A3' not in object.observacions:
<p>El procés de canvi de comercialitzadora consta de tres passos:</p>
<p><strong>1. Enviament de la sol·licitud a la distribuïdora.</strong> És el pas en què estem actualment. Enviem la petició de canvi de comercialitzadora amb totes les dades que ens has facilitat.</p>
<p><strong>2. Recepció de la resposta per part de la distribuïdora.</strong> En un període màxim d'una setmana, la distribuïdora confirmarà si podem continuar amb el tràmit. Si necessitem alguna altra gestió per la teva part, t'avisarem.</p>
<p><strong>3. Activació del contracte.</strong> Quan la distribuïdora ens confirmi que el contracte ja està <strong>actiu</strong> amb la cooperativa, t'ho comunicarem per correu electrònic. A partir d'aquell moment ja facturarem des de Som Energia, però tingues en compte que encara rebràs l'última factura de la teva antiga comercialitzadora amb el consum acumulat fins al dia exacte del canvi (en cap cas es duplicarà el cobrament).</p>
            % else:
<p>El procés d'alta de subministrament consta dels següents passos:</p>
<p><strong>1. Enviament de la sol·licitud a la distribuïdora.</strong> És el pas en què estem actualment. Enviem la petició d'alta de subministrament amb totes les dades que ens has facilitat.</p>
<p><strong>2. Recepció de la resposta per part de la distribuïdora.</strong> En uns dies rebrem la resposta d'inici d'actuacions.</p>
<ul>
<li><em>Si la sol·licitud s'ha acceptat</em>, t'informarem via correu electrònic; en aquest moment, la distribuïdora disposarà de 15 dies per efectuar l'alta de subministrament. En cas necessari, contactaran amb tu al telèfon que vares facilitar en emplenar el formulari.</li>
<li><em>En cas contrari,</em> t'informarem dels passos a seguir.</li>
</ul>
<p><strong>3. Activació del contracte.</strong> Quan l'alta sigui efectiva, ens ho faran saber i t'enviarem un darrer correu electrònic indicant la data exacta. Amb aquesta comunicació el procés d'alta haurà finalitzat.</p>
<p><strong>4.</strong> Posteriorment, <strong>a la primera factura</strong> inclourem els costos de l'alta (que cobra la distribuïdora) desglossats. Pots consultar un càlcul orientatiu dels costos en <a href="https://ca.support.somenergia.coop/article/225-no-tinc-llum-actualment-puc-sol-licitar-un-nou-punt-de-consum">aquest enllaç</a>.</p>
            % endif
<p>Informació important sobre el teu contracte:</p>
<p>${text_desistiment}</p>
<p><strong>Sense permanència.</strong> A Som Energia <strong>no tens cap obligació de permanència.</strong> En el moment que vulguis, pots canviar de comercialitzadora. Som una cooperativa 100% renovable sense ànim de lucre i un dels nostres principis és oferir el preu més ajustat possible. No oferim ofertes especials, ni clàusules addicionals ni lletra petita. La transparència, el bon tracte, uns preus ajustats, el treball per un canvi de model energètic, són alguns dels valors de Som Energia i el motiu pel qual tanta gent es suma al projecte i continua, sense cap clàusula de permanència.</p>
<p>Enllaços d'interès:</p>
<ul>
<li><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a>: aquí pots revisar l'estat del teu contracte, modificar les teves dades i consultar les factures que anirem emetent. <a href="https://ca.support.somenergia.coop/category/72-oficina-virtual">Ús de l'Oficina Virtual.</a></li>
<li><a href="https://ca.support.somenergia.coop/">Centre de Suport Som Energia</a>: hi trobaràs resposta als dubtes més freqüents, com per exemple: "Com puc fer un canvi de potència o tarifa?", "Com puc facilitar la lectura?", etc.</li>
<li><a href="https://participa.somenergia.coop/">Plataforma Participa</a>: l'espai de democràcia interna i debat de la cooperativa. Aquí podràs participar activament en la presa de decisions i estar al dia dels projectes.</li>
</ul>
<p>Moltes gràcies per triar consumir bona energia!</p>
<p>Atentament,</p>
<p>Equip de Som Energia<br>comercialitzacio@somenergia.coop<br><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a></p>
        % else:
<p>¡Hola!</p>
<p><strong>Ya has completado la solicitud para contratar tu suministro eléctrico a través de la cooperativa Som Energia. ¡Muchas gracias por sumarte al cambio!</strong></p>
<p>Te adjuntamos las condiciones generales y particulares de tu contrato.</p>
<p>Este es el resumen de los datos facilitados en el formulario de contratación de electricidad:</p>
<ul>
<li>Persona socia de Som Energia: ${object.soci.name}</li>
<li>Titular del contrato de electricidad: ${object.titular.name}</li>
<li>Dirección punto de suministro: ${object.cups_direccio}</li>
<li>Código CUPS: ${object.cups.name}</li>
<li>Tarifa: ${tarifa_a_mostrar}</li>
% if object.donatiu:
<li>Donativo Voluntario (0,01€/kWh): Sí</li>
%endif
</ul>
%if autoconsum_description:
<ul>
<li>Modalidad autoconsumo: ${autoconsum_description}</li>
</ul>
<p>Si tu modalidad de autoconsumo es con compensación de excedentes, también se ha activado el <a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar">Flux Solar</a>.</p>
%endif
<p>Recuerda que la persona titular del contrato de suministro tiene que ser usuaria efectiva de la electricidad contratada y ha de disponer de un justo título (contrato de arrendamiento, propiedad etc.) sobre el punto de suministro.</p>
<h3>¿Cuáles son los siguientes pasos?</h3>
<p><img alt="Esquema cambio comercializadora" src="https://www.somenergia.coop/wpsom/static/email/esquema_canvi_comer_ES.png" style="width: 475px;"/></p>
% if not object.observacions or 'proces: A3' not in object.observacions:
<p>El proceso de cambio de comercializadora consta de tres pasos:</p>
<p><strong>1. Envío de la solicitud a la distribuidora.</strong> Es el paso en el que estamos en estos momentos. Enviamos la petición de cambio de comercializadora con los datos que nos has facilitado.</p>
<p><strong>2. Recepción de la respuesta por parte de la distribuidora.</strong> En un periodo máximo de una semana, la distribuidora confirmará si podemos continuar con el trámite. Si necesitamos alguna otra gestión por tu parte, te avisaremos.</p>
<p><strong>3. Activación del contrato.</strong> Una vez la distribuidora nos confirme que el contrato ya está <strong>activo</strong> con la cooperativa, te lo comunicaremos por correo electrónico. A partir de ese momento ya facturaremos desde Som Energia, pero ten en cuenta que aún recibirás la última factura de tu antigua comercializadora con el consumo acumulado hasta el día exacto del cambio (en ningún caso se duplicará el cobro).</p>
% else:
<p>El proceso de alta de suministro consta de los siguientes pasos:</p>
<p><strong>1. Envío de la solicitud a la distribuidora.</strong> Es el paso en el que estamos actualmente. Enviamos la petición de alta con los datos facilitados.</p>
<p><strong>2. Recepción de la respuesta por parte de la distribuidora.</strong> En unos días recibiremos la respuesta de inicio de actuaciones.</p>
<ul>
<li><em>Si la solicitud se acepta,</em> te informaremos vía correo electrónico; en ese momento, la distribuidora dispondrá de 15 días para efectuar el alta de suministro. Si fuera necesario, contactará contigo al teléfono que facilitaste al rellenar el formulario.</li>
<li><em>Si la solicitud se rechaza,</em> te informaremos de las gestiones necesarias.</li>
</ul>
<p><strong>3. Activación del contrato.</strong> Cuando el alta sea efectiva, nos lo comunicarán y te enviaremos un último correo electrónico indicando la fecha exacta. Con esta comunicación, el proceso de alta habrá finalizado.</p>
<p><strong>4.</strong> Posteriormente, en <strong>la primera factura</strong> se reflejará el coste del alta (que cobra la distribuidora) desglosado. Puedes consultar un cálculo orientativo en <a href="https://es.support.somenergia.coop/article/245-no-tengo-luz-actualmente-puedo-solicitar-un-nuevo-punto-de-consumo">este enlace</a>.</p>
% endif
<p>Información importante sobre tu contrato:</p>
<p>${text_desistiment}</p>
<p><strong>Sin permanencia.</strong> En Som Energia <strong>no tienes obligación de permanencia.</strong> Cuando quieras, puedes cambiar de comercializadora. Somos una cooperativa 100% renovable sin ánimo de lucro y uno de nuestros principios es ofrecer el precio lo más ajustado posible. No ofrecemos ofertas especiales, ni cláusulas adicionales ni letra pequeña. La transparencia, el buen trato, unos precios ajustados, el trabajo para un cambio de modelo energético, son algunos de los valores de Som Energia y el motivo por el cual tanta gente se suma al proyecto y continua, sin ninguna cláusula de permanencia.</p>
<p>Enlaces de interés:</p>
<ul>
<li><a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>: aquí puedes revisar el estado de tu contrato, modificar tus datos y consultar las facturas que vayamos emitiendo. <a href="https://es.support.somenergia.coop/category/141-uso-de-la-oficina-virtual">Uso de la Oficina Virtual.</a></li>
<li><a href="https://es.support.somenergia.coop/">Centro de Ayuda Som Energia</a>: encontrarás respuesta a las dudas más frecuentes, como por ejemplo: "¿Cómo puedo hacer un cambio de potencia o tarifa?", "¿Cómo puedo facilitar la lectura?", etc.</li>
<li><a href="https://participa.somenergia.coop/">Plataforma Participa</a>: el espacio de democracia interna y debate de la cooperativa. Aquí podrás participar activamente en la toma de decisiones y estar al día de los proyectos.</li>
</ul>
<p>¡Muchas gracias por escoger consumir buena energía!</p>
<p>Atentamente,</p>
<p>Equipo de Som Energia<br>comercializacion@somenergia.coop<br><a href="https://www.somenergia.coop">www.somenergia.coop</a></p>
% endif

${plantilla_footer}
