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
        <b>Potencia Solicitada mayor que la Potencia Máxima Autorizada en baja tensión.</b>
    </p>
    <p>
        Per poder tirar endavant aquest augment de potència caldrà que personal electricista autoritzat emeti un nou <a href="https://ca.support.somenergia.coop/article/500-que-es-el-butlleti-electric">butlletí o certificat elèctric</a> de la teva instal·lació on consti que la potència màxima admissible és igual o superior a la potència que desitges contractar.
    </p>
    <p>
        Un cop el tingueu, podeu tornar a omplir el formulari de modificació contractual i adjuntar la documentació a través de l'<a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Potencia Solicitada mayor que la Potencia Máxima Autorizada en baja tensión.</b>
    </p>
    <p>
        Para poder llevar a cabo este aumento de potencia será necesario que personal electricista autorizado emita un nuevo <a href="https://es.support.somenergia.coop/article/505-que-es-el-boletin-electrico">boletín o certificado eléctrico</a> de tu instalación donde conste que la potencia máxima admisible es igual o superior a la potencia que deseas contratar.
    </p>
    <p>
        Una vez lo tengas, puedes volver a solicitar la modificación contractual y adjuntar el documento a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
    </p>
</%def>
                
            