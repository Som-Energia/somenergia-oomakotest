% if object.cups_polissa_id.titular.lang == "ca_ES":
<!doctype html><html><head><meta charset="utf-8"/></head><body> <table width="100%" frame="below" bgcolor="#E8F1D4"> <tr><td height=2px><font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td> <td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr> <tr><td height=2px><font size=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr> <tr><td height=2px><font size=1>Codi CUPS: ${object.cups_id.name}</font></td></tr> <tr><td height=2px width=100%><font size=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr> </table>
% else:
<!doctype html><html><head><meta charset="utf-8"/></head><body> <table width="100%" frame="below" bgcolor="#E8F1D4"> <tr><td height=2px><font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td> <td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr> <tr><td height=2px><font size=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr> <tr><td height=2px><font size=1>Código CUPS: ${object.cups_id.name}</font></td></tr> <tr><td height=2px width=100%><font size=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr> </table>
% endif
<%
model1 = pas1 = model4 = pas4 = model2 =  pas2 = None
for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))

  if model.startswith('giscedata.switching.m1.01'):
    model1 , pas1 = model , obj
  if model.startswith('giscedata.switching.m1.04'):
    model4 , pas4 = model , obj
  if model.startswith('giscedata.switching.m1.02'):
    model2 , pas2 = model , obj
  if model1 and model2 and model4 and pas1 and pas2 and pas4:
    break

if not pas4:
    model4 = model2
    pas4 = pas2

phone = pas1.cont_telefon
TarifaATR=dict(object.pool.get(model1).fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas1.tarifaATR]
if TarifaATR == '3.0A':
  lineesDePotencia = '\n'.join((
    '&nbsp;&nbsp;&nbsp;&nbsp;- <strong> %s: %s W</strong>'%(p.name, p.potencia)
    for p in pas1.header_id.pot_ids
    if p.potencia != 0
    ))
else:
  for p in pas1.header_id.pot_ids:
    if p.potencia == 0: continue
    potencia = p.potencia
    break

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

def IsThisError(reg,err_id):
  #return reg.motiu_rebuig.id == err_id
  return reg.motiu_rebuig.name == str(err_id)

%>
Hola${nom_titular}, 
% if object.cups_polissa_id.titular.lang != "es_ES":

Recentment has sol·licitat una modificació de tarifa i/o potència del teu contracte de llum. Aquestes son les dades de la teva sol·licitud:

- Tarifa desitjada : <strong>${TarifaATR}</strong>
%if TarifaATR == '3.0A':
- Potència desitjada: 
${lineesDePotencia}
%else:
- Potència desitjada: <strong>${potencia} W</strong>
%endif
- Telèfon de contacte: <strong>${phone}</strong>

L'empresa de <a href="http://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">distribució elèctrica de la teva zona</a> és la encarregada d'acceptar i aplicar aquestes modificacions.

En el teu cas, lamentem informar-te que <strong>la sol·licitud a estat rebutjada</strong> pel següent motiu: 

%for r in pas4.rebuig_ids:
<i> - ${r.motiu_rebuig.text} ${(" - "+r.desc_rebuig) if r.desc_rebuig != r.motiu_rebuig.text else ""}</i>

%if IsThisError(r,26):
Algún tècnic de la distribuidora s'ha posat en contacte amb vosaltres?

El telèfon de contacte que ens vas facilitar és correcte?

Si tens el comptador a dins de casa o a un bloc de pisos que no tenen accés lliure, et recomanem que estiguis atent a les trucades telefòniques quan hagueu rebut el mail de ""Modificació contractual acceptada"".

En cas que aquest motiu de rebuig ja ho haguis rebut en altres ocasions, et recomanem tornar a demanar la modificanció contestant aquest correu i una vegada rebis el correu de ""Modificació contractual acceptada"" et possis directament en contacte amb la distribuïdora i preguntis pels tècnis que gestionaran el teu tràmit.
%elif IsThisError(r,31):
Algún tècnic de la distribuidora s'ha posat en contacte amb vosaltres?

Segon la informació que ens envia, no veu donar permís al tècnic per aplicar les modificacions. És així?
%elif IsThisError(r,62):
Algún tècnic de la distribuidora s'ha posat en contacte amb vosaltres?

Segon la informació que ens envia, no veu donar permís al tècnic per aplicar les modificacions. És així?
%elif IsThisError(r,999999): # add new ca_ES errors here
Undefined error.
%endif

%endfor
Atentament,

Equip de Som Energia
modifica@somenergia.coop
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":

Recientemente has solicitado una modificación de tarifa y/o potencia de tu contrato de luz. Estos son los datos de tu solicitud:

- Tarifa deseada: <strong>${TarifaATR}</strong>
%if TarifaATR == '3.0A':
- Potencia deseada: 
${lineesDePotencia}
%else:
- Potencia deseada: <strong>${potencia} W</strong>
%endif
- Teléfono de contacto: <strong>${phone}</strong>

La empresa de <a href="http://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">distribución eléctrica de tu zona</a> es la encargada de aceptar y aplicar estas modificaciones.

En tu caso, lamentamos informarte que <strong>la solicitud ha sido rechazada</strong> por el siguiente motivo: 

%for r in pas4.rebuig_ids:
<i> - ${r.motiu_rebuig.text} ${(" - "+r.desc_rebuig) if r.desc_rebuig != r.motiu_rebuig.text else ""}</i>

%if IsThisError(r,26):
¿Se ha puesto en contacto con vosotros algún técnico de la distribuidora? 

¿El teléfono de contacto que nos facilitaste es correcto?

Si tienes el contador dentro de casa o en un bloque de pisos que no tiene libre acceso, te recomendamos que estés atento a las llamadas telefónicas cuando haya recibido el mail de ""Modificación contractual aceptada""

En caso de que este motivo de rechazo ya lo hayas recibido en otras ocasiones, te recomendamos volver a solicitar la modificanción contestando este correo y una vez recibas el correo de ""Modificación aceptada"" te pongas directamente en contacto con la distribuidora y preguntes por los técnicos que gestionarán tu trámite."
%elif IsThisError(r,31):
¿Se ha puesto en contacto con vosotros algún técnico de la distribuidora?

Según la información que nos envian, no habéis dado permiso al técnico para aplicar las modificaciones. ¿Es asi?
%elif IsThisError(r,62):
¿Se ha puesto en contacto con vosotros algún técnico de la distribuidora?

Según la información que nos envian, no habéis dado permiso al técnico para aplicar las modificaciones. ¿Es asi?
%elif IsThisError(r,999999): # add new es_ES errors here
Undefined error.
%endif

%endfor
Atentamente,

Equipo de Som Energia
modifica@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
