<!doctype html>
<html>
<head></head>
<body>
<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">
% if object.titular.lang == "ca_ES":
Benvolgut/da,

Ja has completat la sol·licitud per contractar el teu subministrament elèctric amb Som Energia.  

Aquest és el resum de les dades facilitades en el formulari de contractació d'electricitat:

<table width="60%" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td><fieldset><P ALIGN=center><
Soci/a de Som Energia: ${object.soci.name}
Titular del contracte d'electricitat: ${object.titular.name}
Pagador/a del contracte d'electricitat: ${object.pagador.name}

Adreça punt subministrament: ${object.cups_direccio}
Codi CUPS: ${object.cups.name}</fieldset></td></tr></table>

% if not object.observacions or 'process: A3' not in object.observacions:

El procés de canvi de comercialitzadora consta dels següents pasos:

1. <b>Enviament de la sol·licitud a la distribuïdora</b>. Pas en el que estem actualment. Enviem la petició de canvi de comercialitzadora amb les dades facilitades.

2. <b>Recepció de la resposta per part de la distribuïdora</b>. En un període màxim de dues setmanes, rebem la resposta de si el procés de canvi de companyia es pot efectuar o si requereixen més informació. Si la sol·licitud s'ha acceptat, t'informarem via mail de la data prevista d'activació del teu contracte amb Som Energia, <u>normalment entre 2 i 7 setmanes després</u>. En cas contrari, també ens posarem en contacte amb tu.

3. <b>Activació del contracte</b>. Quan rebem una lectura del teu comptador, és quan s'activa el contracte amb la cooperativa. A partir d'aleshores ja facturarem des de Som Energia però tingues en compte que encara rebràs l'última factura de la teva antiga comercialitzadora. En cas de voler fer <b> un canvi de potència o de tarifa</b> serà a partir d'aquest moment que ho podràs sol·licitar <a href="http://ca.support.somenergia.coop/article/271-com-puc-fer-una-modificacio-de-potencia-o-de-tarifa-i-quant-costa">(més informació)</a>.

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

- <a href="http://mandrillapp.com/track/click/30198970/oficinavirtual.somenergia.coop?p=eyJzIjoiaU9GbS11bFZWd21FbkUtN1VGeDNNVUFxLWprIiwidiI6MSwicCI6IntcInVcIjozMDE5ODk3MCxcInZcIjoxLFwidXJsXCI6XCJodHRwczpcXFwvXFxcL29maWNpbmF2aXJ0dWFsLnNvbWVuZXJnaWEuY29vcFxcXC9jYVxcXC9sb2dpblxcXC9cIixcImlkXCI6XCI3ZDc5NDQ5YzNiYWY0YmQwYmRjOGUwZTRjNGM3NzkyOVwiLFwidXJsX2lkc1wiOltcIjJmMGFiMzY4MjY3MTgzZWUxNWNlZmQxMDMyYTk5MmRhOTBkYzk1NjZcIl19In0">Oficina Virtual:</a> Aquí pots revisar l'estat del teu contracte i les factures que emetrem. <a href="http://mandrillapp.com/track/click/30198970/ca.support.somenergia.coop?p=eyJzIjoiLW1ZYWMzTVYwdEtLNEdqdnhpTkRzR3dHbFBNIiwidiI6MSwicCI6IntcInVcIjozMDE5ODk3MCxcInZcIjoxLFwidXJsXCI6XCJodHRwOlxcXC9cXFwvY2Euc3VwcG9ydC5zb21lbmVyZ2lhLmNvb3BcXFwvY2F0ZWdvcnlcXFwvMTgzLWphLXRpbmMtbGEtbGx1bS1jb250cmFjdGFkYVwiLFwiaWRcIjpcIjdkNzk0NDljM2JhZjRiZDBiZGM4ZTBlNGM0Yzc3OTI5XCIsXCJ1cmxfaWRzXCI6W1wiMzVhNDEwMjYxMGI3ZTcwYTc3NjNhZmNmZjk0ZjVjMDhlMmY3ZTdjYlwiXX0ifQ">Més informació</a>

- <b>Centre de Suport Som Energia:</b> Aquí hi trobaràs resolts els dubtes més freqüents, com per exemple: "Com puc fer un canvi de potència o tarifa?", "Com puc facilitar la lectura?", etc.


Moltes gràcies per triar bona energia!

Atentament,

Equip de Som Energia
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
comercialitzacio@somenergia.coop
% else:
Apreciado/a,

Ya has completado la solicitud para contratar tu suministro eléctrico a través de la cooperativa Som Energia.

<table width="60%" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td><fieldset><P ALIGN=left><B><U>Resumen de los datos facilitados en el formulario de contratación de electricidad:</U></B>
- Socio/a de Som Energia: ${object.soci.name}
- Titular del contrato de electricidad: ${object.titular.name}
- Pagador/a del contrato de electricidad: ${object.pagador.name}

- Dirección punto de suministro: ${object.cups_direccio}
- Código CUPS: ${object.cups.name}</fieldset></td></tr></table>

% if 'process: A3' not in object.observacions:

El proceso de cambio de comercializadora consta de los siguientes pasos:

1. <b>Envío de la solicitud a la distribuidora</b>. Paso en que estamos en estos momentos. 

2. <b>Recepción de la respuesta por parte de la distribuidora</b>. En un periodo máximo de dos semanas recibimos la respuesta de si el proceso de cambio de compañía se puede efectuar, o si requieren más información.  Si la solicitud se ha aceptado, te informaremos vía correo electrónico de la fecha prevista de activación de tu contrato con Som Energia, <u> normalmente es entre 2 y 7 semanas después</u>. En caso contrario, también nos pondremos en contacto contigo.

3. <b> Activación del contrato </b>. Cuando la distribuidora reciba una lectura de tu contador, es cuando se activa el contrato con la cooperativa. A partir de entonces ya facturaremos desde Som Energia, pero ten en cuenta que aún recibirás la última factura de tu antigua comercializadora. En caso de querer hacer <b> un cambio de potencia o de tarifa </b> será a partir de este momento que lo podrás solicitar <a href="http://es.support.somenergia.coop/article/284-como-puedo-hacer-una-modificacion-de-potencia-o-de-tarifa-y-cuanto-cuesta">(más información)</a>.

% else:

% endif

Enlaces de interés:

- <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>: Aquí puedes revisar el estado de tu contrato y las facturas que emitiremos a través de nuestra Oficina Virtual.  <a href="http://es.support.somenergia.coop/category/141-uso-de-la-oficina-virtual">Más información</a>

- <a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda Som Energia.</a>: Aquí encontrarás resueltas las dudas más frecuentes, como por ejemplo: "¿Cómo puedo hacer un cambio de potencia o tarifa?", "¿Cómo puedo facilitar la lectura?", etc.

¡Muchas gracias por escoger consumir buena energía!

Atentamente,

Equip de Som Energia
<a href="www.somenergia.coop">www.somenergia.coop</a>
comercialitzacion@somenergia.coop
%endif
</body>
</html>
