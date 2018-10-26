<%
    is_C1 = cas.proces_id.name == 'C1'
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

    % if is_C1:
        <p>
            Si vols que continuem amb el canvi de comercialitzadora, ens hauries de retornar <a href="https://drive.google.com/file/d/1rlxXJ_W6S0xWEW_mkH5Z68FJtYCByPEs/view">aquest document</a> firmat conforme renúncies a l’aplicació del bo social.
        </p>
    % else:
        <p>
            Continues interessat amb el canvi?
        </p>
    % endif

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

    % if is_C1:
        <p>
            Si quieres seguir con el cambio de comercializadora, tendrías que devolvernos este <a href="https://drive.google.com/file/d/1vM9jjB0tXIganEJh8xX039s7b5gpndaF/view">documento firmado</a> conforme renuncias a la aplicación del bono social.
        </p>
    % else:
        <p>
            ¿Sigues interesado en el cambio?
        </p>
    % endif

    <p>
        Quedamos a la espera de tu respuesta para iniciar de nuevo el proceso o anularlo.
    </p>
</%def>




