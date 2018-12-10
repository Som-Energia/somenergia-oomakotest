<!doctype html>
<html>
   <head>
    % if object.titular.lang == "ca_ES":
        ${cabecera_cat()}
    % else:
        ${cabecera_es()}
    % endif
   </head>
   <body>
       <br>
        % if object.titular.lang == "ca_ES":
            ${correu_cat()}
        % else:
            ${correu_es()}
        % endif
    </body>
</html>

<%def name="cabecera_cat()">
    <table width="100%" frame="below" bgcolor="#E8F1D4">
        <tr>
            <td height=2px>
                <font size=2><strong>Contracte Som Energia nº ${object.name}</strong></font>
            </td>
            <td valign=TOP rowspan="4" align="right">
                <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
            </td>
        </tr>
        <tr>
            <td height=2px>
                <font size=1>Adreça punt subministrament: ${object.cups.direccio}</font>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <font size=1>Codi CUPS: ${object.cups.name}</font>
            </td>
        </tr>
        <tr>
            <td height=2px width=100%>
                <font size=1> Titular: ${object.titular.name} </font>
            </td>
        </tr>
    </table>
</%def>

<%def name="cabecera_es()">
    <table width="100%" frame="below" bgcolor="#E8F1D4">
        <tr>
            <td height=2px>
                <font size=2><strong>Contracto Som Energia nº ${object.name}</strong></font>
            </td>
            <td valign=TOP rowspan="4" align="right">
                <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
            </td>
        </tr>
        <tr>
            <td height=2px>
                <font size=1>Dirección punto de subministro: ${object.cups.direccio}</font>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <font size=1>Código CUPS: ${object.cups.name}</font>
            </td>
        </tr>
        <tr>
            <td height=2px width=100%>
                <font size=1> Titular: ${object.titular.name} </font>
            </td>
        </tr>
    </table>
</%def>

<%def name="correu_cat()">
    <p>
        Benvolgut/da
    </p>
    <p>
        Ens posem en contacte amb tu per informar-te que <strong><a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">l’empresa distribuïdora</a> ens ha indicat i reclamat per segona vegada <a href="http://ca.support.somenergia.coop/article/500-que-es-el-butlleti-electric">el butlletí elèctric</a></strong> de la teva instal·lació ja que està caducat (té més de 20 anys). Com que no se’ls hi ha presentat aquesta documentació en el termini indicat, <strong>han traslladat la informació a l’autoritat competent</strong>.
    </p>
    <p>
        L’empresa distribuïdora ens demana aquest butlletí perquè, segons la Llei 9/2014, de la seguretat industrial dels establiments, les instal·lacions i els productes; és necessari emetre aquest document i presentar-lo davant la distribuïdora per justificar el manteniment de les condicions de seguretat de la instal·lació de casa teva.
    </p>
    <p>
        El termini de presentació d’aquest butlletí des de que rebem <strong>el primer</strong> avís és de 2 mesos, segons la mateixa normativa, i aquest butlletí no pot tenir una antiguitat superior als 6 mesos quan el presentem.
    </p>
    <p>
        Tingues present que, segons la Llei 24/2013 del sector elèctric, (art. 44.3) els usuaris consumidors tenen l’obligació de garantir que les instal·lacions elèctriques compleixen els requisits tècnics i de seguretat establerts en la normativa vigent i que, segons la mateixa, (52.6) <strong>es podrà procedir a la desconnexió de les instal·lacions que es considerin en situació de comportar un risc per les persones o immobles</strong>, és a dir, que no s’hagi justificat pertinentment que la instal·lació de casa estigui al dia en termes de seguretat.
    </p>
    <p>
        Una vegada tinguis el nou butlletí emès, ens el pots enviar contestant aquest mateix correu i nosaltres el farem arribar immediatament a l’empresa distribuïdora.
    </p>
    <p>
        Salutacions,
    </p>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
    <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
</%def>


<%def name="correu_es()">
    <p>
        Estimado/a
    </p>
    <p>
        Nos ponemos en contacto contigo para informarte que <strong><a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">la empresa distribuidora</a> nos ha indicado y reclamado por segunda vez <a href="http://es.support.somenergia.coop/article/505-que-es-el-boletin-electrico">el boletín eléctrico</a></strong> de tu instalación ya que está caducado (más de 20 años). Como no se les ha presentado esta documentación en el plazo indicado, <strong>han trasladado la información a la autoridad competente</strong>.
    </p>
    <p>
        La empresa distribuidora nos pide este boletín porque, según la Ley 9/2014, de la seguridad industrial de los establecimientos, las instalaciones y los productos; es necesario emitir este documento y presentarlo ante la distribuidora para justificar el mantenimiento de las condiciones de seguridad de la instalación de casa tuya.
    </p>
    <p>
        El plazo de presentación de este boletín desde que recibimos <strong>el primer</strong> aviso es de 2 meses, según la misma normativa, y este boletín no puede tener una antigüedad superior a los 6 meses cuando lo presentamos.
    </p>
    <p>
        Ten presente que, según la Ley 24/2013 del sector eléctrico, (arte. 44.3) los usuarios consumidores tienen la obligación de garantizar que las instalaciones eléctricas cumplen los requisitos técnicos y de seguridad establecidos en la normativa vigente y que, según la misma, (52.6) se podrá proceder a la desconexión de las instalaciones que se consideren en situación de comportar un riesgo por las personas o inmuebles, es decir, que no se haya justificado pertinentemente que la instalación de casa esté al día en términos de seguridad.
    </p>
    <p>
        Una vez tengas el nuevo boletín emitido, nos lo puedes enviar contestando este mismo correo y nosotros lo haremos llegar inmediatamente a la empresa distribuidora.
    </p>
    <p>
        Saludos,
    </p>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
