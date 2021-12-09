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
        <b>Más de una modificación de potencia en un punto de suministro en menos de 12 meses para el mismo titular del punto de suministro.</b>
    </p>
    <p>
        Per llei, la distribuïdora està obligada a fer una única modificació cada 12 mesos. La resta de sol·licituds en aquest període les pot rebutjar.
    </p>
    <p>
        Un cop hagin passat 12 mesos des de la teva darrera modificació, podràs tornar a sol·licitar una modificació contractual, a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Más de una modificación de potencia en un punto de suministro en menos de 12 meses para el mismo titular del punto de suministro.</b>
    </p>
    <p>
        Por ley, la distribuidora está obligada a hacer una única modificación cada 12 meses. El resto de solicitudes en este periodo las puede rechazar.
    </p>
    <p>
        Una vez hayan pasado 12 meses desde tu última modificación, podrás volver a solicitar una modificación contractual a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
    </p>
</%def>
                
            