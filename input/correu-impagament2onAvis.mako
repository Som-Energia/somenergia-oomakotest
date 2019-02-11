<!doctype html>
<html>
% if object.invoice_id.partner_id.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" bgcolor="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
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
Et tornem a recordar l'impagament d'aquesta factura. No hem rebut la transferència per cancel·lar el deute ni tampoc cap sol·licitud per tornar a domiciliar el cobrament. Per aquest motiu, et demanem que regularitzis la situació al més aviat possible.<br/>
<br/>
Com saps, Som Energia té uns recursos limitats i els impagaments poden posar en risc la continuïtat de la nostra cooperativa.<br/>
<br/>
El número de compte de Som Energia perquè facis la transferència és el següent:<br/>
<br/>
<B>ES82 1491 0001 29 2027098223</B><br/>
<br/>
T’agrairem que posis el número de la factura o el número de contracte en el concepte.<br/>
<br/>
Si ho prefereixes, podem tornar a girar el rebut pel banc. En aquest cas, et demanem que contestis aquest correu i ens ho indiquis.<br/>
<br/>
<U>Resum de la teva factura</U><br/>
- Adreça punt subministrament: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Codi CUPS: ${object.cups_id.name}<br/>
- Número de factura: <B>${object.number}</B><br/>
- Data factura: ${object.invoice_id.date_invoice}<br/>
- Període del  ${object.data_inici} al  ${object.data_final}<br/>
- <B>Import total: ${object.invoice_id.amount_total}€</B> <br/>
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
Te volvemos a recordar el impago de esta factura. No hemos recibido la transferencia cancelando la deuda ni tampoco nos has solicitado volver a domiciliar el cobro. Por este motivo rogamos regularices la situación con la mayor brevedad posible.<br/>
<br/>
Como sabes, Som Energia tiene unos recursos limitados y los impagos pueden poner en riesgo la continuidad de nuestra cooperativa.<br/>
<br/>
El número de cuenta de Som Energia para que realices la transferencia es el siguiente:<br/>
<br/>
<B>ES82 1491 0001 29 2027098223</B><br/>
<br/>
Te agradeceremos que indiques el número de la factura o el número de contrato en el concepto.<br/>
<br/>
Si lo prefieres, podemos volver a pasar el recibo por el banco. En este caso, te pedimos que respondas a este correo y así nos lo indiques.<br/>
<br/>
<U>Resumen de la factura</U><br/>
- Dirección punto suministro: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Código CUPS: ${object.cups_id.name}<br/>
- Número factura: <B>${object.number}</B><br/>
- Fecha factura: ${object.invoice_id.date_invoice}<br/>
- Periodo del  ${object.data_inici} al  ${object.data_final}<br/>
- <B>Importe total: ${object.invoice_id.amount_total}</B>€<br/>
<br/>
Si eres una persona electrodependiente o bien en tu punto de suministro vive una persona que lo sea, envíanos el certificado médico oficial que lo acredite a cobros@somenergia.coop<br/>
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
