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
        <b>Instalación incompleta o con elementos no válidos.</b>
    </p>
    <p>
        S'ha posat en contacte amb tu personal tècnic de l'empresa de distribució elèctrica? T'han explicat quina és la deficiència present a la teva instal·lació, i com solucionar-ho?
    </p>
    <p>
        Si no és així, pots contactar amb <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">l'empresa de distribuïció elèctrica</a> de la teva zona, per tal que et facilitin aquesta informació. En cas que no hi puguis contactar, nosaltres podem enviar-los una reclamació, sol·licitant més informació.
    </p>
    <p>
        Un cop hagis corregit la teva instal·lació, pots tornar a sol·licitar la modificació contractual a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Instalación incompleta o con elementos no válidos.</b>
    </p>
    <p>
        ¿Se ha puesto en contacto contigo personal técnico de la empresa de distribución eléctrica? ¿Te han explicado cuál es la deficiencia presente en tu instalación, y cómo solucionarla?
    </p>
    <p>
        Si no es así, puedes contactar directamente con <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad"> la empresa de distribución eléctrica</a> de tu zona, para que te faciliten esta información. En el caso que no consigas contactar con ellos, nosotras podemos enviarles una reclamación, solicitando más información.
    </p>
    <p>
        Una vez hayas corregido tu instalación, puedes volver a solicitar la modificación contractual a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
    </p>
</%def>
                
            