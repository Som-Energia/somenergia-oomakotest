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
        <b>Potencia Solicitada no puede ser inferior a Potencia de B.I.E. (Suministros en Modo 2 no interrumpibles)</b>
    </p>
    <p>
        Aquest rebuig es produeix quan l'empresa distribuïdora té notificat que la instal·lació d’aquest punt de subministrament disposa d'un element no interrompible (per exemple un ascensor), i per tant, la facturació ha de ser per <a href="https://ca.support.somenergia.coop/article/261-que-es-el-maximetre">maxímetre</a>. El maxímetre permet que no deixi d’haver-hi subministrament, si en algun moment sobrepasseu la potència contractada.
    </p>
    <p>
        <b>Si disposeu d’un element no interrompible</b>, per a que puguem tornar a sol·licitar aquesta modificació contractual amb maxímetre, fa falta que ens faciliteu un butlletí elèctric o Certificat d'Instal·lació Elèctrica, en el que s’especifiqui en l'apartat d'observacions, que aquest punt de subministrament disposa d’un element no interrompible; també caldrà indicar quina és la potència nominal d'aquest element en kW. Heu de tenir en compte que la potència mínima a contractar, serà la potència nominal d’aquest element.
    </p>
    <p>
        <b>En cas de no disposar de cap element no interruptible</b> a la vostra instal·lació, no necessitaríeu la facturació per maxímetre, i es podrà demanar la modificació que sol·licitis amb facturació per ICP (Interruptor de Control de Potència).
    </p>
    <p>
        Quedem pendents que ens confirmis quina és la teva situació.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Potencia Solicitada no puede ser inferior a Potencia de B.I.E. (Suministros en Modo 2 no interrumpibles)</b>
    </p>
    <p>
        Este rechazo se produce cuando la empresa distribuidora, tiene notificado que la instalación de este punto de suministro, dispone de un elemento no interrumpible (por ejemplo un ascensor) y por tanto, la facturación debe ser por <a href="https://es.support.somenergia.coop/article/187-que-es-el-maximetro">maxímetro</a>. El maxímetro permite que no deje de haber suministro, si en algún momento sobrepasáis la potencia contratada.
    </p>
    <p>
        <b>Si disponéis de un elemento no interrumpible</b>, para que podamos volver a solicitar esta modificación contractual con maxímetro, hace falta que nos facilitéis un boletín o Certificado de Instalación Eléctrica, especificando en el apartado de observaciones, que este punto de suministro dispone de un elemento no interrumpible, e indicar cuál es la potencia nominal de este elemento en kW. Debes tener en cuenta que la potencia mínima a contratar, será la potencia nominal de este elemento.
    </p>
    <p>
        <b>En caso de no disponer de ningún elemento no interrumpible</b> en vuestra instalación, no necesitaríais la facturación por maxímetro y podemos pedir la modificación que solicites con facturación por ICP (Interruptor de Control de Potencia).
    </p>
    <p>
        Quedamos a la espera que nos confirmes cuál es tu situación.
    </p>
</%def>
                
            