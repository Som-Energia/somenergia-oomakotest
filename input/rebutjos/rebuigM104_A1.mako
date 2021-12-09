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
        <b>Incidència no subsanada.</b>
    </p>
    <p>
        Quan ens diuen això, donen a entendre que personal tècnic de l’empresa distribuïdora, hauria visitat el punt de subministrament, i s'hauria trobat amb alguna cosa que et vas comprometre a arreglar.
    </p>
    <p>
        Semblaria que en no realitzar-se aquesta determinada acció a temps, s'hauria rebutjat i tancat el tràmit.
    </p>
    <p>
        Per tornar a iniciar el tràmit, quan hagis resolt la incidència, pots tornar a sol·licitar la modificació contractual a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Incidència no subsanada.</b>
    </p>
    <p>
        Con esta comunicación dan a entender que unos días atrás personal técnico de la distribuidora, habría visitado el punto de suministro, y se habría encontrado con algo que te comprometiste a arreglar.
    </p>
    <p>
        Parecería que al no realizarse esta determinada acción a tiempo se habría rechazado y cerrado el trámite.
    </p>
    <p>
        Para volver a iniciar el trámite, una vez esté resuelta la incidencia, puedes volver a solicitar la modificación contractual a través de tu <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
    </p>
</%def>
                
            