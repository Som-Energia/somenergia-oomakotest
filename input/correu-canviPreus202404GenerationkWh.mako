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
        object._cr, object._uid,
        'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]
    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        object
    )

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
L'energia al mercat majorista ha baixat, i les previsions són que segueixi disminuint,
per això, el dia 1 d'abril farem una actualització de les tarifes per períodes
(l'expliquem <a href="https://blog.somenergia.coop/?p=47158">al blog</a>).
</p>

<p>
Si bé el preu de l'energia del mercat majorista no afecta a la tarifa Generation kWh,
sí que afecta a alguns conceptes que hi hem d'aplicar, com per exemple el que està
relacionat amb les pèrdues d'energia pel trasllat per la xarxa.
</p>

<p>És per això que els preus de la tarifa Generation kWh han baixat lleugerament.</p>

<p>
Al web del Generation kWh pots consultar els
<a href="https://www.generationkwh.org/ca/tarifa-generation-kwh/">preus de la tarifa Generation kWh</a>,
i pots comparar-les amb les de dates anteriors
<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/historic-de-tarifes/">aquí</a>.
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
La energía en el mercado mayorista ha bajado, y las previsiones son que siga disminuyendo,
por eso, el día 1 de abril haremos una actualización de las tarifas por periodos
(lo explicamos <a href="https://blog.somenergia.coop/?p=47160">en el blog</a>).
</p>

<p>
Si bien el precio de la energía del mercado mayorista no afecta a la tarifa Generation kWh,
sí afecta a algunos conceptos que debemos aplicar, como por ejemplo el que está
relacionado con las pérdidas de energía por el traslado por la red.
</p>

<p>Por ello, los precios de la tarifa Generation kWh han bajado ligeramente.</p>

<p>
En la web del Generation kWh puedes consultar los
<a href="https://www.generationkwh.org/es/tarifa-generation-kwh/">precios de la tarifa Generation kWh</a>,
y puedes compararlas con las de fechas anteriores
<a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">aquí</a>.
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

<br>
${text_legal}
</div>
</body>
</html>
