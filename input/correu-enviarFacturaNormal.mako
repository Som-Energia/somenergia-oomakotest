<%
import datetime
data_inici = datetime.datetime.strptime(object.data_inici, '%Y-%m-%d').strftime('%d-%m-%Y')
data_final = datetime.datetime.strptime(object.data_final, '%Y-%m-%d').strftime('%d-%m-%Y')
%><!doctype html><html>
<head><meta charset='utf8'></head>
<body>
% if object.partner_id.lang != "es_ES":
<p>
<div align="right"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>Benvolgut/da,

T'enviem la <B>factura</B> d'electricitat de Som Energia. 

Carregarem l'import d'aquesta factura al teu número de compte durant els propers dies.
</p>

<U><B>Resum de la factura</B></U>
<ul><li>Número de factura: ${object.number}</li>
<li>Codi CUPS: ${object.cups_id.name}</li>
<li>Adreça punt subministrament: ${object.cups_id.direccio}</li>
<li>Titular: ${object.polissa_id.titular.name}</li>
<li>Període del  ${data_inici} al  ${data_final}</li>
<li><B> Import total: ${object.invoice_id.amount_total}</B>€</li>
</ul>


Pots consultar les dades del contracte i veure totes les teves factures a l’<a href="https://oficinavirtual.somenergia.coop">Oficina Virtual</a>

Si tens algun dubte, trobaràs les preguntes més freqüents al <a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre de Suport</a>

<div align="center"><b><h2>Recorda que pots <a href="https://www.somenergia.coop/ca/participa/campanyes/">Il·luminar amb bona energia</a> convidant a contractar a familiars i amics.</h2></b></div>

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

Te enviamos la <B>factura</B> de electricidad de Som Energia. 

Cargaremos el importe en tu cuenta bancaria durante los próximos días. 
</p>

<U>Resumen de la factura</U>
<ul><li>Número factura: ${object.number}</li>
<li>Codigo CUPS: ${object.cups_id.name}</li>
<li>Dirección punto suministro: ${object.cups_id.direccio}</li>
<li>Titular: ${object.polissa_id.titular.name}</li>
<li>Periodo del  ${data_inici} al  ${data_final}</li>
<li><B>Importe total: ${object.invoice_id.amount_total}</B>€</li>
</ul>

Puedes consultar los datos del contrato y ver todas tus facturas en la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>

Si tienes alguna duda, encontrarás las preguntas más frecuentes en el <a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a>

<div align="center"><b><h2>Recuerda que puedes <a href="https://www.somenergia.coop/participa/campanas/">Iluminar con buena energía</a> invitando a contratar a familiares y amigos.</h2></b></div>

Atentamente,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
