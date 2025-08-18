<%
    from datetime import datetime
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

    for step in object.step_ids:
      obj = step.pas_id
      model = obj._table_name
      if model.startswith('giscedata.switching.t1.06'):
        pas5 = obj
        break

    date = datetime.strptime(pas5.data_activacio, '%Y-%m-%d')
    date = date.strftime('%d/%m/%Y')

    p_obj = object.pool.get('res.partner')
    nom_titular = ' ' + p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom'] if not p_obj.vat_es_empresa(object._cr, object._uid, object.cups_polissa_id.titular.vat) else ""
%>

${plantilla_header}

% if object.cups_polissa_id.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

${plantilla_footer}

## Todo: move this to a common template to permit reuse
<%def name="social_icons(lang)">
<%
  telegram_url = 'https://t.me/somenergia_es'
  if lang == 'ca_ES':
    telegram_url = 'https://t.me/somenergia'
%>
<table role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td align="center" style="padding: 10px 0;">
      <a href="https://mastodon.economiasocial.org/@SomEnergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/assets/social/primary/mastodon.svg" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/assets/social/mastodon.svg" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/assets/social/primary/mastodon.svg" alt="Mastodon" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.instagram.com/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/assets/social/primary/instagram.svg" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/assets/social/instagram.svg" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/assets/social/primary/instagram.svg" alt="Instagram" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.facebook.com/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/assets/social/primary/facebook.svg" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/assets/social/facebook.svg" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/assets/social/primary/facebook.svg" alt="Facebook" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://x.com/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/assets/social/primary/x.svg" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/assets/social/x.svg" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/assets/social/primary/x.svg" alt="X" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="${telegram_url}" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/assets/social/primary/telegram.svg" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/assets/social/telegram.svg" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/assets/social/primary/telegram.svg" alt="Telegram" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.youtube.com/user/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/assets/social/primary/youtube.svg" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/assets/social/youtube.svg" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/assets/social/primary/youtube.svg" alt="Youtube" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.linkedin.com/company/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/assets/social/primary/linkedin.svg" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/assets/social/linkedin.svg" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/assets/social/primary/linkedin.svg" alt="Linkedin" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
    </td>
  </tr>
</table>
</%def>


<%def name="correu_cat()">
    <p>Hola${nom_titular},</p>
    <p>Ens sap greu informar-te que el teu contracte ${object.cups_polissa_id.name}, amb direcció de subministrament ${object.cups_id.direccio}, número de CUPS ${object.cups_id.name} i titular ${object.cups_polissa_id.titular.name}, <strong>ja no està amb Som Energia</strong>. La data del canvi de companyia és el ${date}, i el contracte ha passat a ser gestionat per l’empresa comercialitzadora de referència.</p>
    <p>Esperem que, durant aquest temps, hagis estat a gust i et quedin bons records de la primera cooperativa d’energia verda de l’estat.</p>
    <p>Per part nostra,${nom_titular}, et trobarem a faltar, i <strong>t’agraïm</strong> aquest temps de confiança i camí conjunt.</p>
    <p>Des de Som Energia seguirem treballant per a un futur més net, sostenible, just i en mans de les persones.</p>
    <p>Com sempre que marxa algú, ens preguntem: <strong>què ha passat?</strong> Podríem haver fet quelcom perquè aquesta persona no hagués marxat? Com podríem millorar?</p>
    <p>És per això que et volem demanar un últim favor: que ens ho expliquis responent <a target='_blank' href='https://docs.google.com/forms/d/e/1FAIpQLSf_VzfB9sJUx9co6RalNt00AlnyHbsZw0-fS2-vP1_saPtxtQ/viewform'>aquesta breu enquesta</a>, de 3 minutets.</p>
    <p class='align-center'><a class='button' target='_blank' href='https://docs.google.com/forms/d/e/1FAIpQLSf_VzfB9sJUx9co6RalNt00AlnyHbsZw0-fS2-vP1_saPtxtQ/viewform'>Respon l’enquesta</a></p>
    <p>T’agraïm per avançat aquest retorn, ens serà molt útil per seguir millorant!</p>
    <br>
    <p>Ah! Que marxis no vol dir que ens perdis la pista! <strong>Podem seguir en contacte</strong> a través de les xarxes socials, aquí et deixem els enllaços:</p>
    ${social_icons(object.cups_polissa_id.titular.lang)}
    <p>Si mai canvies d’opinió, estarem encantades de rebre’t altre cop!</p>
    <br>
    <br>
    Moltes gràcies,<br>
    <br>
    Som Energia<br>
    <a target='_blank' href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
    <a target='_blank' href="tel:+34872202550">872.202.550</a><br>
</%def>


<%def name="correu_es()">
    <p>Hola${nom_titular},</p>
    <p>Nos sabe mal informarte que tu contrato ${object.cups_polissa_id.name}, con dirección de suministro ${object.cups_id.direccio}, número de CUPS ${object.cups_id.name} y titular ${object.cups_polissa_id.titular.name}, <strong>ya no está con Som Energia</strong>. La fecha del cambio de compañía es el ${date}, y el contrato ha pasado a ser gestionado por la empresa comercializadora de referencia.
</p>
    <p>Esperamos que, durante este tiempo, hayas estado a gusto y te queden buenos recuerdos de la primera cooperativa estatal de energía verde.</p>
    <p>Por nuestra parte,${nom_titular}, te echaremos de menos, y <strong>te agradecemos</strong> ese tiempo de confianza y camino conjunto.</p>
    <p>Desde Som Energia seguiremos trabajando para un futuro más limpio, sostenible, justo y en manos de las personas.</p>
    <p>Como siempre que se va alguien, nos preguntamos: <strong>¿qué ha pasado?</strong> ¿Podríamos haber hecho algo para que esa persona no se hubiera ido? ¿Cómo podríamos mejorar?</p>
    <p>Por eso te queremos pedir un último favor: que nos lo expliques respondiendo <a target='_blank' href='https://docs.google.com/forms/d/e/1FAIpQLScgmyH-sRBsTCYs2kCOhFsZFmTiKGevxuxvyvy_Z35atLyBjA/viewform'>esta breve encuesta</a>, de 3 minutitos.</p>
    <p class='align-center'><a class='button' target='_blank' href='https://docs.google.com/forms/d/e/1FAIpQLScgmyH-sRBsTCYs2kCOhFsZFmTiKGevxuxvyvy_Z35atLyBjA/viewform'>Responde la encuesta</a></p>
    <p>Te agradecemos por adelantado estas reflexiones, nos serán muy útiles para seguir mejorando.</p>
    <br>
    <p>¡Ah! ¡Que te vayas no quiere decir que nos pierdas la pista! <strong>Podemos seguir en contacto</strong> a través de las redes sociales, aquí te dejamos los enlaces:</p>
    ${social_icons(object.cups_polissa_id.titular.lang)}
    <p>Si alguna vez cambias de opinión, ¡estaremos encantadas de recibirte de nuevo!</p>
    <br>
    <br>
    Muchas gracias,<br>
    <br>
    Som Energia<br>
    <a target='_blank' href="https://www.somenergia.coop/es">www.somenergia.coop</a><br>
    <a target='_blank' href="tel:+34872202550">872.202.550</a><br>
</%def>
