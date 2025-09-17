<%
    import time
    from mako.template import Template

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            lang=object_.partner_id.lang,
            # The clar/fosc is reversed because here refers to the background color
            light_logo='https://www.somenergia.coop/logo/logo_header_socies_fosc.png',
            dark_logo='https://www.somenergia.coop/logo/logo_header_socies_clar.png',
            logo_link='https://www.somenergia.coop',
            logo_css_style='width: 570px;',
            format_exceptions=True,
        )

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    template_social_links_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_social_links')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_social_links = render(t_obj.read(object._cr, object._uid, [template_social_links_id], ['def_body_text'])[0]['def_body_text'], object)

    partner_obj = object.pool.get('res.partner')
    is_company = partner_obj.vat_es_empresa(object._cr, object._uid, object.partner_id.vat)
    nom_titular = partner_obj.separa_cognoms(
        object._cr, object._uid, object.partner_id.name
    )['nom'] if not is_company else ""
    nom_titular_amb_coma = ', ' + nom_titular

    polissa_obj = object.pool.get('giscedata.polissa')
    has_polisses = bool(polissa_obj.search_count(
        object._cr, object._uid, [('titular', '=', object.partner_id.id), ('state', '=', 'activa')]
    ))

    ingres = time.strftime('%d/%m/%y')
    def socifilter(text):
        return str(int(''.join([a for a in text if a.isdigit()])))
%>

${plantilla_header}

% if object.partner_id.lang == "ca_ES":

<p>Hola${nom_titular_amb_coma}!!</p>
<p>T’acabes d’associar a Som Energia! Et donem la <strong>benvinguda a la cooperativa que vol transformar el model energètic!</strong></p>
<p>Aquestes són les teves dades:</p>
<table border="0" width="430" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center"><strong>El teu núm. de soci/a és: ${object.partner_id.ref | socifilter}</strong></p>
<p align="center">Nom: ${object.name}</p>
<p align="center">Data d'entrada: ${ingres}</p>
<p align="center">Aportació obligatòria al capital social: 100 euros.</p>
</fieldset></td>
</tr>
</tbody>
</table>
<br>
% if has_polisses:
<p>Com que ja tenies un contracte de llum amb la cooperativa, el passarem automàticament al teu número de soci/a.</p>
% else:
<p>Si també vols contractar la llum amb Som Energia (no és el mateix que associar-se), has de clicar <a target="_blank" href="https://www.somenergia.coop/ca/contracta-la-llum-domestic?mtm_cid=20250822&mtm_campaign=benv-socies&mtm_medium=M&mtm_content=ES&mtm_source=email">aquí</a>:</p>
<p class='align-center'><a class='button' target='_blank' href='https://www.somenergia.coop/ca/contracta-la-llum-domestic?mtm_cid=20250822&mtm_campaign=benv-socies&mtm_medium=M&mtm_content=ES&mtm_source=email'>Vull contractar la llum</a></p>
% endif
<br>
<p>Segurament fa uns dies que estàs informant-te sobre Som Energia i pensant si t’hi associes o no. Possiblement, després d’haver fet el procés, tens el cap una mica saturat, i és que el món del mercat elèctric és complex. Un dels nostres objectius, ara mateix, és posar-te les coses fàcils i no atabalar-te més. <strong>No volem complicar-te la vida, sinó facilitar-te-la.</strong></p>
<p>Per això, esperarem uns dies abans d’explicar-te una mica més sobre la cooperativa i les opcions que se t’obren ara que t’has associat. I aleshores, t’ho explicarem de forma <strong>senzilla</strong> i <strong>clara</strong>.</p>
<p>Mentrestant, si et ve de gust, ens podem trobar a les xarxes socials:</p>
${plantilla_social_links}
<br>
<p><strong>Si tens qualsevol dubte</strong>, ens pots trucar al 872.202.550 (t’atendrem de dilluns a divendres de 9 a 14 h) o enviar-nos un correu a info@somenergia.coop.</p>
% if not is_company:
<p><strong>${nom_titular}, ens fa molta il·lusió tenir-te entre nosaltres!</strong></p>
% endif
<p dir="ltr">&nbsp;</p>
<p>Fins aviat,</p>

% else:

<p>¡Hola${nom_titular_amb_coma}!</p>
<p>¡Te acabas de asociar a Som Energia! Te damos la <strong>bienvenida a la cooperativa que quiere transformar el modelo energético.</strong></p>
<p>Estos son tus datos:</p>
<table border="0" width="430" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center"><strong>Tu nº. de socio/a es: ${object.partner_id.ref | socifilter}</strong></p>
<p align="center">Nombre: ${object.name}</p>
<p align="center">Fecha de entrada: ${ingres}</p>
<p align="center">Aportación obligatoria al capital social: 100 euros.</p>
</fieldset></td>
</tr>
</tbody>
</table>
<br>
% if has_polisses:
<p>Puesto que ya tenías un contrato de luz con la cooperativa, lo pasaremos automáticamente a tu número de socio/a.</p>
% else:
<p>Si también quieres contratar la luz con Som Energia (no es lo mismo que asociarse), debes clicar <a target="_blank" href="https://www.somenergia.coop/es/contrata-la-luz-domestico/?mtm_cid=20250822&mtm_campaign=benv-socies&mtm_medium=M&mtm_content=ES&mtm_source=email">aquí</a>:</p>
<p class='align-center'><a class='button' target='_blank' href='https://www.somenergia.coop/es/contrata-la-luz-domestico/?mtm_cid=20250822&mtm_campaign=benv-socies&mtm_medium=M&mtm_content=ES&mtm_source=email'>Quiero contratar la luz</a></p>
% endif
<br>
<p>Seguramente hace unos días que estás informándote sobre Som Energia y pensando si te asocias o no. Posiblemente, después de haber hecho el proceso, tienes la cabeza algo saturada, y es que el mundo del mercado eléctrico es complejo. Uno de nuestros objetivos, ahora mismo, es ponerte las cosas fáciles y no agobiarte más. <strong>No queremos complicarte la vida, sino facilitártela.</strong></p>
<p>Por eso, esperaremos unos días antes de contarte un poco más sobre la cooperativa y las opciones que se te abren ahora que te has asociado. Y entonces, te lo explicaremos de forma <strong>sencilla</strong> y <strong>clara</strong>.</p>
<p>Mientras, si te apetece, nos podemos encontrar en las redes sociales:</p>
${plantilla_social_links}
<br>
<p><strong>Si tienes cualquier duda</strong>, nos puedes llamar al 872 202 550 (te atenderemos de lunes a viernes de 9 a 14 h) o enviarnos un correo a info@somenergia.coop.</p>
% if not is_company:
<p><strong>${nom_titular}, ¡nos hace mucha ilusión tenerte con nosotros!</strong></p>
% endif
<p dir="ltr">&nbsp;</p>
<p>Hasta pronto,</p>

% endif
<p><a href="https://www.somenergia.coop" target="_blank"><picture>
    <source srcset="https://www.somenergia.coop/logo/logo_fosc_100px.png" media="(prefers-color-scheme: light)"/>
    <source srcset="https://www.somenergia.coop/logo/logo_clar_100px.png" media="(prefers-color-scheme: dark)"/>
    <img src="https://www.somenergia.coop/logo/logo_fosc_100px.png" alt="Som Energia" style="height: 60px;"/>
</picture></a></p>

${plantilla_footer}
