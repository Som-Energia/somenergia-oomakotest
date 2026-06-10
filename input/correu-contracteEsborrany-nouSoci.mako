<%
import time
from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        lang=object_.soci.lang,
        # The clar/fosc is reversed because here refers to the background color
        light_logo='https://www.somenergia.coop/logo/logo_header_socies_fosc.png',
        dark_logo='https://www.somenergia.coop/logo/logo_header_socies_clar.png',
        logo_link='https://www.somenergia.coop',
        logo_css_style='width: 570px;',
        format_exceptions=True,
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
template_social_links_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_social_links')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_social_links = render(t_obj.read(object._cr, object._uid, [template_social_links_id], ['def_body_text'])[0]['def_body_text'], object)

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


partner_obj = object.pool.get('res.partner')
is_company = partner_obj.vat_es_empresa(object._cr, object._uid, object.soci.vat)
nom_titular = partner_obj.separa_cognoms(
    object._cr, object._uid, object.soci.name
)['nom'] if not is_company else object.soci.name

email_info = 'empresa@somenergia.coop' if is_company else 'info@somenergia.coop'

ingres = time.strftime('%d/%m/%y')
def socifilter(text):
    return str(int(''.join([a for a in text if a.isdigit()])))

%>

${plantilla_header}

            % if object.titular.lang == "ca_ES":
<p>Hola, ${nom_titular}!</p>
<p>Et donem la <strong>benvinguda a Som Energia!</strong></p>
<p>Acabes de fer dues coses importants: <strong>associar-te</strong> a la cooperativa, i completar la <strong>sol·licitud per contractar</strong> el teu subministrament elèctric a través de Som Energia.</p>
<p>Segurament fa uns dies que estàs informant-te sobre Som Energia, veient si t'associes, si passes el contracte, quina tarifa agafes... Possiblement, després d'haver fet el procés, tens el cap una mica saturat, i és que el món del mercat elèctric és complex, prou que ho sabem. Per això, un dels nostres objectius, ara mateix, és posar-te les coses fàcils i no atabalar-te més. <strong>No volem complicar-te la vida, sinó facilitar-te-la.</strong></p>
<p>A continuació, doncs, ens limitarem a donar-te les dades bàsiques de tot plegat, i t'expliquem com seguirà el procés.</p>
<h2>Les teves dades com a cooperativista:</h2>
<table border="0" width="430" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center"><strong>El teu núm. de persona sòcia és: ${object.soci.ref | socifilter}</strong></p>
<p align="center">Nom: ${object.soci.name}</p>
<p align="center">Data d'entrada: ${ingres}</p>
<p align="center">Aportació obligatòria al capital social: 100 euros.</p>
</fieldset></td>
</tr>
</tbody>
</table>
<br>
<h2>Informació del teu contracte d'electricitat:</h2>
<table border="0" width="430" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center">Titular del contracte d'electricitat: ${object.titular.name}</p>
<p align="center">Adreça punt subministrament: ${object.cups_direccio}</p>
<p align="center">Codi CUPS: ${object.cups.name}</p>
<p align="center">Tarifa: ${tarifa_a_mostrar}</p>
</fieldset></td>
</tr>
</tbody>
</table>
<br>
<p>Adjunt a aquest correu t'enviem les condicions generals i les condicions particulars del teu contracte.</p>
            % if not object.observacions or 'proces: A3' not in object.observacions:
<h3>Procés del canvi de comercialitzadora:</h3>
<p>El procés de canvi de comercialitzadora consta d'una sèrie de passos:</p>
<img style="width: 475px;" src="https://www.somenergia.coop/wpsom/static/email/esquema_canvi_comer_CA.png" alt="Esquema canvi comercialitzadora"/>
<p><strong>1. Enviament de la sol·licitud a la distribuïdora.</strong> Actualment estem en aquest punt. Hem enviat la petició de canvi de comercialitzadora amb les dades facilitades.</p>
<p><strong>2. Recepció de la resposta per part de la distribuïdora.</strong> En un període màxim d'una setmana rebrem la resposta de si el procés de canvi de companyia es pot efectuar o si requereixen més informació. Si la sol·licitud ha sigut rebutjada t'ho comunicarem per indicar-te com procedir.</p>
<p><strong>3. Activació del contracte.</strong> Una vegada la distribuïdora ens confirmi que el canvi s'ha fet efectiu i el <strong>contracte</strong> ja estigui <strong>actiu amb la cooperativa</strong> t'ho comunicarem per correu electrònic. A partir d'aleshores ja facturarem des de Som Energia. Tingues en compte, però, que encara rebràs l'última factura de la teva antiga comercialitzadora. En cas de voler fer un canvi de potència serà a partir d'aquest moment que ho podràs sol·licitar (<a target="_blank" href="https://ca.support.somenergia.coop/article/271-com-puc-fer-una-modificacio-de-potencia-o-de-tarifa-i-quant-costa">més informació</a>).</p>
            % else:
<h3>Procés d'alta de subministrament:</h3>
<p>El procés d'alta de subministrament consta dels següents passos:</p>
<img style="width: 475px;" src="https://www.somenergia.coop/wpsom/static/email/esquema_canvi_comer_CA.png" alt="Esquema alta subministrament"/>
<p><strong>1. Enviament de la sol·licitud a la distribuïdora.</strong> És el pas en què estem actualment. Enviem la petició d'alta de subministrament amb totes les dades que ens has facilitat.</p>
<p><strong>2. Recepció de la resposta per part de la distribuïdora.</strong> En uns dies rebrem la resposta d'inici d'actuacions.</p>
<ul>
<li><em>Si la sol·licitud s'ha acceptat</em>, t'informarem via correu electrònic; en aquest moment, la distribuïdora disposarà de 15 dies per efectuar l'alta de subministrament. En cas necessari, contactaran amb tu al telèfon que vares facilitar en emplenar el formulari.</li>
<li><em>En cas contrari,</em> t'informarem dels passos a seguir.</li>
</ul>
<p><strong>3. Activació del contracte.</strong> Quan l'alta sigui efectiva, ens ho faran saber i t'enviarem un darrer correu electrònic indicant la data exacta. Amb aquesta comunicació el procés d'alta haurà finalitzat.</p>
<p><strong>4.</strong> Posteriorment, <strong>a la primera factura</strong> inclourem els costos de l'alta (que cobra la distribuïdora) desglossats. Pots consultar un càlcul orientatiu dels costos en <a href="https://ca.support.somenergia.coop/article/225-no-tinc-llum-actualment-puc-sol-licitar-un-nou-punt-de-consum">aquest enllaç</a>.</p>
            % endif
<h3>Si et vols fer enrere…</h3>
<p>Desitgem que no sigui així! Però igualment t'informem del teu dret de desistiment del contracte d'electricitat i les seves conseqüències:</p>
<div class='background-text'>${text_desistiment}</div>
<br>
<p>Et recordem que la titularitat del contracte de subministrament ha de recaure en l'usuari efectiu de l'electricitat contractada i que ha de tenir un just títol (contracte d'arrendament, etc.) sobre el punt de subministrament.</p>
<p><strong>Res més per avui!</strong> D'aquí a uns dies t'explicarem una mica més sobre la cooperativa i les opcions que se t'obren ara mateix.</p>
<p>Mentrestant, si et ve de gust, ens podem trobar a les xarxes socials:</p>
${plantilla_social_links}
<br>
<p><strong>Si tens qualsevol dubte</strong>, ens pots trucar al 872.202.550 (t'atendrem de dilluns a divendres de 9 a 14 h) o enviar-nos un correu a ${email_info}.</p>
<p><strong>${nom_titular}, ens fa molta il·lusió tenir-te entre nosaltres!</strong></p>
<p dir="ltr">&nbsp;</p>
<p>Fins aviat,</p>

        % else:
<p>¡Hola, ${nom_titular}!</p>
<p>¡Te damos la <strong>bienvenida a Som Energia!</strong></p>
<p>Acabas de hacer dos cosas importantes: <strong>unirte</strong> a la cooperativa, y completar la <strong>solicitud para contratar</strong> tu suministro eléctrico a través de Som Energia.</p>
<p>Seguramente hace unos días que estás informándote sobre Som Energia, viendo si te asocias, si pasas el contrato, qué tarifa coges... Posiblemente, después de haber hecho el proceso, tienes la cabeza algo saturada, y es que el mundo del mercado eléctrico es complejo, lo sabemos. Por eso, uno de nuestros objetivos, ahora mismo, es ponerte las cosas fáciles y no agobiarte más. <strong>No queremos complicarte la vida, sino facilitártela.</strong></p>
<p>A continuación nos limitaremos a darte los datos básicos, y te explicamos cómo seguirá el proceso.</p>
<h2>Tus datos como cooperativista:</h2>
<table border="0" width="430" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center"><strong>Tu nº. de socio/socia es: ${object.soci.ref | socifilter}</strong></p>
<p align="center">Nombre: ${object.soci.name}</p>
<p align="center">Fecha de entrada: ${ingres}</p>
<p align="center">Aportación obligatoria al capital social: 100 euros.</p>
</fieldset></td>
</tr>
</tbody>
</table>
<br>
<h2>Información de tu contrato de electricidad:</h2>
<table border="0" width="430" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center">Titular del contrato de electricidad: ${object.titular.name}</p>
<p align="center">Dirección del punto de suministro: ${object.cups_direccio}</p>
<p align="center">Código CUPS: ${object.cups.name}</p>
<p align="center">Tarifa: ${tarifa_a_mostrar}</p>
</fieldset></td>
</tr>
</tbody>
</table>
<br>
<p>Adjunto a este correo te enviamos las condiciones generales y condiciones particulares de tu contrato.</p>
            % if not object.observacions or 'proces: A3' not in object.observacions:
<h3>Proceso del cambio de comercializadora:</h3>
<p>El proceso de cambio de comercializadora consta de una serie de pasos:</p>
<img style="width: 475px;" src="https://www.somenergia.coop/wpsom/static/email/esquema_canvi_comer_ES.png" alt="Esquema cambio comercializadora"/>
<p><strong>1. Envío de la solicitud a la distribuidora.</strong> Actualmente estamos en ese punto. Hemos enviado la petición de cambio de comercializadora con los datos facilitados.</p>
<p><strong>2. Recepción de la respuesta por parte de la distribuidora.</strong> En un periodo máximo de una semana recibiremos la respuesta de si el proceso de cambio de compañía puede efectuarse o si requieren más información. Si la solicitud ha sido rechazada te lo comunicaremos para indicarte cómo proceder.</p>
<p><strong>3. Activación del contrato.</strong> Una vez la distribuidora nos confirme que el cambio se ha hecho efectivo y el <strong>contrato</strong> ya esté <strong>activo con la cooperativa</strong> te lo comunicaremos por correo electrónico. A partir de entonces ya facturaremos desde Som Energia. Sin embargo, ten en cuenta que todavía recibirás la última factura de tu antigua comercializadora. En caso de querer hacer un cambio de potencia será a partir de ese momento cuando lo podrás solicitar (<a target="_blank" href="https://es.support.somenergia.coop/article/284-como-puedo-hacer-una-modificacion-de-potencia-o-de-tarifa-y-cuanto-cuesta">más información</a>).</p>
            % else:
<h3>Proceso de alta de suministro:</h3>
<p>El proceso de alta de suministro consta de los siguientes pasos:</p>
<img style="width: 475px;" src="https://www.somenergia.coop/wpsom/static/email/esquema_canvi_comer_ES.png" alt="Esquema alta suministro"/>
<p><strong>1. Envío de la solicitud a la distribuidora.</strong> Es el paso en el que estamos actualmente. Enviamos la petición de alta con los datos facilitados.</p>
<p><strong>2. Recepción de la respuesta por parte de la distribuidora.</strong> En unos días recibiremos la respuesta de inicio de actuaciones.</p>
<ul>
<li><em>Si la solicitud se acepta,</em> te informaremos vía correo electrónico; en ese momento, la distribuidora dispondrá de 15 días para efectuar el alta de suministro. Si fuera necesario, contactará contigo al teléfono que facilitaste al rellenar el formulario.</li>
<li><em>Si la solicitud se rechaza,</em> te informaremos de las gestiones necesarias.</li>
</ul>
<p><strong>3. Activación del contrato.</strong> Cuando el alta sea efectiva, nos lo comunicarán y te enviaremos un último correo electrónico indicando la fecha exacta. Con esta comunicación, el proceso de alta habrá finalizado.</p>
<p><strong>4.</strong> Posteriormente, en <strong>la primera factura</strong> se reflejará el coste del alta (que cobra la distribuidora) desglosado. Puedes consultar un cálculo orientativo en <a href="https://es.support.somenergia.coop/article/245-no-tengo-luz-actualmente-puedo-solicitar-un-nuevo-punto-de-consumo">este enlace</a>.</p>
            % endif
<h3>Si te quieres echar atrás…</h3>
<p>¡Deseamos que no sea así! Pero igualmente te informamos de tu derecho de desistimiento del contrato de electricidad y sus consecuencias:</p>
<div class='background-text'>${text_desistiment}</div>
<br>
<p>Te recordamos que la titularidad del contrato de suministro debe recaer en el usuario efectivo de la electricidad contratada y que debe tener un justo título (contrato de arrendamiento, etc.) sobre el punto de suministro.</p>
<p><strong>¡Nada más por hoy!</strong> En unos días te explicaremos un poco más sobre la cooperativa y las opciones que se te abren ahora mismo.</p>
<p>Mientras, si te apetece, nos podemos encontrar en las redes sociales:</p>
${plantilla_social_links}
<br>
<p><strong>Si tienes cualquier duda</strong>, nos puedes llamar al 872.202.550 (te atenderemos de lunes a viernes de 9 a 14 h) o enviarnos un correo a ${email_info}.</p>
<p><strong>${nom_titular}, ¡nos hace mucha ilusión tenerte entre nosotros!</strong></p>
<p dir="ltr">&nbsp;</p>
<p>Hasta pronto,</p>

        % endif

<p><a href="https://www.somenergia.coop" target="_blank"><picture>
    <source srcset="https://www.somenergia.coop/logo/logo_fosc_100px.png" media="(prefers-color-scheme: light)"/>
    <source srcset="https://www.somenergia.coop/logo/logo_clar_100px.png" media="(prefers-color-scheme: dark)"/>
    <img src="https://www.somenergia.coop/logo/logo_fosc_100px.png" alt="Som Energia" style="height: 60px;"/>
</picture></a></p>

${plantilla_footer}
