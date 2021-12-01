<%
    r_model,r_id = cas.step_ids[0].pas_id.split(',')
    cas_obj = cas.pool.get(r_model)
    llista_telefons = cas_obj.read(cas._cr, cas._uid, int(r_id), ['cont_telefons'])['cont_telefons']
    if len(llista_telefons) > 0:
        tel_obj = cas.pool.get('giscedata.switching.telefon')
        telefon = tel_obj.read(cas._cr, cas._uid, llista_telefons[0])
        tel_cont =  "+" + telefon['prefix'] + " " + telefon['numero']
    else:
        tel_cont = "-"
%>

% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

<%def name="correu_cat()">
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a> de la teva zona, l’encarregada d'aplicar aquestes modificacions, ha rebutjat la teva sol·licitud amb el següent motiu:
    </p>
    <p>
        <b>Acceso imposibilitado más de dos veces por causas ajenas a la Distribuidora.</b>
    </p>
    <p>
        Entenem que el personal tècnic de l’empresa distribuïdora, que ha de fer l’actuació al vostre comptador, no ha pogut contactar amb vosaltres. El telèfon que vas indicar a la sol·licitud és <b>${tel_cont}</b>.
    </p>
    <p>
        Si vols que tornem a tramitar la modificació, caldrà que tornis a fer una nova sol·licitud a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>.
    </p>
    <p>
        Un cop hagis fet la nova sol·licitud, et recomanem que estiguis atent a les trucades que puguis rebre al telèfon de contacte que ens indiquis a través d’aquesta nova sol·licitud.
    </p>
</%def>
<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Acceso imposibilitado más de dos veces por causas ajenas a la Distribuidora.</b>
    </p>
    <p>
        Entendemos que el personal técnico de la empresa distribuidora, que debe modificar vuestro contador, no ha podido contactar con vosotros. El teléfono de contacto que indicaste en la solicitud es:  <b>${tel_cont}</b>.
    </p>
    <p>
        Si quieres que volvamos a tramitar la modificación, debes solicitarla de nuevo a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
    </p>
    <p>
        Una vez hayas tramitado la nueva solicitud, te recomendamos que estés atento a las llamadas que puedas recibir al teléfono de contacto que hayas indicado en la nueva solicitud.
    </p>
</%def>
