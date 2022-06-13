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

NEW_TARIFF_PRICES = {
    "2.0TD": {
        "power": [
            ("P1", 27.984),
            ("P2", 2.963),
        ],
        "energy": [
            ("P1", 0.357),
            ("P2", 0.293),
            ("P3", 0.241),
        ],
        "gkwh": [
            ("P1", 0.170),
            ("P2", 0.120),
            ("P3", 0.096),
        ]
    },
    "3.0TD": {
        "power": [
            ("P1", 14.440099),
            ("P2", 11.127305),
            ("P3", 5.123259),
            ("P4", 4.237486),
            ("P5", 2.557580),
            ("P6", 1.780529),
        ],
        "energy": [
            ("P1", 0.355),
            ("P2", 0.324),
            ("P3", 0.296),
            ("P4", 0.269),
            ("P5", 0.246),
            ("P6", 0.239),
        ],
        "gkwh": [
            ("P1", 0.142),
            ("P2", 0.130),
            ("P3", 0.107),
            ("P4", 0.095),
            ("P5", 0.083),
            ("P6", 0.091),
        ]
    },
    "6.1TD": {
        "power": [
            ("P1", 22.417110),
            ("P2", 20.370815),
            ("P3", 11.478137),
            ("P4", 9.055455),
            ("P5", 1.992116),
            ("P6", 1.185268),
        ],
        "energy": [
            ("P1", 0.314),
            ("P2", 0.289),
            ("P3", 0.271),
            ("P4", 0.244),
            ("P5", 0.226),
            ("P6", 0.219),
        ],
        "gkwh": [
            ("P1", 0.101),
            ("P2", 0.093),
            ("P3", 0.079),
            ("P4", 0.072),
            ("P5", 0.062),
            ("P6", 0.069),
        ]
    },
    "3.0TDVE": {
        "power": [
            ("P1", 2.600765),
            ("P2", 2.266264),
            ("P3", 0.915907),
            ("P4", 0.696758),
            ("P5", 0.274140),
            ("P6", 0.274140),
        ],
        "energy": [
            ("P1", 0.441),
            ("P2", 0.392),
            ("P3", 0.333),
            ("P4", 0.291),
            ("P5", 0.251),
            ("P6", 0.243),
        ],
        "gkwh": [
            ("P1", 0.227),
            ("P2", 0.198),
            ("P3", 0.144),
            ("P4", 0.118),
            ("P5", 0.088),
            ("P6", 0.095),
        ]
    },
    "6.1TDVE": {
        "power": [
            ("P1", 4.107961),
            ("P2", 4.107961),
            ("P3", 2.239713),
            ("P4", 1.696452),
            ("P5", 0.112654),
            ("P6", 0.112654),
        ],
        "energy": [
            ("P1", 0.456),
            ("P2", 0.403),
            ("P3", 0.335),
            ("P4", 0.285),
            ("P5", 0.232),
            ("P6", 0.223),
        ],
        "gkwh": [
            ("P1", 0.242),
            ("P2", 0.207),
            ("P3", 0.143),
            ("P4", 0.113),
            ("P5", 0.068),
            ("P6", 0.074),
        ]
    },
}

OLD_TARIFF_PRICES = {
    "2.0TD": {
        "power": [
            ("P1", 27.984),
            ("P2", 2.963),
        ],
        "energy": [
            ("P1", 0.380),
            ("P2", 0.315),
            ("P3", 0.261),
        ],
        "gkwh": [
            ("P1", 0.183),
            ("P2", 0.132),
            ("P3", 0.109),
        ]
    },
    "3.0TD": {
        "power": [
            ("P1", 14.440099),
            ("P2", 11.127305),
            ("P3", 5.123259),
            ("P4", 4.237486),
            ("P5", 2.557580),
            ("P6", 1.780529),
        ],
        "energy": [
            ("P1", 0.373),
            ("P2", 0.340),
            ("P3", 0.313),
            ("P4", 0.290),
            ("P5", 0.264),
            ("P6", 0.252),
        ],
        "gkwh": [
            ("P1", 0.148),
            ("P2", 0.135),
            ("P3", 0.114),
            ("P4", 0.104),
            ("P5", 0.093),
            ("P6", 0.099),
        ]
    },
    "6.1TD": {
        "power": [
            ("P1", 22.417110),
            ("P2", 20.370815),
            ("P3", 11.478137),
            ("P4", 9.055455),
            ("P5", 1.992116),
            ("P6", 1.185268),
        ],
        "energy": [
            ("P1", 0.332),
            ("P2", 0.305),
            ("P3", 0.287),
            ("P4", 0.265),
            ("P5", 0.242),
            ("P6", 0.231),
        ],
        "gkwh": [
            ("P1", 0.107),
            ("P2", 0.099),
            ("P3", 0.086),
            ("P4", 0.080),
            ("P5", 0.069),
            ("P6", 0.076),
        ]
    },
    "3.0TDVE": {
        "power": [
            ("P1", 2.600765),
            ("P2", 2.266264),
            ("P3", 0.915907),
            ("P4", 0.696758),
            ("P5", 0.274140),
            ("P6", 0.274140),
        ],
        "energy": [
            ("P1", 0.458),
            ("P2", 0.407),
            ("P3", 0.350),
            ("P4", 0.312),
            ("P5", 0.269),
            ("P6", 0.255),
        ],
        "gkwh": [
            ("P1", 0.233),
            ("P2", 0.203),
            ("P3", 0.151),
            ("P4", 0.127),
            ("P5", 0.097),
            ("P6", 0.102),
        ]
    },
    "6.1TDVE": {
        "power": [
            ("P1", 4.107961),
            ("P2", 4.107961),
            ("P3", 2.239713),
            ("P4", 1.696452),
            ("P5", 0.112654),
            ("P6", 0.112654),
        ],
        "energy": [
            ("P1", 0.473),
            ("P2", 0.418),
            ("P3", 0.352),
            ("P4", 0.306),
            ("P5", 0.248),
            ("P6", 0.235),
        ],
        "gkwh": [
            ("P1", 0.249),
            ("P2", 0.212),
            ("P3", 0.150),
            ("P4", 0.120),
            ("P5", 0.075),
            ("P6", 0.080),
        ]
    },
}

def getConsumEstimatPotencia(potencia):
  res = 0
  if potencia <= 1:
    res = 200
  elif 1 < potencia <= 2:
    res = 600
  elif 2 < potencia <= 3:
    res = 1200
  elif 3 < potencia <= 4:
    res = 1800
  elif 4 < potencia <= 5:
    res = 2500
  elif 5 < potencia <= 6:
    res = 3100
  elif 6 < potencia <= 7:
    res = 4100
  elif 7 < potencia <= 8:
    res = 5000
  elif 8 < potencia <= 9:
    res = 5400
  elif 9 < potencia <= 10:
    res = 6100
  elif 10 < potencia <= 11:
    res = 7100
  elif 11 < potencia <= 12:
    res = 8500
  elif 12 < potencia <= 13:
    res = 9000
  elif 13 < potencia <= 14:
    res = 10000
  elif 14 < potencia <= 15:
    res = 10500
  elif potencia == 15.001:
    res = 9800
  elif 15.001 < potencia <= 20:
    res = 16500
  elif 20 < potencia <= 25:
    res = 22100
  elif 25 < potencia <= 30:
    res = 26500
  elif 30 < potencia <= 35:
    res = 33100
  elif 35 < potencia <= 40:
    res = 42500
  elif 40 < potencia <= 45:
    res = 48700
  elif 45 < potencia <= 50:
    res = 65400
  elif 50 < potencia <= 55:
    res = 52300
  elif 55 < potencia <= 60:
    res = 56100
  elif 60 < potencia <= 65:
    res = 62500
  elif 65 < potencia <= 70:
    res = 74800
  elif potencia > 70:
    res = 100000

  return res

def getPotenciesPolissa(pol):
  potencies = {}
  for pot in pol.potencies_periode:
      potencies[pot.periode_id.name] = pot.potencia
  return potencies

def calcularPreuTotal(consums, potencies, tarifa, preus):

  types =  {
    'power': potencies or {},
    'energy': consums or {}
  }
  imports = 0
  for terme, values in types.items():
    for periode, quantity in values.items():
      imports += dict(preus[tarifa][terme])[periode] * quantity

  return imports

def aplicarCoeficients(consum_anual, tarifa):
  coeficients = {
    '2.0TD': {
      'P1': 0.284100158347879,
      'P2': 0.251934848093523,
      'P3': 0.463964993558617,
    },
    '3.0TD': {
      'P1': 0.1179061169783,
      'P2': 0.135534026607127,
      'P3': 0.126188472795622,
      'P4': 0.137245875258514,
      'P5': 0.052448855573218,
      'P6': 0.430676652787213,
    },
    '6.1TD': {
      'P1': 0.1179061169783,
      'P2': 0.135534026607127,
      'P3': 0.126188472795622,
      'P4': 0.137245875258514,
      'P5': 0.052448855573218,
      'P6': 0.430676652787213,
    },
  }
  consums = {
    k: consum_anual * coeficients[tarifa][k]
    for k in coeficients[tarifa].keys()
  }
  return consums

def calcularImpostos(preu, fiscal_position):
  iva = 0.21
  impost_electric = 0.051127
  if fiscal_position:
    if fiscal_position.id in [19,33]:
      iva = 0.03
    if fiscal_position.id in [25,34]:
      iva = 0.0
  preu_imp = round(preu * (1 + impost_electric), 2)
  return round(preu_imp * (1 + iva))

def formatNumber(number):
  return format(number, "1,.0f").replace(',','.')

potencies = getPotenciesPolissa(object.polissa_id)

tarifa = object.polissa_id.tarifa.name
consums = ''
origen = ''
quintextes = ''
if object.extra_text:
  consums = eval(object.extra_text)
  origen = consums['origen']
  quintextes = consums['origen']
  del consums['origen']
  consum_total = sum(consums.values())
elif tarifa == '2.0TD':
  consum_total = getConsumEstimatPotencia(object.polissa_id.potencia)
  consums = aplicarCoeficients(consum_total, tarifa)
  origen = 'estadistic'
  quintextes = 'casB'
else:
  consum_total = object.polissa_id.cups.conany_kwh
  origen = object.polissa_id.cups.conany_origen
  consums = aplicarCoeficients(consum_total, tarifa)
  if origen == 'estadistic' or origen == 'usuari':
    consum_total = getConsumEstimatPotencia(object.polissa_id.potencia)
    consums = aplicarCoeficients(consum_total, tarifa)
    quintextes = 'casB'
  else:
    quintextes = 'casA'

preu_vell = calcularPreuTotal(consums, potencies, tarifa, OLD_TARIFF_PRICES)
preu_nou = calcularPreuTotal(consums, potencies, tarifa, NEW_TARIFF_PRICES)

preu_vell_imp_int = calcularImpostos(preu_vell, object.polissa_id.fiscal_position_id)
preu_nou_imp_int = calcularImpostos(preu_nou, object.polissa_id.fiscal_position_id)

increment_total = formatNumber(abs(preu_nou_imp_int - preu_vell_imp_int))
increment_mensual = abs((preu_nou_imp_int - preu_vell_imp_int) / 12)

preu_vell_imp = formatNumber(preu_vell_imp_int)
preu_nou_imp = formatNumber(preu_nou_imp_int)

impost_aplicat = 'IVA del 21'
if object.polissa_id.fiscal_position_id.id in [19, 33]:
  impost_aplicat = "IGIC del 3"
elif object.polissa_id.fiscal_position_id.id in [25, 34]:
  impost_aplicat = "IGIC del 0"

consum_total = formatNumber(round(consum_total/100.0)*100)

%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, object.polissa_id.titular.vat):
    nom_titular =' ' + object.polissa_id.titular.name.split(',')[1].lstrip()
  else:
    nom_titular = ''
except:
  nom_titular = ''
%>
<br>
<p>Hola${nom_titular},</p>
<br>
% if  object.polissa_id.titular.lang != "es_ES":

<p>Des d’avui, 10 de juny, apliquem uns nous preus a les tarifes de Som Energia. Després d’uns mesos amb costos de l’energia elevadíssims, ara s’han estabilitzat; això, i la previsió per als propers mesos, fan que puguem abaixar una mica les nostres tarifes. </p>
<p>Donem més detalls de l’actualització de preus a <a href="https://blog.somenergia.coop/?p=42375">aquesta notícia</a> del blog, i pots veure’ls també a l’<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">apartat de tarifes del web</a>. Si vols fer-ne comparacions, pots accedir a l’<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha els preus vigents fins al 9 de juny i els de períodes anteriors.</p>
<p>Per altra banda, pel que fa a la mesura de les <b>rebaixes dels impostos (IVA del 10% i impost elèctric del 0,5%)</b>, de moment segueixen en vigor fins al 30 de juny en les mateixes condicions.</p>
<br>
<p><b>Estimació</b></p>
  % if quintextes == 'casA':
  <p>Tal com estableix la normativa, hem fet una <b>estimació de caràcter orientatiu</b>, a partir de les dades que tenim del teu històric recent d’ús d’electricitat (aproximadament ${consum_total} kWh anuals) i prenent com a referència el repartiment horari d’un contracte estàndard, sense autoproducció ni Generation kWh. Segons aquestes dades, l’actualització dels nous càrrecs podria suposar una disminució aproximada de ${increment_total} euros anuals a la factura respecte al que costaria si mantinguéssim els preus de l'abril durant tot l’any. Així doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense actualitzar els preus. En els dos casos l’estimació inclou l’${impost_aplicat} % i l’impost elèctric del 5,11 %, és a dir, impostos sense les rebaixes vigents.</p>
  <p>Tingues en compte que això són estimacions aproximades, i que els imports finals <b>dependran de circumstàncies</b> que no podem preveure, com per exemple els horaris i l’ús d’energia que finalment facis, altres variacions de preus durant el 2022, o canvis que pugui haver al mercat elèctric.</p>
  % elif quintextes == 'casB':
  <p>Tal com estableix la normativa, hem fet una <b>estimació de caràcter orientatiu</b>, en funció de la potència contractada que tens i l’ús d’electricitat que sol haver-hi amb aquestes potències, agafant de referència un contracte estàndard, sense autoproducció ni Generation kWh. Segons aquestes dades, l’actualització de preus podria suposar una disminució aproximada de ${increment_total} euros anuals a la factura respecte al que costaria sense aplicar-hi els nous preus (és a dir, si mantinguéssim els preus de l'abril durant tot l’any). Així doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense aplicar el canvi de preus. En els dos casos l’estimació inclou l’${impost_aplicat} % i l’impost elèctric del 5,11%, és a dir, impostos sense les rebaixes vigents.</p>
  <p>Tingues en compte que això són estimacions aproximades a partir d’usos típics, i que els imports finals <b>dependran de circumstàncies</b> que no podem preveure, com per exemple els horaris i el consum real d’energia que facis, altres variacions de preus durant el 2022, o canvis que pugui haver al mercat elèctric.</p>
  % elif quintextes == 'casC':
  <p>Tal com estableix la normativa, hem fet una <b>estimació de caràcter orientatiu</b>, a partir de les dades que tenim del teu històric recent d’ús d’electricitat (aproximadament ${consum_total} kWh anuals) i sense tenir en compte l’autoproducció ni el Generation kWh. Segons aquesta estimació, l’actualització dels nous càrrecs podria suposar una disminució aproximada de ${increment_total} euros anuals a la factura respecte al que costaria si mantinguéssim els preus vigents des de l'abril, durant tot l’any. Així doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense aplicar els nous preus. En els dos casos l’estimació inclou l’${impost_aplicat} % i l’impost elèctric del 5,11 %, és a dir, impostos sense rebaixes del govern.</p>
  <p>Tingues en compte que això són estimacions aproximades, i que els imports finals <b>dependran de circumstàncies</b> que no podem preveure, com per exemple els horaris i el consum real d’energia que facis, variacions de preus durant el 2022, o altres canvis que pugui haver al mercat elèctric.</p>
  % endif
<br>
<p>T’adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Imaginem que estaràs d’acord amb la baixada de preus. Si és així, <b>no cal que ens retornis el document signat</b>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d’informar-te que si, per alguna raó, aquest canvi de preus a la baixa et fes replantejar la teva pertinença a la cooperativa, podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia de finalització del contracte, amb els preus vigents a cada moment.</p>
<br>
<p>Estem a la teva disposició per a qualsevol dubte. Et demanem que, en cas que en tinguis, ens escriguis un correu a info@somenergia.coop.</p>
<p>Una salutació cordial,</p>
<br>
<p> Equip de Som Energia</p>
<p><a href="https://www.somenergia.coop/ca/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
<p><i>Aquest correu electrònic no admet respostes.</i><p>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<p>Desde hoy, 10 de junio, aplicamos unos nuevos precios a las tarifas de Som Energia. Después de unos meses con elevadísimos costes de la energía, ahora se han estabilizado; esto, y la previsión para los próximos meses hacen que podamos bajar un poco nuestras tarifas.</p>
<p>Damos más detalles de la actualización de precios en esta <a href="https://blog.somenergia.coop/?p=42377">noticia del blog</a>, y puedes verlos también en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">apartado de tarifas de la web</a>. Si quieres hacer comparaciones, puedes acceder al <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde están los precios vigentes hasta el 9 de junio y los de períodos anteriores.</p>
<p>Por otra parte, en cuanto a la medida de las <b>rebajas de los impuestos (IVA del 10% e impuesto eléctrico del 0,5%)</b>, de momento siguen en vigor hasta el 30 de junio en las mismas condiciones.</p>
<br>
<p><b>Estimación</b></p>
% if quintextes == 'casA':
<p>Tal y como establece la normativa, hemos hecho una <b>estimación orientativa</b>, a partir de los datos que tenemos de tu histórico reciente de uso de electricidad (aproximadamente ${consum_total} kWh anuales) y tomando como referencia el reparto horario de un contrato estándar, sin autoproducción ni Generation kWh. Según estos datos, la actualización de los nuevos precios podría suponer una disminución aproximada de ${increment_total} euros anuales en la factura respecto a lo que costaría si mantuviéramos los precios de abril durante todo el año. Así pues, resultaría un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin actualizar los precios. En ambos casos la estimación incluye el ${impost_aplicat}% y el impuesto eléctrico del 5,11%, es decir, impuestos sin las rebajas vigentes.</p>
<p>Ten en cuenta que esto son estimaciones aproximadas a partir de usos típicos, y que los importes finales <b>dependerán de circunstancias</b> que no podemos prever, como por ejemplo los horarios y el consumo real de energía que realices, otras variaciones de precios durante el 2022, o cambios que pueda haber en el mercado eléctrico.</p>
% elif quintextes == 'casB':
<p>Tal y como establece la normativa, hemos hecho una <b>estimación de carácter orientativo</b>, en función de la potencia contratada que tienes y el uso de electricidad que suele haber con estas potencias, cogiendo de referencia un contrato estándar, sin autoproducción ni Generation kWh. Según estos datos, la actualización de precios podría suponer una disminución aproximada de ${increment_total} euros anuales en la factura respecto a lo que costaría sin aplicar los nuevos precios (es decir, si mantuviéramos los precios de abril durante todo el año). Así pues, resultaría un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin aplicar el cambio de precios. En ambos casos la estimación incluye el ${impost_aplicat}% y el impuesto eléctrico del 5,11%, es decir, impuestos sin las rebajas vigentes.</p>
<p>Ten en cuenta que esto son estimaciones aproximadas a partir de usos típicos, y que los importes finales <b>dependerán de circunstancias</b> que no podemos prever, como por ejemplo los horarios y el consumo real de energía que realices, otras variaciones de precios durante el 2022, o cambios que pueda haber en el mercado eléctrico.</p>
% elif quintextes == 'casC':
<p>Tal y como establece la normativa, hemos hecho una <b>estimación de carácter orientativo</b>, a partir de los datos que tenemos de tu histórico reciente de uso de electricidad (aproximadamente ${consum_total} kWh anuales) y sin tener en cuenta la autoproducción ni el Generation kWh. Según esta estimación, la actualización de los nuevos cargos podría suponer una disminución aproximada de ${increment_total} euros anuales en la factura respecto a lo que costaría si mantuviéramos los precios vigentes desde abril, durante todo el año. Así pues, resultaría un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin aplicar los nuevos precios. En ambos casos la estimación incluye el ${impost_aplicat}% y el impuesto eléctrico del 5,11%, es decir, impuestos sin rebajas del gobierno.</p>
<p>Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <b>dependerán de circunstancias</b> que no podemos prever, como por ejemplo los horarios y el consumo real de energía que realices, variaciones de precios durante el 2022, u otros cambios que pueda haber en el mercado eléctrico.</p>
% endif
<br>
<p>Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Imaginamos que estarás de acuerdo con la disminución de precios. Si es así, <b>no es necesario que nos devuelvas el documento firmado</b>, ya que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos informarte de que si, por alguna razón, este cambio de precios a la baja te hiciera replantear tu pertenencia a la cooperativa, podrías dar de baja tu contrato con Som Energia, bien comunicándonoslo directamente, o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día de finalización del contrato, con los precios vigentes en cada momento.</p>
<br>
<p>Estamos a tu disposición para cualquier duda. Te pedimos que, en caso de que las tengas, nos escribas un correo a info@somenergia.coop.</p>
<p>Un saludo cordial,</p>
<br>
<p> Equipo de Som Energia</p>
<p> <a href="https://www.somenergia.coop/es/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
<p><i>Este correo electrónico no admite respuestas.</i><p>
% endif

<p>${text_legal}</p>
</body>
</html>
