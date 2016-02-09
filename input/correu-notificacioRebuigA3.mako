<!doctype html>
<html>
% if object.cups_polissa_id.titular.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% else:
<head><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr></table></head><body>
% endif
<%
p_obj = object.pool.get('res.partner')
if not object.vat_enterprise():
  nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid, object.cups_polissa_id.titular.name)['nom']
else:
  nom_titular = ''

%>
Hola${nom_titular}, 

% if object.cups_polissa_id.titular.lang != "es_ES":
Fa uns dies vàrem iniciar  la sol.licitud d'alta de subministrament 

La companyia distribuïdora (que gestiona aquest procediment) ens indica que per completar la sol.licitud és necessària la presentació del Butlletí de la instal.lació. (link a la FAQ)

Aquest document certifica que la vostra instal·lació compleix la llei en matèria de seguretat i les seves especificacions tècniques. Un electricista qualificat podrà emetre aquest Butlletí. 

Un cop el tingueu, ens el podeu fer arribar en resposta en aquest correu i el remetrem a la distribuïdora per continuar amb el procés d’alta. 


Gràcies per la teva atenció,  estem en contacte per a qualsevol dubte o consulta.

Atentament,

Equip de Som Energia
comercialitzacio@somenergia.coop
<a href="www.somenergia.coop">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES":
Hace unos días iniciamos la solicitud de alta de suministro. 

La companyia distribuïdora (que gestiona este procedimiento) nos indica que para completar la solicitud es necesaria la presentación del Boletín de la instalación eléctrica (link a la FAQ)

Este documento certifica que vuestra instalación cumple con la ley en materia de seguridad y sus especificaciones técnicas. Un electricista cualificado podrá emitir el Boletín. 

Una vez emitido, nos lo podéis adjuntar en respuesta a este correo y lo remitiremos a la distribuidora para continuar el proces de alta. 

Muchas gracias por tu atención, estamos en contacto para cualquier duda o consulta.

Atentamente,

Equipo de Som Energia
comercializacion@somenergia.coop
<a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
% endif
</body>
</html>
</html>