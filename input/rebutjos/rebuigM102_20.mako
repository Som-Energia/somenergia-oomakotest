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
        <b>NECESIDAD DE ABRIR EXPEDIENTE DE ACOMETIDA,INSTALACIÓN NO DISPONIBLE O AMPLIACIÓN SUMINISTRO EN TRÁMITE (EXPTE ABIERTO + CÓDIGO DE EXPTE + MOTIVO DE EXPTE</b>
    </p>
    <p>
        Hauràs de contactar amb l’empresa distribuïdora per a confirmar que l’expedient està tancat i si no és així, us diguin quines accions has de dur a terme. En principi, el que han de fer és comprovar que l’escomesa que arriba al vostre punt de subministrament permet la potència que vols contractar.
    </p>
    <p>
        Pots consultar en aquest enllaç  <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">el telèfon de les principals empreses distribuïdores</a>.
    </p>
    <p>
        Una vegada resolts els requeriments de l’empresa distribuïdora, l’expedient quedarà tancat i serà el moment en què podràs tornar a tramitar de nou la modificació contractual  a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>NECESIDAD DE ABRIR EXPEDIENTE DE ACOMETIDA,INSTALACIÓN NO DISPONIBLE O AMPLIACIÓN SUMINISTRO EN TRÁMITE (EXPTE ABIERTO + CÓDIGO DE EXPTE + MOTIVO DE EXPTE</b>
    </p>
    <p>
        Tendrás que contactar con la empresa distribuidora para confirmar que el expediente está cerrado y si no es así, os digan qué acciones tienes que llevar a cabo. Deben comprobar que la acometida que llega a vuestro punto de suministro permite la potencia que quieres contratar.
    </p>
    <p>
        Puedes consultar en el siguiente enlace <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">el teléfono de las principales empresas distribuidoras</a>.
    </p>
    <p>
        Una vez resueltos los requerimientos de la distribuidora el expediente quedará cerrado y será el momento en podrás volver a tramitar la modificación contractual rellenando otra vez el formulario a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
    </p>
</%def>
                
            