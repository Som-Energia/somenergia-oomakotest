<!doctype html><html><body>
<%
import datetime
data_inici = datetime.datetime.strptime(object.data_inici, '%Y-%m-%d').strftime('%d-%m-%Y')
data_final = datetime.datetime.strptime(object.data_final, '%Y-%m-%d').strftime('%d-%m-%Y')

%>
% if object.partner_id.lang != "es_ES":
<p>
<div align="right"><img src="https://www.somenergia.coop/templates/somenergia/images/logo_web.jpg"></div>Benvolgut/da,

T'enviem la <B>factura</B> d'electricitat de Som Energia.  Si us plau, revisa que totes les dades siguin correctes. 

Si no ens dius res, <B>carregarem l'import d'aquesta factura al teu número de compte durant els propers dies</B>.
</p>

<U><B>Resum de la factura</B></U>
<ul><li>Número de factura: ${object.number}</li>
<li>Codi CUPS: ${object.cups_id.name}</li>
<li>Adreça punt subministrament: ${object.cups_id.direccio}</li>
<li>Titular: ${object.polissa_id.titular.name}</li>
<li>Període del ${data_inici} al ${data_final}</li>
<li><B> Import total: ${object.invoice_id.amount_total}</B>€</li>
</ul>



Pots consultar les dades del contracte i veure totes les teves factures a l’<a href="https://oficinavirtual.somenergia.coop">Oficina Virtual de Som Energia</a>

Pots escriure a aquests correus per a consultar dubtes relacionats amb:
- Dubtes de facturació: factura@somenergia.coop
- Dubtes generals del contracte d'electricitat: comercialitzacio@somenergia.coop
- Informació de Som Energia: info@somenergia.coop

Atentament,

Equip de Som Energia
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
<p>
<div align="right"><img src="https://www.somenergia.coop/templates/somenergia/images/logo_web.jpg"></div>Saludos,

Te enviamos la <B>factura</B> de electricidad de Som Energia. Por favor, revisa que todos los datos sean correctos. 

Si no nos comentas nada, <B>cargaremos el importe en tu cuenta bancaria durante los próximos días</B>. 
</p>

<U>Resumen de la factura</U>
<ul><li>Número factura: ${object.number}</li>
<li>Codigo CUPS: ${object.cups_id.name}</li>
<li>Dirección punto suministro: ${object.cups_id.direccio}</li>
<li>Titular: ${object.polissa_id.titular.name}</li>
<li>Periodo del  ${object.data_inici} al  ${object.data_final}</li>
<li><B>Importe total: ${object.invoice_id.amount_total}</B>€</li>
</ul>



Puedes consultar tu contrato y todas tus facturas en la <a href="https://oficinavirtual.somenergia.coop">Oficina Virtual de Som Energia</a>

Puedes escribir a estos correos para consultar dudas relacionadas con:
- Dudas de facturación: factura@somenergia.coop
- Dudas generales del contrato de electricidad: comercializacion@somenergia.coop
- Información de Som Energia: info@somenergia.coop

Atentamente,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
