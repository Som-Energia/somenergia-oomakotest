<%
from gestionatr.defs import TABLA_64
from mako.template import Template

pas1 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None

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

def get_tension_type(object_, pas1, lang):
    codi_cnmc = pas1.tensio_solicitada
    taula_cnmc = dict(TABLA_64)
    tension_name = taula_cnmc.get(codi_cnmc, False)

    if not tension_name:
        return False

    if tension_name.lower().startswith("3x"):
        return THREEPHASE[lang]
    return MONOPHASE[lang]


def get_autoconsum_description(object_, auto_consum, lang):
    M101 = object_.pool.get('giscedata.switching.m1.01')
    tipus_autoconsum = dict(M101.fields_get(object_._cr, object_._uid, context={'lang': lang})['tipus_autoconsum']['selection'])

    return auto_consum + " - " + tipus_autoconsum[auto_consum]

def is_canvi_potencia(object_, pas1):
    polissa_pots = {
        d.periode_id.name: int(d.potencia * 1000)
        for d in object_.cups_polissa_id.potencies_periode
    }

    if len(polissa_pots) != len(pas1.header_id.pot_ids):
        return True

    for sw_pot in pas1.header_id.pot_ids:
        if polissa_pots.get(sw_pot.name, False) != sw_pot.potencia:
            return True
    return False

def is_canvi_tarifa(object_, pas1):
    pol_tarifa_codi = object_.cups_polissa_id.tarifa.codi_ocsum
    return pas1.tarifaATR != pol_tarifa_codi


tipus_tensio = False
if pas1:
    _is_canvi_tarifa = is_canvi_tarifa(object, pas1)

    PasM101 = object.pool.get('giscedata.switching.m1.01')
    mapaTarifes = dict(PasM101.fields_get(object._cr, object._uid)['tarifaATR']['selection'])
    tarifaATR = mapaTarifes[pas1.tarifaATR]

    cont_telefon = pas1.cont_telefons and pas1.cont_telefons[0].numero or object.tel_pagador_polissa

    _is_canvi_potencia = is_canvi_potencia(object, pas1)
    pot_deseada_ca = ''
    pot_deseada_es = pot_deseada_ca
    if _is_canvi_potencia:
        pot_deseada_ca = '\n'.join((
            '&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
            for p in pas1.header_id.pot_ids
            if p.potencia != 0
        ))
        pot_deseada_es = pot_deseada_ca
        if tarifaATR == "2.0TD":
            pot_deseada_ca = pot_deseada_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
            pot_deseada_es = pot_deseada_es.replace("P1:", "Punta:").replace("P2:", "Valle:")

    if pas1.solicitud_tensio == "S" and pas1.tensio_solicitada:
        lang = object.cups_polissa_id.titular.lang
        tipus_tensio = get_tension_type(object, pas1, lang)

    nou_autoconsum = False
    if pas1.tipus_autoconsum is not False:
        if object.cups_polissa_id.autoconsumo != pas1.tipus_autoconsum:
            nou_autoconsum = get_autoconsum_description(object, pas1.tipus_autoconsum, object.cups_polissa_id.titular.lang)

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    text_desistiment_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_modi_rejection_text')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
    text_desistiment = render(t_obj.read(object._cr, object._uid, [text_desistiment_id], ['def_body_text'])[0]['def_body_text'], object)

%>

    ${plantilla_header}
    % if object.cups_polissa_id.titular.lang != "ca_ES":
        ${correu_es()}
    % else:
        ${correu_cat()}
    %endif
    ${plantilla_footer}

<%def name="correu_cat()">
    <p>
        Hola,<br>
    </p>
    <p>
        Hem rebut una sol·licitud de modificació del contracte ${object.cups_polissa_id.name} amb Som Energia:<br>
    </p>
    <p>
        Dades del contracte:<br>
        - CUPS: ${object.cups_id.name}<br>
        - Adreça: ${object.cups_polissa_id.cups_direccio}<br>
        - Persona titular: ${object.cups_polissa_id.titular.name}<br>
        - DNI, NIE o CIF: ${pas1.codi_document}<br>
    </p>
    <p>
        Dades de la sol·licitud: <br>
        %if _is_canvi_tarifa:
        - Tarifa d'accés: ${tarifaATR} <br>
        %endif
        %if _is_canvi_potencia:
        - Potències desitjades: <br>
        ${pot_deseada_ca}
        %endif
        %if tipus_tensio:
        - Tensió desitjada: ${tipus_tensio}
        %endif
        %if nou_autoconsum:
        - Autoconsum desitjat: ${nou_autoconsum}
        %endif
    </p>
    <p>
        Telèfon de contacte: ${cont_telefon} (recorda que aquest telèfon l'utilitzarà la distribuïdora de la teva zona per posar-se en contacte amb tu en el cas que sigui necessari).
    </p>
    <p>
        En els propers dies rebràs un correu electrònic en què t’informarem de l’estat de la teva sol·licitud.
    </p>
    <p>
        En un termini de 24 h enviarem la teva sol·licitud a la distribuïdora de la teva zona, l’encarregada de validar i fer efectiva la teva sol·licitud. En el cas que detectis algun error, respon aquest mateix correu electrònic al més aviat possible.
    </p>
    ${text_desistiment}
    Fins ben aviat,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
</%def>

<%def name="correu_es()">
    <p>
        Hola,<br>
    </p>
    <p>
        Hemos recibido una solicitud de modificación del contrato ${object.cups_polissa_id.name} con Som Energia:<br>
    </p>
    <p>
        Datos del contrato:<br>
        - CUPS: ${object.cups_id.name}<br>
        - Dirección: ${object.cups_polissa_id.cups_direccio}<br>
        - Persona titular: ${object.cups_polissa_id.titular.name}<br>
        - DNI, NIE o CIF: ${pas1.codi_document}<br>
    </p>
    <p>
        Datos de la solicitud:<br>
        %if _is_canvi_tarifa:
        - Tarifa de acceso: ${tarifaATR}<br>
        %endif
        %if _is_canvi_potencia:
        - Potencias deseadas: <br>
        ${pot_deseada_es}
        %endif
        %if tipus_tensio:
        - Tensión deseada: ${tipus_tensio}
        %endif
        %if nou_autoconsum:
        - Autoconsumo deseado: ${nou_autoconsum}
        %endif
    </p>
    <p>
        Teléfono de contacto: ${cont_telefon} (recuerda que este teléfono lo utilizará la distribuidora de tu zona para ponerse en contacto contigo en caso de que sea necesario).<br>
    </p>
    <p>
        En los próximos días recibirás un correo electrónico en el que te informaremos del estado de tu solicitud.<br>
    </p>
    <p>
        En un plazo de 24 horas enviaremos la solicitud a la distribuidora de tu zona, la encargada de validar y hacer efectiva tu solicitud. En el caso que detectes algún error, responde este mismo correo electrónico lo antes posible.<br>
    </p>
    ${text_desistiment}
    Hasta pronto,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
