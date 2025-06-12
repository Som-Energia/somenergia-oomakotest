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
        format_exceptions=True
)

t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

%>

${plantilla_header}

% if object.cups_polissa_id.titular.lang != "es_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
<br><br>
Hola${nom_titular},
<br><br>
<p>T&rsquo;escrivim per informar-te que ens han comunicat la baixa del teu contracte amb Som Energia. La data de canvi de companyia &eacute;s el <strong>${date}</strong></p>
% if object.cups_polissa_id.soci:
<p dir="ltr">Si no eres conscient que s'ha realitzat aquesta sol&middot;licitud i s'ha fet contra la teva voluntat, respon a aquest mateix correu i iniciarem els tr&agrave;mits perqu&egrave; tornis a tenir el contracte amb la cooperativa i, si &eacute;s el cas, per a realitzar la reclamaci&oacute; pertinent si el canvi de comercialitzadora es va fer de manera fraudulenta sense el teu consentiment.</p>
<p>Si ho has fet de forma conscient, i vols passar el contracte de Som Energia a una altra comercialitzadora, no cal que facis cas d'aquest missatge perqu&egrave; sempre pots triar lliurement la teva comercialitzadora.</p>
<p>Per &uacute;ltim, tamb&eacute; ens agradaria saber els motius que t&rsquo;han fet decidir a canviar. Ens ser&agrave; de gran ajuda con&egrave;ixer-los. Nom&eacute;s cal que dediquis un parell de minuts a respondre aquest <a href="https://docs.google.com/forms/d/e/1FAIpQLSeIzBIxrPbN5mykRtkPDhg8ZbQ3CW_Z-LiHIdu4ojQugW80Ug/viewform">q&uuml;estionari</a>.</p>
% endif
<p>Gr&agrave;cies.<br><br>Salutacions,<br><br>Equip de Som Energia<br>comercialitzacio@somenergia.coop<br><a href="www.somenergia.coop">www.somenergia.coop</a></p>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
<br><br>
Hola${nom_titular},
<br><br>
<p>Te escribimos para informarte que nos han comunicado la baja de tu contrato con Som Energia. La fecha de cambio de compa&ntilde;ia es el <strong>${date}</strong></p>
% if object.cups_polissa_id.soci:
<p dir="ltr">Si no eres consciente de que se realiz&oacute; esta solicitud y se hizo contra tu voluntad, responde a este mismo correo e iniciaremos los tr&aacute;mites para que vuelvas a tener el contrato con la cooperativa y, en su caso, para realizar la reclamaci&oacute;n pertinente si el cambio de comercializadora se hizo de forma fraudulenta sin tu consentimiento.</p>
<p>Si lo has hecho de manera consciente, y quieres pasar el contrato de Som Energia a otra comercializadora, no es necesario que atiendas a este mensaje ya que siempre puedes escoger libremente tu comercializadora.</p>
<p>Por &uacute;ltimo, tambi&eacute;n nos gustar&iacute;a saber los motivos que te han hecho decidir por el cambio. Nos puede ser de gran ayuda conocerlos. Solo tendr&iacute;as que dedicar un par de minutos responder este <a href="https://docs.google.com/forms/d/e/1FAIpQLSfyzfNf5GIQtrUhWuOX_h0EsA_3JQYLgLI5HT3yE-8ahvnAqg/viewform">cuestionario</a>.</p>
% endif
<p>Gracias.<br><br>Un saludo,<br><br>Equipo de Som Energia<br>comercializacion@somenergia.coop<br><a href="http://www.somenergia.coop/es">www.somenergia.coop</a></p>
% endif

${plantilla_footer}
