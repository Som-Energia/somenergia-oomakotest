<!doctype html>
<html>
<head>
<meta charset='utf-8'>
</head>
<body>
<table width="100%" frame="below" bgcolor="#E8F1D4">
% if object.cups_polissa_id.titular.lang == "ca_ES":
<tr><td height=2px><font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td>
<td valign=top rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height=2px><font size=2>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr>
<tr><td height=2px><font size=2>Codi CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height=2px width=100%><font size=2> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr>
% else:
<tr><td height=2px><font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td>
<td valign=top rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height=2px><font size=2>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr>
<tr><td height=2px><font size=2>Código CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height=2px width=100%><font size=2> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr>
% endif
</table>
<%
pas2 = None
for step in object.step_ids:
  model, res_id = step.pas_id.split(',')
  obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if step.pas_id.startswith('giscedata.switching.m1.02'):
    pas2 = obj
  if step.pas_id.startswith('giscedata.switching.m1.01'):
    pas1 = obj
# TODO: Si el pas2 no existeix abortar el correu

tarifaATR=dict(object.pool.get('giscedata.switching.m1.01').fields_get(object._cr, object._uid)['tarifaATR']['selection'])[pas1.tarifaATR]

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''
%>

Hola${nom_titular}, 
% if object.cups_polissa_id.titular.lang != "es_ES":

La <font color="green"><strong> modificació contractual que vares sol·licitar ha estat acceptada</strong></font>.

%if pas1.sollicitudadm == "S":
El canvi de titular es veurà reflectit a la propera factura, i, en els següents dies, a la oficina virtual.

%elif pas1.sollicitudadm == "N":
%if TarifaATR == '3.0A':
El canvi s’efecturarà en el proper cicle de facturació.

%else: # no 3.0
Durant els propers 15 dies vindrà un tècnic de l'empresa distribuïdora per fer-la efectiva.

Recorda que si el comptador no està accessible el tècnic de l’empresa distribuïdora es posarà en contacta amb tu prèviament.

%endif
Uns dies més tard, rebràs un mail on t'indicarem la data exacta d'activació de la modificació.

% endif

Les dades del contracte modificat són les següents:
- Adreça: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}


Atentament,

Equip de Som Energia
modifica@somenergia.coop
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":

La <font color="green"><strong> modificación contractual que solicitaste ha sido aceptada</strong></font>.

%if pas1.sollicitudadm == "S":
El cambio de titular se verá reflejado en la próxima factura, y, durante los siguientes días, en la oficina virtual.

%elif pas1.sollicitudadm == "N":
%if TarifaATR == '3.0A':
El cambio se efectuará en el siguiente ciclo de facturación.

%else: # no 3.0
Durante <strong>los próximos 15 días, vendrá un técnico de la empresa distribuidora  para hacerla efectiva.</strong>

Recuerda que si el contador no está accesible el técnico de la empresa distribuidora se pondrá en contacto contigo préviament.

%endif
Unos dias más tarde, recibirás un correo donde te indicaremos la fecha exacta de activación de la modificación.

% endif

Los datos del contrato son los siguientes:
- Dirección: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}


Atentamente,

Equipo de Som Energia
modifica@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
