% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif


<%def name="correu_cat()">
    <p>
    <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a>, propietària de la xarxa elèctrica i dels comptadors, és l'encarregada d'acceptar i aplicar aquestes modificacions.
    </p>
    <p>
        En el teu cas, la sol.licitud ha estat rebujada pel motiu <strong>"Potencia Solicitada mayor que la Potencia Máxima Autorizada en baja tensión”</strong>.
    </p>
    <p>
        Per poder tirar endavant aquest augment de potència caldrà que un electricista autoritzat emeti un nou <strong><a href="http://ca.support.somenergia.coop/article/500-que-es-el-butlleti-electric">butlletí o certificat elèctric</a></strong> de la teva instal·lació on consti que la potència màxima admissible és igual o superior a la potència que desitges contractar.
    </p>
    <p>
        Un cop tinguis aquest document, si us plau, ens el pots fer arribar en format digital responent aquest mateix correu electrònic per poder iniciar de nou el procés.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a>, propietaria de la red eléctrica y de los contadores, es la encargada de aceptar y aplicar estas modificaciones.
    </p>
    <p>
        En tu caso, la solicitud ha sido rechazada bajo el motivo <strong>"Potencia solicitada mayor que la Potencia Máxima Autorizada en baja tensión”</strong>.
    </p>
    <p>
        Para poder llevar a cabo este aumento de potencia será necesario que un electricista autorizado emita un nuevo <strong><a href="http://es.support.somenergia.coop/article/505-que-es-el-boletin-electrico">boletín o certificado eléctrico</a></strong> de tu instalación donde conste que la potencia máxima admisible es igual o superior a la potencia que deseas contratar.
    </p>

    <p>
        Una vez tengas este documento, por favor, háznoslo llegar en formato digital respondiendo este mismo correo electrónico para poder iniciar de nuevo el proceso.
    </p>
</%def>
