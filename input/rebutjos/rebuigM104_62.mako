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
        <b>Actuación Solicitada por Comercializador no acorde con requerimientos Cliente.</b>
    </p>
    <p>
        Entenem que heu parlat amb el personal tècnic de l’empresa distribuïdora, i els heu indicat que hi ha una divergència entre la nostra sol·licitud i el que realment voleu modificar. Així doncs, et confirmem que la modificació no serà realitzada.
    </p>
    <p>
        Us recordem que com a titulars del punt de subministrament, sempre podeu trucar directament a la distribuïdora per tal de demanar explicacions sobre el motiu pel qual rebutgen la vostra sol·licitud. Pots consultar en aquest enllaç <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">el telèfon de les principals empreses distribuïdores</a>.
    </p>
    <p>
        Si el rebuig que ens ha notificat l’empresa distribuïdora no és correcte, ens ho comuniques, i els hi enviarem una reclamació.
    </p>
    <p>
        Si el que vols és que demanem una nova modificació contractual, cal que tornis a fer una nova sol·licitud a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Actuación Solicitada por Comercializador no acorde con requerimientos Cliente.</b>
    </p>
    <p>
        Entendemos que habéis hablado con el personal técnico de la empresa distribuidora, y les habéis indicado que hay una divergencia entre nuestra solicitud y lo que realmente queréis modificar. Así pues, te confirmamos que la modificación no se llevará a cabo.
    </p>
    <p>
        Os recordamos que como titulares del punto de suministro, siempre podéis llamar directamente a la distribuidora para pedir explicaciones sobre el motivo por el cual rechazan vuestra solicitud. Puedes consultar en este enlace <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">el teléfono de las principales empresas distribuidoras</a>.
    </p>
    <p>
        Si el rechazo que nos ha notificado la empresa distribuidora no es correcto, nos lo comunicas, y enviaremos una reclamación a la empresa distribuidora.
    </p>
    <p>
        Si quieres que tramitemos una nueva modificación contractual, será necesario que la solicites a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>
    </p>
</%def>
                
            