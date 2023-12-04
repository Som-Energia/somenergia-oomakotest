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


</head>
## TODO: Passar sempre l'inliner: https://templates.mailchimp.com/resources/inline-css/
<body style="text-align: justify; font-family: 'Roboto Mono', Arial; font-size: 14px; line-height: 175%;">
<div style="width:96%;max-width:1200px;margin:20px auto;">

% if is_cat:
<a href="https://www.somenergia.coop/ca/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif
% if not is_cat:
<a href="https://www.somenergia.coop/es/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif

<br>
<br>

<p>Hola${nom_titular}</p>

% if is_cat:
<p>
A partir de l’1 de gener modificarem els preus de les tarifes de la cooperativa.
En aquesta actualització de preus també hem fet una revisió i actualització
dels preus del Generation kWh i alguns components són una mica menors, per tant,
ha resultat una lleugera disminució respecte als preus actuals.
</p>

<p>
T'informem de com queden actualment els nous preus, i hi incloem també una comparació
amb els preus actuals (en el cas dels impostos, hi hem aplicat els que seran vigents
a partir del gener).
</p>

<p><strong>Preus Generation kWh (en euros)</strong></p>
%endif

% if not is_cat:
<p>
A partir del 1 de enero modificaremos los precios de las tarifas de la cooperativa.
En esta actualización de precios también hemos hecho una revisión y actualización
de los precios del Generation kWh y algunos componentes son un poco menores, por lo tanto,
ha resultado una ligera disminución respecto a los precios actuales.
</p>

<p>
Te informamos de cómo quedan actualmente los nuevos precios, e incluimos también una
comparación con los precios actuales (en el caso de los impuestos,
hemos aplicado los que serán vigentes a partir de enero).
</p>

<p><strong>Precios Generation kWh (en euros)</strong></p>
%endif

<figure class="table">
<table class="tarifestb bordall" style="max-width: 550px;margin-left: auto;margin-right: auto;font-family: Roboto;font-size: 1em;line-height: 1.3em;border: 1px solid black!important;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
    <colgroup>
        <col span="1" style="width: 90px;">
        <col span="1" style="width: 80px;">
        <col span="1" style="width: 27%;">
        <col span="1" style="width: 27%;">
        <col span="1" style="width: 27%;">
    </colgroup>
    <thead class="bordall" style="border: 1px solid black!important;">
        <tr class="bordsota" style="border-bottom: 1px solid black!important;">
            <th class="centertxt grisfosc" rowspan="2" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #4D4D4D;color: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">Tarifa</th>
            <th class="centertxt grisfosc" rowspan="2" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #4D4D4D;color: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                ${'Període' if is_cat else 'Período'}
            </th>
            <th class="centertxt verdc" rowspan="2" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #E0E723;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                ${'Preu de la potència contractada' if is_cat else 'Precio de la potencia contratada'}
                <br>${'(€/kW i any)' if is_cat else '(€/kW y año)'}
            </th>
            <th class="centertxt verd" colspan="2" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #97D700;border: none;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                ${'Preu de l\'energia (€/kWh)' if is_cat else 'Precio de la energía (€/kWh)'}
            </th>
        </tr>
        <tr>
            <th class="centertxt verd" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #97D700;border: none;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                ${'Preu estàndard' if is_cat else 'Precio estándar'}
            </th>
            <th class="centertxt verd" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #97D700;border: none;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                ${'Preu Generation kWh' if is_cat else 'Precio Generation kWh'}
            </th>
        </tr>
    </thead>
    <tbody>
        <tr class="trfwhite">
            <td class="centertxt" rowspan="3" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">2.0TD</td>
            <td class="senseborder" style="border-bottom: none;border-top: none;text-align: center;background: white;border-right: 1px solid black!important;">Punta</td>
            <td class="centertxt" rowspan="2" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">27,474</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,247</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,187</td>
        </tr>
        <tr class="trfwhite">
            <td class="senseborder" style="border-bottom: none;border-top: none;text-align: center;background: white;border-right: 1px solid black!important;">${'Pla' if is_cat else 'Llano'}</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,189</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,139</td>
        </tr>
        <tr class="trfwhite bordsota" style="border-bottom: 1px solid black!important;">
            <td class="centertxt punts" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;border-top: 1px dotted black!important;">${'Vall' if is_cat else 'Valle'}</td>
            <td class="centertxt punts" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;border-top: 1px dotted black!important;">3,433</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,154</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,116</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" rowspan="6" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">3.0TD</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P1</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">13,982509</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,215</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,154</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P2</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">11,899074</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,197</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,142</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P3</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">4,002045</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,167</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,117</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P4</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">3,653973</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,159</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,110</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P5</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">2,732707</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,145</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,104</td>
        </tr>
        <tr class="trfgris bordsota" style="border-bottom: 1px solid black!important;">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P6</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">2,001136</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,147</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,108</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" rowspan="6" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">6.1TD</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P1</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">22,965215</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,184</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,124</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P2</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">19,841178</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,172</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,115</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P3</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">10,327582</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,150</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,098</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P4</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">8,560662</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,148</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,095</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P5</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">1,908583</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,136</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,088</td>
        </tr>
        <tr class="trfwhite bordsota" style="border-bottom: 1px solid black!important;">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P6</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">1,148958</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,137</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,092</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" rowspan="6" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">3.0TDVE</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P1</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">2,558984</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,302</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,241</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P2</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">2,503926</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,266</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,210</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P3</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,664441</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,198</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,147</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P4</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,573622</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,179</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,130</td>
        </tr>
        <tr class="trfgris">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P5</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,338303</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,150</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,109</td>
        </tr>
        <tr class="trfgris bordsota" style="border-bottom: 1px solid black!important;">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P6</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,338303</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,150</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: #EFEFEF;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,111</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" rowspan="6" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">6.1TDVE</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P1</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">4,269983</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,332</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,272</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P2</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">4,002324</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,288</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,231</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P3</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">1,994267</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,201</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,149</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P4</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">1,599721</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,182</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,130</td>
        </tr>
        <tr class="trfwhite">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P5</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,113126</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,143</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,094</td>
        </tr>
        <tr class="trfwhite bordsota" style="border-bottom: 1px solid black!important;">
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">P6</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,113126</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,142</td>
            <td class="centertxt" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">0,096</td>
        </tr>
    </tbody>
</table>
</figure>

<figure class="table">
    <table class="tarifestb" style="border-right: none !important;max-width: 550px;margin-left: auto;margin-right: auto;font-family: Roboto;font-size: 1em;line-height: 1.3em;border-collapse: collapse!important;padding: 6px!important;"><tr>
        <td>
            <table class="tarifestb bordall" style="max-width: 550px;margin-left: auto;margin-right: auto;font-family: Roboto;font-size: 1em;line-height: 1.3em;border: 1px solid black!important;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                <tr class="trfwhite">
                    <td class="bordall espai-dins" style="padding: 4px 10px;background: white;border: 1px solid black!important;">
                        ${'Preu compensació dels' if is_cat else 'Precio compensación'}
                        <br>${'excedents d\'autoproducció' if is_cat else 'excedentes autoproducción'}
                        <br>(€/kWh)</td>
                    <td class="centertxt bordall espai-dins" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;padding: 6px!important;background: white;border: 1px solid black!important;border-collapse: collapse!important;border-right: 1px solid black!important;">0,070</td>
                </tr>
            </table>
            <br>
            <table class="tarifestb bordall" style="max-width: 550px;margin-left: auto;margin-right: auto;font-family: Roboto;font-size: 1em;line-height: 1.3em;border: 1px solid black!important;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                <tr class="trfwhite">
                    <td class="bordall espai-dins" style="padding: 4px 10px;background: white;border: 1px solid black!important;">
                        ${'Bo Social (€/dia)' if is_cat else 'Bono Social (€/día)'}
                    </td>
                    <td class="centertxt bordall espai-dins" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;padding: 6px!important;background: white;border: 1px solid black!important;border-collapse: collapse!important;border-right: 1px solid black!important;">0,038455</td>
                </tr>
            </table>
        </td>
        <td style="padding-left: 30px;">
            <table class="tarifestb bordall" style="max-width: 550px;margin-left: auto;margin-right: auto;font-family: Roboto;font-size: 1em;line-height: 1.3em;border: 1px solid black!important;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                <thead class="bordall" style="border: 1px solid black!important;">
                    <tr class="bordsota" style="border-bottom: 1px solid black!important;">
                        <th class="centertxt verdc" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #E0E723;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                            ${'Impost' if is_cat else 'Impuesto'}
                        </th>
                        <th class="centertxt verdc" style="font-family: Roboto;font-size: 1em;line-height: 1.3em;text-align: center;text-transform: initial;background: #E0E723;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">
                            ${'Preu' if is_cat else 'Precio'}
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="trfwhite">
                        <td class="bordall espai-dins" style="padding: 4px 10px;background: white;border: 1px solid black!important;">IVA</td>
                        <td class="centertxt bordall" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border: 1px solid black!important;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">21%</td>
                    </tr>
                    <tr class="trfwhite">
                        <td class="bordall espai-dins" style="padding: 4px 10px;background: white;border: 1px solid black!important;">
                            ${'Impost' if is_cat else 'Impuesto'}
                            <br>${'elèctric' if is_cat else 'eléctrico'}
                        </td>
                        <td class="centertxt bordall" style="text-align: center;text-transform: initial;font-family: Roboto;font-size: 1em;line-height: 1.3em;background: white;border: 1px solid black!important;border-collapse: collapse!important;padding: 6px!important;border-right: 1px solid black!important;">5,11269632%</td>
                    </tr>
                </tbody>
            </table>
        </td>
    </tr></table>
</figure>

% if is_cat:
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
% endif

% if not is_cat:
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
% endif

<p>Som Energia.</p>

</div>
</body>

