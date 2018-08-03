<%
    reasons = '\n'.join((
        '&nbsp;&nbsp;&nbsp;- <strong>{}</strong><br>'.format(rebuig.desc_rebuig)
        for rebuig in pas.rebuig_ids
    ))

%>

% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

<%def name="correu_cat()">
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">La companyia distribuïdora</a> (que gestiona aquest procediment) ens indica que per completar la sol.licitud és necessària la presentació del Butlletí de la Instal.lació Elèctrica (<a href="http://ca.support.somenergia.coop/article/500-que-es-el-butlleti-electric">clica aquí per més informació</a>)<br>
        Aquest document certifica que la vostra instal·lació compleix la llei en matèria de seguretat i les seves especificacions tècniques. Un electricista qualificat podrà emetre aquest Butlletí.<br>
    </p>
    <p>
        Un cop el tingueu, ens el podeu fer arribar en resposta en aquest correu i el remetrem a la distribuïdora per continuar amb el procés.<br>
    </p>
    <p>
        Gràcies per la teva atenció, estem en contacte per a qualsevol dubte o consulta.<br>
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">la empresa de distribución eléctrica</a>  (que gestiona este procedimiento) nos indica que para completar la solicitud es necesaria la presentación del Boletín de la instalación Eléctrica (<a href="http://es.support.somenergia.coop/article/505-que-es-el-boletin-electrico">clica aquí para más información</a>).<br>
        Este documento certifica que vuestra instalación cumple con la ley en materia de seguridad y sus especificaciones técnicas. Un electricista cualificado podrá emitir el Boletín. <br>
    </p>
    <p>
        Una vez emitido, nos lo podéis adjuntar en respuesta a este correo y lo remitiremos a la distribuidora para continuar el proceso.
    </p>
    <p>
        Muchas gracias por tu atención, estamos en contacto para cualquier duda o consulta.
    </p>
</%def>
