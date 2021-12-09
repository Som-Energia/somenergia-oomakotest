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
        <b>Existencia de Solicitud previa en curso C2.</b>
    </p>
    <p>
        Aquest rebuig indica que actualment s’està tramitant un canvi de comercialitzadora amb canvi de titularitat per aquest punt de subministrament.
    </p>
    <p>
        Així doncs, un cop es faci efectiu aquest canvi de companyia que hi ha en curs, rebràs un correu electrònic en el qual t’informarem de la data de baixa del teu contracte.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> de tu zona, la encargada de aplicar estas modificaciones, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <b>Existencia de Solicitud previa en curso C2.</b>
    </p>
    <p>
        Este rechazo indica que actualmente se está tramitando un cambio de comercializadora con cambio de titularidad para este punto de suministro.
    </p>
    <p>
        En cualquier caso, una vez se haga efectivo el cambio de compañía que hay en curso, recibirás un correo en el que te informaremos sobre la fecha de baja de tu contrato.
    </p>
</%def>
                
            