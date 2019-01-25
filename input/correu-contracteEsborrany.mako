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
            <p>
                Aquest és el resum de les dades facilitades en el formulari de contractació d'electricitat: <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Soci/a de Som Energia: ${object.soci.name} <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Titular del contracte d'electricitat: ${object.titular.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Pagador/a del contracte d'electricitat: ${object.pagador.name}<br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Adreça punt subministrament: ${object.cups_direccio}
                &nbsp;&nbsp;&nbsp;&nbsp;- Codi CUPS: ${object.cups.name}
            </p>
            % if not object.observacions or 'proces: A3' not in object.observacions:
                <p>
                    El procés de canvi de comercialitzadora consta dels següents passos:<br>
                    <br>
                    1. <b>Enviament de la sol·licitud a la distribuïdora</b>. Pas en el que estem actualment. Enviem la petició de canvi de comercialitzadora amb les dades facilitades.<br>
                    <br>
                    2. <b>Recepció de la resposta per part de la distribuïdora</b>. En un període màxim d'una setmana, rebem la resposta de si el procés de canvi de companyia es pot efectuar o si requereixen més informació. Si la sol·licitud s'ha acceptat, t'informarem via mail de la data prevista d'activació del teu contracte amb Som Energia. En cas contrari, també ens posarem en contacte amb tu.<br>
                    <br>
                    3. <b>Activació del contracte</b>. Una vegada la distribuïdora ens confirmi que el canvi s’ha fet efectiu i el contracte ja està <b>actiu</b> amb la cooperativa t’ho comunicarem per correu electrònic. A partir d'aleshores ja facturarem des de Som Energia però tingues en compte que encara rebràs l'última factura de la teva antiga comercialitzadora. En cas de voler fer <b> un canvi de potència o de tarifa</b> serà a partir d'aquest moment que ho podràs sol·licitar <a href="http://ca.support.somenergia.coop/article/271-com-puc-fer-una-modificacio-de-potencia-o-de-tarifa-i-quant-costa">(més informació)</a>.
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
                Enllaços d'interès:<br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- <a href="http://www.generationkwh.org/ca/">Generació kWh:</a> Ara també pots generar la teva pròpia energia renovable de forma col·lectiva. A l'enllaç hi trobaràs un vídeo explicatiu.<br>
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
            <p>
                Este es el resumen de los datos facilitados en el formulario de contratación de electricidad:<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Socio/a de Som Energia: ${object.soci.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Titular del contrato de electricidad: ${object.titular.name}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Pagador/a del contrato de electricidad: ${object.pagador.name}<br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Dirección punto de suministro: ${object.cups_direccio}<br>
                &nbsp;&nbsp;&nbsp;&nbsp;- Código CUPS: ${object.cups.name}
            </p>
            % if not object.observacions or 'proces: A3' not in object.observacions:
                <p>
                    El proceso de cambio de comercializadora consta de los siguientes pasos:<br>
                    1. <b>Envío de la solicitud a la distribuidora</b>. Paso en que estamos en estos momentos. Enviamos la petición de cambio de comercializadora con los datos facilitados.<br>
                    <br>
                    2. <b>Recepción de la respuesta por parte de la distribuidora</b>. En un periodo máximo de una semana, recibimos la respuesta de si el proceso de cambio de compañía se puede efectuar, o si requieren más información.  Si la solicitud se ha aceptado, te informaremos vía correo electrónico de la fecha prevista de activación de tu contrato con Som Energia. En caso contrario, también nos pondremos en contacto contigo.<br>
                    <br>
                    3. <b> Activación del contrato </b>. Una vez la distribuidora nos confirme que el cambio se ha hecho efectivo y que el contrato ya está <b>activo</b> con la cooperativa, te lo comunicaremos por correo electrónico. A partir de entonces ya facturaremos desde Som Energia, pero ten en cuenta que aún recibirás la última factura de tu antigua comercializadora. En caso de querer hacer <b> un cambio de potencia o de tarifa </b> será a partir de este momento que lo podrás solicitar <a href="http://es.support.somenergia.coop/article/284-como-puedo-hacer-una-modificacion-de-potencia-o-de-tarifa-y-cuanto-cuesta">(más información)</a>.<br>
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
                Enlaces de interés: <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;- <a href="http://www.generationkwh.org/es/">Generación kWh:</a> Ahora también puedes generar tu propia energía renovable de forma colectiva. En el enlace encontrarás un vídeo explicativo.<br>
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
    </body>
</html>
