<%
from gestionatr.defs import TABLA_64

pas1 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None

THREEPHASE = {
    'ca_ES': "Trifàsica",
    'es_ES': "Trifásica"
}

MONOPHASE = {
    'ca_ES': "Monofàsica",
    'es_ES': "Monofásica"
}

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
    pot_deseada = ''

    if _is_canvi_potencia:
        lineesDePotencia = '\n'.join((
            '&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
            for p in pas1.header_id.pot_ids
            if p.potencia != 0
        ))

        pot_deseada = lineesDePotencia if tarifaATR == '3.0A' else potencia

    if pas1.solicitud_tensio == "S" and pas1.tensio_solicitada:
        lang = object.cups_polissa_id.titular.lang
        tipus_tensio = get_tension_type(object, pas1, lang)

    nou_autoconsum = False
    if object.cups_polissa_id.autoconsumo != pas1.tipus_autoconsum:
        nou_autoconsum = get_autoconsum_description(object, pas1.tipus_autoconsum, object.cups_polissa_id.titular.lang)

%>

<!doctype html>
<html>
    <head>
        <meta charset="utf-8"/>
    </head>
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td valign=TOP rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
        </table>
        <br>
        <br>
        % if object.cups_polissa_id.titular.lang != "ca_ES":
            ${correu_es()}
        % else:
            ${correu_cat()}
        %endif
    </body>
</html>

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
        ${pot_deseada}
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
    <p>
        <b>Dret de desistiment.</b> Totes les persones consumidores de la cooperativa disposen de 14 dies naturals des de la data del contracte per desistir dels serveis. En cas que vulguis desistir, és necessari que ens notifiquis la teva decisió per correu electrònic a comercialitzacio@somenergia.coop, o per correu postal a SOM ENERGIA SCCL c/ Pic de Peguera 11, 17003 Girona. Si vols, pots utilitzar el text de desistiment que tens <b><a href="https://docs.google.com/document/d/10CzheqAYQs5lwvKpJBkaiBEdsHZjY6TZoeBDN-mOfT0/edit">en aquesta plantilla</a></b>.
    </p>
    <p>
        <b>Conseqüències del desistiment.</b>Et tornarem tots els pagaments rebuts, si n’hi ha, dintre dels 14 dies naturals a partir de la data en què ens comuniquis la teva decisió. Efectuarem aquest reemborsament sense que suposi cap més despesa per a tu, i farem servir el mateix mitjà de pagament que hagis emprat per a la transacció inicial, si no és que ens indiques el contrari. En cas que ja es trobi actiu el subministrament d’electricitat, ens hauràs d’abonar el consum corresponent als dies en què t’hàgim prestat servei, així com la resta de costos associats a la contractació i, si s’escau, la reposició a la situació anterior.
    </p>
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
        ${pot_deseada}
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
    <p>
        <b>Derecho de desistimiento.</b> Todas las personas consumidoras de la cooperativa disponen de 14 días naturales desde la fecha del contrato para desistir de los servicios. Si quieres desistir, es necesario que nos notifiques tu decisión por correo electrónico a comercializacion@somenergia.coop, o por correo postal a SOM ENERGIA SCCL c/Pic de Peguera 11, 17003 Girona. Para hacerlo, puedes utilizar el texto que figura <b><a href="https://docs.google.com/document/d/1KOnlw370Fkv8VX8mw2qfC7zvPKnAmptcGsvXU-4tMCc/edit">en esta plantilla</a></b>.
    </p>
    <p>
        <b>Consecuencias del desistimiento.</b> Te devolveremos todos los pagos recibidos, si los hay, dentro de 14 días naturales a partir de la fecha en la que nos comuniques tu decisión. Efectuaremos dicho reembolso, sin que esto suponga ningún gasto para ti, utilizando el mismo medio de pago que hayas empleado para la transacción inicial, a no ser que nos indiques lo contrario. En caso de que ya se encuentre activo el suministro de electricidad, deberás abonarnos el consumo correspondiente a los días en que te hayamos prestado servicio.
    </p>
    Hasta pronto,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
