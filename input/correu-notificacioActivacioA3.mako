<%
import sys
for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    # Deprecated method
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if model == 'giscedata.switching.a3.05':
    pas5 = obj
    break
try:
  from datetime import datetime, timedelta
  date = datetime.strptime(pas5.data_activacio, '%Y-%m-%d')
  data_activacio = date.strftime('%d/%m/%Y')
except:
  data_activacio = ''

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

TarifaATR=dict(object.pool.get(model).fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas5.tarifaATR]

lineesDePotencia_ca = '\n'.join((
  '\t- <strong> %s: </strong>%s kW'%(p.name, p.potencia / 1000.0)
  for p in pas5.header_id.pot_ids
  if p.potencia != 0
  ))
lineesDePotencia_es = lineesDePotencia_ca
if TarifaATR == "2.0TD":
    lineesDePotencia_ca = lineesDePotencia_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
    lineesDePotencia_es = lineesDePotencia_es.replace("P1:", "Punta:").replace("P2:", "Valle:")

subministrament_essencial = False
if object.cups_polissa_id.titular_nif[2] in ['P','Q','S'] or object.cups_polissa_id.cnae.name in ['3600', '4910', '4931', '4939', '5010', '5110', '5221', '5222', '5223', '5229', '8621', '8622', '8690', '8610', '9603']:
  subministrament_essencial = True

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
tarifaComer = object.cups_polissa_id.modcontractuals_ids[0].llista_preu.nom_comercial or object.cups_polissa_id.modcontractuals_ids[0].llista_preu.name
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
                    % if object.cups_polissa_id.titular.lang != "es_ES":
                    <table width="100%" frame="below">
                    <tbody>
                    <tr>
                    <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></span></td>
                    </tr>
                    <tr>
                    <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${object.cups_id.direccio}</span></td>
                    </tr>
                    <tr>
                    <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.cups_id.name}</span></td>
                    </tr>
                    <tr>
                    <td width="100%" height="2px"><span style="font-size: xx-small;"> Titular: ${object.cups_polissa_id.titular.name} </span></td>
                    </tr>
                    </tbody>
                    </table>
                    <p><br>Hola${nom_titular},<br></p>
                    % if object.cups_polissa_id.mode_facturacio == "index":
                    <p>Ens plau comunicar-te que el procés d'alta de subministrament ha finalitzat, <strong>el contracte està activat amb Som Energia</strong> des del ${data_activacio}. En aquest sentit, t’adjuntem les condicions generals, específiques i particulars resultants després dels tràmits amb la companyia distribuïdora.</p>
                    % else:
                    <p>Ens plau comunicar-te que el procés d'alta de subministrament ha finalitzat, <strong>el contracte està activat amb Som Energia</strong> des del ${data_activacio}. En aquest sentit, t’adjuntem les condicions generals i particulars resultants després dels tràmits amb la companyia distribuïdora.</p>
                    % endif
                    <p>Per a qualsevol consulta o aclariment, aquestes són les teves dades:</p>
                    <ul>
                    <li><strong>Número de contracte amb Som Energia: </strong>${object.cups_polissa_id.name}</li>
                    <li><strong>CUPS: </strong>${object.cups_id.name}</li>
                    <li><strong>Direcció del punt de subministrament: </strong>${object.cups_id.direccio}</li>
                    <li><strong>Titular: </strong>${object.cups_polissa_id.titular.name}</li>
                    <li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
                    <li><strong>Soci/a vinculat/da: </strong>${object.cups_polissa_id.soci.name}</li>
                    <li><strong> Tarifa: </strong>${tarifaComer}</li>
                    <li><strong> Potència: </strong>${lineesDePotencia_ca}</li>
                    % if object.cups_polissa_id.donatiu:
                    <li><strong> Donatiu Voluntari (0,01€/kWh):</strong> Si</li>
                    %endif
                    </ul>
                    <p>Aproximadament en el termini d’un mes, rebràs la primera factura, que inclourà els costos regulats per la tramitació de l’alta (i que cobra la distribuïdora).<br><br>A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> pots consultar les dades del contracte, <a href="https://ca.support.somenergia.coop/article/265-puc-facilitar-jo-la-lectura">facilitar-nos les lectures</a> i veure totes les teves factures. També podràs sol·licitar modificar la potència o la tarifa contractada.<br></p>
                    %if subministrament_essencial:
                    <p>Si aquest contracte de llum correspon a un <a href="https://ca.support.somenergia.coop/article/1226-subministraments-essencials">subministrament essencial</a>, per tal de disposar d’una protecció especial i que no es pugui suspendre el subministrament elèctric, cal que ens ho indiqueu responent aquest mateix correu.<br></p>
                    %endif
                    <p>Si tens algun dubte, trobaràs les preguntes més freqüents al <a href="https://ca.support.somenergia.coop/">Centre de Suport</a>.<br><br><br>Atentament,<br><br>Equip de Som Energia<br>comercialitzacio@somenergia.coop<br><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a></p>
                    % endif
                    % if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
                    <p><br>----------------------------------------------------------------------------------------------------</p>
                    % endif
                    % if object.cups_polissa_id.titular.lang != "ca_ES":
                    <table width="100%" frame="below">
                      <tbody>
                      <tr>
                      <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></span></td>
                      </tr>
                      <tr>
                      <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${object.cups_id.direccio}</span></td>
                      </tr>
                      <tr>
                      <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${object.cups_id.name}</span></td>
                      </tr>
                      <tr>
                      <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${object.cups_polissa_id.titular.name} </span></td>
                      </tr>
                      </tbody>
                      </table>
                    <p><br>Hola${nom_titular},<br></p>
                    % if object.cups_polissa_id.mode_facturacio == "index":
                    <p>Nos complace informarte que el proceso de alta de suministro ha finalizado, <strong>tu contrato con Som Energia está activado </strong> desde el ${data_activacio}. En este sentido, te adjuntamos las condiciones generales, específicas y particulares resultantes después de los trámites con la compañía distribuidora.</p>
                    % else:
                    <p>Nos complace informarte que el proceso de alta de suministro ha finalizado, <strong>tu contrato con Som Energia está activado </strong> desde el ${data_activacio}. En este sentido, te adjuntamos las condiciones generales y particulares resultantes después de los trámites con la compañía distribuidora.</p>
                    % endif
                    <p>Los datos del nuevo contrato son:</p>
                    <ul>
                    <li><strong>Número de contrato con Som Energia: </strong>${object.cups_polissa_id.name}</li>
                    <li><strong>CUPS: </strong>${object.cups_id.name}</li>
                    <li><strong>Dirección del punto de suministro: </strong>${object.cups_id.direccio}</li>
                    <li><strong>Titular del contrato: </strong>${object.cups_polissa_id.titular.name}</li>
                    <li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
                    <li><strong>Socio/a vinculado/a: </strong>${object.cups_polissa_id.soci.name}</li>
                    <li><strong> Tarifa: </strong>${tarifaComer}</li>
                    <li><strong> Potencia: </strong>${lineesDePotencia_es}</li>
                    % if object.cups_polissa_id.donatiu:
                    <li><strong> Donativo Voluntario (0,01€/kWh):</strong> Si</li>
                    %endif
                    </ul>
                    <p>Aproximadamente en el plazo de un mes, recibirás la primera factura, que incluirá los costes regulados de la tramitación del alta (y que cobra la distribuidora).<br><br>En la <a href="https://oficinavirtual.somenergia.coop/es/login/"> Oficina Virtual </a> puedes consultar los datos del contrato, <a href="https://es.support.somenergia.coop/article/535-como-puedo-facilitar-la-lectura"> facilitarnos las lecturas </a> y ver todas tus facturas. También podrás solicitar modificar la potencia o la tarifa contratada.<br></p>
                    %if subministrament_essencial:
                    <p>Si este contrato de luz corresponde a un <a href="https://es.support.somenergia.coop/article/1227-suministros-esenciales">suministro esencial</a>, para disponer de una protección especial y que no se pueda suspender el suministro eléctrico, es necesario que nos lo indiquéis respondiendo este mismo correo.<br></p>
                    %endif
                    <p>Si tienes alguna duda, encontrarás las preguntas más frecuentes en el <a href="https://es.support.somenergia.coop/">Centro de Ayuda</a> .<br><br><br>Atentamente,<br><br>Equipo de Som Energia<br>comercializacion@somenergia.coop<br><a href="https://www.somenergia.coop">www.somenergia.coop</a></p>
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
