<%
    email_o = object.pool.get('report.backend.mailcanvipreus')
    data = email_o.get_data(object._cr, object._uid, object.id, context={'lang': object.partner_id.lang})
%>
<!doctype html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
<style>
    body{ font-family: 'Roboto Mono', Arial; font-size: 16px; text-align:'justify'}
    .margin_top{ margin-top: 2em; }
</style>
</head>
<body style="text-align: justify; font-family: 'Roboto Mono', Arial; font-size: 14px; line-height: 175%;" >
<div style="width:96%;max-width:1200px;margin:20px auto;">

% if data['lang'] == "ca_ES":
<a href="https://www.somenergia.coop/ca/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif
% if data['lang'] != "ca_ES":
<a href="https://www.somenergia.coop/es/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif

<br>
<br>

## <p><strong>TEST: ${object.polissa_id.name}</strong></p>
## <br>

<p>Hola${data['nom_titular']}</p>

% if data['lang'] == "ca_ES":



% if data['Periodes20TDPeninsulaFins10kw']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En aquesta modificació tenim un gran exemple de la complexitat del sector energètic, ja que hi ha diversos canvis en diversos sentits. Així, a grans trets:</span></p>
<p><span style="font-weight: 400;">Respecte als preus que estableix Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El preu de l’energia baixarà, ja que el mercat de futurs (on comprem la major part de l’energia) segueix moderant-se.</li>
    <li style="padding-bottom:1em">El preu de la potència pujarà lleugerament. Això és així perquè augmentem lleugerament el marge per a la viabilitat de la cooperativa (segueix estant dins els paràmetres que va marcar l’Assemblea General).</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
    <li><ul style="display: grid;padding-top: 1em">
    <li>En total en resultarà una disminució dels preus que estableix Som Energia.</li>
    </ul></li>
</li>
</ul></p>
<p><span style="font-weight: 400;">Respecte als impostos i altres càrrecs que estableix el govern:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">L’IVA pujarà al 21%, i l’impost elèctric, al 5,11%. El govern havia establert mesures provisionals, com ara la rebaixa de l’IVA al 5% per a alguns casos (com el teu), i la rebaixa de l’impost elèctric al 0,5%. Aquestes mesures, segons es va establir, deixaran d’estar en vigor l’1 de gener.</li>
    <li style="padding-bottom:1em">És possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</li>
</ul></p>
<p><strong>Resultat:</strong></p>
<p><span style="font-weight: 400;">Tot plegat farà que, en general, en resulti un augment de les factures d’electricitat. Més avall trobaràs una <strong>estimació</strong> de com podria afectar aquesta modificació de tarifes en el teu cas.</span></p>

% endif

% if data['Periodes20TDPeninsulaMesDe10kw']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En aquesta modificació tenim un gran exemple de la complexitat del sector energètic, ja que hi ha diversos canvis en diversos sentits. Així, a grans trets:</span></p>
<p><span style="font-weight: 400;">Respecte als preus que estableix Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El preu de l’energia baixarà, ja que el mercat de futurs (on comprem la major part de l’energia) segueix moderant-se.</li>
    <li style="padding-bottom:1em">El preu de la potència pujarà lleugerament. Això és així perquè augmentem lleugerament el marge per a la viabilitat de la cooperativa (segueix estant dins els paràmetres que va marcar l’Assemblea General).</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
    <li><ul style="display: grid;padding-top: 1em">
    <li>En total en resultarà una disminució.</li>
    </ul></li>
</li>
</ul></p>
<p><span style="font-weight: 400;">Respecte als impostos i altres càrrecs que estableix el govern:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">L’impost elèctric pujarà. Fins ara era del 0,5% perquè el govern ho havia establert com a mesura provisional. Aquesta mesura deixarà d’estar en vigor l’1 de gener, per tant, l’impost elèctric tornarà a ser del 5,11%.</li>
    <li style="padding-bottom:1em">És possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</li>
</ul></p>
<p><strong>Resultat:</strong></p>
<p><span style="font-weight: 400;">Tot plegat farà que, en general, en resulti una disminució de les factures d’electricitat. Més avall trobaràs una <strong>estimació</strong> de com podria afectar aquesta modificació de tarifes en el teu cas.</span></p>

% endif

% if data['Periodes20TDCanaries']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En aquesta modificació tenim un gran exemple de la complexitat del sector energètic, ja que hi ha diversos canvis en diversos sentits. Així, a grans trets:</span></p>
<p><span style="font-weight: 400;">Respecte als preus que estableix Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El preu de l’energia baixarà, ja que el mercat de futurs (on comprem la major part de l’energia) segueix moderant-se.</li>
    <li style="padding-bottom:1em">El preu de la potència pujarà lleugerament. Això és així perquè augmentem lleugerament el marge per a la viabilitat de la cooperativa (segueix estant dins els paràmetres que va marcar l’Assemblea General).</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
    <li><ul style="display: grid;padding-top: 1em">
    <li>En total en resultarà una disminució.</li>
    </ul></li>
</li>
</ul></p>
<p><span style="font-weight: 400;">Respecte als impostos i altres càrrecs que estableix la normativa:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">L’impost elèctric pujarà. Fins ara era del 0,5% perquè el govern ho havia establert com a mesura provisional. Aquesta mesura deixarà d’estar en vigor l’1 de gener, per tant, l’impost elèctric tornarà a ser del 5,11%.</li>
    <li style="padding-bottom:1em">L’IGIC seguirà al ${data['igic']}%, segons ha establert el govern canari.</li>
    <li style="padding-bottom:1em">És possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</li>
</ul></p>
<p><strong>Resultat:</strong></p>
<p><span style="font-weight: 400;">Tot plegat farà que, en general, en resulti una disminució de les factures d’electricitat. Més avall trobaràs una <strong>estimació</strong> de com podria afectar aquesta modificació de tarifes en el teu cas.</span></p>

% endif

% if data['Periodes30i60TDPeninsula']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En aquesta modificació tenim un gran exemple de la complexitat del sector energètic, ja que hi ha diversos canvis en diversos sentits. Així, a grans trets:</span></p>
<p><span style="font-weight: 400;">Respecte als preus que estableix Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El preu de l’energia baixarà, ja que el mercat de futurs (on comprem la major part de l’energia) segueix moderant-se.</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
</li>
</ul></p>
<p><span style="font-weight: 400;">Respecte als impostos i altres càrrecs que estableix la normativa:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">L’impost elèctric pujarà al 5,11%. El govern havia establert mesures provisionals, com ara la rebaixa de l’impost elèctric al 0,5%. Aquestes mesures, segons es va establir, deixaran d’estar en vigor l’1 de gener de 2024.</li>
    <li style="padding-bottom:1em">A part, és possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</li>
</ul></p>
<p><strong>Resultat:</strong></p>
<p><span style="font-weight: 400;">Tot plegat farà que, en general, en resulti una disminució de les factures d’electricitat. Més avall trobaràs una <strong>estimació</strong> de com podria afectar aquesta modificació de tarifes en el teu cas.</span></p>

% endif

% if data['Periodes30i60TDCanaries']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En aquesta modificació tenim un gran exemple de la complexitat del sector energètic, ja que hi ha diversos canvis en diversos sentits. Així, a grans trets:</span></p>
<p><span style="font-weight: 400;">Respecte als preus que estableix Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El preu de l’energia baixarà, ja que el mercat de futurs (on comprem la major part de l’energia) segueix moderant-se.</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
</li>
</ul></p>
<p><span style="font-weight: 400;">Respecte als impostos i altres càrrecs que estableix la normativa:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">L’impost elèctric pujarà. Fins ara era del 0,5% perquè el govern ho havia establert com a mesura provisional. Aquesta mesura deixarà d’estar en vigor l’1 de gener, per tant, l’impost elèctric tornarà a ser del 5,11%.</li>
    <li style="padding-bottom:1em">L’IGIC seguirà sent del 3%, segons ha establert el govern canari.</li>
    <li style="padding-bottom:1em">És possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</li>
</ul></p>
<p><strong>Resultat:</strong></p>
<p><span style="font-weight: 400;">Tot plegat farà que, en general, en resulti una disminució de les factures d’electricitat. Més avall trobaràs una <strong>estimació</strong> de com podria afectar aquesta modificació de tarifes en el teu cas.</span></p>

% endif

% if data['Indexada20TDPeninsulaBalearsFins10kw']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En el cas de la tarifa indexada (la que tens actualment), actualitzarem el terme de <strong>potència</strong>, ja que hi repercutim un petit augment del marge per a la viabilitat de la cooperativa (segueix estant dins els paràmetres que va marcar l’Assemblea General, al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes). La fórmula per calcular el terme d’<strong>energia</strong> no variarà.</span></p>
<p><span style="font-weight: 400;">Per altra banda, la mesura del govern de rebaixar l’IVA i l’impost elèctric d’algunes factures d’electricitat, deixarà d’estar vigent a partir de l’any vinent i, per tant, es recupera l’<strong>IVA del 21% i l’impost elèctric del 5,11%</strong>.</span></p>
<p><span style="font-weight: 400;">És possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</span></p>

% endif

% if data['Indexada20TDPeninsulaBalearsMesDe10kw']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En el cas de la tarifa indexada (la que tens actualment), actualitzarem el terme de <strong>potència</strong>, ja que hi repercutim un petit augment del marge per a la viabilitat de la cooperativa (segueix estant dins els paràmetres que va marcar l’Assemblea General, al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes). La fórmula per calcular el terme d’<strong>energia</strong> no variarà.</span></p>
<p><span style="font-weight: 400;">Per altra banda, la mesura del govern de rebaixar l’impost elèctric al 0,5% deixarà d’estar vigent a partir de l’any vinent, per tant, l’impost elèctric tornarà a ser del 5,11%.</span></p>
<p><span style="font-weight: 400;">És possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</span></p>

% endif

% if data['Indexada20TDCanaries']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En el cas de la tarifa indexada (la que tens actualment), actualitzarem el terme de <strong>potència</strong>, ja que hi repercutim un petit augment del marge per a la viabilitat de la cooperativa (segueix estant dins els paràmetres que va marcar l’Assemblea General, al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes). La fórmula per calcular el terme d’<strong>energia</strong> no variarà.</span></p>
<p><span style="font-weight: 400;">Per altra banda, la mesura del govern de rebaixar l’impost elèctric d’algunes factures d’electricitat, deixarà d’estar vigent a partir de l’any vinent i, per tant, es recupera l’<strong>impost elèctric del 5,11%</strong>. L’IGIC seguirà sent del ${data['igic']}%, segons ha establert el govern canari.</span></p>
<p><span style="font-weight: 400;">És possible que el govern anunciï variacions d’altres càrrecs, que seran d’aplicació immediata o quan ho estableixi el decret. Acostuma a passar quan canvia l’any, i normalment són modificacions de decimals, que no tenen gaire afectació al preu final.</span></p>

% endif

<br>
<p><strong>Autoproducci&oacute;</strong></p>

% if data['periodes']:

<p><span style="font-weight: 400;">Per als contractes que tenen autoproducció amb compensació simplificada, els excedents d’autoproducció els continuarem compensant al mateix valor de referència del cost de l’energia que fem servir per calcular el preu de venda. Com que el cost de referència de l’energia en hores de producció fotovoltaica ha baixat, disminueix també la compensació d’excedents.</span></p>

% endif

% if data['indexada']:

<p><span style="font-weight: 400;">Per als contractes que tenen autoproducció amb compensació simplificada, els excedents d’autoproducció els continuarem compensant al mateix valor de referència del cost de l’energia que fem servir per calcular el preu de venda. Això, aplicat a les tarifes indexades, es tradueix en què els excedents generats a una hora concreta es compensen al preu de l’energia al mercat majorista diari a aquella hora.</span></p>

% endif

<p><span style="font-weight: 400;">En el cas dels contractes amb modalitat d’autoproducció acollits a la compensació simplificada, et recordem que també tenen activat el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats/">Flux Solar</a>, que proporciona descomptes per als excedents que no poden ser compensats amb la compensació simplificada.</span></p>


% if data['te_gkwh']:

<br>
<p><strong>Generation kWh</strong></p>
<p><span style="font-weight: 400;">Respecte a la tarifa Generation kWh, hem actualitzat els components que formen la tarifa, i en resulta una lleugera disminució.</span></p>

% endif


<br>
<p dir="ltr">Una salutaci&oacute; cordial,
<br>
Equip de Som Energia
<br>
<a href="https://somenergia.coop/ca">www.somenergia.coop</a></p>

% endif

% if  data['lang'] != "ca_ES":


<br>
<p dir="ltr">Un saludo cordial,
<br>
Equipo de Som Energia
<br>
<a href="https://www.somenergia.coop/es/">www.somenergia.coop</a></p>

% endif

<br>

${data['text_legal']}
</div>
</body>
</html>
