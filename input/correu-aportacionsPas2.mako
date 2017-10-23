<!doctype html>
<html>
<head><meta charset="utf-8"/></head><br/>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
% if object.partner_id.lang != "es_ES":

Benvolgut/da ${object.partner_id.name.split(',')[-1]},

Volem informar-te que a data d'avui hem girat el rebut corresponent a la teva aportació voluntària al capital social de la cooperativa Som Energia SCCL i per tant, en dos o tres dies (laborables) es realitzarà el càrrec al teu compte. 

T'adjuntem les condicions de la teva inversió i et recordem que per a qualsevol dubte o aclariment en relació a l’aportació realitzada pots enviar una mail a <a href="mailto:invertir@somenergia.coop">invertir@somenergia.coop</a> o consultar el web <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a>. 

Aprofitem per agrair-te, una vegada més, la teva implicació amb l’objectiu compartit d’assolir un model energètic 100% renovable!
Recorda que també pots participar de la Generació kWh per generar la teva energia a partir de nous projectes col·lectius de generació. Consulta el web <a href="https://www.generationkwh.org/ca">www.generationkwh.org</a>.

Pots fer córrer la veu explicant el projecte a familiars i amics/gues. Com més siguem, més energia verda generarem!

Moltes gràcies i bona energia!

Atentament,

Som Energia, SCCL
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.partner_id.lang != "ca_ES":

Apreciado/a ${object.partner_id.name.split(',')[-1]},

Queremos informarte que a fecha de hoy hemos girado el recibo correspondiente a tu aportación voluntaria al capital social de la cooperativa Som EnergiaSCCL y en dos o tres días (laborables) se realizará el cargo a tu cuenta.

Adjuntamos el contrato con las condiciones de tu inversión y te recordamos que para cualquier duda o aclaración en relación a la aportación realizada puedes enviar una mail a <a href="mailto:invertir@somenergia.coop">invertir@somenergia.coop</a> o consultar la web <a href="https://www.somenergia.coop">www.somenergia.coop</a>. 

Aprovechamos para agradecerte, una vez más, tu implicación con el objetivo compartido de lograr un modelo energético 100% renovable.
Recuerda que también puedes participar de la Generación kWh para generar tu energía con nuevos proyectos colectivos de generación. Consulta la web <a href="https://www.generationkwh.org/es">www.generationkwh.org</a>.

Haz que corra la voz explicando el proyecto a familiares y amigos. Cuantos/as más seamos, más energía verde generaremos.

¡Muchas gracias y buena energía!

Atentamente,

Som Energia, SCCL
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>
