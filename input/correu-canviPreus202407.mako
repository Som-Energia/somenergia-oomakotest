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
                      Hola${data['nom_titular']} <br/>
                    </p>

                    % if data['lang'] == "ca_ES":
                        % if data['modcon'] == "index":
                            <figure class="table">
                                <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <p>
                                                  <span style="font-weight: 400;text-align: left;">
                                                    Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. T'informem, doncs, d'un petit canvi que aplicarem a la tarifa indexada a partir de l'1 d'agost, i d'una nova opció disponible: la tendència de preus per a les properes 24 hores.
                                                  </span>
                                                </p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </figure>
                        % elif data['modcon'] == "atr":
                          <figure class="table">
                              <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                                  <tbody>
                                      <tr>
                                          <td>
                                              <p>
                                                <span style="font-weight: 400;text-align: left;">
                                                  Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la tarifa ${data['tarifa_acces']} períodes, que s’hauria de produir a les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} indexada, t'expliquem més avall els canvis que hi aplicarem a partir de l'1 d'agost, i que t’afectaran si, per algun motiu, el teu contracte segueix amb la tarifa indexada.
                                                </span>
                                              </p>
                                              <p>
                                                <span style="font-weight: 400;text-align: left;">
                                                  Al nostre web pots trobar la nova fórmula de càlcul de la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">tarifa indexada</a>. En resum, augmenta lleugerament el marge del preu de l'energia.
                                                </span>
                                              </p>
                                          </td>
                                      </tr>
                                  </tbody>
                              </table>
                          </figure>
                        % endif
                        % if data['modcon'] != "atr" and data['modcon'] != "index":
                          <p>
                            T'escrivim per explicar-te dues novetats respecte a la tarifa indexada que tens contractada actualment. Per una banda, estrenem un nou apartat web on podràs veure la tendència de preus de les properes 24 hores. Per altra banda, t'informem d'un petit augment en el marge de la viabilitat de la cooperativa, que forma part del preu de la teva tarifa indexada, i que aplicarem a partir de l'1 d'agost.
                          </p>
                        % endif
                        <h1>
                          Tendència de preus per a les properes hores
                        </h1>
                        <p>
                          Recentment hem posat en funcionament un apartat web on es pot veure la previsió de preus d'energia de la indexada per a les pròximes 24 hores. Hi pots veure, doncs, la tendència de preus per al dia següent, i això et pot ser útil per saber <strong>a quines hores l'energia serà més barata </strong> (és a dir, quan convé més, per exemple, posar la rentadora).
                        </p>
                        <img src="https://blog.somenergia.coop/wp-content/uploads/2024/06/Captura-web-24-CA.png" alt="GenerationDemo" width="550">
                        <p>
                          Si bé els preus de l'apartat web no seran els definitius (caldrà afegir-hi un terme que es publicarà amb posterioritat), sí que donen una idea fiable de les hores més econòmiques i les més cares.
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
                        <h1>
                          Canvi del marge en la tarifa
                        </h1>
                        <p>
                          Per altra banda, t'informem que a partir de l'1 d'agost aplicarem un <strong>lleuger augment al marge de viabilitat</strong> de la tarifa indexada, per tal de seguir garantint la viabilitat de la cooperativa. A continuació tens una versió resumida, per si no hi vols dedicar molt de temps, i més avall trobaràs una versió més detallada, per si t'interessa saber-ne els detalls.
                        </p>
                        <h2>
                          Explicació resumida
                        </h2>
                        %if data['Indexada20TDPeninsula']:
                         <p>
                            En el cas de la tarifa 2.0TD indexada (la teva), sense tenir en compte el preu de l'energia, a un contracte amb un consum mitjà de 2.500 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 15 euros l'any (poc més d'un euro al mes).</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                         </p>
                        %endif
                        %if data['Indexada30TDPeninsula']:
                          <p>
                            En el cas de la tarifa 3.0TD indexada (la teva), sense tenir en compte el preu de l'energia, a un contracte amb un consum mitjà de 10.000 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 58 euros l'any.</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                          </p>
                        %endif
                        %if data['Indexada61TDPeninsula']:
                          <p>
                            En el cas de la tarifa 6.1TD indexada (la teva), sense tenir en compte el preu de l'energia, a un contracte amb un consum mitjà de 15.000 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 79 euros l'any.</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                          </p>
                        %endif
                        %if data['Indexada30TDVEPeninsula']:
                          <p>
                            En el cas de la tarifa 3.0TDVE indexada (la teva), sense tenir en compte el preu de l'energia, a un contracte amb un consum mitjà de 10.000 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 58 euros l'any.</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                          </p>
                        %endif
                      <p>
                        Aquesta és la informació bàsica, resumida. Si tens curiositat i vols saber més detalls del canvi, a continuació te'ls expliquem. Com sempre, pots trobar els preus a l' <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">apartat de tarifes del web</a>.
                      </p>
                      <h2>Explicació detallada dels canvis</h2>
                      <h3 style="margin-top: 20px;">Canvis en la fórmula del càlcul del preu de l'energia</h3>
                      <p>
                        Com deus saber, la tarifa indexada obté el preu de l'energia a partir d'una fórmula, que inclou el cost de l'energia al mercat majorista, i inclou també altres conceptes (peatges, càrrecs…) que s'han de pagar per poder consumir energia. 
                      </p>
                      <p>
                        Un dels components de la fórmula és la "F", la franja de la cooperativa. Fins ara, dins d'aquest concepte hi incloíem el marge per a la viabilitat de la cooperativa, més els costos dels Certificats de Garantia d'Origen 100 % renovable (GdO) i els costos de les desviacions. A partir de l'1 d'agost, la "F" contindrà únicament el marge per a la viabilitat de la cooperativa. Els Certificats de Garantia d'Origen i els costos de les desviacions seguiran formant part de la fórmula, però en uns conceptes separats de la franja.
                      </p>
                      <p>
                        La nova fórmula, doncs, serà la següent:
                      </p>
                      <p>
                        <strong style="font-size: 14px; text-align: center">
                          PH = 1,015 × [(PHM + Pc + Sc + <span style="color:#7a562e">Dsv</span> + <span style="color:#7a562e">GdO</span> + P<sub>OsOm</sub>) (1 + Perd) + FE + F] + PTD + CA
                        </strong>
                      </p>
                      <p>
                        (Al <a href="https://www.somenergia.coop">nostre web</a> pots veure a què correspon cada terme.)
                      </p>
                      <p>
                        L'import dels certificats de garantia (a la fórmula: <span style="color:#7a562e;font-weight:bold;">GdO</span>) i dels costos de les desviacions (<span style="color:#7a562e;font-weight:bold;">Dsv</span>) s'anirà calculant en funció del que costin aquests conceptes, i es publicarà a <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">l'apartat web de tarifes.</a>
                      </p>
                      <p>
                        L'import de <strong> la franja (F) </strong> que ara serà únicament el marge, <strong> serà de ${data['dades_index']['f_nova']}</strong>.
                      </p>
                      <img src="https://blog.somenergia.coop/wp-content/uploads/2024/06/Captura-web-24-CA.png" alt="GenerationDemo" width="550">
                      <p>
                        Els preus de la potència, en aquest cas, no han canviat. Els pots trobar a <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">l'apartat web de tarifes.</a>
                      </p>
                      <h3>Estimació orientativa</h3>
                      <p>
                        Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del cost de l'electricitat amb aquest augment del marge, i l'hem comparat amb el cost amb la tarifa actual. L'estimació l'hem fet en base a un usuari/a mitjà, amb un contracte estàndard, d'un consum tipus, de ${data['dades_index']['conany']} kWh anuals, i sense tenir autoproducció ni Generation kWh, ni lloguer de comptador.
                      </p>
                      <p>
                        En els dos casos l'estimació inclou l'IVA del ${data['dades_index']['iva']}% i l'impost elèctric del ${data['dades_index']['ie']}%.
                      </p>
                      <p>
                        Així doncs, et mostrem a continuació l'estimació aproximada del cost anual si apliquéssim els preus actuals, i el cost anual si apliquéssim els nous preus.
                      </p>
                      <h3>
                        Cost anual estimat (euros/any)
                      </h3>
                      <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                        <tr>
                          <td colspan="3">
                            <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td class="purchase_borders" align="left">
                                  <p class="f-fallback"></p>
                                </td>
                                <td class="purchase_borders" align="left">
                                  <p class="f-fallback"><strong>Cost estimat amb els nous preus</strong></p>
                                </td>
                                <td class="purchase_borders" align="left">
                                  <p class="f-fallback"><strong>Cost estimat amb els preus actuals</strong></p>
                                </td>
                              </tr>
                              <tr>
                                <td width="33%" class="purchase_borders" valign="middle">
                                  <p class="f-fallback">Abans d'impostos</p>
                                </td>
                                <td width="33%" class="purchase_borders" valign="middle">
                                  <p class="f-fallback">${data['dades_index']['import_total_anual_nova']}</p>
                                </td>
                                <td width="33%" class="purchase_borders" valign="middle">
                                  <p class="f-fallback">${data['dades_index']['import_total_anual_antiga']}</p>
                                </td>
                              </tr>
                              <tr>
                                <td width="33%" class="purchase_borders" valign="middle">
                                  <p class="f-fallback">Després d'impostos</p>
                                </td>
                                <td width="33%" class="purchase_borders" valign="middle">
                                  <p class="f-fallback">${data['dades_index']['import_total_anual_nova_amb_impost']}</p>
                                </td>
                                <td width="33%" class="purchase_borders" valign="middle">
                                  <p class="f-fallback">${data['dades_index']['import_total_anual_antiga_amb_impost']}</p>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                      <p>
                        Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l'ús d'energia que finalment facis, altres variacions de preus durant l'any, o canvis que hi pugui haver al mercat elèctric.
                      </p>
                      <p>
                        Com sempre, pots trobar la informació, els preus i la fórmula de la tarifa indexada al nostre web, <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">apartat tarifa indexada</a>, i al <a href="https://ca.support.somenergia.coop/category/1359-les-tarifes-indexades">Centre d'Ajuda</a>. També hem publicat una <a href="https://ca.support.somenergia.coop/category/1359-les-tarifes-indexades">notícia al blog</a> que explica aquest canvi.
                      </p>
                      <h2>Informació legal</h2>
                      <p>
                        La <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus és la clàusula 5.3 (ii) per a les modificacions de la part del preu no regulada.
                      </p>
                      <p>
                        % if data['modcon'] != "atr" and data['modcon'] != "index":
                          T'adjuntem en aquest correu el teu contracte actualitzat amb els canvis aplicats. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat,</strong> ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/">tarifa per períodes</a> (<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                        %else:
                          T'adjuntem en aquest correu el teu contracte actualitzat amb els canvis aplicats. Si hi estàs d’acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi et fes replantejar seguir amb aquesta tarifa, podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                        %endif
                      </p>
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