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
  <p>
    Aquests dies estem de celebració! Ara ja fa un any que vàrem posar en marxa <strong>el primer projecte GURB a Mataró.</strong>
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
    Durant el temps que portes participant al projecte i, segons la teva quota de participació (${object.beta_kw} kW):
  </p>
  <ul>
    <li>
      Se t'han <strong>assignat un total de ${env['saving']['kwh_generacio_neta']} kWh</strong> d'energia.
    </li>
    <li>
      D'aquesta energia has <strong>autoconsumit</strong> (energia que consumeixes directament quan la instal·lació està generant) <strong>${env['saving']['kwh_autoconsumits']}kWh,</strong>  que suposa un [% AUTO] de la producció assignada.
    </li>
    <li>
      L'energia que no has fet servir i que ha anat a parar a la xarxa de distribució i per tant ha generat un <strong>excedent a compensar ha estat de ${env['saving']['kwh_excedents']} kWh.</strong>
    </li>
    <li>
      L'energia autoproduïda que has rebut de la instal·lació gràcies a la teva participació a GURB ha suposat un <strong>${object.beta_percentage}%</strong> del teu consum total durant aquest temps.
    </li>
    <li>
      L'energia que has utilitzat i que no provenia de les plaques, i que per tant <strong>ha vingut de la xarxa de distribució, ha estat de ${env['saving']['estalvi_amb_impostos']} kWh.</strong>
    </li>
    <li>
      <strong>Això t'ha suposat un estalvi total de ${env['saving']['estalvi_amb_impostos']} euros</strong> (aquest càlcul no té en compte la quota d'adhesió).
    </li>
  </ul>
  <p>
    Les dades de consum són dades aportades per l’empresa de distribució elèctrica i el càlcul està fet en base a aquesta informació.
  </p>
  <p>
    <strong>Com pots veure aquestes dades?</strong> A la factura mensual de Som Energia pots veure el detall de l'energia autoconsumida, l'energia consumida de xarxa i l'energia excedentària.
  </p>
  <p>
    <strong>I què pots fer per treure'n un major rendiment?</strong> Intentar moure al màxim els teus consums energètics a les hores solars, que són les hores de màxima producció.
  </p>
  <p>
    Tingues present la teva participació per poder consumir de manera esglaonada dins d'aquestes hores: si engegues tots els electrodomèstics dins del mateix interval horari, és molt probable que amb la quantitat d'energia assignada no en tinguis prou i hauries de consumir energia de la xarxa.
  </p>
  <p>
    Alguns electrodomèstics ja tenen la funció de programació horària incorporada per programar-ne el seu funcionament. Això et permetria per exemple programar la rentadora a hores solars. Si els teus aparells no tenen aquesta opció, pots comprar temporitzadors que et permetin programar electrodomèstics. També hi ha sistemes de domòtica que, de manera remota i  intel·ligent, compleixen aquesta funció.
  </p>
  <p>
    Volem agrair-te especialment la teva participació i la teva confiança un cop més a Som Energia. Gràcies a la teva col·laboració la cooperativa pot continuar treballant per complir la nostra missió, <strong>transformar el model energètic posant el poder en mans de la ciutadania.</strong>
  </p>
  <p>
    Esperem que tota aquesta informació t'hagi estat útil i et resulti interessant. Altre cop, moltes gràcies per la teva confiança en la cooperativa. Si tens qualsevol dubte ens pots escriure a gurb@somenergia.coop.
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
    ¡Estos días estamos de celebración! Hace ya un año que pusimos en marcha el primer proyecto GURB en Mataró.
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
      Se te han <strong>asignado un total de ${env['saving']['kwh_generacio_neta']} kWh</strong> de energía.
    </li>
    <li>
      De esa energía has <strong>autoconsumido</strong> (energía que consumes directamente cuando la instalación está generando) <strong>${env['saving']['kwh_autoconsumits']} kWh,</strong> que supone un [% AUTO] de la producción asignada.
    </li>
    <li>
      La energía que no has utilizado y que ha ido a parar a la red de distribución y por tanto ha generado un <strong>excedente a compensar ha sido de ${env['saving']['kwh_excedents']} kWh.</strong>
    </li>
    <li>
      La energía autoproducida que ha recibido de la instalación gracias a tu participación en GURB ha supuesto un <strong>${object.beta_percentage} %</strong> de tu consumo total durante este tiempo.
    </li>
    <li>
      La energía que has utilizado y que no provenía de las placas, y que por tanto <strong>ha venido de la red de distribución, ha sido de xx kWh.</strong>
    </li>
    <li>
      <strong>Esto te ha supuesto un ahorro total de ${env['saving']['estalvi_amb_impostos']} euros</strong> (este cálculo no tiene en cuenta la cuota de adhesión).
    </li>
  </ul>
  <p>
    <strong>¿Cómo puedes ver estos datos?</strong> En la factura mensual de Som Energia puedes ver el detalle de la energía autoconsumida, la energía consumida de red y la energía excedentaria.
  </p>
  <p>
    ¿Y qué puedes hacer para sacarle un mayor rendimiento? Intentar mover al máximo tus consumos energéticos en las horas solares, que son las horas de máxima producción.
  </p>
  <p>
    Ten presente tu participación para poder consumir de forma escalonada dentro de estas horas: si pones en marcha todos los electrodomésticos dentro del mismo intervalo horario, es muy probable que con la cantidad de energía asignada no tengas suficiente y deberías consumir energía de la red.
  </p>
  <p>
    Algunos electrodomésticos ya tienen la función de programación horaria incorporada para programar su funcionamiento. Esto te permitiría por ejemplo programar la lavadora en horas solares. Si tus aparatos no tienen esa opción, puedes comprar temporizadores que te permitan programar electrodomésticos. También existen sistemas de domótica que, de forma remota e inteligente, cumplen esta función.
  </p>
  <p>
    Queremos agradecerte especialmente tu participación y confianza una vez más a Som Energia. Gracias a tu colaboración la cooperativa puede seguir trabajando para cumplir con nuestra misión, transformar el modelo energético poniendo el poder en manos de la ciudadanía.
  </p>
  <p>
    Esperamos que toda esta información te haya sido útil y te resulte interesante. De nuevo, muchas gracias por tu confianza en la cooperativa. Si tienes cualquier duda puedes escribirnos a gurb@somenergia.coop.
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