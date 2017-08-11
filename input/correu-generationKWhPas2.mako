<!doctype html>
<html>
<head></head>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
% if object.partner_id.lang != "es_ES":

Hola ${object.partner_id.name.split(',')[-1]},

Volem informar-te que a data d'avui hem girat l’import ${int(abs(object.amount_total))} € corresponent a la teva participació a la Generació kWh i, per tant, en dos o tres dies (laborables) es passarà el càrrec al teu compte bancari.

T'adjuntem el contracte amb les condicions generals de la teva inversió i et recordem que per a qualsevol dubte o aclariment pots consultar el web <a href="https://www.generationkwh.org/ca">www.generationkwh.org</a>, respondre directament a aquest correu o bé escriure a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>.

Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable! 

Recorda que pots fer córrer la veu i explicar el projecte a familiars i amistats. Si estàs connectat a les xarxes socials també pots compartir fàcilment un missatge des d'aquest enllaç a <a href="http://ctt.ec/7Yr1X">Twitter</a>, a <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=c876858ba3&e=680d1e3de2">Facebook</a>, <a href="https://www.linkedin.com/cws/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Linkedin</a> i, fins tot, a <a href="https://plus.google.com/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Google+</a>. Quants més siguem, més energia verda generarem!

Moltes gràcies i bona energia!

Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.partner_id.lang != "ca_ES":
Apreciado/a ${object.partner_id.name.split(',')[-1]},

Queremos informarte que a fecha de hoy hemos girado el recibo correspondiente a tu aportación a la Generación kWh y, en dos o tres días (laborables), se realizará el cargo a tu cuenta.

Adjuntamos el contrato con las condiciones generales de tu inversión y te recordamos que para cualquier duda o aclaración en relación a la aportación realizada puedes enviar una mail a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a> o consultar la web <a href="https://www.generationkwh.org/es">www.generationkwh.org</a>. 

Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de lograr un modelo energético 100% renovable.
 
Haz que corra la voz explicando el proyecto a familiares y amigos. Si estás conectado a las redes sociales también puedes compartir fácilmente un mensaje desde este enlace en <a href="http://ctt.ec/134fX">Twitter</a>, en <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=c876858ba3&e=680d1e3de2">Facebook</a>, en <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=45ac0c2d2d&e=6e8d00bf75">Linkedin</a> e incluso en <a href="http://generationkwh.us2.list-manage1.com/track/click?u=56d8bf2e8806722821a650fd1&id=870e457cc5&e=6e8d00bf75">Google+</a>.  Cuantos/as más seamos, más energía verde generaremos.

Muchas gracias y buena energía!

Atentamente,

Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>
