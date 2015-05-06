<!doctype html>
<html>
<head></head>
<body>
<div align="right"><img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
<%
try:
  falta_lectura = 0
  for step in object.step_ids:
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
    if step.pas_id.startswith('giscedata.switching.c1.02') or step.pas_id.startswith('giscedata.switching.c2.02'):
      pas2 = obj
    if step.pas_id.startswith('giscedata.switching.c1.01') or step.pas_id.startswith('giscedata.switching.c2.01') :
      pas1 = obj
  if pas1.activacio_cicle == 'N':
    data_act = "La data de l’activació serà aproximadament en uns 15 dies"
    data_act_cast = "La fecha de activación será aproximadamente en unos 15 días"
  else: 
    from datetime import datetime, timedelta
    # TODO: Cas pas2.data_ult_lect == False
    date = datetime.strptime(pas2.data_ult_lect, '%Y-%m-%d')
    if object.cups_polissa_id.tarifa_codi == "3.0A": 
      date += timedelta(40)
      data_act= "La data de l’activació serà aproximadament el dia " + date.strftime('%d/%m/%Y')
      data_act_cast = "La fecha de activación será aproximadamente el día " + date.strftime('%d/%m/%Y')
    else:
      date += timedelta(70)
      data_act = "La data de l’activació serà aproximadament el dia " + date.strftime('%d/%m/%Y')
      data_act_cast = "La fecha de activación será aproximadamente el día " + date.strftime('%d/%m/%Y')
    avui_5 = datetime.strftime(datetime.today() +timedelta(5) ,('%Y/%m/%d'))
    if date.strftime('%Y/%m/%d') >'9999/01/01' or date.strftime('%Y/%m/%d') <= avui_5:
      falta_lectura = True
       
except:
    data_act = 0
    data_act_cast = 0

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

%>
% if object.cups_polissa_id.titular.lang != "es_ES":
Hola${nom_titular},

Ens plau comunicar-te que la <strong>sol·licitud del canvi ha estat acceptada</strong>.

% if falta_lectura:

<HR width=80% align="left"><strong><u>Important<u></strong>: per tal que l’activació sigui efectiva, és necessari que comuniquis la lectura actual del comptador a la distribuïdora de la zona. 

Telefons de les diferentes distribuïdores per comunicar la lectura:
- Endesa Distribución 902 509600
- Iberdrola 900171171
- Fenosa 900 111 999
- Hidrocantrábrico (EdP) 900 907 004
- E.On 900 10 10 51

<strong>Per què he d'informar la lectura?</strong> En el moment de realitzar la petició de canvi, sol•licitem que es faci efectiva coincidint amb la lectura. 
Si per qualsevol motiu aquesta no es realitza, aquest fet por fer que el canvi a Som Energia trigui més del que esperem. <HR width=80% align="left">

Quan ens informin de la data d’activació, te la confirmarem via correu electrònic. 
% else:
% if data_act:

${data_act}.  
% endif

T'enviarem un e-mail per comunicar-te que el contracte ja està actiu amb la cooperativa.
% endif

Tingues en compte que encara t'arribarà una factura (la darrera) de la companyia actual. 

Les dades del contracte són les següents:
- Número de contracte amb Som Energia: ${object.cups_polissa_id.name}
- Titular del contracte: ${object.cups_polissa_id.titular.name}
- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}

- Adreça: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}


Atentament,

Equip de Som Energia
comercialitzacio@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
Hola${nom_titular},

Nos complace comunicarte que<strong> la solicitud del cambio ha sido aceptada</strong>.
% if falta_lectura:

<HR width=80% align="left"><strong><u>Importante<u></strong>: para que la activación sea efectiva, es necesario que comuniques la lectura actual del contador a la distribuidora de tu zona.

Telefonos de las diferentes distribuidoras para comunicar la lectura:
- Endesa Distribución 902 509600
- Iberdrola 900171171
- Fenosa 900 111 999
- Hidrocantrábrico (EdP) 900 907 004
- E.On 900 10 10 51

<strong>¿Por qué tengo que dar la lectura?</strong>En el momento de realizar la petición de cambio, solicitamos que ésta sea efectiva coincidiendo con una toma de lectura. 
Si por cualquier motivo la toma de lectura no se realiza con regularidad, puede retrasar el cambio a Som Energia.  <HR width=80% align="left">

Cuando nos informen la fecha de activación, te la confirmaremos via e-mail. 
% else:
% if data_act_cast:

${data_act_cast}.  
% endif

Cuando nos lo comuniquen, te enviaremos un e-mail indicando que el contrato ya es activo con la cooperativa.
% endif

En cualquier caso, todavía te llegará una factura (la última) de la compañía actual. 

Los datos del contrato son los siguientes:
- Número de contrato con Som Energia: ${object.cups_polissa_id.name} 
- Titular del contrato: ${object.cups_polissa_id.titular.name}
- Socio/a Som Energia: ${object.cups_polissa_id.soci.name}

- Dirección: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}


Atentamente,

Equipo de Som Energia
comercializacion@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
