<%!
    from mako.template import Template
    from datetime import datetime

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
        )
%>

<%
    md_obj = object.pool.get('ir.model.data')
    is_canvi_tit = object.step_ids[0].pas_id.sollicitudadm == 'S'

    is_pot_tar = object.step_ids[0].pas_id.sollicitudadm == 'N'

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ''

    data_activacio = datetime.strptime(
        object.step_ids[-1].pas_id.data_activacio, '%Y-%m-%d'
    ).strftime('%d/%m/%Y')

    # Campanya canvi titular sense soci
    campanya_partner_soci_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_polissa_soci', 'res_partner_soci_ct'
    )[1]
    is_campanya_ct_sense_soci = campanya_partner_soci_id == object.cups_polissa_id.soci.id

    t_obj = object.pool.get('poweremail.templates')

    template_id = md_obj.get_object_reference(
    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]

    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        object
    )

    M101 = object.pool.get('giscedata.switching.m1.01')
    is_auto_uni = M101.search(object._cr, object._uid, [('sw_id', '=', object.id)]) == []
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
                    <font size=2><strong> Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
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
        <br>
        %if is_pot_tar:
            ${pot_tar_cat()}
        %elif is_canvi_tit:
            ${canvi_tit_cat()}
        %elif is_auto_uni:
            ${unidireccional_cat()}
        %endif
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="unidireccional_cat()">
    <p>
        Hola${nom_titular},<br>
    </p>
    <p>
        L'empresa distribuïdora de la teva zona ens comunica que s'ha acceptat la modificació contractual d'autoconsum que estàs tramitant. <br>

        Quan tinguem la confirmació per part de la distribuïdora t’enviarem un correu electrònic indicant la data exacta d'<strong>activació de la modificació.</strong><br>
    </p>
</%def>

<%def name="pot_tar_cat()">
    <p>
        Hola${nom_titular},<br>
    </p>
    <p>
        <strong> La modificació contractual que vares sol·licitar ha estat acceptada.</strong><br>
    </p>
    <p>
        En cas que la telegestió del teu comptador no estigui activa, <strong>durant els propers 15 dies hàbils, vindrà un operari de <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">l'empresa de distribució elèctrica</a></strong> de la teva zona per a realitzar la modificació sol·licitada.
        <br>
        Si el comptador no està accessible, l’operari de l'empresa distribuïdora es posarà en contacte amb tu prèviament a través del telèfon de contacte que has facilitat mitjançant el formulari.<br>
        <br>
        Quan tinguem la confirmació per part de la distribuïdora t’enviarem un correu electrònic indicant la data exacta d'<strong>activació de la modificació.</strong><br>
    </p>
    <p>
        Les dades del contracte modificat són les següents:<br>
        - Adreça: ${object.cups_polissa_id.cups_direccio}<br>
        - CUPS: ${object.cups_id.name}<br>
    </p>
</%def>

<%def name="canvi_tit_cat()">
    <p>
        Hola,<br>
    </p>
    <p>
        El <b>canvi de titular del contracte ${object.cups_polissa_id.name}</b> i adreça de subministrament ${object.cups_polissa_id.cups_direccio} ha estat realitzat amb èxit.
    </p>
    <p>
        Així doncs, des del <b>${data_activacio}</b> ets la nova persona titular del contracte. Ho veuràs reflectit en les factures i a la teva Oficina Virtual en els propers dies.
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
                    <font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Dirección punto suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Código CUPS: ${object.cups_id.name}</font>
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
        <br>
        %if is_pot_tar:
            ${pot_tar_es()}
        %elif is_canvi_tit:
            ${canvi_tit_es()}
        %elif is_auto_uni:
            ${unidireccional_es()}
        %endif
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop">www.somenergia.coop</a>

    </body>
</%def>

<%def name="unidireccional_es()">
    <p>
        Hola${nom_titular},<br>
    </p>
    <p>
        La empresa distribuidora de tu zona nos comunica que ha aceptado la modificación de autoconsumo que estas tramitando.<br>
        En el momento que tengamos la confirmación por parte de la distribuidora, te enviaremos un correo electrónico indicando la fecha exacta de <strong>activación de la modificación.</strong><br>
    </p>

</%def>

<%def name="pot_tar_es()">
    <p>
        Hola${nom_titular},<br>
    </p>
    <p>
        <strong> La modificación contractual que solicitaste ha sido aceptada. </strong><br>
    </p>
    <p>
        En el caso que la telegestión de tu contador no esté activa, <strong>durante los próximos 15 días hábiles, vendrá un operario de <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">la empresa de distribución eléctrica</a></strong> de tu zona para realizar la modificación solicitada.
        <br>
        Si el contador no está accesible el operario de la empresa distribuidora se pondrá en contacto contigo préviamente a través del teléfono de contacto facilitado mediante el formulario..<br>
        <br>
        En el momento que tengamos la confirmación por parte de la distribuidora, te enviaremos un correo electrónico indicando la fecha exacta de <strong>activación de la modificación.</strong><br>
    </p>
    <p>
        Los datos del contrato son los siguientes:<br>
        - Dirección: ${object.cups_polissa_id.cups_direccio}<br>
        - CUPS: ${object.cups_id.name}<br>
    </p>

</%def>

<%def name="canvi_tit_es()">
    <p>
        Hola,<br>
    </p>
    <p>
        El <b>cambio de titular del contrato ${object.cups_polissa_id.name}</b> y dirección de suministro ${object.cups_polissa_id.cups_direccio} ha sido llevado a cabo con éxito.
    </p>
    <p>
        Así pues, desde la fecha <b>${data_activacio}</b> eres la nueva persona titular del contrato. Lo verás reflejado en las próximas facturas y en tu Oficina Virtual durante los próximos días.
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
