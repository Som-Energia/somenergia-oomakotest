<%
    import datetime
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

    is_cat = object.member_id.partner_id.lang == "ca_ES"
    try:
        p_obj = object.pool.get('res.partner')
        if not p_obj.vat_es_empresa(object._cr, object._uid, object.member_id.partner_id.vat):
            nom_titular = ' ' + object.member_id.partner_id.name.split(',')[1].lstrip() + ','
        else:
            nom_titular = ','
    except:
        nom_titular = ','

    order_date = datetime.datetime.strptime(object.order_date, "%Y-%m-%d").strftime('%d/%m/%Y')
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
T'informem que s'ha activat la teva aportació al Generation kWh ${object.name}
que vas fer amb data ${order_date}.
<br/>
Això significa que, a partir d'ara, ja es veurà reflectida l'energia d'aquesta aportació
a les teves factures, o a les d'aquells contractes que ens has indicat.
</p>

<p>
Des de l'<a href="https://oficinavirtual.somenergia.coop/">Oficina Virtual</a>
en qualsevol moment pots gestionar quins contractes reben l'energia Generation kWh.
</p>

<p>
Aprofitem per donar-te les gràcies un cop més per la teva participació al Generation kWh.
Aquest suport ens ajuda a caminar cap a la transformació energètica.
</p>

<p>Salut i bona energia!</p>
%endif

% if not is_cat:
<p>
Te informamos que se ha activado tu aportación al Generation kWh ${object.name}
que hiciste con fecha ${order_date}.
<br/>
Eso significa que, a partir de ahora, ya se verá reflejada la energía de esta aportación
en tus facturas, o en las de aquellos contratos que nos has indicado.
</p>
<p>
Desde la <a href="https://oficinavirtual.somenergia.coop/">Oficina Virtual</a>
en cualquier momento puedes gestionar qué contratos reciben la energía Generation kWh.
</p>
<p>
Aprovechamos para darte las gracias una vez más por tu participación en el Generation kWh.
Este apoyo nos ayuda a caminar hacia la transformación energética.
</p>

<p>¡Salud y buena energía!</p>
%endif

<p>
Som Energia.
<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a>
<br/>
<a href="https://www.generationkwh.org">www.generationkwh.org</a>
</p>

<br>
${text_legal}
</div>
</body>
</html>
