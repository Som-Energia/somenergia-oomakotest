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
                                                  Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} períodes,</strong> que s'hauria de produir a les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} indexada, t'expliquem més avall els canvis que hi aplicarem a partir de l'1 d'agost, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa indexada.
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
                          %if not data['canaries'] and not data['balears']:
                            <p>
                              T'escrivim per explicar-te dues novetats respecte a la tarifa indexada que tens contractada actualment. Per una banda, estrenem un nou apartat web on podràs veure la tendència de preus de les properes 24 hores. Per altra banda, t'informem d'un petit augment en el marge de la viabilitat de la cooperativa, que forma part del preu de la teva tarifa indexada, i que aplicarem a partir de l'1 d'agost.
                            </p>
                          %else: ## Es Canaries o Balears
                            %if data['autoconsum']['compensacio']:
                              <p>
                                T'escrivim per explicar-te dos canvis respecte a la tarifa indexada que tens contractada actualment, i que aplicarem a partir de l'1 d'agost. Per una banda, augmentarem lleugerament el marge de viabilitat de la cooperativa, que forma part del preu de la tarifa indexada, i per altra banda modificarem la fórmula que estableix la compensació d'excedents d'autoproducció.
                              </p>
                              <h1>Canvi del marge en la tarifa</h1>
                              <p>
                                Com et dèiem, a partir de l'1 d'agost aplicarem un <strong>petit augment al marge de viabilitat</strong> de la tarifa indexada, per tal de seguir garantint la viabilitat de la cooperativa. A continuació tens una versió resumida, per si no hi vols dedicar molt de temps, i més avall trobaràs una versió més detallada, per si t'interessa saber-ne els detalls.
                              </p>
                            %else:
                              <p>
                                T'escrivim per explicar-te que a partir de l'1 d'agost augmentarem lleugerament el marge de viabilitat de les tarifes indexades, per seguir garantint la viabilitat de la cooperativa. A continuació tens una versió resumida, per si no hi vols dedicar molt de temps, i més avall trobaràs una versió més detallada, per si t'interessa saber-ne els detalls.
                              </p>
                            %endif
                          %endif
                        % endif
                        %if not data['canaries'] and not data['balears']:
                          <h1>
                            Tendència de preus per a les properes hores
                          </h1>
                          <p>
                            Recentment hem posat en funcionament un apartat web on es pot veure la previsió de preus d'energia de la indexada per a les pròximes 24 hores. Hi pots veure, doncs, la tendència de preus per al dia següent, i això et pot ser útil per saber <strong>a quines hores l'energia serà més barata </strong> (és a dir, quan convé més, per exemple, posar la rentadora).
                          </p>
                          <img src="https://blog.somenergia.coop/wp-content/uploads/2024/06/Captura-web-24h-marge-CA.png" alt="GenerationDemo" width="550">
                          <br/><br/><br/>
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
                        % endif
                      <h2>
                        Explicació resumida
                      </h2>
                      %if data['Indexada20TDPeninsula']:
                        <p>
                          En el cas de la tarifa 2.0TD indexada (la teva), sense tenir en compte el preu de l'energia, a un contracte amb un consum mitjà de 2.500 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 19 euros l'any (un euro i mig al mes).</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
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
                      %if data['Indexada20TDCanaries'] or data['Indexada20TDBalears']:
                        <p>
                          En el cas de la tarifa 2.0TD indexada (la teva), sense tenir en compte el preu de l'energia ni l'autoproducció, a un contracte amb un consum mitjà, de 2.500 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 19 euros l'any (poc més d'un euro i mig al mes).</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                        </p>
                      %endif
                      %if data['Indexada30TDCanaries'] or data['Indexada30TDBalears']:
                        <p>
                          En el cas de la tarifa 3.0TD indexada (la teva), sense tenir en compte el preu de l'energia ni l'autoproducció, a un contracte amb un consum mitjà de 10.000 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 58 euros l'any.</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                        </p>
                      %endif
                      %if not data['canaries'] and not data['balears']:
                        <p>
                          Aquesta és la informació bàsica, resumida. Si tens curiositat i vols saber més detalls del canvi, a continuació te'ls expliquem. Com sempre, pots trobar els preus a l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">apartat de tarifes del web</a>.
                        </p>
                      %else: ## Es Canaries o Balears
                        <p>
                          Aquesta és la informació bàsica, resumida. Si tens curiositat i vols saber més detalls del canvi, a continuació te'ls expliquem.
                        </p>
                      % endif
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
                          PH = 1,015 × [(PHM + Pc + Sc + <span style="color:#c68c43">Dsv</span> + <span style="color:#c68c43">GdO</span> + P<sub style="font-size: 9px;">OsOm</sub>) (1 + Perd) + FE + F] + PTD + CA
                        </strong>
                      </p>
                      <p>
                        (Al <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#formula-indexada">nostre web</a> pots veure a què correspon cada terme.)
                      </p>
                      <p>
                        L'import dels certificats de garantia (a la fórmula: <span style="color:#c68c43;font-weight:bold;">GdO</span>) i dels costos de les desviacions (<span style="color:#c68c43;font-weight:bold;">Dsv</span>) s'anirà calculant en funció del que costin aquests conceptes, i es publicarà a <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">l'apartat web de tarifes.</a>
                      </p>
                      <p>
                        L'import de <strong> la franja (F) </strong> que ara serà únicament el marge, <strong> serà de ${data['dades_index']['f_nova']}</strong>.
                      </p>
                      <img src="https://blog.somenergia.coop/wp-content/uploads/2024/06/Captura-web-24-CA.png" alt="GenerationDemo" width="550">
                      <br/><br/>
                      <p>
                        Els preus de la potència, en aquest cas, no han canviat. Els pots trobar a <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">l'apartat web de tarifes.</a>
                      </p>
                      <h3>Estimació orientativa</h3>
                      <p>
                        Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del cost de l'electricitat amb aquest augment del marge, i l'hem comparat amb el cost amb la tarifa actual. L'estimació l'hem fet en base a un usuari/a mitjà, amb un contracte estàndard, d'un consum tipus, de ${data['dades_index']['conany']} kWh anuals, i sense tenir autoproducció ni Generation kWh, ni lloguer de comptador.
                      </p>
                      <p>
                        En els dos casos l'estimació inclou l'${data['impostos_str']} i l'impost elèctric del ${data['dades_index']['ie']}%.
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
                                <td class="purchase_borders" style="vertical-align: center;" align="left">
                                  <p class="f-fallback"  style="margin: 10px 0"></p>
                                </td>
                                <td class="purchase_borders" style="vertical-align: center;" align="left">
                                  <p class="f-fallback"  style="margin: 10px 0"><strong>Cost estimat amb els nous preus</strong></p>
                                </td>
                                <td class="purchase_borders" style="vertical-align: center;" align="left">
                                  <p class="f-fallback" style="margin: 10px 0"><strong>Cost estimat amb els preus actuals</strong></p>
                                </td>
                              </tr>
                              <tr>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback"  style="margin: 10px 0">Abans d'impostos</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_nova']}</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_antiga']}</p>
                                </td>
                              </tr>
                              <tr>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="margin: 10px 0">Després d'impostos</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_nova_amb_impost']}</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_antiga_amb_impost']}</p>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                      <br/>
                      <p>
                        Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l'ús d'energia que finalment facis, altres variacions de preus durant l'any, o canvis que hi pugui haver al mercat elèctric.
                      </p>
                      %if not data['canaries'] and not data['balears']:
                        <p>
                          Com sempre, pots trobar la informació, els preus i la fórmula de la tarifa indexada al nostre web, <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">apartat tarifa indexada</a>, i al <a href="https://ca.support.somenergia.coop/category/1359-les-tarifes-indexades">Centre d'Ajuda</a>. També hem publicat una <a href="https://ca.support.somenergia.coop/category/1359-les-tarifes-indexades">notícia al blog</a> que explica aquest canvi.
                        </p>
                      %else: ## Es Canaries o Balears
                        %if data['autoconsum']['compensacio']:
                          <h1>Canvi del càlcul de compensació dels excedents</h1>
                          <p>
                            Per altra banda, aplicarem també un canvi en el preu de compensació dels excedents de Balears i Canàries. En les tarifes indexades compensem els excedents al mateix preu a què ens els paga Red Eléctrica a Som Energia. No hi afegim marge ni comissions. Per seguir fent-ho així, com que Red Eléctrica paga els excedents a preu de mercat insular i li resta el preu d'un terme anomenat SphAuto, també hem de restar aquest terme a la fórmula de compensació d'excedents de Som Energia. Això suposarà una <strong>petita disminució del preu de compensació.</strong>
                          </p>
                          <p>
                            Recorda que la manera de treure més profit de les instal·lacions d'autoproducció és utilitzant l'energia al mateix moment en què es genera.
                          </p>
                        %endif
                      %endif
                      <h2>Informació legal</h2>
                      %if not data['canaries'] and not data['balears']:
                        <p>
                          La <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus és la clàusula 5.3 (ii) per a les modificacions de la part del preu no regulada.
                        </p>
                      %else: ## Es Canaries o Balears
                        <p>
                          Les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/">clàusules contractuals de les Condicions Generals</a> que ens autoritzen a fer aquests canvis de preus són la clàusula 5.3 (ii) per a les modificacions de la part del preu no regulada, i la clàusula 8.5 per la modificació del preu de compensació d'excedents.
                        </p>
                      % endif
                      <p>
                        % if data['modcon'] != "atr" and data['modcon'] != "index":
                          T'adjuntem en aquest correu el teu contracte actualitzat amb els canvis aplicats. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat,</strong> ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/">tarifa per períodes</a> (<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                        %else:
                          T'adjuntem en aquest correu el teu contracte actualitzat amb els canvis aplicats. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi et fes replantejar seguir amb aquesta tarifa, podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                        %endif
                      </p>
                      <p>
                        Una salutació cordial,
                      </p>
                      <p>
                      Equip de Som Energia <br/>
                      <a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a>
                      </p>

                    %else: ## CASTELLANO





                      % if data['modcon'] == "index":
                          <figure class="table">
                              <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                                  <tbody>
                                      <tr>
                                          <td>
                                              <p>
                                                <span style="font-weight: 400;text-align: left;">
                                                  Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Te informamos, pues, de un pequeño cambio que aplicaremos en la tarifa indexada a partir del 1 de agosto, y de una nueva opción disponible: la tendencia de precios para las próximas 24 horas.
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
                                                Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong> tarifa ${data['tarifa_acces']} periodos,</strong> que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} indexada, te explicamos más abajo los cambios que le aplicaremos a partir del 1 de agosto, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa indexada.
                                              </span>
                                            </p>
                                            <p>
                                              <span style="font-weight: 400;text-align: left;">
                                                En nuestra web puedes encontrar la nueva fórmula de cálculo de <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/">la tarifa indexada</a>. En resumen, aumenta ligeramente el margen del precio de la energía.
                                              </span>
                                            </p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </figure>
                      % endif
                      % if data['modcon'] != "atr" and data['modcon'] != "index":
                        %if not data['canaries'] and not data['balears']:
                          <p>
                            Te escribimos para contarte dos novedades respecto a la tarifa indexada que tienes contratada actualmente. Por un lado, estrenamos un nuevo apartado web donde podrás ver la tendencia de precios de las próximas 24 horas. Por otra parte, te informamos de un pequeño aumento en el margen de la viabilidad de la cooperativa, que forma parte del precio de tu tarifa indexada, y que aplicaremos a partir del 1 de agosto.
                          </p>
                        %else: ## Es Canaries o Balears
                          %if data['autoconsum']['compensacio']:
                            <p>
                              Te escribimos para contarte dos cambios respecto a la tarifa indexada que tienes contratada actualmente, y que aplicaremos a partir del 1 de agosto. Por un lado, aumentaremos ligeramente el margen de viabilidad de la cooperativa, que forma parte del precio de la tarifa indexada, y por otra parte modificaremos la fórmula que establece la compensación de excedentes de autoproducción.
                            </p>
                            <h1>Cambio del margen en la tarifa</h1>
                            <p>
                              Como te decíamos, a partir del 1 de agosto aplicaremos un <strong>pequeño aumento al margen de viabilidad</strong> de la tarifa indexada, para seguir garantizando la viabilidad de la cooperativa. A continuación tienes una versión resumida, por si no quieres dedicarle mucho tiempo, y más abajo encontrarás una versión más detallada, por si te interesa saber los detalles.
                            </p>
                          %else:
                            <p>
                              Te escribimos para explicarte que a partir del 1 de agosto aumentaremos ligeramente el margen de viabilidad de las tarifas indexadas, para seguir garantizando la viabilidad de la cooperativa. A continuación tienes una versión resumida, por si no quieres dedicarle mucho tiempo, y más abajo encontrarás una versión más detallada, por si te interesa saber los detalles.
                            </p>
                          %endif
                        %endif
                      % endif
                      %if not data['canaries'] and not data['balears']:
                        <h1>
                          Tendencia de precios para las próximas horas
                        </h1>
                        <p>
                          Recientemente hemos puesto en funcionamiento un apartado web en el que se puede ver la previsión de precios de energía de la indexada para las próximas 24 horas. Puedes ver, pues, la tendencia de precios para el día siguiente, y esto te puede ser útil para saber <strong>a qué horas la energía será más barata </strong> (es decir, cuándo conviene más, por ejemplo, poner la lavadora).
                        </p>
                        <img src="https://blog.somenergia.coop/wp-content/uploads/2024/06/Captura-web-24-CA.png" alt="GenerationDemo" width="550">
                        <br/><br/><br/>
                        <p>
                          Si bien los precios del apartado web no serán los definitivos (habrá que añadir un término que se publicará con posterioridad), sí dan una idea fiable de las horas más económicas y las más caras.
                        </p>
                        <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td align="center">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                <tr>
                                  <td align="center">
                                    <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/precio-hoy/" class="f-fallback button" target="_blank">Mira la página</a>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <h1>
                          Cambio del margen en la tarifa
                        </h1>
                        <p>
                          Por otra parte, te informamos que a partir del 1 de agosto aplicaremos un <strong>ligero aumento al margen de viabilidad</strong> de la tarifa indexada, para seguir garantizando la viabilidad de la cooperativa. A continuación tienes una versión resumida, por si no quieres dedicarle mucho tiempo, y más abajo encontrarás una versión más detallada, por si te interesa saber los detalles.
                        </p>
                      % endif
                      <h2>
                        Explicación resumida
                      </h2>
                      %if data['Indexada20TDPeninsula']:
                        <p>
                          En el caso de la tarifa 2.0TD indexado (la tuya), sin tener en cuenta el precio de la energía, a un contrato con un consumo medio de 2.500 kWh anuales, este cambio le supondría un <strong>aumento aproximado de unos 19 euros al año (un euro y medio al mes).</strong> Evidentemente, esta cifra cambiaría si variara el consumo, el precio de la energía u otros aspectos del mercado eléctrico.
                        </p>
                      %endif
                      %if data['Indexada30TDPeninsula']:
                        <p>
                          En el caso de la tarifa 3.0TD indexada (la tuya), sin tener en cuenta el precio de la energía, a un contrato con un consumo medio de 10.000 kWh anuales, este cambio le supondría un <strong>aumento aproximado de unos 58 euros al año.</strong> Evidentemente, esta cifra cambiaría si variara el consumo, el precio de la energía u otros aspectos del mercado eléctrico.
                        </p>
                      %endif
                      %if data['Indexada61TDPeninsula']:
                        <p>
                          En el caso de la tarifa 6.1TD indexada (la tuya), sin tener en cuenta el precio de la energía, a un contrato con un consumo medio de 15.000 kWh anuales, este cambio le supondría un <strong>aumento aproximado de unos 79 euros al año.</strong> Evidentemente, esta cifra cambiaría si variara el consumo, el precio de la energía u otros aspectos del mercado eléctrico.
                        </p>
                      %endif
                      %if data['Indexada30TDVEPeninsula']:
                        <p>
                          En el caso de la tarifa 3.0TDVE indexada (la tuya), sin tener en cuenta el precio de la energía, a un contrato con un consumo medio de 10.000 kWh anuales, este cambio le supondría un <strong>aumento aproximado de unos 58 euros al año.</strong> Evidentemente, esta cifra cambiaría si variara el consumo, el precio de la energía u otros aspectos del mercado eléctrico.
                        </p>
                      %endif
                      %if data['Indexada20TDCanaries'] or data['Indexada20TDBalears']:
                        <p>
                          En el caso de la tarifa 2.0TD indexada (la tuya), sin tener en cuenta el precio de la energía ni la autoproducción, a un contrato con un consumo medio, de 2.500 kWh anuales, este cambio le supondría un <strong>aumento aproximado de unos 19 euros anuales (poco más de un euro y medio al mes)</strong>. Evidentemente, esta cifra cambiaría si variara el consumo, el precio de la energía u otros aspectos del mercado eléctrico.
                        </p>
                      %endif
                      %if data['Indexada30TDCanaries'] or data['Indexada30TDBalears']:
                        <p>
                          En el caso de la tarifa 3.0TD indexada (la tuya), sin tener en cuenta el precio de la energía ni la autoproducción, a un contrato con un consumo medio de 10.000 kWh anuales, este cambio le supondría un <strong>aumento aproximado de unos 58 euros anuales</strong>. Evidentemente, esta cifra cambiaría si variara el consumo, el precio de la energía u otros aspectos del mercado eléctrico.
                        </p>
                      %endif
                      %if not data['canaries'] and not data['balears']:
                        <p>
                          Ésta es la información básica, resumida. Si tienes curiosidad y quieres saber más detalles del cambio, a continuación te los explicamos. Como siempre, puedes encontrar los precios en el<a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/">apartado de tarifas</a> de la web.
                        </p>
                      %else: ## Es Canaries o Balears
                        <p>
                          Esta es la información básica, resumida. Si tienes curiosidad y quieres saber más detalles del cambio, a continuación te los explicamos.
                        </p>
                      % endif
                      <h2>Explicación detallada de los cambios</h2>
                      <h3 style="margin-top: 20px;">Cambios en la fórmula del cálculo del precio de la energía</h3>
                      <p>
                        Como quizás ya sabes, la tarifa indexada obtiene el precio de la energía a partir de una fórmula, que incluye el coste de la energía en el mercado mayorista, e incluye también otros conceptos (peajes, cargos…) que deben pagarse para poder consumir energía.
                      </p>
                      <p>
                        Uno de los componentes de la fórmula es la “F”, la franja de la cooperativa. Hasta ahora, dentro de este concepto incluíamos el margen para la viabilidad de la cooperativa, más los costes de los Certificados de Garantía de Origen 100% renovable (GdO) y los costes de las desviaciones. A partir del 1 de agosto, la “F” contendrá únicamente el margen para la viabilidad de la cooperativa. Los Certificados de Garantía de Origen y los costes de las desviaciones seguirán formando parte de la fórmula, pero en unos conceptos separados de la franja.
                      </p>
                      <p>
                        La nueva fórmula, pues, será la siguiente:
                      </p>
                      <p>
                        <strong style="font-size: 14px; text-align: center">
                          PH = 1,015 × [(PHM + Pc + Sc + <span style="color:#c68c43">Dsv</span> + <span style="color:#c68c43">GdO</span> + P<sub style="font-size: 9px;">OsOm</sub>) (1 + Perd) + FE + F] + PTD + CA
                        </strong>
                      </p>
                      <p>
                        (En <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#formula-indexada">nuestra web</a> puedes ver a qué corresponde cada término.)
                      </p>
                      <p>
                        El importe de los certificados de garantía (en la fórmula: <span style="color:#c68c43;font-weight:bold;">GdO</span>)  de los costes de las desviaciones (<span style="color:#c68c43;font-weight:bold;">Dsv</span>) se irá calculando en función de lo que cuesten estos conceptos, y se publicará en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">apartado web de tarifas</a>.
                      </p>
                      <p>
                        El importe de <strong>la franja (F)</strong> que ahora será únicamente el margen, <strong>será de ${data['dades_index']['f_nova']}</strong>.
                      </p>
                      <img src="https://blog.somenergia.coop/wp-content/uploads/2024/06/Captura-web-24-CA.png" alt="GenerationDemo" width="550">
                      <br/><br/>
                      <p>
                        Los precios de la potencia, en este caso, no han cambiado. Los puedes encontrar en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">apartado web de tarifas</a>.
                      </p>
                      <h3>Estimación orientativa</h3>
                      <p>
                        Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> del coste de la electricidad con este aumento del margen, y lo hemos comparado con el coste con la actual tarifa. La estimación la hemos hecho en base a un usuario/a medio, con un contrato estándar, de un consumo tipo, de ${data['dades_index']['conany']} kWh anuales, y sin tener autoproducción ni Generation kWh, ni alquiler de contador.
                      </p>
                      <p>
                        En ambos casos la estimación incluye el ${data['impostos_str']} y el impuesto eléctrico del ${data['dades_index']['ie']}%.
                      </p>
                      <p>
                        Así pues, te mostramos a continuación la estimación aproximada del coste anual si aplicáramos los precios actuales, y el coste anual si aplicáramos los nuevos precios.
                      </p>
                      <h3>
                        Coste anual estimado (euros/año)
                      </h3>
                      <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                        <tr>
                          <td colspan="3">
                            <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td class="purchase_borders" style="vertical-align: center;" align="left">
                                  <p class="f-fallback"  style="margin: 10px 0"></p>
                                </td>
                                <td class="purchase_borders" style="vertical-align: center;" align="left">
                                  <p class="f-fallback"  style="margin: 10px 0"><strong>Coste estimado con los nuevos precios</strong></p>
                                </td>
                                <td class="purchase_borders" style="vertical-align: center;" align="left">
                                  <p class="f-fallback" style="margin: 10px 0"><strong>Coste estimado con los precios actuales</strong></p>
                                </td>
                              </tr>
                              <tr>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback"  style="margin: 10px 0">Antes de impuestos</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_nova']}</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_antiga']}</p>
                                </td>
                              </tr>
                              <tr>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="margin: 10px 0">Después de impuestos</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_nova_amb_impost']}</p>
                                </td>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['dades_index']['import_total_anual_antiga_amb_impost']}</p>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                      <br/>
                      <p>
                        Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente hagas, otras variaciones de precios durante el año, o cambios que puedan producirse en el mercado eléctrico.
                      </p>
                      %if not data['canaries'] and not data['balears']:
                        <p>
                          Como siempre, puedes encontrar la información, precios y fórmula de la tarifa indexada en nuestra web, <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/">apartado tarifa indexada</a>, y en el <a href="https://es.support.somenergia.coop/category/1361-las-tarifas-indexadas">Centro de Ayuda</a>. También hemos publicado <a href="https://blog.somenergia.coop/?p=48070">una noticia en el blog</a> que explica ese cambio.
                        </p>
                      %else: ## Es Canaries o Balears
                        %if data['autoconsum']['compensacio']:
                          <h1>Cambio del cálculo de compensación de los excedentes</h1>
                          <p>
                            Por otra parte, aplicaremos también un cambio en el precio de compensación de los excedentes de Baleares y Canarias. En las tarifas indexadas compensamos los excedentes al mismo precio al que nos los paga Red Eléctrica a Som Energia. No añadimos margen ni comisiones. Para seguir haciéndolo así, como Red Eléctrica paga los excedentes a precio de mercado insular y le resta el precio de un término llamado Sph Auto, también debemos restar este término a la fórmula de compensación de excedentes de Som Energia. Esto supondrá una <strong>pequeña disminución del precio de compensación</strong>.
                          </p>
                          <p>
                            Recuerde que la forma de sacar más provecho de las instalaciones de autoproducción es utilizando la energía en el mismo momento en que se genera.
                          </p>
                        %endif
                      %endif
                      <h2>Información legal</h2>
                      %if not data['canaries'] and not data['balears']:
                        <p>
                          La <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/#precio-y-actualizacion">cláusula contractual de las Condiciones Generales</a> que nos autoriza a realizar este cambio de precios es la cláusula 5.3 (ii) para las modificaciones de la parte del precio no regulada.
                        </p>
                      %else: ## Es Canaries o Balears
                        <p>
                          Las <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/">cláusulas contractuales de las Condiciones Generales</a> que nos autorizan a hacer estos cambios de precios son la cláusula 5.3 (ii) para las modificaciones de la parte del precio no regulada, y la cláusula 8.5 por la modificación del precio de compensación de excedentes.
                        </p>
                      % endif
                      <p>
                        % if data['modcon'] != "atr" and data['modcon'] != "index":
                          Te adjuntamos en este correo tu contrato actualizado con los cambios aplicados. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos informarte de que si, por alguna razón, este cambio te hiciese replantear seguir con esta tarifa, podrías cambiarte a la <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/">tarifa por períodos</a> (<a href="https://es.support.somenergia.coop/article/1345-modificacion-de-la-tarifa-de-periodos-a-indexada-y-de-indexada-a-periodos?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">a través de tu Oficina Virtua</a>), o podrías dar de baja tu contrato con nosotros, bien comunicándolo directamente, o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejamos de suministrarte energía, con los precios vigentes en cada momento.
                        %else:
                          T'adjuntem en aquest correu el teu contracte actualitzat amb els canvis aplicats. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi et fes replantejar seguir amb aquesta tarifa, podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                        %endif
                      </p>
                      <p>
                        Un cordial saludo,
                      </p>
                      <p>
                      Equipo de Som Energia <br/>
                      <a href="https://www.somenergia.coop/es">www.somenergia.coop</a>
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