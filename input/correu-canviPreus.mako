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
            ("P1", 0.343),
            ("P2", 0.281),
            ("P3", 0.234),
        ],
        "gkwh": [
            ("P1", 0.170),
            ("P2", 0.120),
            ("P3", 0.095),
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
            ("P1", 0.342),
            ("P2", 0.312),
            ("P3", 0.279),
            ("P4", 0.256),
            ("P5", 0.234),
            ("P6", 0.224),
        ],
        "gkwh": [
            ("P1", 0.144),
            ("P2", 0.132),
            ("P3", 0.104),
            ("P4", 0.093),
            ("P5", 0.082),
            ("P6", 0.089),
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
            ("P1", 0.302),
            ("P2", 0.277),
            ("P3", 0.254),
            ("P4", 0.245),
            ("P5", 0.227),
            ("P6", 0.216),
        ],
        "gkwh": [
            ("P1", 0.104),
            ("P2", 0.095),
            ("P3", 0.077),
            ("P4", 0.071),
            ("P5", 0.062),
            ("P6", 0.068),
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
            ("P1", 0.427),
            ("P2", 0.38),
            ("P3", 0.316),
            ("P4", 0.278),
            ("P5", 0.238),
            ("P6", 0.227),
        ],
        "gkwh": [
            ("P1", 0.229),
            ("P2", 0.200),
            ("P3", 0.140),
            ("P4", 0.116),
            ("P5", 0.087),
            ("P6", 0.092),
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
            ("P1", 0.444),
            ("P2", 0.390),
            ("P3", 0.319),
            ("P4", 0.286),
            ("P5", 0.233),
            ("P6", 0.221),
        ],
        "gkwh": [
            ("P1", 0.246),
            ("P2", 0.209),
            ("P3", 0.141),
            ("P4", 0.112),
            ("P5", 0.068),
            ("P6", 0.073),
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

def calcularPreuTotal(consums, potencies, tarifa, preus, afegir_maj, bo_social_separat):
  maj_price = 0.140 #€/kWh
  bo_social_price = 14.035934
  types =  {
    'power': potencies or {},
    'energy': consums or {}
  }
  imports = 0
  for terme, values in types.items():
    for periode, quantity in values.items():
      preu_periode = dict(preus[tarifa][terme])[periode]
      if afegir_maj and terme == 'energy':
        preu_periode += maj_price
      imports += preu_periode * quantity
  if bo_social_separat:
    imports += bo_social_price

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

def calcularImpostos(preu, fiscal_position, potencies):
  iva = 0.21
  impost_electric = 0.005
  if all([potencia <= 10 for potencia in potencies.values()]):
    iva = 0.05
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
insular = "INSULAR" in object.polissa_id.llista_preu.name

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

afegir_maj = not insular
preu_vell = calcularPreuTotal(consums, potencies, tarifa, OLD_TARIFF_PRICES, afegir_maj, False)

preu_nou = calcularPreuTotal(consums, potencies, tarifa, NEW_TARIFF_PRICES, False, True)

preu_vell_imp_int = calcularImpostos(preu_vell, object.polissa_id.fiscal_position_id, potencies)
preu_nou_imp_int = calcularImpostos(preu_nou, object.polissa_id.fiscal_position_id, potencies)

increment_total = formatNumber(abs(preu_nou_imp_int - preu_vell_imp_int))
increment_mensual = abs((preu_nou_imp_int - preu_vell_imp_int) / 12)

preu_vell_imp = formatNumber(preu_vell_imp_int)
preu_nou_imp = formatNumber(preu_nou_imp_int)

impost_aplicat = 'IVA del 21'
if all([potencia <= 10 for potencia in potencies.values()]):
  impost_aplicat = 'IVA del 5'
if object.polissa_id.fiscal_position_id.id in [19, 33]:
  impost_aplicat = "IGIC del 3"
elif object.polissa_id.fiscal_position_id.id in [25, 34]:
  impost_aplicat = "IGIC del 0"

consum_total = formatNumber(round(consum_total/100.0)*100)
te_gkwh = object.polissa_id.te_assignacio_gkwh

try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, object.polissa_id.titular.vat):
    nom_titular = object.polissa_id.titular.name.split(',')[1].lstrip() + ','
  else:
    nom_titular = ''
except:
  nom_titular = ''
%>
<!doctype html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
<style>
    body{ font-family: 'Roboto Mono', Arial; font-size: 16px; text-align:'justify'}
    .margin_top{ margin-top: 2em; }
</style>
</head>
<body style="text-align: justify; font-family: 'Roboto Mono', Arial; font-size: 14px; line-height: 175%;" >
<div style="width:96%;max-width:1200px;margin:20px auto;">
Hola, ${nom_titular}
% if insular:
${correu_insular()}
% else:
${correu_peninsula()}
% endif
<br>
${text_legal}
</div>
</body>
</html>
<%def name="correu_peninsula()">
% if object.polissa_id.titular.lang == "ca_ES":
<p style="margin-top: 2em;">El dia 1 d&rsquo;octubre haurem de canviar les tarifes de Som Energia, per tal de repercutir-hi d&rsquo;una altra manera el cost del mecanisme d&rsquo;ajust del gas. Aix&ograve; suposar&agrave; que no podrem saber, amb antelaci&oacute;, els preus finals, que probablement seran m&eacute;s elevats que els actuals. Aquest nou sistema de tarifes &eacute;s temporal i en principi, segons el <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2022-7843">RDL 10/2022</a>, no s&rsquo;estendr&agrave; m&eacute;s enll&agrave; del 31 de maig de 2023.</p>
<p>A continuaci&oacute; pots trobar una explicaci&oacute; curta dels punts m&eacute;s importants, per si no pots o vols dedicar-hi gaire temps, i una explicaci&oacute; m&eacute;s detallada, per si vols tenir-ne m&eacute;s informaci&oacute;. Tot plegat ho trobar&agrave;s tamb&eacute; a <a href="https://blog.somenergia.coop/?p=43135">aquesta not&iacute;cia</a> del blog.</p>
<div style="background-color: #e1e7b7; padding: 1em;" style="margin-top: 2em;">
<p dir="ltr" style="font-size: 16px;"><strong>Explicaci&oacute; curta:</strong></p>
<p dir="ltr"><strong id="docs-internal-guid-25c64086-7fff-9fab-11ba-07ec2a7bba39"></strong>Com d&egrave;iem, a les nostres tarifes hem d&rsquo;aplicar el preu del mecanisme d&rsquo;ajust del gas, que no se sap amb antelaci&oacute;. Per aix&ograve;, <strong>no podrem saber els preus finals amb antelaci&oacute;</strong>. De tota manera:</p>
<ul>
% if tarifa == '2.0TD':
<li dir="ltr"><strong>Els tres per&iacute;odes horaris seguiran sent v&agrave;lids</strong>. El per&iacute;ode vall (nits, caps de setmana i festius estatals) seguir&agrave; sent el m&eacute;s econ&ograve;mic. Despr&eacute;s ve el per&iacute;ode pla (laborables de 8 a 10 h, de 14 a 18 h i de 22 a 00 h), durant el qual l&rsquo;energia no &eacute;s tan econ&ograve;mica. Finalment, ve el per&iacute;ode punta (de 10 a 14 h i de 18 a 22 h), que &eacute;s quan el preu de l&rsquo;energia ser&agrave; m&eacute;s elevat.</li>
% elif tarifa == '3.0TD' or tarifa == '6.1TD':
<li dir="ltr"><strong>Els sis per&iacute;odes horaris seguiran sent v&agrave;lids</strong>. Recorda que pots consultar les taules a <a href="https://ca.support.somenergia.coop/article/1107-horaris-i-periodes-de-la-tarifa-3-0td-i-les-tarifes-dalta-tensio-6-1td-6-2td-6-3td-i-6-4td">aquest article del nostre web</a>.</li>
% endif
<li dir="ltr" role="presentation"><strong>A la factura apareixer&agrave; una l&iacute;nia m&eacute;s</strong>, que detallar&agrave; el preu del mecanisme d&rsquo;ajust del gas. Aquest import dependr&agrave; de la quantitat d&rsquo;energia utilitzada: quanta m&eacute;s energia consumida, m&eacute;s elevat ser&agrave; aquest import.</li>
<li dir="ltr" role="presentation">A l&rsquo;<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">apartat web de tarifes</a> apareixeran els preus sense el mecanisme d&rsquo;ajust del gas aplicats, que no podem saber amb antelaci&oacute; (per tant, apareixeran uns preus inferiors als actuals).</li>
<li dir="ltr"><strong id="docs-internal-guid-92e7f074-7fff-8074-35a4-89cb62275999">La factura final acabar&agrave; sent, possiblement, m&eacute;s elevada</strong> del que &eacute;s actualment.</li>
</ul>
</div>
<br>
<div style="background-color: #eeeeee; padding: 1em;">
<p dir="ltr" style="font-size: 16px;"><strong>Explicaci&oacute; detallada:</strong></p>
<p dir="ltr">Fins ara, com que hav&iacute;em comprat gran part de l&rsquo;energia per a aquests mesos d&rsquo;estiu abans que el topall del gas fos aprovat per la Uni&oacute; Europea, pr&agrave;cticament no hav&iacute;em de pagar el mecanisme d&rsquo;ajust del gas. L&rsquo;energia que hem comprat pel darrer trimestre de l&rsquo;any ja &eacute;s amb les noves condicions, &eacute;s a dir, a un preu m&eacute;s baix, per&ograve; al qual cal afegir el cost del mecanisme d&rsquo;ajust del gas (MAG).</p>
<p dir="ltr">Als nostres preus, doncs, els haurem d&rsquo;afegir un concepte que &eacute;s el del MAG. Aquest cost, com que t&eacute; a veure amb el cost del gas de cada dia, no es pot con&egrave;ixer amb antelaci&oacute;. Per aix&ograve;, no podem saber els nostres preus finals amb antelaci&oacute;. S&iacute; que podem saber, per&ograve;, una part dels preus (la que no &eacute;s el MAG). &Eacute;s el que es pot veure a l&rsquo;<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">apartat de tarifes del web</a> i a la <a href="https://blog.somenergia.coop/?p=43135">not&iacute;cia</a> del blog, ho expliquem m&eacute;s avall.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Qu&egrave; apareixer&agrave; a la factura?</strong></p>
<p dir="ltr">A cada factura apareixer&agrave; una l&iacute;nia nova, corresponent al preu del mecanisme d&rsquo;ajust calculat per Som Energia. A aquesta l&iacute;nia es podr&agrave; veure el preu del mecanisme (&euro; per kWh), el consum total d&rsquo;energia del per&iacute;ode facturat (kWh), els dies del per&iacute;ode facturat, i l&rsquo;import final a pagar.</p>
<p dir="ltr">En els casos en qu&egrave; el MAG no s&rsquo;hagi d&rsquo;aplicar a tots els dies del per&iacute;ode facturat (per exemple, si la factura comen&ccedil;a a mitjans de setembre), a aquesta l&iacute;nia apareixeran les dades referents al per&iacute;ode d&rsquo;aplicaci&oacute; del MAG (des de l&rsquo;1 d&rsquo;octubre).</p>
% if tarifa == '2.0TD':
<p dir="ltr" style="margin-top: 2em;"><strong>Com calcularem el preu del MAG?</strong></p>
<p dir="ltr">Per a cada per&iacute;ode de facturaci&oacute; agafarem de refer&egrave;ncia el preu del mecanisme d&rsquo;ajust del gas que <a href="https://www.omie.es/es/market-results/daily/average-final-prices/hourly-price-consumers">publica di&agrave;riament OMIE</a> i en farem una mitjana, que ponderarem segons el consum energ&egrave;tic horari d&rsquo;una llar tipus (<a href="https://www.ree.es/es/clientes/consumidor/gestion-medidas-electricas/consulta-perfiles-de-consumo">calculat per Red El&eacute;ctrica de Espa&ntilde;a</a> segons la <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2021-21395">Resoluci&oacute; de 23/12/2021</a>). N&rsquo;obtindrem un preu, que multiplicarem pel consum total que hagi tingut el contracte en el per&iacute;ode facturat.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Qu&egrave; passar&agrave; amb els tres per&iacute;odes horaris?</strong></p>
<p dir="ltr">Els tres per&iacute;odes horaris (per&iacute;ode punta, pla i vall) seguiran sent v&agrave;lids. No sabrem amb antelaci&oacute; quin ser&agrave; el preu, per&ograve; s&iacute; que sabem que el per&iacute;ode vall seguir&agrave; sent el m&eacute;s econ&ograve;mic, el per&iacute;ode pla, l&rsquo;intermig, i el per&iacute;ode punta, el m&eacute;s car. Recorda que al nostre Centre d&rsquo;Ajuda <a href="https://ca.support.somenergia.coop/article/1003-la-tarifa-2-0td">pots trobar uns rellotgets</a> per poder identificar visualment els tres per&iacute;odes.</p>
% elif tarifa == '3.0TD' or tarifa == '6.1TD':
<p dir="ltr" style="margin-top: 2em;"><strong>Com calcularem el preu del MAG?</strong></p>
<p dir="ltr">Per a cada per&iacute;ode de facturaci&oacute; agafarem de refer&egrave;ncia el preu del mecanisme d&rsquo;ajust del gas que <a href="https://www.omie.es/es/market-results/daily/average-final-prices/hourly-price-consumers">publica di&agrave;riament OMIE</a> i en farem una mitjana, que ponderarem segons el consum energ&egrave;tic horari d&rsquo;un contracte tipus de la teva tarifa (<a href="https://www.ree.es/es/clientes/consumidor/gestion-medidas-electricas/consulta-perfiles-de-consumo">calculat per Red El&eacute;ctrica de Espa&ntilde;a</a> segons la <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2021-21395">Resoluci&oacute; de 23/12/2021</a>). N&rsquo;obtindrem un preu, que multiplicarem pel consum total que hagi tingut el contracte en el per&iacute;ode facturat.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Qu&egrave; passar&agrave; amb els per&iacute;odes horaris?</strong></p>
<p dir="ltr">Els sis per&iacute;odes horaris (P1, P2, P3, P4, P5 i P6) seguiran sent v&agrave;lids. No sabrem amb antelaci&oacute; quin ser&agrave; el preu, per&ograve; s&iacute; que sabem que el per&iacute;ode 6 seguir&agrave; sent el m&eacute;s econ&ograve;mic, i el per&iacute;ode 1, el m&eacute;s car. Recorda que <a href="https://ca.support.somenergia.coop/article/1107-horaris-i-periodes-de-la-tarifa-3-0td-i-les-tarifes-dalta-tensio-6-1td-6-2td-6-3td-i-6-4td">al nostre Centre d&rsquo;Ajuda</a> pots trobar les taules de la distribuci&oacute; hor&agrave;ria dels diferents per&iacute;odes segons regi&oacute; (Pen&iacute;nsula, Balears i Can&agrave;ries).</p>
% endif
</div>
<p dir="ltr" style="margin-top: 2em;">Per tal de resoldre dubtes i poder explicar amb detall aquest canvi, hem organitzat una <strong>sessió informativa virtual</strong> per al dijous 15 de setembre a les 18 h, amb la participació del Consell Rector i l’Equip Tècnic de Som Energia. Es podrà seguir a través del <a href="https://www.youtube.com/c/somenergia">canal de Youtube de Som Energia</a> i qui vulgui participar a la sessió a través de zoom, s'haurà d'<a href="https://docs.google.com/forms/d/e/1FAIpQLSd0rUT4TGWyanp1CaZk3G8xg6Ixvv5-IZUBNwVC6miqRgt2jQ/viewform">inscriure a aquest formulari</a>.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Quin preu final pots esperar a la factura?</strong></p>
<p dir="ltr">Com que no se sap quin ser&agrave; el preu del mecanisme d&rsquo;ajust del gas, no podem saber del cert si el total de la factura ser&agrave; major o menor que l&rsquo;actual. De tota manera, l&rsquo;evoluci&oacute; del mercat energ&egrave;tic i la pol&iacute;tica internacional indiquen que, possiblement, les factures acabaran sent majors que actualment. Cal tenir en compte que, si no hi hagu&eacute;s l&rsquo;excepci&oacute; ib&egrave;rica i el mecanisme d&rsquo;ajust del gas, els preus que haur&iacute;em de pagar serien molt superiors. Aquest mecanisme ens ajuda, tant a comercialitzadores com a persones usu&agrave;ries, a no haver de pagar un import que faria pujar les factures for&ccedil;a m&eacute;s.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Actualitzaci&oacute; dels preus del web </strong></p>
<p dir="ltr">Els nous preus que mostrem a <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">l&rsquo;apartat de tarifes del web</a> i a les condicions particulars no inclouen el MAG (perqu&egrave; el MAG no el podem saber amb antelaci&oacute;). Tot i aix&ograve;, recordeu que a les factures s&rsquo;hi afegir&agrave; el preu del MAG que correspongui en cada ocasi&oacute;.</p>
% if te_gkwh:
<p dir="ltr" style="margin-top: 2em;"><strong>La tarifa Generation kWh</strong></p>
<p dir="ltr">El mecanisme d&rsquo;ajust del gas no aplica a la tarifa Generation kWh, per aix&ograve;, a aquesta tarifa no se li sumar&agrave; l&rsquo;afegit del MAG. En la revisi&oacute; de preus, per&ograve;, s&iacute; que hem modificat aquesta tarifa per actualitzar alguns conceptes que havien variat.</p>
% endif
<p dir="ltr" style="margin-top: 2em;"><strong>Per qu&egrave; el MAG que apliquem &eacute;s variable?</strong></p>
<p dir="ltr">El preu del mecanisme d&rsquo;ajust del gas que marca OMIE (i que hem de pagar com a comercialitzadora) varia molt. Des de Som Energia podr&iacute;em haver fet una estimaci&oacute; del preu fins a final d&rsquo;any per poder mantenir les tarifes fixes, per&ograve; com que el preu del gas pot variar tant, seria probable trobar-nos en una situaci&oacute; en qu&egrave; o b&eacute; les persones i entitats s&ograve;cies haurien hagut de pagar un preu for&ccedil;a superior al que finalment ser&agrave; (fent que paguessin m&eacute;s del necessari), o b&eacute; for&ccedil;a inferior (posant en perill la viabilitat de la cooperativa). Per aix&ograve;, per tal que el que pagueu les persones que teniu contracte amb Som Energia sigui el m&eacute;s ajustat possible a la realitat, actualitzarem el MAG a les factures segons el que hagi costat realment a cada per&iacute;ode.</p>
<p dir="ltr">Si vols saber m&eacute;s detalls sobre el mecanisme del gas i el seu funcionament, pots consultar <a href="https://ca.support.somenergia.coop/article/1251-mecanisme-dajust-del-gas">aquest article</a> del nostre Centre d&rsquo;Ajuda.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Comparativa estimada&nbsp;</strong></p>
<p dir="ltr">La normativa estableix que hem d&rsquo;incloure, junt amb la informaci&oacute; de noves tarifes, una estimaci&oacute; del cost anual que cada contracte hauria de pagar amb els nous preus i una comparaci&oacute; amb el total anual si no modifiqu&eacute;ssim les tarifes. A continuaci&oacute; incloem aquesta estimaci&oacute;, per&ograve; <strong>t&rsquo;alertem que el resultat no &eacute;s fiable</strong>, doncs estem comparant uns preus fixos (els que hi havia fins ara) amb uns preus que inclouen un terme variable que no podem con&egrave;ixer amb antelaci&oacute;. Aquesta comparaci&oacute;, doncs, <strong>no pot servir de guia</strong> per calcular quin total anual haur&agrave; de pagar cada contracte. Aix&iacute; doncs,&nbsp;
% if quintextes == 'casA':
tal com estableix la normativa, hem fet una estimaci&oacute; orientativa, a partir de les dades que tenim del teu hist&ograve;ric recent d&rsquo;&uacute;s d&rsquo;electricitat (aproximadament ${consum_total} kWh anuals), aplicant el preu del MAG de les &uacute;ltimes setmanes com si fos igual durant tot l&rsquo;any, i prenent com a refer&egrave;ncia el repartiment horari d&rsquo;un contracte est&agrave;ndard, sense autoproducci&oacute; ni Generation kWh. Segons aquestes dades, l&rsquo;actualitzaci&oacute; dels nous preus podria suposar un augment aproximat de ${increment_total} euros anuals a la factura respecte al que costaria si mantingu&eacute;ssim els preus actuals durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb el nou sistema de preus, i un cost anual aproximat de ${preu_vell_imp} euros sense actualitzar-ho. En els dos casos l&rsquo;estimaci&oacute; inclou l'${impost_aplicat}% i l&rsquo;impost el&egrave;ctric del 5,11%, &eacute;s a dir, impostos sense les rebaixes vigents. Tingues en compte que aix&ograve; s&oacute;n estimacions, i que els imports finals <strong>no els podem saber, doncs dependran molt de circumst&agrave;ncies i preus que no podem preveure</strong>, com per exemple el preu del gas.</p>
% elif quintextes == 'casB':
tal com estableix la normativa, hem fet una estimaci&oacute; de car&agrave;cter orientatiu, en funci&oacute; de la pot&egrave;ncia contractada que tens i l&rsquo;&uacute;s d&rsquo;electricitat que sol haver-hi amb aquestes pot&egrave;ncies, aplicant el preu del MAG de les &uacute;ltimes setmanes com si fos igual durant tot l&rsquo;any, i agafant de refer&egrave;ncia un contracte est&agrave;ndard, sense autoproducci&oacute; ni Generation kWh. Segons aquestes dades, l&rsquo;actualitzaci&oacute; de preus podria suposar un augment aproximat de ${increment_total} euros anuals a la factura respecte al que costaria si mantingu&eacute;ssim els preus actuals durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb l&rsquo;actualitzaci&oacute;, i un cost anual aproximat de ${preu_vell_imp} euros sense l&rsquo;actualitzaci&oacute;. En els dos casos l&rsquo;estimaci&oacute; inclou l'${impost_aplicat}% i l&rsquo;impost el&egrave;ctric del 5,11%, &eacute;s a dir, impostos sense les rebaixes vigents. Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades, i que els imports finals <strong>no els podem saber, doncs dependran molt de circumst&agrave;ncies i preus que no podem preveure</strong>, com per exemple el preu del gas.</p>
% elif quintextes == 'casC':
tal com estableix la normativa, hem fet una estimaci&oacute; de car&agrave;cter orientatiu, a partir de les dades que tenim del teu hist&ograve;ric recent d&rsquo;&uacute;s d&rsquo;electricitat (aproximadament ${consum_total} kWh anuals), aplicant el preu del MAG de les &uacute;ltimes setmanes com si fos igual durant tot l&rsquo;any, i sense tenir en compte l&rsquo;autoproducci&oacute; ni el Generation kWh. Segons aquesta estimaci&oacute;, l&rsquo;actualitzaci&oacute; de les tarifes podria suposar un augment aproximat de ${increment_total} euros anuals a la factura respecte al que costaria si mantingu&eacute;ssim els preus actuals durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb l&rsquo;actualitzaci&oacute;, i un cost anual aproximat de ${preu_vell_imp} euros sense actualitzar tarifes. En els dos casos l&rsquo;estimaci&oacute; inclou l'${impost_aplicat}% i l&rsquo;impost el&egrave;ctric del 5,11%, &eacute;s a dir, impostos sense rebaixes del govern. Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades, i que els imports finals <strong>no els podem saber, doncs dependran de circumst&agrave;ncies i preus que no podem preveure</strong>, com per exemple el preu del gas.</p>
% endif
<br>
<p dir="ltr">T&rsquo;adjuntem en aquest correu el teu contracte actualitzat. Hi trobar&agrave;s, per una banda, els preus vigents fins al 30 de setembre. Per altra banda, tamb&eacute; trobar&agrave;s els nous preus que aplicarem a partir de l&rsquo;1 d&rsquo;octubre (que no inclouen la part del mecanisme d&rsquo;ajust del gas), aix&iacute; com el detall de la manera com calcularem la part corresponent al MAG. Com et coment&agrave;vem, aquest canvi es comen&ccedil;ar&agrave; a aplicar el dia 1 d&rsquo;octubre de 2022. Si hi est&agrave;s d&rsquo;acord, <strong>no cal que responguis aquest correu</strong> ni que ens retornis el document signat, ja que l'actualitzaci&oacute; de les nostres tarifes s'aplicar&agrave; autom&agrave;ticament. Si lamentablement aquest canvi et fes replantejar la teva pertinen&ccedil;a a la cooperativa, podries donar de baixa el teu contracte amb nosaltres, b&eacute; comunicant-nos-ho directament, o b&eacute; mitjan&ccedil;ant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni cl&agrave;usules de perman&egrave;ncia en cap moment. Aix&iacute; doncs, si decidissis marxar, nom&eacute;s et facturar&iacute;em el consum realitzat fins al dia de finalitzaci&oacute; del contracte, amb els preus vigents a cada moment.<strong><br></strong></p>
<p dir="ltr" style="margin-top: 2em;"><strong>Aclariment legal</strong></p>
<p dir="ltr">El mecanisme d&rsquo;ajust del gas l&rsquo;aplicarem a la part del preu que es preveu a la cl&agrave;usula 5.3 (ii) de les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/">Condicions Generals</a> del contracte de subministrament.</p>
<br>
<p dir="ltr">Una salutaci&oacute; cordial,<br>
Equip de Som Energia<br>
<a href="https://somenergia.coop/ca">www.somenergia.coop</a></p>
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<p dir="ltr" style="margin-top: 2em;">El d&iacute;a 1 de octubre tendremos que cambiar las tarifas de Som Energia, para repercutir de otra manera el coste del mecanismo de ajuste del gas. Esto supondr&aacute; que no podremos saber con antelaci&oacute;n los precios finales, que probablemente ser&aacute;n m&aacute;s elevados que los actuales. Este nuevo sistema de tarifas es temporal y en principio, seg&uacute;n el <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2022-7843">RDL 10/2022</a>, no se extender&aacute; m&aacute;s all&aacute; del 31 de mayo de 2023.</p>
<p dir="ltr">A continuaci&oacute;n puedes encontrar una explicaci&oacute;n corta de los puntos m&aacute;s importantes, por si no puedes o no quieres dedicarle mucho tiempo, y una explicaci&oacute;n m&aacute;s detallada, por si prefieres tener m&aacute;s informaci&oacute;n. Todo ello lo encontrar&aacute;s tambi&eacute;n en <a href="https://blog.somenergia.coop/?p=43137">esta noticia</a> del blog.</p>
<div style="background-color: #e1e7b7; padding: 1em;" style="margin-top: 2em;">
<p dir="ltr" style="font-size: 16px;"><strong>Explicaci&oacute;n corta:</strong></p>
<p dir="ltr">Como dec&iacute;amos, en nuestras tarifas debemos aplicar el precio del mecanismo de ajuste del gas, que no se conoce con antelaci&oacute;n. Por eso, <strong>no podremos saber los precios finales con antelaci&oacute;n</strong>. De todas formas:</p>
<ul>
% if tarifa == '2.0TD':
<li dir="ltr" role="presentation"><strong>Los tres periodos horarios seguir&aacute;n siendo v&aacute;lidos</strong>. El periodo valle (noches, fines de semana y festivos estatales) seguir&aacute; siendo el m&aacute;s econ&oacute;mico. Luego viene el periodo llano (laborables de 8 a 10 h, de 14 a 18 y de 22 a 00 h), durante el cual la energ&iacute;a no es tan econ&oacute;mica. Finalmente, viene el periodo punta (de 10 a 14 y de 18 a 22 h), que es cuando el precio de la energ&iacute;a ser&aacute; m&aacute;s elevado.</li>
% elif tarifa == '3.0TD' or tarifa == '6.1TD':
<li dir="ltr" role="presentation"><strong>Los seis per&iacute;odos horarios seguir&aacute;n siendo v&aacute;lidos</strong>. Recuerda que puedes consultarlos en <a href="https://es.support.somenergia.coop/article/1108-horarios-y-periodos-de-la-tarifa-3-0td-y-las-tarifas-de-alta-tension-6-1td-6-2td-6-3td-y-6-4td">este art&iacute;culo de nuestra web</a>.</li>
% endif
<li dir="ltr" role="presentation"><strong>En la factura aparecer&aacute; una l&iacute;nea m&aacute;s</strong>, que detallar&aacute; el precio del mecanismo de ajuste del gas. Este importe depender&aacute; de la cantidad de energ&iacute;a utilizada: cuanta m&aacute;s energ&iacute;a consumida, mayor ser&aacute; este importe.</li>
<li dir="ltr" role="presentation">En el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">apartado web de tarifas</a> aparecer&aacute;n los precios sin el mecanismo de ajuste del gas aplicados, que no podemos saber con antelaci&oacute;n (por tanto, aparecer&aacute;n unos precios inferiores a los actuales).</li>
<li dir="ltr" role="presentation"><strong>La factura final acabar&aacute; siendo, posiblemente, m&aacute;s elevada </strong>de lo que es actualmente.</li>
</ul>
</div>
<br>
<div style="background-color: #eeeeee; padding: 1em;">
<p dir="ltr" style="font-size: 16px;"><strong>Explicaci&oacute;n detallada:</strong></p>
<p dir="ltr">Hasta ahora, como hab&iacute;amos comprado gran parte de la energ&iacute;a para estos meses de verano antes de que el tope del gas fuera aprobado por la Uni&oacute;n Europea, pr&aacute;cticamente no ten&iacute;amos que pagar el mecanismo de ajuste del gas. La energ&iacute;a que hemos comprado para el &uacute;ltimo trimestre del a&ntilde;o ya es con las nuevas condiciones, es decir, a un precio m&aacute;s bajo, pero al que hay que a&ntilde;adir el coste del mecanismo de ajuste del gas (MAG).&nbsp;</p>
<p dir="ltr">A nuestros precios, pues, deberemos a&ntilde;adirles un concepto que es el del MAG. Este coste, al tener que ver con el coste del gas de cada d&iacute;a, no se puede conocer con antelaci&oacute;n. Por eso, no podemos saber nuestros precios finales con antelaci&oacute;n. Sin embargo, s&iacute; podemos saber una parte de los precios (la que no es el MAG). Es lo que se puede ver en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">apartado de tarifas de la web</a> y en <a href="https://blog.somenergia.coop/?p=43137">la noticia</a> del blog, lo explicamos m&aacute;s abajo.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;Qu&eacute; aparecer&aacute; en la factura?</strong></p>
<p dir="ltr">En cada factura aparecer&aacute; una l&iacute;nea nueva, correspondiente al precio del mecanismo de ajuste calculado por Som Energia. En esta l&iacute;nea se podr&aacute; ver el precio del mecanismo (&euro; por kWh), el consumo total de energ&iacute;a del periodo facturado (kWh), los d&iacute;as del periodo facturado, y el importe final a pagar.&nbsp;</p>
<p dir="ltr">En los casos en los que el MAG no deba aplicarse a todos los d&iacute;as del periodo facturado (por ejemplo, si la factura comienza a mediados de septiembre), en esta l&iacute;nea aparecer&aacute;n los datos referentes al periodo de aplicaci&oacute;n del MAG (desde el 1 de octubre).<strong><br></strong></p>
% if tarifa == '2.0TD':
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;C&oacute;mo calcularemos el precio del MAG?</strong></p>
<p dir="ltr">Para cada periodo de facturaci&oacute;n tomaremos de referencia el precio del mecanismo de ajuste del gas que <a href="https://www.omie.es/es/market-results/daily/average-final-prices/hourly-price-consumers">publica diariamente OMIE</a> y haremos una media, que ponderaremos seg&uacute;n el consumo energ&eacute;tico horario de un hogar tipo (<a href="https://www.ree.es/es/clientes/consumidor/gestion-medidas-electricas/consulta-perfiles-de-consumo">calculado por Red El&eacute;ctrica de Espa&ntilde;a</a> seg&uacute;n la <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2021-21395">Resoluci&oacute;n de 23/12/2021</a>). Obtendremos un precio, que multiplicaremos por el consumo total que haya tenido el contrato en el periodo facturado.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;Qu&eacute; pasar&aacute; con los tres periodos horarios?</strong></p>
<p dir="ltr">Los tres periodos horarios (periodo punta, llano y valle) seguir&aacute;n siendo v&aacute;lidos. No sabremos con antelaci&oacute;n cu&aacute;l ser&aacute; el precio, pero s&iacute; sabemos que el periodo valle seguir&aacute; siendo el m&aacute;s econ&oacute;mico, el periodo llano, el intermedio, y el periodo punta, el m&aacute;s caro. Recuerda que en nuestro Centro de Ayuda <a href="https://es.support.somenergia.coop/article/1004-la-tarifa-2-0td">puedes encontrar unas im&aacute;genes</a> para poder identificar visualmente los tres periodos.</p>
% elif tarifa == '3.0TD' or tarifa == '6.1TD':
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;C&oacute;mo calcularemos el precio del MAG?</strong></p>
<p dir="ltr">Para cada periodo de facturaci&oacute;n tomaremos de referencia el precio del mecanismo de ajuste del gas que <a href="https://www.omie.es/es/market-results/daily/average-final-prices/hourly-price-consumers">publica diariamente OMIE</a> y haremos una media, que ponderaremos seg&uacute;n el consumo energ&eacute;tico horario de un contrato tipo de tu tarifa (<a href="https://www.ree.es/es/clientes/consumidor/gestion-medidas-electricas/consulta-perfiles-de-consumo">calculado por Red El&eacute;ctrica de Espa&ntilde;a</a> seg&uacute;n la <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2021-21395">Resoluci&oacute;n de 23/12/2021</a>). Obtendremos un precio, que multiplicaremos por el consumo total que haya tenido el contrato en el periodo facturado.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;Qu&eacute; pasar&aacute; con los periodos horarios?</strong></p>
<p dir="ltr">Los seis periodos horarios (P1, P2, P3, P4, P5 y P6) seguir&aacute;n siendo v&aacute;lidos. No sabremos con antelaci&oacute;n cu&aacute;l ser&aacute; el precio, pero s&iacute; sabemos que el periodo 6 seguir&aacute; siendo el m&aacute;s econ&oacute;mico, y el per&iacute;odo 1, el m&aacute;s caro. Recuerda que <a href="https://es.support.somenergia.coop/article/1108-horarios-y-periodos-de-la-tarifa-3-0td-y-las-tarifas-de-alta-tension-6-1td-6-2td-6-3td-y-6-4td">en nuestro Centro de Ayuda</a> puedes encontrar las tablas de la distribuci&oacute;n horaria de los diferentes periodos seg&uacute;n regi&oacute;n (Pen&iacute;nsula, Baleares y Canarias).</p>
% endif
</div>
<p dir="ltr" style="margin-top: 2em;">Para resolver dudas y poder explicar con detalle este cambio, hemos organizado una <strong>sesión informativa virtual</strong> para el jueves 15 de septiembre a las 18 h, con la participación del Consejo Rector y el Equipo Técnico de Som Energia. Se podrá seguir a través del <a href="https://www.youtube.com/c/somenergia">canal de YouTube de Som Energia</a> y quien quiera participar a la sesión a través de zoom, se tendrá que <a href="https://docs.google.com/forms/d/e/1FAIpQLSexsN3dyVCQYGuSRFvaEymmAB4SJIBrG4R1vRxkn6UyZsmIgQ/viewform">inscribir a este formulario</a>.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;Qu&eacute; precio final puedes esperar en la factura?</strong></p>
<p dir="ltr">Como no se sabe cu&aacute;l ser&aacute; el precio del mecanismo de ajuste del gas, no podemos saber a ciencia cierta si el total de la factura ser&aacute; mayor o menor que el actual. Sin embargo, la evoluci&oacute;n del mercado energ&eacute;tico y la pol&iacute;tica internacional indican que, posiblemente, las facturas acabar&aacute;n siendo mayores que actualmente. Hay que tener en cuenta que, si no hubiera la excepci&oacute;n ib&eacute;rica y el mecanismo de ajuste del gas, los precios que tendr&iacute;amos que pagar ser&iacute;an muy superiores. Este mecanismo nos ayuda, tanto a comercializadoras como a personas usuarias, a no tener que pagar un importe que har&iacute;a subir las facturas bastante m&aacute;s.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Actualizaci&oacute;n de los precios de la web</strong></p>
<p dir="ltr">Los nuevos precios que mostramos en <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">el apartado de tarifas de la web</a> y en las condiciones particulares no incluyen el MAG (porque el MAG no podemos saberlo con antelaci&oacute;n). Sin embargo, recuerda que en las facturas se a&ntilde;adir&aacute; el precio del MAG que corresponda en cada ocasi&oacute;n.</p>
% if te_gkwh:
<p dir="ltr" style="margin-top: 2em;"><strong>La tarifa Generation kWh</strong></p>
<p dir="ltr">El mecanismo de ajuste del gas no aplica a la tarifa Generation kWh, por eso, a esta tarifa no se le sumar&aacute; el a&ntilde;adido del MAG. Sin embargo, en la revisi&oacute;n de precios s&iacute; hemos modificado esta tarifa para actualizar algunos conceptos que hab&iacute;an variado.</p>
% endif
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;Por qu&eacute; el MAG que aplicamos es variable?&nbsp;</strong></p>
<p dir="ltr">El precio del mecanismo de ajuste del gas que marca OMIE (y que debemos pagar como comercializadora) var&iacute;a mucho. Desde Som Energia podr&iacute;amos haber hecho una estimaci&oacute;n del precio hasta final de a&ntilde;o para poder mantener las tarifas fijas, pero como el precio del gas puede variar tanto, ser&iacute;a probable encontrarnos en una situaci&oacute;n en la que o bien las personas y entidades socias habr&iacute;an tenido que pagar un precio bastante superior al que finalmente ser&aacute; (haciendo que pagaran m&aacute;s de lo necesario), o bastante inferior (poniendo en peligro la viabilidad de la cooperativa). Por eso, para que lo que pagu&eacute;is las personas que ten&eacute;is contrato con Som Energia sea lo m&aacute;s ajustado posible a la realidad, actualizaremos el MAG en las facturas seg&uacute;n lo que haya costado realmente en cada periodo.</p>
<p dir="ltr">Si quieres saber m&aacute;s sobre el mecanismo de ajuste del gas y su funcionamiento, puedes consultar <a href="https://es.support.somenergia.coop/article/1252-mecanismo-de-ajuste-del-gas">este art&iacute;culo</a> de nuestro Centro de Ayuda.<strong><br></strong></p>
<p dir="ltr" style="margin-top: 2em;"><strong>Comparativa estimada&nbsp;</strong></p>
<p dir="ltr">La normativa establece que debemos incluir, junto con la informaci&oacute;n de nuevas tarifas, una estimaci&oacute;n del coste anual que cada contrato deber&iacute;a pagar con los nuevos precios y una comparaci&oacute;n con el total anual si no modific&aacute;ramos las tarifas. A continuaci&oacute;n incluimos esta estimaci&oacute;n, pero<strong> te alertamos de que el resultado no es fiable</strong>, pues estamos comparando unos precios fijos (los que hab&iacute;a hasta ahora) con unos precios que incluyen un t&eacute;rmino variable que no podemos conocer con antelaci&oacute;n. Esta comparaci&oacute;n, pues, <strong>no puede servir de gu&iacute;a </strong>para calcular qu&eacute; total anual tendr&aacute; que pagar cada contrato. As&iacute; pues,&nbsp;
% if quintextes == 'casA':
tal y como establece la normativa, hemos hecho una estimaci&oacute;n orientativa, a partir de los datos que tenemos de tu hist&oacute;rico reciente de uso de electricidad (aproximadamente ${consum_total} kWh anuales), aplicando el precio del MAG de las &uacute;ltimas semanas como si fuese igual durante todo el a&ntilde;o, y tomando como referencia el reparto horario de un contrato est&aacute;ndar, sin autoproducci&oacute;n ni Generation kWh. Seg&uacute;n estos datos, la actualizaci&oacute;n de los nuevos precios podr&iacute;a suponer un aumento aproximado de ${increment_total} euros anuales en la factura respecto a lo que costar&iacute;a si mantuvi&eacute;semos los precios actuales durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de ${preu_nou_imp} euros con el nuevo sistema de precios, y un coste anual aproximado de ${preu_vell_imp} euros sin actualizarlo. En ambos casos la estimaci&oacute;n incluye el ${impost_aplicat}% y el impuesto el&eacute;ctrico del 5,11%, es decir, impuestos sin las rebajas vigentes. Ten en cuenta que esto son estimaciones, y que los importes finales <strong>no los podemos saber, pues depender&aacute;n mucho de circunstancias y precios que no podemos prever</strong>, como por ejemplo el precio del gas.</p>
% elif quintextes == 'casB':
tal y como establece la normativa, hemos hecho una estimaci&oacute;n de car&aacute;cter orientativo, en funci&oacute;n de la potencia contratada que tienes y el uso de electricidad que suele haber con estas potencias, aplicando el precio del MAG de las &uacute;ltimas semanas como si fuera igual durante todo el a&ntilde;o, y cogiendo de referencia un contrato est&aacute;ndar, sin autoproducci&oacute;n ni Generation kWh. Seg&uacute;n estos datos, la actualizaci&oacute;n de precios podr&iacute;a suponer un aumento aproximado de ${increment_total} euros anuales en la factura respecto a lo que costar&iacute;a si mantuvi&eacute;semos los precios actuales durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de ${preu_nou_imp} euros con la actualizaci&oacute;n, y un coste anual aproximado de ${preu_vell_imp} euros sin la actualizaci&oacute;n. En ambos casos la estimaci&oacute;n incluye el ${impost_aplicat}% y el impuesto el&eacute;ctrico del 5,11%, es decir, impuestos sin las rebajas vigentes. Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>no los podemos saber, pues depender&aacute;n mucho de circunstancias y precios que no podemos prever</strong>, como por ejemplo el precio del gas.</p>
% elif quintextes == 'casC':
tal y como establece la normativa, hemos hecho una estimaci&oacute;n de car&aacute;cter orientativo, a partir de los datos que tenemos de tu hist&oacute;rico reciente de uso de electricidad (aproximadamente ${consum_total} kWh anuales), aplicando el precio del MAG de las &uacute;ltimas semanas como si fuese igual durante todo el a&ntilde;o, y sin tener en cuenta la autoproducci&oacute;n ni el Generation kWh. Seg&uacute;n esta estimaci&oacute;n, la actualizaci&oacute;n de las tarifas podr&iacute;a suponer un aumento aproximado de ${increment_total} euros anuales en la factura respecto a lo que costar&iacute;a si mantuvi&eacute;semos los precios actuales durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de ${preu_nou_imp} euros con la actualizaci&oacute;n, y un coste anual aproximado de ${preu_vell_imp} euros sin actualizar tarifas. En ambos casos la estimaci&oacute;n incluye el ${impost_aplicat}% y el impuesto el&eacute;ctrico del 5,11%, es decir, impuestos sin rebajas del gobierno. Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>no los podemos saber, pues depender&aacute;n de circunstancias y precios que no podemos prever</strong>, como por ejemplo el precio del gas.</p>
% endif
<br>
<p dir="ltr">Te adjuntamos en este correo tu contrato actualizado. Encontrar&aacute;s, por un lado, los precios vigentes hasta el 30 de septiembre. Por otra parte, tambi&eacute;n encontrar&aacute;s los nuevos precios que aplicaremos a partir del 1 de octubre (que no incluyen la parte del mecanismo de ajuste del gas), as&iacute; como el detalle de la forma en que calcularemos la parte correspondiente al MAG. Como te coment&aacute;bamos, este cambio se empezar&aacute; a aplicar el d&iacute;a 1 de octubre de 2022. Si est&aacute;s de acuerdo, <strong>no es necesario que respondas a este correo</strong> ni que nos devuelvas el documento firmado, ya que la actualizaci&oacute;n de nuestras tarifas se aplicar&aacute; autom&aacute;ticamente. Si lamentablemente este cambio te hiciera replantear tu pertenencia a la cooperativa, podr&iacute;as dar de baja tu contrato con Som Energia, bien comunic&aacute;ndonoslo directamente, o mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cl&aacute;usulas de permanencia en ning&uacute;n momento. As&iacute; pues, si decidieras marcharte, s&oacute;lo te facturar&iacute;amos el consumo realizado hasta el d&iacute;a de finalizaci&oacute;n del contrato, con los precios vigentes en cada momento.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Aclaraci&oacute;n legal</strong></p>
<p dir="ltr">El mecanismo de ajuste del gas lo aplicaremos en la parte del precio previsto en la cl&aacute;usula 5.3 (ii) de las <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/">Condiciones Generales</a> del contrato de suministro.</p>
<br>
<p dir="ltr">Un saludo cordial,<br>
Equipo de Som Energia<br>
<a href="https://www.somenergia.coop/es/">www.somenergia.coop</a></p>
% endif
</%def>
<%def name="correu_insular()">
% if object.polissa_id.titular.lang == "ca_ES":
<p dir="ltr" style="margin-top: 2em;">El dia 1 d&rsquo;octubre haurem de canviar les tarifes de Som Energia, per tal de repercutir-hi el cost del mecanisme d&rsquo;ajust del gas. Aquest nou sistema de tarifes &eacute;s temporal i en principi, segons el <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2022-7843">RDL 10/2022</a>, no s&rsquo;estendr&agrave; m&eacute;s enll&agrave; del 31 de maig de 2023.</p>
<p dir="ltr">Les Illes Balears i Can&agrave;ries no es regeixen pel mateix mercat el&egrave;ctric que la resta de l&rsquo;estat espanyol. La normativa estableix que, en aquest cas, el mecanisme d&rsquo;ajust del gas no aplica per als territoris insulars. Aix&iacute; doncs, com que des de Som Energia no hem de pagar el mecanisme d&rsquo;ajust del gas per a l&rsquo;energia que comercialitzem a les Illes Balears i Can&agrave;ries, tampoc aplicarem aquest preu a les tarifes corresponents.</p>
<p dir="ltr">Aix&iacute; doncs, per a aquests contractes (entre ells, el teu), l&rsquo;actualitzaci&oacute; de tarifes ser&agrave; a la baixa. Pots veure els preus finals a l&rsquo;<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">apartat de tarifes del web</a>. Si vols fer-ne comparacions, pots accedir a l&rsquo;<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">hist&ograve;ric de tarifes</a>, per&ograve; tingues en compte que els nous preus no tenen incl&ograve;s el mecanisme d&rsquo;ajust del gas (que s&iacute; que s&rsquo;aplica als contractes de la pen&iacute;nsula).</p>
<p dir="ltr">Si tens curiositat o vols saber m&eacute;s detalls de l&rsquo;afectaci&oacute; del mecanisme a la resta de contractes, pots llegir <a href="https://blog.somenergia.coop/?p=43135">aquesta not&iacute;cia</a> del blog.</p>
<p dir="ltr" style="margin-top: 2em;"><strong>Estimaci&oacute;</strong></p>
% if quintextes == 'casA':
<p dir="ltr">Tal com estableix la normativa, hem fet una estimaci&oacute; orientativa, a partir de les dades que tenim del teu hist&ograve;ric recent d&rsquo;&uacute;s d&rsquo;electricitat (aproximadament ${consum_total} kWh anuals) i prenent com a refer&egrave;ncia el repartiment horari d&rsquo;un contracte est&agrave;ndard, sense autoproducci&oacute; ni Generation kWh. Segons aquestes dades, l&rsquo;actualitzaci&oacute; dels nous preus podria suposar una disminuci&oacute; aproximada de ${increment_total} euros anuals a la factura respecte al que costaria si mantingu&eacute;ssim els preus actuals durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense actualitzar els preus. En els dos casos l&rsquo;estimaci&oacute; inclou l'${impost_aplicat}% i l&rsquo;impost el&egrave;ctric del 5,11%, &eacute;s a dir, impostos sense les rebaixes vigents.</p>
<p dir="ltr">Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades, i que els imports finals <strong>dependran de circumst&agrave;ncies</strong> que no podem preveure, com per exemple els horaris i l&rsquo;&uacute;s d&rsquo;energia que finalment facis, altres variacions de preus durant el 2022, o canvis que pugui haver al mercat el&egrave;ctric.</p>
% elif quintextes == 'casB':
<p dir="ltr">Tal com estableix la normativa, hem fet una estimaci&oacute; de car&agrave;cter orientatiu, en funci&oacute; de la pot&egrave;ncia contractada que tens i l&rsquo;&uacute;s d&rsquo;electricitat que sol haver-hi amb aquestes pot&egrave;ncies, agafant de refer&egrave;ncia un contracte est&agrave;ndard, sense autoproducci&oacute; ni Generation kWh. Segons aquestes dades, l&rsquo;actualitzaci&oacute; de preus podria suposar una disminuci&oacute; aproximada de ${increment_total} euros anuals a la factura respecte al que costaria sense aplicar-hi els nous preus (&eacute;s a dir, si mantingu&eacute;ssim els preus actuals durant tot l&rsquo;any). Aix&iacute; doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense aplicar el canvi de preus. En els dos casos l&rsquo;estimaci&oacute; inclou l'${impost_aplicat}% i l&rsquo;impost el&egrave;ctric del 5,11%, &eacute;s a dir, impostos sense les rebaixes vigents.</p>
<p dir="ltr">Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades a partir d&rsquo;usos t&iacute;pics, i que els imports finals <strong>dependran de circumst&agrave;ncies</strong> que no podem preveure, com per exemple els horaris i el consum real d&rsquo;energia que facis, altres variacions de preus durant el 2022, o canvis que pugui haver al mercat el&egrave;ctric.</p>
% elif quintextes == 'casC':
<p>Tal com estableix la normativa, hem fet una estimaci&oacute; de car&agrave;cter orientatiu, a partir de les dades que tenim del teu hist&ograve;ric recent d&rsquo;&uacute;s d&rsquo;electricitat (aproximadament ${consum_total} kWh anuals) i sense tenir en compte l&rsquo;autoproducci&oacute; ni el Generation kWh. Segons aquesta estimaci&oacute;, l&rsquo;actualitzaci&oacute; dels nous preus podria suposar una disminuci&oacute; aproximada de ${increment_total} euros anuals a la factura respecte al que costaria si mantingu&eacute;ssim els preus vigents actualment, durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de ${preu_nou_imp} euros amb els nous preus, i un cost anual aproximat de ${preu_vell_imp} euros sense aplicar els nous preus. En els dos casos l&rsquo;estimaci&oacute; inclou l'${impost_aplicat}% i l&rsquo;impost el&egrave;ctric del 5,11%, &eacute;s a dir, impostos sense rebaixes del govern.</p>
<p>Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades, i que els imports finals <strong>dependran de circumst&agrave;ncies</strong> que no podem preveure, com per exemple els horaris i el consum real d&rsquo;energia que facis, variacions de preus durant el 2022, o altres canvis que pugui haver al mercat el&egrave;ctric.</p>
% endif
% if tarifa == '2.0TD':
<p dir="ltr" style="margin-top: 2em;"><strong>Els tres per&iacute;odes horaris segueixen vigents</strong></p>
<p dir="ltr">Et recordem que els tres per&iacute;odes horaris d&rsquo;energia segueixen vigents. Aix&iacute;, el per&iacute;ode vall (nits, caps de setmana i festius estatals) seguir&agrave; sent el m&eacute;s econ&ograve;mic. Despr&eacute;s ve el per&iacute;ode pla (laborables de 8 a 10 h, de 14 a 18 h i de 22 a 00 h), durant el qual l&rsquo;energia no &eacute;s tan econ&ograve;mica. Finalment, ve el per&iacute;ode punta (de 10 a 14 h i de 18 a 22 h), que &eacute;s quan el preu de l&rsquo;energia &eacute;s m&eacute;s elevat.</p>
% elif tarifa == '3.0TD' or tarifa == '6.1TD':
<p dir="ltr" style="margin-top: 2em;"><strong>Qu&egrave; passar&agrave; amb els per&iacute;odes horaris?</strong></p>
<p dir="ltr">Els sis per&iacute;odes horaris (P1, P2, P3, P4, P5 i P6) seguiran sent v&agrave;lids. El per&iacute;ode 6 seguir&agrave; sent el m&eacute;s econ&ograve;mic, i el per&iacute;ode 1, el m&eacute;s car. Recordeu que <a href="https://ca.support.somenergia.coop/article/1107-horaris-i-periodes-de-la-tarifa-3-0td-i-les-tarifes-dalta-tensio-6-1td-6-2td-6-3td-i-6-4td">al nostre Centre d&rsquo;Ajuda</a> podeu trobar les taules de la distribuci&oacute; hor&agrave;ria dels diferents per&iacute;odes segons regi&oacute; (Pen&iacute;nsula, Balears i Can&agrave;ries).</p>
% endif
<br>
<p dir="ltr">T&rsquo;adjuntem en aquest correu el teu contracte actualitzat amb els preus actuals, vigents fins al 30 de setembre, i els nous preus, que comen&ccedil;arem a aplicar el dia 1 d&rsquo;octubre de 2022. Si hi est&agrave;s d&rsquo;acord, <strong>no cal que responguis aquest correu</strong> ni que ens retornis el document signat, ja que l'actualitzaci&oacute; de les nostres tarifes s'aplicar&agrave; autom&agrave;ticament. Si lamentablement aquest canvi et fes replantejar la teva pertinen&ccedil;a a la cooperativa, podries donar de baixa el teu contracte amb nosaltres, b&eacute; comunicant-nos-ho directament, o b&eacute; mitjan&ccedil;ant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni cl&agrave;usules de perman&egrave;ncia en cap moment. Aix&iacute; doncs, si decidissis marxar, nom&eacute;s et facturar&iacute;em el consum realitzat fins al dia de finalitzaci&oacute; del contracte, amb els preus vigents a cada moment.<strong><br></strong></p>
<br>
<p dir="ltr">Una salutaci&oacute; cordial,<br>
Equip de Som Energia<br>
<a href="https://somenergia.coop/">www.somenergia.coop</a></p>
% endif
% if object.polissa_id.titular.lang != "ca_ES":
<p dir="ltr" style="margin-top: 2em;">El d&iacute;a 1 de octubre tendremos que cambiar las tarifas de Som Energia, para repercutir el coste del mecanismo de ajuste del gas. Este nuevo sistema de tarifas es temporal y en principio, seg&uacute;n el <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2022-7843">RDL 10/2022</a>, no se extender&aacute; m&aacute;s all&aacute; del 31 de mayo de 2023.</p>
<p dir="ltr">Las Islas Baleares y Canarias no se rigen por el mismo mercado el&eacute;ctrico que el resto del estado espa&ntilde;ol. La normativa establece que, en ese caso, el mecanismo de ajuste del gas no aplica para los territorios insulares. As&iacute; pues, como desde Som Energia no tenemos que pagar el mecanismo de ajuste del gas para la energ&iacute;a que comercializamos en Baleares y Canarias, tampoco aplicaremos este precio a las tarifas correspondientes.</p>
<p dir="ltr">As&iacute; pues, para estos contratos (entre ellos, el tuyo), la actualizaci&oacute;n de tarifas ser&aacute; a la baja. Puedes ver los precios finales en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">apartado de tarifas de la web</a>. Si quieres realizar comparaciones, puedes acceder al <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/historico-de-tarifas-de-electricidad/">hist&oacute;rico de tarifas</a>, pero ten en cuenta que los nuevos precios no tienen incluido el mecanismo de ajuste del gas (que s&iacute; se aplica a los contratos de la pen&iacute;nsula).</p>
<p dir="ltr">Si tienes curiosidad o quieres saber m&aacute;s detalles de la afectaci&oacute;n del mecanismo en el resto de contratos, puedes leer <a href="https://blog.somenergia.coop/?p=43137">esta noticia</a> del blog.</p>
<p style="margin-top: 2em;"><strong>Estimaci&oacute;n</strong></p>
% if quintextes == 'casA':
<p dir="ltr">Tal y como establece la normativa, hemos hecho una estimaci&oacute;n orientativa, a partir de los datos que tenemos de tu hist&oacute;rico reciente de uso de electricidad (aproximadamente ${consum_total} kWh anuales) y tomando como referencia el reparto horario de un contrato est&aacute;ndar, sin autoproducci&oacute;n ni Generation kWh. Seg&uacute;n estos datos, la actualizaci&oacute;n de los nuevos precios podr&iacute;a suponer una disminuci&oacute;n aproximada de ${increment_total} euros anuales en la factura respecto a lo que costar&iacute;a si mantuvi&eacute;semos los precios actuales durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin actualizar los precios. En ambos casos la estimaci&oacute;n incluye el ${impost_aplicat}% y el impuesto el&eacute;ctrico del 5,11%, es decir, impuestos sin las rebajas vigentes.</p>
<p dir="ltr">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>depender&aacute;n de circunstancias</strong> que no podemos prever, como los horarios y el uso de energ&iacute;a que finalmente hagas, otras variaciones de precios durante el 2022, o cambios que pueda haber en el mercado el&eacute;ctrico.</p>
% elif quintextes == 'casB':
<p dir="ltr">Tal y como establece la normativa, hemos hecho una estimaci&oacute;n de car&aacute;cter orientativo, en funci&oacute;n de la potencia contratada que tienes y el uso de electricidad que suele haber con estas potencias, cogiendo de referencia un contrato est&aacute;ndar, sin autoproducci&oacute;n ni Generation kWh. Seg&uacute;n estos datos, la actualizaci&oacute;n de precios podr&iacute;a suponer una disminuci&oacute;n aproximada de ${increment_total} euros anuales en la factura respecto a lo que costar&iacute;a sin aplicar los nuevos precios (es decir, si mantuvi&eacute;semos los precios actuales durante todo el a&ntilde;o). As&iacute; pues, resultar&iacute;a un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin aplicar el cambio de precios. En ambos casos la estimaci&oacute;n incluye el ${impost_aplicat}% y el impuesto el&eacute;ctrico del 5,11%, es decir, impuestos sin las rebajas vigentes.</p>
<p dir="ltr">Ten en cuenta que esto son estimaciones aproximadas a partir de usos t&iacute;picos, y que los importes finales <strong>depender&aacute;n de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el consumo real de energ&iacute;a que realices, otras variaciones de precios durante el 2022, o cambios que pueda haber en el mercado el&eacute;ctrico.</p>
% elif quintextes == 'casC':
<p dir="ltr">Tal y como establece la normativa, hemos hecho una estimaci&oacute;n de car&aacute;cter orientativo, a partir de los datos que tenemos de tu hist&oacute;rico reciente de uso de electricidad (aproximadamente ${consum_total} kWh anuales) y sin tener en cuenta la autoproducci&oacute;n ni el Generation kWh. Seg&uacute;n esta estimaci&oacute;n, la actualizaci&oacute;n de los nuevos precios podr&iacute;a suponer una disminuci&oacute;n aproximada de ${increment_total} euros anuales en la factura respecto a lo que costar&iacute;a si mantuvi&eacute;ramos los precios actualmente vigentes, durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de ${preu_nou_imp} euros con los nuevos precios, y un coste anual aproximado de ${preu_vell_imp} euros sin aplicar los nuevos precios. En ambos casos la estimaci&oacute;n incluye el ${impost_aplicat}% y el impuesto el&eacute;ctrico del 5,11%, es decir, impuestos sin rebajas del gobierno.</p>
<p dir="ltr">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>depender&aacute;n de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el consumo real de energ&iacute;a que realices, variaciones de precios durante 2022, u otros cambios que pueda haber en el mercado el&eacute;ctrico.</p>
% endif
% if tarifa == '2.0TD':
<p dir="ltr" style="margin-top: 2em;"><strong>Los tres periodos horarios siguen vigentes</strong></p>
<p dir="ltr">Te recordamos que los tres periodos horarios de energ&iacute;a siguen vigentes. As&iacute;, el per&iacute;odo valle (noches, fines de semana y festivos estatales) seguir&aacute; siendo el m&aacute;s econ&oacute;mico. Luego viene el periodo llano (laborables de 8 a 10 h, de 14 a 18 h y de 22 a 00 h), durante el cual la energ&iacute;a no es tan econ&oacute;mica. Finalmente, viene el periodo punta (de 10 a 14 h y de 18 a 22 h), que es cuando el precio de la energ&iacute;a es m&aacute;s elevado.</p>
% elif tarifa == '3.0TD' or tarifa == '6.1TD':
<p dir="ltr" style="margin-top: 2em;"><strong>&iquest;Qu&eacute; pasar&aacute; con los periodos horarios?</strong></p>
<p dir="ltr">Los seis periodos horarios (P1, P2, P3, P4, P5 y P6) seguir&aacute;n siendo v&aacute;lidos. El periodo 6 seguir&aacute; siendo el m&aacute;s econ&oacute;mico, y el periodo 1, el m&aacute;s caro. Recuerda que <a href="https://es.support.somenergia.coop/article/1108-horarios-y-periodos-de-la-tarifa-3-0td-y-las-tarifas-de-alta-tension-6-1td-6-2td-6-3td-y-6-4td">en nuestro Centro de Ayuda</a> puedes encontrar las tablas de la distribuci&oacute;n horaria de los diferentes periodos seg&uacute;n regi&oacute;n (Pen&iacute;nsula, Baleares y Canarias).</p>
% endif
<br>
<p dir="ltr">Te adjuntamos en este correo tu contrato actualizado con los precios actuales, vigentes hasta el 30 de septiembre, y los nuevos precios, que empezaremos a aplicar el d&iacute;a 1 de octubre de 2022. Si est&aacute;s de acuerdo, <strong>no es necesario que respondas a este correo</strong> ni que nos devuelvas el documento firmado, ya que la actualizaci&oacute;n de nuestras tarifas se aplicar&aacute; autom&aacute;ticamente. Si lamentablemente este cambio te hiciera replantear tu pertenencia a la cooperativa, podr&iacute;as dar de baja tu contrato con Som Energia, bien comunic&aacute;ndonoslo directamente, o mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cl&aacute;usulas de permanencia en ning&uacute;n momento. As&iacute; pues, si decidieras marcharte, s&oacute;lo te facturar&iacute;amos el consumo realizado hasta el d&iacute;a de finalizaci&oacute;n del contrato, con los precios vigentes en cada momento.</p>
<br>
<p dir="ltr">Un saludo cordial,<br>
Equipo de Som Energia<br>
<a href="https://www.somenergia.coop/es">www.somenergia.coop</a></p>
% endif
</%def>