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

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

    email_o = object.pool.get('report.backend.mailcanvipreus')
    data = email_o.get_data(object._cr, object._uid, object.id, context={'lang': object.partner_id.lang})
%>

${plantilla_header}

<p>
  Hola${data['nom_titular']} <br/>
</p>

% if data['lang'] == "ca_ES": # CATALÀ
    % if data['modcon'] == "index" and data['tarifa_acces'] == '2.0TD':
        <figure class="table">
            <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                <tbody>
                    <tr>
                        <td>
                            <p>
                              <span style="font-weight: 400;text-align: left;">
                                <p>
                                  Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 de gener, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.
                                </p>
                                <p>
                                  La tarifa ${data['tarifa_acces']} indexada augmentarà lleugerament el preu de la potència. Pots veure els <strong><a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">nous preus</a> de la tarifa 2.0TD indexada</strong> al nostre web i a <a href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/al-gener-actualitzarem-els-preus">aquest article</a> del blog.
                                </p>
                              </span>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </figure>
    % elif data['modcon'] == "index" and data['tarifa_acces'] != '2.0TD':
      <figure class="table">
        <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
            <tbody>
                <tr>
                    <td>
                        <p>
                          <span style="font-weight: 400;text-align: left;">
                            <p>
                              Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 de gener, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.
                            </p>
                            <p>
                              Els preus de la <strong>tarifa ${data['tarifa_acces']} indexada</strong> no varien. Els pots trobar <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">al nostre web</a>.
                            </p>
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
                              <p>
                                  Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} períodes</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} indexada, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 de gener, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa indexada.
                                </p>
                                <p>
                                  Els preus de la <strong>tarifa ${data['tarifa_acces']} períodes també variaran lleugerament</strong>. Pots trobar l’explicació a <a href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/al-gener-actualitzarem-els-preus?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquest article</a> del blog, i el detall dels preus els tens <a href="https://www.somenergia.coop/ca/tarifes-llum/domestic-periodes/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">al nostre web</a>.
                                </p>
                            </span>
                          </p>
                      </td>
                  </tr>
              </tbody>
          </table>
      </figure>
    % endif
    % if data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'atr':
      <p>
        L’1 de gener modificarem els preus de les tarifes per períodes (la que tens ara, ho és). Alguns conceptes han pujat i d’altres han baixat, i el resultat final fa que, per a un contracte domèstic tipus <strong>quedi pràcticament igual</strong> (la variació és d’un augment de menys <strong>d’un 0,5%</strong>).
      </p>
      <p>
        A la <strong>tarifa 2.0TD períodes</strong> (la teva), el preu de l’energia disminueix una mica als períodes punta i pla, i augmenta una mica al període vall.
      </p>
      <p>
        Els preus han variat tant pel cost de l’energia (l’aprovisionament), com pels altres conceptes (el que està relacionat amb les pèrdues d’energia pel trasllat per la xarxa, desviaments, certificats de garantia d’origen,...), com pel marge per a la viabilitat de la cooperativa.
      </p>
    % elif data['tarifa_acces'] != '2.0TD' and data['mode_facturacio'] == 'atr':
    <p>
      L’1 de gener modificarem els preus de les tarifes per períodes (la que tens ara, ho és). A les <strong>tarifes 3.0TD períodes i 6.1TD períodes</strong> ha variat el preu de l’energia (alguns períodes pugen i d’altres baixen) per la variació del cost de l’energia i per la variació dels altres conceptes (desviaments, coeficients de pèrdues, certificats de garantia d’origen…). El marge per a la viabilitat de la cooperativa es manté igual.
    </p>
    <p>
      A continuació podeu veure els nous preus, així com una estimació aproximada de com us podria afectar en el vostre cas en concret.
    </p>
    % elif data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'index':
    <p>
      L’1 de gener modificarem els preus de la tarifa 2.0TD indexada (la que tens ara, ho és). En concret, variarà el preu de la potència, ja que hi hem augmentat lleugerament el marge per a la viabilitat de la cooperativa.
    </p>
    <p>
      Aquesta variació de potència, a un contracte tipus li suposarà un augment d’uns 2 euros a l’any.
    </p>
    % endif

    <p>Et donem més detalls de les variacions a <a href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/al-gener-actualitzarem-els-preus?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquest article del blog</a>.</p>
    <h1>
      Nous preus i comparativa amb preus actuals
    </h1>
    <p>
      A continuació tens una taula amb els nous preus (vigents a partir de l'1 de gener), i una comparació amb els preus actuals (fins a 31 de desembre) de la tarifa que tens contractada. Els impostos aplicats són l'${data['impostos_str']}, i l'impost elèctric del 5,11%.
    </p>
    <br/>
  %if data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'atr':
    <h1>
      Tarifa 2.0TD períodes
    </h1>
    <h3>
      Preu del terme d'energia (en euros/kWh)
    </h3>

    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="4">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">

            <tr>
              <td width="20%" class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="margin: 10px 0"></p>
              </td>
              <td width="20%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Període</strong></p>
              </td>
              <td width="30%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Preus actuals</strong></p>
              </td>
              <td width="30%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback" style="margin: 10px 0"><strong>Preus nous</strong></p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=3>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Sense impostos</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Punta</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Pla</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Vall</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P3']}</p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=3>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Amb impostos</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Punta</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Pla</p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Vall</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P3']}</p>
              </td>
            </tr>

          </table>
        </td>
      </tr>
    </table>
    <h3>
      Preu del terme de potència (en euros/kWh a l'any)
    </h3>
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="5">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
              <td width="20%" class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="margin: 10px 0"></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Preus actuals</strong></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Preus nous</strong></p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0"></p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període vall</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període vall</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Sense impostos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Sense impostos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P2']}</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  %endif
  %if data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'index':
    <h1>Tarifa ${data['tarifa_acces']} indexada</h1>
    <h3>
      Preu del terme de potència (en euros/kWh a l'any)
    </h3>
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="5">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
              <td width="20%" class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="margin: 10px 0"></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Preus actuals</strong></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Preus nous</strong></p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0"></p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període vall</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Període vall</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Sense impostos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Sense impostos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P2']}</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  %endif
  %if data['tarifa_acces'] != '2.0TD' and data['mode_facturacio'] == 'atr':
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
              <td width="32.5%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Preus actuals</strong></p>
              </td>
              <td width="32.5%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback" style="margin: 10px 0"><strong>Preus nous</strong></p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=6>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Sense impostos aplicats</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P1</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P2</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P3</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P3']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P4</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P4']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P4']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P5</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P5']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P5']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P6</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P6']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P6']}</p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=6>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Amb impostos aplicats</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P1</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P2</p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P3</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P3']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P4</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P4']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P4']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P5</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P5']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P5']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P6</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P6']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P6']}</p>
              </td>
            </tr>

          </table>
        </td>
      </tr>
    </table>
    <p>
      El preu de la potència no ha variat, segueix sent <a href="https://www.somenergia.coop/ca/tarifes-llum/domestic-periodes?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">el que ja hi havia</a>.
    </p>
  %endif
  %if data['mode_facturacio'] == 'atr' and data['autoconsum']['compensacio']:
    <h2>Autoproducció</h2>
    <p>
      El preu de l’energia durant les hores de sol ha continuat baixant, i la previsió és que segueixi fent-ho. És per això que <strong>disminueix la compensació dels excedents d’autoproducció</strong>, que afecta a les persones que tingueu alguna modalitat d’autoproducció amb compensació simplificada. La compensació la seguim fixant al mateix valor mitjà del cost de l’energia en hores solars (compensem l’energia excedentària al mateix valor que el que ens costaria comprar-la al mercat majorista).
    </p>
    <h3>Preu de compensació d’excedents d’autoproducció (en euros/kWh)</h3>
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="3">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
              <td class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="margin: 10px 0"></p>
              </td>
              <td class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="text-align: center; padding-left: 0; margin: 10px 0"><strong>Preus actuals</strong></p>
              </td>
              <td class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0"><strong>Preus nous</strong></p>
              </td>
            </tr>
            <tr>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Sense impostos aplicats</strong></p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_antic']}</p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_nou']}</p>
              </td>
            </tr>
            <tr>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="margin: 10px 0"><strong>Amb impostos aplicats</strong></p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_antic_imp']}</p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_nou_imp']}</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br/>
    <p>
      Les persones que tingueu compensació simplificada també teniu activat el <a href="https://www.somenergia.coop/ca/actualitat/cooperativa/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Flux Solar</a>, que proporciona descomptes per als excedents que no poden ser compensats amb la compensació simplificada. Podeu veure si tens Sols disponibles a la vostra <a href="https://oficinavirtual.somenergia.coop/ca/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Oficina Virtual</a> (<a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar#sols?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquí</a> t'expliquem el camí). Si és el cas, se t'aniran aplicant a les properes factures.
    </p>
  %endif
  <h1>Estimació</h1>
  %if data['origen'] == 'pdf':
    <p>
      Tal com estableix la normativa, hem fet <strong>una estimació de caràcter orientatiu</strong> del que et costaria l’energia i la potència durant un any, si apliquéssim els preus actuals i si apliquéssim els preus nous. L’estimació l’hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i sense autoproducció, ni Generation kWh, ni lloguer de comptador. 
    </p>
  %elif data['origen'] == 'cnmc':
    <p>
      Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l’energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L’estimació l’hem fet a partir de les dades que tenim dels teus consums anteriors (sense tenir en compte autoproducció ni Generation kWh ni lloguer de comptador), extrapolant-les segons el consum mitjà que sol haver-hi a cada mes (segons dades de la Comissió Nacional dels Mercats i la Competència). Amb això n’hem obtingut un consum anual, que és el que fem servir per a la comparació.
    </p>
  %elif data['origen'] == 'estadistic':
    <p>
      Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l’energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L’estimació l’hem fet en funció de la potència contractada més alta que tens (${data['potencia']} kW), l’ús d’electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense autoproducció ni Generation kWh ni lloguer de comptador.
    </p>
  %else: # TODO: nou cas indexada 2.0TD amb corbes
    <p>
      Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del cost de l’electricitat amb aquest augment de la potència, i l’hem comparat amb el cost amb la tarifa actual. L’estimació l’hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']}  kWh) i les potències que tens contractades, sense tenir en compte l’autoproducció ni Generation kWh, ni lloguer de comptador.
    </p>
  %endif
  <p>
    L'estimació la pots veure sense impostos i amb impostos inclosos (l'${data['impostos_str']} i l'impost elèctric del 5,11%).
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
            <td class="purchase_borders" style="padding-left: 5px; padding-right: 5px; text-align: center" align="left">
              <p class="f-fallback"  style="margin: 10px 0"><strong>Cost estimat amb els preus actuals</strong></p>
            </td>
            <td class="purchase_borders" style="padding-left: 5px; padding-right: 5px; text-align: center" align="left">
              <p class="f-fallback" style="margin: 10px 0"><strong>Cost estimat amb els nous preus</strong></p>
            </td>
          </tr>
          <tr>
            <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">Sense impostos aplicats</p>
            </td>
            <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_vell']}</p>
            </td>
            <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_nou']}</p>
            </td>
          </tr>
          <tr>
            <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="margin: 10px 0">Amb impostos aplicats</p>
            </td>
            <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_vell_imp']}</p>
            </td>
            <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_nou_imp']}</p>
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
  %if False: # TODO: nou cas indexada 2.0TD amb corbes
    <p>
      Com sempre, pots trobar la informació, els preus i la fórmula de la tarifa indexada al nostre web, <a href="https://www.somenergia.coop/ca/tarifes-llum/domestic-indexada?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">apartat tarifa indexada</a>, i al <a href="https://ca.support.somenergia.coop/category/1359-les-tarifes-indexades?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Centre d’Ajuda</a>.
    </p>
  %endif
  %if data["te_gkwh"]:
  <h1>Generation kWh</h1>
  <p>
    El preu del Generation kWh també ha variat. No es tracta del cost de l’energia, sinó que han canviat algun dels altres components del preu, com per exemple el que està relacionat amb les pèrdues d’energia pel trasllat per la xarxa.
  </p>
  <p>
    Això fa que l’energia als períodes punta i pla <strong>baixi lleugerament</strong>, i el període vall quedi <strong>igual</strong>.
  </p>
  <h3>Generation kWh: preu del terme d’energia (en euros/kWh):</h3>
  <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
    <tr>
      <td colspan="7">
        <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td class="purchase_borders" style="vertical-align: center;" align="left">
              <p class="f-fallback"  style="margin: 10px 0"></p>
            </td>
            <td class="purchase_borders" style="padding-left: 5px; padding-right: 5px; text-align: center" align="left" colspan="3">
              <p class="f-fallback"  style="margin: 10px 0"><strong>Preus actuals</strong></p>
            </td>
            <td class="purchase_borders" style="padding-left: 5px; padding-right: 5px; text-align: center" align="left" colspan="3">
              <p class="f-fallback" style="margin: 10px 0"><strong>Preus nous</strong></p>
            </td>
          </tr>
          <tr>
            <td width="16%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">Sense impostos aplicats</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_generation']['P1']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_generation']['P2']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_generation']['P3']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_generation']['P1']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_generation']['P2']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_generation']['P3']}</p>
            </td>
          </tr>
          <tr>
            <td width="16%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="margin: 10px 0">Amb impostos aplicats</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_generation_imp']['P1']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_generation_imp']['P2']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_antics_generation_imp']['P3']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_generation_imp']['P1']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_generation_imp']['P2']}</p>
            </td>
            <td width="14%" class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preus_nous_generation_imp']['P3']}</p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br/>
  %endif
  ## FET FINS AQUÍ
  <p>
    Al nostre blog trobaràs <a href="https://blog.somenergia.coop/?p=50300">més detalls del canvi de tarifes</a>, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l'apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de maig i els de períodes anteriors.
  </p>

  <h3 style="font-size: 16px">Informació legal</h3>
  <p class="p-legal">
    La <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus és la clàusula 5.3 (ii).
  </p>
  <p class="p-legal">
    Pots accedir al comparador d'ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través <a href="https://comparador.cnmc.gob.es">d'aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents d'algunes de les comercialitzadores del mercat lliure. Tingues en compte que les tarifes de Som Energia no hi estan incloses.
  </p>
  %if data['gurb']:
    <p class="p-legal">
      Veuràs que t'enviem tota la documentació del paquet contractual (Condicions Generals, Condicions Específiques del servei GURB, Condicions particulars del contracte, i la resta de la documentació relacionada amb el servei de GURB). Et recordem que aquest canvi només afecta el preu de l'energia de la tarifa períodes, i no afecta, per tant, el servei de GURB.
    </p>
  %endif
  %if data['modcon'] == "atr" or data['modcon'] == "index":
    <p class="p-legal">
      Després d'haver-te compartit aquesta informació, si aquest canvi de preus et fes replantejar seguir amb la modificació sol·licitada, podries demanar que s'aturi la modificació de tarifa (escrivint-nos a <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a>) o bé podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
    </p>
  %else:
    <p class="p-legal">
      T'adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">tarifa indexada</a> (<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
    </p>
  %endif
  <br/>
  <br/>
  <p>
    Una salutació cordial,
  </p>
  <p>
  Equip de Som Energia <br/>
  <a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a>
  </p>

%else: ## CASTELLANO
  % if data['modcon'] == "index" and data['tarifa_acces'] == '2.0TD':
      <figure class="table">
          <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
              <tbody>
                  <tr>
                      <td>
                          <p>
                            <span style="font-weight: 400;text-align: left;">
                              <p>
                                Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} periodos, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa de periodos.
                              </p>
                              <p>
                                En la tarifa ${data['tarifa_acces']} indexada aumentará ligeramente el precio de la potencia. Puedes ver los <strong><a href="https://www.somenergia.coop/es/tarifas-luz/domestico-indexada/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">nuevos precios</a> de la tarifa 2.0TD indexada</strong> en nuestra web y en <a href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/en-enero-actualizaremos-los-precios?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">este artículo</a> del blog.
                              </p>
                            </span>
                          </p>
                      </td>
                  </tr>
              </tbody>
          </table>
      </figure>
  % elif data['modcon'] == "index" and data['tarifa_acces'] != '2.0TD':
    <figure class="table">
      <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
          <tbody>
              <tr>
                  <td>
                      <p>
                        <span style="font-weight: 400;text-align: left;">
                          <p>
                            Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} periodos, e explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa de periodos.
                          </p>
                          <p>
                            Los precios de la <strong>tarifa ${data['tarifa_acces']} indexada</strong> no varien. Els pots trobar <a href="https://www.somenergia.coop/es/tarifas-luz/domestico-indexada/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">en nuestra web</a>.
                          </p>
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
                            <p>
                                Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} periodos</strong>, qque debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} indexada, te explicamos más abajo los cambios que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa indexada.
                              </p>
                              <p>
                                Los precios de <strong>la tarifa ${data['tarifa_acces']} periodos también variarán ligeramente</strong>. Puedes encontrar la explicación en <a href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/en-enero-actualizaremos-los-precios?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">este artículo</a> del blog, y el detalle de los precios los tienes <a href="https://www.somenergia.coop/es/tarifas-luz/domestico-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">en nuestra web</a>.
                              </p>
                          </span>
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
    </figure>
  % endif
      % if data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'atr':
      <p>
        El 1 de enero modificaremos los precios de las tarifas por periodos (la que tienes ahora, lo es). Algunos conceptos han subido y otros han bajado, y el resultado final hace que, para un contrato doméstico tipo <strong>quede prácticamente igual</strong> (la variación es de un aumento de menos <strong>del 0,5%</strong>).
      </p>
      <p>
        En la <strong>tarifa 2.0TD periodos</strong> (la tuya), el precio de la energía disminuye un poco en los periodos punta y plano, y aumenta un poco en el periodo valle.
      </p>
      <p>
        Los precios han variado tanto por el coste de la energía (el aprovisionamiento), como por los otros conceptos (el relacionado con las pérdidas de energía por el traslado por la red, desvíos, certificados de garantía de origen,...), como por el margen para la viabilidad de la cooperativa.
      </p>
    % elif data['tarifa_acces'] != '2.0TD' and data['mode_facturacio'] == 'atr':
    <p>
      El 1 de enero modificaremos los precios de las tarifas por periodos (la que tienes ahora, lo es). En las <strong>tarifas 3.0TD periodos y 6.1TD periodos</strong> ha variado el precio de la energía (algunos periodos suben y otros bajan) por la variación del coste de la energía y por la variación de los otros conceptos (desvíos, coeficientes de pérdidas, certificados de garantía de origen…). El margen para la viabilidad de la cooperativa permanece igual.
    </p>
    <p>
      A continuación puedes ver los nuevos precios, así como una estimación aproximada de cómo podría afectarte en tu caso en concreto.
    </p>
    % elif data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'index':
    <p>
      El 1 de enero modificaremos los precios de la tarifa 2.0TD indexada (la que tienes ahora, lo es). En concreto, variará el precio de la potencia, puesto que hemos aumentado ligeramente el margen para la viabilidad de la cooperativa.
    </p>
    <p>
      Esta variación de potencia, a un contrato tipo le supondrá un aumento de unos 2 euros al año.
    </p>
    % endif

    <p>Te damos más detalles de las variaciones en <a href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/en-enero-actualizaremos-los-precios?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">del blog</a>.</p>
    <h1>
      Nuevos precios y comparativa con precios actuales
    </h1>
    <p>
      A continuación tienes una tabla con los nuevos precios (vigentes a partir del 1 de enero) y una comparación con los precios actuales (hasta 31 de diciembre) de la tarifa que tienes contratada. Los impuestos aplicados son ${data['impostos_str']}, y el impuesto eléctrico del 5,11%.
    </p>

  %if data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'atr':
    <br/>
    <h1>
      Tarifa 2.0TD periodos
    </h1>
    <h3>
      Precio del término de energía (en euros/kWh)
    </h3>

    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="4">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">

            <tr>
              <td width="20%" class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="margin: 10px 0"></p>
              </td>
              <td width="20%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Periodo</strong></p>
              </td>
              <td width="30%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Precios actuales</strong></p>
              </td>
              <td width="30%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback" style="margin: 10px 0"><strong>Precios nuevos</strong></p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=3>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Sin impuestos</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Punta</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Llano</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Valle</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P3']}</p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=3>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Con impuestos</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Punta</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Llano</p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">Valle</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P3']}</p>
              </td>
            </tr>

          </table>
        </td>
      </tr>
    </table>
    <h3>
      Precio del término de potencia (en euros/kW al año)
    </h3>
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="5">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
              <td width="20%" class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="margin: 10px 0"></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Precios actuales</strong></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Precios nuevos</strong></p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0"></p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo valle</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo valle</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Sin impuestos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Con impuestos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P2']}</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  %endif
%if data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'index':
    <h1>Tarifa ${data['tarifa_acces']} indexada</h1>
    <h3>
      Precio del término de potencia (en euros/kW al año)
    </h3>
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="5">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
              <td width="20%" class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback"  style="margin: 10px 0"></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Precios actuales</strong></p>
              </td>
              <td colspan="2" width="40%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="center">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Precios nuevos</strong></p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0"></p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo valle</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo punta</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Periodo valle</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Sin impuestos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous']['tp']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">Con impuestos</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_antics_imp']['tp']['P2']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P1']}</p>
              </td>
              <td class="purchase_borders" valign="middle">
                <p class="f-fallback" style="margin: 10px 0">${data['preus_nous_imp']['tp']['P2']}</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  %endif
  %if data['tarifa_acces'] != '2.0TD' and data['mode_facturacio'] == 'atr':
    <br/>
    <h1>Tarifa ${data['tarifa_acces']} periodos</h1>
    <h3>Precio del término de energía (en euros/kWh)</h3>
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
              <td width="32.5%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Precios actuales</strong></p>
              </td>
              <td width="32.5%" class="purchase_borders" style="padding-left: 0px; text-align: center" align="left">
                <p class="f-fallback" style="margin: 10px 0"><strong>Precios nuevos</strong></p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=6>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Sin impuestos aplicados</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P1</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P2</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P3</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P3']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P4</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P4']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P4']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P5</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P5']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P5']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P6</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics']['te']['P6']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous']['te']['P6']}</p>
              </td>
            </tr>

            <tr>
              <td class="purchase_borders" style="vertical-align: left;" valign="middle" rowspan=6>
                <p class="f-fallback"  style="margin: 10px 0;"><strong>Con impuestos aplicados</strong></p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P1</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P1']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P1']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P2</p>
              </td>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P2']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P2']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P3</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P3']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P3']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P4</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P4']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P4']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P5</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P5']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P5']}</p>
              </td>
            </tr>
            <tr>
              <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">P6</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_imp']['te']['P6']}</p>
              </td>
              <td class="purchase_borders" style="text-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_imp']['te']['P6']}</p>
              </td>
            </tr>

          </table>
        </td>
      </tr>
    </table>
    <p>
      El precio de la potencia no ha variado, sigue siendo <a href="https://www.somenergia.coop/es/tarifas-luz/empresa-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">el que ya había</a>.
    </p>
  %endif

  %if data['mode_facturacio'] == 'atr' and data['autoconsum']['compensacio']:
    <h2>Autoproducción</h2>
    <p>El precio de la energía durante las horas de sol ha continuado bajando, y la previsión es que siga haciéndolo. Es por eso que <strong>disminuye la compensación de los excedentes de autoproducción</strong>, que afecta a las personas que tengáis alguna modalidad de autoproducción con compensación simplificada. La compensación la seguimos fijando al mismo valor medio del coste de la energía en horas solares (compensamos la energía excedentaria al mismo valor que lo que nos costaría comprarla en el mercado mayorista).
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
                <p class="f-fallback"  style="text-align: center; padding-left: 0; margin: 10px 0"><strong>Precios actuales</strong></p>
              </td>
              <td class="purchase_borders" style="vertical-align: center;" align="left">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0"><strong>Precios nuevos</strong></p>
              </td>
            </tr>
            <tr>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback"  style="margin: 10px 0"><strong>Sin impuestos aplicados</strong></p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_antic']}</p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_nou']}</p>
              </td>
            </tr>
            <tr>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="margin: 10px 0"><strong>Con impuestos aplicados</strong></p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_antic_imp']}</p>
              </td>
              <td width="33%" class="purchase_borders" style="vertical-align: center;" valign="middle">
                <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_auto_nou_imp']}</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br/>
    <p>
      Las personas que tengan compensación simplificada también tienen activado el <a href="https://www.somenergia.coop/es/actualidad/cooperativa/flux-solar-la-herramienta-que-proporciona-descuentos-por-los-excedentes-de-autoproduccion-no-compensados?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Flux Solar</a>, que proporciona descuentos para los excedentes que no pueden ser compensados ​​con la compensación simplificada. Puede ver si tienes Sols disponibles en su <a href="https://oficinavirtual.somenergia.coop/es/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">Oficina Virtual</a> (<a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquí</a> te explicamos el camino). Si es el caso, se te irán aplicando en las próximas facturas.
    </p>
  %endif
  <h1>Estimación</h1>
  %if data['origen'] == 'pdf':
    <p>
      Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, si aplicáramos los precios actuales y si aplicáramos los precios nuevos. La estimación la hemos hecho a partir de los datos que tenemos respecto a lo consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, y sin autoproducción, ni Generation kWh, ni alquiler de contador.
    </p>
  %elif data['origen'] == 'cnmc':
    <p>
      Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho a partir de los datos que tenemos de tus consumos anteriores (sin tener en cuenta autoproducción ni Generation kWh ni alquiler de contador), extrapolándolos según el consumo medio que suele haber en cada mes (según datos de la Comisión Nacional de los Mercados y la Competencia). Con esto hemos obtenido un consumo anual, que es el que utilizamos para la comparación.
    </p>
  %elif data['origen'] == 'estadistic':
    <p>
      Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho en función de la potencia contratada más alta que tienes (${data['potencia']} kW), el uso de electricidad que suele haber con esta potencia y cogiendo de referencia un contrato estándar, sin autoproducción ni Generation kWh ni alquiler de contador.
    </p>
  %else: # TODO: nou cas indexada 2.0TD amb corbes
    <p>
      Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> del coste de la electricidad con este aumento de la potencia, y lo hemos comparado con el coste con la tarifa actual. La estimación la hemos hecho a partir de los datos que tenemos respecto a lo consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, sin tener en cuenta la autoproducción ni Generation kWh, ni alquiler de contador.
    </p>
  %endif
  <p>
    La estimación la puedes ver sin impuestos y con impuestos incluidos (${data['impostos_str']} y el impuesto eléctrico del 5,11%).
  </p>
  <h3>Coste anual estimado, en euros/año, del suministro (energía y potencia):</h3>
  <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
    <tr>
      <td colspan="3">
        <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td width="24%" class="purchase_borders" style="vertical-align: center;" align="left">
              <p class="f-fallback"  style="margin: 10px 0"></p>
            </td>
            <td width="38%" class="purchase_borders" style="padding-left: 5px; padding-right: 5px; 0px; text-align: center" align="left">
              <p class="f-fallback"  style="margin: 10px 0"><strong>Coste estimado con los precios actuales</strong></p>
            </td>
            <td width="38%" class="purchase_borders" style="padding-left: 5px; padding-right: 5px; text-align: center" align="left">
              <p class="f-fallback" style="margin: 10px 0"><strong>Coste estimado con los nuevos precios</strong></p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">Sin impuestos aplicados</p>
            </td>
            <td class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_vell']}</p>
            </td>
            <td class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_nou']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="margin: 10px 0">Con impuestos aplicados</p>
            </td>
            <td class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_vell_imp']}</p>
            </td>
            <td class="purchase_borders" style="vertical-align: center;" valign="middle">
              <p class="f-fallback" style="text-align: center; padding-left: 0; margin: 10px 0">${data['preu_nou_imp']}</p>
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
  %if False: # TODO: nou cas indexada 2.0TD amb corbes
    <p>
      Como siempre, puedes encontrar la información, precios y fórmula de la tarifa indexada en nuestra web, <a href="https://www.somenergia.coop/es/tarifas-luz/domestico-indexada/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">apartado tarifa indexada</a>, y en el <a href="https://es.support.somenergia.coop/category/1361-las-tarifas-indexadas?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Centro de Ayuda</a>.
    </p>
  %endif
  ## FET FINS AQUÍ
  <p>
    En nuestro blog encontrarás <a href="https://blog.somenergia.coop/?p=50302">más detalles</a> del cambio de tarifas, y en la página web puedes consultar en cualquier momento <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">todas las tarifas</a>.  Si quieres hacer comparaciones, puedes acceder al apartado <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde están también los precios vigentes hasta el 31 de mayo y los de periodos anteriores.
  </p>
  <h3 style="font-size: 16px">Información legal</h3>
  <p class="p-legal">
    La <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/#precio-y-actualizacion">cláusula contractual de las Condiciones Generales</a> que nos autoriza a realizar este cambio de precios es la cláusula 5.3 (ii).
  </p>
  <p class="p-legal">
    Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a href="https://comparador.cnmc.gob.es">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de algunas de las comercializadoras del mercado libre. Ten en cuenta que las tarifas de Som Energia no están incluidas.
  </p>
  %if data['gurb']:
    <p class="p-legal">
      Verás que te enviamos toda la documentación del paquete contractual (Condiciones Generales, Condiciones Específicas del servicio GURB, Condiciones particulares del contrato, y demás documentación relacionada con el servicio de GURB). Te recordamos que este cambio sólo afecta al precio de la energía de la tarifa periodos, y no afecta, por tanto, al servicio de GURB.
    </p>
  %endif
  % if data['modcon'] == "atr" or data['modcon'] == "index":
    <p class="p-legal">
      Después de haberte compartido esta información, si este cambio de precios te hiciese replantear seguir con la modificación solicitada, podrías pedir que se pare la modificación de tarifa (escribiéndonos a <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a>) o bien podrías dar de baja tu contrato con nosotros, bien comunicándonoslo directamente, o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejáramos de suministrarte energía, con los precios vigentes en cada momento.
    </p>
  %else:
    <p class="p-legal">
      Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos informarte de que si, por alguna razón, este cambio de precios te hiciese replantear seguir con esta tarifa, podrías cambiarte a la <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/">tarifa indexada</a> (<a href="https://es.support.somenergia.coop/article/1345-modificacion-de-la-tarifa-de-periodos-a-indexada-y-de-indexada-a-periodos?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">a través de tu Oficina Virtual</a>), o podrías dar de baja tu contrato con nosotros, comunicándonoslo directamente,  o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejamos de suministrarte energía, con los precios vigentes en cada momento.
    </p>
  %endif
  <br/>
  <br/>
  <p>
    Un cordial saludo,
  </p>
  <p>
    Equipo de Som Energia <br/>
    <a href="https://www.somenergia.coop/es">www.somenergia.coop</a>
  </p>

%endif
${plantilla_footer}