<%!
    from mako.template import Template
    from datetime import datetime, timedelta
    from gestionatr.defs import TABLA_64

    THREEPHASE = {
        'ca_ES': "Trifàsica",
        'es_ES': "Trifásica"
    }

    MONOPHASE = {
        'ca_ES': "Monofàsica",
        'es_ES': "Monofásica"
    }

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_contract_number_by_cups(object_, cups):
        Polissa = object_.pool.get('giscedata.polissa')
        new_contract_id = Polissa.search(
            object_._cr, object_._uid, [('cups.name', '=', cups)]
        )[-1]
        return Polissa.read(object_._cr, object_._uid, new_contract_id, [])['name']

    def get_autoconsum_description(object_, auto_consum, lang):
        M105 = object_.pool.get('giscedata.switching.m1.05')
        tipus_autoconsum = dict(M105.fields_get(object_._cr, object_._uid, context={'lang': lang})['tipus_autoconsum']['selection'])

        return auto_consum + " - " + tipus_autoconsum[auto_consum]

    def get_tension_type(object_, pas05, lang):
        codi_cnmc = pas05.tensio_suministre
        taula_cnmc = dict(TABLA_64)
        tension_name = taula_cnmc.get(codi_cnmc, False)

        if not tension_name:
            return False

        if tension_name.lower().startswith("3x"):
            return THREEPHASE[lang]
        return MONOPHASE[lang]

%>

<%
    md_obj = object.pool.get('ir.model.data')
    M101 = object.pool.get('giscedata.switching.m1.01')
    M105 = object.pool.get('giscedata.switching.m1.05')
    pas05 = object.step_ids[-1].pas_id if len(object.step_ids) > 0 else None
    pas01 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None

    is_auto_uni = M101.search(object._cr, object._uid, [('sw_id', '=', object.id)]) == []
    if not is_auto_uni:
        is_canvi_tit = object.step_ids[0].pas_id.sollicitudadm == 'S'
        is_pot_tar = object.step_ids[0].pas_id.sollicitudadm == 'N'
    else:
        is_canvi_tit = False
        is_pot_tar = False

    mapaTarifes = dict(M105.fields_get(object._cr, object._uid)['tarifaATR']['selection'])
    tarifaATR = mapaTarifes[pas05.tarifaATR]

    pot_deseada_ca = '\n'.join((
        '&nbsp;&nbsp;&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
        for p in pas05.header_id.pot_ids
        if p.potencia != 0
    ))
    pot_deseada_es = pot_deseada_ca
    if tarifaATR == "2.0TD":
        pot_deseada_ca = pot_deseada_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
        pot_deseada_es = pot_deseada_es.replace("P1:", "Punta:").replace("P2:", "Valle:")
    polissa = object.polissa_ref_id if is_canvi_tit else object.cups_polissa_id

    tipus_tensio = False
    if not is_auto_uni:
        if pas01 and pas01.solicitud_tensio == "S" and pas05.tensio_suministre:
            tipus_tensio = get_tension_type(object, pas05, polissa.titular.lang)

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, polissa.titular.name
        )['nom']) if not object.vat_enterprise() else ''


    # new_contract_number = get_contract_number_by_cups(object, object.cups_id.name)
    new_contract_number = object.polissa_ref_id.name
    date_activacio = datetime.strptime(pas05.data_activacio, '%Y-%m-%d').strftime('%d/%m/%Y')

    autoconsum_description = get_autoconsum_description(object, pas05.tipus_autoconsum, object.polissa_ref_id.titular.lang)

    # Campanya canvi titular sense soci
    campanya_partner_soci_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_polissa_soci', 'res_partner_soci_ct'
    )[1]
    is_campanya_ct_sense_soci = campanya_partner_soci_id == polissa.soci.id

    t_obj = object.pool.get('poweremail.templates')

    template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]

    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        object
    )
%>

<!doctype html>
<html>
    <head>
        <meta charset='utf-8'>
    </head>
    % if object.cups_polissa_id.titular.lang == "ca_ES":
        ${correu_cat()}
    % else:
        ${correu_es()}
    % endif
    ${text_legal}
</html>


<%def name="correu_cat()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Adreça punt subministrament: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codi CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${nom_titular},
        </p>
        %if is_pot_tar or is_auto_uni:
            ${pot_tar_cat()}
        %elif is_canvi_tit:
            ${canvi_tit_cat()}
        %endif
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_tar_cat()">
    <p>
        La sol·licitud de la <font color="green"><strong> modificació contractual ha estat ACTIVADA</strong></font>, amb data ${date_activacio}.
    </p>

    <p>
        Les <b>condicions contractuals actuals</b> del teu contracte amb Som Energia són:<br>
        <br>
        &nbsp;&nbsp; <strong> Tarifa: ${tarifaATR}</strong> <br>
        &nbsp;&nbsp; <strong> Potència: </strong> <br>
        ${pot_deseada_ca}

        %if tipus_tensio:
            &nbsp;&nbsp; <strong> Tensió: ${tipus_tensio}</strong><br>
        %endif

        %if pas05.tipus_autoconsum != '00':
            &nbsp;&nbsp;<strong> Autoconsum: </strong> <br>
            &nbsp;&nbsp;&nbsp;&nbsp; <strong> - Modalitat: ${autoconsum_description} </strong>
        %endif
    </p>

    <p>
        A la propera factura es veurà reflectida la modificació, i a la oficina virtual en els següents dies.
    </p>

    <p>
        Les dades del contracte  que s'ha fet la modificació contractual són les següents: <br>
        &nbsp;&nbsp;- Titular del contracte: ${object.cups_polissa_id.titular.name}<br>
        &nbsp;&nbsp;- Adreça: ${object.cups_polissa_id.cups_direccio}<br>
        &nbsp;&nbsp;- CUPS: ${object.cups_id.name}<br>
        &nbsp;&nbsp;- Número de contracte amb Som Energia: ${object.cups_polissa_id.name}<br>
        &nbsp;&nbsp;- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
    </p>
    <p>
        Estem en contacte per a qualsevol dubte o consulta.
    </p>
</%def>

<%def name="canvi_tit_cat()">
    <p>
        El <b>canvi de titular del contracte ${new_contract_number}</b> i adreça de subministrament ${object.cups_polissa_id.cups_direccio} ha estat realitzat amb èxit.
    </p>
    <p>
        Així doncs, des del <b>${date_activacio}</b> ets la nova persona titular del contracte. Ho veuràs reflectit en les factures i a la teva Oficina Virtual en els propers dies.
    </p>
    %if is_campanya_ct_sense_soci:
        <table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td rowspan="4"><p>
            Has contractat el teu subministrament elèctric amb Som Energia, cooperativa sense ànim de lucre, que té per missió impulsar un model energètic 100 % renovable i en mans de la ciutadania.
            <br/><br/>
            Normalment, els serveis de la cooperativa estan reservats a les persones sòcies. Ara, i durant un temps, estem oferint la possibilitat de <strong>contractar durant un any el subministrament elèctric</strong> a persones que, com tu, han arribat al nostre projecte a través d'un canvi de titular i <strong>prefereixen no associar-se a la cooperativa encara.</strong>
            <br/><br/>
            Durant els pròxims mesos t'anirem explicant més sobre nosaltres; qué és el que ens mou i quin és el nostre pla per a fomentar les energies renovables.
            <br/><br/>
            Amb quin objectiu? Ens agradaria que, quan ens coneguis una mica més, t'uneixis a la cooperativa fent-te soci/a. Ja som més de 85.000 persones que hem construit la cooperativa de forma col·lectiva i en volem ser moltes més!
        </p></td></tr></table>
    %endif
</%def>


<%def name="correu_es()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Dirección del punto de suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codigo CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${nom_titular},
        </p>
        %if is_pot_tar or is_auto_uni:
            ${pot_tar_es()}
        %elif is_canvi_tit:
            ${canvi_tit_es()}
        %endif
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_gen_ca()">
    <p>
        La sol·licitud de la modificació contractual ha estat ACTIVADA, amb data ${date_activacio}.
    </p>
    <p>
        Les condicions contractuals actuals del teu contracte amb Som Energia són:
    </p>
    <ul>
        <li>Tarifa: ${tarifaATR}</li>
        <li>Potència: ${pot_deseada_ca}</li>
        <li>Autoconsum:
            <ul>
                <li>Modalitat: ${autoconsum_description}</li>
                <li>Potència generació:  kW</li>
            </ul>
        </li>
    </ul>

    <p>
        Les dades del contracte que s'ha fet la modificació contractual són les següents:
    </p>
    <ul>
        <li>Titular del contracte: ${object.cups_polissa_id.titular.name}</li>
        <li>Adreça: ${object.cups_polissa_id.cups_direccio}</li>
        <li>CUPS: ${object.cups_id.name}</li>
        <li>Número de contracte amb Som Energia: ${object.cups_polissa_id.name}</li>
        <li>Soci/a Som Energia: ${object.cups_polissa_id.soci.name}</li>
    </ul>
    <p>
        Estem en contacte per a qualsevol dubte o consulta.
    </p>
</%def>

<%def name="pot_gen_es()">
    <p>
        La solicitud de la modificación contractual ha sido ACTIVADA con fecha ${date_activacio}.
    </p>
    <p>
        Las condiciones contractuales actuales de tu contrato con Som Energia son:
    </p>
    <ul>
        <li>Tarifa: ${tarifaATR}</li>
        <li>Potencia: ${pot_deseada_es}</li>
        <li>Autoconsumo:
            <ul>
                <li>Modalidad: ${autoconsum_description}</li>
                <li>Potencia generación:  kW</li>
            </ul>
        </li>
    </ul>

    <p>
        Los datos del contrato con el que se ha hecho la modificación contractual son los siguientes:
    </p>
    <ul>
        <li>Titular del contrato: ${object.cups_polissa_id.titular.name}</li>
        <li>Dirección: ${object.cups_polissa_id.cups_direccio}</li>
        <li>CUPS: ${object.cups_id.name}</li>
        <li>Número de contrato con Som Energia: ${object.cups_polissa_id.name}</li>
        <li>Soci/a Som Energia: ${object.cups_polissa_id.soci.name}</li>
    </ul>
    <p>
        Estamos en contacto para cualquier duda o consulta.
    </p>
</%def>

<%def name="pot_tar_es()">
    <p>
        La solicitud de  <font color="green"><strong>la modificación contractual ha sido ACTIVADA</strong></font> con fecha ${date_activacio}.
    </p>
    <p>
        Las <b>condiciones contractuales actuales</b> de tu contrato con Som Energia son:<br>

        &nbsp;&nbsp;<strong> Tarifa: ${tarifaATR}</strong><br>
        &nbsp;&nbsp;<strong> Potencia: </strong><br>
        ${pot_deseada_es}

        %if tipus_tensio:
            &nbsp;&nbsp; <strong> Tensión: ${tipus_tensio}</strong><br>
        %endif

        %if pas05.tipus_autoconsum != '00':
            &nbsp;&nbsp;<strong> Autoconsumo: </strong> <br>
            &nbsp;&nbsp;&nbsp;&nbsp; <strong> - Modalidad: ${autoconsum_description} </strong>
        %endif
    </p>
    <p>
        En la próxima factura se verá reflejada la modificación, y en la oficina virtual en los siguientes días.
    </p>
    <p>
        Los datos del contrato son los siguientes:<br>
        &nbsp;&nbsp;- Titular del contrato: ${object.cups_polissa_id.titular.name}<br>
        &nbsp;&nbsp;- Dirección: ${object.cups_polissa_id.cups_direccio}<br>
        &nbsp;&nbsp;- CUPS: ${object.cups_id.name}<br>
        &nbsp;&nbsp;- Número de contrato con Som Energia: ${object.cups_polissa_id.name}<br>
        &nbsp;&nbsp;- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
    </p>
    <p>
        Estamos en contacto para cualquier duda o consulta.
    </p>
</%def>

<%def name="canvi_tit_es()">
    <p>
        El <b>cambio de titular del contrato ${new_contract_number}</b> y dirección de suministro ${object.cups_polissa_id.cups_direccio} ha sido llevado a cabo con éxito.
    </p>
    <p>
        Así pues, desde la fecha <b>${date_activacio}</b> eres la nueva persona titular del contrato. Lo verás reflejado en las próximas facturas y en tu Oficina Virtual durante los próximos días.
    </p>
    %if is_campanya_ct_sense_soci:
        <table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td rowspan="4"><p>
            Has contratado tu suministro eléctrico con Som Energia, cooperativa sin ánimo de lucro, cuya misión es impulsar un modelo energético 100 % renovable en manos de la ciudadanía.
            <br/><br/>
            Normalmente, los servicios que prestamos están reservados a las personas socias. Ahora y durante tiempo, estamos ofreciendo la <strong>posibilidad de contratar durante un año</strong> el suministro eléctrico a personas que, como tú, llegan a nuestro proyecto a través de un cambio de titular y <strong>prefieren no asociarse a la cooperativa aún.</strong>
            <br/><br/>
            Durante los próximos meses te iremos explicando más sobre nosotros, qué es lo que nos mueve y cuál es nuestro plan para fomentar las energías limpias.
            <br/><br/>
            ¿Nuestro objetivo? Nos gustaría que, cuando nos conozcas un poco más, te unas a la cooperativa haciéndote socio/a. Ya somos más de 85.000 personas, que de forma colectiva hemos construido Som Energia y ¡queremos ser muchas más!
        </p></td></tr></table>
    %endif
</%def>
