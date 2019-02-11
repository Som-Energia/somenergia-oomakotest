<!doctype html>
<html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% endif
<body>
<%
from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_id = md_obj.get_object_reference(
                    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                )[1]
text_legal = render(t_obj.read(
    object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.polissa_id.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.polissa_id.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>
Hola${nom_pagador},<br/>
<br/>
% if object.invoice_id.partner_id.lang != "es_ES":
Malgrat l'enviament de diferents correus de reclamació, encara no hem rebut cap resposta, per la qual cosa et requerim, un cop més, el pagament d'aquesta factura.<br/>
<br/>
En cas que no puguis abonar el total d’aquest import en aquests moments, t'oferim la possibilitat de negociar uns terminis de pagament que satisfacin les dues parts i que solucionin aquesta situació d'impagament.<br/>
<br/>
Si no rebem cap comunicació per part teva, entendrem que no hi ha voluntat de pagar i, per tant, ens veurem obligats a iniciar les accions legals oportunes en defensa dels interessos de la cooperativa.<br/>
<br/>
Per tal de saldar aquest deute, has de transferir l'import de la factura al següent número de compte. Recorda d’indicar, si us plau, el número de factura o el número de contracte en el concepte.<br/>
<br/>
<B>ES82 1491 0001 29 2027098223</B><br/>
<br/>
<U>Resum de la teva factura</U><br/>
- Adreça punt subministrament: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Codi CUPS: ${object.cups_id.name}<br/>
- Número de factura: <B>${object.number}</B><br/>
- Data factura: ${object.invoice_id.date_invoice}<br/>
- Període del  ${object.data_inici} al  ${object.data_final}<br/>
- <B>Import total: ${object.invoice_id.amount_total}</B>€ <br/>
<br/>
Si ets una persona electrodependent o bé en el teu punt de subministrament viu alguna persona que ho sigui, envia’ns el certificat mèdic oficial que ho acrediti a cobraments@somenergia.coop<br/>
<br/>
Salutacions,<br/>
<br/>
Equip de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br/>
<br/>
<font size="2">Avís a les persones en situació de <b>RISC D'EXCLUSIÓ RESIDENCIAL</b>:<br/>
Les persones que presenten una mancança de recursos econòmics poden obtenir ajudes de les administracions públiques (locals i autonòmiques) que els hi permeti seguir tenint accés als subministraments bàsics: aigua potable, gas i electricitat.<br/>
Si et trobes en aquesta situació, et recomanem que contactis amb els serveis socials del teu municipi; ells et diran si pots acollir-te a aquestes ajudes i quins són els passos que has de seguir per poder beneficar-te'n.<br/>
Abans de donar avís per tallar el subministrament elèctric sol·licitarem a Serveis Socials de l'ajuntament on vius que ens informin si n'ets usuari/a o et trobes en una de les situacions de risc d'exclusió residencial.<br/>
<br/>
Informació al consumidor:<br/>
La persona titular del contracte pot acollir-se al mercat regulat (PVPC) on, en el cas de complir amb els requisits i les condicions previstes en la normativa vigent, podrà sol·licitar el bo social que s'aplicarà a les factures de subministrament d'electricitat. El bo social únicament pot ser ofert per les comercialitzadores de referència.</font><br/>
<br/>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
A pesar del envío de varios correos de reclamación, todavía no hemos recibido respuesta alguna, por lo que te requerimos, una vez más, el pago de esta factura.<br/>
<br/>
En el caso de que no puedas abonar el total del importe en estos momentos, te ofrecemos la posibilidad de negociar unos plazos de pago que satisfagan a las dos partes y que solucionen esta situación de impago.<br/>
<br/>
En el supuesto de que no recibamos ninguna comunicación por tu parte, entenderemos que no hay voluntad de pago y, por consiguiente, nos veremos obligados a iniciar las acciones legales oportunas en defensa de los intereses de la cooperativa.<br/>
<br/>
Para saldar esta deuda, debes transferir el importe de la factura al siguiente número de cuenta. Recuerda indicar, por favor, el número de factura o el número de contrato en el concepto.<br/>
<br/>
<B>ES82 1491 0001 29 2027098223</B><br/>
<br/>
<U>Resumen de la factura</U><br/>
- Dirección punto suministro: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Codigo CUPS: ${object.cups_id.name}<br/>
- Número factura: <B>${object.number}</B><br/>
- Fecha factura: ${object.invoice_id.date_invoice}<br/>
- Periodo del  ${object.data_inici} al  ${object.data_final}<br/>
- <B>Importe total: ${object.invoice_id.amount_total}€</B><br/>
<br/>
Si eres una persona electrodependiente o bien en tu punto de suministro vive una persona que lo sea, envíanos el certificado médico oficial que lo acredite a cobros@somenergia.coop<br/>
<br/>
Atentamente,<br/>
<br/>
Un saludo,<br/>
<br/>
Equipo de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br/>
<br/>
<font size="2">Aviso a las personas en situación de <B>RIESGO DE EXCLUSIÓN RESIDENCIAL</B>:<br/>
Las personas que presentan una falta de recursos económicos pueden obtener ayudas de las administraciones públicas (locales o autonómicas) que les permitan seguir teniendo acceso a los suministros básicos: agua potable, gas y electricidad.<br/>
Si te encuentras en esta situación, te recomendamos que contactes con los servicios sociales de tu municipio; ellos te informarán de estas ayudas y qué pasos debes seguir para poder beneficiarte.<br/>
Antes de dar aviso para que corten el suministro eléctrico solicitaremos a Servicios Sociales del ayuntamiento donde vives que nos informen si eres usuario/a de estos servicios o si te encuentras en alguna de las situaciones de riesgo de exclusión residencial.<br/>
<br/>
Información al consumidor:<br/>
La persona titular del contrato puede acogerse al mercado regulado (PVPC) donde, en el caso de cumplir con los requisitos y las condiciones previstas en la normativa vigente, podrá solicitar el bono social que se aplicará en las facturas de suministro de electricidad. El bono social únicamente puede ser ofertado por las comercializadoras de referencia.</font><br/>
<br/>
% endif
<br/>
${text_legal}
</body>
</html>
