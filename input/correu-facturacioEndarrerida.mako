<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head><body>
% else:
<head><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head><body>
% endif
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''

from datetime import datetime
last_invoiced_date = datetime.strptime(object.data_ultima_lectura, '%Y-%m-%d')
last_invoiced_date_formatted = last_invoiced_date.strftime('%d/%m/%Y')
%>
Hola${nom_pagador},

% if object.titular.lang != "es_ES":
<B>La facturació ha estat aturada durant aquests darrers mesos i no emetíem cap factura des de ${last_invoiced_date_formatted}. 
Ara la posem al dia, fins a la darrera lectura que ens consta i t’enviem les factures.<B>

Si vols que fem algun fraccionament del cobrament, ens ho pots demanar contestant aquest mateix correu, sinó carregarem l'import corresponent al teu número de compte durant els propers dies. 

Perdona les molèsties.

Accedeix a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b> per veure les teves factures, introduir les lectures del comptador i gestionar els teus contractes amb la cooperativa.

<h2 align="center">Vols produir electricitat verda de forma col·lectiva? 
Participa en la <a href="http://www.generationkwh.org/ca/">Generació kWh</a> i suma't al canvi!</h2>

Salutacions,

Equip de Som Energia

<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a>
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":
<B>La facturación ha estado parada durante estos últimos meses y no emitíamos ninguna factura desde ${last_invoiced_date_formatted}. 
Ahora la ponemos al día, hasta la última lectura que nos consta y te enviamos las facturas.<B>

Si quieres que hagamos algún fraccionamiento del cobro, nos lo puedes pedir contestando este mismo correo, sino cargaremos el importe correspondiente a tu número de cuenta en los próximos días.

Perdona las molestias.

Accede a la <b><a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a></b> para ver tus facturas, introducir las lecturas del contador y gestionar tus contratos de la cooperativa.

<h2 align="center">¿Quieres producir electricidad verde de forma colectiva? 
Participa en la <a href="http://www.generationkwh.org">Generación kWh</a> ¡y súmate al cambio!</h2>

Saludos,

Equipo de Som Energia
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a>
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
