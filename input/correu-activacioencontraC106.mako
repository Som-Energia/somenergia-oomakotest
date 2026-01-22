<%
for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    # Deprecated method
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if model.startswith('giscedata.switching.c1.06') or model.startswith('giscedata.switching.c2.06'):
    pas6 = obj

from datetime import datetime, timedelta
date = datetime.strptime(pas6.data_activacio, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular = ' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

from mako.template import Template

def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        lang=object.cups_polissa_id.titular.lang,
        format_exceptions=True
)

t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
template_social_links_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_social_links')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_social_links = render(t_obj.read(object._cr, object._uid, [template_social_links_id], ['def_body_text'])[0]['def_body_text'], object)

ct_ss_soci_id = md_obj.get_object_reference(
  object._cr, object._uid, 'som_polissa_soci', 'res_partner_soci_ct'
)[1]
is_ct_ss = object.cups_polissa_id.soci.id == ct_ss_soci_id

link_survey_ca = (
  'https://docs.google.com/forms/d/e/1FAIpQLSeL-mHps3LER8NyNoyOMBwlYbrx1U2zf9nr7i10uk2gtpkc4g/viewform' if is_ct_ss else 'https://docs.google.com/forms/d/e/1FAIpQLSeIzBIxrPbN5mykRtkPDhg8ZbQ3CW_Z-LiHIdu4ojQugW80Ug/viewform'
)
link_survey_es = (
  'https://docs.google.com/forms/d/e/1FAIpQLSf_GUQE-W3XTYubTsLvKQa7TGn1zj2BFznLMKNNWaurUik-ng/viewform' if is_ct_ss else 'https://docs.google.com/forms/d/e/1FAIpQLSfyzfNf5GIQtrUhWuOX_h0EsA_3JQYLgLI5HT3yE-8ahvnAqg/viewform'
)

%>

${plantilla_header}

<p>Hola${nom_titular},</p>
% if object.cups_polissa_id.titular.lang != "es_ES":
<p>Ens sap greu informar-te que el teu contracte ${object.cups_polissa_id.name}, amb direcció de subministrament ${object.cups_id.direccio}, número de CUPS ${object.cups_id.name} i titular ${object.cups_polissa_id.titular.name}, <strong>ja no està amb Som Energia</strong>. La data del canvi de companyia és el ${date}.</p>
<p>Esperem que, durant aquest temps, hagis estat a gust i et quedin bons records de la primera cooperativa d’energia verda de l’estat.</p>
% if nom_titular:
<p>Per part nostra,${nom_titular}, et trobarem a faltar, i <strong>t’agraïm</strong> aquest temps de confiança i camí conjunt.</p>
% else:
<p>Per part nostra, et trobarem a faltar, i <strong>t’agraïm</strong> aquest temps de confiança i camí conjunt.</p>
% endif
<p>Des de Som Energia seguirem treballant per a un futur més net, sostenible, just i en mans de les persones.</p>
<p>Com sempre que marxa algú, ens preguntem: <strong>què ha passat?</strong> Podríem haver fet quelcom perquè aquesta persona no hagués marxat? Com podríem millorar?</p>
<p>És per això que et volem demanar un últim favor: que ens ho expliquis responent <a target='_blank' href="${link_survey_ca}">aquesta breu enquesta</a>, de 3 minutets.</p>
<p class='align-center'><a class='button' target='_blank' href='${link_survey_ca}'>Respon l’enquesta</a></p>
<p>T’agraïm per avançat aquest retorn, ens serà molt útil per seguir millorant!</p>
<br>
<p><strong>Seguim en contacte?</strong></p>
<p>Ah! Que marxis no vol dir que ens perdis la pista! <strong>Podem seguir en contacte</strong> a través de les xarxes socials, aquí et deixem els enllaços:</p>
${plantilla_social_links}
<p>Si mai canvies d’opinió, estarem encantades de rebre’t altre cop!</p>
<br>
<p><strong>No has estat tu?</strong></p>
<p>Si no has sol·licitat el canvi de companyia, i aquest s’ha fet en contra de la teva voluntat, ens pots respondre aquest mateix correu i iniciarem els tràmits per tal que tornis a tenir el contracte amb Som Energia.</p>
<br>
<br>
Moltes gràcies,<br>
<br>
Som Energia<br>
<a target='_blank' href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
<a target='_blank' href="tel:+34872202550">872.202.550</a><br>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
<p>Nos sabe mal informarte de que tu contrato ${object.cups_polissa_id.name}, con dirección de suministro ${object.cups_id.direccio}, número de CUPS ${object.cups_id.name} y titular ${object.cups_polissa_id.titular.name}, <strong>ya no está con Som Energia</strong>. La fecha del cambio de compañía es el ${date}.</p>
<p>Esperamos que, durante este tiempo, hayas estado a gusto y te queden buenos recuerdos de la primera cooperativa estatal de energía verde.</p>
% if nom_titular:
<p>Por nuestra parte,${nom_titular}, te echaremos de menos, y <strong>te agradecemos</strong> ese tiempo de confianza y camino conjunto.</p>
% else:
<p>Por nuestra parte, te echaremos de menos, y <strong>te agradecemos</strong> ese tiempo de confianza y camino conjunto.</p>
% endif
<p>Desde Som Energia seguiremos trabajando para un futuro más limpio, sostenible, justo y en manos de las personas.</p>
<p>Como siempre que se va alguien, nos preguntamos: <strong>¿qué ha pasado?</strong> ¿Podríamos haber hecho algo para que esa persona no se hubiera ido? ¿Cómo podríamos mejorar?</p>
<p>Por eso te queremos pedir un último favor: que nos lo expliques respondiendo <a target='_blank' href="${link_survey_es}">esta breve encuesta</a>, de 3 minutitos.</p>
<p class='align-center'><a class='button' target='_blank' href='${link_survey_es}'>Responde la encuesta</a></p>
<p>Te agradecemos por adelantado este retorno, ¡nos será muy útil para seguir mejorando!</p>
<br>
<p><strong>¿Seguimos en contacto?</strong></p>
<p>¡Ah! Que te vayas no quiere decir que nos pierdas la pista. <strong>Podemos seguir en contacto</strong> a través de las redes sociales, aquí te dejamos los enlaces:</p>
${plantilla_social_links}
<p>Si alguna vez cambias de opinión, ¡estaremos encantadas de recibirte de nuevo!</p>
<br>
<p><strong>¿No has sido tú?</strong></p>
<p>Si no has solicitado el cambio de compañía, y éste se ha hecho en contra de tu voluntad, puedes respondernos este mismo correo e iniciaremos los trámites para que vuelvas a tener el contrato con Som Energia.</p>
<br>
<br>
Muchas gracias,<br>
<br>
Som Energia<br>
<a target='_blank' href="https://www.somenergia.coop/es">www.somenergia.coop</a><br>
<a target='_blank' href="tel:+34872202550">872.202.550</a><br>
% endif

${plantilla_footer}
