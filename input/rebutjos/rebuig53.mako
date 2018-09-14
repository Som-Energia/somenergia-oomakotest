<%
    endesaCodes = ['0031','0023','0024','0029','0030','0120','0224','0232','0259','0288','0359','0363','0396','0401','0407','0418']
    iberdrolaCodes = ['0021']
    fenosaCodes = ['0022']
    viesgoCodes = ['0027']
    edpCodes = ['0026']

    distri = None
    if cas.cups_polissa_id.distribuidora.ref in endesaCodes:
        distri = {'name':'Endesa ' , 'phone':'902 534 100'}
    if cas.cups_polissa_id.distribuidora.ref in iberdrolaCodes:
        distri = {'name':'Iberdrola' , 'phone':'900 17 11 71'}
    if cas.cups_polissa_id.distribuidora.ref in fenosaCodes:
        distri = {'name':'Fenosa' , 'phone':'900 111 444'}
    if cas.cups_polissa_id.distribuidora.ref in viesgoCodes:
        distri = {'name':'Viesgo' , 'phone':'900 505 249'}
    if cas.cups_polissa_id.distribuidora.ref in edpCodes:
        distri = {'name':'EDP / HC' , 'phone':'900 907 003'}
%>

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
    %if distri:
    <ul>
        <li>${distri['name']} Distribució Nous Subministraments: ${distri['phone']}</li>
    </ul>
    %endif
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
    %if distri:
    <ul>
        <li>${distri['name']} Distribución Nuevos Suministros: ${distri['phone']}</li>
    </ul>
    %endif
    <p>
        Una vez resuelto el requerimiento, la distribuidora cerrará el expediente. Entonces nos podrás avisar y volveremos a solicitar el alta.
    </p>
</%def>
