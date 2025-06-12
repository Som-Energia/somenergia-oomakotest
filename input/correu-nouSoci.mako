<%
    import time
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


    ingres = time.strftime('%d/%m/%y')
    def socifilter(text):
        return str(int(''.join([a for a in text if a.isdigit()])))
%>

${plantilla_header}

% if object.partner_id.lang == "ca_ES":
<p>Benvingut/da a Som Energia!<br><br></p>
<p dir="ltr">Ens alegra que formis part de la cooperativa que construeix un model energ&egrave;tic renovable en mans de la ciutadania, des de la participaci&oacute; i la transpar&egrave;ncia. Esperem que juntes podrem assolir el nostre objectiu de transformar el model energ&egrave;tic, apostant per les energies renovables i l&rsquo;efici&egrave;ncia energ&egrave;tica.</p>
<table border="0" width="373" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center">N&uacute;mero de soci/a: <strong>${object.partner_id.ref | socifilter}</strong></p>
<p align="center">Nom: ${object.name}</p>
<p align="center">Data d'ingr&eacute;s: ${ingres}</p>
<p align="center">Aportaci&oacute; obligat&ograve;ria al capital social: 100&euro;</p>
</fieldset></td>
</tr>
</tbody>
</table>
<p><br><strong>Ara que ja ets soci/a, pots <a href="https://www.somenergia.coop/ca/contracta-la-llum/contractarlallum" target="_blank" rel="noopener">contractar la llum</a></strong><br><br></p>
<p dir="ltr"><strong>Quins avantatges tens com a membre de Som Energia?&nbsp;</strong></p>
<ul>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation"><a href="https://www.somenergia.coop/ca/produeix-energia-renovable/" target="_blank" rel="noopener">Participar</a> en projectes renovables amb aportacions a partir de 100 euros.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Accedir a <a href="https://www.somenergia.coop/ca/produeix-energia-renovable/autoproduccio/" target="_blank" rel="noopener">compres col&middot;lectives</a> d&rsquo;instal&middot;lacions fotovoltaiques dom&egrave;stiques.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Acc&eacute;s il&middot;limitat a l&rsquo;<a href="https://aulapopular.somenergia.coop/">Aula Popular</a>, on trobar&agrave;s formacions sobre energia i cooperativisme.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Pots participar en els <a href="https://www.somenergia.coop/ca/participa/escola-de-som-energia/" target="_blank" rel="noopener">Espais de trobada</a> amb altres persones s&ograve;cies</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Tens acc&eacute;s a&nbsp;<a href="https://www.somenergia.coop/ca/altres-activitats/" target="_blank" rel="noopener">Serveis d&rsquo;entitats</a> amb qui tenim signats acords de col&middot;laboraci&oacute;</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation"><a href="http://www.somenergia.coop/ca/contracta-la-llum/" target="_blank" rel="noopener">Contractar el subministrament d&rsquo;electricitat</a> i convidar fins a 5 contractes d&rsquo;altres persones.</p>
</li>
</ul>
<p dir="ltr">&nbsp;</p>
<p dir="ltr">A m&eacute;s, podr&agrave;s gestionar i consultar les teves dades, contractes i serveis al teu espai de <a href="https://oficinavirtual.somenergia.coop/ca/" target="_blank" rel="noopener">l'Oficina Virtual</a></p>
<p dir="ltr">Si tens dubtes, al <a href="http://links.somenergia.coop/ls/click?upn=0TIWnd5-2FSibmBIPHvRB-2BipLZJoBdtE76a9j18KyPRYJqP9Z5sZLUJbPDBFba0HUYKKFx_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQDMlnr8Gf-2FWzasSAH21TcRBvLaT7GiyKHTqoZDk6GVPZUViNMc-2FSxWe0F3b4bQN9b1pLT4dKFaozK5RmYwZBFjNGc5Q5hM2IuYfOywT4wUZF1efIxS4-2BL7F7f2bJKrrlJ5kQuqaEXoPFo4SlCSp-2F4zh" target="_blank" rel="noopener">Centre d'Ajuda</a> trobar&agrave;s resolts les consultes m&eacute;s habituals.&nbsp;</p>
<p dir="ltr">&nbsp;</p>
<p dir="ltr"><strong>Vols ajudar-nos a difondre el projecte?&nbsp;</strong></p>
<p dir="ltr">Pots afegir-nos com a amic a <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ01ny-2BuMev4LnSMYwaJUg8B3ZswJ7ZLOkyniDNrY0gFTsHXLh_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQCYrg4GdRFA4-2BG4rPJ2ws8PFfypsvo3wgDLhDb0zVG3zC37D8wfLDBBy96-2FDHEZUwM-2B1ePWdG3oE-2BfyOUnf-2FRNou89EZZwpeP2jo9jXxznSrCdbvTdc1WE-2BZ42b9D2-2BwCOVbzBYO1JlXwnbkpWpBxd-2F" target="_blank" rel="noopener">Facebook</a>, seguir-nos a <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ0zhnivjbQG4gVE1Fjrkp0nue0Xi09k3wEy8NA-2Fjk37LG6Cet_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQDumtX9i7lgoywek2gVJA70fPMGCbDfCi8QEr5pN6X5jFjSpH3MgOri9-2FTgTLavCypO-2FnztQncsdAYTkgqCOXO-2BUtt-2F8Uda11ZjZPvVbhCYA31tPD14vUKw0zFnUSaJZ-2BKuxcmMAxTgDjJVEWtyw83R" target="_blank" rel="noopener">Twitter</a>, <a href="https://www.instagram.com/somenergia/" target="_blank" rel="noopener">Instagram</a> o <a href="https://t.me/somenergia" target="_blank" rel="noopener">Telegram</a>.</p>
<p dir="ltr">Si vols participar de la cooperativa d'una forma m&eacute;s activa, pots unir-te al <a href="https://www.somenergia.coop/ca/participa/#grupslocals" target="_blank" rel="noopener">Grup local</a> de la teva zona.&nbsp;</p>
<p dir="ltr">Finalment, pots <a href="https://blog.somenergia.coop/" target="_blank" rel="noopener">subscriure&rsquo;t al nostre blog</a> per estar al dia de les nostres not&iacute;cies.&nbsp;</p>
<p dir="ltr">&nbsp;</p>
<p>Moltes gr&agrave;cies pel teu suport!<br><br>Atentament,</p>
<p>L'equip de Som Energia<br><a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>info@somenergia.coop<br><a href="http://ca.support.somenergia.coop/article/470-com-puc-contactar-amb-la-cooperativa-mail-telefon-etc">Contactar amb Som Energia</a></p>
% else:
<p>&iexcl;Bienvenido/a a Som Energia!<br><br></p>
<p dir="ltr">Nos alegra que formes parte de la cooperativa que construye un modelo energ&eacute;tico renovable en manos de la ciudadan&iacute;a, desde la participaci&oacute;n y la transparencia. Esperamos poder conseguir juntas nuestro objetivo de transformar el modelo energ&eacute;tico, apostando por las energ&iacute;as renovables y la eficiencia energ&eacute;tica.</p>
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td><fieldset>
<p align="left">N&uacute;mero de socio/a: <strong>${object.partner_id.ref | socifilter}</strong><br>Nombre: ${object.name}<br>Fecha de ingreso: ${ingres}<br>Aportaci&oacute;n obligatoria al capital social: 100&euro;</p>
</fieldset></td>
</tr>
</tbody>
</table>
<p><br><strong>Ahora que ya eres socio/a, puedes <a href="https://www.somenergia.coop/es/contrata-la-luz/" target="_blank" rel="noopener">contratar la luz</a>.</strong><br><br></p>
<p dir="ltr"><strong>&iquest;Qu&eacute; ventajas tienes como miembro de Som Energia?</strong></p>
<ul>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Puedes <a href="https://www.somenergia.coop/es/produce-energia-renovable/" target="_blank" rel="noopener">participar</a> en proyectos renovables con aportaciones a partir de 100&euro;.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Acceder a <a href="https://www.somenergia.coop/es/produce-energia-renovable/autoproduccion/" target="_blank" rel="noopener">compras colectivas</a> de instalaciones fotovoltaicas dom&eacute;sticas.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Acceso ilimitado al <a href="https://aulapopular.somenergia.coop/es/inicio/" target="_blank" rel="noopener">Aula Popular</a>, donde encontrar&aacute;s formaciones sobre energ&iacute;a y cooperativismo.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Puedes <a href="https://www.somenergia.coop/es/participa/" target="_blank" rel="noopener">participar</a> en los Espacios de encuentro con otras personas socias</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Tienes acceso a los <a href="https://www.somenergia.coop/es/otras-actividades/" target="_blank" rel="noopener">servicios de entidades</a> con los que tenemos firmados acuerdos de colaboraci&oacute;n</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Puedes <a href="https://www.somenergia.coop/es/contrata-la-luz/" target="_blank" rel="noopener">contratar el suministro de electricidad</a> e invitar hasta a 5 contratos de otras personas.</p>
</li>
</ul>
<p><strong>&nbsp;</strong></p>
<p dir="ltr">Adem&aacute;s, podr&aacute;s gestionar y consultar tus datos, contratos y servicios en <a href="https://oficinavirtual.somenergia.coop/es/login/" target="_blank" rel="noopener">tu espacio de la Oficina Virtual.</a></p>
<p dir="ltr">Si tienes dudas, en el <a href="https://es.support.somenergia.coop/" target="_blank" rel="noopener">Centro de Ayuda</a> encontrar&aacute;s resueltas las consultas m&aacute;s habituales.</p>
<p><strong>&nbsp;</strong></p>
<p dir="ltr"><strong>&iquest;Quieres ayudarnos a difundir el proyecto?</strong></p>
<p dir="ltr">Puedes a&ntilde;adirnos como amigo en <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ01ny-2BuMev4LnSMYwaJUg8B3ZswJ7ZLOkyniDNrY0gFTsHXLh_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQCYrg4GdRFA4-2BG4rPJ2ws8PFfypsvo3wgDLhDb0zVG3zC37D8wfLDBBy96-2FDHEZUwM-2B1ePWdG3oE-2BfyOUnf-2FRNou89EZZwpeP2jo9jXxznSrCdbvTdc1WE-2BZ42b9D2-2BwCOVbzBYO1JlXwnbkpWpBxd-2F" target="_blank" rel="noopener">Facebook</a>, seguirnos en <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ0zhnivjbQG4gVE1Fjrkp0nue0Xi09k3wEy8NA-2Fjk37LG6Cet_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQDumtX9i7lgoywek2gVJA70fPMGCbDfCi8QEr5pN6X5jFjSpH3MgOri9-2FTgTLavCypO-2FnztQncsdAYTkgqCOXO-2BUtt-2F8Uda11ZjZPvVbhCYA31tPD14vUKw0zFnUSaJZ-2BKuxcmMAxTgDjJVEWtyw83R" target="_blank" rel="noopener">Twitter</a>, <a href="https://www.instagram.com/somenergia/" target="_blank" rel="noopener">Instagram</a> o <a href="https://t.me/somenergia_es" target="_blank" rel="noopener">Telegram</a>.</p>
<p dir="ltr">Si quieres participar de la cooperativa de forma m&aacute;s activa, puedes unirte al <a href="https://www.somenergia.coop/es/participa/#gruposlocales" target="_blank" rel="noopener">Grupo local de tu zona</a>.</p>
<p dir="ltr">Por &uacute;ltimo, puedes <a href="https://blog.somenergia.coop/" target="_blank" rel="noopener">suscribirte a nuestro blog</a> para estar al d&iacute;a de nuestras noticias.</p>
<p>&nbsp;</p>
<p>&iexcl;Muchas gracias por tu apoyo!<br><br>Atentamente,</p>
<p>El equipo de Som Energia<br><a href="https://www.somenergia.coop" target="_blank" rel="noopener">www.somenergia.coop</a><br><a href="http://es.support.somenergia.coop/article/471-como-puedo-contactar-con-la-cooperativa-mail-telefono-etc" target="_blank" rel="noopener">Contactar con Som Energia</a></p>
% endif

${plantilla_footer}
