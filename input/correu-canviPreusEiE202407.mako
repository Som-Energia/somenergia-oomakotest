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

    email_o = object.pool.get('report.backend.mailcanvipreus')
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
                        <a href="https://www.somenergia.coop/ca/"><img src="https://www.somenergia.coop/logo/Logotip-Som-Energia.png" alt="SOM Energia" style="height: 106px"/></a>
                    %endif
                    % if data['lang'] != "ca_ES":
                        <a href="https://www.somenergia.coop/es/"><img src="https://www.somenergia.coop/logo/Logotip-Som-Energia.png" alt="SOM Energia" style="height: 106px"/></a>
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
                      Hola,<br/>
                    </p>

                    % if data['lang'] == "ca_ES":
                      <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                          <td colspan="2">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">Contracte Som Energia nº</p>
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
                        Ens posem en contacte amb vosaltres per informar-vos que <strong>a partir de l'1 d'agost aplicarem uns petits canvis en el càlcul del preu de l'energia</strong> amb la tarifa indexada. També aprofitem aquest moment per fer <strong>l'actualització anual de la franja de la cooperativa,</strong> personalitzada segons el vostre ús d'energia dels últims dotze mesos.
                      </p>
                      <h1>
                        Canvis en el càlcul del preu de l'energia
                      </h1>
                      <p>
                        A partir de l'1 d'agost aplicarem els següents canvis en la fórmula per calcular el preu de l'energia:
                      </p>
                      <ul>
                        <li>
                          Traiem de la franja de la cooperativa (F) el cost de les garanties d'origen 100% renovable (GdO) i dels desviaments (Dsv) i els posem amb la resta de costos variables, de manera que la franja serà únicament el marge per la viabilitat de la cooperativa.
                        </li>
                        <li>
                          Eliminen del càlcul el preu del mecanisme d'ajust del gas (PHMA), que ja no és vigent i el cost del servei d'interrumpibilitat (I), perquè és zero.
                        </li>
                      </ul>
                      <p>
                        La nova fórmula, doncs, serà la següent:
                      </p>
                      <p>
                        <strong style="font-size: 14px; text-align: center">
                          PH = 1,015 × [(PHM + Pc + Sc + <span style="color:#7dbc09">Dsv</span> + <span style="color:#7dbc09">GdO</span> + POsOm) (1 + Perd) + FE + F] + PTD + CA
                        </strong>
                      </p>
                      <p>
                        (Al <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#formula-indexada">nostre web</a> podeu veure a què correspon cada terme).
                      </p>
                      %if data['canaries'] or data['balears']:
                        <p>
                          També <strong>modifiquem el preu de compensació dels excedents</strong> perquè sigui igual al preu que els retribueix Red Eléctrica. Aquest canvi suposarà una <strong>petita disminució del preu de compensació,</strong> ja que al preu actual del mercat insular li passarem a restar un terme anomenat Sph Auto.
                        </p>
                      %endif
                      <h1>
                        Actualització anual de la franja de la cooperativa
                      </h1>
                      <p>
                        En la <strong>tarifa indexada empresa</strong> personalitzem el preu de la franja de la cooperativa (la variable F de la fórmula) segons el vostre ús d'energia anual. Per això, un cop a l'any, revisem el vostre ús d'energia dels últims dotze mesos i ajustem el preu de la franja (F): a major ús, el valor d'aquesta variable es redueix, i a la inversa, si l'ús disminueix, el seu valor s'incrementa.
                      </p>
                      <p>
                        Per al vostre contracte, actualment la franja F (que també inclou els costos de les garanties d'origen 100% renovable i dels desviaments) és de ${data['dades_index']['f_antiga_eie']} €/kWh,  i a partir de l'1 d'agost (que tal com us hem explicat, correspondrà únicament al marge per la cooperativa) serà de:  <strong>${data['dades_index']['f_nova_eie']} €/kWh.</strong>
                      </p>
                      <p>
                        Aquest preu està calculat tenint en compte el vostre ús d'energia dels últims dotze mesos: <strong>${data['dades_index']['conany']} kWh.</strong>
                      </p>
                      <h2>
                        Estimació orientativa
                      </h2>
                      <p>
                        Tal com estableix la normativa, hem realitzat una <strong>estimació del cost anual de l'energia amb la nova franja F i la nova fórmula per calcular el preu de l'energia.</strong>  Tenint en compte el consum de l'últim any, el cost per als pròxims dotze mesos amb la fórmula i la franja F actual seria de ${data['dades_index']['import_total_anual_antiga_amb_impost']} €, mentre que amb la nova franja i la nova fórmula seria de ${data['dades_index']['import_total_anual_nova_amb_impost']} €. En tots dos casos, l'estimació inclou els impostos vigents (21% d'IVA i 5,11% d'impost especial de l'electricitat).
                      </p>
                      <h2>Informació legal</h2>
                      <p>
                        La <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusula 5.3 (ii) de les Condicions Generals</a> ens autoritza a fer aquest canvi de la part del preu no regulada.
                      </p>
                      <p>
                        En aquest correu adjuntem el contracte actualitzat amb els canvis aplicats. Si hi esteu d'acord, <strong>no cal que ens retorneu el document signat,</strong> ja que l'actualització del preu s'aplica automàticament. Igualment, hem d'informar-vos que si, per alguna raó, aquest canvi us fes replantejar la continuïtat amb la cooperativa, podríeu donar de baixa el vostre contracte mitjançant un canvi de comercialitzadora, ja que no apliquem penalitzacions ni clàusules de permanència. Tanmateix, si aquesta és la vostra decisió, us agrairem que ens ho comuniqueu amb un preavís de 30 dies. En aquest cas, facturaríem el consum realitzat fins a la data de baixa del contracte, amb els preus vigents a cada moment.
                      </p>
                      <h2>Nou apartat web: tendència de preus de les pròximes hores</h2>
                      <p>
                        Per acabar, us informem que hem estrenat un nou <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">apartat web</a> on podeu <strong>consultar la previsió dels preus de l'energia en la tarifa indexada del mateix dia i de l'endemà.</strong> Tot i que els preus que mostrem estan calculats amb la franja general per 2.0TD, 3.0TD i 6.1TD (no amb la vostra franja personalitzada), i que no són els preus definitius (caldrà afegir-hi un terme que es publica amb posterioritat), és <strong>útil per saber a quines hores l'energia serà més barata o més cara.</strong>
                      </p>
                      <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                        <tr>
                          <td align="center">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                              <tr>
                                <td align="center">
                                  <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/" class="f-fallback button" target="_blank">Mira la pàgina</a>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                      <p>
                        Quedem a la vostra disposició per a qualsevol dubte o consulta.
                      </p>
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
                                  <p class="f-fallback purchase_total purchase_total--label">Contrato Som Energia nº</p>
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
                        Nos ponemos en contacto para informaros que <strong>a partir del 1 de agosto aplicaremos unos pequeños cambios en el cálculo del precio de la energía</strong> con la tarifa indexada que tenéis contratada actualmente. También aprovechamos este momento para realizar la <strong>actualización anual de la franja de la cooperativa,</strong> personalizada según vuestro uso de energía de los últimos doce meses.
                      </p>
                      <h1>
                        Cambios en el cálculo del precio de la energía
                      </h1>
                      <p>
                        A partir del 1 de agosto aplicaremos los siguientes cambios en la fórmula para calcular el precio de la energía:
                      </p>
                      <ul>
                        <li>
                          Sacamos de la franja de la cooperativa (F) el coste de las garantías de origen 100% renovable (GdO) y de los desvíos (Dsv) y los ponemos con el resto de costes variables, de manera que la franja será únicamente el margen para la viabilidad de la cooperativa.
                        </li>
                        <li>
                          Eliminamos del cálculo el precio del mecanismo de ajuste del gas (PHMA), que ya no es vigente y el coste del servicio de interrumpibilidad (I), porque es cero.
                        </li>
                      </ul>
                      <p>
                        La nueva fórmula, pues, será la siguiente:
                      </p>
                      <p>
                        <strong style="font-size: 14px; text-align: center">
                          PH = 1,015 × [(PHM + Pc + Sc + <span style="color:#7dbc09">Dsv</span> + <span style="color:#7dbc09">GdO</span> + POsOm) (1 + Perd) + FE + F] + PTD + CA
                        </strong>
                      </p>
                      <p>
                        (En <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#formula-indexada">nuestra web</a> podéis ver a qué corresponde cada término).
                      </p>
                      %if data['canaries'] or data['balears']:
                        <p>
                          También <strong>modificamos el precio de compensación de los excedentes</strong> para que sea igual al precio que los retribuye Red Eléctrica. Este cambio supondrá una <strong>  ligera disminución del precio de compensación,</strong> ya que al precio actual del mercado insular le pasaremos a restar un término llamado Sph Auto.
                        </p>
                      %endif
                      <h1>
                        Actualización anual de la franja de la cooperativa
                      </h1>
                      <p>
                        En la <strong>tarifa indexada empresa</strong> personalizamos el precio de la franja de la cooperativa (la variable F de la fórmula) según vuestro uso de energía anual. Por este motivo, una vez al año, revisamos vuestro uso de energía de los últimos doce meses y ajustamos el precio de la franja (F): a mayor uso, el valor de esta variable se reduce, y a la inversa, si el uso ha disminuido, su valor se incrementa.
                      </p>
                      <p>
                        Para vuestro contrato, actualmente la franja F (que también incluye los costes de las garantías de origen 100% renovable y de los desvíos) es de ${data['dades_index']['f_antiga_eie']} €/kWh y a partir del 1 de agosto (que tal y como os hemos explicado, corresponderá únicamente al margen per la cooperativa) será de: <strong>${data['dades_index']['f_nova_eie']} €/kWh.</strong>
                      </p>
                      <p>
                        Este precio está calculado teniendo en cuenta vuestro uso de energía de los últimos doce meses: <strong>${data['dades_index']['conany']} kWh.</strong>
                      </p>
                      <h2>
                        Estimación orientativa
                      </h2>
                      <p>
                        Tal como establece la normativa, hemos realizado una <strong>estimación del coste anual de la energía con la nueva franja F y la nueva fórmula para calcular el precio de la energía.</strong> Teniendo en cuenta el consumo del último año, el coste para los próximos doce meses con la fórmula y la franja F actual sería de ${data['dades_index']['import_total_anual_antiga_amb_impost']} €, mientras que con la nueva franja y la nueva fórmula seria de ${data['dades_index']['import_total_anual_nova_amb_impost']} €. En ambos casos, la estimación incluye los impuestos vigentes (21% de IVA y 5,11% del impuesto especial de la electricidad).
                      </p>
                      <h2>Información legal</h2>
                      <p>
                        La <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/#precio-y-actualizacion">cláusula 5.3 (ii) de las Condiciones Generales</a> nos autoriza a realizar este cambio de la parte del precio no regulada.
                      </p>
                      <p>
                        En este correo adjuntamos el contrato actualizado con los cambios aplicados. Si estáis de acuerdo, <strong>no es necesario que retornéis el documento firmado,</strong> puesto que la actualización del precio se aplica automáticamente. Igualmente, debemos informaros que si, por alguna razón, este cambio os hiciera replantear la continuidad con la cooperativa, podéis dar de baja vuestro contrato mediante un cambio de comercializadora, ya que no aplicamos penalizaciones ni cláusulas de permanencia. Asimismo, si esta es vuestra decisión, os agradeceremos que nos lo comuniquéis con un preaviso de 30 días. En este caso, facturaríamos el consumo realizado hasta la fecha de baja del contrato, con los precios vigentes en cada momento.
                      </p>
                      <h2>Nuevo apartado web: tendencia de precios de las próximas horas</h2>
                      <p>
                        Para acabar, os informamos que hemos estrenado un nuevo <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/precio-hoy/">apartado web</a> donde podéis <strong>consultar la previsión de precios de la energía en la tarifa indexada del mismo día y del día siguiente.</strong> A pesar de que los precios que mostramos están calculados con la franja general para 2.0TD, 3.0TD y 6.1TD (no vuestra franja personalizada), y que no son los precios definitivos (hay que añadir una variable que se publica con posterioridad), es <strong>útil para saber a qué horas la energía será más barata o más cara.</strong>
                      </p>
                      <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                        <tr>
                          <td align="center">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                              <tr>
                                <td align="center">
                                  <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/precio-hoy/" class="f-fallback button" target="_blank">Mira la pàgina</a>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
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