<!doctype html>
<html>
<head></head>
<body>
<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">
% if object.titular.lang == "ca_ES":
Benvolgut/da,

Ja has completat la sol·licitud per contractar el teu subministrament elèctric amb Som Energia.  

Aquest és el resum de les dades facilitades en el formulari de contractació d'electricitat:

- Soci/a de Som Energia: ${object.soci.name}
- Titular del contracte d'electricitat: ${object.titular.name}
- Pagador/a del contracte d'electricitat: ${object.pagador.name}

- Adreça punt subministrament: ${object.cups_direccio}
- Codi CUPS: ${object.cups.name}

% if not object.observacions or 'proces: A3' not in object.observacions:

El procés de canvi de comercialitzadora consta dels següents pasos:

1. <b>Enviament de la sol·licitud a la distribuïdora</b>. Pas en el que estem actualment. Enviem la petició de canvi de comercialitzadora amb les dades facilitades.

2. <b>Recepció de la resposta per part de la distribuïdora</b>. En un període màxim de dues setmanes, rebem la resposta de si el procés de canvi de companyia es pot efectuar o si requereixen més informació. Si la sol·licitud s'ha acceptat, t'informarem via mail de la data prevista d'activació del teu contracte amb Som Energia, <u>normalment entre 2 i 7 setmanes després</u>. En cas contrari, també ens posarem en contacte amb tu.

3. <b>Activació del contracte</b>. Quan rebem la lectura periòdica del teu comptador, s'activarà el contracte amb la cooperativa. A partir d'aleshores ja facturarem des de Som Energia però tingues en compte que encara rebràs l'última factura de la teva antiga comercialitzadora. En cas de voler fer <b> un canvi de potència o de tarifa</b> serà a partir d'aquest moment que ho podràs sol·licitar <a href="http://ca.support.somenergia.coop/article/271-com-puc-fer-una-modificacio-de-potencia-o-de-tarifa-i-quant-costa">(més informació)</a>.

% else:

El procés d’alta de subministrament consta dels següents passos: 

1. <b>Enviament de la sol·licitud a la distribuïdora.</b> Pas en què estem actualment. Enviem la petició d’alta amb les dades facilitades.

2. <b>Recepció de la resposta per part de la distribuïdora.</b> En uns dies rebrem la resposta d’inici d’actuacions. 

    - <i>Si la sol·licitud s'ha acceptat</i>, t'informarem via correu electrònic; en aquest moment, la distribuïdora disposarà de 15 dies per efectuar l’alta de subministrament. En cas necessari, contactaran amb tu al telèfon que vares facilitar en emplenar el formulari. 

    - <i>En cas contrari,</i> t’informarem dels passos a seguir.

3. <b>Activació del contracte.</b> Quan l’alta sigui efectiva, ens ho faran saber i t’enviarem un darrer correu electrònic indicant la data exacta. Amb aquesta comunicació el procés d’alta haurà finalitzat. 

4. Posteriorment, <b>a la primera factura</b> inclourem els costos de l’alta (que cobra la distribuïdora) desglossats. Pots consultar un càlcul orientatiu dels costos en <a href="http://ca.support.somenergia.coop/article/225-no-tinc-llum-actualment-puc-sol-licitar-un-nou-punt-de-consum">aquest enllaç</a>.

% endif

Enllaços d'interès:

- <a href="https://oficinavirtual.somenergia.coop/ca">Oficina Virtual:</a> Aquí pots revisar l'estat del teu contracte i les factures que emetrem. <a href="http://ca.support.somenergia.coop/category/72-oficina-virtual">Ús de l'Oficina Virtual.</a>

- <b><a href="http://ca.support.somenergia.coop/">Centre de Suport Som Energia:</a></b> Aquí hi trobaràs resolts els dubtes més freqüents, com per exemple: "Com puc fer un canvi de potència o tarifa?", "Com puc facilitar la lectura?", etc.


Moltes gràcies per triar bona energia!

Atentament,

Equip de Som Energia
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
comercialitzacio@somenergia.coop
% else:
Apreciado/a,

Ya has completado la solicitud para contratar tu suministro eléctrico a través de la cooperativa Som Energia.

Este es el resumen de los datos facilitados en el formulario de contratación de electricidad:

- Socio/a de Som Energia: ${object.soci.name}
- Titular del contrato de electricidad: ${object.titular.name}
- Pagador/a del contrato de electricidad: ${object.pagador.name}

- Dirección punto de suministro: ${object.cups_direccio}
- Código CUPS: ${object.cups.name}

% if 'proces: A3' not in object.observacions:

El proceso de cambio de comercializadora consta de los siguientes pasos:

1. <b>Envío de la solicitud a la distribuidora</b>. Paso en que estamos en estos momentos. 

2. <b>Recepción de la respuesta por parte de la distribuidora</b>. En un periodo máximo de dos semanas recibimos la respuesta de si el proceso de cambio de compañía se puede efectuar, o si requieren más información.  Si la solicitud se ha aceptado, te informaremos vía correo electrónico de la fecha prevista de activación de tu contrato con Som Energia, <u> normalmente es entre 2 y 7 semanas después</u>. En caso contrario, también nos pondremos en contacto contigo.

3. <b> Activación del contrato </b>. Cuando recibamos la lectura periódica de tu contador, se activará el contrato con la cooperativa. A partir de entonces ya facturaremos desde Som Energia, pero ten en cuenta que aún recibirás la última factura de tu antigua comercializadora. En caso de querer hacer <b> un cambio de potencia o de tarifa </b> será a partir de este momento que lo podrás solicitar <a href="http://es.support.somenergia.coop/article/284-como-puedo-hacer-una-modificacion-de-potencia-o-de-tarifa-y-cuanto-cuesta">(más información)</a>.

% else:

El proceso de alta de suministro consta de los siguientes pasos: 

1. <b>Envío de la solicitud a la distribuidora.</b> Paso en el que estamos actualmente. Enviamos la petición de alta con los datos facilitados.

2. <b>Recepción de la respuesta por parte de la distribuidora.</b> En unos días recibiremos la respuesta de inicio de actuaciones.

    - <i>Si la solicitud se acepta,</i> te informaremos vía correo electrónico; en ese momento, la distribuidora dispondrá de 15 días para efectuar el alta de suministro. Si fuera necesario, contactará contigo al teléfono que facilitaste al rellenar el formulario. 

    - <i>De lo contrario,</i> te informaremos de las gestiones necesarias.

3. <b>Activación del contrato.</b> Cuando el alta sea efectiva, nos lo comunicarán y te enviaremos un último correo electrónico indicando la fecha exacta. Con esta comunicación, el proceso de alta habrá finalizado. 

4. Posteriormente, en <b>la primera factura</b> se reflejará el coste del alta (que cobra la distribuidora) desglosado. Puedes consultar un cálculo orientativo en <a href="http://es.support.somenergia.coop/article/245-no-tengo-luz-actualmente-puedo-solicitar-un-nuevo-punto-de-consumo">este enlace</a>.


% endif

Enlaces de interés:

- <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>: Aquí puedes revisar el estado de tu contrato y las facturas que emitiremos a través de nuestra Oficina Virtual.  <a href="http://es.support.somenergia.coop/category/141-uso-de-la-oficina-virtual">Uso de la Oficina Virtual.</a>

- <a href="http://es.support.somenergia.coop/">Centro de Ayuda Som Energia.</a>: Aquí encontrarás resueltas las dudas más frecuentes, como por ejemplo: "¿Cómo puedo hacer un cambio de potencia o tarifa?", "¿Cómo puedo facilitar la lectura?", etc.

¡Muchas gracias por escoger consumir buena energía!

Atentamente,

Equip de Som Energia
<a href="www.somenergia.coop">www.somenergia.coop</a>
comercialitzacion@somenergia.coop
%endif
</body>
</html>
