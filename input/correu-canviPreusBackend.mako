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

    td, th {
        border: 1px solid;
        padding: 4px 10px;
        text-align: center;
    }
</style>
</head>
## TODO: Passar sempre l'inliner: https://templates.mailchimp.com/resources/inline-css/
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

<p><strong>PLANTILLA DE TEST, PÒLISSA ${object.polissa_id.name}</strong></p>
<br>

<p>Hola${data['nom_titular']}</p>

% if data['lang'] == "ca_ES":



% if data['Periodes20TDPeninsulaFins10kw']:

<p><span style="font-weight: 400;">L’1 de gener actualitzarem els preus de les tarifes d’electricitat de Som Energia.</span></p>
<p><span style="font-weight: 400;">En aquesta modificació tenim un gran exemple de la complexitat del sector energètic, ja que hi ha diversos canvis en diversos sentits. Així, a grans trets:</span></p>
<p><span style="font-weight: 400;">Respecte als preus que estableix Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El preu de l’energia baixarà, ja que el mercat de futurs (on comprem la major part de l’energia) segueix moderant-se.</li>
    <li style="padding-bottom:1em">El preu de la potència pujarà lleugerament. Això és així perquè augmentem lleugerament el marge per a la viabilitat de la cooperativa (segueix estant dins els paràmetres que va marcar l’Assemblea General).</li>
    <li style="padding-bottom:1em">En total en resultarà una disminució dels preus que estableix Som Energia.</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
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
    <li style="padding-bottom:1em">En total en resultarà una disminució.</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
</li>
</ul></p>
<p><span style="font-weight: 400;">Respecte als impostos que estableix el govern:</span></p>
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
    <li style="padding-bottom:1em">En total en resultarà una disminució dels preus que estableix Som Energia.</li>
    <li style="list-style: none;padding-bottom:1em">Al Centre d’Ajuda tens més informació sobre la <a href="https://ca.support.somenergia.coop/article/1302-com-establim-els-preus-a-som-energia">composició dels preus</a> de les nostres tarifes.</li>
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

% if data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries']:
<br>
<p><strong>Nous preus i comparativa amb preus actuals</strong></p>
<p><span style="font-weight: 400;">A continuació tens una taula amb els nous preus d’energia i potència (vigents a partir de l’1 de gener de 2024), i una comparació amb els preus actuals (vigents fins a 31 de desembre de 2023) de la tarifa que tens contractada actualment. En els dos casos els impostos aplicats són sense rebaixes, és a dir, ${data['impostos_str']} i 5,11% d’impost elèctric.</span></p>
<br>
<p><strong>Tarifa 2.0TD períodes</strong></p>
<p><strong>Preu del terme de potència (en euros/kW i dia)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th colspan="2">Nous preus</th>
                <th colspan="2">Preus actuals</th>
            </tr>
            <tr>
                <td></td>
                <td>Període punta</td>
                <td>Període vall</td>
                <td>Període punta</td>
                <td>Període vall</td>
            </tr>
            <tr>
                <td>Abans d’impostos</td>
                <td>${data['preus_nous']['tp']['P1']}</td>
                <td>${data['preus_nous']['tp']['P2']}</td>
                <td>${data['preus_antics']['tp']['P1']}</td>
                <td>${data['preus_antics']['tp']['P2']}</td>
            </tr>
            <tr>
                <td>Després d’impostos</td>
                <td>${data['preus_nous_imp']['tp']['P1']}</td>
                <td>${data['preus_nous_imp']['tp']['P2']}</td>
                <td>${data['preus_antics_imp']['tp']['P1']}</td>
                <td>${data['preus_antics_imp']['tp']['P2']}</td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
<p><strong>Preu del terme d’energia (en euros/kWh)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th colspan="3">Nous preus</th>
                <th colspan="3">Preus actuals</th>
            </tr>
            <tr>
                <td></td>
                <td>Període punta</td>
                <td>Període pla</td>
                <td>Període vall</td>
                <td>Període punta</td>
                <td>Període pla</td>
                <td>Període vall</td>
            </tr>
            <tr>
                <td>Abans d’impostos</td>
                <td>${data['preus_nous']['te']['P1']}</td>
                <td>${data['preus_nous']['te']['P2']}</td>
                <td>${data['preus_nous']['te']['P3']}</td>
                <td>${data['preus_antics']['te']['P1']}</td>
                <td>${data['preus_antics']['te']['P2']}</td>
                <td>${data['preus_antics']['te']['P3']}</td>
            </tr>
            <tr>
                <td>Després d’impostos</td>
                <td>${data['preus_nous_imp']['te']['P1']}</td>
                <td>${data['preus_nous_imp']['te']['P2']}</td>
                <td>${data['preus_nous_imp']['te']['P3']}</td>
                <td>${data['preus_antics_imp']['te']['P1']}</td>
                <td>${data['preus_antics_imp']['te']['P2']}</td>
                <td>${data['preus_antics_imp']['te']['P3']}</td>
            </tr>
        </tbody>
    </table>
</figure>

    %if data['te_gkwh']:
        <br>
        <p><strong>Generation: preu del terme d’energia (en euros)</strong></p>
        <figure class="table">
            <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <th></th>
                        <th colspan="3">Nous preus</th>
                        <th colspan="3">Preus actuals</th>
                    </tr>
                    <tr>
                        <td></td>
                        <td>Període punta</td>
                        <td>Període pla</td>
                        <td>Període vall</td>
                        <td>Període punta</td>
                        <td>Període pla</td>
                        <td>Període vall</td>
                    </tr>
                    <tr>
                        <td>Abans d’impostos</td>
                        <td>${data['preus_nous_generation']['P1']}</td>
                        <td>${data['preus_nous_generation']['P2']}</td>
                        <td>${data['preus_nous_generation']['P3']}</td>
                        <td>${data['preus_antics_generation']['P1']}</td>
                        <td>${data['preus_antics_generation']['P2']}</td>
                        <td>${data['preus_antics_generation']['P3']}</td>
                    </tr>
                    <tr>
                        <td>Després d’impostos</td>
                        <td>${data['preus_nous_generation_imp']['P1']}</td>
                        <td>${data['preus_nous_generation_imp']['P2']}</td>
                        <td>${data['preus_nous_generation_imp']['P3']}</td>
                        <td>${data['preus_antics_generation_imp']['P1']}</td>
                        <td>${data['preus_antics_generation_imp']['P2']}</td>
                        <td>${data['preus_antics_generation_imp']['P3']}</td>
                    </tr>
                </tbody>
            </table>
        </figure>
    %endif

% endif

% if data['Periodes30i60TDCanaries'] or data['Periodes30i60TDPeninsula']:

<br>
<p><strong>Nous preus i comparativa amb preus actuals</strong></p>
<p><span style="font-weight: 400;">A continuació tens una taula amb els nous preus d’energia i potència (vigents a partir de l’1 de gener de 2024), i una comparació amb els preus actuals (vigents fins a 31 de desembre de 2023) de la tarifa que tens contractada actualment. En els dos casos els impostos aplicats són: l'${data['impostos_str']} i 5,11% d’impost elèctric. </span></p>
<br>
<p><strong>Tarifa ${data['tarifa_acces']} períodes</strong></p>
<p><strong>Preu del terme de potència (en euros/kW i dia)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Abans d'impostos</th>
                <th>Després d'impostos</th>
            </tr>
            <tr>
                <td rowspan="6">Nous preus</td>
                <td>${data['preus_nous']['tp']['P1']}</td>
                <td>${data['preus_nous_imp']['tp']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${data['preus_nous']['tp'][periode]}</td>
                    <td>${data['preus_nous_imp']['tp'][periode]}</td>
                </tr>
            % endfor
            <tr>
                <td rowspan="6">Preus actuals</td>
                <td>${data['preus_antics']['tp']['P1']}</td>
                <td>${data['preus_antics_imp']['tp']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${data['preus_antics']['tp'][periode]}</td>
                    <td>${data['preus_antics_imp']['tp'][periode]}</td>
                </tr>
            % endfor
        </tbody>
    </table>
</figure>

<br>
<p><strong>Preu del terme d’energia (en euros/kWh)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Abans d'impostos</th>
                <th>Després d'impostos</th>
            </tr>
            <tr>
                <td rowspan="6">Nous preus</td>
                <td>${data['preus_nous']['te']['P1']}</td>
                <td>${data['preus_nous_imp']['te']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${data['preus_nous']['te'][periode]}</td>
                    <td>${data['preus_nous_imp']['te'][periode]}</td>
                </tr>
            % endfor
            <tr>
                <td rowspan="6">Preus actuals</td>
                <td>${data['preus_antics']['te']['P1']}</td>
                <td>${data['preus_antics_imp']['te']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${data['preus_antics']['te'][periode]}</td>
                    <td>${data['preus_antics_imp']['te'][periode]}</td>
                </tr>
            % endfor
        </tbody>
    </table>
</figure>

    %if data['te_gkwh']:
        <br>
        <p><strong>Generation: preu del terme d’energia (en euros)</strong></p>
        <figure class="table">
            <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <th></th>
                        <th>Abans d'impostos</th>
                        <th>Després d'impostos</th>
                    </tr>
                    <tr>
                        <td rowspan="6">Nous preus</td>
                        <td>${data['preus_nous_generation']['P1']}</td>
                        <td>${data['preus_nous_generation_imp']['P1']}</td>
                    </tr>
                    % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                        <tr>
                            <td>${data['preus_nous_generation'][periode]}</td>
                            <td>${data['preus_nous_generation_imp'][periode]}</td>
                        </tr>
                    % endfor
                    <tr>
                        <td rowspan="6">Preus actuals</td>
                        <td>${data['preus_antics_generation']['P1']}</td>
                        <td>${data['preus_antics_generation_imp']['P1']}</td>
                    </tr>
                    % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                        <tr>
                            <td>${data['preus_antics_generation'][periode]}</td>
                            <td>${data['preus_antics_generation_imp'][periode]}</td>
                        </tr>
                    % endfor
                </tbody>
            </table>
        </figure>
    %endif

% endif



% if data['Indexada20TDCanaries'] or data['Indexada20TDPeninsulaBalearsFins10kw'] or data['Indexada20TDPeninsulaBalearsMesDe10kw']:

<br>
<p><strong>Nous preus i comparativa amb preus actuals</strong></p>
<p><span style="font-weight: 400;">A continuació tens una taula amb els nous preus del terme de potència (vigents a partir de l’1 de gener de 2024), i una comparació amb els preus actuals (vigents fins a 31 de desembre de 2023) de la tarifa que tens contractada actualment. En els dos casos, els impostos aplicats són els que s’aplicaran a partir del gener, és a dir, l'${data['impostos_str']} i impost elèctric del 5,11%. </span></p>
<br>
<p><strong>Tarifa ${data['tarifa_acces']} indexada</strong></p>
<p><strong>Preu del terme de potència (en euros/kW i dia)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Abans d'impostos</th>
                <th>Després d'impostos</th>
            </tr>
            <tr>
                <td rowspan="2">Nous preus</td>
                <td>${data['preus_nous']['tp']['P1']}</td>
                <td>${data['preus_nous_imp']['tp']['P1']}</td>
            </tr>
            <tr>
                <td>${data['preus_nous']['tp']['P2']}</td>
                <td>${data['preus_nous_imp']['tp']['P2']}</td>
            </tr>
            <tr>
                <td rowspan="2">Preus actuals</td>
                <td>${data['preus_antics']['tp']['P1']}</td>
                <td>${data['preus_antics_imp']['tp']['P1']}</td>
            </tr>
            <tr>
                <td>${data['preus_antics']['tp']['P2']}</td>
                <td>${data['preus_antics_imp']['tp']['P2']}</td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
<p><span style="font-weight: 400;">Respecte al preu de l’<strong>energia</strong>, com saps, en les tarifes indexades responen a una fórmula. Et posem la fórmula, que en aquest cas, no ha variat.</span></p>
<p><span style="font-weight: 400;color:gray">PH = 1,015 * [(PHM + PHMA + Pc + Sc + I + POsOm) (1 + Perd) + FE + F] + PTD + CA </span></p>
<p><span style="font-weight: 400;">Al <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#formula-indexada">nostre web</a> pots veure a què correspon cada terme.</span></p>
<p><span style="font-weight: 400;">La franja de la cooperativa, la “F” (la part que estableix Som Energia) seguirà sent de 0,020 euros/kWh.</span></p>

% endif


## Ull preus hardcodejats al backend, ja que no podem treure'ls dinàmicament si no té auto.
% if not data['indexada']:

<br>
<p><strong>Preu de compensació d’excedents d’autoproducció</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Nous preus</th>
                <th>Preus actuals</th>
            </tr>
            <tr>
                <td>Abans d’impostos</td>
                <td>${data['auto']['nous']['sense_impostos']}</td>
                <td>${data['auto']['vells']['sense_impostos']}</td></td>
            </tr>
            <tr>
                <td>Després d’impostos</td>
                <td>${data['auto']['nous']['amb_impostos']}</td></td>
                <td>${data['auto']['vells']['amb_impostos']}</td></td>
            </tr>
        </tbody>
    </table>
</figure>

% endif


% if data['origen'] == 'consums':

<br>
<p><strong>Estimació</strong></p>
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong>, a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i sense autoproducció ni Generation kWh ni lloguer de comptador. A continuació trobaràs l’estimació aproximada del cost anual si apliquéssim els preus actuals, i del cost anual si apliquéssim els nous preus. </span></p>
<p><span style="font-weight: 400;">En els dos casos l’estimació inclou l'${data['impostos_str']} i l’impost elèctric del 5,11%, és a dir, els impostos que s’aplicaran a partir del gener (tingues en compte que durant el 2023 alguns contractes han tingut impostos rebaixats).</span></p>
<br>
<p><strong>Cost anual estimat (euros/any)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Cost estimat amb els nous preus</th>
                <th>Cost estimat amb els preus actuals</th>
            </tr>
            <tr>
                <td>Abans d’impostos</td>
                <td>${data['preu_vell']}</td>
                <td>${data['preu_nou']}</td>
            </tr>
            <tr>
                <td>Després d’impostos</td>
                <td>${data['preu_vell_imp']}</td>
                <td>${data['preu_nou_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>

<p><span style="font-weight: 400;">Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l’ús d’energia que finalment facis, altres variacions de preus durant l’any, o canvis que pugui haver al mercat elèctric.</span></p>
<br>
<p><span style="font-weight: 400;">Al nostre blog trobaràs la <a href="https://blog.somenergia.coop/?p=46595">notícia</a> del canvi de tarifes, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l’apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de desembre i els de períodes anteriors.</span></p>

% endif

% if data['origen'] == 'cnmc':

<br>
<p><strong>Estimació</strong></p>
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong>, a partir de les dades que tenim dels teus consums (sense tenir en compte autoproducció ni Generation kWh ni lloguer de comptador), i extrapolant-les segons el consum mitjà que sol haver-hi a cada mes (segons dades de la Comissió Nacional dels Mercats i la Competència). Amb això n’hem obtingut un consum anual, que és el que comparem a continuació, amb els preus actuals i els nous preus.</span></p>
<p><span style="font-weight: 400;">En els dos casos l’estimació inclou l'${data['impostos_str']} i l’impost elèctric del 5,11%, és a dir, els impostos que s’aplicaran a partir del gener (tingues en compte que durant el 2023 alguns contractes han tingut impostos rebaixats).</span></p>
<br>
<p><strong>Cost anual estimat (euros/any)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Cost estimat amb els nous preus</th>
                <th>Cost estimat amb els preus actuals</th>
            </tr>
            <tr>
                <td>Abans d’impostos</td>
                <td>${data['preu_vell']}</td>
                <td>${data['preu_nou']}</td>
            </tr>
            <tr>
                <td>Després d’impostos</td>
                <td>${data['preu_vell_imp']}</td>
                <td>${data['preu_nou_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>

<p><span style="font-weight: 400;">Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l’ús d’energia que finalment facis, altres variacions de preus durant l’any, o canvis que pugui haver al mercat elèctric.</span></p>
<br>
<p><span style="font-weight: 400;">Al nostre blog trobaràs la <a href="https://blog.somenergia.coop/?p=46595">notícia</a> del canvi de tarifes, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l’apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de desembre i els de períodes anteriors.</span></p>

% endif

% if data['origen'] == 'estadistic':

<br>
<p><strong>Estimació</strong></p>
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong>, en funció de la potència contractada més alta que tens (${data['potencia_max']} kW), l’ús d’electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense autoproducció ni Generation kWh ni lloguer de comptador.</span></p>
<p><span style="font-weight: 400;">En els dos casos l’estimació inclou l'${data['impostos_str']} i l’impost elèctric del 5,11%, és a dir, els impostos que s’aplicaran a partir del gener (tingues en compte que durant el 2023 alguns contractes han tingut impostos rebaixats).</span></p>
<p><span style="font-weight: 400;">Així doncs, et mostrem a continuació l’estimació aproximada del cost anual si apliquéssim els preus actuals, i el cost anual si apliquéssim els nous preus.</span></p>
<br>
<p><strong>Cost anual estimat (euros/any)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Cost estimat amb els nous preus</th>
                <th>Cost estimat amb els preus actuals</th>
            </tr>
            <tr>
                <td>Abans d’impostos</td>
                <td>${data['preu_nou']}</td>
                <td>${data['preu_vell']}</td>
            </tr>
            <tr>
                <td>Després d’impostos</td>
                <td>${data['preu_nou_imp']}</td>
                <td>${data['preu_vell_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>

<p><span style="font-weight: 400;">Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l’ús d’energia que finalment facis, altres variacions de preus durant l’any, o canvis que pugui haver al mercat elèctric.</span></p>
<br>
<p><span style="font-weight: 400;">Al nostre blog trobaràs la <a href="https://blog.somenergia.coop/?p=46595">notícia</a> del canvi de tarifes, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l’apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de desembre i els de períodes anteriors.</span></p>

% endif


% if data['origen'] == 'indexada':

<br>
<p><strong>Estimació</strong></p>
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una estimació del cost de la factura de la llum, en funció del teu consum energètic durant l’últim any (aproximadament ${data['consum_total']} kWh), amb el canvi de preus. Com que el preu de l’energia en la tarifa indexada varia cada hora, per fer l’estimació hem utilitzat un preu mitjà en funció de les previsions actuals de preus per al 2024. Tingues en compte, però, que justament com que el preu de l’energia a mercat evoluciona cada dia i cada hora, és molt possible que l’<strong>estimació no reflexi el que acabi passant</strong>.</span></p>
<br>
<p><strong>Cost anual estimat (euros/any)</strong></p>
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Cost estimat amb els nous preus</th>
                <th>Cost estimat amb els preus actuals</th>
            </tr>
            <tr>
                <td>Abans d’impostos</td>
                <td>${data['preu_nou']}</td>
                <td>${data['preu_vell']}</td>
            </tr>
            <tr>
                <td>Després d’impostos</td>
                <td>${data['preu_nou_imp']}</td>
                <td>${data['preu_vell_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>

<p><span style="font-weight: 400;">Els impostos aplicats són, en els dos casos, els que estaran vigents a partir de l’1 de gener (${data['impostos_str']} i impost elèctric del 5,11%).</span></p>
<p><span style="font-weight: 400;">Com et dèiem, això són estimacions aproximades, i els imports finals <strong>dependran de circumstàncies</strong> que no es poden saber a dia d’avui, com és <strong>el preu de l’energia per als propers mesos</strong>, els horaris i l’ús d’energia que finalment facis, o altres canvis que pugui haver al mercat elèctric.</span></p>
<br>
<p><span style="font-weight: 400;">Al nostre blog trobaràs la <a href="https://blog.somenergia.coop/?p=46595">notícia</a> del canvi de tarifes, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim">totes les tarifes</a>.</span></p>
% endif
<br>
<p><strong>Informació legal</strong></p>

<p><span style="font-weight: 400;">Les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusules contractuals de les Condicions Generals</a> que ens autoritzen a fer aquest canvi de preus són la clàusula 5.3 (i) per als canvis regulats per normativa (per exemple, els impostos), i la clàusula 5.3 (ii) per a les modificacions de la part del preu no regulada.</span></p>

% if not data['indexada']:
<p><span style="font-weight: 400;">Pots accedir al comparador d’ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través d’<a href="https://comparador.cnmc.gob.es">aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents de les comercialitzadores del mercat lliure. Tingues en compte que possiblement, al moment de llegir aquest correu, les noves tarifes de Som Energia encara no hi seran reflectides.</span></p>
% endif

<p><span style="font-weight: 400;">T’adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d’acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d’informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la

% if data['indexada']:
<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/">tarifa per períodes</a>
% else:
<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">tarifa indexada</a>
% endif

(<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.</span></p>

<br>
<p dir="ltr">Una salutaci&oacute; cordial,
<br>
Equip de Som Energia
<br>
<a href="https://somenergia.coop/ca">www.somenergia.coop</a></p>

% endif

% if  data['lang'] != "ca_ES":
<p><strong>PLANTILLA EN CASTELLÀ PENDENT</strong></p>

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
