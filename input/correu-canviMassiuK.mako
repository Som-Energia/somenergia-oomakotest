<!doctype html>
<html>

% if object.polissa_id.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.polissa_id.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.polissa_id.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
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

if object.extra_text:
  dict_parametres = eval(object.extra_text)
  k_actual = dict_parametres['k_actual_kwh']
  k_nova = dict_parametres['k_nova_kwh']
  consum_12_mesos_kWh = dict_parametres['consum_12_mesos_kwh']
  cost_anual_k_actual = dict_parametres['cost_anual_k_actual']
  cost_anual_k_nova = dict_parametres['cost_anual_k_nova']
%>
<br>
<p>Hola,</p>
<br>
% if  object.polissa_id.titular.lang != "es_ES":
<p>Ens posem en contacte amb vosaltres per informar-vos que <b>a partir del juliol actualitzem la franja de la cooperativa (el valor K de la fórmula de la <a href="https://ca.support.somenergia.coop/article/1272-la-tarifa-indexada">tarifa indexada</a>)</b>, que inclou el marge per a la viabilitat de la cooperativa, el cost dels certificats de garantia d'origen 100% renovable i el cost dels desviaments.</p>
<p>Per al vostre contracte, el preu actual de la franja K és de ${k_actual} €/kWh i a partir del juliol, el preu serà de:</p>
<b><p style="text-align:center;">${k_nova} €/kWh</p></b>
<p>Aquest preu està calculat tenint en compte el vostre consum dels últims dotze mesos: <b>${consum_12_mesos_kWh} kWh</b>.</p>
<p>La variació de la franja K respon a una revisió a la baixa del càlcul del marge, a una actualització dels costos (augment del preu dels certificats de garantia d’origen i dels desviaments) i a la variació de l’ús elèctric anual del punt de subministrament (a més consum, el marge per kWh es redueix; i a la inversa, si el consum disminueix, el marge per kWh augmenta).<p>
<br>
<p><b>Estimació</b></p>
<p>Tal com estableix la normativa, hem realitzat una <b>estimació del cost anual de l’energia amb la nova franja K.</b> Tenint en compte el vostre consum en els últims dotze mesos, el cost hauria estat de ${cost_anual_k_nova} €, mentre que amb la franja K actual el cost ha sigut de ${cost_anual_k_actual} €.</p>
<br>
<p>En aquest correu adjuntem el contracte actualitzat amb el nou preu de la franja K. Si esteu d'acord amb el canvi, no heu de fer res, ja que l'actualització serà automàtica l’1 de juliol, i se us aplicarà després de rebre la següent factura (és a dir, per exemple, si el període facturat arriba fins al 30 de juny, se us començarà a aplicar l’1 de juliol, i si el període facturat arriba fins al 10 de juliol, se us començarà a aplicar l’11 de juliol).</p>
<p>Igualment, hem d'informar-vos que si aquest canvi us fes replantejar la vostra pertinença a la cooperativa, podeu donar de baixa el contracte mitjançant un canvi de comercialitzadora, ja que no hi ha permanència. Tanmateix, si aquesta és la vostra decisió, us agrairem que ens ho comuniqueu amb un preavís de 30 dies. En aquest cas, facturaríem el consum realitzat fins a la data de finalització del contracte amb els preus corresponents a cada moment.</p>
<p> Per a qualsevol dubte o consulta, quedem a la vostra disposició.</p>
<br>
<p>Salutacions,</p>
<p> Equip de Som Energia</p>
<p><a href="https://www.somenergia.coop/ca/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<p>Os escribimos para informaros que <b>a partir de julio actualizamos la franja de la cooperativa (el valor K de la fórmula de la <a href="https://es.support.somenergia.coop/article/1273-la-tarifa-indexada?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">tarifa indexada</a>)</b>, que incluye el margen para la viabilidad de la cooperativa, el coste de los certificados de garantía de origen 100% renovable y el coste de los desvíos.</p>
<p>El precio actual de la franja (la K) es de ${k_actual} €/kWh y a partir de la fecha indicada, para vuestro contrato, el precio será de:</p>
<b><p style="text-align:center;">${k_nova} €/kWh<p></b>
<p>Este precio está calculado teniendo en cuenta vuestro consumo de los últimos doce meses: <b>${cost_anual_k_nova} kWh</b>.</p>
<p>La variación de la franja K responde a una revisión a la baja del cálculo del margen, a una actualización de los costes (aumento del precio de los certificados de garantía de origen y de los desvíos) y a la variación del uso eléctrico anual del punto de suministro (a más consumo, el margen por kWh se reduce; y a la inversa, si el consumo disminuye, el margen por kWh aumenta).<p>
<br>
<p><b>Estimación</b></p>
<p>Tal y como establece la normativa, hemos realizado una estimación del coste anual de la energía con la nueva franja K. Teniendo en cuenta vuestro consumo en los últimos doce meses, el coste habría sido de ${cost_anual_k_nova} €, mientras que con la franja K actual el coste ha sido de ${cost_anual_k_actual} €.</p>
<br>
<p>En este correo adjuntamos el contrato actualizado con el nuevo precio de la franja K. Si estáis de acuerdo con el cambio, no es necesario hacer nada, ya que la actualización será automática el 1 de julio, y se os aplicará después de recibir la siguiente factura (es decir, por ejemplo, si el período facturado es hasta el 30 de junio, se comenzará a aplicar el 11 de julio, y si el período facturado es hasta el 10 de julio, se empezará a aplicar el 11 de julio).</p>
<p>Igualmente, debemos informaros que si este cambio os hiciera replantear vuestra pertenencia a la cooperativa, podéis dar de baja el contrato mediante un cambio de comercializadora, puesto que no hay permanencia. Asimismo, si esta es vuestra decisión, os agradeceríamos que nos lo comunicarais con un preaviso de 30 días. En este caso, facturaríamos el consumo realizado hasta la fecha de finalización del contrato con los precios correspondientes en cada momento.</p>
<p>Para cualquier duda o consulta, quedamos a vuestra disposición.</p>
<br>
<p>Saludos cordiales,</p>
<p>Equipo de Som Energia</p>
<p> <a href="https://www.somenergia.coop/es/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
<br>
<p>${text_legal}</p>
</body>
</html>
