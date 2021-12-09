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
        <b>Potencia Solicitada mayor que la Potencia Máxima Reconocida de Extensión.</b>
    </p>
    <p>
        Aquest rebuig significa que la potència que pot fer arribar l'empresa de distribució de la zona, és inferior a la potència que sol·licites pel teu punt de subministrament.
    </p>
    <p>
        En aquests cas, si vols contractar aquesta potència, hauràs de contactar amb l'empresa de distribució, perquè obrin un expedient d'escomesa i t'indiquin com procedir per augmentar la potència.
    </p>
    <p>
        Pots consultar en aquest enllaç el <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">telèfon de les principals empreses distribuïdores</a>.
    </p>
    <p>
        Quan aquest expedient estigui resolt, pots tornar a sol·licitar la modificació contractual a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Potencia Solicitada mayor que la Potencia Máxima Reconocida de Extensión.</b>
    </p>
    <p>
        Este rechazo indica que la potencia permitida por parte de la empresa de distribución, es inferior a la potencia que solicitas para tu punto de suministro.
    </p>
    <p>
        En este caso, si quieres contratar esta potencia, tendrás que contactar con la empresa de distribución de tu zona, para que abran un expediente de acometida y te indiquen cómo proceder para aumentar la potencia.
    </p>
    <p>
        Puedes consultar en el siguiente enlace <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">el teléfono de las principales empresas distribuidoras</a>.
    </p>
    <p>
        Cuando este expediente esté resuelto, puedes volver a solicitar la modificación contractual a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>
    </p>
</%def>
                
            