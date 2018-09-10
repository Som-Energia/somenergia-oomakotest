
% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

<%def name="correu_cat()">
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L&apos;empresa distribuïdora</a> (que és qui executa aquest tràmit) ens indica que per a completar la sol·licitud <strong>cal obrir un expedient d&apos;escomesa per a aquest punt de subministrament</strong>.
    </p>
    <p>
        Caldrà que contactis amb Nous Subministraments de la teva distribuïdora, perquè obrin el nou expedient i t&apos;indiquin què cal solucionar.
    </p>
    <ul style="list-style-type:none">
        <li>Endesa Nous Subministraments: 902 534 100</li>
        <li>Iberdrola Nous Subministraments: 900 17 11 71</li>
        <li>Fenosa Nous Subministraments: 900 111 444</li>
        <li>Viesgo Nous Subministraments: 900 505 249</li>
        <li>EDP i HC Nous Subministraments: 900 907 003</li>
    </ul>
    <p>
        Un cop resolt el requeriment, la distribuïdora tancarà l&apos;expedient. Llavors ens podràs avisar perquè tornem a sol·licitar l&apos;alta.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> (que es quien ejecuta el alta) nos indica que para completar la solicitud es necesario <strong>abrir un expediente de acometida para este punto de suministro</strong>.
    </p>
    <p>
        Será necesario que contactes con Nuevos Suministros de tu distribuidora, para que abran el nuevo expediente y te indiquen qué aspecto solucionar.
    </p>
    <ul style="list-style-type:none">
        <li>Endesa Nuevos Suministros: 902 534 100</li>
        <li>Iberdrola Nuevos Suministros: 900 17 11 71</li>
        <li>Fenosa Nuevos Suministros: 900 111 444</li>
        <li>Viesgo Nuevos Suministros: 900 505 249</li>
        <li>EDP y HC Nuevos Suministros: 900 907 003</li>
    </ul>
    <p>
        Una vez resuelto el requerimiento, la distribuidora cerrará el expediente. Entonces nos podrás avisar y volveremos a solicitar el alta.
    </p>
</%def>


