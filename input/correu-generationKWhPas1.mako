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

Benvolgut/da ${name.split(',')[-1]},

Et confirmem que hem rebut correctament la teva sol·licitud per fer una aportació als projectes de la Generació kWh, amb les següents dades:

Soci/Sòcia: ${name}
Compte de càrrec: ${iban[:-4]}****
Import aportació: ${int(abs(amount_currency))} €

En els propers dies rebràs el càrrec bancari en aquest compte, siusplau verifica que totes les dades facilitades són correctes i que disposes dels diners que vols invertir, per tal que no hi hagi cap incidència en el gir del rebut.

Un cop verificada la validesa del pagament realitzat rebràs una nova notificació confirmant l'aportació realitzada i detallant les condicions particulars de la teva aportació.

Agrair la teva participació en l’impuls de nous projectes i recordar-te que per qualsevol dubte o aclariment pots consultar el web <a href="https://www.generationkwh.cat">www.generationkwh.cat</a> o bé mitjançant un mail a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>.

Pots fer córrer la veu explicant el projecte a familiars i amics/gues. Si estàs connectat a les xarxes socials també pots compartir fàcilment un missatge des d'aquest enllaç a <a href="http://ctt.ec/7Yr1X">Twitter</a>, a <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=c876858ba3&e=680d1e3de2">Facebook</a>, <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=45ac0c2d2d&e=6e8d00bf75">Linkedin</a> i fins i tot a <a href="http://generationkwh.us2.list-manage1.com/track/click?u=56d8bf2e8806722821a650fd1&id=870e457cc5&e=6e8d00bf75">Google+</a>. Com més siguem, més energia verda generarem!

Moltes gràcies i bona energia!

Atentament,

Som Energia, SCCL
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
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
