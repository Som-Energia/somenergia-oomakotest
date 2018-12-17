<!doctype html>
<html>
<body>
<br>
% if object.pagador.lang  == "ca_ES":
Hola ${object.direccio_pagament.name.split(',')[-1]}, <br>
<br>
Ja ha arribat l'hivern! així que t’enviem el segon informe amb orientació estacional de l'any del servei <b>Infoenergia, per veure com t’afecten els hiverns i veure com pots millorar la teva ús elèctric.</b><br>
<br>
També fem una <b>previsió de tancament d'aquest any</b>, tenint en compte el teu comportament durant l'any i les dades històriques del teu contracte.<br>
<br>
A la segona part de l'informe analitzem com reparteixes l'ús elèctric al llarg del dia en una setmana "típica".<br>
<br>
També et recordem l'ús permanent d'energia (<i>stand-by</i>) de casa teva i t'oferim una eina de l'OCU per visibilitzar <b>on estan els teus "lladres energètics".</b><br>
<br>
Si et queda qualsevol dubte, pots consultar el nostre <a href="https://ca.support.somenergia.coop/article/672-servei-infoenergia">centre de suport</a> o bé respondre aquest mateix correu electrònic.<br>
<br>
Bona Energia!<br>
<br>
% endif
% if  object.pagador.lang  != "ca_ES":
Hola ${object.direccio_pagament.name.split(',')[-1]}, <br>
<br>
Ya ha llegado el invierno! Te enviamos el segundo informe con orientación estacional del año del servicio <b>Infoenergia, para ver cómo te afectan los inviernos y ver cómo puedes mejorar tu uso eléctrico.</b><br>
<br>
También hacemos una <b>previsión de cierre de este año</b>, teniendo en cuenta tu comportamiento durante el año y los datos históricos de tu contrato. <br>
<br>
En la segunda parte del informe analizamos cómo repartes el uso eléctrico a lo largo del día en una semana “típica”. <br>
<br>
También te recordamos el uso permanente de energía (<i>stand-by</i>) de tu casa y te ofrecemos una herramienta de la OCU para visibilizar <b>donde estan tus “ladrones energéticos”.</b><br>
<br>
Si te queda cualquier duda, puedes consultar nuestro <a href="https://es.support.somenergia.coop/article/673-el-servicio-infoenergia">centro de soporte</a> o bién responder este mismo correo electrónico.<br>
<br>
¡Buena Energía!<br>
<br>
% endif
</body>
</html>
