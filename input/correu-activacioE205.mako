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

    TABLA_133_dict = {
        'ca_ES': {
            '10': "Sense excedents No acollit a compensació",
            '11': "Sense excedents acollit a compensació",
            '20': "Amb excedents no acollits a compensació",
            '21': "Amb excedents acollits a compensació",
            '00': "Sense autoconsum",
            '0C': "Baixa com a membre d'autoconsum col·lectiu",
        },
        'es_ES': {
            '10': "Sin excedentes No acogido a compensación",
            '11': "Sin excedentes acogido a compensación",
            '20': "Con excedentes no acogidos a compensación",
            '21': "Con excedentes acogidos a compensación",
            '00': "Sin autoconsumo",
            '0C': "Baja como miembro de autoconsumo colectivo",
        }
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
        dades_cau_obj = object_.pool.get('giscedata.switching.datos.cau')
        tipus_autoconsum = dict(
            dades_cau_obj.fields_get(object_._cr, object_._uid, context={'lang': lang}
        )['tipus_autoconsum']['selection'])

        return auto_consum + " - " + tipus_autoconsum[auto_consum]

    def get_auto_tipus_subseccio_description(object_, tipus_subseccio, lang):
        dades_cau_obj = object_.pool.get('giscedata.switching.datos.cau')
        # TODO: Get translations with from som_polissa.giscedata_cups import TABLA_133_dict)
        tipus_subseccio_text = TABLA_133_dict[lang].get(str(tipus_subseccio), '')
        return tipus_subseccio + " - " + tipus_subseccio_text

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
    E205 = object.pool.get('giscedata.switching.e2.05')
    pas05 = object.step_ids[-1].pas_id if len(object.step_ids) > 0 else None

    mapaTarifes = dict(E205.fields_get(object._cr, object._uid)['tarifaATR']['selection'])
    tarifaATR = mapaTarifes[pas05.tarifaATR]

    lineesDePotencia_ca = '\n'.join((
    '\t- <strong> %s: </strong>%s W'%(p.name, p.potencia)
    for p in pas05.header_id.pot_ids
    if p.potencia != 0
    ))
    lineesDePotencia_es = lineesDePotencia_ca
    if tarifaATR == "2.0TD":
      lineesDePotencia_ca = lineesDePotencia_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
      lineesDePotencia_es = lineesDePotencia_es.replace("P1:", "Punta:").replace("P2:", "Valle:")

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
        )['nom']) if not object.vat_enterprise() else ''

    data_activacio = datetime.strptime(pas05.data_activacio, '%Y-%m-%d').strftime('%d/%m/%Y')

    autoconsum_description = ''
    pot_gen = ''
    tipus_subseccio_description = ''
    is_collectiu = 'No'
    if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False:
        autoconsum_description = get_autoconsum_description(
            object, pas05.dades_cau[0].tipus_autoconsum, object.cups_polissa_id.titular.lang
        )
        tipus_subseccio_description = get_auto_tipus_subseccio_description(
            object, pas05.dades_cau[0].tipus_subseccio, object.cups_polissa_id.titular.lang
        )
        pot_gen = get_autoconsum_pot_gen(object, pas05.dades_cau)
        is_collectiu = get_autoconsum_is_collectiu(object, pas05.dades_cau)
        is_collectiu = 'Sí' if is_collectiu else 'No'

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
        <p>
            Hola${nom_titular},
        </p>
        Ens plau comunicar-te que el procés de canvi de comercialitzadora ha finalitzat, <font COLOR="green"><strong>el contracte està actiu de nou amb Som Energia</strong></font> des del ${data_activacio}.<br/>
        <br/>
        Per a qualsevol consulta o aclariment, aquestes són les teves dades:<br/>
        <ul>
            <li><strong>Número de contracte amb Som Energia: </strong>${object.cups_polissa_id.name}</li>
            <li><strong>CUPS: </strong>${object.cups_id.name}</li>
            <li><strong>Direcció del punt de subministrament: </strong>${object.cups_id.direccio}</li>
            <li><strong>Titular: </strong>${object.cups_polissa_id.titular.name}</li>
            <li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
            <li><strong>Soci/a vinculat/da: </strong>${object.cups_polissa_id.soci.name}</li>
            <li><strong> Tarifa: </strong>${tarifaATR}</li>
            <li><strong> Potència: </strong>
            ${lineesDePotencia_ca}</li>
            %if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False and pas05.dades_cau[0].tipus_autoconsum != '00':
            <li>Autoconsum:
                <ul>
                    <li>Modalitat: ${autoconsum_description}</li>
                    <li>Subsecció: ${tipus_subseccio_description}</li>
                    <li>Potència generació: ${pot_gen} kW</li>
                    <li>Col·lectiu: ${is_collectiu}</li>
                </ul>
            </li>
            %endif
        </ul>
        <br/>
        T'adjuntem les condicions particulars i generals.
        <br/><br/>
        A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> també pots consultar les dades del contracte i veure totes les teves factures.<br/>
        <br/>
        Si tens algun dubte, trobaràs les preguntes més freqüents al <a href="https://ca.support.somenergia.coop/">Centre de Suport</a>.<br/>
        <br/>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>


<%def name="correu_es()">
    <body>
        <p>
            Hola${nom_titular},
        </p>
        Nos complace informarte que el proceso de cambio de comercializadora ha finalizado, <font COLOR="green"><strong>tu contrato con Som Energia está activo de nuevo</strong></font> desde el ${data_activacio}.<br/>
        <br/>
        Los datos del nuevo contrato son:<br/>
        <ul>
            <li><strong>Número de contrato con Som Energia: </strong>${object.cups_polissa_id.name}</li>
            <li><strong>CUPS: </strong>${object.cups_id.name}</li>
            <li><strong>Dirección del punto de suministro: </strong>${object.cups_id.direccio}</li>
            <li><strong>Titular del contrato: </strong>${object.cups_polissa_id.titular.name}</li>
            <li><strong>NIF/CIF/NIE Titular: </strong>${object.cups_polissa_id.titular_nif}</li>
            <li><strong>Socio/a vinculado/a: </strong>${object.cups_polissa_id.soci.name}</li>
            <li><strong> Tarifa: </strong>${tarifaATR}</li>
            <li><strong> Potencia: </strong>
            ${lineesDePotencia_es}</li>
            %if pas05.dades_cau and pas05.dades_cau[0].tipus_autoconsum is not False and pas05.dades_cau[0].tipus_autoconsum != '00':
            <li>Autoconsumo:
                <ul>
                    <li>Modalidad: ${autoconsum_description}</li>
                    <li>Subsección: ${tipus_subseccio_description}</li>
                    <li>Potencia de generación: ${pot_gen} kW</li>
                    <li>Colectivo: ${is_collectiu}</li>
                </ul>
            </li>
            %endif
        </ul>
        <br/>
        Te adjuntamos las condiciones particulares y generales.
        <br/><br/>
        En la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> puedes consultar los datos del contrato y ver todas tus facturas.<br/>
        <br/>
        Si tienes alguna duda, encontrarás las preguntas más frecuentes en el <a href="https://es.support.somenergia.coop/">Centre de Ayuda</a>.<br/>
        <br/>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>
