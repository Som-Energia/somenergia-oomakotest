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
Com ja deus haver notat a les factures d'electricitat, el preu de l'energia al mercat
majorista ha baixat, i les previsions són que segueixi disminuint.
</p>

<p>
Si bé el preu de l'energia al mercat majorista no afecta a la tarifa Generation kWh,
sí que afecta a alguns conceptes que hi hem d'aplicar, com per exemple el que està
relacionat amb les pèrdues d'energia pel trasllat per la xarxa.
</p>

<p>
És per això que <strong>els <a href="https://www.generationkwh.org/ca/tarifa-generation-kwh/">preus de la tarifa Generation kWh</a> han baixat lleugerament</strong>.
Pots consultar-los al web del Generation kWh, i pots comparar-los amb dates anteriors
<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/historic-de-tarifes/">aquí</a>.
</p>

<p>
Aprofitem per donar-te les gràcies un cop més per la teva participació al Generation kWh.
Aquest tipus de suport és un dels que ens ajuda a caminar cap a la transformació energètica.
</p>

<p style="margin-top: 30px;"><strong>Informació legal</strong></p>

<p>
Si aquesta baixada de preus del Generation kWh no et convenç, i vols deixar de
tenir energia al preu Generation kWh, pots o bé traspassar-la a un altre contracte
(amb la seva conformitat), o bé pots demanar el retorn del préstec Generation kWh,
i deixaràs de tenir drets d'energia a preu Generation kWh (tal com estableixen les
<a href="https://www.generationkwh.org/wp-content/uploads/Condicions-Generals-Contracte-Autoproduccio-Col_lectiva-Generation-kWh_CA.pdf">
condicions generals del préstec</a>).
</p>

<p>
Com que el preu Generation kWh forma part de les condicions particulars del teu
contracte amb Som Energia, legalment hem de dir-te que, si ho desitges, pots desistir
del contracte. Si fos el cas, podries donar de baixa el teu contracte de subministrament
amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de
comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni
clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et
facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia,
amb els preus vigents a cada moment.
</p>

<p>Salut i bona energia!</p>
%endif

% if not is_cat:
<p>
Como ya habrás notado en las facturas de electricidad, el precio de la energía en el
mercado mayorista ha bajado, y las previsiones son que siga disminuyendo.
</p>

<p>
Si bien el precio de la energía en el mercado mayorista no afecta a la tarifa
Generation kWh, sí afecta a algunos conceptos que debemos aplicarle, como por ejemplo
el relacionado con las pérdidas de energía por el traslado por la red.
</p>

<p>
Es por eso que <strong>los <a href="https://www.generationkwh.org/es/tarifa-generation-kwh/">precios de la tarifa Generation kWh</a> han descendido ligeramente.</strong>
Puedes consultarlos en la web del Generation kWh, y puedes compararlos con los de fechas anteriores
<a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">aquí</a>.
</p>

<p>
Aprovechamos para darte las gracias una vez más por tu participación en el Generation kWh.
Este tipo de apoyo es uno de los que nos ayuda a caminar hacia la transformación energética.
</p>

<p style="margin-top: 30px;"><strong>Información legal</strong></p>

<p>
Si esta bajada de precios del Generation kWh no te convence, y quieres dejar de tener
energía al precio Generation kWh, puedes traspasarla a otro contrato (con su conformidad),
o bien puedes pedir el retorno del préstamo Generation kWh, y dejarás de tener derechos
de energía a precio Generation kWh (de acuerdo a lo que establecen las
<a href="https://www.generationkwh.org/wp-content/uploads/Condiciones-Generales-Contrato-Autoproduccion-Colectiva-Generation-kWh_ES.pdf">condiciones generales del préstamo</a>).
</p>

<p>
Dado que el precio Generation kWh forma parte de las condiciones particulares de tu
contrato con Som Energia, legalmente debemos decirte que, si lo deseas, puedes desistir
del contrato. Si fuera el caso, podrías dar de baja tu contrato de suministro con nosotros,
bien comunicándonoslo directamente, o mediante un cambio de comercializadora.
Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de
permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos
el consumo realizado hasta el día en que dejemos de suministrarte energía,
con los precios vigentes en cada momento.
</p>

<p>¡Salud y buena energía!</p>
%endif

<p>Som Energia.</p>

<br>
${text_legal}
</div>
</body>
</html>
