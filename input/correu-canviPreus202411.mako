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
                          <p>
                            L'1 de novembre actualitzarem el preu de l'electricitat de les tarifes per períodes (la que tens ara, ho és). Després de les baixades de l'any passat i d'aquest any, aplicarem un petit augment de preus. El cost de l'energia al mercat majorista ha pujat, i les previsions per als propers mesos indiquen que seguirà a l'alça; és per això que ho hem de reflectir a les nostres tarifes, que se situaran a valors similars de gener de 2024.
                          </p>
                        % endif
                        %if data['iva_reduit']:
                          <h1>
                            L'IVA segueix al 10%
                          </h1>
                          <p>
                            Segons estableix el <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Reial decret llei 8/2023</a> fins al 31 de desembre l'IVA de l'electricitat seguirà rebaixat al 10% a no ser que el preu de lenergia baixi molt. Si baixa molt (si la mitjana mensual del preu de l'energia al mercat diari és inferior a 45 euros/MWh), l'IVA a aplicar serà del 21%.
                          </p>
                        % endif
                      <h1>
                        Nous preus i comparativa amb preus actuals
                      </h1>
                      <p>
                        A continuació tens una taula amb els nous preus (vigents a partir de l'1 de novembre), i una comparació amb els preus actuals (fins a 31 d'octubre) de la tarifa que tens contractada. Els impostos aplicats són ${data['impostos_str']}, i l'impost elèctric del 5,11%.
                      </p>
                      %if data['Periodes20TDPeninsula']:
                        <h1>
                          Tarifa 2.0TD períodes
                        </h1>
                        <h2>
                          Preu del terme d'energia (en euros/kWh)
                        </h2>
                        <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td colspan="3">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td colspan="3" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"><strong>Nous preus</strong></p>
                                  </td>
                                  <td colspan="3" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback" style="margin: 10px 0"><strong>Preus actuals</strong></p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Període punta</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Període pla</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Període vall</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Període punta</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Període pla</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Període vall</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="margin: 10px 0">Sense impostos</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous']['te']['P1']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous']['te']['P2']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous']['te']['P3']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics']['te']['P1']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics']['te']['P2']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics']['te']['P3']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="margin: 10px 0">Amb impostos</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_imp']['te']['P1']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_imp']['te']['P2']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_imp']['te']['P3']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_imp']['te']['P1']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_imp']['te']['P2']}</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_imp']['te']['P3']}</p>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <p>
                          El preu de la potència no ha variat, segueix sent <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#ambit-domestic">el que ja hi havia.</a>
                        </p>
                      %endif
                      %if data['autoconsum']['compensacio']:
                        <h1>Autoproducció</h1>
                        <p>
                          Per als contractes que teniu autoproducció amb compensació simplificada, els excedents d'autoproducció els continuarem compensant al mateix valor de referència del cost de l'energia que fem servir per calcular el preu de venda. A diferència de la mitjana de cost general, que ha pujat, <strong>la mitjana de cost de l'energia en hores de producció fotovoltaica ha baixat.</strong> És per això que hem disminuït també el preu de la compensació d'excedents. T'ho expliquem en detall al <a href="https://blog.somenergia.coop/?p=48550">blog</a>.
                        </p>
                        <h2>Preu de compensació d'excedents d'autoproducció (en euros/kWh)</h2>
                        <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td colspan="3">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"><strong>Nous preus</strong></p>
                                  </td>
                                  <td class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback" style="margin: 10px 0"><strong>Preus actuals</strong></p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Sense impostos aplicats</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_nou']}</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_antic']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="margin: 10px 0">Amb impostos aplicats</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_nou_imp']}</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_antic_imp']}</p>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <p>
                          Et recordem que també tens activat el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats/">Flux Solar</a>, que proporciona descomptes per als excedents que no poden ser compensats amb la compensació simplificada. Pots veure si tens Sols disponibles a la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a> (<a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar#sols">aquí</a> t'expliquem el camí). Si és el cas, se t'aniran aplicant a les properes factures.
                        </p>
                      %endif
                      %if data['origen'] == 'pdf':
                        <h1>Estimació</h1>
                        <p>
                          Tal com estableix la normativa, hem fet <strong>una estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, si apliquéssim els preus actuals i si apliquéssim els preus nous. L'estimació l'hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i sense autoproducció, ni Generation kWh, ni lloguer de comptador.
                        </p>
                        <p>
                          L'estimació la pots veure sense impostos i amb impostos inclosos, els vigents actualment (${data['impostos_str']} i l'impost elèctric del 5,11%).
                        </p>
                        <h2>Cost anual estimat, en euros/any, del subministrament (energia i potència):</h2>
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
                                    <p class="f-fallback"  style="margin: 10px 0">Sense impostos aplicats</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_nou']}</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_vell']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="margin: 10px 0">Amb impostos aplicats</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_nou_imp']}</p>
                                  </td>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_vell_imp']}</p>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <p>
                          Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i la'ús d'energia que finalment facis, altres variacions de preus durant l'any, o canvis que hi pugui haver al mercat elèctric.
                        </p>
                      %endif
                      <p>
                        Al nostre blog trobaràs <a href="https://blog.somenergia.coop/?p=48546">l'article del canvi de tarifes</a>, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l'apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 d'octubre i els de períodes anteriors.
                      </p>

                      <h2>Informació legal</h2>
                      <p>
                        La <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus és la clàusula 5.3 (ii).
                      </p>
                      <p>
                        Pots accedir al comparador d'ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través <a href="https://comparador.cnmc.gob.es">d'aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents d'algunes de les comercialitzadores del mercat lliure. Tingues en compte que les tarifes de Som Energia no hi estan incloses.
                      </p>
                      <p>
                        T'adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">tarifa indexada</a> (<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé <a href="https://drive.google.com/file/d/1t2VBo0c-Yr2FSltmzVegqJdQ1dZsuOOV/view">comunicant-nos-ho directament</a>, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                      </p>

                      <p>
                        Una salutació cordial,
                      </p>
                      <p>
                      Equip de Som Energia <br/>
                      <a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a>
                      </p>

                    %else: ## CASTELLANO

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