<!doctype html><html>
<head>
            <meta charset='utf8'>
</head>
<body>
<div>
<div style="float: left"><img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
% if object.partner_id.lang != "es_ES":

Benvolgut/da ${object.polissa_id.titular.name},

Avui s'ha fet efectiva la teva transferència com a pagament de la factura ${object.number} . Aquesta factura ha quedat regularitzada.

Per a qualsevol consulta seguim en contacte.

Salutacions,

Equip de Som Energia
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre de Suport</a>
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":

Estimado/da ${object.polissa_id.titular.name},

Hoy se ha hecho efectiva tu transferencia como pago de la factura ${object.number}. Esta factura ha quedado regularizada.

Para cualquier duda o consulta seguimos en contacto.

Un saludo,

Equipo de Som Energia
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a>
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</div>
</html>