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
                                  <p class="f-fallback purchase_total purchase_total--label">Contracte</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['numero']}</p>
                                  </td>
                              </tr>
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">Adreça del punt de subministrament</p>
                                  </td>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback">${data['contract']['direccio_cups']}</p>
                                  </td>
                              </tr>
                              <tr>
                                  <td width="50%" class="purchase_footer" valign="middle">
                                  <p class="f-fallback purchase_total purchase_total--label">Codi CUPS</p>
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
                        Ens posem en contacte amb vosaltres per informar-vos que <strong>a partir de l'1 d'agost aplicarem uns petits canvis en el càlcul del preu de l'energia</strong> amb la tarifa indexada, i també aprofitem per fer <strong>l'actualització anual de la franja de la cooperativa,</strong> personalitzada segons el vostre ús d'energia dels últims dotze mesos.
                      </p>
                      <h1>
                        Canvis en el càlcul del preu de l'energia
                      </h1>
                      <p>
                        A partir de l'1 d'agost aplicarem els següents canvis en la fórmula per calcular el preu de l'energia:
                      </p>
                      <ul>
                        <li>
                          El cost de les garanties d'origen 100% renovable (GdO) i dels desviaments (Dsv) els traiem de la franja de la cooperativa (F) i els posem amb la resta de costos variables, de manera que la franja serà únicament el marge per la viabilitat de la cooperativa.
                        </li>
                        <li>
                          Eliminen del càlcul el preu del mecanisme d'ajust del gas (PHMA), que ja no és vigent, i el cost del servei d'interrumpibilitat (I), perquè és zero.
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
                        (Al <a href="https://www.somenergia.coop">nostre web</a> pots veure a què correspon cada terme.)
                      </p>
                      %if data['canaries'] or data['balears']:
                        <p>
                          També modifiquem el preu de compensació dels excedents perquè sigui igual al preu que els retribueix Red Eléctrica. Aquest canvi suposarà una petita disminució del preu de compensació, ja que al preu del mercat insular li passarem a restar un terme anomenat SphAuto.
                        </p>
                      %endif
                      <h1>
                        Actualització anual de la franja de la cooperativa
                      </h1>
                      <p>
                        En la <strong>tarifa indexada empresa</strong> personalitzem el preu de la franja de la cooperativa (la variable F de la fórmula) segons el vostre ús d'energia anual. Per això, un cop a l'any, revisem el vostre ús d'energia dels últims dotze mesos i ajustem el preu de la franja: a major ús, el preu per kWh es redueix, i a la inversa, si l'ús disminueix el preu per kWh, s'incrementa.
                      </p>
                      <p>
                        Per al vostre contracte, actualment la franja F (que també inclou els costos dels certificats de garantia d'origen 100% renovable i dels desviaments) és de ${data['dades_index']['f_antiga_eie']} €/kWh, i a partir de l'1 d'agost (que tal com hem explicat, correspondrà al marge per la cooperativa) serà de: ${data['dades_index']['f_nova_eie']} €/kWh.
                      </p>
                      <p>
                        Aquest preu està calculat tenint en compte el vostre ús d'energia dels últims dotze mesos: ${data['dades_index']['conany']} kWh.
                      </p>
                      <h2>
                        Estimació orientativa
                      </h2>
                      <p>
                        Tal com estableix la normativa, hem realitzat una <strong>estimació del cost anual de l'energia amb la nova franja F i la nova fórmula per calcular el preu de l'energia.</strong> Tenint en compte l'ús d'energia en els últims dotze mesos, el cost hauria estat de ${data['dades_index']['import_total_anual_nova_amb_impost']} €, mentre que amb la franja F actual i la fórmula el cost ha sigut de ${data['dades_index']['import_total_anual_antiga_amb_impost']} €.
                      </p>
                      <h2>Informació legal</h2>
                      <p>
                        La <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus és la clàusula 5.3 (ii) per a les modificacions de la part del preu no regulada.
                      </p>
                      <p>
                        En aquest correu adjuntem el contracte actualitzat amb els canvis aplicats. Si hi esteu d'acord, <strong>no cal que ens retorneu el document signat,</strong> ja que l'actualització del preu s'aplica automàticament. Igualment, hem d'informar-vos que si, per alguna raó, aquest canvi us fes replantejar la continuïtat amb la cooperativa, podríeu donar de baixa el vostre contracte mitjançant un canvi de comercialitzadora, ja que no apliquem penalitzacions ni clàusules de permanència. Tanmateix, si aquesta és la vostra decisió, us agrairem que ens ho comuniqueu amb un preavís de 30 dies. En aquest cas, facturaríem el consum realitzat fins a la data de baixa del contracte, amb els preus vigents a cada moment.
                      </p>
                      <p>Quedem a la vostra disposició per a qualsevol dubte o consulta.</p>
                      <p>
                        Una salutació cordial,
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