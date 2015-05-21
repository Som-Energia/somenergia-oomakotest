<!doctype html>
<html>
<head>
<meta charset='utf-8'/>
</head>
<body>
<table width="100%" frame="below" bgcolor="#E8F1D4">
% if object.cups_polissa_id.titular.lang == "ca_ES":
<tr><td height=2px><font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td>
<td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height=2px><font size=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr>
<tr><td height=2px><font size=1>Codi CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height=2px width=100%><font size=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr>
% else:
<tr><td height=2px><font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td>
<td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height=2px><font size=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr>
<tr><td height=2px><font size=1>Código CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height=2px width=100%><font size=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr>
% endif
</table>
<%

for step in object.step_ids:
  model, res_id = step.pas_id.split(',')
  obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  print step.pas_id
  if step.pas_id.startswith('giscedata.switching.m1.05'):
    pas5 = obj
    break

from datetime import datetime, timedelta
date = datetime.strptime(pas5.data_activacio, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')

TarifaATR=dict(object.pool.get(model).fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas5.tarifaATR]
if TarifaATR == '3.0A':
  lineesDePotencia = '\n'.join((
    '<li><strong> %s: %s W</strong></li>'%(p.name, p.potencia)
    for p in pas5.header_id.pot_ids
    if p.potencia != 0
    ))
else:
  for p in pas5.header_id.pot_ids:
    if p.potencia == 0: continue
    potencia = p.potencia
    break


p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

%>
%if object.cups_polissa_id.titular.lang != "es_ES":

Hola${nom_titular}, 

La sol·licitud de la <font color="green"><strong> modificació contractual ha estat ACTIVADA</strong></font>, amb data ${date}.

Les <b>condicions contractuals actuals</b> del teu contracte amb Som Energia són:

<ul>
<li><strong> Tarifa: ${TarifaATR}</strong></li>
%if TarifaATR == '3.0A':
<li><strong> Potència: </strong>
<ul>
${lineesDePotencia}
</ul>
</li>
%else:
<li><strong> Potència: ${potencia} W</strong></li>
%endif
</ul>

A la propera factura es veurà reflectida la modificació, i a la oficina virtual en els següents dies.

Les dades del contracte  que s'ha fet la modificació contractual són les següents:
- Titular del contracte: ${object.cups_polissa_id.titular.name}
- Adreça: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}
- Número de contracte amb Som Energia: ${object.cups_polissa_id.name}
- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}

Estem en contacte per a qualsevol dubte o consulta.

Atentament,

Equip de Som Energia
modifica@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
Hola${nom_titular}, 

La solicitud de  <font color="green"><strong>la modificación contractual ha sido ACTIVADA</strong></font> con fecha ${date}.

Las <b>condiciones contractuales actuales</b> de tu contrato con Som Energia son:
<ul>
<li><strong> Tarifa: ${TarifaATR}</strong></li>
%if TarifaATR == '3.0A':
<li><strong> Potencia: </strong>
<ul>
${lineesDePotencia}
</ul>
</li>
%else:
<li><strong> Potencia: ${potencia} W</strong></li>
%endif
</ul>

En la próxima factura se verá reflejada la modificación, y en la oficina virtual en los siguientes días.

Los datos del contrato son los siguientes:
- Titular del contrato: ${object.cups_polissa_id.titular.name}
- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}
- Dirección: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}
- Número de contrato con Som Energia: ${object.cups_polissa_id.name} 

Estamos en contacto para cualquier duda o consulta.

Atentamente,

Equipo de Som Energia
modifica@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html> 

