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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

nom_titular = object.polissa_id.titular.name
num_contracte = object.polissa_id.name
direccio_cups = object.polissa_id.cups.direccio
%>
${plantilla_header}
% if object.polissa_id.titular.lang != "es_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${object.polissa_id.cups.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.polissa_id.cups.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;"> Titular: ${object.polissa_id.titular.name} </span></td>
</tr>
</tbody>
</table>
<br>
Hola, ${nom_titular},<br>
<br>
El passat 15 de gener de 2025, la Comissió Nacional dels Mercats i la Competència (CNMC) va publicar una <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-2044">circular (1/2025)</a> que modificava alguns aspectes d’una circular anterior, la 3/2020. Amb aquesta nova circular, entre altres coses, es modifica el mètode de <strong>càlcul de les penalitzacions per excessos de potència contractada</strong>. Aquesta modificació ha entrat en vigor l’ú d’abril de 2025.<br/>
<br/>
Amb aquesta mesura, la CNMC redueix el cost de la penalització per excessos de potència. Així mateix, si detecteu que el vostre contracte té moltes penalitzacions per excessos de potència, podeu contactar amb nosaltres a empresa@somenergia.coop i ho revisarem. <br/>
<br/>
Recordem que els contractes 3.0TD i 6.1TD tenen sis períodes horaris diferents, definits en funció del mes de l’any, el dia de la setmana i l’hora del dia. Els moments amb més demanda elèctrica a nivell global queden classificats com a període 1, que és el més car, mentre que les hores amb menys demanda elèctrica queden definides com a període 6, normalment el més econòmic. Podeu consultar els horaris i preus dels sis períodes <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#tarifa30TD">aquí.</a><br/>
<br/>
Així en el cas que se sobrepassi la potència contractada, i segons les característiques del punt de subministrament, la normativa aplica una fórmula de càlcul o altra. Ho expliquem més detalladament a continuació: <br/>
<br/>
Per una banda, hi ha els punts de subministrament que tenen comptadors tipus 4 o 5 (normalment amb una potència contractada d’entre 15 i 50 kW). En aquest cas, podeu consultar el detall de la nova fórmula de càlcul <a href="https://ca.support.somenergia.coop/article/1086-cost-dels-excessos-de-potencia-per-a-tarifes-de-fins-a-50-kw">aquí</a>. També poden tenir penalitzacions per excessos de potència, amb la mateixa fórmula de càlcul, alguns contractes 2.0TD (de menys de 15 kW de potència contractada) però que tenen elements no-interrompibles (més informació en <a href="https://ca.support.somenergia.coop/article/1103-cost-de-la-potencia-i-dels-excessos-de-potencia-per-a-la-tarifa-2-0td-amb-elements-no-interrompibles">aquest enllaç</a>).<br/>
<br/>
D’altra banda, hi ha aquells punts de subministrament amb comptadors tipus 1,2 o 3 (connectats a l’alta tensió, normalment amb una potència contractada superior als 50 kW). Si aquest és el vostre cas, podeu consultar el detall de la nova fórmula de càlcul <a href="https://ca.support.somenergia.coop/article/1090-cost-dels-excessos-de-potencia-per-a-la-tarifa-de-mes-de-50-kw-i-serveis-auxiliars">aquí</a>. <br/>
<br/>
Recordem que a Som Energia no afegim cap mena de recàrrec en les penalitzacions per excessos de potència i que només traslladem els costos regulat.<br/>
<br/>
Quedem a la vostra disposició per a qualsevol dubte o consulta.<br/>
<br/>
Salutacions,<br/>
<br/>
Equip de Som Energia<br/>
<br/>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${object.polissa_id.cups.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${object.polissa_id.cups.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${object.polissa_id.titular.name}</span></td>
</tr>
</tbody>
</table>
<br/>
Hola ${nom_titular},<br/>
<br/>
El pasado 15 de enero de 2025, la Comisión Nacional de los Mercados y la Competencia (CNMC) publicó una <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-2044">circular (1/2025)</a> que modificaba algunos aspectos de una circular anterior, la 3/2020. Con esta nueva circular, entre otras cosas, se modifica el método de <strong>cálculo de las penalizaciones por excesos de potencia contratada</strong>. Esta modificación ha entrado en vigor el uno de abril de 2025.<br/>
<br/>
Con esta medida, la CNMC reduce el coste de la penalización por excesos de potencia. Así mismo, si detectáis que vuestro contrato tiene muchas penalizaciones por excesos de potencia, podéis contactar con nosotros en empresa@somenergia.coop y lo revisaremos.<br/>
<br/>
Recordamos que los contratos 3.0TD y 6.1TD tienen seis periodos horarios distintos, definidos en función del mes del año, el día de la semana y la hora del día. Los momentos con mayor demanda eléctrica a nivel global quedan clasificados como periodo 1, que es el más caro, mientras que las horas con menos demanda eléctrica quedan definidas como periodo 6, normalmente el más económico. Podéis consultar los horarios y los precios de los seis periodos <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#tarifa30TD">aquí </a>.<br/>
<br/>
Así, en caso de que se sobrepase la potencia contratada, y según las características del punto de suministro, la normativa aplica una fórmula de cálculo u otra. Lo explicamos más detalladamente a continuación:
<br/>
Por un lado, están los puntos de suministro que tienen contadores tipo 4 o 5 (normalmente con una potencia contratada de entre 15 y 50 kW). En este caso, podéis consultar el detalle de la nueva fórmula de cálculo <a href="https://es.support.somenergia.coop/article/1085-coste-de-los-escesos-de-potencia-para-tarifas-hasta-50-kw">aquí</a>. También pueden tener penalizaciones por exceso de potencia, con la misma fórmula de cálculo, algunos contratos 2.0TD (de menos de 15 kW de potencia contratada) pero que tienen elementos ‘no interrumpibles’ (más información en <a href="https://es.support.somenergia.coop/article/1111-coste-de-la-potencia-y-de-los-excesos-de-potencia-para-la-tarifa-2-0td-con-elementos-no-interrumpibles">este enlace</a>).<br/>
<br/>
Por otro lado, tenemos aquellos puntos de suministro con contadores tipo 1,2 o 3 (conectados a la alta tensión, normalmente con una potencia contratada superior a los 50 kW). Si este es vuestro caso, podéis consultar el detalle de la nueva fórmula de cálculo <a href="https://es.support.somenergia.coop/article/1091-coste-de-los-excesos-de-potencia-para-la-tarifa-3-0td-de-mas-de-50-kw">aquí</a>.<br/>
<br/>
Recordamos que en Som Energia no añadimos ningún tipo de recargo en las penalizaciones por excesos de potencia y que solamente trasladamos los costes regulados.<br/>
<br/>
Quedamos a tu disposición para cualquier duda o consulta.<br/>
<br/>
Un saludo,<br/>
<br/>
% endif
${plantilla_footer}