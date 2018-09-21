<%
    def strfy(thing):
        try:
            return '&nbsp;&nbsp;&nbsp;'+repr(thing) +'<br>'
        except:
            return '&nbsp;&nbsp;&nbsp; -- <br>'

    # getStep developed due error in this sentence:
    # cas.step_ids[0].pas_id.pot_ids[0].potencia

    normalizedPowers = [2425, 3464, 5196, 6928, 10392, 13856]

    def getStep01(swCase):
        return getStep(swCase,'01')

    def getStep(swCase,step_name):
        for case_step_id in swCase.step_ids:
            step_obj_name,step_id = case_step_id.pas_id.split(',')
            if step_obj_name.endswith(step_name):
                step_obj = swCase.pool.get(step_obj_name)
                return step_obj.browse(swCase._cr, swCase._uid, int(step_id))

    def getSomething(swCase,model,data,value,field):
        tbl_obj = swCase.pool.get(model)
        ids = tbl_obj.search(swCase._cr, swCase._uid,[(data,'=',value)])
        if ids:
            return tbl_obj.read(swCase._cr, swCase._uid, ids[0],[field])[field]

    step01 = getStep01(cas)
    is_canvi_tit = step01.sollicitudadm == 'S'
    is_pot_tar = step01.sollicitudadm == 'N'
    newPower = step01.pot_ids[0].potencia
    trifasica = newPower in normalizedPowers

    wantedPower = newPower / 1000.0
    wantedTarif = getSomething(cas,'giscedata.polissa.tarifa','codi_ocsum',step01.tarifaATR,'name')
    
    CUPSAddress = cas.cups_id.direccio
    CUPSCode = cas.cups_id.name

    varis = strfy(is_canvi_tit)
    varis += strfy(is_pot_tar)
    varis += strfy(newPower)
    varis += strfy(trifasica)
%>

% if cas.cups_polissa_id.titular.lang == "ca_ES":
    % if trifasica:
        ${correu_tri_cat()}
    % else:
        ${correu_no_tri_cat()}
    % endif
% else:
    % if trifasica:
        ${correu_tri_es()}
    % else:
        ${correu_no_tri_es()}
    % endif
% endif

<%def name="correu_tri_cat()">
    <p>
        Recentment has sol·licitat una modificació de tarifa i/o potència del contracte de llum del carrer ${CUPSAddress} amb CUPS ${CUPSCode}.
    </p>
    <ul>
        <li>Potència desitjada: ${wantedPower}</li>
        <li>Tarifa desitjada: ${wantedTarif}</li>
    </ul>
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a> de la teva zona és l'encarregada d'acceptar i aplicar aquestes modificacions.
    </p>
    <p>
        En el teu cas, la sol·licitud ha estat rebujada pel motiu <font size=2><strong>"Potència no normalitzada en Suministro Trifásico”</strong></font> perquè la potència que has sol·licitat <font size=2><strong>(${wantedPower}kW)</strong></font> correspon a una potència normalitzada per a instal·lació trifàsica de tensió normalitzada 3x230/400 i la teva instal·lació és trifàsica però amb <font size=2><strong>tensió poc habitual; 3x133/230 o bé 3x127/220</strong></font>.
    </p>
    <p>
        Aquesta tensió, que no és gaire comú, li corresponen unes potències normalitzades diferents a les habituals:
    </p>
    <ul>
        <li>0.598 kW</li>
        <li>1.195 kW</li>
        <li>1.394 kW</li>
        <li>1.992 kW</li>
        <li>2.988 kW</li>
        <li>3.984 kW</li>
        <li>5.976 kW</li>
        <li>7.967 kW</li>
        <li>9.959 kW</li>
        <li>11.951 kW</li>
        <li>13.943 kW</li>
    </ul>
    <p>
        Per seguir amb el canvi de potència contractada, cal que <font size=2><strong>responguis aquest mateix correu electrònic</strong></font> i informar del valor triat entre els anteriorment exposats.
    </p>
</%def>

<%def name="correu_tri_es()">
    <p>
        Recientemente has solicitado una modificación de tarifa y/o potencia del contrato de luz de la calle ${CUPSAddress} con CUPS ${CUPSCode}.
    </p>
    <ul>
        <li>Potencia deseada: ${wantedPower}</li>
        <li>Tarifa deseada: ${wantedTarif}</li>
    </ul>
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona es la encargada de aceptar y aplicar estas modificaciones.
    </p>
    <p>
        En tu caso, la solicitud ha sido rechazada por el siguiente motivo: <font size=2><strong>"Potència no normalitzada en Suministro Trifásico”</strong></font> porque la potencia que has solicitado <font size=2><strong>(${wantedPower}kW)</strong></font> corresponde a una potencia normalizada para instalaciones trifásicas de tensión normalizada 3x230/400 tu instalación es trifásica pero con <font size=2><strong>una tensión poco habitual; 3x133/230 o bien, 3x127/220</strong></font>.
    </p>
    <p>
        A esta tensión, que no es demasiado común, le corresponde unas potencias normalizadas diferentes a las habituales:
    </p>
    <ul>
        <li>0.598 kW</li>
        <li>1.195 kW</li>
        <li>1.394 kW</li>
        <li>1.992 kW</li>
        <li>2.988 kW</li>
        <li>3.984 kW</li>
        <li>5.976 kW</li>
        <li>7.967 kW</li>
        <li>9.959 kW</li>
        <li>11.951 kW</li>
        <li>13.943 kW</li>
    </ul>
    <p>
        Para seguir con el cambio de potencia contratada, es necesario que <font size=2><strong>respondas este mismo correo electrónico</strong></font> informando del valor escogido entre los anteriormente expuestos.
    </p>
</%def>

<%def name="correu_no_tri_cat()">
    <p>
        Recentment has sol·licitat una modificació de tarifa i/o potència del contracte de llum del carrer ${CUPSAddress} amb CUPS ${CUPSCode}.
    </p>
    <ul>
        <li>Potència desitjada: ${wantedPower}</li>
        <li>Tarifa desitjada: ${wantedTarif}</li>
    </ul>
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a> de la teva zona és l'encarregada d'acceptar i aplicar aquestes modificacions.
    </p>
    <p>
        En el teu cas, la sol·licitud ha estat rebujada pel motiu <font size=2><strong>"Potència no normalitzada en Suministro Trifásico”</strong></font> perquè <font size=2><strong>la teva instal·lació és trifàsica</strong></font> i per tant has de triar un valor normalitzat per a aquest tipus d'instal·lacions.
    </p>
    <p>
        A l'article <a href="https://ca.support.somenergia.coop/article/269-com-puc-saber-la-potencia-que-necessito">Com puc saber la potencia que necessito?</a> trobaràs una llista de les potències normalitzades i informació molt útil per triar la potència que millor s'adapta a les teves necessitats.
    </p>
    <p>
        Si desitges continuar amb el canvi de potència, cal que tornis a omplir el formulari a l'Oficina Virtual i indicar un valor de potència trifàsica.
    </p>
    <p>
        Si el que desitges és <font size=2><strong>fer un canvi d'instal·lació trifàsica a monofàsica</strong></font> cal que et posis en contacte amb un instal·lador autoritzat perquè faci els canvis oportuns i generi un nou <a href="https://ca.support.somenergia.coop/article/500-que-es-el-butlleti-electric">butlletí elèctric</a> que ens hauràs de fer arribar per poder tramitar el canvi a una potència monofàsica.
    </p>
</%def>

<%def name="correu_no_tri_es()">
    <p>
        Recientemente has solicitado una modificación de tarifa y/o potencia del contrato de luz de la calle ${CUPSAddress} con CUPS ${CUPSCode}.
    </p>
    <ul>
        <li>Potencia deseada: ${wantedPower}</li>
        <li>Tarifa deseada: ${wantedTarif}</li>
    </ul>
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona es la encargada de aceptar y aplicar estas modificaciones.
    </p>
    <p>
        En tu caso, la solicitud ha sido rechazada por el siguiente motivo: <font size=2><strong>"Potència no normalitzada en Suministro Trifásico”</strong></font> porque <font size=2><strong>tu instalación es trifásica</strong></font> y por lo tanto tienes que elegir un valor normalizado para este tipo de instalaciones. 
    </p>
    <p>
        En el artículo <a href="https://es.support.somenergia.coop/article/282-como-puedo-saber-la-potencia-que-necesito">¿Cómo puedo saber la potencia que necesito?</a> encontrarás una lista de las potencias normalizadas e información muy útil para escoger la potencia que mejor se adapte a tus necesidades.
    </p>
    <p>
        Si deseas continuar con el cambio de potencia, tienes que volver a solicitarlo a través de la Oficina Virtual indicando un valor de potencia trifásica.
    </p>
    <p>
        Si lo que deseas es hacer un cambio de instalación trifásica a monofásica debes ponerte en contacto con un instalador autorizado para que haga los cambios oportunos y genere un nuevo <a href"https://es.support.somenergia.coop/article/505-que-es-el-boletin-electrico">boletín eléctrico</a> que nos deberás entregar para poder tramitar el cambio a una potencia monofásica.
    </p>
</%def>
