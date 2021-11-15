<!doctype html>
% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

<%def name="correu_cat()">
    <p>
        Modalitat d’autoconsum: **** TODO: Es pot treure aquesta dada de la M1 01?
    </p>
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a> de la teva zona, l’encarregada d'aplicar aquestes modificacions, ha rebutjat la teva sol·licitud amb el següent motiu:
    </p>
    <p>
        <b>Falta acuerdo de reparto/Acuerdo de reparto incorrecto/Faltan coeficientes de reparto en acuerdo</b>
    </p>
    <p>
        Entenem que  l’empresa distribuïdora, no considera vàlid el document que ens vau fer arribar corresponent a l’acord de repartiment. Necessitarem que ens feu arribar de nou aquest document, tenint en compte que han de constar clarament els coeficients de repartiment per a cada CUPS, i la signatura de totes les persones titulars.
    </p>
    <p>
        Si l’acord de repartiment que ja ens havíeu enviat, ja complia aquests requisits, i el rebuig que ens ha notificat l’empresa distribuïdora no és correcte, ens ho comuniques, i els hi enviarem una reclamació.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        Modalitat d’autoconsum: **** TODO: Es pot treure aquesta dada de la M1 01?
    </p>
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Falta acuerdo de reparto/Acuerdo de reparto incorrecto/Faltan coeficientes de reparto en acuerdo.</b>
    </p>
    <p>
        Entendemos que la empresa distribuidora, no ha considerado válida la documentación que nos hicisteis llegar correspondiente al acuerdo de reparto. Necesitaremos que nos envíes de nuevo este documento, teniendo en cuenta que deben constar los coeficientes de reparto para cada CUPS, y además debe de estar firmado por todas las personas titulares.
    </p>
    <p>
        Si el acuerdo de reparto que nos habías enviado, ya cumple estos requisitos, y el rechazo que nos ha notificado la empresa distribuidora no es correcto, nos lo comunicas, y les enviaremos una reclamación.
    </p>
</%def>
                
            