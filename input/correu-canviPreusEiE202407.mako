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

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

    email_o = object.pool.get('report.backend.mailcanvipreus.eie')
    data = email_o.get_data(object._cr, object._uid, object.id, context={'lang': object.partner_id.lang})
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
                    % if data['lang'] == "ca_ES":
                        <a href="https://www.somenergia.coop/ca/"><img src="https://www.somenergia.coop/logo/logo_fosc.png" alt="SOM Energia" style="height: 106px"/></a>
                    %endif
                    % if data['lang'] != "ca_ES":
                        <a href="https://www.somenergia.coop/es/"><img src="https://www.somenergia.coop/logo/logo_fosc.png" alt="SOM Energia" style="height: 106px"/></a>
                    %endif
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
                    <!-- Mail -->
                    <p>

                    % if data['lang'] == "ca_ES":
                      <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                          <td colspan="2">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">Número de contracte</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['numero']}</p>
                                  </td>
                              </tr>
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">CUPS</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['cups']}</p>
                                  </td>
                              </tr>
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">Titular</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['titular']}</p>
                                  </td>
                              </tr>
                              </table>
                          </td>
                          </tr>
                      </table>

                      <p>
                      Hola,
                      </p>
                      Ens posem en contacte amb vosaltres per informar-vos que <strong>a partir de l'1 de gener de 2026 renovarem el contracte amb la tarifa indexada empresa</strong> que teniu contractada actualment i que <strong>actualitzarem el preu de la franja de la cooperativa,</strong> que correspon al nostre marge.
                      </p>
                      <h1>
                        Actualització de la franja de la cooperativa
                      </h1>
                      <p>
                        En la <strong>tarifa indexada empresa</strong> personalitzem el preu de la franja de la cooperativa (la variable F de la fórmula indexada que podeu consultar al <a href="https://www.somenergia.coop/ca/serveis/com-calculem-el-preu">nostre web</a>) segons el vostre ús d'energia anual. Per això, un cop a l'any, revisem el vostre ús d'energia dels últims dotze mesos i ajustem el preu de la franja: si heu augmentat l'ús d'energia, el valor d'aquesta variable es redueix, i a la inversa, si el vostre ús ha disminuït, el seu valor s'incrementa.
                      </p>
                      Per al vostre contracte, actualment la franja és de ${"%.5f" % (float(data['dades_index']['f_antiga']) / 1000)} €/kWh,  i <strong>a partir de l'1 de gener serà de: ${"%.5f" % (float(data['dades_index']['f_nova']) / 1000)} €/kWh.</strong>
                      </p>
                      <p>
                        Aquest preu està calculat tenint en compte el vostre <strong>ús d'energia dels últims dotze mesos: ${data['dades_index']['conany']} kWh.</strong>
                      </p>
                      <h2>
                        Estimació orientativa
                      </h2>
                      <p>
                        Tal com estableix la normativa, hem realitzat una <strong>estimació del cost anual de l'energia amb la nova franja.</strong> Tenint en compte l'ús de l'últim any, el cost per als pròxims dotze mesos amb la franja actual seria de ${data['dades_index']['import_total_anual_antiga_amb_impost']} €, mentre que amb la nova franja seria de ${data['dades_index']['import_total_anual_nova_amb_impost']} €. En tots dos casos, l'estimació inclou el 21% d'IVA i el 5,11% d'impost especial de l'electricitat.
                      </p>
                      <h2>Actualització de peatges i càrrecs</h2>
                      <p>
                        Els peatges i càrrecs regulats s'actualitzen automàticament (POSAR EL TEXT DEL CORREU GENERAL).
                      </p>
                      <h3>Informació legal</h3>
                      <p>
                        La <a href="https://back.somenergia.coop/storage/app/media/DOCS/Condicions-Generals-contracte-subministrament-energia-electrica-SomEnergia.pdf">clàusula 5.3 (ii) de les Condicions Generals</a> ens autoritza a fer aquest canvi de la part del preu no regulada.
                      </p>
                      <p>
                        En aquest correu adjuntem el contracte actualitzat amb els canvis aplicats. Si hi esteu d'acord, <strong>no cal que ens retorneu el document signat,</strong> ja que l'actualització del preu s'aplica automàticament. Igualment, hem d'informar-vos que si, per alguna raó, aquest canvi us fes replantejar la continuïtat amb la cooperativa, podríeu donar de baixa el vostre contracte mitjançant un canvi de comercialitzadora, ja que no apliquem penalitzacions ni clàusules de permanència. Tanmateix, si aquesta és la vostra decisió, us agrairem que ens ho comuniqueu amb un preavís de 30 dies. En aquest cas, facturaríem el consum realitzat fins a la data de baixa del contracte, amb els preus vigents a cada moment.
                      </p>
                     <p>Quedem a la vostra disposició per a qualsevol dubte o consulta.</p>
                      <p>
                        Salutacions cordials,
                      </p>
                      <p>
                      Equip de Som Energia <br/>
                      <a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a>
                      </p>
                    %else:
                      <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                        <tr>
                          <td colspan="2">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">Número de contrato</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['numero']}</p>
                                  </td>
                              </tr>
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">CUPS</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['cups']}</p>
                                  </td>
                              </tr>
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">Titular</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['titular']}</p>
                                  </td>
                              </tr>
                              </table>
                          </td>
                        </tr>
                      </table>

                      <p>
                      Hola,
                       </p>
                        Nos ponemos en contacto para informaros que <strong>a partir del 1 de enero de 2026 renovaremos el contrato con la tarifa indexada empresa</strong> que tenéis contratada actualmente y que <strong>actualizaremos el precio de la franja de la cooperativa,</strong> que corresponde a nuestro margen.
                      </p>
                      <h1>
                        Actualización de la franja de la cooperativa
                      </h1>
                      <p>
                        En la <strong>tarifa indexada empresa</strong> personalizamos el precio de la franja de la cooperativa (la variable F de la fórmula indexada que podéis consultar en <a href="https://www.somenergia.coop/es/servicios/como-calculamos-el-precio/">nuestro web</a>) según vuestro uso de energía anual. Por este motivo, una vez al año, revisamos vuestro uso de energía de los últimos doce meses y ajustamos el precio de la franja: si habéis aumentado vuestro uso, el valor de esta variable se reduce, y a la inversa, si vuestro uso ha disminuido, su valor se incrementa.
                      </p>
                      Para vuestro contrato, actualmente la franja es de ${"%.5f" % (float(data['dades_index']['f_antiga']) / 1000)} €/kWh y <strong>a partir del 1 de enero será de: ${"%.5f" % (float(data['dades_index']['f_nova']) / 1000)} €/kWh.</strong>
                      </p>
                      <p>
                        Este precio está calculado teniendo en cuenta vuestro <strong>uso de energía de los últimos doce meses: ${data['dades_index']['conany']} kWh.</strong>
                      </p>
                      <h2>
                        Estimación orientativa
                      </h2>
                      <p>
                        Tal como establece la normativa, hemos realizado una <strong>estimación del coste anual de la energía con la nueva franja.</strong> Teniendo en cuenta el uso del último año, el coste para los próximos doce meses con la franja actual sería de ${data['dades_index']['import_total_anual_antiga_amb_impost']} €, mientras que con la nueva franja sería de ${data['dades_index']['import_total_anual_nova_amb_impost']} €. En ambos casos, la estimación incluye el 21% de IVA y el 5,11% del impuesto especial de la electricidad.
                      </p>
                       <h2>Actualización de peajes y cargos</h2>
                      <p>
                        Los peajes y cargos regulados se actualizan automáticamente (POSAR EL TEXT DEL CORREU GENERAL).
                      </p>
<h3>Información legal</h3>
                      <p>
                        La <a href="https://back.somenergia.coop/storage/app/media/DOCS/Condiciones-generales-contrato-suministro-energia-electrica-SomEnergia.pdf">cláusula 5.3 (ii) de las Condiciones Generales</a> nos autoriza a realizar este cambio de la parte del precio no regulada.
                      </p>
                      <p>
                        En este correo adjuntamos el contrato actualizado con los cambios aplicados. Si estáis de acuerdo, <strong>no es necesario que retornéis el documento firmado,</strong> puesto que la actualización del precio se aplica automáticamente. Igualmente, debemos informaros que si, por alguna razón, este cambio os hiciera replantear la continuidad con la cooperativa, podéis dar de baja vuestro contrato mediante un cambio de comercializadora, ya que no aplicamos penalizaciones ni cláusulas de permanencia. Asimismo, si esta es vuestra decisión, os agradeceremos que nos lo comuniquéis con un preaviso de 30 días. En este caso, facturaríamos el consumo realizado hasta la fecha de baja del contrato, con los precios vigentes en cada momento.
                      </p>
                     <p>Quedamos a vuestra disposición para cualquier duda o consulta.</p>
                      <p>
                        Un cordial saludo,
                      </p>
                      <p>
                      Equip de Som Energia <br/>
                      <a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a>
                      </p>
                    %endif
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
