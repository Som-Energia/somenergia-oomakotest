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
                                                    <p>
                                                      Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 de novembre, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.
                                                    </p>
                                                    <p>
                                                      <strong>La tarifa ${data['tarifa_acces']} indexada no canvia.</strong> Al nostre web pots trobar, com sempre, els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada"> preus de la tarifa indexada</a>.
                                                    </p>
                                                  </span>
                                                </p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </figure>
                            <h1>
                              Canvis de preus de la tarifa ${data['tarifa_acces']} períodes
                            </h1>
                        % elif data['modcon'] == "atr":
                          <figure class="table">
                              <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                                  <tbody>
                                      <tr>
                                          <td>
                                              <p>
                                                <span style="font-weight: 400;text-align: left;">
                                                  <p>
                                                    Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} períodes,</strong> que s'hauria de produir a les pròximes setmanes. A la tarifa per períodes li aplicarem un canvi de preus lleugerament a l'alça a partir de l'1 de novembre. Te n'informem a continuació.
                                                  </P>
                                                  <p>
                                                    La tarifa indexada (que et serà d'aplicació mentre no se t'activi el canvi) no té cap actualització per part de Som Energia. Com saps, el preu final canvia cada dia i cada hora en funció del preu diari de l'energia al mercat majorista.
                                                  </p>
                                                  <p>
                                                    Al nostre web pots trobar els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#opcions-de-la-tarifa-periodes"> preus de les tarifes per períodes</a> que aplicarem <strong>a partir de l'1 de novembre</strong> i els de <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">les tarifes indexades</a>. També pots veure, a l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/historic-de-tarifes/">apartat històric</a>, els preus anteriors a 1 de novembre de 2024.
                                                  </p>
                                                </span>
                                              </p>
                                          </td>
                                      </tr>
                                  </tbody>
                              </table>
                          </figure>
                          <h1>
                            Canvis de preus de la tarifa ${data['tarifa_acces']} períodes
                          </h1>
                          <p>
                            L'1 de novembre actualitzarem el preu de l'electricitat de les tarifes per períodes. Com potser ja has notat estant a la tarifa indexada, el cost de l'energia al mercat majorista ha pujat, i les previsions per als propers mesos indiquen que seguirà a l'alça; és per això que ho hem de reflectir a les nostres tarifes per períodes amb un petit augment de preus.
                          </p>
                        % endif
                        % if data['modcon'] != "atr":
                          <p>
                            L'1 de novembre actualitzarem el preu de l'electricitat de les tarifes per períodes (la que tens ara, ho és). Després de les baixades de l'any passat i d'aquest any, aplicarem un petit augment de preus. El cost de l'energia al mercat majorista ha pujat, i les previsions per als propers mesos indiquen que seguirà a l'alça; és per això que ho hem de reflectir a les nostres tarifes, que se situaran a valors similars de gener de 2024.
                          </p>
                        % endif
                        %if data['iva_reduit']:
                          <h3>
                            L'IVA segueix al 10%
                          </h3>
                          <p>
                            Segons estableix el <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Reial decret llei 8/2023</a>, fins al 31 de desembre l'IVA de l'electricitat seguirà rebaixat al 10% a no ser que el preu de l'energia baixi molt. Si baixa molt (si la mitjana mensual del preu de l'energia al mercat diari és inferior a 45 euros/MWh), l'IVA a aplicar serà del 21%.
                          </p>
                        % endif
                      <h1>
                        Nous preus i comparativa amb preus actuals
                      </h1>
                      <p>
                        A continuació tens una taula amb els nous preus (vigents a partir de l'1 de novembre), i una comparació amb els preus actuals (fins a 31 d'octubre) de la tarifa que tens contractada. Els impostos aplicats són ${data['impostos_str']}, i l'impost elèctric del 5,11%.
                      </p>
                      %if data['Periodes20TDPeninsula'] or data['Periodes20TDCanaries'] or data['Periodes20TDBalears']:
                        <h1>
                          Tarifa 2.0TD períodes
                        </h1>
                        <h3>
                          Preu del terme d'energia (en euros/kWh)
                        </h3>
                        <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td colspan="3">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td colspan="3" class="purchase_borders" style="vertical-align: center;">
                                    <p class="f-fallback"  style="text-align: center; margin: 10px 0"><strong>Nous preus</strong></p>
                                  </td>
                                  <td colspan="3" class="purchase_borders" style="vertical-align: center;">
                                    <p class="f-fallback" style="text-align: center; margin: 10px 0"><strong>Preus actuals</strong></p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"   style="margin: 10px 0; font-size: 14">Període punta</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Període pla</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Període vall</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Període punta</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Període pla</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Període vall</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="margin: 10px 0; font-size: 14">Sense impostos</p>
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
                                    <p class="f-fallback" style="margin: 10px 0; font-size: 14">Amb impostos</p>
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
                      %if data['Periodes30TDPeninsula'] or data['Periodes30TDCanaries'] or data['Periodes30TDBalears'] or data['Periodes61TDPeninsula'] or data['Periodes61TDCanaries'] or data['Periodes61TDBalears'] or data['Periodes30TDVEPeninsula']:
                        <h1>Tarifa ${data['tarifa_acces']} períodes</h1>
                        <h3>Preu del terme d'energia (en euros/kWh)</h3>
                        <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td colspan="4">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">

                                <tr>
                                  <td width="25%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td width="10%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td width="32.5%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"><strong>Sense impostos aplicats</strong></p>
                                  </td>
                                  <td width="32.5%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback" style="margin: 10px 0"><strong>Amb impostos aplicats</strong></p>
                                  </td>
                                </tr>

                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0;"><strong>Nous preus</strong></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P1</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P1']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P1']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P2</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P2']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P2']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left;border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P3</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P3']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P3']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P4</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P4']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P4']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P5</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P5']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P5']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P6</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P6']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P6']}</p>
                                  </td>
                                </tr>

                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0;"><strong>Preus actuals</strong></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P1</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P1']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P1']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P2</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P2']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P2']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left;border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P3</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P3']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P3']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P4</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P4']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P4']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P5</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P5']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P5']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P6</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P6']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P6']}</p>
                                  </td>
                                </tr>

                              </table>
                            </td>
                          </tr>
                        </table>
                        <p>
                          El preu de la potència no ha variat, segueix sent <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#tarifa30TD">el que ja hi havia</a>.
                        </p>


                      %endif
                      %if data['autoconsum']['compensacio']:
                        <h2>Autoproducció</h2>
                        <p>
                          Per als contractes que teniu autoproducció amb compensació simplificada, els excedents d'autoproducció els continuarem compensant al mateix valor de referència del cost de l'energia que fem servir per calcular el preu de venda. A diferència de la mitjana de cost general, que ha pujat, <strong>la mitjana de cost de l'energia en hores de producció fotovoltaica ha baixat.</strong> És per això que hem disminuït també el preu de la compensació d'excedents. T'ho expliquem en detall al <a href="https://blog.somenergia.coop/?p=48550">blog</a>.
                        </p>
                        <h3>Preu de compensació d'excedents d'autoproducció (en euros/kWh)</h3>
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
                      <h1>Estimació</h1>
                      %if data['origen'] == 'pdf':
                        <p>
                          Tal com estableix la normativa, hem fet <strong>una estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, si apliquéssim els preus actuals i si apliquéssim els preus nous. L'estimació l'hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i sense autoproducció, ni Generation kWh, ni lloguer de comptador.
                        </p>
                      %elif data['origen'] == 'cnmc':
                        <p>
                          Tal com estableix la normativa, hem fet <strong>una estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L'estimació l'hem fet a partir de les dades que tenim dels teus consums anteriors (sense tenir en compte autoproducció ni Generation kWh ni lloguer de comptador), extrapolant-les segons el consum mitjà que sol haver-hi a cada mes (segons dades de la Comissió Nacional dels Mercats i la Competència). Amb això n'hem obtingut un consum anual, que és el que fem servir per a la comparació.
                        </p>
                      %elif data['origen'] == 'estadistic':
                        <p>
                          Tal com estableix la normativa, hem fet <strong>una estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L'estimació l'hem fet en funció de la potència contractada més alta que tens (${data['potencia']} kW), l'ús d'electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense autoproducció ni Generation kWh ni lloguer de comptador.
                        </p>
                      %endif
                      <p>
                        L'estimació la pots veure sense impostos i amb impostos inclosos, els vigents actualment (${data['impostos_str']} i l'impost elèctric del 5,11%).
                      </p>
                      <h3>Cost anual estimat, en euros/any, del subministrament (energia i potència):</h3>
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
                      <br/>
                      <p>
                        Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l'ús d'energia que finalment facis, altres variacions de preus durant l'any, o canvis que hi pugui haver al mercat elèctric.
                      </p>
                      <p>
                        Al nostre blog trobaràs <a href="https://blog.somenergia.coop/?p=48546">l'article del canvi de tarifes</a>, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l'apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 d'octubre i els de períodes anteriors.
                      </p>

                      <h3>Informació legal</h3>
                      <p style="font-size: 10">
                        La <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus és la clàusula 5.3 (ii).
                      </p>
                      <p style="font-size: 10">
                        Pots accedir al comparador d'ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través <a href="https://comparador.cnmc.gob.es">d'aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents d'algunes de les comercialitzadores del mercat lliure. Tingues en compte que les tarifes de Som Energia no hi estan incloses.
                      </p>
                      % if data['modcon'] == "atr" or data['modcon'] == "index":
                        <p style="font-size: 10">
                          Després d'haver-te compartit aquesta informació, si aquest canvi de preus et fes replantejar seguir amb la modificació sol·licitada, podries demanar que s'aturi la modificació de tarifa (escrivint-nos a <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a>) o bé podries donar de baixa el teu contracte amb nosaltres, bé <a href="https://drive.google.com/file/d/1t2VBo0c-Yr2FSltmzVegqJdQ1dZsuOOV/view">comunicant-nos-ho directament</a>, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                        </p>
                      %else:
                        <p style="font-size: 10">
                          T'adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">tarifa indexada</a> (<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé <a href="https://drive.google.com/file/d/1t2VBo0c-Yr2FSltmzVegqJdQ1dZsuOOV/view">comunicant-nos-ho directament</a>, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                        </p>
                      %endif
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
                                                <p>
                                                  Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} periodos,  te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de noviembre, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa periodos.
                                                </p>
                                                <p>
                                                  <strong>La tarifa ${data['tarifa_acces']} indexada no cambia.</strong> En nuestra web puedes encontrar, como siempre, los <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">precios de la tarifa indexada</a>.
                                                </p>
                                              </span>
                                            </p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </figure>
                        <h1>
                          Cambios de precios de la tarifa ${data['tarifa_acces']} periodos
                        </h1>
                      % elif data['modcon'] == "atr":
                        <figure class="table">
                            <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                                <tbody>
                                    <tr>
                                        <td>
                                            <p>
                                              <span style="font-weight: 400;text-align: left;">
                                                <p>
                                                  Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} periodos,</strong> que debería producirse en las próximas semanas. A la tarifa por periodos le aplicaremos un cambio de precios ligeramente al alza a partir del 1 de noviembre. Te informamos a continuación.
                                                </p>
                                                <p>
                                                  La tarifa indexada (que te será de aplicación mientras no se te active el cambio) no tiene ninguna actualización por parte de Som Energia. Como sabes, el precio final cambia todos los días y cada hora en función del precio diario de la energía en el mercado mayorista.
                                                </p>
                                                <p>
                                                  En nuestra web puedes encontrar los <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#opciones-de-la-tarifa-por-periodos">precios de las tarifas por periodos</a> que aplicaremos <strong>desde el 1 de noviembre</strong> y los de <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">las tarifas indexadas</a>. También puedes ver, en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">apartado histórico</a>, los precios anteriores a 1 de noviembre de 2024.
                                                </p>
                                              </span>
                                            </p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </figure>
                        <h1>
                          Cambios de precios de la tarifa ${data['tarifa_acces']} periodos
                        </h1>
                        <p>
                          El 1 de noviembre actualizaremos el precio de la electricidad de las tarifas por periodos. Como quizás ya has notado estando en la tarifa indexada, el coste de la energía en el mercado mayorista ha subido, y las previsiones para los próximos meses indican que seguirá al alza; es por eso que debemos reflejarlo en las nuestras tarifas por periodos con un pequeño aumento de precios.
                        </p>
                      % endif
                      % if data['modcon'] != "atr":
                        <p>
                          El 1 de noviembre actualizaremos el precio de la electricidad de las tarifas por periodos (la que tienes ahora, lo es). Después de las bajadas del año pasado y este año, aplicaremos un pequeño aumento de precios. El coste de la energía en el mercado mayorista ha subido, y las previsiones para los próximos meses indican que seguirá al alza; es por eso que debemos reflejarlo en nuestras tarifas, que se situarán a valores similares de enero de 2024.
                        </p>
                      % endif
                      %if data['iva_reduit']:
                        <h3>
                          El IVA sigue al 10%
                        </h3>
                        <p>
                          Según establece el <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Real decreto ley 8/2023</a>, hasta el 31 de diciembre el IVA de la electricidad seguirá rebajado al 10% a menos que el precio de la energía baje mucho. Si baja mucho (si la media mensual del precio de la energía en el mercado diario es inferior a 45 euros/MWh), el IVA a aplicar será del 21%.
                        </p>
                      % endif
                      <h1>
                        Nuevos precios y comparativa con precios actuales
                      </h1>
                      <p>
                        A continuación tienes una tabla con los nuevos precios (vigentes a partir del 1 de noviembre) y una comparación con los precios actuales (hasta 31 de octubre) de la tarifa que tienes contratada. Los impuestos aplicados son ${data['impostos_str']}, y el impuesto eléctrico del 5,11%.
                      </p>

                      %if data['Periodes20TDPeninsula'] or data['Periodes20TDCanaries'] or data['Periodes20TDBalears']:
                        <h1>
                          Tarifa 2.0TD periodos
                        </h1>
                        <h3>
                          Precio del término de energía (en euros/kWh)
                        </h3>
                        <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td colspan="3">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td colspan="3" class="purchase_borders" style="vertical-align: center;">
                                    <p class="f-fallback"  style="text-align: center; margin: 10px 0"><strong>Nuevos precios</strong></p>
                                  </td>
                                  <td colspan="3" class="purchase_borders" style="vertical-align: center;">
                                    <p class="f-fallback" style="text-align: center; margin: 10px 0"><strong>Precios actuales</strong></p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Periodo punta</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Periodo llano</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Periodo valle</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Periodo punta</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Periodo llano</p>
                                  </td>
                                  <td width="14%" class="purchase_borders" style="vertical-align: left;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0; font-size: 14">Periodo valle</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback" style="margin: 10px 0; font-size: 13">Sin impuestos</p>
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
                                    <p class="f-fallback" style="margin: 10px 0; font-size: 13">Con impuestos</p>
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
                          El precio de la potencia no ha variado, sigue siendo <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#opciones-de-la-tarifa-por-periodos">el que ya había</a>
                        </p>
                      %endif

                      %if data['Periodes30TDPeninsula'] or data['Periodes30TDCanaries'] or data['Periodes30TDBalears'] or data['Periodes61TDPeninsula'] or data['Periodes61TDCanaries'] or data['Periodes61TDBalears'] or data['Periodes30TDVEPeninsula']:
                        <h1>Tarifa ${data['tarifa_acces']} periodos</h1>
                        <h3>Precio del término de energía (en euros/kWh)</h3>
                        <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td colspan="4">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">

                                <tr>
                                  <td width="27%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td width="10%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td width="31.5%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"><strong>Sin impuestos aplicados</strong></p>
                                  </td>
                                  <td width="31.5%" class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback" style="margin: 10px 0"><strong>Con impuestos aplicados</strong></p>
                                  </td>
                                </tr>

                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0;"><strong>Nuevos precios</strong></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P1</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P1']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P1']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P2</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P2']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P2']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left;border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P3</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P3']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P3']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P4</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P4']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P4']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P5</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P5']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P5']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P6</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P6']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P6']}</p>
                                  </td>
                                </tr>

                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0;"><strong>Precios actuales</strong></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P1</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P1']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P1']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P2</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P2']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P2']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left;border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P3</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P3']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P3']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P4</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P4']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P4']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none; border-bottom: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P5</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P5']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P5']}</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: left; border-top: none;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">P6</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P6']}</p>
                                  </td>
                                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P6']}</p>
                                  </td>
                                </tr>

                              </table>
                            </td>
                          </tr>
                        </table>
                        <p>
                          El precio de la potencia no ha variado, sigue siendo <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#opciones-de-la-tarifa-por-periodos">el que ya había</a>.
                        </p>
                      %endif

                      %if data['autoconsum']['compensacio']:
                        <h2>Autoproducción</h2>
                        <p>Para los contratos que tenéis autoproducción con compensación simplificada, los excedentes de autoproducción los seguiremos compensando al mismo valor de referencia del coste de la energía que utilizamos para calcular el precio de venta. A diferencia de la media de coste general, que ha subido, <strong>la media de coste de la energía en horas de producción fotovoltaica ha bajado.</strong> Por eso hemos disminuido también el precio de la compensación de excedentes. Te lo explicamos en detalle en el <a href="https://blog.somenergia.coop/?p=48552">blog</a>.
                        </p>
                        <h3>Precio de compensación de excedentes de autoproducción (en euros/kWh)</h3>
                        <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td colspan="3">
                              <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"></p>
                                  </td>
                                  <td class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback"  style="margin: 10px 0"><strong>Nuevos precios</strong></p>
                                  </td>
                                  <td class="purchase_borders" style="vertical-align: center;" align="left">
                                    <p class="f-fallback" style="margin: 10px 0"><strong>Precios actuales</strong></p>
                                  </td>
                                </tr>
                                <tr>
                                  <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                    <p class="f-fallback"  style="margin: 10px 0">Sin impuestos aplicados</p>
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
                                    <p class="f-fallback" style="margin: 10px 0">Con impuestos aplicados</p>
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
                          Te recordamos que también tienes activado el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-la-herramienta-que-proporciona-descuentos-por-los-excedentes-de-autoproduccion-no-compensados/">Flux Solar</a>, que proporciona descuentos para los excedentes que no pueden compensarse con la compensación simplificada. Puedes ver si tienes Sols disponibles en tu <a href="https://oficinavirtual.somenergia.coop/es">Oficina Virtual</a> (<a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar#sols">aquí</a> te explicamos el camino). Si es el caso, se te irán aplicando en las próximas facturas.
                        </p>
                      %endif

                      <h1>Estimación</h1>
                      %if data['origen'] == 'pdf':
                        <p>
                          Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, si aplicáramos los precios actuales y si aplicáramos los precios nuevos. La estimación la hemos hecho a partir de los datos que tenemos respecto a lo consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, y sin autoproducción, ni Generation kWh, ni alquiler de contador.
                        </p>
                      %elif data['origen'] == 'cnmc':
                        <p>
                          Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho a partir de los datos que tenemos de tus consumos anteriores (sin tener en cuenta autoproducción ni Generation kWh ni alquiler de contador), extrapolándolas según el consumo medio que suele haber en cada mes (según datos de la Comisión Nacional de los Mercados y la Competencia). Con esto hemos obtenido un consumo anual, que es el que utilizamos para la comparación.
                        </p>
                      %elif data['origen'] == 'estadistic':
                        <p>
                          Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho en función de la potencia contratada más alta que tienes (${data['potencia']} kW), el uso de electricidad que suele haber con esta potencia y cogiendo de referencia un contrato estándar, sin autoproducción ni Generation kWh ni alquiler de contador.
                        </p>
                      %endif
                      <p>
                        La estimación la puedes ver sin impuestos y con impuestos incluidos, los vigentes actualmente (${data['impostos_str']} y el impuesto eléctrico del 5,11%).
                      </p>


                      <h3>Coste anual estimado, en euros/año, del suministro (energía y potencia):</h3>
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
                                  <p class="f-fallback" style="margin: 10px 0"><strong>Coste estimado con los precios actuales </strong></p>
                                </td>
                              </tr>
                              <tr>
                                <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                                  <p class="f-fallback"  style="margin: 10px 0">Sin impuestos aplicados</p>
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
                                  <p class="f-fallback" style="margin: 10px 0">Con impuestos aplicados</p>
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
                      <br/>
                      <p>
                        Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente hagas, otras variaciones de precios durante el año, o cambios que pueda haber en el mercado eléctrico.
                      </p>
                      <p>
                        En nuestro blog encontrarás <a href="https://blog.somenergia.coop/?p=48548">el articulo del cambio de tarifas</a>, y en la página web puedes consultar en cualquier momento <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">todas las tarifas</a>.  Si quieres hacer comparaciones, puedes acceder al apartado <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde están también los precios vigentes hasta el 31 de octubre y los de periodos anteriores.
                      </p>
                      <h3>Información legal</h3>
                      <p style="font-size: 10">
                        La <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/">cláusula contractual de las Condiciones Generales</a> que nos autoriza a realizar este cambio de precios es la cláusula 5.3 (ii).
                      </p>
                      <p style="font-size: 10">
                        Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a href="https://comparador.cnmc.gob.es">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de algunas de las comercializadoras del mercado libre. Ten en cuenta que las tarifas de Som Energia no están incluidas.
                      </p>
                      % if data['modcon'] == "atr" or data['modcon'] == "index":
                        <p style="font-size: 10">
                          Después de haberte compartido esta información, si este cambio de precios te hiciese replantear seguir con la modificación solicitada, podrías pedir que se pare la modificación de tarifa (escribiéndonos a <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a>) o bien podrías dar de baja tu contrato con nosotros, bueno <a href="https://drive.google.com/file/d/1YU78O8Fpr_Xcns3BepvDKlp-cRi1Utid/view?usp=sharing">comunicándonoslo directamente</a>, o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejáramos de suministrarte energía, con los precios vigentes en cada momento.
                        </p>
                      %else:
                        <p style="font-size: 10">
                          Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos informarte de que si, por alguna razón, este cambio de precios te hiciese replantear seguir con esta tarifa, podrías cambiarte a la <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/">tarifa indexada</a> (<a href="https://es.support.somenergia.coop/article/1345-modificacion-de-la-tarifa-de-periodos-a-indexada-y-de-indexada-a-periodos?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">a través de la teva Oficina Virtual</a>), o podrías dar de baja tu contrato con nosotros, <a href="https://drive.google.com/file/d/1YU78O8Fpr_Xcns3BepvDKlp-cRi1Utid/view?usp=sharing">comunicándonoslo directamente</a>,  o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejamos de suministrarte energía, con los precios vigentes en cada momento.
                        </p>
                      %endif
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