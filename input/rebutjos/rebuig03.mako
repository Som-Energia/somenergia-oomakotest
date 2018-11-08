% if cas.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

<%def name="correu_cat()">
    <p>
        La sol·licitud ens ha estat rebutjada per part de <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">l’empresa distribuïdora</a> indicant que no ets l’actual titular d’aquest contracte.
    </p>

    <p>
        Per poder tirar endavant amb el canvi de comercialitzadora necessitaríem que ens feu arribar:
        <ul>
            <li>
                Una factura recent.
            </li>
            <li>
                Indicar qui voleu que sigui la persona titular amb Som Energia.
            </li>
            <li>
                Confirmar el compte IBAN de la persona titular on voleu domiciliar les factures.
            </li>
            <li>
                En cas que vulgueu conservar la titularitat del contracte, ens farà falta una còpia escanejada del seu DNI, correu electrònic i telèfon de contacte.
            </li>
        </ul>
    </p>

    <p>
        En quan tinguem aquestes dades podrem continuar gestionant el canvi.
    </p>
</%def>

<%def name="correu_es()">
    <p>
        La solicitud nos ha sido rechazada por parte de <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">la empresa distribuidora</a> indicando que no eres el actual titular del contrato.
    </p>

    <p>
        Para poder continuar con la solicitud necesitaremos:
        <ul>
            <li>
                Una factura reciente.
            </li>
            <li>
                Saber quién quieres que sea la persona titular con Som Energia.
            </li>
            <li>
                Confirmar la cuenta IBAN del titular donde queréis domiciliar las facturas.
            </li>
            <li>
                En caso de que desees conservar la titularidad, bastará con enviarnos una copia escaneada de su DNI, correo electrónico y teléfono de contacto.
            </li>
        </ul>
    </p>

    <p>
        En cuanto tengamos estos datos podremos continuar gestionando el cambio.
    </p>
</%def>

