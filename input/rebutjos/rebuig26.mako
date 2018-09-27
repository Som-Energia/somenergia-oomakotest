
% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

<%def name="correu_cat()">
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a> (que és qui instal·la el comptador) ens comunica que per procedir a fer el canvi <strong> ha de fer una verificació de la teva instal·lació.</strong>
    </p>
    <p>
        S'han posat en contacte amb vosaltres? Voleu que afegim un altre telèfon de contacte?
    </p>
    <p>
        Quedem a l'espera de la teva resposta per iniciar de nou el procés.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> (que es quien instala el contador) nos comunica que para proceder a hacer el cambio <strong>ha de verificar la instalación.</strong>
    </p>
    <p>
        ¿​Se han puesto en contacto con vosotros? ¿Queréis que añadamos otro telefono de contacto?
    </p>
    <p> ​
        ​Quedamos a la espera de tu respuesta para iniciar de nuevo el proceso.
    </p>
</%def>
