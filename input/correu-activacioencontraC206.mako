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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

%>

${plantilla_header}

<table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0" role="presentation">
  <tr>
    <td align="center">
      <table class="email-content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
        <tr>
          <td class="email-masthead">
            <table align="center" width="570" cellpadding="0" cellspacing="0" role="presentation" class="header">
              <tr>
                <th>
                  <img src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png" alt="SOM Energia" style="height: 100px"/>
                </th>
              </tr>
            </table>
          </td>
        </tr>
        <!-- Email Body -->
        <tr>
          <td class="email-body" width="570" cellpadding="0" cellspacing="0">
            <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0" role="presentation">
              <!-- Body content -->
              <tr>
                <td class="content-cell">
                  <div class="f-fallback">
                    <html>
                    % if object.cups_polissa_id.titular.lang != "es_ES":
                    <head><meta charset="utf-8" /><table width="100%" frame="below"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
                    <br><br>
                    Hola${nom_titular},
                    <br><br>
                    T’escrivim per informar-te que ens han comunicat la baixa del teu contracte amb Som Energia. La data de canvi de companyia és el  <strong>${date}</strong>
                    % if object.cups_polissa_id.soci:
                    <br>
                    <br>
                    No cal que facis cas d’aquest missatge si certament vols passar el contracte de Som Energia a una altra comercialitzadora, ja que sempre pots triar lliurement la teva comercialitzadora.
                    <br>
                    <br>
                    Però si no eres conscient que s’ha realitzat aquesta sol·licitud i s’ha fet contra la teva voluntat, respon a aquest mateix correu i iniciarem els tràmits perquè tornis a tenir el contracte amb la cooperativa i, si és el cas, per a realitzar la reclamació pertinent si el canvi de comercialitzadora es va fer de manera fraudulenta sense el teu consentiment.
                    % endif
                    <br>
                    <br>
                    Gràcies.
                    <br>
                    <br>
                    Salutacions,
                    <br>
                    <br>
                    Equip de Som Energia<br>
                    comercialitzacio@somenergia.coop<br>
                    <a href="www.somenergia.coop">www.somenergia.coop</a><br>
                    % endif
                    % if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
                    ----------------------------------------------------------------------------------------------------
                    % endif
                    % if object.cups_polissa_id.titular.lang != "ca_ES":
                    <head><meta charset="utf-8" /><table width="100%" frame="below"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
                    <br><br>
                    Hola${nom_titular},
                    <br><br>
                    Te escribimos para informarte que nos han comunicado la baja de tu contrato con Som Energia. La fecha de cambio de compañia es el <strong>${date}</strong>
                    % if object.cups_polissa_id.soci:
                    <br>
                    <br>
                    No es necesario que atiendas a este mensaje si efectivamente quieres pasar el contrato de Som Energia a otra comercializadora ya que siempre puedes escoger libremente tu comercializadora.
                    <br>
                    <br>
                    Pero si no eres consciente de que se realizó esta solicitud y se hizo contra tu voluntad, responde a este mismo correo e iniciaremos los trámites para que vuelvas a tener el contrato con la cooperativa y, en su caso, para realizar la reclamación pertinente si el cambio de comercializadora se hizo de forma fraudulenta sin tu consentimiento.
                    % endif
                    <br>
                    <br>
                    Gracias.<br>
                    <br>
                    Un saludo,<br>
                    <br>
                    Equipo de Som Energia<br>
                    comercializacion@somenergia.coop<br>
                    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a><br>
                    % endif
                  </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
${plantilla_footer}
