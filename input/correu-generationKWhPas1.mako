<!doctype html>
<html>
<head><meta charset="utf-8"/></head>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
<%
Soci = object.pool.get('somenergia.soci')
Partner = object.pool.get('res.partner')
PartnerBank = object.pool.get('res.partner.bank')

soci_id = object.member_id.id
soci_obj = Soci.read(object._cr, object._uid, soci_id)
part_obj = Partner.read(object._cr,object._uid,soci_obj['partner_id'][0])
bank_obj = PartnerBank.read(object._cr, object._uid, part_obj['bank_inversions'][0])

lang = part_obj['lang']
name = part_obj['name']
iban = bank_obj['iban']
amount_currency= int(object.nshares) * 100
%>
% if lang == "ca_ES":

Hola ${name.split(',')[-1]},

Et confirmem que hem rebut correctament la teva sol·licitud per fer una aportació als projectes de la Generació kWh, amb les següents dades:

Soci/Sòcia: ${name}
Compte de càrrec: ${iban[:-4]}****
Import aportació: ${int(abs(amount_currency))} €

En els propers dies rebràs el càrrec bancari en aquest compte, si us plau verifica que totes les dades facilitades són correctes i que disposes dels diners que hi vols invertir, per tal que no hi hagi cap incidència en el gir del rebut.

Un cop passem el rebut d’aquest import, t’enviarem un altre mail per confirmar la teva aportació i detallar-ne les condicions particulars.

Agraïm la teva participació en l’impuls de nous projectes i et recordem que per a qualsevol dubte o aclariment hi ha el centre d’ajuda de la web <a href="https://www.generationkwh.org/ca">www.generationkwh.org</a>, respondre directament a aquest correu o bé escriure a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>.

Pots fer córrer la veu i explicar el projecte a familiars i amistats. Si estàs connectat a les xarxes socials també pots compartir fàcilment un missatge des d'aquest enllaç a <a href="http://ctt.ec/7Yr1X">Twitter</a>, a <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=c876858ba3&e=680d1e3de2">Facebook</a>, <a href="https://www.linkedin.com/cws/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Linkedin</a> i, fins tot, a <a href="https://plus.google.com/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Google+</a>. Quants més siguem, més energia verda generarem!

Moltes gràcies i bona energia!

Som Energia, SCCL
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>

% endif
% if  lang != "ca_ES" and  lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  lang == "es_ES":
Apreciado/a ${name.split(',')[-1]},

Te confirmamos que hemos recibido correctament tu solicitud para realizar una aportación a los proyectos de la Generación kWh, con los siguientes datos:

Socio/a: ${name}
Cuenta de cargo: ${iban[:-4]}****
Importe aportación: ${int(abs(amount_currency))} €

En los próximos dias recibirás el cargo bancario en esta cuenta, porfavor
verifica que todos los datos facilitados són correctos y dispones del dinero que quiéres invertir, para evitar cualquier
incidencia en el giro del recibo.

Una vez verificada la validez del pago realizado recibirás una nueva notificación
confirmando la aportación realizada y detallando las condiciones particulares de
tu aportación.

Agradecer tu participación en este impuslo a nuevos proyectos y recordarte que para cualquier duda o aclaración puedes consultar
nuestra web <a href="https://www.generationkwh.es">www.generationkwh.es</a> o enviarnos un correo electrónico a
<a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>

Haz que corra la voz explicando el proyecto a familiares y amigos. Si estás conectado a las redes sociales también puedes compartir fácilmente un mensaje desde este enlace en <a href="http://ctt.ec/134fX">Twitter</a>, en <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=c876858ba3&e=680d1e3de2">Facebook</a>, en <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=45ac0c2d2d&e=6e8d00bf75">Linkedin</a> e incluso en <a href="http://generationkwh.us2.list-manage1.com/track/click?u=56d8bf2e8806722821a650fd1&id=870e457cc5&e=6e8d00bf75">Google+</a>. Cuantos más seamos, más energía verde generamos.
Muchas gracias y buena energía!

Atentamente,

Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
