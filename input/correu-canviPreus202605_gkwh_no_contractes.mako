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

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

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

${plantilla_header}

<!-- MAILDEV_CODE: ${object.partner_id.ref} -->

<p>
  Hola${nom_titular} <br/>
</p>

% if is_cat: # CATALÀ
    <p>T’escrivim per informar-te que, a partir de l’1 de maig, actualitzarem la forma de calcular la <strong>tarifa Generation kWh</strong> per adaptar-nos al context d’inestabilitat geopolítica actual. El canvi principal és que els <strong>Serveis d’Ajust</strong> — costos obligatoris que fixa Red Eléctrica Española per assegurar el correcte funcionament de la xarxa — passaran a cobrar-se a part segons el seu cost real a cada factura, en lloc d'estar inclosos en el preu de l'energia.</p>
    <p><strong>Aquesta actualització no t’afecta directament a la teva factura actual, ja que ara mateix no tens cap contracte del qual siguis titular assignat amb energia a preu Generation kWh.</strong></p>
    <p>Al web pots consultar els <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-generationkwh?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">preus de la tarifa Generation kWh</a>, i pots comparar-les amb les de dates anteriors <a target="_blank" href="https://www.somenergia.coop/ca/historic-tarifa-periodes?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquí</a>.</p>
    <p>Et recordem que a la teva <a target="_blank" href="https://oficinavirtual.somenergia.coop/ca/login/?next=/ca/investments/investments-kwh/?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Oficina Virtual</a> pots veure a quin o quins contractes va a parar l’energia a preu Generation kWh que et correspon.</p>
    <p>Com a participant de Generation kWh, et pertoca una part de l’energia a preu Generation kWh. Si vols afegir part d’aquesta energia a preu Generation kWh, als contractes dels quals siguis titular, pots fer-ho a través de l’<a target="_blank" href="https://oficinavirtual.somenergia.coop/ca/login/?next=/ca/investments/investments-kwh/?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Oficina Virtual</a>.</p>
    <p>Si vols fer modificacions d’assignacions de contractes dels quals no siguis titular, escriu-nos un correu a generationkwh@somenergia.coop.</p>
    <p>Et recordem que les condicions del Generation kWh estan detallades a les <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/Condicions-Generals-Contracte-Autoproduccio-Collectiva-Generation-kWh-CA.pdf">Condicions Generals del Generation kWh</a>.</p>
    <br/>
    <p>Aprofitem per donar-te les gràcies un cop més per la teva participació al Generation kWh.</p>
    <p>Aquest tipus de suport és un dels que ens ajuda a caminar cap a la transformació energètica.</p>
    <h3 style="font-size: 16px">Informació legal</h3>
    <p class="p-legal">
        Pots accedir al comparador d’ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través d’<a href="https://comparador.cnmc.gob.es">aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents d’algunes de les comercialitzadores del mercat lliure. Tingues en compte que les tarifes de Som Energia no hi estan incloses.
    </p>
    <p class="p-legal">
        Igualment, hem d’informar-te que si, per alguna raó, aquest canvi a la tarifa Generation kWh et fes replantejar mantenir la teva aportació, pots escriure’ns un correu a <a href="mailto:info@somenergia.coop">info@somenergia.coop</a>.
    </p>
    <br/>
    <br/>
    <p>Salutacions,</p>
    <p>Som Energia.</p>
%else: ## CASTELLANO
    <p>Te escribimos para informarte que, a partir del 1 de mayo, actualizaremos la forma de calcular la <strong>tarifa Generation kWh</strong> para adaptarnos al contexto de inestabilidad geopolítica actual. El cambio principal es que los <strong>Servicios de Ajuste</strong> – costes obligatorios que fija Red Eléctrica Española por asegurar el correcto funcionamiento de la red – pasarán a cobrarse aparte según su coste real en cada factura, en lugar de estar incluidos en el precio de la energía.</p>
    <p><strong>Esta actualización no te afecta directamente a tu factura actual, ya que ahora mismo no tienes ningún contrato del que seas titular asignado con energía a precio Generation kWh.</strong></p>
    <p>En la web puedes consultar los <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-generationkwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">precios de las tarifas Generation kWh</a>, y puedes compararlas con las de fechas anteriores <a target="_blank" href="https://www.somenergia.coop/es/historico-tarifa-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">aquí</a>.</p>
    <p>Te recordamos que en tu <a target="_blank" href="https://oficinavirtual.somenergia.coop/es/login/?next=/es/investments/investments-kwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">Oficina Virtual</a> puedes ver a qué contrato o contratos va a parar la energía a precio Generation kWh que te corresponde.</p>
    <p>Como participante de Generation kWh, te corresponde una parte de la energía a precio Generation kWh. Si quieres añadir parte de esta energía a precio Generation kWh, a contratos de los cuáles seas titular, puedes hacerlo a través de la <a target="_blank" href="https://oficinavirtual.somenergia.coop/es/login/?next=/es/investments/investments-kwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">Oficina Virtual</a>.</p>
    <p>Si quieres realizar modificaciones de asignaciones de contratos de los que no seas titular, escríbenos un correo a generationkwh@somenergia.coop.</p>
    <p>Te recordamos que las condiciones del Generation kWh están detalladas en las <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/Condiciones-Generales-Contrato-Autoproduccion-Colectiva-Generation-kWh-ES.pdf?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Condiciones generales de Generation kWh</a>.</p>
    <p>Aprovechamos para darte las gracias una vez más por tu participación en el Generation kWh. Este tipo de soporte es uno de los que nos ayuda a caminar hacia la transformación energética.</p>
    <p></p>
    <h3 style="font-size: 16px">Información legal</h3>
    <p class="p-legal">
        Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a href="https://comparador.cnmc.gob.es">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de algunas de las comercializadoras del mercado libre. Ten en cuenta que las tarifas de Som Energia no están incluidas.
    </p>
    <p class="p-legal">
        Igualmente, debemos informarte de que si, por alguna razón, este cambio de precios te hiciese replantear mantener tu aportación, puedes escribirnos un correo a <a href="mailto:info@somenergia.coop">info@somenergia.coop</a>
    </p>
    <br/>
    <br/>
    <p>Saludos,</p>
    <p>Som Energia.</p>
%endif
${plantilla_footer}