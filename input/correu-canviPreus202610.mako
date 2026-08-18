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

<!-- MAILDEV_CODE: ${data['codi_polissa']} -->

<p>
  Hola${data['nom_titular']} <br/>
</p>

% if data['lang'] == "ca_ES": # CATALÀ
    % if data['modcon'] == "index":
        <figure class="table">
            <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                <tbody>
                    <tr>
                        <td>
                            <p>
                              <span style="font-weight: 400;text-align: left;">
                                <p>
                                  Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 d'octubre, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.
                                </p>
                                <p>
                                  Els preus de la tarifa indexada no varien. Els pots trobar <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">al nostre web</a>.
                                </p>
                              </span>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </figure>
    % endif

    %if data['tarifa_acces'] == '2.0TD':
      <p>El pròxim 1 d'octubre actualitzem els preus de la tarifa per períodes (la que tens contractada actualment). Les tensions al mercat energètic derivades dels conflictes globals i la inestabilitat geopolítica fa mesos que estan encarint el cost de l'electricitat i ens obliguen a actualitzar les tarifes.</p>
    %else:
      <p>El pròxim 1 d'octubre actualitzem els preus de les tarifes ${data['tarifa_acces']} períodes (la que tens contractada actualment). Les tensions al mercat energètic derivades dels conflictes globals i la inestabilitat geopolítica fa mesos que estan encarint el cost de l'electricitat i ens obliguen a actualitzar les tarifes.</p>
    %endif
    <p>L'energia que produïm a les nostres instal·lacions fotovoltaiques no s'ha encarit. El que ha augmentat és el cost de l'energia que hem de comprar al mercat per cobrir la part del consum que encara no podem generar nosaltres mateixos.</p>
    <p>Com a projecte sense ànim de lucre, ajustem el preu només el mínim indispensable per garantir la salut econòmica de la cooperativa i continuar avançant junts cap a la transició energètica.</p>
    <p>Vols conèixer tots els detalls? Llegeix l'article sencer <strong><a target="_blank" href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/actualizacio-tarifes-1-octubre?mtm_cid=20260827&mtm_campaign=canvitarifesAgo&mtm_medium=S&mtm_content=ca&mtm_source=emailerp">aquí</a></strong>.</p>
    <p>A continuació et detallem els canvis.</p>

    <h1>
      Nous preus i comparativa amb preus actuals
    </h1>
    <p>A continuació tens una taula amb els nous preus (vigents a partir de l'1 d'octubre), i una comparació amb els preus actuals (fins al 30 de setembre) de la tarifa que tens contractada. Els impostos aplicats són l'${data['impostos_str']} i l'impost elèctric del 5,11%.</p>
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
    <br/>
    <p>El preu de la potència no ha variat, segueix sent <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-periodes?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">el que ja hi havia</a>.</p>
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
      El preu de la potència no ha variat, segueix sent <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-periodes?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">el que ja hi havia</a>.
    </p>
  %endif
  %if data['autoconsum']['compensacio'] and data['mode_facturacio'] == 'atr':
    <h1>Autoproducció</h1>
    <p>En el cas de l'autoproducció, mantenim la compensació dels excedents. El preu de l'energia durant les hores de sol no ha variat i, per tant, tampoc ho fa el valor amb el qual es compensen els excedents de les persones que teniu contractada alguna modalitat d'autoproducció amb compensació simplificada.</p>
    <p>Recordeu que teniu activat el <a target="_blank" href="https://www.somenergia.coop/ca/actualitat/cooperativa/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Flux Solar</a>, que us permet obtenir descomptes pels excedents que no es poden compensar mitjançant la compensació simplificada. Podeu consultar si teniu Sols disponibles a l'<a target="_blank" href="https://oficinavirtual.somenergia.coop/ca/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Oficina Virtual</a> (<a target="_blank" href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar#sols?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquí us expliquem el camí</a>). Si en teniu, s'aniran aplicant automàticament a les properes factures.</p>
  %endif

  <h1>Estimació</h1>
  %if data['origen'] in ['pdf', 'consums_periods']:
    <p>
      Tal com estableix la normativa, hem fet <strong>una estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, si apliquéssim els preus actuals i si apliquéssim els preus nous. L'estimació l'hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i no inclou el lloguer de comptador ni els costos dels Serveis d'Ajust.
    </p>
  %elif data['origen'] == 'cnmc':
    <p>
      Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L'estimació l'hem fet a partir de les dades que tenim dels teus consums anteriors (sense tenir en compte ni el lloguer de comptador, ni els costos dels Serveis d'Ajust), extrapolant-les segons el consum mitjà que sol haver-hi a cada mes (segons dades de la Comissió Nacional dels Mercats i la Competència). Amb això n'hem obtingut un consum anual, que és el que fem servir per a la comparació.
    </p>
  %elif data['origen'] == 'estadistic':
    <p>
      Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L'estimació l'hem fet en funció de la potència contractada més alta que tens (${data['potencia']} kW), l'ús d'electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense el lloguer de comptador ni els Serveis d'Ajust.
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
              <p class="f-fallback"  style="margin: 10px 0"><strong>Sense impostos aplicats</strong></p>
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
              <p class="f-fallback" style="margin: 10px 0"><strong>Amb impostos aplicats</strong></p>
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
    Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l'ús d'energia que finalment facis, altres variacions de preus durant l'any, o canvis que hi pugui haver al mercat elèctric o en el context geopolític.
  </p>
   <p>
    Com et dèiem més amunt, al nostre blog trobaràs <a target="_blank" href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/actualizacio-tarifes-1-octubre?mtm_cid=20260827&mtm_campaign=canvitarifesAgo&mtm_medium=S&mtm_content=ca&mtm_source=emailerp">més detalls del canvi de preus</a>, i a la pàgina web pots consultar en qualsevol moment <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-periodes?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l’apartat <a target="_blank" href="https://www.somenergia.coop/ca/historic-tarifa-periodes?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">històric de tarifes</a>, on hi ha també els preus vigents fins al 30 de setembre i els de períodes anteriors.
  </p>
  <h3 style="font-size: 16px">Informació legal</h3>
  <p class="p-legal">

    La <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/legal/ca/CCGG/Condicions-Generals-contracte-subministrament-energia-electrica-SomEnergia.pdf">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus de les tarifes períodes és la clàusula 3.3.
  </p>
  <p class="p-legal">
    Pots accedir al comparador d'ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través <a target="_blank" href="https://comparador.cnmc.gob.es/">d'aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents d'algunes de les comercialitzadores del mercat lliure. Tingues en compte que les tarifes de Som Energia no hi estan incloses.
  </p>
  <p class="p-legal">
    %if data['modcon']:
      Hem 
    %else:
      T’adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d’acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem 
    %endif
     d’informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te de tarifa (<a target="_blank" href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament enviant-nos una còpia del <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/Desistiment_Plantilla_CAT.pdf?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=gl&mtm_source=emailerp">document de desistiment</a>, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
  </p>
  <br/>
  <br/>
  <p>
    Una salutació cordial,
  </p>
  <p>
  Som Energia <br/>
  <a href="https://www.somenergia.coop/ca?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">www.somenergia.coop</a>
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
                                Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} periodos, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de octubre, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa de periodos.
                              </p>
                              <p>
                                Los precios de la tarifa indexada no varían. Los puedes encontrar en <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-indexada">nuestra web</a>.
                              </p>
                            </span>
                          </p>
                      </td>
                  </tr>
              </tbody>
          </table>
      </figure>
  % endif

  %if data['tarifa_acces'] == '2.0TD':
    <p>El próximo 1 de octubre actualizamos los precios de la tarifa por periodos (la que tienes contratada actualmente). Las tensiones en el mercado energético derivadas de los conflictos globales y la inestabilidad geopolítica llevan meses encareciendo el coste de la electricidad y nos obligan a actualizar las tarifas.</p>
  %else:
    <p>El próximo 1 de octubre actualizamos los precios de las tarifas ${data['tarifa_acces']} periodos (la que tienes contratada actualmente). Las tensiones en el mercado energético derivadas de los conflictos globales y la inestabilidad geopolítica llevan meses encareciendo el coste de la electricidad y nos obligan a actualizar las tarifas.</p>
  %endif
  <p>La energía que producimos en nuestras instalaciones fotovoltaicas no se ha encarecido. Lo que ha aumentado es el coste de la energía que tenemos que comprar en el mercado para cubrir la parte del consumo que todavía no podemos generar nosotros mismos.</p>
  <p>Como proyecto sin ánimo de lucro, ajustamos el precio solo lo mínimo indispensable para garantizar la salud económica de la cooperativa y seguir avanzando juntas hacia la transición energética.</p>
  <p>¿Quieres conocer todos los detalles? Lee el artículo completo <strong><a target="_blank" href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/actualizacion-tarifas-1-octubre?mtm_cid=20260827&mtm_campaign=cambiotarifasAgo&mtm_medium=S&mtm_content=es&mtm_source=emailerp">aquí</a></strong>.</p>
  <p>A continuación te detallamos los cambios.</p>

  <h1>
    Nuevos precios y comparativa con precios actuales
  </h1>
  <p>A continuación tienes una tabla con los nuevos precios (vigentes a partir del 1 de octubre) y una comparación con los precios actuales (hasta el 30 de septiembre) de la tarifa que tienes contratada. Los impuestos aplicados son ${data['impostos_str']}, y el impuesto eléctrico del 5,11%.</p>

  %if data['tarifa_acces'] == '2.0TD' and data['mode_facturacio'] == 'atr':
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
    <p>El precio de la potencia no ha variado, sigue siendo <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">el que ya había</a>.</p>
  %endif
  %if data['tarifa_acces'] != '2.0TD' and data['mode_facturacio'] == 'atr':
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
      El precio de la potencia no ha variado, sigue siendo <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/empresa-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">el que ya había</a>.
    </p>
  %endif

  %if data['autoconsum']['compensacio'] and data['mode_facturacio'] == 'atr':
    <h1>Autoproducción</h1>
    <p>En el caso de la autoproducción, mantenemos la compensación de los excedentes. El precio de la energía durante las horas de sol no ha variado y, por tanto, tampoco lo hace el valor con el que se compensan los excedentes de las personas que tenéis contratada alguna modalidad de autoproducción con compensación simplificada.</p>
    <p>Recordad que tenéis activado el <a target="_blank" href="https://www.somenergia.coop/es/actualidad/cooperativa/flux-solar-la-herramienta-que-proporciona-descuentos-por-los-excedentes-de-autoproduccion-no-compensados">Flux Solar</a>, que os permite obtener descuentos por los excedentes que no se pueden compensar mediante la compensación simplificada. Podéis consultar si tenéis Sols disponibles en la <a target="_blank" href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a> (<a target="_blank" href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">aquí os explicamos el proceso</a>). Si tenéis, se irán aplicando automáticamente en las próximas facturas.</p>
  %endif

  <h1>Estimación</h1>
  %if data['origen'] in ['pdf', 'consums_periods']:
    <p>
      Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, si aplicáramos los precios actuales y si aplicáramos los precios nuevos. La estimación la hemos hecho a partir de los datos que tenemos respecto a lo consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, y no incluye ni el alquiler del contador ni los Servicios de Ajuste.
    </p>
  %elif data['origen'] == 'cnmc':
    <p>
      Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho a partir de los datos que tenemos de tus consumos anteriores (sin tener en cuenta ni el alquiler de contador, ni los Servicios de Ajuste), extrapolándolos según el consumo medio que suele haber en cada mes (según datos de la Comisión Nacional de los Mercados y la Competencia). Con esto hemos obtenido un consumo anual, que es el que utilizamos para la comparación.
    </p>
  %elif data['origen'] == 'estadistic':
    <p>
      Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho en función de la potencia contratada más alta que tienes (${data['potencia']} kW), el uso de electricidad que suele haber con esta potencia y cogiendo de referencia un contrato estándar, sin el alquiler de contador ni los Servicios de Ajuste.
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
              <p class="f-fallback"  style="margin: 10px 0"><strong>Sin impuestos aplicados</strong></p>
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
              <p class="f-fallback" style="margin: 10px 0"><strong>Con impuestos aplicados</strong></p>
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
    Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente hagas, otras variaciones de precios durante el año, o cambios que puedan producirse en el mercado eléctrico o en el contexto geopolítico.
  </p>
   <p>
    Como te decíamos más arriba, en nuestro blog encontrarás <a target="_blank" href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/actualizacion-tarifas-1-octubre?mtm_cid=20260827&mtm_campaign=cambiotarifasAgo&mtm_medium=S&mtm_content=es&mtm_source=emailerp">más detalles del cambio de precios</a>, y en la página web puedes consultar en cualquier momento <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">todas las tarifas</a>. Si quieres hacer comparaciones, puedes acceder al apartado <a target="_blank" href="https://www.somenergia.coop/es/historico-tarifa-periodos?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">histórico de tarifas</a>, donde están también los precios vigentes hasta el 30 de septiembre y los de periodos anteriores.
  </p>
  <h3 style="font-size: 16px">Información legal</h3>
  <p class="p-legal">
    La <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/legal/es/CCGG/Condiciones-Generales-contrato-suministro-energia-electrica-SomEnergia.pdf">cláusula contractual de las Condiciones Generales</a> que nos autoriza a realizar este cambio de precios de las tarifas periodos es la cláusula 3.3.
  </p>
  <p class="p-legal">
    Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a target="_blank" href="https://comparador.cnmc.gob.es/">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de algunas de las comercializadoras del mercado libre. Ten en cuenta que las tarifas de Som Energia no están incluidas.
  </p>
  <p class="p-legal">
    %if data['modcon']:
    Debemos 
    %else:
    Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos 
    %endif
    informarte de que si, por alguna razón, este cambio de precios te hiciese replantear seguir con esta tarifa, podrías cambiarte de tarifa (<a target="_blank" href="https://es.support.somenergia.coop/article/1345-modificacion-de-la-tarifa-de-periodos-a-indexada-y-de-indexada-a-periodos?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">a través de tu Oficina Virtual</a>), o podrías dar de baja tu contrato con nosotros, bien comunicándolo directamente enviándonos una copia del <a target="_blank" href="https://back-nova-test.somenergia.coop/storage/app/media/DOCS/Desistimiento_Plantilla_CAST.pdf?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">documento de desistimiento</a>, o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejamos de suministrarte energía, con los precios vigentes en cada momento.
  </p>
  <br/>
  <br/>
  <p>
    Un cordial saludo,
  </p>
  <p>
    Som Energia <br/>
    <a href="https://www.somenergia.coop/es?mtm_cid=20251121&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">www.somenergia.coop</a>
  </p>
%endif
${plantilla_footer}
