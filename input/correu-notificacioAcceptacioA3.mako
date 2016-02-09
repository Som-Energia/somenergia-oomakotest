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
p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

%>
Hola${nom_titular},
% if object.cups_polissa_id.titular.lang != "es_ES":

<b>Ens plau comunicar-te que la sol·licitud del canvi ha estat acceptada</b>.

En un termini màxim de 15 dies la companyia distribuïdora realitzarà les gestions necessàries per fer efectiva l’alta de subministrament. Si fos necessari, contactarà amb tu al telèfon que vares indicar en emplenar el formulari. 

<b>T'enviarem un darrer e-mail per comunicar-te  la data efectiva de l’alta. </b>

Les dades del contracte són les següents:
- Número de contracte amb Som Energia: ${object.cups_polissa_id.name}
- Titular del contracte: ${object.cups_polissa_id.titular.name}
- Soci/a Som Energia: ${object.cups_polissa_id.soci.name}

- Adreça: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name}
- Potència: ${object.cups_polissa_id.potencia} kW
- Tarifa: ${object.cups_polissa_id.tarifa.name}

Atentament,

Equip de Som Energia
comercialitzacio@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":

<b>Nos complace comunicarte que la solicitud del cambio ha sido aceptada</b>.

En un plazo máximo de 15 días la compañía distribuidora realizará las gestiones necesarias para hacer efectiva la alta de suministro. Si fuera necesario, contactará contigo en el teléfono que varas indicar al rellenar el formulario. 

<b>Te enviaremos un último e-mail para comunicarte la fecha efectiva del alta.</b> 

Los datos del contrato son los siguientes:
- Número de contrato con Som Energia: ${object.cups_polissa_id.name} 
- Titular del contrato: ${object.cups_polissa_id.titular.name}
- Socio/a Som Energia: ${object.cups_polissa_id.soci.name}

- Dirección: ${object.cups_polissa_id.cups_direccio}
- CUPS: ${object.cups_id.name} 
- Potencia: ${object.cups_polissa_id.potencia} kW
- Tarifa: ${object.cups_polissa_id.tarifa.name}

Atentamente,

Equipo de Som Energia
comercializacion@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
