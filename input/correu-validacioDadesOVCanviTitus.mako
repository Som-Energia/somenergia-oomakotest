<!doctype html>
<html>
<head></head>
<body>
%if object.polissa_ref_id.titular.lang != "es_ES":
Benvolguts/des,<br>
<br>
Us informem que hem rebut correctament la sol·licitud d'un canvi de titular pel contracte número ${object.cups_polissa_id.name} amb el CUPS: ${object.cups_id.name} i del qual, fins ara, el titular és en/na ${object.cups_polissa_id.titular.name.split(',')[-1]} ${object.cups_polissa_id.titular.name.split(',')[0]}.<br>
<br>
Si es tracta d'un canvi de titularitat degut a la defunció de la persona titular actual o bé detecteu un error en el resum de dades següent, contesteu aquest correu.<br>
<b>Si tot és correcte no és necessari que contesteu</b> i la gestió es durà a terme en un màxim de cinc dies hàbils.<br>
És important tenir en compte que en les properes setmanes, la persona que ha estat titular fins ara, rebrà una última factura fins a la data d’activació del contracte amb la nova persona titular.<br>
<br>
Les dades del nou titular són:<br>
- Nom: ${object.polissa_ref_id.titular.name.split(',')[-1]} ${object.polissa_ref_id.titular.name.split(',')[0]}<br>
- NIF, NIE o CIF: ${object.polissa_ref_id.titular.vat[2:]}<br>
- Número de compte: ${object.polissa_ref_id.bank.iban[:-4]}****<br>
<br>
% if object.polissa_ref_id.soci:
El contracte estarà associat al soci/a ${object.polissa_ref_id.soci.name.split(',')[-1]} ${object.polissa_ref_id.soci.name.split(',')[0]}.<br>
% else:
El contracte estarà associat al soci/a: Encara sense persona sòcia vinculada.<br/>
% endif
<br>
Salutacions,<br>
<br>
Equip de Som Energia<br>
modifica@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if object.polissa_ref_id.titular.lang != "ca_ES" and object.polissa_ref_id.titular.lang != "es_ES":
<br>
----------------------------------------------------------------------------------------------------
<br>
% endif
% if object.polissa_ref_id.titular.lang != "ca_ES":
Estimados/as,<br/>
<br/>
Os informamos que hemos recibido correctamente la solicitud de cambio de titular del contrato número ${object.cups_polissa_id.name} con el CUPS: ${object.cups_id.name} y del cual, hasta ahora el titular es ${object.cups_polissa_id.titular.name.split(',')[-1]} ${object.cups_polissa_id.titular.name.split(',')[0]}.<br/>
<br/>
Si se trata de un cambio de titularidad debido a la defunción de la persona titular actual o bien detectáis un error en el resumen de datos siguiente, contestad este correo.<br/>
<b>Si todo es correcto no es necesario que lo hagáis</b> y la gestión se llevará a cabo en un plazo máximo de cinco días hábiles.<br/>
Es importante tener en cuenta que en las próximas semanas, la persona que ha sido titular hasta ahora, recibirá una última factura hasta la fecha de activación del contrato con la nueva persona titular.<br/>
<br/>
Los datos del nuevo titular son:<br/>
- Nombre: ${object.polissa_ref_id.titular.name.split(',')[-1]} ${object.polissa_ref_id.titular.name.split(',')[0]}<br/>
- NIF, NIE o CIF: ${object.polissa_ref_id.titular.vat[2:]}<br/>
- Número de cuenta: ${object.polissa_ref_id.bank.iban[:-4]}****<br/>
<br/>
% if object.polissa_ref_id.soci:
El contrato estará asociado al socio/a ${object.polissa_ref_id.soci.name.split(',')[-1]} ${object.polissa_ref_id.soci.name.split(',')[0]}.<br>
% else:
El contrato estará asociado al socio/a: Aún sin persona socia vinculada.<br/>
% endif
<br/>
Saludos,<br/>
<br/>
Equipo de Som Energia<br/>
modifica@somenergia.coop<br/>
<a href="www.somenergia.coop/es">www.somenergia.coop</a><br/>
% endif
</body>
</html>
