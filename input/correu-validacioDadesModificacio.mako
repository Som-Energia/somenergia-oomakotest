<!doctype html><html><head><meta charset="utf-8"/></head><body><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr></table>
<%
for step in object.step_ids:
  model, res_id = step.pas_id.split(',')
  obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if step.pas_id.startswith('giscedata.switching.m1.01'):
    pas1 = obj
    break
tarifaATR=dict(object.pool.get('giscedata.switching.m1.01').fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas1.tarifaATR]
print "'{}'".format(tarifaATR)

if tarifaATR == '3.0A':
  lineesDePotencia = '\n'.join((
    '\t- <strong> %s: %s W</strong>'%(p.name, p.potencia)
    for p in pas1.header_id.pot_ids
    if p.potencia != 0
    ))
else:
  for p in pas1.header_id.pot_ids:
    if p.potencia == 0: continue
    potencia = p.potencia
    break

%>
% if object.cups_polissa_id.titular.lang != "ca_ES":
Hola,

Hemos recibido una solicitud de modificación del contrato ${object.cups_polissa_id.name}. con Som Energia:

Datos del contrato:
- CUPS: ${object.cups_id.name}
- Dirección: ${object.cups_polissa_id.cups_direccio}
- Persona titular: ${object.cups_polissa_id.titular.name} 
- DNI, NIE o CIF: ${object.nif_titular_polissa}

%if tarifaATR == '3.0A':
Datos de la solicitud:
- Tarifa de acceso: ${tarifaATR}
- Potencia deseada:
${lineesDePotencia}
%else:
- Tipo de modificación: Reducción de potencia
- Tarifa deseada: ${tarifaATR}
- Potencia deseada: ${potencia} kW
%endif

Teléfono de contacto: ${object.tel_pagador_polissa} (recuerda que este teléfono lo utilizará la distribuidora de tu zona para ponerse en contacto contigo en caso de que sea necesario).

En los próximos días recibirás un correo electrónico en el que te informaremos del estado de tu solicitud.

En un plazo de 24 horas enviaremos la solicitud a la distribuidora de tu zona, la encargada de validar y hacer efectiva tu solicitud. En el caso que detectes algún error, responde este mismo correo electrónico lo antes posible.

Hasta pronto

Equipo de Som Energia
modifica@somenergia.coop
www.somenergia.coop/ca
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
%endif
% if object.cups_polissa_id.titular.lang != "es_ES":
Hola,

Hem rebut una sol·licitud de modificació del contracte ${object.cups_polissa_id.name} amb Som Energia:

Dades del contracte:
- CUPS: ${object.cups_id.name}
- Adreça: ${object.cups_polissa_id.cups_direccio}
- Persona titular: ${object.cups_polissa_id.titular.name} 
- DNI, NIE o CIF: ${object.nif_titular_polissa}

%if tarifaATR == '3.0A':
Dades de la sol·licitud:
- Tarifa d'accés: ${tarifaATR}
- Potències desitjades:
${lineesDePotencia}
%else:
- Tipus de modificació: Reducción de potencia
- Tarifa desijada: ${tarifaATR}
- Potència desitjada: ${potencia} kW
%endif

Telèfon de contacte: ${object.tel_pagador_polissa} (recorda que aquest telèfon l'utilitzarà la distribuïdora de la teva zona per posar-se en contacte amb tu en el cas que sigui necessari).

En els propers dies rebràs un correu electrònic en què t’informarem de l’estat de la teva sol·licitud. 

En un termini de 24 h enviarem la teva sol·licitud a la distribuïdora de la teva zona, l’encarregada de validar i fer efectiva la teva sol·licitud. En el cas que detectis algun error, respon aquest mateix correu electrònic al més aviat possible.

Fins ben aviat

Equip de Som Energia
modifica@somenergia.coop
www.somenergia.coop/ca

%endif
</body>
</html>
