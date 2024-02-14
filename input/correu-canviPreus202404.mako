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

    .cuadricula td, .cuadricula th {
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

<p>Hola${data['nom_titular']}</p>

% if data['lang'] == "ca_ES":

% if data['modcon']:
<figure class="table">
    <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
        <tbody>
            <tr>
                <td>
% if data['modcon'] == 'index' and ( data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries'] or data['Periodes30i60TDCanaries'] or data['Periodes30i60TDPeninsula'] ):
                    <p><span style="font-weight: 400;text-align: left;">Som conscients que el teu contracte està pendent d’un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s’hauria de produir a les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t’expliquem més avall els canvis de preu que hi aplicarem a partir de l’1 de gener, i que t’afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.</span></p>
                    <p><span style="font-weight: 400;text-align: left;">
                    La <strong>tarifa ${data['tarifa_acces']} indexada</strong> no canvia, tan sols s'actualitza l'impost elèctric que, tal com <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">va establir el govern</a> l'1 d'abril passarà del 2,5% al 3,8%. Aquesta és una actualització legal que s'aplica a tots els contractes d'electricitat, tret d'alguna petita excepció que ve regulada a l'article 22 del Reial Decret Llei 8/2023, de 27 de desembre.
                    Al nostre web pots trobar, com sempre, els  <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">preus de la tarifa indexada</a>.</span></p>
% endif
% if data['modcon'] == 'atr' and ( data['Indexada20TDCanaries'] or data['Indexada20TDPeninsulaBalearsFins10kw'] or data['Indexada20TDPeninsulaBalearsMesDe10kw'] ):
                    <p><span style="font-weight: 400;text-align: left;">Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a <strong>tarifa ${data['tarifa_acces']} períodes</strong> que s'hauria de produir a les pròximes setmanes. A la tarifa per períodes li aplicarem un canvi de preus <strong>lleugerament a la baixa</strong> a partir de l'1 d'abril. Te n'informem a continuació.
                    La tarifa indexada (que et serà d'aplicació mentre no se t'activi el canvi) no té actualització de preus més enllà de la variació de l'impost elèctric que, tal com <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">va establir el govern</a>, l'1 d'abril passarà del 2,5% al 3,8%. Aquesta és una actualització legal que s'aplica a tots els contractes d'electricitat. Al nostre web pots trobar, com sempre, els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#opcions-de-la-tarifa-periodes">preus de les tarifes per períodes</a> que aplicarem a partir de l'1 d'abril i els de <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">les tarifes indexades</a>. També pots veure, a l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/historic-de-tarifes/">apartat històric</a>, els preus anteriors a 1 d'abril de 2024.</span></p>
% endif
                </td>
            </tr>
        </tbody>
    </table>
</figure>
</table>

<br/>
% if data['periodes']:
<h3>Canvis de preus de la tarifa ${data['tarifa_acces']} períodes</h3>
% endif

% if data['indexada']:
<h3>Canvis de preus de la tarifa ${data['tarifa_acces']} indexada</h3>
% endif

% endif


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
<p><span style="font-weight: 400;">A continuació tens una taula amb els nous preus d’energia i potència (vigents a partir de l’1 de gener de 2024), i una comparació amb els preus actuals (vigents fins a 31 de desembre de 2023) de la tarifa que tens contractada actualment. En els dos casos els impostos aplicats són ${data['impostos_str']} i impost elèctric del 5,11%.</span></p>
<br>
<p><strong>Tarifa 2.0TD períodes</strong></p>
<p><strong>Preu del terme de potència (en euros/kW i dia)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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
        <p><strong>Generation kWh: preu del terme d’energia (en euros/kWh)</strong></p>
        <figure class="table">
            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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
<p><span style="font-weight: 400;">A continuació tens una taula amb els nous preus d’energia i potència (vigents a partir de l’1 de gener de 2024), i una comparació amb els preus actuals (vigents fins a 31 de desembre de 2023) de la tarifa que tens contractada actualment. En els dos casos els impostos aplicats són: l'${data['impostos_str']} i impost elèctric del 5,11%. </span></p>
<br>
<p><strong>Tarifa ${data['tarifa_acces']} períodes</strong></p>
<p><strong>Preu del terme de potència (en euros/kW i dia)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th></th>
                <th>Abans d'impostos</th>
                <th>Després d'impostos</th>
            </tr>
            <tr>
                <td rowspan="6">Nous preus</td>
                <td>P1</td>
                <td>${data['preus_nous']['tp']['P1']}</td>
                <td>${data['preus_nous_imp']['tp']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
                    <td>${data['preus_nous']['tp'][periode]}</td>
                    <td>${data['preus_nous_imp']['tp'][periode]}</td>
                </tr>
            % endfor
            <tr>
                <td rowspan="6">Preus actuals</td>
                <td>P1</td>
                <td>${data['preus_antics']['tp']['P1']}</td>
                <td>${data['preus_antics_imp']['tp']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
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
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th></th>
                <th>Abans d'impostos</th>
                <th>Després d'impostos</th>
            </tr>
            <tr>
                <td rowspan="6">Nous preus</td>
                <td>P1</td>
                <td>${data['preus_nous']['te']['P1']}</td>
                <td>${data['preus_nous_imp']['te']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
                    <td>${data['preus_nous']['te'][periode]}</td>
                    <td>${data['preus_nous_imp']['te'][periode]}</td>
                </tr>
            % endfor
            <tr>
                <td rowspan="6">Preus actuals</td>
                <td>P1</td>
                <td>${data['preus_antics']['te']['P1']}</td>
                <td>${data['preus_antics_imp']['te']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
                    <td>${data['preus_antics']['te'][periode]}</td>
                    <td>${data['preus_antics_imp']['te'][periode]}</td>
                </tr>
            % endfor
        </tbody>
    </table>
</figure>

    %if data['te_gkwh']:
        <br>
        <p><strong>Generation kWh: preu del terme d’energia (en euros/kWh)</strong></p>
        <figure class="table">
            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <th></th>
                        <th></th>
                        <th>Abans d'impostos</th>
                        <th>Després d'impostos</th>
                    </tr>
                    <tr>
                        <td rowspan="6">Nous preus</td>
                        <td>P1</td>
                        <td>${data['preus_nous_generation']['P1']}</td>
                        <td>${data['preus_nous_generation_imp']['P1']}</td>
                    </tr>
                    % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                        <tr>
                            <td>${periode}</td>
                            <td>${data['preus_nous_generation'][periode]}</td>
                            <td>${data['preus_nous_generation_imp'][periode]}</td>
                        </tr>
                    % endfor
                    <tr>
                        <td rowspan="6">Preus actuals</td>
                        <td>P1</td>
                        <td>${data['preus_antics_generation']['P1']}</td>
                        <td>${data['preus_antics_generation_imp']['P1']}</td>
                    </tr>
                    % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                        <tr>
                            <td>${periode}</td>
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
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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
<p><span style="font-weight: 400;">Respecte al preu de l’<strong>energia</strong>, com saps, en les tarifes indexades responen a una fórmula. Et posem la fórmula, que en aquest cas, no ha variat.</span></p>
<p><span style="font-weight: 400;color:gray">PH = 1,015 * [(PHM + PHMA + Pc + Sc + I + POsOm) (1 + Perd) + FE + F] + PTD + CA </span></p>
<p><span style="font-weight: 400;">Al <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#formula-indexada">nostre web</a> pots veure a què correspon cada terme.</span></p>
<p><span style="font-weight: 400;">La franja de la cooperativa, la “F” (la part que estableix Som Energia) seguirà sent de 0,020 euros/kWh.</span></p>

    %if data['te_gkwh']:
        <br>
        <p><strong>Generation kWh: preu del terme d’energia (en euros/kWh)</strong></p>
        <figure class="table">
            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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


## Ull preus hardcodejats al backend, ja que no podem treure'ls dinàmicament si no té auto.
% if not data['indexada']:

<br>
<p><strong>Preu de compensació d’excedents d’autoproducció (en euros/kWh)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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

% if data['origen'] == 'cnmc':

<br>
<p><strong>Estimació</strong></p>
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong>, a partir de les dades que tenim dels teus consums (sense tenir en compte autoproducció ni Generation kWh ni lloguer de comptador), i extrapolant-les segons el consum mitjà que sol haver-hi a cada mes (segons dades de la Comissió Nacional dels Mercats i la Competència). Amb això n’hem obtingut un consum anual, que és el que comparem a continuació, amb els preus actuals i els nous preus.</span></p>
<p><span style="font-weight: 400;">En els dos casos l’estimació inclou l'${data['impostos_str']} i l’impost elèctric del 5,11%, és a dir, els impostos que s’aplicaran a partir del gener (tingues en compte que durant el 2023 alguns contractes han tingut impostos rebaixats).</span></p>
<br>
<p><strong>Cost anual estimat (euros/any)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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

% if data['origen'] == 'estadistic':

<br>
<p><strong>Estimació</strong></p>
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong>, en funció de la potència contractada més alta que tens (${data['potencia_max']} kW), l’ús d’electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense autoproducció ni Generation kWh ni lloguer de comptador.</span></p>
<p><span style="font-weight: 400;">En els dos casos l’estimació inclou l'${data['impostos_str']} i l’impost elèctric del 5,11%, és a dir, els impostos que s’aplicaran a partir del gener (tingues en compte que durant el 2023 alguns contractes han tingut impostos rebaixats).</span></p>
<p><span style="font-weight: 400;">Així doncs, et mostrem a continuació l’estimació aproximada del cost anual si apliquéssim els preus actuals, i el cost anual si apliquéssim els nous preus.</span></p>
<br>
<p><strong>Cost anual estimat (euros/any)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
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

% if data['lang'] != "ca_ES":

% if data['modcon']:
<figure class="table">
    <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
        <tbody>
            <tr>
                <td>
% if data['modcon'] == 'index' and ( data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries'] ):
                    <p><span style="font-weight: 400;text-align: left;">Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} períodos, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa períodos.</span></p>
                    <p><span style="font-weight: 400;text-align: left;">En nuestra web puedes encontrar, desde hoy, los <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">nuevos precios de la tarifa indexada</a>. Así grosso modo, aumenta un poco el precio de la potencia y se recuperan el ${data['impostos_str']} y el impuesto eléctrico del 5,11% en los contratos que los tenían rebajados.</span></p>
% endif
% if data['modcon'] == 'index' and ( data['Periodes30i60TDCanaries'] or data['Periodes30i60TDPeninsula'] ):
                    <p><span style="font-weight: 400;text-align: left;">Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} períodos, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa períodos.</span></p>
                    <p><span style="font-weight: 400;text-align: left;">En nuestra web puedes encontrar, desde hoy, los <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">nuevos precios de la tarifa indexada</a>.</span></p>
% endif
% if data['modcon'] == 'atr' and ( data['Indexada20TDCanaries'] or data['Indexada20TDPeninsulaBalearsFins10kw'] or data['Indexada20TDPeninsulaBalearsMesDe10kw'] ):
                    <p><span style="font-weight: 400;text-align: left;">Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} períodos</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} indexada, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa períodos.</span></p>
                    <p><span style="font-weight: 400;text-align: left;">En nuestra web puedes encontrar, desde hoy, los <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#opciones-de-la-tarifa-por-periodos">nuevos precios de la tarifa periodos</a>.</span></p>
% endif
                </td>
            </tr>
        </tbody>
    </table>
</figure>
</table>

<br/>
<br/>
% if data['periodes']:
<h3>Cambios de precios de la tarifa ${data['tarifa_acces']} periodos</h3>
% endif

% if data['indexada']:
<h3>Cambios de precios de la tarifa ${data['tarifa_acces']} indexada</h3>
% endif


% endif


% if data['Periodes20TDPeninsulaFins10kw']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En esta modificación tenemos un gran ejemplo de la complejidad del sector energético, ya que existen varios cambios en distintos sentidos. Así, a grandes rasgos:</span></p>
<p><span style="font-weight: 400;">Respecto a los precios que establece Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El precio de la energía bajará, puesto que el mercado de futuros (donde compramos la mayor parte de la energía) sigue moderándose.</li>
    <li style="padding-bottom:1em">El precio de la potencia subirá ligeramente. Esto es así porque aumentamos ligeramente el margen para la viabilidad de la cooperativa (sigue estando dentro de los parámetros que marcó l'Asamblea General).</li>
    <li style="padding-bottom:1em">En total resultará una disminución de los precios que establece Som Energia.</li>
    </ul>
</p>
<p><span style="font-weight: 400;">En el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia">composición de los precios</a> de nuestras tarifas.</span></p>

<p><span style="font-weight: 400;">Respecto a los impuestos y otros cargos que establece el gobierno:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El IVA subirá al 21% y el impuesto eléctrico, al 5,11%. El gobierno había establecido medidas provisionales, como la rebaja del IVA al 5% para algunos casos (como el tuyo), y la rebaja del impuesto eléctrico al 0,5%. Estas medidas, según se estableció, dejarán de estar en vigor el 1 de enero.</li>
    <li style="padding-bottom:1em">Es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen demasiada afectación sobre el precio final.</li>
</ul></p>
<p><strong>Resultado:</strong></p>
<p><span style="font-weight: 400;">Todo lo anterior hará que, en general, resulte un aumento de las facturas de electricidad. Más abajo encontrarás una <strong>estimación</strong> de cómo podría afectar esta modificación de tarifas en tu caso.</span></p>

% endif

% if data['Periodes20TDPeninsulaMesDe10kw']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En esta modificación tenemos un gran ejemplo de la complejidad del sector energético, ya que existen varios cambios en distintos sentidos. Así, a grandes rasgos:</span></p>
<p><span style="font-weight: 400;">Respecto a los precios que establece Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El precio de la energía bajará, puesto que el mercado de futuros (donde compramos la mayor parte de la energía) sigue moderándose.</li>
    <li style="padding-bottom:1em">El precio de la potencia subirá ligeramente. Esto es así porque aumentamos ligeramente el margen para la viabilidad de la cooperativa (sigue estando dentro de los parámetros que marcó la Asamblea General).</li>
    <li style="padding-bottom:1em">En total resultará una disminución de los precios que establece Som Energia.</li>
</ul></p>
<p><span style="font-weight: 400;">En el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia">composición de los precios</a> de nuestras tarifas.</span></p>


<p><span style="font-weight: 400;">Respecto a los impuestos que establece el gobierno:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El impuesto eléctrico subirá. Hasta ahora era del 0,5%, porque el gobierno lo había establecido como medida provisional. Esta medida dejará de estar en vigor el 1 de enero, por tanto, el impuesto eléctrico volverá a ser del 5,11%.</li>
    <li style="padding-bottom:1em">Es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen demasiada afectación sobre el precio final.</li>
</ul></p>
<p><strong>Resultado:</strong></p>
<p><span style="font-weight: 400;">Todo lo anterior hará que, en general, resulte una disminución de las facturas de electricidad. Más abajo encontrarás una <strong>estimación</strong> de cómo podría afectar esta modificación de tarifas en tu caso.</span></p>

% endif

% if data['Periodes20TDCanaries']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En esta modificación tenemos un gran ejemplo de la complejidad del sector energético, ya que existen varios cambios en distintos sentidos. Así, a grandes rasgos:</span></p>
<p><span style="font-weight: 400;">Respecto a los precios que establece Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El precio de la energía bajará, puesto que el mercado de futuros (donde compramos la mayor parte de la energía) sigue moderándose.</li>
    <li style="padding-bottom:1em">El precio de la potencia subirá ligeramente. Esto es así porque aumentamos ligeramente el margen para la viabilidad de la cooperativa (sigue estando dentro de los parámetros que marcó la Asamblea General).</li>
    <li style="padding-bottom:1em">En total resultará una disminución de los precios que establece Som Energia.</li>
    <li style="list-style: none;padding-bottom:1em">En el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">composición de los precios</a> de nuestras tarifas.</li>
</ul></p>
<p><span style="font-weight: 400;">Respecto a los impuestos y otros cargos que establece la normativa:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El impuesto eléctrico subirá. Hasta ahora era del 0,5%, porque el gobierno lo había establecido como medida provisional. Esta medida dejará de estar en vigor el 1 de enero, por tanto, el impuesto eléctrico volverá a ser del 5,11%.</li>
    <li style="padding-bottom:1em">El IGIC seguirá al ${data['igic']}%, según estableció el gobierno canario.</li>
    <li style="padding-bottom:1em">Es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen demasiada afectación sobre el precio final.</li>
</ul></p>
<p><strong>Resultado:</strong></p>
<p><span style="font-weight: 400;">Todo lo anterior hará que, en general, resulte una disminución en las facturas de electricidad. Más abajo encontrarás una estimación de cómo podría afectar esta modificación de tarifas en tu caso.</span></p>

% endif

% if data['Periodes30i60TDPeninsula']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En esta modificación tenemos un ejemplo de la complejidad del sector energético, ya que existen cambios en distintos sentidos. Así, a grandes rasgos:</span></p>
<p><span style="font-weight: 400;">Respecto a los precios que establece Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El precio de la energía bajará, puesto que el mercado de futuros (donde compramos la mayor parte de la energía) sigue moderándose.</li>
    <li style="list-style: none;padding-bottom:1em">En el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">composición de los precios</a> de nuestras tarifas.</li>
</ul></p>
<p><span style="font-weight: 400;">Respecto a los impuestos y otros cargos que establece el gobierno:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El impuesto eléctrico subirá al 5,11%. El gobierno había establecido medidas provisionales, como la rebaja del impuesto eléctrico al 0,5%. Estas medidas, según se estableció, dejarán de estar en vigor el 1 de enero de 2024.</li>
    <li style="padding-bottom:1em">Aparte, es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen demasiada afectación sobre el precio final.</li>
</ul></p>
<p><strong>Resultado:</strong></p>
<p><span style="font-weight: 400;">Todo lo anterior hará que, en general, resulte una disminución de las facturas de electricidad. Más abajo encontrarás una <strong>estimación</strong> de cómo podría afectar esta modificación de tarifas en tu caso.</span></p>

% endif

% if data['Periodes30i60TDCanaries']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En esta modificación tenemos un ejemplo de la complejidad del sector energético, ya que existen varios cambios en distintos sentidos. Así, a grandes rasgos:</span></p>
<p><span style="font-weight: 400;">Respecto a los precios que establece Som Energia:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El precio de la energía bajará, puesto que el mercado de futuros (donde compramos la mayor parte de la energía) sigue moderándose.</li>
    <li style="list-style: none;padding-bottom:1em">En el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia">composición de los precios</a> de nuestras tarifas.</li>
</ul></p>
<p><span style="font-weight: 400;">Respecto a los impuestos y otros cargos que establece la normativa:</span></p>
<p><ul style="display: grid;padding-top: 1em">
    <li style="padding-bottom:1em">El impuesto eléctrico subirá. Hasta ahora era del 0,5%, porque el gobierno lo había establecido como medida provisional. Esta medida dejará de estar en vigor el 1 de enero, por tanto, el impuesto eléctrico volverá a ser del 5,11%.</li>
    <li style="padding-bottom:1em">El IGIC seguirá siendo del 3%, según ha establecido el gobierno canario.</li>
    <li style="padding-bottom:1em">Es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen demasiada afectación sobre el precio final.</li>
</ul></p>
<p><strong>Resultado:</strong></p>
<p><span style="font-weight: 400;">Todo lo anterior hará que, en general, resulte una disminución en las facturas de electricidad. Más abajo encontrarás una estimación de cómo podría afectar esta modificación de tarifas en tu caso.</span></p>

% endif

% if data['Indexada20TDPeninsulaBalearsFins10kw']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En el caso de la tarifa indexada (la que tienes actualmente), actualizaremos el término de <strong>potencia</strong>, ya que repercutimos un pequeño aumento del margen para la viabilidad de la cooperativa (sigue estando dentro de los parámetros que marcó la Asamblea General; en el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">composición de los precios</a> de nuestras tarifas). La fórmula para calcular el término de <strong>energía</strong> no variará.</span></p>
<p><span style="font-weight: 400;">Por otra parte, la medida del gobierno de rebajar el IVA y el impuesto eléctrico de algunas facturas de electricidad, dejará de estar vigente a partir del próximo año y, por tanto, se recupera el <strong>IVA del 21% y el impuesto eléctrico del 5,11%</strong>.</span></p>
<p><span style="font-weight: 400;">Es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen mucha afectación al precio final.</span></p>

% endif

% if data['Indexada20TDPeninsulaBalearsMesDe10kw']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En el caso de la tarifa indexada (la que tienes actualmente), actualizaremos el término de <strong>potencia</strong>, ya que repercutimos un pequeño aumento del margen para la viabilidad de la cooperativa (sigue estando dentro de los parámetros que marcó la Asamblea General; en el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">composición de los precios</a> de nuestras tarifas). La fórmula para calcular el término de <strong>energía</strong>, no variará.</span></p>
<p><span style="font-weight: 400;">Por otro lado, la medida del gobierno de rebajar el impuesto eléctrico al 0,5% dejará de estar vigente a partir del próximo año, por tanto, el impuesto eléctrico volverá a ser del 5,11%.</span></p>
<p><span style="font-weight: 400;">Es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen demasiada afectación sobre el precio final.</span></p>

% endif

% if data['Indexada20TDCanaries']:

<p><span style="font-weight: 400;">El 1 de enero actualizaremos los precios de las tarifas de electricidad de Som Energia.</span></p>
<p><span style="font-weight: 400;">En el caso de la tarifa indexada (la que tienes actualmente), actualizaremos el término de <strong>potencia</strong>, ya que repercutimos un pequeño aumento del margen para la viabilidad de la cooperativa (sigue estando dentro de los parámetros que marcó la Asamblea General; en el Centro de Ayuda tienes más información sobre la <a href="https://es.support.somenergia.coop/article/1303-como-establecemos-los-precios-en-som-energia?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">composición de los precios</a> de nuestras tarifas). La fórmula para calcular el término de <strong>energía</strong>, no variará.</span></p>
<p><span style="font-weight: 400;">Por otra parte, la medida del gobierno de rebajar el impuesto eléctrico de algunas facturas de electricidad, dejará de estar vigente a partir del próximo año y, por tanto, se recupera <strong>el impuesto eléctrico del 5,11%</strong>. El IGIC seguirá siendo del ${data['igic']}%, según ha establecido el gobierno canario.</span></p>
<p><span style="font-weight: 400;">Es posible que el gobierno anuncie variaciones de otros cargos, que serán de aplicación inmediata o cuando lo establezca el decreto. Suele pasar cuando cambia el año, y normalmente son modificaciones de decimales, que no tienen demasiada afectación sobre el precio final.</span></p>

% endif

<br>
<p><strong>Autoproducción</strong></p>

% if data['periodes']:

<p><span style="font-weight: 400;">Para los contratos que tienen autoproducción con compensación simplificada, los excedentes de autoproducción los continuaremos compensando al mismo valor de referencia del coste de la energía que utilizamos para calcular el precio de venta. Como el coste de referencia de la energía en horas de producción fotovoltaica ha descendido, disminuye también la compensación de excedentes.</span></p>

% endif

% if data['indexada']:

<p><span style="font-weight: 400;">Para los contratos que tienen autoproducción con compensación simplificada, los excedentes de autoproducción los continuaremos compensando al mismo valor de referencia del coste de la energía que utilizamos para calcular el precio de venta. Esto, aplicado a las tarifas indexadas, se traduce en que los excedentes generados en una hora concreta se compensan al precio de la energía en el mercado mayorista diario a esa hora.</span></p>

% endif

<p><span style="font-weight: 400;">En el caso de los contratos con modalidad de autoproducción acogidos a la compensación simplificada, te recordamos que también tienen activado el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-la-herramienta-que-proporciona-descuentos-por-los-excedentes-de-autoproduccion-no-compensados/">Flux Solar</a>, que proporciona descuentos para los excedentes que no pueden ser compensados ​​con la compensación simplificada.</span></p>


% if data['te_gkwh']:

<br>
<p><strong>Generation kWh</strong></p>
<p><span style="font-weight: 400;">Respecto a la tarifa Generation kWh, hemos actualizado los componentes que forman la tarifa, y resulta una ligera disminución.</span></p>

% endif

% if data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries']:
<br>
<p><strong>Nuevos precios y comparativa con precios actuales</strong></p>
<p><span style="font-weight: 400;">A continuación tienes una tabla con los nuevos precios de energía y potencia (vigentes a partir del 1 de enero de 2024), y una comparación con los precios actuales (vigentes hasta 31 de diciembre de 2023) de la tarifa que tienes contratada actualmente. En ambos casos los impuestos aplicados son ${data['impostos_str']} e impuesto eléctrico del 5,11%.</span></p>
<br>
<p><strong>Tarifa 2.0TD períodos</strong></p>
<p><strong>Precio del término de potencia (en euros/kW y día)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th colspan="2">Nuevos precios</th>
                <th colspan="2">Precios actuales</th>
            </tr>
            <tr>
                <td></td>
                <td>Periodo punta</td>
                <td>Periodo valle</td>
                <td>Periodo punta</td>
                <td>Periodo valle</td>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['preus_nous']['tp']['P1']}</td>
                <td>${data['preus_nous']['tp']['P2']}</td>
                <td>${data['preus_antics']['tp']['P1']}</td>
                <td>${data['preus_antics']['tp']['P2']}</td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
                <td>${data['preus_nous_imp']['tp']['P1']}</td>
                <td>${data['preus_nous_imp']['tp']['P2']}</td>
                <td>${data['preus_antics_imp']['tp']['P1']}</td>
                <td>${data['preus_antics_imp']['tp']['P2']}</td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
<p><strong>Precio del término de energía (en euros/kWh)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th colspan="3">Nuevos precios</th>
                <th colspan="3">Precios actuales</th>
            </tr>
            <tr>
                <td></td>
                <td>Periodo punta</td>
                <td>Periodo llano</td>
                <td>Periodo valle</td>
                <td>Periodo punta</td>
                <td>Periodo llano</td>
                <td>Periodo valle</td>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['preus_nous']['te']['P1']}</td>
                <td>${data['preus_nous']['te']['P2']}</td>
                <td>${data['preus_nous']['te']['P3']}</td>
                <td>${data['preus_antics']['te']['P1']}</td>
                <td>${data['preus_antics']['te']['P2']}</td>
                <td>${data['preus_antics']['te']['P3']}</td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
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
        <p><strong>Generation kWh: precio del término de energía (en euros/kWh)</strong></p>
        <figure class="table">
            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <th></th>
                        <th colspan="3">Nuevos precios</th>
                        <th colspan="3">Precios actuales</th>
                    </tr>
                    <tr>
                        <td></td>
                        <td>Periodo punta</td>
                        <td>Periodo llano</td>
                        <td>Periodo valle</td>
                        <td>Periodo punta</td>
                        <td>Periodo llano</td>
                        <td>Periodo valle</td>
                    </tr>
                    <tr>
                        <td>Antes de impuestos</td>
                        <td>${data['preus_nous_generation']['P1']}</td>
                        <td>${data['preus_nous_generation']['P2']}</td>
                        <td>${data['preus_nous_generation']['P3']}</td>
                        <td>${data['preus_antics_generation']['P1']}</td>
                        <td>${data['preus_antics_generation']['P2']}</td>
                        <td>${data['preus_antics_generation']['P3']}</td>
                    </tr>
                    <tr>
                        <td>Después de impuestos</td>
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
<p><strong>Nuevos precios y comparativa con precios actuales</strong></p>
<p><span style="font-weight: 400;">A continuación tienes una tabla con los nuevos precios de energía y potencia (vigentes a partir del 1 de enero de 2024), y una comparación con los precios actuales (vigentes hasta 31 de diciembre de 2023) de la tarifa que tienes contratada actualmente. En ambos casos los impuestos aplicados son: ${data['impostos_str']} e impuesto eléctrico del 5,11%.</span></p>
<br>
<p><strong>Tarifa ${data['tarifa_acces']} periodos</strong></p>
<p><strong>Precio del término de potencia (en euros/kW y día)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th></th>
                <th>Antes de impuestos</th>
                <th>Después de impuestos</th>
            </tr>
            <tr>
                <td rowspan="6">Nuevos precios</td>
                <td>P1</td>
                <td>${data['preus_nous']['tp']['P1']}</td>
                <td>${data['preus_nous_imp']['tp']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
                    <td>${data['preus_nous']['tp'][periode]}</td>
                    <td>${data['preus_nous_imp']['tp'][periode]}</td>
                </tr>
            % endfor
            <tr>
                <td rowspan="6">Precios actuales</td>
                <td>P1</td>
                <td>${data['preus_antics']['tp']['P1']}</td>
                <td>${data['preus_antics_imp']['tp']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
                    <td>${data['preus_antics']['tp'][periode]}</td>
                    <td>${data['preus_antics_imp']['tp'][periode]}</td>
                </tr>
            % endfor
        </tbody>
    </table>
</figure>

<br>
<p><strong>Precio del término de energía (en euros/kWh)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th></th>
                <th>Antes de impuestos</th>
                <th>Después de impuestos</th>
            </tr>
            <tr>
                <td rowspan="6">Nuevos precios</td>
                <td>P1</td>
                <td>${data['preus_nous']['te']['P1']}</td>
                <td>${data['preus_nous_imp']['te']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
                    <td>${data['preus_nous']['te'][periode]}</td>
                    <td>${data['preus_nous_imp']['te'][periode]}</td>
                </tr>
            % endfor
            <tr>
                <td rowspan="6">Precios actuales</td>
                <td>P1</td>
                <td>${data['preus_antics']['te']['P1']}</td>
                <td>${data['preus_antics_imp']['te']['P1']}</td>
            </tr>
            % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                <tr>
                    <td>${periode}</td>
                    <td>${data['preus_antics']['te'][periode]}</td>
                    <td>${data['preus_antics_imp']['te'][periode]}</td>
                </tr>
            % endfor
        </tbody>
    </table>
</figure>

    %if data['te_gkwh']:
        <br>
        <p><strong>Generation kWh: precio del término de energía (en euros/kWh)</strong></p>
        <figure class="table">
            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <th></th>
                        <th></th>
                        <th>Antes de impuestos</th>
                        <th>Después de impuestos</th>
                    </tr>
                    <tr>
                        <td rowspan="6">Nuevos precios</td>
                        <td>P1</td>
                        <td>${data['preus_nous_generation']['P1']}</td>
                        <td>${data['preus_nous_generation_imp']['P1']}</td>
                    </tr>
                    % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                        <tr>
                            <td>${periode}</td>
                            <td>${data['preus_nous_generation'][periode]}</td>
                            <td>${data['preus_nous_generation_imp'][periode]}</td>
                        </tr>
                    % endfor
                    <tr>
                        <td rowspan="6">Precios actuales</td>
                        <td>P1</td>
                        <td>${data['preus_antics_generation']['P1']}</td>
                        <td>${data['preus_antics_generation_imp']['P1']}</td>
                    </tr>
                    % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                        <tr>
                            <td>${periode}</td>
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
<p><strong>Nuevos precios y comparativa con precios actuales</strong></p>
<p><span style="font-weight: 400;">A continuación tienes una tabla con los nuevos precios del término de potencia (vigentes a partir del 1 de enero de 2024), y una comparación con los precios actuales (vigentes hasta 31 de diciembre de 2023) de la tarifa que tienes contratada actualmente. En ambos casos, los impuestos aplicados son los que se aplicarán a partir de enero, es decir, ${data['impostos_str']} e impuesto eléctrico del 5,11%.</span></p>
<br>
<p><strong>Tarifa ${data['tarifa_acces']} indexada</strong></p>
<p><strong>Precio del término de potencia (en euros/kW y día)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
            <th></th>
                <th colspan="2">Nuevos precios</th>
                <th colspan="2">Precios actuales</th>
            </tr>
            <tr>
                <td></td>
                <td>Periodo punta</td>
                <td>Periodo valle</td>
                <td>Periodo punta</td>
                <td>Periodo valle</td>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['preus_nous']['tp']['P1']}</td>
                <td>${data['preus_nous']['tp']['P2']}</td>
                <td>${data['preus_antics']['tp']['P1']}</td>
                <td>${data['preus_antics']['tp']['P2']}</td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
                <td>${data['preus_nous_imp']['tp']['P1']}</td>
                <td>${data['preus_nous_imp']['tp']['P2']}</td>
                <td>${data['preus_antics_imp']['tp']['P1']}</td>
                <td>${data['preus_antics_imp']['tp']['P2']}</td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
<p><span style="font-weight: 400;">Respecto al precio de la <strong>energía</strong>, como sabes, en las tarifas indexadas responde a una fórmula. Te ponemos la fórmula, que en este caso, no ha variado.</span></p>
<p><span style="font-weight: 400;color:gray">PH = 1,015 * [(PHM + PHMA + Pc + Sc + I + POsOm) (1 + Perd) + FE + F] + PTD + CA </span></p>
<p><span style="font-weight: 400;">En <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#formula-indexada">nuestra web</a> puedes ver a qué corresponde cada término.</span></p>
<p><span style="font-weight: 400;">La franja de la cooperativa, la “F” (la parte que establece Som Energia) seguirá siendo de 0,020 euros/kWh.</span></p>

    %if data['te_gkwh']:
        <br>
        <p><strong>Generation kWh: precio del término de energía (en euros/kWh)</strong></p>
        <figure class="table">
            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <th></th>
                        <th colspan="3">Nuevos precios</th>
                        <th colspan="3">Precios actuales</th>
                    </tr>
                    <tr>
                        <td></td>
                        <td>Periodo punta</td>
                        <td>Periodo llano</td>
                        <td>Periodo valle</td>
                        <td>Periodo punta</td>
                        <td>Periodo llano</td>
                        <td>Periodo valle</td>
                    </tr>
                    <tr>
                        <td>Antes de impuestos</td>
                        <td>${data['preus_nous_generation']['P1']}</td>
                        <td>${data['preus_nous_generation']['P2']}</td>
                        <td>${data['preus_nous_generation']['P3']}</td>
                        <td>${data['preus_antics_generation']['P1']}</td>
                        <td>${data['preus_antics_generation']['P2']}</td>
                        <td>${data['preus_antics_generation']['P3']}</td>
                    </tr>
                    <tr>
                        <td>Después de impuestos</td>
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


## Ull preus hardcodejats al backend, ja que no podem treure'ls dinàmicament si no té auto.
% if not data['indexada']:

<br>
<p><strong>Precio de compensación de excedentes de autoproducción (euros/kWh)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Nuevos precios</th>
                <th>Precios actuales</th>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['auto']['nous']['sense_impostos']}</td>
                <td>${data['auto']['vells']['sense_impostos']}</td></td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
                <td>${data['auto']['nous']['amb_impostos']}</td></td>
                <td>${data['auto']['vells']['amb_impostos']}</td></td>
            </tr>
        </tbody>
    </table>
</figure>

% endif


% if data['origen'] == 'consums':

<br>
<p><strong>Estimación</strong></p>
<p><span style="font-weight: 400;">Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong>, a partir de los datos que tenemos respecto a lo consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, y sin autoproducción ni Generation kWh ni alquiler de contador. A continuación encontrarás la estimación aproximada del coste anual si aplicáramos los precios actuales, y del coste anual si aplicáramos los nuevos precios.</span></p>
<p><span style="font-weight: 400;">En ambos casos la estimación incluye ${data['impostos_str']} y el impuesto eléctrico del 5,11%, es decir, los impuestos que se aplicarán a partir de enero (ten en cuenta que en 2023 algunos contratos han tenido impuestos rebajados).</span></p>
<br>
<p><strong>Coste anual estimado (euros/año)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Coste estimado con los nuevos precios</th>
                <th>Coste estimado con los precios actuales</th>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['preu_nou']}</td>
                <td>${data['preu_vell']}</td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
                <td>${data['preu_nou_imp']}</td>
                <td>${data['preu_vell_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>

<p><span style="font-weight: 400;">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente realices, otras variaciones de precios durante el año, o cambios que pueda haber en el mercado eléctrico.</span></p>
<br>
<p><span style="font-weight: 400;">En nuestro blog encontrarás la <a href="https://blog.somenergia.coop/?p=46598">noticia</a> del cambio de tarifas, y en la página web puedes consultar en cualquier momento <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">todas las tarifas</a>. Si quieres hacer comparaciones, puedes acceder al apartado <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde están también los precios vigentes hasta el 31 de diciembre y los de periodos anteriores.</span></p>

% endif


% if data['origen'] == 'cnmc':

<br>
<p><strong>Estimación</strong></p>
<p><span style="font-weight: 400;">Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong>, a partir de los datos que tenemos de tus consumos (sin tener en cuenta autoproducción ni Generation kWh ni alquiler de contador), y extrapolándolos según el consumo medio que suele haber en cada mes (según datos de la Comisión Nacional de los Mercados y la Competencia). Con esto hemos obtenido un consumo anual, que es el que comparamos a continuación, con los precios actuales y los nuevos precios.</span></p>
<p><span style="font-weight: 400;">En ambos casos la estimación incluye el ${data['impostos_str']} y el impuesto eléctrico del 5,11%, es decir, los impuestos que se aplicarán a partir de enero (a lo largo de 2023 algunos contratos han tenido impuestos rebajados).</span></p>
<br>
<p><strong>Coste anual estimado (euros/año)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Coste estimado con los nuevos precios</th>
                <th>Coste estimado con los precios actuales</th>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['preu_nou']}</td>
                <td>${data['preu_vell']}</td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
                <td>${data['preu_nou_imp']}</td>
                <td>${data['preu_vell_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>

<p><span style="font-weight: 400;">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente realices, otras variaciones de precios durante el año, o cambios que pueda haber en el mercado eléctrico.</span></p>
<br>
<p><span style="font-weight: 400;">En nuestro blog encontrarás la <a href="https://blog.somenergia.coop/?p=46598">noticia</a> del cambio de tarifas, y en la página web puedes consultar en cualquier momento <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">todas las tarifas</a>. Si quieres hacer comparaciones, puedes acceder al apartado <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde están también los precios vigentes hasta el 31 de diciembre y los de periodos anteriores.</span></p>

% endif

% if data['origen'] == 'estadistic':

<br>
<p><strong>Estimación</strong></p>
<p><span style="font-weight: 400;">Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong>, en función de la potencia contratada más alta que tienes (${data['potencia_max']} kW), el uso de electricidad que suele haber con esta potencia y cogiendo de referencia un contrato estándar, sin autoproducción ni Generation kWh ni alquiler de contador.</span></p>
<p><span style="font-weight: 400;">En ambos casos la estimación incluye el ${data['impostos_str']} y el impuesto eléctrico del 5,11%, es decir, los que se aplicarán a partir de enero (durante 2023 algunos contratos han tenido impuestos rebajados).
</span></p>
<p><span style="font-weight: 400;">Así pues, te mostramos a continuación la estimación aproximada del coste anual si aplicáramos los precios actuales, y el coste anual si aplicáramos los nuevos precios.</span></p>
<br>
<p><strong>Coste anual estimado (euros/año)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Coste estimado con los nuevos precios</th>
                <th>Coste estimado con los precios actuales</th>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['preu_nou']}</td>
                <td>${data['preu_vell']}</td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
                <td>${data['preu_nou_imp']}</td>
                <td>${data['preu_vell_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>

<p><span style="font-weight: 400;">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente realices, otras variaciones de precios durante el año, o cambios que pueda haber en el mercado eléctrico.</span></p>
<br>
<p><span style="font-weight: 400;">En nuestro blog encontrarás la <a href="https://blog.somenergia.coop/?p=46598">noticia</a> del cambio de tarifas, y en la página web puedes consultar en cualquier momento <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">todas las tarifas</a>. Si quieres hacer comparaciones, puedes acceder al apartado <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde están también los precios vigentes hasta el 31 de diciembre y los de periodos anteriores.</span></p>

% endif


% if data['origen'] == 'indexada':

<br>
<p><strong>Estimación</strong></p>
<p><span style="font-weight: 400;">Tal y como establece la normativa, hemos realizado una estimación del coste de la factura de la luz, en función de tu consumo energético durante el último año (aproximadamente ${data['consum_total']} kWh), con el cambio de precios. Como el precio de la energía en la tarifa indexada varía cada hora, para hacer la estimación hemos utilizado un precio medio en función de las previsiones actuales de precios para 2024. Ten en cuenta, sin embargo, que justamente como el precio de la energía en mercado evoluciona todos los días y cada hora, es muy posible que <strong>la estimación no refleje lo que acabe pasando</strong>.</span></p>
<br>
<p><strong>Coste anual estimado (euros/año)</strong></p>
<figure class="table">
    <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
        <tbody>
            <tr>
                <th></th>
                <th>Coste estimado con los nuevos precios</th>
                <th>Coste estimado con los precios actuales</th>
            </tr>
            <tr>
                <td>Antes de impuestos</td>
                <td>${data['preu_nou']}</td>
                <td>${data['preu_vell']}</td>
            </tr>
            <tr>
                <td>Después de impuestos</td>
                <td>${data['preu_nou_imp']}</td>
                <td>${data['preu_vell_imp']}</td>
            </tr>
        </tbody>
    </table>
</figure>   

<p><span style="font-weight: 400;">Los impuestos aplicados son, en ambos casos, los que estarán vigentes a partir del 1 de enero (${data['impostos_str']} e impuesto eléctrico del 5,11%).</span></p>
<p><span style="font-weight: 400;">Como te decíamos, esto son estimaciones aproximadas, y los importes finales <strong> dependerán de circunstancias</strong> que no se pueden saber a día de hoy, como son <strong>el precio de la energía para los próximos meses</strong>, los horarios y el uso de energía que finalmente hagas, u otros cambios que pueda haber en el mercado eléctrico.</span></p>
<br>
<p><span style="font-weight: 400;">En nuestro blog encontrarás la <a href="https://blog.somenergia.coop/?p=46598">noticia</a> del cambio de tarifas, y en la página web puedes consultar en cualquier momento <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">todas las tarifas</a>.</span></p>
% endif
<br>
<p><strong>Información legal</strong></p>

<p><span style="font-weight: 400;">Las <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/#precio-y-actualizacion">cláusulas contractuales de las Condiciones Generales</a> que nos autorizan a realizar este cambio de precios son la cláusula 5.3 (i) para los cambios regulados por normativa (por ejemplo, los impuestos), y la cláusula 5.3 (ii) para las modificaciones de la parte del precio no regulada.</span></p>

% if not data['indexada']:
<p><span style="font-weight: 400;">Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a href="https://comparador.cnmc.gob.es">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de las comercializadoras del mercado libre. Ten en cuenta que posiblemente, en el momento de leer este correo, las nuevas tarifas de Som Energia todavía no estarán reflejadas.</span></p>
% endif

<p><span style="font-weight: 400;">Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos informarte de que si, por alguna razón, este cambio de precios te hiciese replantear seguir con esta tarifa, podrías cambiarte a la

% if data['indexada']:
<a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/">tarifa por periodos</a>
% else:
<a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/">tarifa indexada</a>
% endif

(<a href="https://es.support.somenergia.coop/article/1345-modificacion-de-la-tarifa-de-periodos-a-indexada-y-de-indexada-a-periodos?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">a través de tu Oficina Virtual</a>),  o podrías dar de baja tu contrato con nosotros, bien comunicándonoslo directamente, o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejemos de suministrarte energía, con los precios vigentes en cada momento.</span></p>


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
