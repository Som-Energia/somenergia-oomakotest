<!doctype html>
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
        <b>Impedimento del titular.</b>
    </p>
    <p>
        Entenem que heu parlat amb el personal tècnic de l’empresa distribuïdora, i els heu indicat que no voleu continuar amb la modificació sol·licitada. Així doncs, et confirmem que la modificació no es durà a terme.
    </p>
    <p>
        Si vols que demanem una nova modificació contractual, cal que tornis a fer una nova sol·licitud a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>
    </p>
    <p>
        Si el rebuig que ens ha notificat l’empresa distribuïdora no és correcte, ens ho comuniques, i els hi enviarem una reclamació.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Impedimento del titular.</b>
    </p>
    <p>
        Entendemos habéis hablado con personal técnico de la empresa distribuidora, y les habéis indicado que no queréis continuar con la modificación solicitada. De este modo, te confirmamos que la modificación no se hará efectiva.
    </p>
    <p>
        Si quieres que tramitemos una nueva modificación contractual, deberás solicitarla de nuevo a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
    </p>
    <p>
        Si el rechazo que nos ha enviado la empresa distribuidora no es correcto, nos lo comunicas,  y les enviaremos una reclamación.
    </p>
</%def>
                
            