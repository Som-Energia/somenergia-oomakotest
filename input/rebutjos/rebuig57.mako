<%
    reasons = '\n'.join((
        '&nbsp;&nbsp;&nbsp;- <strong>{}</strong><br>'.format(rebuig.desc_rebuig)
        for rebuig in pas.rebuig_ids
    ))

    is_a3 = cas.proces_id.name == "A3"

%>

% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

<%def name="correu_cat()">
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L’empresa distribuïdora</a> (que gestiona aquest procediment) ens indica que és necessària la <strong>presentació del <a href="http://ca.support.somenergia.coop/article/500-que-es-el-butlleti-electric">Certificat o Butlletí Elèctric de la Instal·lació</a></strong>. Aquest document certifica que la vostra instal·lació compleix la llei en matèria de seguretat i les seves especificacions tècniques. Un electricista qualificat podrà emetre aquest Butlletí.<br>
    </p>
    %if is_a3:
        ${subministrament_cat_cat()}
    %endif
    <p>
        <strong>Un cop el tingueu, ens el podeu fer arribar en resposta en aquest correu i el remetrem a la distribuïdora per continuar amb el procés.</strong><br>
    </p>
</%def>

<%def name="correu_es()">
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa distribuidora</a> (que gestiona este procedimiento) nos indica es necesaria la <strong>presentación del <a href="http://es.support.somenergia.coop/article/505-que-es-el-boletin-electrico">Certificado o Boletín de la instalación</a></strong>. Este documento certifica que vuestra instalación cumple con la ley en materia de seguridad y sus especificaciones técnicas. Un electricista cualificado podrá emitir el Boletín. <br>
    </p>
    %if is_a3:
        ${subministrament_cat_es()}
    %endif
    <p>
        <strong>Una vez emitido, nos lo podéis adjuntar en respuesta a este correo y lo remitiremos a la distribuidora para continuar el proceso</strong>.
    </p>
</%def>


<%def name="subministrament_cat_cat()">
    <p>
        Si el teu punt de subministrament és de Catalunya i tens dubtes sobre quin document has de presentar, pots llegir <a href="https://ca.support.somenergia.coop/article/758-documentacio-necessaria-per-a-l-alta-de-subministrament-a-catalunya">aquest article del nostre centre de suport.</a><br>
    </p>
</%def>

<%def name="subministrament_cat_es()">
    <p>
        Si tu punto de suministro está en Catalunya y tienes dudas sobre qué documento debes presentar, puedes leer este <a href="https://es.support.somenergia.coop/article/759-documentacion-necesaria-para-el-alta-de-suministro-en-catalunaartículo">artículo en nuestro centro de ayuda.</a><br>
    </p>
</%def>