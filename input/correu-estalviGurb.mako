<%
    from mako.template import Template
    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
        )

    import locale

    locale.setlocale(locale.LC_NUMERIC, 'ca_ES.UTF-8')

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>

${plantilla_header}

<p>
  Hola,<br/>
</p>

% if object.partner_id.lang == "ca_ES": # CATALÀ
  <p>
    L’equip de GURB de Som Energia hem estat treballant per donar-vos una bona notícia per començar el 2026.
  </p>
  <p>
    Ara ja fa més d’un any que vàrem posar en marxa el <strong>primer projecte GURB a Mataró!</strong>
  </p>
  <p>
    Com està anant? Esperem que molt bé!
  </p>
  <p>
    Volem recordar-te els beneficis de participar en el projecte GURB. Sent partícip d'un autoconsum col·lectiu contribueixes en la <strong>democratització de l'energia</strong> i en <strong>afavorir la transició energètica</strong> cap a un model 100% renovable, a més reps <strong>energia descentralitzada</strong> i de <strong>producció local,</strong> compartida amb el teu veïnat.
  </p>
  <p>
    Sovint, participar a GURB també comporta <strong>beneficis econòmics,</strong> ja que suposa un estalvi en la teva factura de la llum. Creiem que ara és un bon moment per fer un repàs de com està anant.
  </p>
  <p>
    Durant el temps que portes participant al projecte i, segons la teva quota de participació (${locale.format_string('%.2f', object.beta_kw, grouping=True)} kW):
  </p>
  <ul>
    <li>
      Se t'han <strong>assignat un total de ${locale.format_string('%.2f', env['saving']['kwh_generacio_neta'], grouping=True)} kWh</strong> d'energia.
    </li>
    <li>
      D'aquesta energia has <strong>autoconsumit</strong> (energia que consumeixes directament quan la instal·lació està generant) <strong>${locale.format_string('%.2f', env['saving']['kwh_autoconsumits'], grouping=True)}kWh,</strong> que suposa un ${locale.format_string('%.2f', env['saving']['percentatge_autoconsumida'], grouping=True)} % de la producció assignada.
    </li>
    <li>
      L'energia que no has fet servir i que ha anat a parar a la xarxa de distribució i, per tant, ha generat un <strong>excedent a compensar ha estat de ${locale.format_string('%.2f', env['saving']['kwh_excedents'], grouping=True)} kWh.</strong>
    </li>
    <li>
      L'energia autoconsumida ha suposat un <strong>${locale.format_string('%.2f', env['saving']['percentatge_autoconsum'], grouping=True)} %</strong> del teu consum total durant aquest temps. Això significa que si no tinguessis el servei GURB, seria energia que pagaries tal com pagues l’energia procedent de la xarxa de distribució.
    </li>
    <li>
      L'energia que has utilitzat i que no provenia de les plaques, i que per tant <strong>ha vingut de la xarxa de distribució, ha estat de ${locale.format_string('%.2f', env['saving']['kwh_consumits'], grouping=True)} kWh.</strong>
    </li>
  </ul>
  <figure class="table">
      <table style="background-color: #FFCDB5; border: 4px solid #FF632B; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
          <tbody>
              <tr>
                  <td>
                    <strong>Això t'ha suposat un estalvi total de ${locale.format_string('%.2f', env['saving']['estalvi_amb_impostos'], grouping=True)} euros</strong> (aquest càlcul té en compte la quota GURB que pagues mensualment a la factura i els impostos associats).
                </td>
              </tr>
          </tbody>
      </table>
  </figure>
  <small>
    Les dades de consum són dades aportades per l’empresa de distribució elèctrica i el càlcul està fet en base a aquesta informació.
  </small>
  <p>
    Volem agrair-te especialment la teva participació i la teva confiança un cop més a Som Energia. Gràcies a la teva col·laboració la cooperativa pot continuar treballant per complir la nostra missió, <strong>transformar el model energètic posant el poder en mans de la ciutadania.</strong>
  </p>
  <p>
    Esperem que tota aquesta informació t'hagi estat útil i et resulti interessant. Altre cop, moltes gràcies per la teva confiança en la cooperativa. Si tens qualsevol dubte ens pots escriure a <a href="mailto:gurb@somenergia.coop">gurb@somenergia.coop</a>.
  </p>
  <p>
    Salutacions,
  </p>
  <p>
    Som Energia <br/>
    <a href="https://www.somenergia.coop/es?mtm_cid=20251121&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">www.somenergia.coop</a>
  </p>
%else: ## CASTELLANO
  <p>
    El equipo de GURB de Som Energia hemos estado trabajando para daros una buena noticia y  empezar bien el 2026.
  </p>
  <p>
    ¡Ahora ya hace más de un año que pusimos en marcha el <strong>primer proyecto GURB en Mataró!</strong>
  </p>
  <p>
    ¿Cómo está yendo? ¡Esperamos que muy bien!
  </p>
  <p>
    Queremos recordarte los beneficios de participar en el proyecto GURB. Siendo partícipe de un autoconsumo colectivo contribuyes a la <strong>democratización de la energía</strong> y a <strong>favorecer la transición energética</strong> hacia un modelo 100% renovable, además recibes <strong>energía descentralizada</strong> y de <strong>producción local</strong>, compartida con tu vecindario.
  </p>
  <p>
    A menudo, participar en GURB también comporta <strong>beneficios económicos,</strong> puesto que supone un ahorro en tu factura de la luz. Creemos que ahora es un buen momento para hacer un repaso de cómo está yendo.
  </p>
  <p>
    Durante el tiempo que llevas participando en el proyecto y, según tu cuota de participación (${object.beta_kw} kW):
  </p>
  <ul>
    <li>
      Se te han <strong>asignado un total de ${locale.format_string('%.2f', env['saving']['kwh_generacio_neta'], grouping=True)} kWh</strong> de energía.
    </li>
    <li>
      De esa energía has <strong>autoconsumido</strong> (energía que consumes directamente cuando la instalación está generando) <strong>${locale.format_string('%.2f', env['saving']['kwh_autoconsumits'], grouping=True)} kWh,</strong> que supone un ${locale.format_string('%.2f', env['saving']['percentatge_autoconsumida'], grouping=True)} % de la producción asignada.
    </li>
    <li>
      La energía que no has utilizado y que ha ido a parar a la red de distribución y, por tanto, ha generado un <strong>excedente a compensar ha sido de ${locale.format_string('%.2f', env['saving']['kwh_excedents'], grouping=True)} kWh.</strong>
    </li>
    <li>
      La energía autoconsumida ha supuesto un <strong>${locale.format_string('%.2f', env['saving']['percentatge_autoconsum'], grouping=True)} %</strong> de tu consumo total durante este tiempo. Esto significa que si no tuvieras el servicio GURB, sería energía que pagarías tal y como pagas la energía procedente de la red de distribución.
    </li>
    <li>
      La energía que has utilizado y que no provenía de las placas, y que por tanto <strong>ha venido de la red de distribución, ha sido de ${locale.format_string('%.2f', env['saving']['kwh_consumits'], grouping=True)} kWh.</strong>
    </li>
  </ul>
  <figure class="table">
    <table style="background-color: #FFCDB5; border: 4px solid #FF632B; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
        <tbody>
            <tr>
                <td>
                  <strong>Esto te ha supuesto un ahorro total de ${locale.format_string('%.2f', env['saving']['estalvi_amb_impostos'], grouping=True)} euros</strong> (este cálculo tiene en cuenta la cuota GURB que pagas mensualmente en la factura y los impuestos asociados).
                </td>
              </tr>
          </tbody>
      </table>
  </figure>
  <small>Los datos de consumo son datos aportados por la empresa de distribución eléctrica y el cálculo está realizado en base a esta información.</small>
  <p>
    Queremos agradecerte especialmente tu participación y confianza una vez más a Som Energia. Gracias a tu colaboración, la cooperativa puede seguir trabajando para cumplir con nuestra misión, <strong>transformar el modelo energético poniendo el poder en manos de la ciudadanía.</strong>
  </p>
  <p>
    Esperamos que toda esta información te haya sido útil y te resulte interesante. De nuevo, muchas gracias por tu confianza en la cooperativa. Si tienes cualquier duda puedes escribirnos a <a href="mailto:gurb@somenergia.coop">gurb@somenergia.coop</a>.
  </p>
  <p>
    Saludos,
  </p>
  <p>
    Som Energia <br/>
    <a href="https://www.somenergia.coop/es?mtm_cid=20251121&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">www.somenergia.coop</a>
  </p>
%endif
${plantilla_footer}
