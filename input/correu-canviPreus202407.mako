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
                                                <p><span style="font-weight: 400;text-align: left;">
                                                    Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 d'abril, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.
                                                </span></p>
                                                <p><span style="font-weight: 400;text-align: left;">
                                                    La tarifa ${data['tarifa_acces']} indexada no canvia, tan sols s'actualitza l'impost elèctric que, tal com <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">va establir el govern</a>, l'1 d'abril passarà del 2,5% al 3,8%. Aquesta és una actualització legal que s'aplica a tots els contractes d'electricitat. Al nostre web pots trobar, com sempre, els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">preus de la tarifa indexada</a>.
                                                </span></p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </figure>

                            <br/>
                            <h3>Canvis de preus de la tarifa ${data['tarifa_acces']} períodes</h3>
                        % elif data['modcon'] == "atr":
                            <p><span style="font-weight: 400;text-align: left;">
                                Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} períodes</strong> que s'hauria de produir en les pròximes setmanes. A la tarifa per períodes li aplicarem un canvi de preus <strong>lleugerament a la baixa</strong> a partir de l'1 d'abril. Ho expliquem a <a href="https://blog.somenergia.coop/?p=47158">aquesta notícia del blog</a>, i a l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#opcions-de-la-tarifa-periodes">apartat de tarifes</a> del web pots veure els nous preus.
                            </span></p>
                            <p><span style="font-weight: 400;text-align: left;">
                                La tarifa indexada (que et serà d'aplicació mentre no se t'activi el canvi) no té actualització de preus més enllà de la variació de l'impost elèctric que, tal com <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">va establir el govern</a>, l'1 d'abril passarà del 2,5% al 3,8%. Aquesta és una actualització legal que s'aplica a tots els contractes d'electricitat. Al nostre web pots trobar, com sempre, els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#opcions-de-la-tarifa-periodes">preus de les tarifes per períodes</a> que aplicarem a partir de l'1 d'abril i els de <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">les tarifes indexades</a>. També pots veure, a l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/historic-de-tarifes/">apartat històric</a>, els preus anteriors a 1 d'abril de 2024.
                            </span></p>
                        % endif
                        <p>
                          T'escrivim per explicar-te dues novetats respecte a la tarifa indexada que tens contractada actualment. Per una banda, estrenem un nou apartat web on podràs veure la tendència de preus de les properes 24 hores. Per altra banda, t'informem d'un petit augment en el marge de la viabilitat de la cooperativa, que aplicarem a partir de l'1 d'agost.
                        </p>
                        <h1>
                          Tendència de preus per a les properes hores
                        </h1>
                        <p>
                          Recentment hem posat en funcionament un apartat web on es pot veure la previsió de preus d'energia de la indexada per a les pròximes 24 hores. Hi pots veure, doncs, la tendència de preus per al dia següent, i això et pot ser útil per saber <strong>a quines hores l'energia serà més barata</strong> (és a dir, quan convé més, per exemple, posar la rentadora).
                        </p>
                        <img src="https://www.generationkwh.org/wp-content/uploads/2024/05/infografia-que-es-GenerationkWh-CA.jpg" alt="GenerationDemo" width="550">
                        <p>
                          Si bé els preus no seran els definitius (caldrà afegir-hi un terme que es publicarà amb posterioritat), sí que donen una idea fiable de les hores més econòmiques i les més cares.
                        </p>
                        <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td align="center">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                <tr>
                                  <td align="center">
                                    <a href="{{action_url}}" class="f-fallback button" target="_blank">Mira la pàgina</a>
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
                          Per altra banda, t'informem que a partir de l'1 d'agost aplicarem un <strong>lleuger augment al marge de viabilitat</strong> de la tarifa indexada, per tal de seguir garantint la viabilitat de la cooperativa. A continuació tens una versió resumida, per si no hi vols dedicar molt de temps, i més avall trobaràs una versió més detallada, per si t'nteressa saber-ne els detalls.<p>
                        </p>
                        <h2>
                          Explicació resumida
                        </h2>
                        %if data['Indexada20TDPeninsula']:
                         <p>
                            En el cas de la tarifa 2.0TD indexada (la teva), sense tenir en compte el preu de l'energia a un contracte amb un consum mitjà de 2.500 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 15 euros l'any (poc més d'un euro al mes).</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                         </p>
                        %endif
                        %if data['Indexada30TDPeninsula']:
                          <p>
                            En el cas de la tarifa 3.0TD indexada (la teva), si els preus de l'energia seguissin sent com en l'últim any, a un contracte amb un consum mitjà de 10.000 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 58 euros l'any.</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                          </p>
                        %endif
                        %if data['Indexada61TDPeninsula']:
                          <p>
                            En el cas de la tarifa 6.1TD indexada (la teva), si els preus de l'energia seguissin sent com en l'últim any, a un contracte amb un consum mitjà de 15.000 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 79 euros l'any.</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                          </p>
                        %endif
                        %if data['Indexada30TDVEPeninsula']:
                          <p>
                            En el cas de la tarifa 3.0TDVE indexada (la teva), si els preus de l'energia seguissin sent com en l'últim any, a un contracte amb un consum mitjà de 10.000 kWh anuals, aquest canvi li suposaria un <strong>augment aproximat d'uns 58 euros l'any.</strong> Evidentment, aquesta xifra canviaria si variés el consum, el preu de l'energia o altres aspectes del mercat elèctric.
                          </p>
                        %endif
                      <p>
                        Aquesta és la informació bàsica, resumida. Si tens curiositat i vols saber més detalls del canvi, a continuació te'ls expliquem. Com sempre, pots trobar els preus a l' <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">apartat de tarifes del web</a>.
                      </p>
                      <h2>Explicació detallada dels canvis</h2>
                      <h3>Canvis en la fórmula del càlcul del preu de l'energia</h3>
                      <p>
                        Com deus saber, la tarifa indexada obté el preu de l’energia a partir d’una fórmula, que inclou el cost de l’energia al mercat majorista, i inclou també altres conceptes (peatges, càrrecs…) que s’han de pagar per poder consumir energia.
                      </p>
                      <p>
                        Un dels components de la fórmula és la “F”, la franja de la cooperativa. Fins ara, dins d’aquest concepte hi incloíem el marge per a la viabilitat de la cooperativa, més els costos dels Certificats de Garantia d’Origen 100 % renovable (GdO) i els costos de les desviacions. A partir de l’1 d’agost, la “F” contindrà únicament el marge per a la viabilitat de la cooperativa. Els Certificats de Garantia d’Origen i els costos de les desviacions seguiran formant part de la fórmula, però en uns conceptes separats de la franja.
                      </p>
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
                      <p>
                        L'import dels certificats de garantia (a la fórmula: <span style="color:#7dbc09">GdO</span>) i dels costos de les desviacions (<span style="color:#7dbc09">Dsv</span>) s'anirà calculant en funció del que costin aquests conceptes, i es publicarà a <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">l'apartat web de tarifes.</a>
                      </p>
                      <p>
                        L'import de <strong> la franja (F) </strong> que ara serà únicament el marge, <strong> serà de ${data['dades_index']['f_nova']}</strong>.
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