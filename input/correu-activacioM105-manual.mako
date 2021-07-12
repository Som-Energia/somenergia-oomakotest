% if object.cups_polissa_id.titular.lang == "ca_ES":
<!doctype html><html><head><meta charset="utf-8"/></head><body> <table width="100%" frame="below" bgcolor="#E8F1D4"> <tr><td height=2px><font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td> <td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr> <tr><td height=2px><font size=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr> <tr><td height=2px><font size=1>Codi CUPS: ${object.cups_id.name}</font></td></tr> <tr><td height=2px width=100%><font size=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr> </table>
% else:
<!doctype html><html><head><meta charset="utf-8"/></head><body> <table width="100%" frame="below" bgcolor="#E8F1D4"> <tr><td height=2px><font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td> <td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr> <tr><td height=2px><font size=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr> <tr><td height=2px><font size=1>Código CUPS: ${object.cups_id.name}</font></td></tr> <tr><td height=2px width=100%><font size=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr> </table>
% endif
<%
for step in object.step_ids:
  obj = step.pas_id
  try:
    model = obj._table_name
  except:
    # Deprecated method
    model, res_id = step.pas_id.split(',')
    obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if model.startswith('giscedata.switching.m1.05'):
    pas5 = obj
    break

from datetime import datetime, timedelta
date = datetime.strptime(pas5.data_activacio, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')

TarifaATR=dict(object.pool.get(model).fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas5.tarifaATR]
pot_deseada_ca = '\n'.join((
  '\t- <strong> %s: </strong>%s W'%(p.name, p.potencia)
  for p in pas5.header_id.pot_ids
  if p.potencia != 0
  ))

pot_deseada_es = pot_deseada_ca
if TarifaATR == "2.0TD":
  pot_deseada_ca = pot_deseada_ca.replace("P1:", "Punta:").replace("P2:", "Vall:")
  pot_deseada_es = pot_deseada_es.replace("P1:", "Punta:").replace("P2:", "Valle:")


p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

%>
%if object.cups_polissa_id.titular.lang != "es_ES":
<br/>
Hola${nom_titular}, <br/>
<br/>
La sol·licitud de la <font color="green"><strong> modificació contractual ha estat ACTIVADA</strong></font>, amb data ${date}.<br/>
<br/>
Les <b>condicions contractuals actuals</b> del teu contracte amb Som Energia són:<br/>
<br/>
<strong> Tarifa: ${TarifaATR}</strong><br/>
<strong> Potència: </strong><br/>
${pot_deseada_ca}<br/>
<br/>
A la propera factura es veurà reflectida la modificació, i a la oficina virtual en els següents dies.<br/>
<br/>
Les dades del contracte  que s'ha fet la modificació contractual són les següents:<br/>
- Titular del contracte: ${object.cups_polissa_id.titular.name}<br/>
- Adreça: ${object.cups_polissa_id.cups_direccio}<br/>
- CUPS: ${object.cups_id.name}<br/>
- Número de contracte amb Som Energia: ${object.cups_polissa_id.name}<br/>
- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br/>
<br/>
Estem en contacte per a qualsevol dubte o consulta.<br/>
<br/>
Atentament,<br/>
<br/>
Equip de Som Energia<br/>
modifica@somenergia.coop<br/>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
<br/>
Hola${nom_titular}, <br/>
<br/>
La solicitud de  <font color="green"><strong>la modificación contractual ha sido ACTIVADA</strong></font> con fecha ${date}.<br/>
<br/>
Las <b>condiciones contractuales actuales</b> de tu contrato con Som Energia son:<br/>
<br/>
<strong> Tarifa: ${TarifaATR}</strong><br/>
<strong> Potencia: </strong><br/>
${pot_deseada_es}<br/>
<br/>
En la próxima factura se verá reflejada la modificación, y en la oficina virtual en los siguientes días.<br/>
<br/>
Los datos del contrato son los siguientes:<br/>
- Titular del contrato: ${object.cups_polissa_id.titular.name}<br/>
- Dirección: ${object.cups_polissa_id.cups_direccio}<br/>
- CUPS: ${object.cups_id.name}<br/>
- Número de contrato con Som Energia: ${object.cups_polissa_id.name} <br/>
- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br/>
<br/>
Estamos en contacto para cualquier duda o consulta.<br/>
<br/>
Atentamente,<br/>
<br/>
Equipo de Som Energia<br/>
modifica@somenergia.coop<br/>
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
