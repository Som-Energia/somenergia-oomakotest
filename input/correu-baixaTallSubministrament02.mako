% if object.cups_polissa_id.titular.lang == "ca_ES":
<!doctype html><html><head><meta charset="utf-8"/></head><body> <table width="100%" frame="below" bgcolor="#E8F1D4"> <tr><td height=2px><font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font></td> <td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr> <tr><td height=2px><font size=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr> <tr><td height=2px><font size=1>Codi CUPS: ${object.cups_id.name}</font></td></tr> <tr><td height=2px width=100%><font size=1> Titular: ${object.cups_polissa_id.titular.name} </font></td></tr> </table>
% else:
<!doctype html><html><head><meta charset="utf-8"/></head><body> <table width="100%" frame="below" bgcolor="#E8F1D4"> <tr><td height=2px><font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font></td> <td valign=TOP rowspan="4" align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr> <tr><td height=2px><font size=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr> <tr><td height=2px><font size=1>Código CUPS: ${object.cups_id.name}</font></td></tr> <tr><td height=2px width=100%><font size=1>Titular:${object.cups_polissa_id.titular.name} </font></td></tr> </table>
% endif

%if object.cups_polissa_id.titular.lang == "ca_ES":

Hola, 

Hem sol·licitat la baixa amb tall de subministrament del contracte corresponent a l’adreça ${object.cups_polissa_id.cups_direccio} i ha estat acceptada.

<a href="http://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L'empresa de distribució elèctrica</a> té 5 dies hàbils per donar de baixa aquest punt de subministrament i que deixi d'haver-hi llum.

Recorda que la cooperativa emetrà una última factura fins que la baixa sigui efectiva.

De seguida que ens comuniquin la data, us n'informarem. 

Salutacions,

Equip de Som Energia
comercialitzacio@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.cups_polissa_id.titular.lang != "ca_ES" and object.cups_polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.cups_polissa_id.titular.lang == "es_ES":
Hola, 

Hemos solicitado la baja con corte de suministro del contrato correspondiente a la dirección ${object.cups_polissa_id.cups_direccio} y ha sido aceptada.

<a href="http://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa de distribución eléctrica</a> tiene 5 días hábiles para dar de baja este punto de suministro y que deje de haber luz.

Recuerda que la cooperativa emitirá una última factura hasta que la baja sea efectiva.

En cuanto nos comuniquen la fecha exacta, os informaremos. 

Saludos,

Equipo de Som Energia
comercialitzacio@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html> 