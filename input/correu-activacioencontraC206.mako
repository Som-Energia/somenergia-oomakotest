<html>
% if object.cups_polissa_id.titular.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% else:
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% endif
<%
for step in object.step_ids:
  obj = step.pas_id
  model = obj._table_name
  if model.startswith('giscedata.switching.c1.06') or model.startswith('giscedata.switching.c2.06'):
    pas6 = obj

from datetime import datetime, timedelta
date = datetime.strptime(pas6.data_activacio, '%Y-%m-%d')
date = date.strftime('%d/%m/%Y')

p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

%>
Hola${nom_titular}, 

% if object.cups_polissa_id.titular.lang != "es_ES":
T’escrivim per informar-te que ens han comunicat la baixa del teu contracte amb Som Energia. La data de canvi de companyia és el  <strong>${date}</strong>

No cal que facis cas d’aquest missatge si certament vols passar el contracte de Som Energia a una altra comercialitzadora.
 
Però si no eres conscient que s’ha realitzat aquesta sol·licitud i s’ha fet contra la teva voluntat, respon a aquest mateix correu i iniciarem els tràmits perquè tornis a tenir el contracte amb la cooperativa.

Gràcies.

Salutacions,

Equip de Som Energia
comercialitzacio@somenergia.coop
<a href="www.somenergia.coop">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
Te escribimos para informarte que nos han comunicado la baja de tu contrato con Som Energia. La fecha de cambio de compañia es el <strong>${date}</strong>

No es necesario que atiendas a este mensaje si efectivamente quieres pasar el contrato de Som Energia a otra comercializadora. 
 
Pero si no eres consciente de que se realizó esta solicitud y se hizo contra tu voluntad, responde a este mismo correo e iniciaremos los trámites para que vuelvas a tener el contrato con la cooperativa.

Gracias. 

Un saludo,

Equipo de Som Energia
comercializacion@somenergia.coop
<a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
% endif
</body>
</html>
</html>