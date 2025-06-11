<%
    from mako.template import Template
    from datetime import datetime, timedelta

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_motiu_modificacio(object_, motiu, lang):
        M205 = object_.pool.get('giscedata.switching.m2.05')
        motiu_modificacio = dict(M205.fields_get(object_._cr, object_._uid, context={'lang': lang})['motiu_modificacio']['selection'])
        return motiu + " - " + motiu_modificacio[motiu]

    def get_potencia_generacio(object_, pas):
        data = []
        for cau in pas.dades_cau:
            cau_name = cau.cau
            cau_pot = 0
            for instalacio in cau.dades_instalacio_gen:
                cau_pot += instalacio.pot_installada_gen
            data.append((cau_name, cau_pot))
        return data

    def get_autoconsum_pot_gen(object_, dades_cau):
        sumatori_pot = 0
        for cau in dades_cau:
            for inst in cau.dades_instalacio_gen:
                sumatori_pot += inst.pot_installada_gen
        pot_installada = sumatori_pot or ' '
        return pot_installada

    def get_autoconsum_is_collectiu(object_, dades_cau):
        for cau in dades_cau:
            if cau.collectiu:
                return True
        return False

    p_obj = object.pool.get('res.partner')
    cups_obj = object.pool.get('giscedata.cups.ps')
    M105 = object.pool.get('giscedata.switching.m1.05')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
        )['nom']) if not object.vat_enterprise() else ''

    pas01 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None
    pas05 = object.step_ids[-1].pas_id if len(object.step_ids) > 0 else None
    date_activacio = datetime.strptime(pas05.data_activacio, '%Y-%m-%d').strftime('%d/%m/%Y')

    motiu_modificacio = get_motiu_modificacio(object, pas05.motiu_modificacio, object.cups_polissa_id.titular.lang)
    pots_generacio = get_potencia_generacio(object, pas05)


    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]

    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        object
    )

    autoconsum_description = ''
    pot_gen = ''
    tipus_subseccio_description = ''
    is_collectiu = 'No'
    if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False:
        autoconsum_description = cups_obj.get_autoconsum_description(object._cr, object._uid, pas05.dades_cau[0].tipus_autoconsum, object.cups_polissa_id.titular.lang)
        tipus_subseccio_description = cups_obj.get_auto_tipus_subseccio_description(object._cr, object._uid, pas05.dades_cau[0].tipus_subseccio, object.cups_polissa_id.titular.lang)
        pot_gen = get_autoconsum_pot_gen(object, pas05.dades_cau)
        is_collectiu = get_autoconsum_is_collectiu(object, pas05.dades_cau)
        is_collectiu = 'Sí' if is_collectiu else 'No'


    tarifaATR = object.cups_polissa_id.tarifa.name
    pot_deseada_ca = '\n'.join((
        '&nbsp;&nbsp;&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.periode_id.name, p.potencia)
        for p in object.cups_polissa_id.potencies_periode
        if p.potencia != 0
    ))
    pot_deseada_es = pot_deseada_ca
    if tarifaATR == "2.0TD":
        pot_deseada_ca = pot_deseada_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
        pot_deseada_es = pot_deseada_es.replace("P1:", "Punta:").replace("P2:", "Valle:")
%>

<!doctype html>
<html>
    <head>
        <meta charset='utf-8'>
    </head>
    % if object.cups_polissa_id.titular.lang == "ca_ES" and pas05.motiu_modificacio != '02':
        ${correu_cat()}
    % elif pas05.motiu_modificacio != '02':
        ${correu_es()}
    % elif object.cups_polissa_id.titular.lang == "ca_ES" and pas05.motiu_modificacio == '02':
        ${correu_02_cat()}
    % else:
        ${correu_02_es()}
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
        <p>
            Hola${nom_titular},
        </p>
        ${pot_gen_ca()}
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="correu_es()">
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
        ${pot_gen_es()}
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_gen_ca()">
    <p>
        En data ${date_activacio}, s’ha activat la modificació contractual tramitada unilateralment per part de la distribuïdora.
    </p>
    <p>
        Les <b>condicions contractuals actuals</b> del teu contracte amb Som Energia són:
    </p>
    <ul>
        <li>Tarifa: ${tarifaATR}</li>
        <li>Potència:</li>
        <ul>
            <li>
            ${pot_deseada_ca}
            </li>
        </ul>
    </ul>
    %if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False and pas05.dades_cau[0].tipus_autoconsum != '00':
    <ul>
        <li>Autoconsum:
            <ul>
                <li>Motiu: ${motiu_modificacio}</li>
                <li>Modalitat: ${autoconsum_description} </li>
                <li>Subsecció: ${tipus_subseccio_description} </li>
                <li>Potència generació: ${pot_gen} kW </li>
                <li>Col·lectiu: ${is_collectiu} </li>

            </ul>
        </li>
    </ul>
    %endif

    <p>
       En la pròxima factura es veurà reflectida la modificació, i en l'Oficina Virtual en els següents dies.
    </p>
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
        Con fecha  ${date_activacio}, se ha activado la modificación contractual tramitada unilateralmente por parte de la distribuidora.
    </p>
    <p>
        Las  <b>condiciones contractuales actuales</b> de tu contrato con Som Energia son:
    </p>
    <ul>
        <li>Tarifa: ${tarifaATR}</li>
        <li>Potencia:</li>
        <ul>
            <li>
            ${pot_deseada_ca}
            </li>
        </ul>
    </ul>
    %if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False and pas05.dades_cau[0].tipus_autoconsum != '00':
    <ul>
        <li>Autoconsumo:
            <ul>
                <li>Motivo: ${motiu_modificacio}</li>
                <li>Modalidad: ${autoconsum_description} </li>
                <li>Subsección: ${tipus_subseccio_description} </li>
                <li>Potencia generación: ${pot_gen} kW </li>
                <li>Colectivo: ${is_collectiu} </li>

            </ul>
        </li>
    </ul>
    %endif
    <p>
        En la próxima factura se verá reflejada la modificación, y en la Oficina Virtual en los siguientes días.
    </p>
    <p>
        Los datos del contrato son los siguientes:
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

<%def name="correu_02_cat()">
    <body>
        <p>
            Hola${nom_titular},
        </p>
        <p>
            El canvi en l'acord de repartiment per la instal·lació d'autoconsum vinculada al CUPS ${object.cups_id.name} amb adreça de subministrament ${object.cups_id.direccio} ha estat realitzada amb èxit.
        </p>
        <p>
            Així doncs, des del ${date_activacio} ha entrat en vigor el nou acord de repartiment per a la instal·lació d'autoconsum amb CAU ${pas05.dades_cau[0].cau}.
        </p>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>


<%def name="correu_02_es()">
    <body>
        <p>
            Hola${nom_titular},
        </p>
        <p>
            El cambio en el acuerdo de reparto para la instalación de autoconsumo vinculada a tu CUPS ${object.cups_id.name} con dirección de suministro ${object.cups_id.direccio} se ha completado con éxito.
        </p>
        <p>
            Desde el ${date_activacio} ha entrado en vigor el nuevo acuerdo de reparto para la instalación de autoconsumo con CAU ${pas05.dades_cau[0].cau}.
        </p>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>