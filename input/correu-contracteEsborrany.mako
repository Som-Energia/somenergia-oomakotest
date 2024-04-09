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
template_id = md_obj.get_object_reference(
￼        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_rejection_text'
￼    )[1]
￼
text_desistiment = render(
￼    t_obj.read(object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
￼    object
￼)
tarifa_a_mostrar = ""

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

<!doctype html>
<html>
    <head></head>
    <body>
        <img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">
        % if object.titular.lang == "ca_ES":
            <p>
                Benvolgut/da,
            </p>
            <p>
                Ja has completat la sol·licitud per contractar el teu subministrament elèctric amb Som Energia.
            </p>
            % if object.mode_facturacio == "index":
            <p>
                T'adjuntem les condicions generals, específiques i particulars del teu contracte.
            </p>
            % else:
            <p>
                T'adjuntem les condicions generals i particulars del teu contracte.
            </p>
            % endif
            <p>
                Aquest és el resum de les dades facilitades en el formulari de contractació d'electricitat: <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Soci/a de Som Energia: ${object.soci.name} <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Titular del contracte d'electricitat: ${object.titular.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Adreça punt subministrament: ${object.cups_direccio}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Codi CUPS: ${object.cups.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Tarifa: ${tarifa_a_mostrar}<br>
            </p>
            % if not object.observacions or 'proces: A3' not in object.observacions:
                <p>
                    Recorda que el titular del contracte de subministrament ha de ser l’usuari efectiu de l’electricitat contractada i que ha de tenir un just títol (contracte d’arrendament, etc.) sobre el punt de subministrament.
                </p>
                <p>
                    El procés de canvi de comercialitzadora consta dels següents passos:<br>
                    <br>
                    1. <b>Enviament de la sol·licitud a la distribuïdora</b>. Pas en el qual estem actualment. Enviem la petició de canvi de comercialitzadora amb les dades facilitades.<br>
                    <br>
                    2. <b>Recepció de la resposta per part de la distribuïdora</b>. En un període màxim d'una setmana rebrem la resposta de si el procés de canvi de companyia es pot efectuar o si requereixen més informació. Si la sol·licitud s'ha acceptat, t'informarem via correu electrònic de la data prevista d'activació del teu contracte amb Som Energia. En cas contrari, també ens posarem en contacte amb tu.<br>
                    <br>
                    3. <b>Activació del contracte</b>. Una vegada la distribuïdora ens confirmi que el canvi s’ha fet efectiu i el contracte ja està <b>actiu</b> amb la cooperativa t’ho comunicarem per correu electrònic. A partir d'aleshores ja facturarem des de Som Energia, però tingues en compte que encara rebràs l'última factura de la teva antiga comercialitzadora. En cas de voler fer <b> un canvi de potència</b> serà a partir d'aquest moment que ho podràs sol·licitar <a href="http://ca.support.somenergia.coop/article/271-com-puc-fer-una-modificacio-de-potencia-o-de-tarifa-i-quant-costa">(més informació)</a>.
                </p>
            % else:
                <p>
                    El procés d’alta de subministrament consta dels següents passos:<br>
                    <br>
                    1. <b>Enviament de la sol·licitud a la distribuïdora.</b> Pas en què estem actualment. Enviem la petició d’alta amb les dades facilitades.<br>
                    <br>
                    2. <b>Recepció de la resposta per part de la distribuïdora.</b> En uns dies rebrem la resposta d’inici d’actuacions.<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;- <i>Si la sol·licitud s'ha acceptat</i>, t'informarem via correu electrònic; en aquest moment, la distribuïdora disposarà de 15 dies per efectuar l’alta de subministrament. En cas necessari, contactaran amb tu al telèfon que vares facilitar en emplenar el formulari.<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;- <i>En cas contrari,</i> t’informarem dels passos a seguir.<br>
                    <br>
                    3. <b>Activació del contracte.</b> Quan l’alta sigui efectiva, ens ho faran saber i t’enviarem un darrer correu electrònic indicant la data exacta. Amb aquesta comunicació el procés d’alta haurà finalitzat.<br>
                    <br>
                    4. Posteriorment, <b>a la primera factura</b> inclourem els costos de l’alta (que cobra la distribuïdora) desglossats. Pots consultar un càlcul orientatiu dels costos en <a href="http://ca.support.somenergia.coop/article/225-no-tinc-llum-actualment-puc-sol-licitar-un-nou-punt-de-consum">aquest enllaç</a>.
                </p>
            % endif
            <p>
                Informació rellevant en el procés de contractació:<br>
            </p>
            ${text_desistiment}
                <p>
                    A Som Energia <b>no tens cap obligació de permanència.</b> En el moment que vulguis, pots canviar de companyia comercialitzadora. Som una cooperativa d’electricitat 100% renovable sense ànim de lucre i un dels nostres principis és oferir el preu més ajustat possible. No oferim ofertes especials, ni clàusules addicionals, ni lletra petita. La transparència, el bon tracte, uns preus ajustats, el treball per un canvi de model energètic, són alguns dels valors de Som Energia i el motiu pel qual tanta gent se suma al projecte i continua amb nosaltres sense cap clàusula de permanència.
                </p>
            <p>
                Enllaços d'interès:<br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- <a href="http://oficinavirtual.somenergia.coop/ca">Oficina Virtual:</a> Aquí pots revisar l'estat del teu contracte i les factures que emetrem. <a href="http://ca.support.somenergia.coop/category/72-oficina-virtual">Ús de l'Oficina Virtual.</a><br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- <b><a href="http://ca.support.somenergia.coop/">Centre de Suport Som Energia:</a></b> Aquí hi trobaràs resolts els dubtes més freqüents, com per exemple: "Com puc fer un canvi de potència o tarifa?", "Com puc facilitar la lectura?", etc.<br>
            </p>
            <p>
                Moltes gràcies per triar bona energia!<br>
                <br>
                Atentament,
            </p>
            <p>
                Equip de Som Energia<br>
                <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
                <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
            </p>
        % else:
            <p>
                Apreciado/a,
            </p>
            <p>
                Ya has completado la solicitud para contratar tu suministro eléctrico a través de la cooperativa Som Energia.
            </p>
            % if object.mode_facturacio == "index":
            <p>
                Te adjuntamos las condiciones generales, específicas y particulares de tu contrato.
            </p>
            % else:
            <p>
                Te adjuntamos las condiciones generales y particulares de tu contrato.
            </p>
            % endif
            <p>
                Este es el resumen de los datos facilitados en el formulario de contratación de electricidad:<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Socio/a de Som Energia: ${object.soci.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Titular del contrato de electricidad: ${object.titular.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Dirección punto de suministro: ${object.cups_direccio}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Código CUPS: ${object.cups.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Tarifa: ${tarifa_a_mostrar}<br>
            </p>
            % if not object.observacions or 'proces: A3' not in object.observacions:
                <p>
                    Recuerda que el titular del contrato de suministro tiene que ser el usuario efectivo de la electricidad contratada y que tiene que tener un justo título (contrato de arrendamiento, etc.) sobre el punto de suministro.
                </p>
                <p>
                    El proceso de cambio de comercializadora consta de los siguientes pasos:<br>
                    1. <b>Envío de la solicitud a la distribuidora</b>. Paso en el que estamos en estos momentos. Enviamos la petición de cambio de comercializadora con los datos facilitados.<br>
                    <br>
                    2. <b>Recepción de la respuesta por parte de la distribuidora</b>. En un periodo máximo de una semana, recibiremos la respuesta de si el proceso de cambio de compañía se puede efectuar, o si requieren más información.  Si la solicitud se ha aceptado, te informaremos vía correo electrónico de la fecha prevista de activación de tu contrato con Som Energia. En caso contrario, también nos pondremos en contacto contigo.<br>
                    <br>
                    3. <b> Activación del contrato </b>. Una vez la distribuidora nos confirme que el cambio se ha hecho efectivo y que el contrato ya está <b>activo</b> con la cooperativa, te lo comunicaremos por correo electrónico. A partir de entonces ya facturaremos desde Som Energia, pero ten en cuenta que aún recibirás la última factura de tu antigua comercializadora. En caso de querer hacer <b> un cambio de potencia</b> será a partir de este momento cuando lo podrás solicitar <a href="http://es.support.somenergia.coop/article/284-como-puedo-hacer-una-modificacion-de-potencia-o-de-tarifa-y-cuanto-cuesta">(más información)</a>.<br>
                    <br>
                </p>
            % else:
                <p>
                    El proceso de alta de suministro consta de los siguientes pasos:<br>
                    1. <b>Envío de la solicitud a la distribuidora.</b> Paso en el que estamos actualmente. Enviamos la petición de alta con los datos facilitados.<br>
                    <br>
                    2. <b>Recepción de la respuesta por parte de la distribuidora.</b> En unos días recibiremos la respuesta de inicio de actuaciones.<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;- <i>Si la solicitud se acepta,</i> te informaremos vía correo electrónico; en ese momento, la distribuidora dispondrá de 15 días para efectuar el alta de suministro. Si fuera necesario, contactará contigo al teléfono que facilitaste al rellenar el formulario.<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;- <i>De lo contrario,</i> te informaremos de las gestiones necesarias.<br>
                    <br>
                    3. <b>Activación del contrato.</b> Cuando el alta sea efectiva, nos lo comunicarán y te enviaremos un último correo electrónico indicando la fecha exacta. Con esta comunicación, el proceso de alta habrá finalizado.<br>
                    <br>
                    4. Posteriormente, en <b>la primera factura</b> se reflejará el coste del alta (que cobra la distribuidora) desglosado. Puedes consultar un cálculo orientativo en <a href="http://es.support.somenergia.coop/article/245-no-tengo-luz-actualmente-puedo-solicitar-un-nuevo-punto-de-consumo">este enlace</a>.<br>
                </p>
            % endif
            <p>
                Información referente al proceso de contratación:<br>
            </p>
            ${text_desistiment}
                <p>
                    En Som Energia <b>no tienes obligación de permanencia.</b> Cuando quieras, puedes cambiar de compañia comercializadora. Somos una cooperativa 100% renovable sin ánimo de lucro y uno de nuestros principios es ofrecer el precio lo más ajustado posible. No ofrecemos ofertas especiales, ni cláusulas adicionales ni letra pequeña. La transparencia, el buen trato, unos precios ajustados, el trabajo para un cambio de modelo energético, son algunos de los valores de Som Energia y el motivo por el cual tanta gente se suma al proyecto y sigue con nosotros, sin ninguna cláusula de permanencia.
                </p>
            <p>
                Enlaces de interés: <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- <a href="http://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>: Aquí puedes revisar el estado de tu contrato y las facturas que emitiremos a través de nuestra Oficina Virtual.  <a href="http://es.support.somenergia.coop/category/141-uso-de-la-oficina-virtual">Uso de la Oficina Virtual.</a><br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- <a href="http://es.support.somenergia.coop/">Centro de Ayuda Som Energia.</a>: Aquí encontrarás resueltas las dudas más frecuentes, como por ejemplo: "¿Cómo puedo hacer un cambio de potencia o tarifa?", "¿Cómo puedo facilitar la lectura?", etc.<br>
            </p>
            <p>
                ¡Muchas gracias por escoger consumir buena energía!<br>
                <br>
                Atentamente,
            </p>
            <p>
                Equip de Som Energia<br>
                <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
                <a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
            </p>
        % endif
        ${text_legal}
    </body>
</html>
