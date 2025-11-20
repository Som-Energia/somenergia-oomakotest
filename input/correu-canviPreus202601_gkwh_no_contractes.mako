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

<p>
  Hola${nom_titular} <br/>
</p>

% if is_cat: # CATALÀ
    <p>Amb el canvi d’any, aprofitem per actualitzar petits termes (coeficients de pèrdues, apuntaments, sobrecostos…) de la tarifa Generation kWh. Això fa que l’energia als períodes punta i pla <strong>baixi lleugerament</strong>, i el període vall quedi <strong>igual</strong>.</p>
    <p>Al web pots consultar els <a href="https://www.somenergia.coop/ca/tarifes-llum/domestic-generationkwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">preus de la tarifa Generation kWh</a>, i pots comparar-les amb les de dates anteriors <a href="https://www.somenergia.coop/ca/historic-tarifa-periodes?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquí.</p>
    <p>Això no t’afecta directament, ja que actualment tu no tens cap contracte del qual siguis titular assignat amb energia a preu Generation kWh. </p>
    <p>Et recordem que a la teva <a href="https://oficinavirtual.somenergia.coop/ca/login/?next=/ca/investments/investments-kwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Oficina Virtual</a> pots veure a quin o quins contractes va a parar l’energia a preu Generation kWh que et correspon.</p>
    <p>Com a participant de Generation kWh, et pertoca una part de l’energia a preu Generation kWh. Si vols afegir part d’aquesta energia a preu Generation kWh, als contractes dels quals siguis titular, pots fer-ho a través de l’<a href="https://oficinavirtual.somenergia.coop/ca/login/?next=/ca/investments/investments-kwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Oficina Virtual</a>.</p>
    <p>Si vols fer modificacions d’assignacions de contractes dels quals no siguis titular, escriu-nos un correu a generationkwh@somenergia.coop.</p>
    <p>Et recordem que les condicions del Generation kWh estan detallades a les <a href="https://back.somenergia.coop/storage/app/media/DOCS/Condicions-Generals-Contracte-Autoproduccio-Collectiva-Generation-kWh-CA.pdf?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Condicions Generals del Generation kWh</a>.</p>
    <br/>
    <p>Aprofitem per donar-te les gràcies un cop més per la teva participació al Generation kWh.</p>
    <p>Aquest tipus de suport és un dels que ens ajuda a caminar cap a la transformació energètica.</p>
    <br/>
    <br/>
    <p>Salutacions,</p>
    <p>Som Energia.</p>
%else: ## CASTELLANO
    <p>Con el cambio de año, aprovechamos para actualizar pequeños términos (coeficientes de pérdidas, apuntamientos, sobrecostes…) de la tarifa Generation kWh. Esto hace que la energía en los periodos punta y llano <strong>baje ligeramente</strong>, y el periodo valle quede <strong>igual</strong>.</p>
    <p>En la web puedes consultar los <a href="https://www.somenergia.coop/es/tarifas-luz/domestico-generationkwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">Precios de las tarifas Generation kWh</a>, y puedes compararlas con las de fechas anteriores <a href="https://www.somenergia.coop/es/historico-tarifa-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">aquí</a>.</p>
    <p>Esto no te afecta directamente, ya que actualmente tú no tienes ningún contrato del que seas titular asignado con energía a precio Generation kWh.</p>
    <p>Te recordamos que en tu <a href="https://oficinavirtual.somenergia.coop/es/login/?next=/es/investments/investments-kwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">Oficina Virtual</a> puedes ver a qué contrato o contratos va a parar la energía a precio Generation kWh que te corresponde.</p>
    <p>Como participante de Generation kWh, te corresponde una parte de la energía a precio Generation kWh. Si quieres añadir parte de esta energía a precio Generation kWh, a contratos de los cuáles seas titular, puedes hacerlo a través de la <a href="https://oficinavirtual.somenergia.coop/es/login/?next=/es/investments/investments-kwh/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">Oficina Virtual</a>.</p>
    <p>Si quieres realizar modificaciones de asignaciones de contratos de los que no seas titular, escríbenos un correo a generationkwh@somenergia.coop.</p>
    <p>Te recordamos que las condiciones del Generation kWh están detalladas en las <a href="https://back.somenergia.coop/storage/app/media/DOCS/Condicions-Generals-Contracte-Autoproduccio-Collectiva-Generation-kWh-CA.pdf">Condiciones generales de Generation kWh</a>.</p>
    <p>Aprovechamos para darte las gracias una vez más por tu participación en el Generation kWh. Este tipo de soporte es uno de los que nos ayuda a caminar hacia la transformación energética.</p>
    <p></p>
    <br/>
    <br/>
    <p>Saludos,</p>
    <p>Som Energia.</p>
%endif
${plantilla_footer}