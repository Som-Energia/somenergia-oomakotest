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
<br/>
<br/>
Hola${nom_pagador},<br/>
<br/>
% if object.invoice_id.partner_id.lang != "es_ES":
Vam enviar el rebut de la factura d'electricitat a la teva entitat bancària però ens l’ha retornat.<br/>
<br/>
T’oferim dues opcions per abonar aquesta factura:<br/>
<br/>
Realitzar el pagament mitjançant el document adjunt amb codi de barres. Pots realitzar-lo des del següent <a href="https://www4.caixabank.es/apl/pagos/codigoBarras_ca.html">enllaç</a> o bé en els caixers de l’entitat <a href="https://www3.caixabank.es/apl/localizador/caixamaps/index_ca.html">CaixaBank</a>. Si tens qualsevol dubte consulta l’enllaç: <a href="https://ca.support.somenergia.coop/article/773-pagament-mitjancant-codi-de-barres-n57">Com fer el pagament mitjançant codi de barres?</a><br/>
<br/>
O si ho prefereixes, podem tornar a passar pel banc aquesta factura sempre que t’asseguris que hi ha saldo suficient i que no hi hagi cap problema amb la domiciliació.<br/>
<br/>
T’informem que si et trobes en una situació de vulnerabilitat econòmica, i en compliment de la legislació vigent (Reial decret 897/2017, de 6 d’octubre, pel qual es regula la figura del consumidor vulnerable, el bo social i altres mesures de protecció per als consumidors domèstics d’energia elèctrica), el teu contracte hauria de passar a la comercialitzadora de referència per poder-te acollir al bo social. Som Energia no el pot aplicar per llei, malgrat que el financi.<br/>
<br/>
Per canviar de comercialitzadora pots fer el tràmit tu mateix contractant amb ella. Tanmateix, si vols que ho gestioni directament Som Energia, contesta’ns aquest correu i t’enviarem un document de conformitat que ens hauràs de retornar signat.<br/>
<br/>
<U>Resum de la teva factura</U><br/>
- Adreça punt subministrament: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Codi CUPS: ${object.cups_id.name}<br/>
- Número de factura: <B>${object.number}</B><br/>
- Data factura: ${object.invoice_id.date_invoice}<br/>
- Període del  ${object.data_inici} al  ${object.data_final}<br/>
-<B> Import total: ${object.invoice_id.amount_total}€</B> <br/>
<br/>
Si ets una persona electrodependent o bé en el teu punt de subministrament viu alguna persona que ho sigui, envia’ns el certificat mèdic oficial que ho acrediti a cobraments@somenergia.coop<br/>
<br/>
Salutacions,<br/>
<br/>
Equip de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
<br/>
<font size="1" style="color:grey">
Si compliu els requisits per ser consumidor vulnerable, podeu sol·licitar a una de les empreses comercialitzadores de referència acollir-se al bo social, que suposa un descompte sobre el preu voluntari per al petit consumidor (PVPC). El canvi de modalitat en el contracte per passar a PVPC, sempre que no es modifiquin els paràmetres que recull el contracte d’accés de tercers a la xarxa, s’ha de portar a terme sense cap tipus de penalització ni cost addicional. Una vegada acollit al PVPC, i sempre que s’hagin acreditat els requisits per ser consumidor vulnerable, el termini perquè se us pugui suspendre el subministrament d’electricitat, en cas que no s’hagi abonat la quantitat deguda, passa a ser de 4 mesos (comptats sempre des de la recepció del requeriment fefaent de pagament).<br/>
<br/>
L’enllaç a la pàgina web de la CNMC, en la qual trobareu les dades necessàries per contactar amb la comercialitzadora de referència, és el següent: <a href="https://www.cnmc.es/ambitos-de-actuacion/energia/mercado-electrico#listados">https://www.cnmc.es/ambitos-de-actuacion/energia/mercado-electrico#listados</a><br/>
<br/>
Addicionalment,, si compliu els requisits per ser vulnerable sever, us podeu posar en contacte amb els serveis socials del municipi i la comunitat autònoma en què residiu perquè us informin sobre la possibilitat d’atendre el pagament del vostre subministrament d’electricitat. Els requisits per ser consumidor vulnerable es recullen a l’article 3 del Reial decret 897/2017, de 6 d’octubre, pel qual es regula la figura del consumidor vulnerable, el bo social i altres mesures de protecció per als consumidors domèstics d’energia elèctrica, del qual us remetem un extracte.<br/>
<br/>
Article 3. Definició de consumidor vulnerable.<br/>
<br/>
Als efectes d’aquest Reial decret i altres normatives aplicables, té la consideració de consumidor vulnerable el titular d’un punt de subministrament d’electricitat a la residència habitual que, sent persona física, estigui acollit al preu voluntari per al petit consumidor (PVPC) i compleixi la resta de requisits d’aquest article.<br/>
Perquè un consumidor d’energia elèctrica es pugui considerar consumidor vulnerable, ha de complir algun dels requisits següents:<br/>
Que la seva renda o, en cas de formar part d’una unitat familiar, la renda conjunta anual de la unitat familiar a la qual pertanyi sigui igual o inferior:<br/>
a 1,5 vegades l’indicador públic de renda d’efectes múltiples (IPREM) de 14 pagues, en cas que no formi part d’una unitat familiar o no hi hagi cap menor en la unitat familiar;<br/>
a 2 vegades l’índex IPREM de 14 pagues, en cas que hi hagi un menor en la unitat familiar;<br/>
a 2,5 vegades l’índex IPREM de 14 pagues, en cas que hi hagi dos menors en la unitat familiar.<br/>
A aquests efectes, es considera unitat familiar la constituïda d’acord amb el que disposa la Llei 35/2006, de 28 de novembre, de l’impost sobre la renda de les persones físiques i de modificació parcial de les lleis dels impostos sobre societats, sobre la renda de no residents i sobre el patrimoni.<br/>
<br/>
Tenir el títol de família nombrosa.<br/>
Que el mateix consumidor i, en cas de formar part d’una unitat familiar, tots els membres d’aquesta que tinguin ingressos, siguin pensionistes del Sistema de la Seguretat Social per jubilació o incapacitat permanent, percebent la quantia mínima vigent en cada moment per a les classes de pensió esmentades, i no percebin altres ingressos.<br/>
<br/>
Els multiplicadors de renda respecte de l’índex IPREM de 14 pagues que estableix l’apartat 2.a) s’han d’incrementar, en cada cas, en 0,5, sempre que concorri alguna de les circumstàncies especials següents:<br/>
Que el consumidor o algun dels membres de la unitat familiar tingui discapacitat reconeguda igual o superior al 33%.<br/>
Que el consumidor o algun dels membres de la unitat familiar acrediti la situació de violència de gènere, de conformitat amb el que estableix la legislació vigent.<br/>
Que el consumidor o algun dels membres de la unitat familiar tingui la condició de víctima de terrorisme, de conformitat amb el que estableix la legislació vigent.<br/>
Quan, complint els requisits anteriors, el consumidor i, si s’escau, la unitat familiar a la qual pertanyi, tinguin una renda anual inferior o igual al 50% dels llindars que estableix l’apartat 2.a), incrementats si s’escau d’acord amb el que disposa l’apartat 3, el consumidor s’ha de considerar vulnerable sever. Així mateix, també s’ha de considerar vulnerable sever quan el consumidor i, si s’escau, la unitat familiar a la qual pertanyi, tinguin una renda anual inferior o igual a una vegada l’IPREM a 14 pagues o dues vegades aquest, en cas que estigui en la situació de l’apartat 2.c) o 2.b), respectivament.<br/>
En tot cas, perquè un consumidor sigui considerat vulnerable ha d’acreditar el compliment dels requisits que recull aquest article en els termes que s’estableixin per ordre del ministre d’Energia, Turisme i Agenda Digital.<br/>
<br/>
En cas que un consumidor que compleixi els requisits per percebre el bo social i vulgui sol·licitar-ne l’aplicació no figuri com a titular del punt de subministrament d’electricitat en vigor, la sol·licitud de modificació de titularitat del contracte de subministrament d’electricitat es pot fer de manera simultània a la sol·licitud del bo social. En aquest cas, no s’aplica el que disposa l’article 83.5 del Reial decret 1955/2000, d’1 de desembre, pel qual es regulen les activitats de transport, distribució, comercialització, subministrament d’electricitat i procediments d’autorització d’instal·lacions d’energia elèctrica, sobre la revisió de les instal·lacions de més de vint anys.<br/>
<br/>
<a href="https://ca.support.somenergia.coop/article/171-que-es-el-bo-social">El Bo Social. Article a Som Energia</a><br/>
<a href="https://blog.somenergia.coop/grupos-locales/aragon/2018/03/el-nuevo-bono-social/">El nuevo Bono Social</a><br/>
<a href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad">Acceso a las tablas de pensiones mínimas</a><br/>
<a href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad">¿Qué es el PVPC?</a><br/>
<a href="http://www.minetad.gob.es/energia/bono-social/Paginas/preguntas-frecuentes-bono-social.aspx#contenido">Preguntas frecuentes sobre el bono social en la Web del Ministerio de Energía.</a><br/>
<br/>
</font>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
Hace unos días enviamos el recibo de tu factura de electricidad a tu entidad bancaria pero nos ha venido devuelto.<br/>
<br/>
Te agradeceremos que respondas a este correo y nos indiques cómo y cuándo se pagará esta factura. Para ello, tienes dos opciones:<br/>
<br/>
Realizar el pago mediante el documento adjunto con código de barras. Puedes realizarlo desde el siguiente <a href="https://www4.caixabank.es/apl/pagos/codigoBarras_es.html">enlace</a> o bien en los cajeros de la entidad <a href="https://www1.caixabank.es/apl/localizador/caixamaps/index_es.html">CaixaBank</a>. Si tienes cualquier duda consulta el enlace: <a href="https://es.support.somenergia.coop/article/774-pago-mediante-codigo-de-barras-n57">Cómo hacer el pago mediante código de barras?</a><br/>
<br/>
O si lo prefieres, podemos volver a pasar por el banco esta factura siempre que te asegures que hay saldo suficiente y que no haya ningún problema con la domiciliación.<br/>
<br/>
Te informamos que si te encuentras en una situación de vulnerabilidad económica, y en cumplimiento de la legislación vigente (Real Decreto 897/2017, de 6 de ocutbre, por el cual se regula la figura del consumidor vulnerable, el bono social y otras medidas de protección para los consumidores domésticos de energía eléctrica), tu contrato tendría que pasar a la comercializadora de referencia para poderte acoger al bono social. Som Energia no lo puede aplicar por ley, a pesar de que lo financia.<br/>
<br/>
Para cambiar de comercializadora puedes hacer el trámite tu mismo contactando con ella. Sin embargo, si quieres que lo gestione directamente Som Energia, contéstanos este correo y te enviaremos un documento que tendrás que devolver firmado.<br/>
<br/>
<U>Resumen de la factura</U><br/>
- Dirección punto suministro: ${object.cups_id.direccio}<br/>
- Titular: ${object.polissa_id.titular.name}<br/>
- Código CUPS: ${object.cups_id.name}<br/>
- Número factura: <B>${object.number}</B><br/>
- Fecha factura: ${object.invoice_id.date_invoice}<br/>
- Periodo del  ${object.data_inici} al  ${object.data_final}<br/>
- <B>Importe total: ${object.invoice_id.amount_total}€</B><br/>
<br/>
Si eres una persona electrodependiente o bien en tu punto de suministro vive una persona que lo sea, envíanos el certificado médico oficial que lo acredite a cobros@somenergia.coop<br/>
<br/>
Un saludo,<br/>
<br/>
Equipo de Som Energia<br/>
factura@somenergia.coop<br/>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br/>
<br/>
<font size="1" style="color:grey">
Si usted cumple los requisitos para ser consumidor vulnerable, puede solicitar a una de las empresas comercializadoras de referencia acogerse al bono social, que supone un descuento sobre el precio voluntario para el pequeño consumidor (PVPC). El cambio de modalidad en el contrato para pasar a PVPC, siempre que no se modifiquen los parámetros recogidos en el contrato de acceso de terceros a la red, se llevará a cabo sin ningún tipo de penalización ni coste adicional. Una vez acogido al PVPC, y siempre que se hayan acreditado los requisitos para ser consumidor vulnerable, el plazo para que su suministro de electricidad pueda ser suspendido, de no haber sido abonada la cantidad adeudada, pasará a ser 4 meses (contados siempre desde la recepción del requerimiento fehaciente de pago).<br/> 
<br/>
El enlace a la página web de la CNMC donde encontrará los datos necesarios para contactar con la comercializadora de referencia es el siguiente: <a href="https://www.cnmc.es/ambitos-de-actuacion/energia/mercado-electrico#listados">https://www.cnmc.es/ambitos-de-actuacion/energia/mercado-electrico#listados</a><br/>
<br/>
Adicionalmente, si usted cumple los requisitos para ser vulnerable severo, puede ponerse en contacto con los servicios sociales del municipio y comunidad autónoma donde reside, para que le informen sobre la posibilidad de atender el pago de su suministro de electricidad. Los requisitos para ser consumidor vulnerable vienen recogidos en el artículo 3 del Real Decreto 897/2017, de 6 de octubre, por el que se regula la figura del consumidor vulnerable, el bono social y otras medidas de protección para los consumidores domésticos de energía eléctrica, del que le remitimos un extracto.<br/> 
<br/>
Artículo 3. Definición de consumidor vulnerable.<br/>
A los efectos de este real decreto y demás normativa de aplicación, tendrá la consideración de consumidor vulnerable el titular de un punto de suministro de electricidad en su vivienda habitual que, siendo persona física, esté acogido al precio voluntario para el pequeño consumidor (PVPC) y cumpla los restantes requisitos del presente artículo.<br/>
Para que un consumidor de energía eléctrica pueda ser considerado consumidor vulnerable, deberá cumplir alguno de los requisitos siguientes:<br/>
Que su renta o, caso de formar parte de una unidad familiar, la renta conjunta anual de la unidad familiar a que pertenezca sea igual o inferior:<br/>
a 1,5 veces el Indicador Público de Renta de Efectos Múltiples (IPREM) de 14 pagas, en el caso de que no forme parte de una unidad familiar o no haya ningún menor en la unidad familiar;<br/>
a 2 veces el índice IPREM de 14 pagas, en el caso de que haya un menor en la unidad familiar;<br/>
a 2,5 veces el índice IPREM de 14 pagas, en el caso de que haya dos menores en la unidad familiar.<br/>
A estos efectos, se considera unidad familiar a la constituida conforme a lo dispuesto en la Ley 35/2006, de 28 de noviembre, del Impuesto sobre la Renta de las Personas Físicas y de modificación parcial de las leyes de los Impuestos sobre Sociedades, sobre la Renta de no Residentes y sobre el Patrimonio.<br/>
<br/>
Estar en posesión del título de familia numerosa.<br/>
Que el propio consumidor y, en el caso de formar parte de una unidad familiar, todos los miembros de la misma que tengan ingresos, sean pensionistas del Sistema de la Seguridad Social por jubilación o incapacidad permanente, percibiendo la cuantía mínima vigente en cada momento para dichas clases de pensión, y no perciban otros ingresos.<br/>
<br/>
Los multiplicadores de renta respecto del índice IPREM de 14 pagas establecidos en el apartado 2.a) se incrementarán, en cada caso, en 0,5, siempre que concurra alguna de las siguientes circunstancias especiales:<br/>
Que el consumidor o alguno de los miembros de la unidad familiar tenga discapacidad reconocida igual o superior al 33%.<br/>
Que el consumidor o alguno de los miembros de la unidad familiar acredite la situación de violencia de género, conforme a lo establecido en la legislación vigente.<br/>
Que el consumidor o alguno de los miembros de la unidad familiar tenga la condición de víctima de terrorismo, conforme a lo establecido en la legislación vigente.<br/>
Cuando, cumpliendo los requisitos anteriores, el consumidor y, en su caso, la unidad familiar a la que pertenezca, tengan una renta anual inferior o igual al 50% de los umbrales establecidos en el apartado 2.a), incrementados en su caso conforme a lo dispuesto en el apartado 3, el consumidor será considerado vulnerable severo. Asimismo también será considerado vulnerable severo cuando el consumidor, y, en su caso, la unidad familiar a que pertenezca, tengan una renta anual inferior o igual a una vez el IPREM a 14 pagas o dos veces el mismo, en el caso de que se encuentre en la situación del apartado 2.c) o 2.b), respectivamente.<br/>
En todo caso, para que un consumidor sea considerado vulnerable deberá acreditar el cumplimiento de los requisitos recogidos en el presente artículo en los términos que se establezcan por orden del Ministro de Energía, Turismo y Agenda Digital.<br/>
<br/>
En el caso de que un consumidor que cumpla los requisitos para percibir el bono social y quiera solicitar su aplicación, no figure como titular del punto de suministro de electricidad en vigor, la solicitud de modificación de titularidad del contrato de suministro de electricidad se podrá realizar de forma simultánea a la solicitud del bono social. En este caso, no se aplicará lo dispuesto en el artículo 83.5 del Real Decreto 1955/2000, de 1 de diciembre, por el que se regulan las actividades de transporte, distribución, comercialización, suministro de electricidad y procedimientos de autorización de instalaciones de energía eléctrica, sobre la revisión de las instalaciones de más de veinte años.<br/>
<br/>
<a href="https://es.support.somenergia.coop/article/208-que-es-el-bono-social">El Bono Social. Artículo en Som Energia</a><br/>
<a href="https://blog.somenergia.coop/grupos-locales/aragon/2018/03/el-nuevo-bono-social/">El nuevo Bono Social</a><br/>
<a href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad">Acceso a las tablas de pensiones mínimas</a><br/>
<a href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad">¿Qué es el PVPC?</a><br/>
<a href="http://www.minetad.gob.es/energia/bono-social/Paginas/preguntas-frecuentes-bono-social.aspx#contenido">Preguntas frecuentes sobre el bono social en la Web del Ministerio de Energía.</a><br/>
<br/>
</font>
% endif
${text_legal}
</body>
</html>
