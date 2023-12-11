<%
    is_cat = object.partner_id.lang == "ca_ES"
    try:
        p_obj = object.pool.get('res.partner')
        if not p_obj.vat_es_empresa(object._cr, object._uid, object.partner_id.vat):
            nom_titular = ' ' + object.partner_id.name.split(',')[1].lstrip() + ','
        else:
            nom_titular = ','
    except:
        nom_titular = ','
%>
<!doctype html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
<style>
    body{ font-family: 'Roboto Mono', Arial; font-size: 16px; text-align:'justify'}
    .margin_top{ margin-top: 2em; }
</style>
</head>
## TODO: Passar sempre l'inliner: https://templates.mailchimp.com/resources/inline-css/
<body style="text-align: justify; font-family: 'Roboto Mono', Arial; font-size: 14px; line-height: 175%;" >
<div style="width:96%;max-width:1200px;margin:20px auto;">

% if is_cat:
<a href="https://www.somenergia.coop/ca/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif
% if not is_cat:
<a href="https://www.somenergia.coop/es/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif

<br/>
<br/>

<p>Hola${nom_titular}</p>

% if is_cat:
<p>
A partir de l’1 de gener modificarem els preus de les tarifes de la cooperativa.
En aquesta actualització de preus també hem fet una revisió i actualització
dels preus del Generation kWh i alguns components són una mica menors, per tant,
ha resultat una lleugera disminució respecte als preus actuals.
</p>

<p>
Al web del Generation kWh pots consultar els
<a href="https://www.generationkwh.org/ca/tarifa-generation-kwh/">preus de la tarifa Generation kWh</a>,
i pots comparar-les amb tarifes de dates anteriors a
l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/historic-de-tarifes/">històric de tarifes</a>.
</p>

<p>
Et recordem que les condicions del Generation kWh estan detallades a les
<a href="https://www.generationkwh.org/wp-content/uploads/Condicions-Generals-Contracte-Autoproduccio-Col_lectiva-Generation-kWh_CA.pdf">
Condicions Generals del Generation kWh</a>.
</p>
<p>
Aprofitem per donar-te les gràcies un cop més per la teva participació al Generation kWh.
Aquest tipus de suport és un dels que ens ajuda a caminar cap a la transformació energètica.
</p>

<p>Salut i bona energia!</p>
%endif

% if not is_cat:
<p>
A partir del 1 de enero modificaremos los precios de las tarifas de la cooperativa.
En esta actualización de precios también hemos hecho una revisión y actualización
de los precios del Generation kWh y algunos componentes son un poco menores, por lo tanto,
ha resultado una ligera disminución respecto a los precios actuales.
</p>

<p>
En la web del Generation kWh puedes consultar los
<a href="https://www.generationkwh.org/es/tarifa-generation-kwh/">precios de la tarifa Generation kWh</a>,
y puedes compararlas con tarifas de fechas anteriores en el
<a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>.
</p>

<p>
Te recordamos que las condiciones del Generation kWh están detalladas en las
<a href="https://www.generationkwh.org/wp-content/uploads/Condiciones-Generales-Contrato-Autoproduccion-Colectiva-Generation-kWh_ES.pdf">
Condiciones Generales del Generation kWh</a>.
</p>
<p>
Aprovechamos para darte las gracias una vez más por tu participación en el Generation kWh.
Este tipo de apoyo es uno de los que nos ayuda a caminar hacia la transformación energética.
</p>

<p>¡Salud y buena energía!</p>
%endif

<p>Som Energia.</p>

</div>
</body>
</html>
