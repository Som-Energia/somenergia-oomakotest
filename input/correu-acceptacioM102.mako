<!doctype html>
<html>
% if object.cups_polissa_id.titular.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% else:
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% endif
<head></head>
<body>
<%

for step in object.step_ids:
  model, res_id = step.pas_id.split(',')
  obj = object.pool.get(model).browse(object._cr, object._uid, int(res_id))
  if step.pas_id.startswith('giscedata.switching.m1.02'):
    pas2 = obj
  if step.pas_id.startswith('giscedata.switching.m1.01'):
    pas1 = obj

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''
%>
Hola${nom_titular}, 
% if object.cups_polissa_id.titular.lang != "es_ES":

Fa uns dies vas sol•licitar una modificació contractual.

La sol•licitud de la <FONT COLOR="green"><strong> modificació contractual ha estat acceptada</strong></FONT>.
% if pas1.sollicitudadm == "N":

Durant <strong>els propers 15 dies, vindrà un tècnic de l’empresa distribuïdora per fer la modificació, si el comptador no està accesible es posaria en contacte amb tu.</strong>

La modificació serà efectiva a partir de la visita del tècnic. <strong>Uns dies més tard, rebràs un mail </strong>on t'indicarem la data exacta d'activació de la modificació.
% elif pas1.sollicitudadm == "S":

A la propera factura es veurà reflectit el canvi de titular,  i a la oficina virtual en els següents dies.
% endif

Les dades del contracte  que s'ha fet la modificació contractual són les següents:
- Adreça: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}

Atentament,

Equip de Som Energia
modifica@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":

Hace unos días solicitaste una modificación contractual. 

La solicitud de  <FONT COLOR="green"><strong>la modificación contractual ha sido aceptada</strong></FONT>.
% if pas1.sollicitudadm == "N":

Durante <strong>los próximos 15 días, vendrá alguien de la empresa distribuidora  para hacer la modificación, si el contador no está accesible se pondría en contacto contigo</strong>.

La modificación será efectiva a partir de la visita del técnico. <strong>Unos días más tarde, recibirás un correo</strong> donde te indicaremos la fecha exacta de la activación de la modificación.
% elif pas1.sollicitudadm == "S":

A la próxima factura podrás ver reflectido el cambio de titular, y en la oficina virtual en los siguientes días.
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

