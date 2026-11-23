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
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
    email_o = object.pool.get('report.backend.mailcanvipreus')
    data = email_o.get_data(object._cr, object._uid, object.id, context={'lang': object.partner_id.lang})

    ca = data['lang'] == 'ca_ES'
    es_20 = data['tarifa_acces'] == '2.0TD'
    indexada = data['mode_facturacio'] == 'index'
    periodes_energia = [('P1', 'Punta'), ('P2', 'Pla' if ca else 'Llano'), ('P3', 'Vall' if ca else 'Valle')] if es_20 else [('P{}'.format(i), 'P{}'.format(i)) for i in range(1, 7)]
    periodes_potencia = [('P1', 'Punta'), ('P2', 'Vall' if ca else 'Valle')]
%>

<%def name="taula_preus(antics, nous, antics_imp, nous_imp, periodes, ca)">
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td colspan="4">
          <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
              <td width="20%" class="purchase_borders"><p class="f-fallback" style="margin: 10px 0"></p></td>
              <td width="20%" class="purchase_borders" style="text-align: center;">
                <p class="f-fallback" style="margin: 10px 0"><strong>${'Període' if ca else 'Periodo'}</strong></p>
              </td>
              <td width="30%" class="purchase_borders" style="text-align: center;">
                <p class="f-fallback" style="margin: 10px 0"><strong>${'Preus actuals' if ca else 'Precios actuales'}</strong></p>
              </td>
              <td width="30%" class="purchase_borders" style="text-align: center;">
                <p class="f-fallback" style="margin: 10px 0"><strong>${'Preus nous' if ca else 'Precios nuevos'}</strong></p>
              </td>
            </tr>
            % for etiqueta, preus_antics, preus_nous in [(('Sense impostos' if ca else 'Sin impuestos'), antics, nous), (('Amb impostos' if ca else 'Con impuestos'), antics_imp, nous_imp)]:
              % for i, (periode, nom) in enumerate(periodes):
                <tr>
                  % if i == 0:
                    <td class="purchase_borders" valign="middle" rowspan="${len(periodes)}">
                      <p class="f-fallback" style="margin: 10px 0"><strong>${etiqueta}</strong></p>
                    </td>
                  % endif
                  <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
                    <p class="f-fallback" style="margin: 10px 0">${nom}</p>
                  </td>
                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                    <p class="f-fallback" style="margin: 10px 0">${preus_antics[periode]}</p>
                  </td>
                  <td class="purchase_borders" style="text-align: center;" valign="middle">
                    <p class="f-fallback" style="margin: 10px 0">${preus_nous[periode]}</p>
                  </td>
                </tr>
              % endfor
            % endfor
          </table>
        </td>
      </tr>
    </table>
</%def>

${plantilla_header}

<!-- MAILDEV_CODE: ${data['codi_polissa']} -->

<p>Hola${data['nom_titular']} <br/></p>

% if data['modcon'] in ['index', 'atr']:
    <figure class="table">
      <table style="background-color: #e3e8df; padding-top: 1em; padding-left: 2em; padding-right: 2em; padding-bottom: 1em;">
        <tbody>
          <tr>
            <td>
              % if ca:
                % if data['modcon'] == 'index':
                  <p>Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 de gener, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.</p>
                  % if es_20:
                    <p>La tarifa ${data['tarifa_acces']} indexada augmentarà lleugerament el preu de la potència. Pots veure els <strong><a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-indexada">nous preus de la tarifa 2.0TD indexada</a></strong> al nostre web i a <a target="_blank" href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/actualizacio-tarifes-1-gener">aquest article</a> del blog.</p>
                  % else:
                    <p>Els preus de la <strong>tarifa ${data['tarifa_acces']} indexada</strong> no varien. Els pots trobar <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">al nostre web</a>.</p>
                  % endif
                % else:
                  <p>Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} períodes</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} indexada, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 de gener, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa indexada.</p>
                  <p>Els preus de la <strong>tarifa ${data['tarifa_acces']} períodes també variaran</strong>. Pots trobar l'explicació a <a target="_blank" href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/actualizacio-tarifes-1-gener">aquest article</a> del blog, i el detall dels preus els tens <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-periodes">al nostre web</a>.</p>
                % endif
                <p>T’adjuntem en aquest correu el teu contracte actualitzat amb els nous preus de la <strong>tarifa ${'indexada' if data['modcon'] == 'index' else 'períodes'}</strong> que se t’aplicarà. Si hi estàs d’acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament.</p>
              % else:
                % if data['modcon'] == 'index':
                  <p>Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} periodos, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa de periodos.</p>
                  % if es_20:
                    <p>En la tarifa ${data['tarifa_acces']} indexada aumentará ligeramente el precio de la potencia. Puedes ver los <strong><a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-indexada">nuevos precios de la tarifa 2.0TD indexada</a></strong> en nuestra web y en <a target="_blank" href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/actualizacion-tarifas-1-enero">este artículo</a> del blog.</p>
                  % else:
                    <p>Los precios de la <strong>tarifa ${data['tarifa_acces']} indexada</strong> no varían. Los puedes encontrar en <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/empresa-indexada">nuestra web</a>.</p>
                  % endif
                % else:
                  <p>Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} periodos</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} indexada, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de enero, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa indexada.</p>
                  <p>Los precios de la <strong>tarifa ${data['tarifa_acces']} periodos también variarán</strong>. Puedes encontrar la explicación en <a target="_blank" href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/actualizacion-tarifas-1-enero">este artículo</a> del blog, y el detalle de los precios lo tienes en <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-periodos">nuestra web</a>.</p>
                % endif
                <p>Te adjuntamos en este correo tu contrato actualizado con los nuevos precios de la <strong>tarifa ${'indexada' if data['modcon'] == 'index' else 'periodos'}</strong> que se te aplicará. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente.</p>
              % endif
            </td>
          </tr>
        </tbody>
      </table>
    </figure>
% endif

% if ca:
    % if indexada:
      <p>L’1 de gener modificarem els preus de la tarifa 2.0TD indexada (la que tens ara contractada).</p>
      <p>En concret, variarà el preu de la potència, ja que hi hem augmentat lleugerament el marge per a la viabilitat de la cooperativa.</p>
    % else:
      % if es_20:
        <p>El pròxim 1 de gener actualitzem els preus de la <strong>tarifa per períodes</strong> (la que tens contractada actualment) a causa de l’increment sostingut del cost de l’energia al mercat elèctric durant els darrers mesos.</p>
        <p>Fins ara, hem assumit aquest sobrecost des de la cooperativa per evitar traslladar-lo a la teva factura. Tanmateix, l’evolució del mercat elèctric ens obliga a actualitzar els preus de l’energia i de la potència per garantir l’equilibri econòmic del projecte.</p>
      % else:
        <p>El pròxim 1 de gener actualitzem els preus de la <strong>tarifa ${data['tarifa_acces']} períodes</strong> a causa de l’increment sostingut del cost de l’energia al mercat elèctric durant els darrers mesos.</p>
        <p>Fins ara, hem assumit aquest sobrecost des de la cooperativa per evitar traslladar-lo a la teva factura. Tanmateix, l’evolució del mercat elèctric ens obliga a actualitzar els preus de l’energia per garantir l’equilibri econòmic del projecte.</p>
      % endif
      <p>Com a entitat sense ànim de lucre, recordem que sempre <strong>traslladem únicament els costos reals</strong> per ajustar els preus al mínim indispensable.</p>
    % endif
    <p>Vols conèixer-ne tots els detalls? Llegeix l'article sencer <a target="_blank" href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/actualizacio-tarifes-1-gener">aquí</a>.</p>
    <p>A continuació et detallem els canvis.</p>

    <h1>Nous preus i comparativa amb preus actuals</h1>
    <p>A continuació tens una taula amb els nous preus (vigents a partir de l’1 de gener del 2027), i una comparació amb els preus actuals (fins a 31 de desembre del 2026) de la tarifa que tens contractada. Els impostos aplicats són l’${data['impostos_str']}, i l’impost elèctric del 5,11%.</p>
% else:
    % if indexada:
      <p>El 1 de enero modificaremos los precios de la tarifa indexada 2.0TD (la que tienes contratada actualmente).</p>
      <p>En concreto, variará el precio de la potencia, puesto que hemos aumentado ligeramente el margen para la viabilidad de la cooperativa.</p>
    % else:
      % if es_20:
        <p>El próximo 1 de enero actualizamos los precios de la <strong>tarifa por periodos</strong> (la que tienes contratada actualmente) debido al incremento sostenido del coste de la energía en el mercado eléctrico durante los últimos meses.</p>
        <p>Hasta ahora, hemos asumido este sobrecoste desde la cooperativa para evitar trasladarlo a tu factura. Sin embargo, la evolución del mercado eléctrico nos obliga a actualizar los precios de la energía y la potencia para garantizar el equilibrio económico del proyecto.</p>
      % else:
        <p>El próximo 1 de enero actualizamos los precios de la <strong>tarifa ${data['tarifa_acces']} periodos</strong> debido al incremento sostenido del coste de la energía en el mercado eléctrico durante los últimos meses.</p>
        <p>Hasta ahora, hemos asumido este sobrecoste desde la cooperativa para evitar trasladarlo a tu factura. Sin embargo, la evolución del mercado eléctrico nos obliga a actualizar los precios de la energía para garantizar el equilibrio económico del proyecto.</p>
      % endif
      <p>Como entidad sin ánimo de lucro, recordamos que siempre <strong>trasladamos únicamente los costes reales</strong> para ajustar los precios al mínimo indispensable.</p>
    % endif
    <p>¿Quieres conocer todos los detalles? Lee el artículo entero <a target="_blank" href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/actualizacion-tarifas-1-enero">aquí</a>.</p>
    <p>A continuación te detallamos los cambios.</p>

    <h1>Nuevos precios y comparativa con precios actuales</h1>
    <p>A continuación tienes una tabla con los nuevos precios (vigentes a partir del 1 de enero de 2027), y una comparación con los precios actuales (hasta 31 de diciembre de 2026) de la tarifa que tienes contratada. Los impuestos aplicados son ${data['impostos_str']}, y el impuesto eléctrico del 5,11%.</p>
% endif

% if not indexada:
    <h2>Tarifa ${data['tarifa_acces']} ${'períodes' if ca else 'periodos'}</h2>
    <p><strong>${'Preu del terme d’energia (en euros/kWh)' if ca else 'Precio del término de energía (en euros/kWh)'}</strong></p>
    ${taula_preus(data['preus_antics']['te'], data['preus_nous']['te'], data['preus_antics_imp']['te'], data['preus_nous_imp']['te'], periodes_energia, ca)}
% else:
    <h2>Tarifa indexada 2.0TD</h2>
% endif
% if es_20:
    <p><strong>${'Preu del terme de potència (en euros/kW a l’any)' if ca else 'Precio del término de potencia (en euros/kW al año)'}</strong></p>
    ${taula_preus(data['preus_antics']['tp'], data['preus_nous']['tp'], data['preus_antics_imp']['tp'], data['preus_nous_imp']['tp'], periodes_potencia, ca)}
% endif

% if data['autoconsum']['compensacio'] and not indexada:
    % if ca:
      <h2>Autoproducció</h2>
      <p>En el cas de l’autoproducció, <strong>el preu de compensació dels excedents es manté igual</strong>. L’encariment que motiva aquesta actualització de tarifes s’ha produït en les hores no solars; en canvi, el valor de l’energia durant les hores de sol no ha variat. Per tant, tampoc es modifica la compensació simplificada per a les persones que teniu instal·lacions d’autoproducció.</p>
    % else:
      <h2>Autoproducción</h2>
      <p>En el caso de la autoproducción, <strong>el precio de compensación de los excedentes se mantiene igual</strong>. El encarecimiento que motiva esta actualización de tarifas se ha producido en las horas no solares; sin embargo, el valor de la energía durante las horas de sol no ha variado. Por tanto, tampoco se modifica la compensación simplificada para las personas que tenéis instalaciones de autoproducción.</p>
    % endif
% endif

% if ca:
    <h1>Estimació</h1>
    % if data['origen'] in ['pdf', 'consums_periods']:
      <p>Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l’energia i la potència durant un any, si apliquéssim els preus actuals i si apliquéssim els preus nous. L’estimació l’hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i no inclou el lloguer de comptador, ni els costos dels Serveis d’Ajust.</p>
    % elif data['origen'] == 'cnmc':
      <p>Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l’energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L’estimació l’hem fet a partir de les dades que tenim dels teus consums anteriors (sense tenir en compte ni el lloguer de comptador, ni els costos dels Serveis d’Ajust), extrapolant-les segons el consum mitjà que sol haver-hi a cada mes (segons dades de la Comissió Nacional dels Mercats i la Competència). Amb això n’hem obtingut un consum anual, que és el que fem servir per a la comparació.</p>
    % elif data['origen'] == 'estadistic':
      <p>Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l’energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L’estimació l’hem fet en funció de la potència contractada més alta que tens (${data['potencia']} kW), l’ús d’electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense el lloguer de comptador ni els Serveis d’Ajust.</p>
    % elif data['origen'] == 'indexada':
      <p>Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del cost de l’electricitat amb aquest augment de la potència, i l’hem comparat amb el cost amb la tarifa actual. L’estimació l’hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, sense el lloguer de comptador ni els Serveis d’Ajust.</p>
    % endif
    <p>L’estimació la pots veure sense impostos i amb impostos inclosos (l’${data['impostos_str']} i l’impost elèctric del 5,11%).</p>
    <p><strong>Cost anual estimat, en euros/any, del subministrament (energia i potència):</strong></p>
% else:
    <h1>Estimación</h1>
    % if data['origen'] in ['pdf', 'consums_periods']:
      <p>Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, si aplicáramos los precios actuales y si aplicáramos los precios nuevos. La estimación la hemos realizado a partir de los datos que tenemos respecto a lo que has consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, y no incluye el alquiler de contador, ni los costes de los Servicios de Ajuste.</p>
    % elif data['origen'] == 'cnmc':
      <p>Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los precios nuevos. La estimación la hemos hecho a partir de los datos que tenemos de tus consumos anteriores (sin tener en cuenta ni el alquiler de contador, ni los costes de los Servicios de Ajuste), extrapolándolos según el consumo medio que suele haber en cada mes (según datos de la Comisión Nacional de los Mercados y la Competencia). Con esto hemos obtenido un consumo anual, que es el que utilizamos para la comparación.</p>
    % elif data['origen'] == 'estadistic':
      <p>Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho en función de la potencia contratada más alta que tienes (${data['potencia']} kW), el uso de electricidad que suele haber con esta potencia y cogiendo de referencia un contrato estándar, sin el alquiler de contador ni los Servicios de Ajuste.</p>
    % elif data['origen'] == 'indexada':
      <p>Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> del coste de la electricidad con este aumento de la potencia, y lo hemos comparado con el coste con la tarifa actual. La estimación la hemos hecho a partir de los datos que tenemos respecto a lo consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, sin el alquiler de contador ni los Servicios de Ajuste.</p>
    % endif
    <p>La estimación la puedes ver sin impuestos y con impuestos incluidos (${data['impostos_str']} y el impuesto eléctrico del 5,11%).</p>
    <p><strong>Coste anual estimado, en euros/año, del suministro (energía y potencia):</strong></p>
% endif

<table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
  <tr>
    <td colspan="3">
      <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
        <tr>
          <td width="24%" class="purchase_borders"><p class="f-fallback" style="margin: 10px 0"></p></td>
          <td width="38%" class="purchase_borders" style="padding-left: 5px; padding-right: 5px; text-align: center;">
            <p class="f-fallback" style="margin: 10px 0">${'Cost estimat amb els preus actuals' if ca else 'Coste estimado con los precios actuales'}</p>
          </td>
          <td width="38%" class="purchase_borders" style="padding-left: 5px; padding-right: 5px; text-align: center;">
            <p class="f-fallback" style="margin: 10px 0">${'Cost estimat amb els nous preus' if ca else 'Coste estimado con los nuevos precios'}</p>
          </td>
        </tr>
        % for etiqueta, antic, nou in [(('Sense impostos' if ca else 'Sin impuestos'), 'preu_vell', 'preu_nou'), (('Amb impostos' if ca else 'Con impuestos'), 'preu_vell_imp', 'preu_nou_imp')]:
          <tr>
            <td class="purchase_borders" valign="middle"><p class="f-fallback" style="margin: 10px 0">${etiqueta}</p></td>
            <td class="purchase_borders" style="text-align: center;" valign="middle"><p class="f-fallback" style="margin: 10px 0">${data[antic]}</p></td>
            <td class="purchase_borders" style="text-align: center;" valign="middle"><p class="f-fallback" style="margin: 10px 0">${data[nou]}</p></td>
          </tr>
        % endfor
      </table>
    </td>
  </tr>
</table>
<br/>

% if ca:
    <p>Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l’ús d’energia que finalment facis, altres variacions de preus durant l’any, o canvis que hi pugui haver al mercat elèctric.</p>
    % if indexada:
      <p>Com sempre, pots trobar la informació, els preus i la fórmula de la tarifa indexada al nostre web, <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-indexada">apartat tarifa indexada</a>, i al <a target="_blank" href="https://ca.support.somenergia.coop/category/1359-les-tarifes-indexades">Centre d’Ajuda</a>.</p>
    % endif
% else:
    <p>Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente hagas, otras variaciones de precios durante el año, o cambios que puedan producirse en el mercado eléctrico.</p>
    % if indexada:
      <p>Como siempre, puedes encontrar la información, precios y fórmula de la tarifa indexada en nuestra web, <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-indexada">apartado tarifa indexada</a>, o en el <a target="_blank" href="https://es.support.somenergia.coop/category/1361-las-tarifas-indexadas">Centro de ayuda</a>.</p>
    % endif
% endif

% if data['te_gkwh']:
    <h1>Generation kWh</h1>
    % if ca:
      <p>En el cas de la tarifa complementària Generation kWh que tens contractada, el cost base de l’electricitat no varia, perquè prové directament de la producció de les nostres plantes i és aliè a la volatilitat del mercat. Tot i això, el preu final s’ajusta lleugerament per actualitzar altres costos regulats de la comercialització.</p>
      <p>A continuació pots veure com queden els preus de la <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-generationkwh">tarifa Generation kWh</a>.</p>
      <p>Els impostos aplicats són l’${data['impostos_str']}, i l’impost elèctric del 5,11%.</p>
      <p><strong>Generation kWh: preu del terme d’energia (en euros/kWh)</strong></p>
    % else:
      <p>En el caso de la tarifa complementaria Generation kWh que tienes contratada, el coste base de la electricidad no varía, porque procede directamente de la producción de nuestras plantas y es ajeno a la volatilidad del mercado. Sin embargo, el precio final se ajusta ligeramente para actualizar otros costes regulados de la comercialización.</p>
      <p>A continuación puedes ver cómo quedan los precios de la <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-generationkwh">tarifa Generation kWh</a>.</p>
      <p>Los impuestos aplicados son ${data['impostos_str']}, y el impuesto eléctrico del 5,11%.</p>
      <p><strong>Generation kWh: precio del término de energía (en euros/kWh)</strong></p>
    % endif
    ${taula_preus(data['preus_antics_generation'], data['preus_nous_generation'], data['preus_antics_generation_imp'], data['preus_nous_generation_imp'], periodes_energia, ca)}
% endif

% if ca:
    <p>Com et dèiem més amunt, al nostre <a target="_blank" href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/actualizacio-tarifes-1-gener">blog</a> trobaràs més detalls del canvi de preus, i a la pàgina web pots consultar en qualsevol moment <a target="_blank" href="https://www.somenergia.coop/ca/tarifes-llum/domestic-periodes">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l’apartat <a target="_blank" href="https://www.somenergia.coop/ca/historic-tarifa-periodes">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de desembre i els de períodes anteriors.</p>

    <h1 style="font-size: 16px">Informació legal</h1>
    <p class="p-legal">La <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/legal/ca/CCGG/Condicions-Generals-contracte-subministrament-energia-electrica-SomEnergia.pdf">clàusula contractual de les Condicions Generals</a> que ens autoritza a fer aquest canvi de preus de les tarifes ${'indexada' if indexada else 'períodes'} és la clàusula 3.3.</p>
    <p class="p-legal">Pots accedir al comparador d’ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través <a target="_blank" href="https://comparador.cnmc.gob.es/">d’aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents d’algunes de les comercialitzadores del mercat lliure. Tingues en compte que les tarifes de Som Energia no hi estan incloses.</p>
    <p class="p-legal">
      % if data['modcon']:
        Hem
      % else:
        T’adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d’acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem
      % endif
      d’informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te de tarifa (<a target="_blank" href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament enviant-nos una còpia del <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/Desistiment_Plantilla_CAT.pdf">document de desistiment</a>, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
    </p>
    <br/>
    <br/>
    <p>Una salutació cordial,</p>
    <p>Som Energia <br/><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a></p>
% else:
    <p>Como te decíamos más arriba, en nuestro <a target="_blank" href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/actualizacion-tarifas-1-enero">blog</a> encontrarás más detalles del cambio de precios, y en la página web puedes consultar en cualquier momento <a target="_blank" href="https://www.somenergia.coop/es/tarifas-luz/domestico-periodos">todas las tarifas</a>. Si quieres hacer comparaciones, puedes acceder al apartado <a target="_blank" href="https://www.somenergia.coop/es/historico-tarifa-periodos">histórico de tarifas</a>, donde están también los precios vigentes hasta el 31 de diciembre y los de períodos anteriores.</p>

    <h1 style="font-size: 16px">Información legal</h1>
    <p class="p-legal">La <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/legal/es/CCGG/Condiciones-Generales-contrato-suministro-energia-electrica-SomEnergia.pdf">cláusula contractual de las Condiciones Generales</a> que nos autoriza a realizar este cambio de precios de las tarifas ${'indexada' if indexada else 'periodos'} es la cláusula 3.3.</p>
    <p class="p-legal">Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a target="_blank" href="https://comparador.cnmc.gob.es/">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de algunas de las comercializadoras del mercado libre. Ten en cuenta que las tarifas de Som Energia no están incluidas.</p>
    <p class="p-legal">
      % if data['modcon']:
        Debemos
      % else:
        Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos
      % endif
      informarte de que si, por alguna razón, este cambio de precios te hiciese replantear seguir con esta tarifa, podrías cambiarte de tarifa (<a target="_blank" href="https://es.support.somenergia.coop/article/1345-modificacion-de-la-tarifa-de-periodos-a-indexada-y-de-indexada-a-periodos">a través de tu Oficina Virtual</a>), o podrías dar de baja tu contrato con nosotros, bien comunicándolo directamente enviándonos una copia del <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/Desistimiento_Plantilla_CAST.pdf">documento de desistimiento</a>, o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejamos de suministrarte energía, con los precios vigentes en cada momento.
    </p>
    <br/>
    <br/>
    <p>Un cordial saludo,</p>
    <p>Som Energia <br/><a href="https://www.somenergia.coop/es">www.somenergia.coop</a></p>
% endif
${plantilla_footer}
