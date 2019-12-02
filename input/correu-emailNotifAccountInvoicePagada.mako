<!doctype html><html><head><meta charset="utf-8"/><html>
<%
  pol_obj = object.pool.get('giscedata.polissa')
  polissa_id = pol_obj.search(object._cr, object._uid, [('name', '=', object.name)], context={'active_test': False})
  polissa = pol_obj.browse(object._cr, object._uid, polissa_id[0])
%>
% if object.lang_partner == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${polissa.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${polissa.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${polissa.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${polissa.titular.name}</font></td></tr></table></head><body>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${polissa.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${polissa.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${polissa.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${polissa.titular.name}</font></td></tr></table></head><body>
% endif
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, polissa.pagador.vat):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid, polissa.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>
Hola${nom_pagador},

% if object.lang_partner != "es_ES":
Avui hem rebut la teva transferència com a pagament de la factura <b>${object.number}</b>. Aquesta factura ha quedat regularitzada.

Per a qualsevol consulta seguim en contacte.

Salutacions,

Equip de Som Energia
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre de Suport</a>
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if object.lang_partner != "ca_ES" and object.lang_partner != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.lang_partner != "ca_ES":
Hoy hemos recibido tu transferencia como pago de la factura <b>${object.number}</b>. Esta factura ha quedado regularizada.

Para cualquier duda o consulta seguimos en contacto.

Un saludo,
Equipo de Som Energia
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a>
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
