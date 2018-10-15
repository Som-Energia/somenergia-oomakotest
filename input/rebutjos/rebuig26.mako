<%
    is_A = cas.proces_id.name == 'A3'
    is_C = cas.proces_id.name in ['C1', 'C2']
    is_M = cas.proces_id.name == 'M1'
%>


% if cas.cups_polissa_id.titular.lang == "ca_ES":
    % if is_A:
        ${correu_A_cat()}
    % elif is_C:
        ${correu_C_cat()}
    % elif is_M:
        ${correu_M_cat()}
    % endif
% else:
    % if is_A:
        ${correu_A_es()}
    % elif is_C:
        ${correu_C_es()}
    % elif is_M:
        ${correu_M_es()}
    % endif
% endif


<%def name="correu_A_cat()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> (que és qui instal·la el comptador) ens comunica que el <strong>tècnic ha intentat realitzar l'alta però o no ha pogut contactar amb tu o no ha pogut accedir a l'edifici.</strong>
    </p>
    <p>
        Has rebut alguna trucada del tècnic?<br>
        Vols que tornem a sol·licitar l’alta?
    </p>
    <p>
        Si ho desitges, pots donar-nos un número de telèfon addicional i l’afegirem a la nova sol·licitud.
    </p>
</%def>

<%def name="correu_C_cat()">
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

<%def name="correu_M_cat()">
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a> de la teva zona encarregada d'aplicar aquestes modificacions, ha rebutjat la teva sol·licitud amb el següent motiu: <strong><i>"Acceso imposibilitado más de dos veces por causas ajenas a la Distribuidora"</i></strong>
    </p>
    <p>
        Algun operari/a de l'empresa de distribució elèctrica s'ha posat en contacte amb tu?
    </p>
    <p>
        El telèfon de contacte que ens vas facilitar és correcte?
    </p>
    <p>
        Si tens el comptador a dins de casa o a un bloc de pisos en que no hi ha lliure accés, et recomanem parar atenció a les trucades telefòniques en haver rebut el mail de "Modificació contractual acceptada".
    </p>
    <p>
        Tornem a tramitar la teva sol·licitud?
    </p>
    <p>
        Esperem la teva confirmació.
    </p>
</%def>

<%def name="correu_A_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> (que es quien instala el contador) nos indica que <strong>el técnico ha intentado realizar el alta, pero o bien no ha podido contactar contigo o no le ha sido posible acceder al edificio.</strong>
    </p>
    <p>
        ¿Has recibido alguna llamada del técnico? <br>
        ¿Quieres que volvamos a solicitar el Alta?
    </p>
    <p>
        Si lo deseas, puedes facilitarnos un número de teléfono adicional para añadirlo a la nueva solicitud.
    </p>
</%def>

<%def name="correu_C_es()">
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

<%def name="correu_M_es()">
    <p>
        Finalmente <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> encargada de aplicar estas modificaciones, ha rechazado tu solicitud alegando el siguiente motivo: <strong><i>"Acceso imposibilitado más de dos veces por causas ajenas a la Distribuidora"</i></strong>
    </p>
    <p>
        ¿Se ha puesto en contacto con vosotros algún/a operario/a de la empresa de distribución eléctrica?
    </p>
    <p>
        El teléfono de contacto que nos facilitaste es correcto?
    </p>
    <p>
        Si tienes el contador dentro de casa o en un bloque de pisos en que no hay libre acceso, te recomendamos prestar atención a las llamadas telefónicas cuando haya recibido el mail de "Modificación contractual aceptada"
    </p>
    <p>
        ¿Volvemos a tramitar tu solicitud?
    </p>
    <p>
        Esperamos tu confirmación.
    </p>
</%def>
