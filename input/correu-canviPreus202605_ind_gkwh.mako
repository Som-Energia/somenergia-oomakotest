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
    L’1 de maig actualitzarem la forma de calcular la tarifa Generation kWh. Davant l’actual context d’inestabilitat geopolítica, el preu de l'electricitat al mercat està pujant; tot i això, <strong>el model del Generation kWh et protegeix de part d’aquesta pujada</strong>, ja que el preu de la tarifa Generation kWh es calcula segons els costos reals de generació de les plantes i no li afecta la pujada dels combustibles fòssils.
  </p>
  <p>
    El canvi principal que veuràs és sobre els <strong>Serveis d’Ajust</strong>. Són costos obligatoris que fixa Red Eléctrica Española (REE) per <strong>assegurar el correcte funcionament la xarxa</strong>. Fins ara, els incloíem com una previsió dins el preu de l’energia, però la inestabilitat actual fa que el seu import variï constantment i no el puguem preveure amb antelació. Per això, per responsabilitat i per no cobrar-te de més "per si de cas", a partir d'ara te'ls cobrarem a part segons l’import real que marqui REE a cada factura. Per orientar-te, la mitjana d’aquest preu al mes de març ha sigut de 0,028 €/kWh.
  </p>
  <p>
    Vols conèixer tots els detalls? Llegeix l’article sencer <strong><a target="_blank" href="https://www.somenergia.coop/ca/actualitat/tarifes-sector-electric/actualizacio-tarifes-1-de-maig">aquí</a></strong>.
  </p>
  <p>
    A continuació, podràs veure la comparativa dels preus actuals amb els nous preus. Els impostos aplicats són l'${data['impostos_str']}, i l’impost elèctric del 0,5%, en els dos casos amb les rebaixes d’impostos que ha aprovat el Govern.
  </p>
  <h3>Generation kWh: preu del terme d’energia (en euros/kWh):</h3>
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
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P1']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P1']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P2</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P2']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P2']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P3</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P3']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P3']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P4</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P4']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P4']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P5</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P5']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P5']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P6</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P6']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P6']}</p>
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
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P1']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P1']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P2</p>
            </td>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P2']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P2']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P3</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P3']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P3']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P4</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P4']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P4']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P5</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P5']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P5']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P6</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P6']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P6']}</p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br/>
  <p>
    Al web pots consultar <a href="https://www.somenergia.coop/ca/tarifes-llum/domestic-generationkwh?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">els preus de la tarifa Generation kWh</a>. Pots comparar-les amb les de dates anteriors <a href="https://www.somenergia.coop/ca/historic-tarifa-periodes?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">aquí</a>.
  </p>
  <p>
    Et recordem que les condicions del Generation kWh estan detallades a les <a href="https://back.somenergia.coop/storage/app/media/DOCS/Condicions-Generals-Contracte-Autoproduccio-Collectiva-Generation-kWh-CA.pdf">Condicions Generals del Generation kWh</a>.
  </p>
  <p>
    Aprofitem per donar-te les gràcies un cop més per la teva participació al Generation kWh. Aquest tipus de suport és un dels que ens ajuda a caminar cap a la transformació energètica.
  </p>
  <h3 style="font-size: 16px">Informació legal</h3>
  <p class="p-legal">
    Pots accedir al comparador d’ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través d’<a href="https://comparador.cnmc.gob.es">aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents d’algunes de les comercialitzadores del mercat lliure. Tingues en compte que les tarifes de Som Energia no hi estan incloses.
  </p>
  <p class="p-legal">
    T’adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d’acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d’informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, pots escriure’ns un correu a <a href="mailto:info@somenergia.coop">info@somenergia.coop</a>. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència a cap tarifa. Així doncs, si decidissis marxar del Generation kWh, només et facturaríem el consum realitzat fins al dia en què se’t deixés d’aplicar, amb els preus vigents a cada moment.
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
  <p>
    El 1 de mayo actualizaremos la forma de calcular la tarifa de Generation kWh. Ante el actual contexto de inestabilidad geopolítica, el precio de la electricidad en el mercado está subiendo; sin embargo, <strong>el modelo del Generation kWh te protege de parte de esta subida</strong>, ya que el precio de la tarifa Generation kWh se calcula según los costes reales de generación de las plantas y no le afecta la subida de los combustibles fósiles.
  </p>
  <p>
    El cambio principal que verás es sobre los <strong>Servicios de Ajuste</strong>. Son costes obligatorios que fija Red Eléctrica Española (REE) por <strong>asegurar el correcto funcionamiento la red</strong>. Hasta ahora, los incluíamos como una previsión dentro del precio de la energía, pero la inestabilidad actual hace que su importe varíe constantemente y no podamos preverlo con antelación. Por eso, por responsabilidad y por no cobrarte de más "por si acaso", a partir de ahora te los cobraremos aparte según el importe real que marque REE en cada factura. Para orientarte, la media de este precio en marzo ha sido de 0,028 €/kWh.
  </p>
  <p>
    ¿Quieres conocer todos los detalles? Lee el artículo entero <strong><a target="_blank" href="https://www.somenergia.coop/es/actualidad/tarifas-sector-electrico/actualizacion-tarifas-1-de-mayo">aquí</a></strong>.
  </p>
  <p>
    A continuación podrás ver la comparativa de los precios actuales con los nuevos precios. Los impuestos aplicados son el ${data['impostos_str']}, y el impuesto eléctrico del 0,5%, en ambos casos con las rebajas de impuestos que ha aprobado el Gobierno.
  </p>
  <h3>Generation kWh: precio del término de energía (en euros/kWh):</h3>
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
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P1']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P1']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P2</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P2']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P2']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P3</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P3']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P3']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P4</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P4']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P4']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P5</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P5']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P5']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P6</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation']['P6']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation']['P6']}</p>
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
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P1']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P1']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P2</p>
            </td>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P2']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P2']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P3</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P3']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P3']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P4</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P4']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P4']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P5</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P5']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P5']}</p>
            </td>
          </tr>
          <tr>
            <td class="purchase_borders" style="text-align: center; white-space: nowrap;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">P6</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_antics_generation_imp']['P6']}</p>
            </td>
            <td class="purchase_borders" style="text-align: center;" valign="middle">
              <p class="f-fallback"  style="margin: 10px 0">${data['preus_nous_generation_imp']['P6']}</p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br/>
  <p>
    En la web puedes consultar <a href="https://www.somenergia.coop/ca/tarifes-llum/domestic-generationkwh?mtm_cid=20260330&mtm_campaign=canvi-preus-5-26&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">los precios de la tarifa Generation kWh</a>. Puedes compararlas con las de fechas anteriores <a href="https://www.somenergia.coop/es/historico-tarifa-periodos/?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">aquí</a>.
  </p>
  <p>
    Te recordamos que las condiciones del Generation kWh están detalladas en las <a href="https://back.somenergia.coop/storage/app/media/DOCS/Condiciones-Generales-Contrato-Autoproduccion-Colectiva-Generation-kWh-ES.pdf?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=ca&mtm_source=emailerp">Condiciones generales de Generation kWh</a>.
  </p>
  <p>
    Aprovechamos para darte las gracias una vez más por tu participación en el Generation kWh. Este tipo de soporte es uno de los que nos ayuda a caminar hacia la transformación energética.
  </p>
  <h3 style="font-size: 16px">Información legal</h3>
  <p class="p-legal">
    Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a href="https://comparador.cnmc.gob.es">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de algunas de las comercializadoras del mercado libre. Ten en cuenta que las tarifas de Som Energia no están incluidas.
  </p>
  <p class="p-legal">
    Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si estás de acuerdo, no es necesario que nos devuelvas el documento firmado, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos informarte de que si, por alguna razón, este cambio de precios te hiciese replantear seguir con esta tarifa, puedes escribirnos un correo a <a href="mailto:info@somenergia.coop">info@somenergia.coop</a>. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia a ninguna tarifa. Así pues, si decidieras marcharte del Generation kWh, sólo te facturaríamos el consumo realizado hasta el día en que se te dejara de aplicar, con los precios vigentes en cada momento.
  </p>
  <br/>
  <br/>
  <p>
    Un cordial saludo,
  </p>
  <p>
    Som Energia <br/>
    <a href="https://www.somenergia.coop/es?mtm_cid=20251127&mtm_campaign=canvi-preus&mtm_medium=L&mtm_content=es&mtm_source=emailerp">www.somenergia.coop</a>
  </p>
%endif
${plantilla_footer}