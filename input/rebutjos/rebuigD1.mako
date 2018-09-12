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
        La distribuïdora de la teva zona ens comunica que el teu contracte està acollit al <a href="https://ca.support.somenergia.coop/article/171-que-es-el-bo-social">bo social</a>.
    </p>
    <p>
        Som Energia no pot oferir el bo social, per tant, si canvies a la cooperativa el teu contracte perdràs la bonificació actual.
    </p>
    <p>
        Seguiu interessat amb el canvi?
    </p>
    <p>
        Quedem a l'espera de la teva resposta per iniciar de nou el procés o anular-lo.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        La distribuidora de tu zona nos comunica que tu contrato está acogido al <a href="https://es.support.somenergia.coop/article/208-que-es-el-bono-social">bono social</a>.
    </p>
    <p>
        Som Energia no puede ofrecer el bono social; de modo que si cambias a la cooperativa el contrato perderás la bonificación actual.
    </p>
    <p>
        Sigues interesado en el cambio?
    </p>
    <p>
        Quedamos a la espera de tu respuesta para iniciar de nuevo el proceso o anularlo.
    </p>
</%def>




