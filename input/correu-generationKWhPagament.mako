<!doctype html>
<html>
<head></head>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
% if object.partner_id.lang != "es_ES":

Hola ${object.partner_id.name.split(',')[-1]},

Volem informar-te que a data d'avui hem girat l’import ${int(abs(object.amount_total))} € corresponent a la teva participació a la Generació kWh i, per tant, en dos o tres dies (laborables) es passarà el càrrec al teu compte bancari.

T'adjuntem el contracte amb les condicions generals de la teva inversió i et recordem que per a qualsevol dubte o aclariment en relació amb la teva aportació pots respondre aquest correu, escriure a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a> o consultar el <a href="http://ca.support.somenergia.coop/category/580-generation-kwh">centre d’ajuda</a> de la web.

Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable! 

Recorda que pots fer córrer la veu i explicar el projecte a familiars i amistats. Si estàs connectat a les xarxes socials també pots compartir fàcilment un missatge des d'aquest enllaç a <a href="http://ctt.ec/7Yr1X">Twitter</a>, a <a href="https://www.facebook.com/sharer/sharer.php?u=http://www.generationkwh.cat">Facebook</a>, <a href="https://www.linkedin.com/cws/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Linkedin</a> i, fins tot, a <a href="https://plus.google.com/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Google+</a>. Quants més siguem, més energia verda generarem!


Moltes gràcies i bona energia!


Som Energia, SCCL
<a href="http://www.somenergia.coop/ca/">www.somenergia.coop</a>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.partner_id.lang != "ca_ES":

Hola ${object.partner_id.name.split(',')[-1]},

Queremos informarte que a fecha de hoy hemos girado el importe de ${int(abs(object.amount_total))} € correspondiente a tu participación en la Generación kWh y, por tanto, en dos o tres días (laborables) se pasará el cargo a tu cuenta bancaria.

Te adjuntamos el contrato con las condiciones generales de tu inversión y te recordamos que para cualquier duda o aclaración en relación a tu aportación puedes responder a este correo, escribir a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a> o consultar el <a href = "http://es.support.somenergia.coop/category/595-generation-kwh">centro de ayuda</a> de la web.

Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de alcanzar un modelo energético 100% renovable.

Recuerda que puedes hacer correr la voz y explicar el proyecto a familiares y amistades. Si estás conectado a las redes sociales también puedes compartir fácilmente un mensaje desde este enlace en <a href="http://ctt.ec/134fX">Twitter</a>, en <a href="https://www.facebook.com/sharer/sharer.php?u=http://www.generationkwh.es">Facebook</a>, en <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=45ac0c2d2d&e=6e8d00bf75">Linkedin</a> e incluso en <a href="http://generationkwh.us2.list-manage1.com/track/click?u=56d8bf2e8806722821a650fd1&id=870e457cc5&e=6e8d00bf75">Google+</a>. Cuantas más seamos, ¡más energía verde generaremos!


¡Muchas gracias y buena energía!


Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>
