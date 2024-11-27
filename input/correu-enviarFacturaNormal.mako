<%
    email_o = object.pool.get('report.backend.invoice.email')
    data = email_o.get_data(object._cr, object._uid, object.id, context={'lang': object.partner_id.lang})
    polissa_retrocedida = data['polissa']['polissa_retrocedida']
    potencies = [float(x['potencia'].replace(',','.')) for x in data['polissa']['potencies']['contractades']]
%>
<div align="right"><a href="https://somenergia.coop"><img src="${data['comerci']['logo']}"/></a></div>
% if data['lang'] != "es_ES":
    <p><br>Benvolgut, benvolguda,</p>
    <p>T'enviem
    % if not polissa_retrocedida:
        la
    % else:
        una altra
    %endif
    <strong>factura</strong> d'electricitat de Som Energia.</p>
    % if polissa_retrocedida:
        <p>Aquest mes has rebut més d'una factura a causa d'un endarreriment de les factures, o perquè la distribuïdora ens ha enviat lectures d'un període més curt. Si vols, podem canviar la data de venciment per cobrar-la quan et vagi millor.</p>
    % endif
    <p dir="ltr">Durant els pròxims dies carregarem l'import d'aquesta factura al compte corrent associat a aquest contracte.</p>
    <p dir="ltr"><span style="text-decoration: underline;"><strong>Resum de la factura</strong></span></p>
    <ul>
        <li>Número de factura: ${data['factura']['numero']}</li>
        <li>Període facturat: del<strong id="docs-internal-guid-6536ca4e-7fff-dbd9-04a0-3e9d7d100756"> </strong>${data['factura']['data']['inici']} al ${data['factura']['data']['fi']}</li>
        <li>Tarifa: ${data['polissa']['llista_preus']}</li>
        <li>Titular del contracte: ${data['polissa']['titular']['nom']}</li>
        <li>Número de contracte: ${data['polissa']['numero']}</li>
        <li>Codi CUPS: ${data['polissa']['cups']['codi']}</li>
        <li>Adreça del punt de subministrament: ${data['polissa']['cups']['adreca']}</li>
        <li><strong><strong id="docs-internal-guid-531dd379-7fff-ff8b-79e9-ac3d592033e4">Import a carregar</strong>: ${data['factura']['import']} euros</strong></li>
    </ul>
    <p>
    %if data['factura']['te_iva_21'] and potencies and max(potencies) <= 10:
        <p>Com veuràs a la factura, l'IVA que t'apliquem és del 21%, i no del 10%. Això és així perquè la rebaixa de l'IVA al 10% només es pot aplicar si el preu mitjà de l'energia al mercat majorista no baixa per sota dels 45 €/MWh. </p>
        <p>Com que el preu de l'energia (el preu mitjà del mes natural anterior a l'últim dia del període de facturació, segons estableix el <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Reial decret</a>), ha baixat per sota dels 45 €/MWh, en aquesta factura hem d'aplicar un IVA del 21%. </p>
    %endif
    %if data['polissa']['tarifa'] == '2.0TD' and data['polissa']['mode_facturacio'] == 'atr':
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar el funcionament de la tarifa que tens contractada en aquest article: <a href="https://ca.support.somenergia.coop/article/1003-la-tarifa-2-0td">la tarifa 2.0TD períodes</a>, i al web pots veure'n els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#tarifa20TD">preus</a>.
        </p>
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-resol-els-teus-dubtes-sobre-la-factura">aquest enllaç</a>, o bé ens ho pots comunicar responent aquest mateix correu. I si vols saber més sobre la factura, trobaràs la informació detallada en l'article que explica <a href="https://ca.support.somenergia.coop/article/488-entendre-la-factura-20td">la factura en la tarifa 2.0TD períodes</a> del Centre d'Ajuda.
        </p>
    %elif data['polissa']['tarifa'] == '2.0TD' and data['polissa']['mode_facturacio'] == 'index':
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar el funcionament de la tarifa que tens contractada en aquest article: <a href="https://ca.support.somenergia.coop/article/1323-la-tarifa-2-0td-indexada">la tarifa 2.0TD indexada</a>, i al web pots veure'n els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#tarifa20TD">preus</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Els preus de les pròximes hores:</strong> si vols saber la tendència de preus per a les properes hores, pots visitar <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">aquest apartat</a> del web.
            </p>
        %endif
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum">aquest enllaç</a> o bé, ens ho pots comunicar responent a aquest mateix correu.
        </p>
    %elif data['polissa']['tarifa'] in ['3.0TD', '6.1TD'] and data['polissa']['mode_facturacio'] == 'index' and data['polissa']['has_business_tariff']:
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar el funcionament de la tarifa que tens contractada en aquest article: <a href="https://ca.support.somenergia.coop/article/1272-les-tarifes-indexades">la tarifa indexada</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Els preus de les pròximes hores:</strong> si vols saber la tendència de preus per a les properes hores, pots visitar <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">aquest apartat</a> del web.
            </p>
        %endif
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum">aquest enllaç</a> o bé, ens ho pots comunicar responent a aquest mateix correu.
        </p>
    %elif data['polissa']['tarifa'] == '3.0TD' and data['polissa']['mode_facturacio'] == 'atr':
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar el funcionament de la tarifa que tens contractada en aquest article: <a href="https://ca.support.somenergia.coop/article/1115-la-tarifa-3-0td">la tarifa 3.0TD períodes</a>, i al web pots veure'n els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#tarifa30TD">preus</a>.
        </p>
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum">aquest enllaç</a> o bé, ens ho pots comunicar responent a aquest mateix correu.
        </p>
    %elif data['polissa']['tarifa'] == '3.0TD' and data['polissa']['mode_facturacio'] == 'index':
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar el funcionament de la tarifa que tens contractada en aquest article: <a href="https://ca.support.somenergia.coop/article/1324-la-tarifa-3-0td-indexada">la tarifa 3.0TD indexada</a>, i al web pots veure'n els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#tarifa30TD">preus</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Els preus de les pròximes hores:</strong> si vols saber la tendència de preus per a les properes hores, pots visitar <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">aquest apartat</a> del web.
            </p>
        %endif
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum">aquest enllaç</a> o bé, ens ho pots comunicar responent a aquest mateix correu.
        </p>
    %elif data['polissa']['tarifa'] == '6.1TD' and data['polissa']['mode_facturacio'] == 'atr':
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar el funcionament de la tarifa que tens contractada en aquest article: <a href="https://ca.support.somenergia.coop/article/1163-tarifes-dalta-tensio-6-1td-6-2td-6-3td-i-6-4td">les tarifes d'alta tensió 6.1TD, 6.2TD, 6.3TD i 6.4TD períodes</a>, i al web pots veure'n els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#tarifa61TD">preus</a>.
        </p>
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum">aquest enllaç</a> o bé, ens ho pots comunicar responent a aquest mateix correu.
        </p>
    %elif data['polissa']['tarifa'] == '6.1TD' and data['polissa']['mode_facturacio'] == 'index':
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar el funcionament de la tarifa que tens contractada en aquest article: <a href="https://ca.support.somenergia.coop/article/1337-tarifes-dalta-tensio-6-1td-6-2td-6-3td-i-6-4td-indexades">les tarifes d'alta tensió 6.1TD, 6.2TD, 6.3TD i 6.4TD indexades</a>, i al web pots veure'n els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#tarifa61TD">preus</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Els preus de les pròximes hores:</strong> si vols saber la tendència de preus per a les properes hores, pots visitar <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">aquest apartat</a> del web.
            </p>
        %endif
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum">aquest enllaç</a> o bé, ens ho pots comunicar responent a aquest mateix correu.
        </p>
    %else:
        <p dir="ltr">
            Sempre que vulguis, pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure i descarregar les teves factures i gestionar els contractes que tens amb la cooperativa.
        </p>
        <p dir="ltr">
            Pots consultar els preus que apliquem en aquest <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/">apartat</a> del web.
        </p>
        <p dir="ltr">
            Si detectes algun error en la factura, pots consultar <a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum">aquest enllaç</a> o bé, ens ho pots comunicar responent a aquest mateix correu.
        </p>
    %endif
    %if data['factura']['isTariffChange']:
        <p>Com que en el període que comprèn la teva factura hi ha hagut un canvi de tarifes, una part del terme d'energia i del terme de potència està facturada amb les tarifes d'abans del canvi, i l'altra part està facturada amb les noves tarifes. Això fa que, a la factura, apareguin dues línies (amb els dos preus) de cadascun dels conceptes d'energia i potència.</p>
    %endif
    <br>
    % if data['polissa']['autoconsum']:
        <p>En cas que en aquesta factura hi aparegui un descompte per Flux Solar, t'informem que hem aplicat els impostos tal com estableix la normativa vigent (<a href="https://petete.tributos.hacienda.gob.es/consultas/?num_consulta=V1146-24" target="_blank" rel="noopener nofollow noreferrer">V1146-24</a>), és a dir, abans de descomptar els Sols del Flux Solar.</p>
    % endif
    <br>
    <p dir="ltr"><span style="text-decoration: none;"><strong>Avís sobre estafes</strong></span></p>
    <p dir="ltr">
        Últimament ha crescut el número d'<strong>estafes i trucades fraudulentes al mercat elèctric</strong>. Sovint acaben en un canvi de companyia no desitjat per la persona titular del contracte, i en ocasions, qui truca fa referència a alguna legislació o nova normativa, actualització de dades, canvi de comptador o altres.
    </p>
    <p dir="ltr">
        Aprofitem, doncs, per recordar-te que, a no ser que estiguis fent un tràmit amb Som Energia, no et trucarem. <strong>Si reps una trucada i sospites o tens dubtes</strong>, et recomanem que pengis, i contactis tu amb Som Energia (sigui per telèfon o per correu electrònic). Al nostre Centre d'Ajuda et donem <a href="https://ca.support.somenergia.coop/article/775-enganys-i-estafes-en-el-mercat-electric">més consells per evitar enganys</a>.
    </p>
    <p>Atentament,</p>
    <p>Equip de Som Energia</p>
    <div style="text-align: center;"><a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum"><img style="width: 189px; margin-left: auto; margin-right: auto" src="https://www.somenergia.coop/factura/dubtes_socia_som_energia.png" alt="" height="182"></a></div>
    <p dir="ltr" style="text-align: center;"><a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum"><strong>Creus que la teva factura és errònia?</strong></a></p>
    </p>
% endif
% if data['lang'] != "ca_ES" and data['lang'] != "es_ES":
    <p>----------------------------------------------------------------------------------------------------</p>
% endif
% if data['lang'] != "ca_ES":
    <p><br>Estimado, estimada,</p>
    <p>Te enviamos
    % if not polissa_retrocedida:
        la
    % else:
        otra
    %endif
    <strong>factura</strong> de electricidad de Som Energia.</p>
    % if polissa_retrocedida:
        <p>Este mes has recibido más de una factura debido a un retraso de las facturas, o porque la distribuidora nos ha enviado lecturas de un período más corto. Si quieres, podemos cambiar la fecha de vencimiento para cobrarla cuando te vaya mejor.</p>
    % endif
    <p dir="ltr">Durante los próximos días cargaremos el importe de esta factura en el número de cuenta asociado a este contrato.</p>
    <p dir="ltr"><span style="text-decoration: underline;"><strong>Resumen de la factura</strong></span></p>
    <ul>
        <li>Número de factura: ${data['factura']['numero']}</li>
        <li>Periodo facturado: del<strong id="docs-internal-guid-6536ca4e-7fff-dbd9-04a0-3e9d7d100756"> </strong>${data['factura']['data']['inici']} al ${data['factura']['data']['fi']}</li>
        <li>Tarifa: ${data['polissa']['llista_preus']}</li>
        <li>Titular del contrato: ${data['polissa']['titular']['nom']}</li>
        <li>Número de contrato: ${data['polissa']['numero']}</li>
        <li>Código CUPS: ${data['polissa']['cups']['codi']}</li>
        <li>Dirección del punto de suministro: ${data['polissa']['cups']['adreca']}</li>
        <li><strong><strong id="docs-internal-guid-531dd379-7fff-ff8b-79e9-ac3d592033e4">Importe a cargar</strong>: ${data['factura']['import']} euros</strong></li>
    </ul>
    <p dir="ltr"></p>
    %if data['factura']['te_iva_21'] and potencies and max(potencies) <= 10:
        <p>Como verás en la factura, el IVA que te aplicamos es del 21%, y no del 10%. Esto es así porque la rebaja del IVA al 10% sólo puede aplicarse si el precio medio de la energía en el mercado mayorista no baja por debajo de los 45 €/MWh.</p>
        <p>Debido a que el precio de la energía (el precio medio del mes natural anterior al último día del período de facturación, según establece el <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Real decreto</a>), ha sido inferior a 45 €/MWh, en esta factura debemos aplicar un IVA del 21%. </p>
    %endif
    %if data['polissa']['tarifa'] == '2.0TD' and data['polissa']['mode_facturacio'] == 'atr':
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar el funcionamiento de la tarifa que tienes contratada en este artículo: <a href="https://es.support.somenergia.coop/article/1004-la-tarifa-2-0td">La tarifa 2.0TD periodos</a>, y en el web puedes ver sus <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#tarifa20TD">precios</a>.
        </p>
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo. Y si quieres saber más sobre la factura, encontrarás la información detallada en el artículo que explica <a href="https://es.support.somenergia.coop/article/489-entender-la-factura-20td-periodos">la factura en la tarifa 2.0TD periodos</a> del Centro de Ayuda.
        </p>
    %elif data['polissa']['tarifa'] == '2.0TD' and data['polissa']['mode_facturacio'] == 'index':
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar el funcionamiento de la tarifa que tienes contratada en este artículo: <a href="https://es.support.somenergia.coop/article/1325-la-tarifa-2-0td-indexada">La tarifa 2.0TD indexada</a>, y en el web puedes ver sus <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#tarifa20TD">precios</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Los precios de las próximas horas:</strong> si quieres saber la tendencia de precios para las próximas horas, puedes visitar <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/precio-hoy/">este apartado</a> de la web. También está disponible en <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">catalán</a>, <a href="https://www.somenergia.coop/gl/tarifas-electricas-que-ofrecemos/tarifa-indexada/prezo-hoxe/">gallego</a> y <a href="https://www.somenergia.coop/eu/eskaintzen-ditugun-elektrizitate-tarifak/tarifa-indexatua/gaurko-prezioa/">euskera</a>.
            </p>
        %endif
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo.
        </p>
        <p dir="ltr">
            Y si quieres saber más sobre la factura, encontrarás la información detallada en el artículo que explica la factura en <a href="https://es.support.somenergia.coop/article/1378-entender-la-factura-2-0td-indexada">la tarifa 2.0TD indexada</a> del Centro de Ayuda.
        </p>
    %elif data['polissa']['tarifa'] in ['3.0TD', '6.1TD'] and data['polissa']['mode_facturacio'] == 'index' and data['polissa']['has_business_tariff']:
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar el funcionamiento de la tarifa que tienes contratada en este artículo: <a href="https://es.support.somenergia.coop/article/1273-las-tarifas-indexadas">La tarifa indexada</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Los precios de las próximas horas:</strong> si quieres saber la tendencia de precios para las próximas horas, puedes visitar <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/precio-hoy/">este apartado</a> de la web. También está disponible en <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">catalán</a>, <a href="https://www.somenergia.coop/gl/tarifas-electricas-que-ofrecemos/tarifa-indexada/prezo-hoxe/">gallego</a> y <a href="https://www.somenergia.coop/eu/eskaintzen-ditugun-elektrizitate-tarifak/tarifa-indexatua/gaurko-prezioa/">euskera</a>.
            </p>
        %endif
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo.
        </p>
    %elif data['polissa']['tarifa'] == '3.0TD' and data['polissa']['mode_facturacio'] == 'atr':
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar el funcionamiento de la tarifa que tienes contratada en este artículo: <a href="https://es.support.somenergia.coop/article/1116-la-tarifa-3-0td-periodos">La tarifa 3.0TD periodos</a>, y en el web puedes ver sus <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#tarifa30TD">precios</a>.
        </p>
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo.
        </p>
    %elif data['polissa']['tarifa'] == '3.0TD' and data['polissa']['mode_facturacio'] == 'index':
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar el funcionamiento de la tarifa que tienes contratada en este artículo: <a href="https://es.support.somenergia.coop/article/1326-la-tarifa-3-0td-indexada">La tarifa 3.0TD indexada</a>, y en el web puedes ver sus <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#tarifa30TD">precios</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Los precios de las próximas horas:</strong> si quieres saber la tendencia de precios para las próximas horas, puedes visitar <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/precio-hoy/">este apartado</a> de la web. También está disponible en <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">catalán</a>, <a href="https://www.somenergia.coop/gl/tarifas-electricas-que-ofrecemos/tarifa-indexada/prezo-hoxe/">gallego</a> y <a href="https://www.somenergia.coop/eu/eskaintzen-ditugun-elektrizitate-tarifak/tarifa-indexatua/gaurko-prezioa/">euskera</a>.
            </p>
        %endif
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo.
        </p>
    %elif data['polissa']['tarifa'] == '6.1TD' and data['polissa']['mode_facturacio'] == 'atr':
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar el funcionamiento de la tarifa que tienes contratada en este artículo: las <a href="https://es.support.somenergia.coop/article/1164-tarifas-de-alta-tension-6-1td-6-2td-6-3td-y-6-4td">tarifas de alta tensión  6.1TD, 6.2TD, 6.3TD i 6.4TD periodos</a>, y en el web puedes ver sus <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#tarifa61TD">precios</a>.
        </p>
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo.
        </p>
    %elif data['polissa']['tarifa'] == '6.1TD' and data['polissa']['mode_facturacio'] == 'index':
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar el funcionamiento de la tarifa que tienes contratada en este artículo: las <a href="https://es.support.somenergia.coop/article/1164-tarifas-de-alta-tension-6-1td-6-2td-6-3td-y-6-4td">tarifas de alta tensión  6.1TD, 6.2TD, 6.3TD i 6.4TD periodos</a>, y en el web puedes ver sus <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#tarifa61TD">precios</a>.
        </p>
        %if data['polissa']['cups']['is_peninsula']:
            <p dir="ltr">
                <strong>Los precios de las próximas horas:</strong> si quieres saber la tendencia de precios para las próximas horas, puedes visitar <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/precio-hoy/">este apartado</a> de la web. También está disponible en <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">catalán</a>, <a href="https://www.somenergia.coop/gl/tarifas-electricas-que-ofrecemos/tarifa-indexada/prezo-hoxe/">gallego</a> y <a href="https://www.somenergia.coop/eu/eskaintzen-ditugun-elektrizitate-tarifak/tarifa-indexatua/gaurko-prezioa/">euskera</a>.
            </p>
        %endif
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo.
        </p>
    %else:
        <p dir="ltr">
            Siempre que quieras, puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver y descargar tus facturas y gestionar tus contratos con la cooperativa.
        </p>
        <p dir="ltr">
            Puedes consultar los precios que aplicamos en este <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">apartado</a> del web.
        </p>
        <p dir="ltr">
            Si detectas algún error en la factura, puedes consultar este <a href="https://es.support.somenergia.coop/article/927-resuelve-tus-dudas-de-la-factura">enlace</a> o bien nos lo puedes comunicar respondiendo a este mismo correo.
        </p>
    %endif
    % if data['factura']['isTariffChange']:
        <p>Como en el periodo que comprende tu factura ha habido un cambio de tarifas, una parte del término de energía y del término de potencia está facturada con las tarifas de antes del cambio, y la otra parte está facturada con las nuevas tarifas. Esto hace que, en la factura, aparezcan dos líneas (con los precios distintos) de cada uno de los conceptos de energía y potencia.</p>
    % endif
    <br>
    % if data['polissa']['autoconsum']:
        <p>En caso de que en esta factura aparezca un descuento por Flux Solar, te informamos que hemos aplicado los impuestos tal y como establece la normativa vigente (<a href="https://petete.tributos.hacienda.gob.es/consultas/?num_consulta=V1146-24">V1146-24</a>), es decir, antes de descontar los Sols del Flux Solar.</p>
    % endif
    <br>
    <p dir="ltr"><span style="text-decoration: none;"><strong>Aviso sobre estafas</strong></span></p>
    <p dir="ltr">
        Últimamente ha crecido el número de <strong>estafas y llamadas fraudulentas en el mercado eléctrico</strong>. A menudo terminan en un cambio de compañía no deseado por la persona titular del contrato, y en ocasiones, quien llama hace referencia a alguna legislación o nueva normativa, actualización de datos, cambio de contador u otros.
    </p>
    <p dir="ltr">
        Aprovechamos, pues, para recordarte que, a menos que estés haciendo un trámite con Som Energia, no te llamaremos. <strong>Si recibes una llamada y sospechas o tienes dudas</strong>, te recomendamos que cuelgues, y contactes tú con Som Energia (sea por teléfono o por correo electrónico). En nuestro Centro de Ayuda te damos <a href="https://es.support.somenergia.coop/article/776-enganos-y-estafas-en-el-mercado-electrico?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">más consejos para evitar engaños</a>.
    </p>
    <p>Atentamente,</p>
    <p>Equipo de Som Energia</p>
    <div style="text-align: center;"><a href="https://es.support.somenergia.coop/article/927-que-puedo-hacer-si-estoy-en-desacuerdo-con-la-factura-de-la-luz"><img style="width: 189px; margin-left: auto; margin-right: auto" src="https://www.somenergia.coop/factura/dubtes_socia_som_energia.png" alt="" height="182"></a></div>
    <p dir="ltr" style="text-align: center;"><strong><a href="https://es.support.somenergia.coop/article/927-que-puedo-hacer-si-estoy-en-desacuerdo-con-la-factura-de-la-luz">¿Crees que tu factura contiene errores?</a></strong></p>
    <p style="text-align: center;">&nbsp;</p>
%endif
<p>${data['text_correu']['text_legal']}</p>
