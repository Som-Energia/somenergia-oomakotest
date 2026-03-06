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
    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

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

${plantilla_header}
% if object.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${plantilla_footer}


<%def name="correu_cat()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Adreça punt subministrament: ${object.cups_id.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Codi CUPS: ${object.cups_id.name}</span>
            </td>
        </tr>
        <tr>
            <td height=2px width=100%>
                <span style="font-size: xx-small;"> Titular: ${object.cups_polissa_id.titular.name}</span>
            </td>
        </tr>
    </table>
    <p>
        Hola${nom_titular},
    </p>
    %if pas05.motiu_modificacio == '02':
        ${correu_02_cat()}
    %else:
        ${pot_gen_ca()}
    %endif:
    Atentament,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
</%def>

<%def name="correu_es()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Dirección del punto de suministro: ${object.cups_id.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Codigo CUPS: ${object.cups_id.name}</span>
            </td>
        </tr>
        <tr>
            <td height=2px width=100%>
                <span style="font-size: small;"> Titular: ${object.cups_polissa_id.titular.name}</span>
            </td>
        </tr>
    </table>
    <p>
        Hola${nom_titular},
    </p>
    %if pas05.motiu_modificacio == '02':
        ${correu_02_es()}
    %else:
        ${pot_gen_es()}
    %endif
    Atentamente,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>

<%def name="pot_gen_ca()">
    <p>
        En data ${date_activacio}, <font color="green"><strong>s’ha activat la modificació contractual</strong></font> tramitada unilateralment per part de la distribuïdora.
    </p>
    <p>
        Les <b>condicions contractuals actuals</b> del teu contracte amb Som Energia són:
    </p>
    <ul>
        <li><strong>Tarifa: ${tarifaATR}</strong></li>
        <li><strong>Potència:</strong></li>
        <ul>
            <li>
            ${pot_deseada_ca}
            </li>
        </ul>
    </ul>
    %if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False and pas05.dades_cau[0].tipus_autoconsum != '00':
    <ul>
        <li><strong>Autoconsum:</strong>
            <ul>
                <li><strong>Motiu: ${motiu_modificacio}</strong></li>
                <li><strong>Modalitat: ${autoconsum_description}</strong> </li>
                <li><strong>Subsecció: ${tipus_subseccio_description} </strong></li>
                <li><strong>Potència generació: ${pot_gen} kW </strong></li>
                <li><strong>Col·lectiu: ${is_collectiu} </strong></li>
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
        <li><strong>Tarifa: ${tarifaATR}</strong></li>
        <li><strong>Potencia:</strong></li>
        <ul>
            <li>
            ${pot_deseada_ca}
            </li>
        </ul>
    </ul>
    %if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False and pas05.dades_cau[0].tipus_autoconsum != '00':
    <ul>
        <li><strong>Autoconsumo</strong>:
            <ul>
                <li><strong>Motivo: ${motiu_modificacio}</strong></li>
                <li><strong>Modalidad: ${autoconsum_description}</strong> </li>
                <li><strong>Subsección: ${tipus_subseccio_description} </strong></li>
                <li><strong>Potencia generación: ${pot_gen} kW </strong></li>
                <li><strong>Colectivo: ${is_collectiu} </strong></li>
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
    <p>
        El canvi en l'acord de repartiment per la instal·lació d'autoconsum vinculada al CUPS ${object.cups_id.name} amb adreça de subministrament ${object.cups_id.direccio} ha estat realitzada amb èxit.
    </p>
    <p>
        Així doncs, des del ${date_activacio} ha entrat en vigor el nou acord de repartiment per a la instal·lació d'autoconsum amb CAU ${pas05.dades_cau[0].cau}.
    </p>
</%def>


<%def name="correu_02_es()">
    <p>
        El cambio en el acuerdo de reparto para la instalación de autoconsumo vinculada a tu CUPS ${object.cups_id.name} con dirección de suministro ${object.cups_id.direccio} se ha completado con éxito.
    </p>
    <p>
        Desde el ${date_activacio} ha entrado en vigor el nuevo acuerdo de reparto para la instalación de autoconsumo con CAU ${pas05.dades_cau[0].cau}.
    </p>
</%def>