<%

pas1 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None

if pas1:

    PasM101 = object.pool.get('giscedata.switching.m1.01')
    mapaTarifes = dict(PasM101.fields_get(object._cr, object._uid)['tarifaATR']['selection'])
    tarifaATR = mapaTarifes[pas1.tarifaATR]

    cont_telefon = pas1.cont_telefons and pas1.cont_telefons[0].numero or object.tel_pagador_polissa

    if tarifaATR == '3.0A':
        lineesDePotencia = '\n'.join((
            '&nbsp;&nbsp;- <strong> %s: %s W</strong> <br>' % (p.name, p.potencia)
            for p in pas1.header_id.pot_ids
            if p.potencia != 0
        ))
    else:
      for p in pas1.header_id.pot_ids:
          if p.potencia == 0: continue
          potencia = p.potencia
          break

    pot_deseada = lineesDePotencia if tarifaATR == '3.0A' else potencia
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
        - Tarifa d'accés: ${tarifaATR} <br>
        %if tarifaATR == '3.0A':
        - Potències desitjades: <br>
        ${pot_deseada}
        %else:
        - Potència desitjada: ${pot_deseada} W <br>
        %endif
        %if pas1.solicitud_tensio:
            <%
                tipus_tensio = None
                if pas1.solicitud_tensio == 'T':
                    tipus_tensio = "Trifàsica"
                elif pas1.solicitud_tensio == 'M':
                    tipus_tensio = "Monofàsica"
            %>
        - Tensió desitjada: ${tipus_tensio}
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
    <br>
    <p>
        <b>IMPORTANT:</b>  Si ets una persona treballadora autònoma i vols reduir la potència contractada a causa de l’estat d’alarma, ens has d’enviar el document d’alta al règim especial de treballadores autònomes de la Seguretat Social, per tal d’acollir-te a les mesures del real Decret-llei 11/2020, de 31 de Març, responent aquest mateix correu.
Si ets una empresa i la teva distribuïdora és E-Distribución (antiga Endesa), un document indicant que et vols acollir a l’article 42 del RDL 11/2020, el CUPS i el NIF, pots fer servir <a href="https://drive.google.com/file/d/1ilMCLmoQxEszwE4eGRcOtHjLqtbtpIBG/view">aquest model</a>.
    </p>
    <br>
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
        - Tarifa de acceso: ${tarifaATR}<br>
        %if tarifaATR == '3.0A':
        - Potencias deseadas: <br>
        ${pot_deseada}
        %else:
        - Potencia deseada: ${pot_deseada} W<br>
        %endif
        %if pas1.solicitud_tensio:
            <%
                tipus_tensio = None
                if pas1.solicitud_tensio == 'T':
                    tipus_tensio = "Trifásica"
                elif pas1.solicitud_tensio == 'M':
                    tipus_tensio = "Monofásica"
            %>
        - Tensión deseada: ${tipus_tensio}
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
    <br>
    <p>
        <b>IMPORTANTE:</b> Si eres una persona trabajadora autónoma y quieres reducir la potencia contratada a causa del estado de alarma, nos tienes que enviar el documento de alta al régimen especial de trabajadoras autónomas de la Seguridad Social, para acogerte a las medidas del real Decreto ley 11/2020, de 31 de Marzo, respondiendo a este mismo correo.
Si eres una empresa y tu distribuidora es E-Distribución (antigua Endesa), un documento indicando que quieres acogerte al artículo 42 del RDL 11/2020, el CUPS y el NIF, puedes utilizar <a href="https://drive.google.com/file/d/1Hw-7WdrFyonP3nb3z4m7GFqHZNNLrwzH/view">este modelo</a>.
    </p>
    <br>
    Hasta pronto,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
