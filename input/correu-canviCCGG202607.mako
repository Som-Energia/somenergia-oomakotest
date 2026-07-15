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
  <p>A Som Energia apostem per la transparència i per mantenir-te sempre al corrent de tot el que afecta el teu subministrament. Per aquest motiu, volem informar-te que hem <strong>actualitzat el teu paquet contractual amb la cooperativa.</strong></p>

  <p>Aquesta revisió respon a la necessitat d'adaptar-nos a les noves normatives del sector elèctric (principalment el <a target="_blank" href="https://www.boe.es/buscar/act.php?id=BOE-A-2026-3212">Reial Decret 88/2026</a> i el <a target="_blank" href="https://www.boe.es/buscar/act.php?id=BOE-A-2026-6544">Reial Decret Llei 7/2026</a>) i, sobretot, aprofitem l'ocasió per introduir altres <strong>modificacions per aclarir conceptes tècnics, reforçar els teus drets, simplificar els tràmits i oferir-te més garanties com a persona consumidora.</strong></p>

  <p>Aquests són els punts més importants que has de saber:</p>

  <h1>1. Contractació, durada i noves garanties</h1>
  <ul>
    <li><strong>Accés directe amb la distribuïdora (Clàusula 1.1):</strong> Si compleixes amb els requisits legals per acollir-te a aquest dret, pots triar si fas el contracte d'accés directament amb la distribuïdora o si ho gestionem nosaltres.</li>
    <li><strong>Nou canal telefònic (Clàusula 3.1 i 9.4):</strong> A partir d'ara, sumem el telèfon com a nou canal de contractació i de modificacions contractuals, que s'afegeix al que ja tenies disponible per la pàgina web.</li>
    <li><strong>Més transparència abans de signar (Clàusula 3.2):</strong> Rebràs un resum de contractació clar amb la informació essencial del teu contracte abans de contractar.</li>
    <li><strong>Garanties per telèfon (Clàusula 3.2):</strong> Tindràs el contracte signat digitalment i, si ho demanes, la gravació i transcripció de la trucada.</li>
    <li><strong>Durada trimestral i pròrroga (Clàusula 3.3 i 12.2):</strong> El contracte es renova automàticament cada trimestre natural, excepte si t'avisem d'un canvi de preus o de la resolució anticipada del mateix amb 30 dies d'antelació.</li>
    <li><strong>Regulació de dipòsits (Clàusula 3.6):</strong> S'aclareix com es demana, es paga i es retorna el dipòsit de garantia en el moment de contractar.</li>
    <li><strong>Eliminació de garanties addicionals (Antiga clàusula 3.8 i 11.4):</strong> Ja no et podrem demanar fiances equivalents a l'última factura o al consum estimat durant la vigència del contracte ni per la reposició del subministrament.</li>
  </ul>

  <h1>2. Preus, actualització i facturació</h1>
  <ul>
    <li><strong>Serveis d'ajust (Clàusula 5.1):</strong> S'actualitza el text sobre els costos del sistema elèctric, sense cap canvi en el preu de la teva tarifa.</li>
    <li><strong>Comparador de la CNMC (Clàusula 5.2):</strong> S'inclou informació sobre el comparador oficial d'ofertes d'energia.</li>
    <li><strong>Actualització de preus (Clàusula 5.4, ii):</strong> S'avisarà amb 30 dies d'antelació i l'increment es limitarà al 50% de la pujada del mercat (ex: si el mercat puja 0,018 €/kWh, a la tarifa només s'hi sumaran 0,009 €/kWh).</li>
  </ul>

  <h3>Exemple pràctic d'actualització de preus:</h3>
  <p>Si el 8 de juny el preu per al mes de juliol cotitza a 78 €/MWh, i el dia 1 d'abril cotitzava a 60 €/MWh, la diferència és de 18 €/MWh. L'increment màxim aplicable a la teva tarifa al cap de 30 dies serà de 9 €/MWh (el 50% de 18 €/MWh), que es desglossa de la següent manera per períodes:</p>

  <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
    <tr>
      <td colspan="4">
        <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
          <tr>
            <td width="20%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Període tarifari</strong></td>
            <td width="26%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Preu abans de la notificació (€/kWh)</strong></td>
            <td width="27%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Augment registrat el 8 de juny</strong></td>
            <td width="27%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Preu màxim a aplicar al cap de 30 dies (€/kWh)</strong></td>
          </tr>
          <tr>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Punta</strong></td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,226</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,018 €/kWh (18 €/MWh)</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,226 + (0,018 / 2) = <strong>0,235</strong></td>
          </tr>
          <tr>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Plana</strong></td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,150</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,018 €/kWh (18 €/MWh)</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,150 + (0,018 / 2) = <strong>0,159</strong></td>
          </tr>
          <tr>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Vall</strong></td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,124</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,018 €/kWh (18 €/MWh)</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,124 + (0,018 / 2) = <strong>0,133</strong></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <ul>
    <li><strong>Errors de facturació de la distribuïdora (Clàusula 5.6):</strong> Si, per un error en la facturació de peatges i càrrecs, la distribuïdora factura menys quantitat de la que et tocava, haurà de fraccionar el pagament (màxim en 10 mesos). Si factura més quantitat de la que tocava, haurà de retornar l'import de la factura abonat de més amb interessos corresponents (interès legal + 1,5%).</li>
    <li><strong>Errors de facturació de Som Energia (Clàusula 7.4):</strong> Si per errors només imputables a Som Energia et cobrem menys energia de la que tocava, la diferència de preu pendent d'abonar es fraccionarà en diverses factures mensuals (màxim 1 any enrere); si cobrem de més, es torna tot l'import cobrat de més amb els interessos corresponents (interès legal + 1,5%).</li>
    <li><strong>Pagament amb targeta (Clàusula 7.7):</strong> S'activa l'opció de pagar amb targeta des del formulari de contractació, sense cap recàrrec, així com la signatura del mandat SEPA.</li>
  </ul>

  <h1>3. Gestions, canvis de titularitat, suspensions i baixes</h1>
  <ul>
    <li><strong>Canvi de comercialitzadora més ràpid (Clàusula 10.2):</strong> Tramitarem el teu canvi de comercialitzadora en 24 hores laborables, i el canvi serà efectiu en la majoria de casos en un màxim de 10 dies hàbils.</li>
    <li><strong>Més temps per a avisos i esmenes en cas de resolució anticipada del contracte (Clàusula 12.2):</strong> El preavís per resolució unilateral de contracte per part de Som Energia passa de 5 a 30 dies naturals, i el termini per esmenar un incompliment s'amplia de 5 a 15 dies hàbils.</li>
  </ul>

  <h1>4. Contractes amb autoconsum</h1>
  <ul>
    <li><strong>Gestor d'autoconsum (Clàusula 8):</strong> Podràs delegar tràmits a un gestor d'autoconsum, sempre que estigui autoritzat formalment.</li>
    <li><strong>Ajustos de saldo al Flux Solar (Clàusula 8.6):</strong> Si la distribuïdora corregeix una lectura antiga, regularitzarem el teu saldo de Sols en les factures següents.</li>
    <li><strong>Canvis de contracte amb Flux Solar (Clàusula 8.6):</strong> En cas de baixa, canvi de comercialitzadora, traspàs <strong>o subrogació</strong>, els Sols acumulats es perdran automàticament. L'única excepció on es conserven és si el canvi de titular es fa per defunció o per fusió d'empreses.</li>
  </ul>

  <h1>5. Modificacions del contracte i flexibilitat</h1>
  <ul>
    <li><strong>Modificacions àgils, però limitades (Clàusula 9.2):</strong> Som Energia podrà modificar el contracte directament per guanyar agilitat, però de forma molt restringida; només per canvis legals, ajustos tècnics de mercat, millores operatives o força major.</li>
    <li><strong>Garantia de preus i dret de rescissió (Clàusula 5.4):</strong> Aquesta flexibilitat mai permetrà canviar els preus de forma unilateral. T'avisarem amb 30 dies d'antelació i podràs rescindir el contracte immediatament i sense penalització.</li>
    <li><strong>Possibilitat de canvis simultanis (Clàusula 9.4):</strong> Abans, no podies modificar la tarifa contractada i fer altres sol·licituds a la vegada. Ara, s'elimina aquesta limitació.</li>
  </ul>

  <h1>6. Protecció de dades, responsabilitat i atenció</h1>
  <ul>
    <li><strong>Estudis de consum i privacitat (Clàusula 4.5 i 15.3):</strong> Es modifica el redactat que ja permet elaborar anàlisis d'hàbits de consum i compartir-los amb col·laboradors per fer estudis o millorar els serveis, però sempre amb dades totalment anonimitzades.</li>
    <li><strong>Actualització de la Força Major (Clàusula 13.2):</strong> S'exclou la responsabilitat de qualsevol de les parts en cas d'incompliment per causes que estan fora de control d'aquestes.</li>
    <li><strong>Horari d'atenció i jurisdicció competent (Clàusula 16.4, 18.3 i 19):</strong> L'horari d'atenció telefònica s'ajusta al calendari de festius de Catalunya i, en cas de conflicte judicial, prevaldran sempre els tribunals del teu propi domicili.</li>
  </ul>

  % if data['indexada'] or data['gurb'] or data['te_gkwh']:
    <p><strong>A banda d'aquestes novetats generals, també hi ha canvis específics relacionats amb els serveis o tarifes que tens contractats:</strong></p>
  % endif

  % if data['indexada']:
    <h1>Tarifa Indexada</h1>
    <ul>
      <li><strong>Preu per quarts d'hora (MTU) (Clàusula 2.2):</strong> El preu de l'energia i dels excedents es calcularà en blocs de 15 minuts en lloc de per hores, adaptant-nos al nou sistema de mercat. <strong>Això no canvia el preu final que pagues.</strong></li>
      <li><strong>Durada trimestral (Clàusula 3.4):</strong> El contracte passa a renovar-se automàticament de manera trimestral (per trimestres naturals).</li>
      <li><strong>Facturació sense dades reals (Clàusula 7.2 bis):</strong> Es modifica la forma de calcular el preu de l'energia quan no es disposen de dades reals per part de la distribuïdora.</li>
    </ul>
  % endif

  % if data['gurb']:
    <h1>Projecte GURB</h1>
    <ul>
      <li><strong>Més d'un autoconsum (Clàusula 2):</strong> Ara és compatible tenir GURB i un altre autoconsum (individual o col·lectiu), sempre que Som Energia sigui la comercialitzadora d'almenys un dels teus contractes.</li>
      <li><strong>Ampliació a 5 km (Clàusula 6.1 ii):</strong> El radi per poder participar s'amplia de 2 a 5 quilòmetres, facilitant que mantinguis el servei si et mudes de casa.</li>
      <li><strong>Canvis de potència (Clàusula 4.6):</strong> Si vols modificar la teva potència, caldrà que ho notifiquis primer a <a href="mailto:gurb@somenergia.coop">gurb@somenergia.coop</a>.</li>
      <li><strong>Baixa voluntària (Clàusula 5.1):</strong> Pots donar-te de baixa comunicant-ho a l'adreça <a href="mailto:gurb@somenergia.coop">gurb@somenergia.coop</a>. En cas que no es comuniqui la baixa, la quota es continuarà girant fins que la distribuïdora faci efectiva la baixa.</li>
      <li><strong>Actualització amb l'IPC (Clàusula 6):</strong> El preu del producte GURB s'actualitzarà anualment segons l'Índex de Preus de Consum.</li>
    </ul>
  % endif

  % if data['te_gkwh']:
    <h1>Tarifa Generation kWh</h1>
    <ul>
      <li><strong>Regulació formal:</strong> S'incorporen les Condicions Específiques d'aquesta tarifa per escrit. És un tràmit informatiu; <strong>no altera el servei que reps ni t'afegeix noves obligacions.</strong></li>
      <li><strong>Aplicació del preu (Clàusula 4 - 5.7):</strong> El preu especial s'aplica només als kWh sencers corresponents a les teves accions energètiques. La resta de consum es calcula amb la tarifa estàndard.</li>
      <li><strong>Preu provisional i revisió (Clàusula 4 - 5.7 d.):</strong> El preu anual el fixa el Consell Rector de forma provisional i es regularitzarà definitivament el 31 de desembre en funció dels costos reals de producció.</li>
      <li><strong>Sense permanència (Clàusula 3.3 i 3.4):</strong> Pots donar-te de baixa quan vulguis des de l'Oficina Virtual o enviant un correu a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>. Qualsevol canvi de preu es comunicarà amb 30 dies d'antelació.</li>
    </ul>
  % endif

  <p>Aquest és només un resum de les novetats principals. Perquè puguis consultar tots els canvis amb detall i de forma desglossada, hem preparat un article complet al nostre <a target="_blank" href="https://ca.support.somenergia.coop/article/1554-condicions-generals">Centre d'Ajuda</a>. Així mateix, trobaràs adjunt en aquest correu el document PDF amb el text complet del nou paquet contractual, que se t'aplicarà a partir del 27 d'agost de 2026. Si hi estàs d'acord, <strong>no cal que facis res</strong>: l'actualització s'activa de manera automàtica.</p>

  <p>Com sempre, si tens qualsevol dubte pots posar-te en <a target="_blank" href="https://www.somenergia.coop/ca/contacte">contacte</a> amb nosaltres.</p>

  <!-- FIXME: revisar els paràmetres de campanya; el valor actual correspon a una campanya de canvi de preus de 2025. -->
  <p>Si no desitges continuar amb el contracte, pots sol·licitar la baixa o canviar de comercialitzadora en qualsevol moment bé comunicant-nos-ho directament enviant-nos una còpia del <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/Desistiment_Plantilla_CAT.pdf?mtm_cid=20251127&amp;mtm_campaign=canvi-preus&amp;mtm_medium=L&amp;mtm_content=ca&amp;mtm_source=emailerp">document de desistiment</a>, o bé mitjançant un canvi de comercialitzadora. Recorda que a Som Energia no tenim clàusules de permanència ni penalitzacions; si decidissis marxar, només es facturarà el consum realitzat fins al darrer dia amb els preus vigents en cada moment.</p>

  <br/>
  <p>Una salutació cordial,</p>
  <p>Equip de Som Energia</p>

%else: ## CASTELLANO
  <p>En Som Energia apostamos por la transparencia y por mantenerte siempre al día de todo lo que afecta a tu suministro. Por este motivo, queremos informarte de que hemos <strong>actualizado tu paquete contractual con la cooperativa.</strong></p>

  <p>Esta revisión responde a la necesidad de adaptarnos a la nueva normativa del sector eléctrico (principalmente el <a target="_blank" href="https://www.boe.es/buscar/act.php?id=BOE-A-2026-3212">Real Decreto 88/2026</a> y el <a target="_blank" href="https://www.boe.es/buscar/act.php?id=BOE-A-2026-6544">Real Decreto-ley 7/2026</a>) y, sobre todo, aprovechamos la ocasión para introducir otras <strong>modificaciones que aclaran conceptos técnicos, refuerzan tus derechos, simplifican los trámites y te ofrecen más garantías como persona consumidora.</strong></p>

  <p>Estos son los puntos más importantes que debes saber:</p>

  <h1>1. Contratación, duración y nuevas garantías</h1>
  <ul>
    <li><strong>Acceso directo con la distribuidora (Cláusula 1.1):</strong> Si cumples con los requisitos legales para acogerte a este derecho, puedes elegir si formalizas el contrato de acceso directamente con la distribuidora o si lo gestionamos nosotros.</li>
    <li><strong>Nuevo canal telefónico (Cláusula 3.1 y 9.4):</strong> A partir de ahora, sumamos el teléfono como nuevo canal de contratación y de modificaciones contractuales, que se añade al que ya tenías disponible por la página web.</li>
    <li><strong>Más transparencia antes de firmar (Cláusula 3.2):</strong> Recibirás un resumen de contratación claro con la información esencial de tu contrato antes de contratar.</li>
    <li><strong>Garantías por teléfono (Cláusula 3.2):</strong> Dispondrás del contrato firmado digitalmente y, si lo solicitas, de la grabación y transcripción de la llamada.</li>
    <li><strong>Duración trimestral y prórroga (Cláusula 3.3 y 12.2):</strong> El contrato se renueva automáticamente cada trimestre natural, salvo que te avisemos de un cambio de precios o de su resolución anticipada con 30 días de antelación.</li>
    <li><strong>Regulación de depósitos (Cláusula 3.6):</strong> Se aclara cómo se solicita, se paga y se devuelve el depósito de garantía en el momento de contratar.</li>
    <li><strong>Eliminación de garantías adicionales (Antigua cláusula 3.8 y 11.4):</strong> Ya no podremos solicitarte fianzas equivalentes a la última factura o al consumo estimado durante la vigencia del contrato, ni para la reposición del suministro.</li>
  </ul>

  <h1>2. Precios, actualización y facturación</h1>
  <ul>
    <li><strong>Servicios de ajuste (Cláusula 5.1):</strong> Se actualiza el texto relativo a los costes del sistema eléctrico, sin ningún cambio en el precio de tu tarifa.</li>
    <li><strong>Comparador de la CNMC (Cláusula 5.2):</strong> Se incluye información sobre el comparador oficial de ofertas de energía.</li>
    <li><strong>Actualización de precios (Cláusula 5.4, ii):</strong> Se avisará con 30 días de antelación y el incremento se limitará al 50% de la subida del mercado (ej.: si el mercado sube 0,018 €/kWh, en la tarifa solo se sumarán 0,009 €/kWh).</li>
  </ul>

  <h3>Ejemplo práctico de actualización de precios:</h3>
  <p>Si el 8 de junio el precio para el mes de julio cotiza a 78 €/MWh, y el 1 de abril cotizaba a 60 €/MWh, la diferencia es de 18 €/MWh. El incremento máximo aplicable a tu tarifa transcurridos 30 días será de 9 €/MWh (el 50% de 18 €/MWh), que se desglosa de la siguiente manera por periodos:</p>

  <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
    <tr>
      <td colspan="4">
        <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
          <tr>
            <td width="20%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Periodo tarifario</strong></td>
            <td width="26%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Precio antes de la notificación (€/kWh)</strong></td>
            <td width="27%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Aumento registrado el 8 de junio</strong></td>
            <td width="27%" class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Precio máximo a aplicar al cabo de 30 días (€/kWh)</strong></td>
          </tr>
          <tr>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Punta</strong></td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,226</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,018 €/kWh (18 €/MWh)</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,226 + (0,018 / 2) = <strong>0,235</strong></td>
          </tr>
          <tr>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Llano</strong></td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,150</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,018 €/kWh (18 €/MWh)</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,150 + (0,018 / 2) = <strong>0,159</strong></td>
          </tr>
          <tr>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle"><strong>Valle</strong></td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,124</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,018 €/kWh (18 €/MWh)</td>
            <td class="purchase_borders" style="padding: 10px 5px; text-align: center;" valign="middle">0,124 + (0,018 / 2) = <strong>0,133</strong></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <ul>
    <!-- FIXME: el redactado difiere de la versión catalana, que no concreta "la energía consumida". -->
    <li><strong>Errores de facturación de la distribuidora (Cláusula 5.6):</strong> Si, por un error en la facturación de peajes y cargos que corresponda a la energía consumida, la distribuidora factura menos cantidad de la que te correspondía, deberá fraccionar el pago (máximo en 10 meses). Si factura más cantidad de la que correspondía, deberá devolver el importe de la factura abonado de más con los intereses correspondientes (interés legal + 1,5%).</li>
    <!-- FIXME: el redactado difiere de la versión catalana, que dice "energía de la que tocaba". -->
    <li><strong>Errores de facturación de Som Energia (Cláusula 7.4):</strong> Si por errores imputables únicamente a Som Energia te facturamos menos energía de la consumida, la diferencia de precio pendiente de abono se fraccionará en varias facturas mensuales (máximo 1 año atrás); si facturamos de más, se devolverá la totalidad del importe cobrado en exceso con los intereses correspondientes (interés legal + 1,5%).</li>
    <li><strong>Pago con tarjeta (Cláusula 7.7):</strong> Se habilita la opción de pagar con tarjeta desde el formulario de contratación, sin ningún recargo, así como la firma del mandato SEPA.</li>
  </ul>

  <h1>3. Gestiones, cambios de titularidad, suspensiones y bajas</h1>
  <ul>
    <li><strong>Cambio de comercializadora más rápido (Cláusula 10.2):</strong> Tramitaremos tu cambio de comercializadora en 24 horas laborables, y el cambio será efectivo, en la mayoría de los casos, en un plazo máximo de 10 días hábiles.</li>
    <li><strong>Más tiempo para avisos y subsanaciones en caso de resolución anticipada del contrato (Cláusula 12.2):</strong> El preaviso por resolución unilateral del contrato por parte de Som Energia pasa de 5 a 30 días naturales, y el plazo para subsanar un incumplimiento se amplía de 5 a 15 días hábiles.</li>
  </ul>

  <h1>4. Contratos con autoconsumo</h1>
  <ul>
    <li><strong>Gestor de autoconsumo (Cláusula 8):</strong> Podrás delegar trámites en un gestor de autoconsumo, siempre que esté formalmente autorizado.</li>
    <li><strong>Ajustes de saldo en Flux Solar (Cláusula 8.6):</strong> Si la distribuidora corrige una lectura antigua, regularizaremos tu saldo de Soles en las facturas siguientes.</li>
    <li><strong>Cambios de contrato con Flux Solar (Cláusula 8.6):</strong> En caso de baja, cambio de comercializadora, traspaso <strong>o subrogación</strong>, los Soles acumulados se perderán automáticamente. La única excepción en la que se conservan es cuando el cambio de titular se produce por fallecimiento o por fusión de empresas.</li>
  </ul>

  <h1>5. Modificaciones del contrato y flexibilidad</h1>
  <ul>
    <li><strong>Modificaciones ágiles, pero limitadas (Cláusula 9.2):</strong> Som Energia podrá modificar el contrato directamente para ganar agilidad, si bien de forma muy restringida; solo por cambios legales, ajustes técnicos de mercado, mejoras operativas o fuerza mayor.</li>
    <li><strong>Garantía de precios y derecho de rescisión (Cláusula 5.4):</strong> Esta flexibilidad no permitirá en ningún caso modificar los precios de forma unilateral. Te avisaremos con 30 días de antelación y podrás rescindir el contrato de forma inmediata y sin penalización.</li>
    <li><strong>Posibilidad de cambios simultáneos (Cláusula 9.4):</strong> Anteriormente no podías modificar la tarifa contratada y hacer otras solicitudes al mismo tiempo. A partir de ahora se elimina esta limitación.</li>
  </ul>

  <h1>6. Protección de datos, responsabilidad y atención</h1>
  <ul>
    <li><strong>Estudios de consumo y privacidad (Cláusula 4.5 y 15.3):</strong> Se modifica la redacción que ya permite elaborar análisis de hábitos de consumo y compartirlos con colaboradores para realizar estudios o mejorar los servicios, siempre con datos totalmente anonimizados.</li>
    <li><strong>Actualización de la Fuerza Mayor (Cláusula 13.2):</strong> Se excluye la responsabilidad de cualquiera de las partes en caso de incumplimiento por causas ajenas a su control.</li>
    <li><strong>Horario de atención y jurisdicción competente (Cláusula 16.4, 18.3 y 19):</strong> El horario de atención telefónica se ajusta al calendario de festivos de Cataluña y, en caso de conflicto judicial, serán siempre competentes los tribunales del domicilio del cliente.</li>
  </ul>

  % if data['indexada'] or data['gurb'] or data['te_gkwh']:
    <p><strong>Además de estas novedades generales, también hay cambios específicos relacionados con los servicios o tarifas que tienes contratados:</strong></p>
  % endif

  % if data['indexada']:
    <h1>Tarifa Indexada</h1>
    <ul>
      <li><strong>Precio por cuartos de hora (MTU) (Cláusula 2.2):</strong> El precio de la energía y de los excedentes se calculará en bloques de 15 minutos en lugar de por horas, adaptándonos al nuevo sistema de mercado. <strong>Esto no modifica el precio final que pagas.</strong></li>
      <li><strong>Duración trimestral (Cláusula 3.4):</strong> El contrato pasa a renovarse automáticamente de forma trimestral (por trimestres naturales).</li>
      <li><strong>Facturación sin datos reales (Cláusula 7.2 bis):</strong> Se modifica la forma de calcular el precio de la energía cuando no se dispone de datos reales por parte de la distribuidora.</li>
    </ul>
  % endif

  % if data['gurb']:
    <h1>Proyecto GURB</h1>
    <ul>
      <li><strong>Más de un autoconsumo (Cláusula 2):</strong> Ahora es compatible tener GURB y otro autoconsumo (individual o colectivo), siempre que Som Energia sea la comercializadora de al menos uno de tus contratos.</li>
      <li><strong>Ampliación a 5 km (Cláusula 6.1 ii):</strong> El radio para poder participar se amplía de 2 a 5 kilómetros, facilitando que mantengas el servicio si cambias de domicilio.</li>
      <li><strong>Cambios de potencia (Cláusula 4.6):</strong> Si deseas modificar tu potencia, deberás notificarlo previamente a <a href="mailto:gurb@somenergia.coop">gurb@somenergia.coop</a>.</li>
      <li><strong>Baja voluntaria (Cláusula 5.1):</strong> Puedes darte de baja comunicándolo a la dirección <a href="mailto:gurb@somenergia.coop">gurb@somenergia.coop</a>. En caso de que no se comunique la baja, la cuota se seguirá girando hasta que la distribuidora la haga efectiva.</li>
      <li><strong>Actualización con el IPC (Cláusula 6):</strong> El precio del producto GURB se actualizará anualmente conforme al Índice de Precios de Consumo.</li>
    </ul>
  % endif

  % if data['te_gkwh']:
    <h1>Tarifa Generation kWh</h1>
    <ul>
      <li><strong>Regulación formal:</strong> Se incorporan por escrito las Condiciones Específicas de esta tarifa. Se trata de un trámite informativo; <strong>no altera el servicio que recibes ni te añade nuevas obligaciones.</strong></li>
      <li><strong>Aplicación del precio (Cláusula 4 - 5.7):</strong> El precio especial se aplica únicamente a los kWh enteros correspondientes a tus acciones energéticas. El resto del consumo se calcula con la tarifa estándar.</li>
      <li><strong>Precio provisional y revisión (Cláusula 4 - 5.7 d.):</strong> El precio anual lo fija el Consejo Rector con carácter provisional y se regularizará definitivamente el 31 de diciembre en función de los costes reales de producción.</li>
      <li><strong>Sin permanencia (Cláusula 3.3 y 3.4):</strong> Puedes darte de baja cuando quieras desde la Oficina Virtual o enviando un correo a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>. Cualquier cambio de precio se comunicará con 30 días de antelación.</li>
    </ul>
  % endif

  <p>Este es solo un resumen de las novedades principales. Para que puedas consultar todos los cambios con detalle y de forma desglosada, hemos preparado un artículo completo en nuestro <a target="_blank" href="https://es.support.somenergia.coop/article/1555-condiciones-generales">Centro de Ayuda</a>. Asimismo, encontrarás adjunto en este correo el documento PDF con el texto completo del nuevo paquete contractual, que te será de aplicación a partir del 27 de agosto de 2026. Si estás de acuerdo, <strong>no es necesario que hagas nada</strong>: la actualización se activa de forma automática.</p>

  <p>Como siempre, si tienes cualquier duda puedes ponerte en <a target="_blank" href="https://www.somenergia.coop/es/contacto">contacto</a> con nosotros.</p>

  <!-- FIXME: este enlace no incluye parámetros de campaña, a diferencia del enlace catalán, que conserva parámetros de una campaña antigua. -->
  <p>Si no deseas continuar con el contrato, puedes solicitar la baja o cambiar de comercializadora en cualquier momento, ya sea comunicándonoslo directamente mediante el envío de una copia del <a target="_blank" href="https://back.somenergia.coop/storage/app/media/DOCS/Desistimiento_Plantilla_CAST.pdf">documento de desistimiento</a>, o bien a través de un cambio de comercializadora. Recuerda que en Som Energia no existen cláusulas de permanencia ni penalizaciones; si decidieras marcharte, solo se facturará el consumo realizado hasta el último día, con los precios vigentes en cada momento.</p>

  <br/>
  <p>Un cordial saludo,</p>
  <p>Equipo de Som Energia</p>

%endif
${plantilla_footer}
