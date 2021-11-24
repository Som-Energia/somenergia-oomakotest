<!doctype html>
<html>
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.polissa_id.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
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

OLD_TARIFF_PRICES = {
    "2.0TD": {
        "power": [
            ("P1", 31.949),
            ("P2", 2.701),
        ],
        "energy": [
            ("P1", 0.301),
            ("P2", 0.199),
            ("P3", 0.148),
        ],
    },
    "3.0TD": {
        "power": [
            ("P1", 19.596985),
            ("P2", 13.781919),
            ("P3", 7.005384),
            ("P4", 6.106183),
            ("P5", 4.399377),
            ("P6", 2.636993),
        ],
        "energy": [
            ("P1", 0.257),
            ("P2", 0.228),
            ("P3", 0.195),
            ("P4", 0.169),
            ("P5", 0.150),
            ("P6", 0.141),
        ],
    },
    "6.1TD": {
        "power": [
            ("P1", 30.535795),
            ("P2", 25.894705),
            ("P3", 14.909149),
            ("P4", 12.094449),
            ("P5", 3.938660),
            ("P6", 2.108693),
        ],
        "energy": [
            ("P1", 0.214),
            ("P2", 0.193),
            ("P3", 0.171),
            ("P4", 0.151),
            ("P5", 0.135),
            ("P6", 0.128),
        ],
    },
    "3.0TDVE": {
        "power": [
            ("P1", 2.660074),
            ("P2", 2.321941),
            ("P3", 0.939277),
            ("P4", 0.715050),
            ("P5", 0.281312),
            ("P6", 0.281312),
        ],
        "energy": [
            ("P1", 0.379),
            ("P2", 0.324),
            ("P3", 0.247),
            ("P4", 0.200),
            ("P5", 0.160),
            ("P6", 0.148),
        ],
    },
    "6.1TDVE": {
        "power": [
            ("P1", 4.733449),
            ("P2", 4.733449),
            ("P3", 2.569106),
            ("P4", 1.941942),
            ("P5", 0.124793),
            ("P6", 0.124793),
        ],
        "energy": [
            ("P1", 0.411),
            ("P2", 0.349),
            ("P3", 0.261),
            ("P4", 0.204),
            ("P5", 0.146),
            ("P6", 0.136),
        ],
    },
}

NEW_TARIFF_PRICES = {
    "2.0TD": {
        "power": [
            ("P1", 31.981),
            ("P2", 3.192),
        ],
        "energy": [
            ("P1", 0.396),
            ("P2", 0.286),
            ("P3", 0.228),
        ],
    },
    "3.0TD": {
        "power": [
            ("P1", 19.444029),
            ("P2", 13.631455),
            ("P3", 6.942581),
            ("P4", 6.056808),
            ("P5", 4.376902),
            ("P6", 2.614518),
        ],
        "energy": [
            ("P1", 0.357),
            ("P2", 0.319),
            ("P3", 0.283),
            ("P4", 0.255),
            ("P5", 0.231),
            ("P6", 0.219),
        ],
    },
    "6.1TD": {
        "power": [
            ("P1", 27.611408),
            ("P2", 22.970318),
            ("P3", 13.366972),
            ("P4", 10.944290),
            ("P5", 3.880951),
            ("P6", 2.050984),
        ],
        "energy": [
            ("P1", 0.306),
            ("P2", 0.277),
            ("P3", 0.254),
            ("P4", 0.231),
            ("P5", 0.210),
            ("P6", 0.199),
        ],
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
            ("P1", 0.480),
            ("P2", 0.414),
            ("P3", 0.335),
            ("P4", 0.286),
            ("P5", 0.240),
            ("P6", 0.225),
        ],
    },
    "6.1TDVE": {
        "power": [
            ("P1", 4.107960),
            ("P2", 4.107960),
            ("P3", 2.239713),
            ("P4", 1.696451),
            ("P5", 0.112654),
            ("P6", 0.112654),
        ],
        "energy": [
            ("P1", 0.486),
            ("P2", 0.419),
            ("P3", 0.334),
            ("P4", 0.280),
            ("P5", 0.220),
            ("P6", 0.207),
        ],
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
    if fiscal_position.id == 19:
      iva = 0.03
    if fiscal_position.id == 25:
      iva = 0.0
  preu_imp = round(preu * (1 + impost_electric), 2)
  return round(preu_imp * (1 + 0.21), 2)


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

preu_vell_imp = calcularImpostos(preu_vell, object.polissa_id.fiscal_position_id)
preu_nou_imp = calcularImpostos(preu_nou, object.polissa_id.fiscal_position_id)

increment_total = (preu_nou_imp - preu_vell_imp)
increment_mensual = (preu_nou_imp - preu_vell_imp) / 12

impost_aplicat = 'IVA del 21%'
if object.polissa_id.fiscal_position_id.id == 19:
  impost_aplicat = "IGIC del 3%"
elif object.polissa_id.fiscal_position_id.id == 25:
  impost_aplicat = "IGIC del 0%"

consum_total = round(consum_total,2)

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
<br>
<p> Hola ${nom_titular},</p>
<br>
% if  object.polissa_id.titular.lang != "es_ES":

<p>A partir de l’u de gener <b>modificarem els preus de l’electricitat</b> de Som Energia. Ja deus saber que estem en un context de pujades desorbitades del preu de l’energia al mercat majorista (per la qual cosa ja vam haver d’actualitzar preus al novembre). Ara hem de repercutir, de nou, aquest cost, i també hem d’adaptar els preus a les necessitats que tindrà la cooperativa durant l’any 2022.</p>

<p>Ho expliquem a <a href="https://blog.somenergia.coop">aquesta notícia del blog</a>, i al web hi podràs veure, també, <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l’apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">Històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de desembre i els de períodes anteriors.</p>
<br>
<p><b>Les mesures del govern</b></p>

<p>El govern va establir que les mesures de rebaixa de l’IVA i l’impost elèctric, així com el descompte en els càrrecs, serien fins al 31 de desembre. És per això que les tarifes amb impostos a partir de l’u de gener contemplen impostos del 21 % d’IVA i del 5,11 % d’impost elèctric. A no ser que hi hagi canvis en aquest sentit, això també farà que la variació en la factura final sigui major.</p>
<br>
<p><b>Estimació</b></p>

  % if quintextes == 'casA':
  <p>Hem fet una <b>estimació de caire orientatiu</b>, en base a les dades que tenim del teu històric recent de consum (aproximadament ${consum_total} kWh anuals) i prenent com a referència el repartiment horari d’un usuari/a mitjà (sense autoproducció ni Generation kWh). Segons aquestes dades, l’actualització de preus podria suposar un increment aproximat de ${increment_total} euros anuals a la factura respecte al que costaria si mantinguéssim els preus actuals, vigents des del novembre, durant tot l’any vinent. Així doncs, en resulta un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense actualitzar preus (en els dos casos l’estimació inclou l’${impost_aplicat} i l’impost elèctric del 5,11%, és a dir, impostos sense rebaixes del govern).</p>

  <p>Tingues en compte que això són estimacions aproximades, i que els imports finals <b>dependran de multitud de circumstàncies</b> que no podem preveure, com per exemple els horaris i el consum d’energia que finalment facis, les variacions de preus durant el 2022, o altres canvis que pugui haver al mercat energètic.</p>

  % elif quintextes == 'casB':
  <p>Hem fet una estimació en funció de la potència contractada que tens i el consum aproximat que sol haver-hi amb aquestes potències. Així doncs, a un usuari/a tipus de la teva potència amb un consum tipus de ${consum_total} kWh anuals, sense Generation kWh ni autoproducció, la factura anual amb els nous preus li sortiria ${increment_total} euros més elevada que si no actualitzéssim els preus. Segons aquesta estimació, el cost anual amb la pujada de preus sortiria per ${preu_nou_imp} euros, mentre que el cost anual amb els preus vigents des del novembre sortiria per ${preu_vell_imp} euros; tot, comptant que no hi ha rebaixes ni descomptes del govern.</p>

  <p>Tingues en compte que això són estimacions aproximades a partir d’usos típics, i que els imports finals <b>dependran de multitud de circumstàncies</b> que no podem preveure, com per exemple els horaris i el consum real d’energia que facis, variacions de preus durant el 2022, o altres canvis que pugui haver al mercat energètic.</p>

  % elif quintextes == 'casC':

  <p>Hem fet una <b>estimació de caire orientatiu</b>, en base a les dades que tenim del teu històric recent de consum (aproximadament ${consum_total} kWh anuals) i sense tenir en compte l’autoproducció ni el Generation kWh. Segons aquesta estimació, l’actualització de preus podria suposar un increment aproximat de ${increment_total} euros anuals a la factura respecte al que costaria si mantinguéssim els preus actuals, vigents des del novembre, durant tot l’any vinent. Així doncs, en resulta un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense actualitzar preus (en els dos casos l’estimació inclou l’${impost_aplicat} i l’impost elèctric del 5,11%, és a dir, impostos sense rebaixes del govern).</p>

  <p>Tingues en compte que això són estimacions aproximades, i que els imports finals <b>dependran de multitud de circumstàncies</b> que no podem preveure, com per exemple els horaris i el consum real d’energia que facis, variacions de preus durant el 2022, o altres canvis que pugui haver al mercat energètic.</p>

  % endif
<br>
<p>A la cooperativa fixem els preus de les nostres tarifes en funció del mercat elèctric, del qual depenem. N’hem de <b>reflexar les variacions, i ho fem tant a l’alça com a la baixa</b>. Les <b>previsions</b> apunten que el segon trimestre de 2022 hi haurà una baixada generalitzada del preu de l’energia, fet que ens permetria actualitzar les nostres tarifes.</b>
<br>
<p>Aprofitem per dir-te que al servei de comercialització de la cooperativa ens trobem encara en una situació excepcional de sobrecàrrega de feina, a causa de problemàtiques derivades dels nous peatges i l’adaptació de les distribuïdores. Això fa que no puguem atendre les consultes i peticions amb la celeritat amb què ho fem habitualment. Recorda que, si tens dubtes o vols fer algun tràmit, pots consultar el <a href="https://ca.support.somenergia.coop/">Centre d’Ajuda</a> o entrar a la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a>.</p>

<br>
<p>T’adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Com et comentàvem, les noves tarifes es començaran a aplicar el dia 1 de gener de 2022. Si hi estàs d’acord, no cal que responguis aquest correu ni que ens retornis el document signat, ja que l'actualització dels preus de les nostres tarifes s'aplicarà automàticament. Si lamentablement aquest canvi et fes replantejar la teva pertinença a la cooperativa, podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia de finalització del contracte, amb els preus vigents a cada moment.</p>

<br>
<p>Una salutació cordial,</p>
<br>
<p> Equip de Som Energia</p>
<p> <a href="https://www.somenergia.coop/ca/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<p>A partir del uno de enero modificaremos los precios de la electricidad de Som Energia. Ya debes saber que estamos en un contexto de subidas desorbitadas del precio de la energía en el mercado mayorista (por lo que ya tuvimos que actualizar precios en noviembre). Ahora tenemos que repercutir, de nuevo, este coste, y también debemos adaptar los precios a las necesidades que tendrá la cooperativa durante el año 2022.</p>

<p>Lo explicamos en <a href="https://blog.somenergia.coop">esta noticia del blog</a>, y en la web podrás ver, también, <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">todas las tarifas</a>. Si quieres hacer comparaciones, puedes acceder al apartado <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/historico-de-tarifas-de-electricidad/">Histórico de tarifas</a>, donde hay también los precios vigentes hasta el 31 de diciembre y los de períodos anteriores.</p>
<br>
<p><b>Las medidas del gobierno</b></p>

<p>El gobierno estableció que las medidas de rebaja del IVA y el impuesto eléctrico, así como el descuento en los cargos, serían hasta el 31 de diciembre. Por ello, las tarifas con impuestos a partir del uno de enero contemplan impuestos del 21% de IVA y del 5,11% de impuesto eléctrico. A no ser que haya cambios en este sentido, esto también hará que la variación en la factura final sea mayor.</p>
<br>
<p><b>Estimación</b></p>

% if quintextes == 'casA':

<p>Hemos hecho una estimación de carácter orientativo, en base a los datos que tenemos de tu histórico reciente de consumo (aproximadamente ${consum_total} kWh anuales) y tomando como referencia el reparto horario de un usuario/a medio (sin autoproducción ni Generation kWh). Según estos datos, la actualización de precios podría suponer un incremento aproximado de ${increment_total} euros anuales en la factura respecto a lo que costaría si mantuviéramos los precios actuales, vigentes desde noviembre, durante el próximo año. Así pues, resulta un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin actualizar precios (en los dos casos la estimación incluye el ${impost_aplicat} y el impuesto eléctrico del 5,11%, es decir, impuestos sin rebajas del gobierno).</p>
<p>Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <b>dependerán de multitud de circunstancias</b> que no podemos prever, como por ejemplo los horarios y el consumo de energía que finalmente hagas, las variaciones de precios durante 2022, u otros cambios que pueda haber en el mercado energético.</p>

% elif quintextes == 'casB':

<p>Hemos hecho una estimación en función de la potencia contratada que tienes y el consumo aproximado que suele haber con estas potencias. Así pues, para un usuario/a tipo de tu potencia con un consumo tipo de ${consum_total} kWh anuales, sin Generation kWh ni autoproducción, la factura anual con los nuevos precios saldría ${increment_total} euros más elevada que si no actualizáramos los precios. Según esta estimación, el coste anual con la subida de precios saldría por ${preu_nou_imp} euros, mientras que el coste anual con los precios vigentes desde noviembre saldría por ${preu_vell_imp} euros; todo esto, contando que no haya rebajas ni descuentos del gobierno.</p>
<p>Ten en cuenta que esto son estimaciones aproximadas a partir de usos típicos, y que los importes finales <b>dependerán de multitud de circunstancias</b> que no podemos prever, como por ejemplo los horarios y el consumo real de energía que hagas, variaciones de precios durante en 2022, u otros cambios que pueda haber en el mercado energético.</p>

% elif quintextes == 'casC':

<p>Hemos hecho una estimación de carácter orientativo, en base a los datos que tenemos de tu histórico reciente de consumo (aproximadamente ${consum_total} kWh anuales) y sin tener en cuenta la autoproducción ni el Generation kWh. Según esta estimación, la actualización de precios podría suponer un incremento aproximado de ${increment_total} euros anuales a la factura respecto a lo que costaría si mantuviéramos los precios actuales, vigentes desde noviembre, durante todo el próximo año. Así pues, resulta un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin actualizar precios (en ambos casos la estimación incluye el ${impost_aplicat} y el impuesto eléctrico del 5,11%, es decir, impuestos sin rebajas del gobierno).</p>
<p>Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <b>dependerán de multitud de circunstancias</b> que no podemos prever, como por ejemplo los horarios y el consumo real de energía que hagas, variaciones de precios durante el 2022, u otros cambios que pueda haber en el mercado energético.</p>
% endif
<br>
<p>En la cooperativa fijamos los precios de nuestras tarifas en función del mercado eléctrico, del cual dependemos. Debemos <b>reflejar sus variaciones, y lo hacemos tanto al alza como a la baja</b>. Las <b>previsiones</b> apuntan a que en el segundo trimestre de 2022 habrá una bajada generalizada del precio de la energía, lo que nos permitiría actualizar nuestras tarifas.</p>
<br>
<p>Aprovechamos para decirte que en el servicio de comercialización de la cooperativa nos encontramos todavía en una situación excepcional de sobrecarga de trabajo, debido a problemáticas derivadas de los nuevos peajes y la adaptación de las distribuidoras. Esto hace que no podamos atender las consultas y peticiones con la celeridad con la que lo hacemos habitualmente. Recuerda que, si tienes dudas o quieres realizar algún trámite, puedes consultar el <a href="https://es.support.somenergia.coop/">Centro de Ayuda</a> o entrar en tu <a href="https://oficinavirtual.somenergia.coop/es">Oficina Virtual</a>.</b>
<br>
<p>Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Como te comentábamos, las nuevas tarifas empezarán a aplicarse el día 1 de enero de 2022. Si estás de acuerdo, no hace falta que respondas este correo ni que nos devuelvas el documento firmado, ya que la actualización de los precios de nuestras tarifas se aplicará automáticamente. Si lamentablemente este cambio te hiciera replantear tu pertenencia a la cooperativa, podrías dar de baja tu contrato con nosotros, bien comunicándolo directamente, o mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día de finalización del contrato, con los precios vigentes en cada momento.</p>
<br>
<p>Un saludo cordial,<p>
<br>
<p> Equipo de Som Energia</p>
<p> <a href="https://www.somenergia.coop/es/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif

<p> ${text_legal}</p>
</body>
</html>