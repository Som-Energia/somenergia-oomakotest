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
            ("P1", 26.881),
            ("P2", 2.841),
        ],
        "energy": [
            ("P1", 0.295),
            ("P2", 0.237),
            ("P3", 0.199),
        ],
        "gkwh": [
            ("P1", 0.197),
            ("P2", 0.150),
            ("P3", 0.126),
        ]
    },
    "3.0TD": {
        "power": [
            ("P1", 13.982509),
            ("P2", 11.899074),
            ("P3", 4.002045),
            ("P4", 3.653973),
            ("P5", 2.732707),
            ("P6", 2.001136),
        ],
        "energy": [
            ("P1", 0.233),
            ("P2", 0.254),
            ("P3", 0.23),
            ("P4", 0.213),
            ("P5", 0.213),
            ("P6", 0.196),
        ],
        "gkwh": [
            ("P1", 0.159),
            ("P2", 0.152),
            ("P3", 0.127),
            ("P4", 0.118),
            ("P5", 0.118),
            ("P6", 0.119),
        ]
    },
    "6.1TD": {
        "power": [
            ("P1", 22.965215),
            ("P2", 19.841178),
            ("P3", 10.327582),
            ("P4", 8.560662),
            ("P5", 1.908583),
            ("P6", 1.148958),
        ],
        "energy": [
            ("P1", 0.207),
            ("P2", 0.221),
            ("P3", 0.207),
            ("P4", 0.195),
            ("P5", 0.189),
            ("P6", 0.180),
        ],
        "gkwh": [
            ("P1", 0.129),
            ("P2", 0.12),
            ("P3", 0.104),
            ("P4", 0.099),
            ("P5", 0.095),
            ("P6", 0.099),
        ]
    },
    "3.0TDVE": {
        "power": [
            ("P1", 2.558984),
            ("P2", 2.503926),
            ("P3", 0.664441),
            ("P4", 0.573622),
            ("P5", 0.338303),
            ("P6", 0.338303),
        ],
        "energy": [
            ("P1", 0.320),
            ("P2", 0.329),
            ("P3", 0.26),
            ("P4", 0.233),
            ("P5", 0.217),
            ("P6", 0.203),
        ],
        "gkwh": [
            ("P1", 0.246),
            ("P2", 0.227),
            ("P3", 0.157),
            ("P4", 0.138),
            ("P5", 0.122),
            ("P6", 0.125),
        ]
    },
    "6.1TDVE": {
        "power": [
            ("P1", 4.269983),
            ("P2", 4.002324),
            ("P3", 1.994267),
            ("P4", 1.599721),
            ("P5", 0.113126),
            ("P6", 0.113126),
        ],
        "energy": [
            ("P1", 0.355),
            ("P2", 0.337),
            ("P3", 0.258),
            ("P4", 0.235),
            ("P5", 0.196),
            ("P6", 0.185),
        ],
        "gkwh": [
            ("P1", 0.277),
            ("P2", 0.237),
            ("P3", 0.155),
            ("P4", 0.140),
            ("P5", 0.101),
            ("P6", 0.104),
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
            ("P1", 0.343),
            ("P2", 0.281),
            ("P3", 0.234),
        ],
        "gkwh": [
            ("P1", 0.197),
            ("P2", 0.150),
            ("P3", 0.126),
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
            ("P1", 0.159),
            ("P2", 0.152),
            ("P3", 0.127),
            ("P4", 0.118),
            ("P5", 0.118),
            ("P6", 0.119),
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
            ("P1", 0.129),
            ("P2", 0.12),
            ("P3", 0.104),
            ("P4", 0.099),
            ("P5", 0.095),
            ("P6", 0.099),
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
            ("P1", 0.246),
            ("P2", 0.227),
            ("P3", 0.157),
            ("P4", 0.138),
            ("P5", 0.122),
            ("P6", 0.125),
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
            ("P1", 0.277),
            ("P2", 0.237),
            ("P3", 0.155),
            ("P4", 0.140),
            ("P5", 0.101),
            ("P6", 0.104),
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
    if fiscal_position.id in [19, 33, 38]:
      iva = 0.03
    if fiscal_position.id in [25, 34, 39]:
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

preu_vell = calcularPreuTotal(consums, potencies, tarifa, OLD_TARIFF_PRICES, False, False)

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
if object.polissa_id.fiscal_position_id.id in [19, 33, 38]:
  impost_aplicat = "IGIC del 3"
elif object.polissa_id.fiscal_position_id.id in [25, 34, 39]:
  impost_aplicat = "IGIC del 0"

consum_total = formatNumber(round(consum_total/100.0)*100)
te_gkwh = object.polissa_id.te_assignacio_gkwh

try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, object.polissa_id.titular.vat):
    nom_titular = ' ' + object.polissa_id.titular.name.split(',')[1].lstrip() + ','
  else:
    nom_titular = ','
except:
  nom_titular = ','
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

% if object.polissa_id.titular.lang == "ca_ES":
<a href="https://www.somenergia.coop/ca/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif
% if object.polissa_id.titular.lang != "ca_ES":
<a href="https://www.somenergia.coop/es/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
%endif

<br>
<br>

## <p><strong>TEST: ${object.polissa_id.name}</strong></p>
## <br>

<p>Hola${nom_titular}</p>

% if object.polissa_id.titular.lang == "ca_ES":

<p><span style="font-weight: 400;">A partir de l&rsquo;1 de maig tindrem uns nous preus de l&rsquo;electricitat a Som Energia. El preu de l&rsquo;energia al mercat de futurs (on comprem la major part de l&rsquo;energia) s&rsquo;est&agrave; moderant lleugerament, per tant, ens permet </span><strong>abaixar les nostres tarifes</strong><span style="font-weight: 400;">. N&rsquo;expliquem tots els detalls a </span><a href="https://blog.somenergia.coop/?p=44830"><span style="font-weight: 400;">aquesta not&iacute;cia</span></a><span style="font-weight: 400;"> del blog, i a la p&agrave;gina web pots consultar en qualsevol moment </span><a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/"><span style="font-weight: 400;">totes les tarifes</span></a><span style="font-weight: 400;">. Si vols fer-ne comparacions, pots accedir a l&rsquo;apartat</span> <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/"><span style="font-weight: 400;">hist&ograve;ric de tarifes</span></a><span style="font-weight: 400;">, on hi ha tamb&eacute; els preus vigents fins al 30 d&rsquo;abril i els de per&iacute;odes anteriors.</span></p>

<br>
<p><strong>Bo social</strong></p>
<p><span style="font-weight: 400;">El cost del finan&ccedil;ament del bo social, que fins ara inclo&iacute;em a les tarifes, passar&agrave; a ser un concepte a part a la factura. Tal com estableix l&rsquo;</span><a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-2606"><span style="font-weight: 400;">ordre TED/81/2023</span></a><span style="font-weight: 400;">, actualment s&oacute;n aproximadament 14,04 euros anuals per a cada contracte.</span></p>

% if not insular:
<br>
<p><strong>Mecanisme d&rsquo;ajust del gas (MAG)&nbsp;</strong></p>
<p><span style="font-weight: 400;">Segons el </span><a href="https://www.boe.es/buscar/act.php?id=BOE-A-2022-7843"><span style="font-weight: 400;">Reial decret llei 10/2022</span></a><span style="font-weight: 400;">, el Mecanisme d&rsquo;ajust del gas (</span><a href="https://ca.support.somenergia.coop/article/1251-mecanisme-dajust-del-gas"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">) segueix vigent fins al 31 de maig de 2023. Aix&iacute; doncs, seguim com fins ara, </span><span style="font-weight: 400;">aplicant-lo a la part del preu que es preveu a la cl&agrave;usula 5.3 (ii) de les Condicions Generals del contracte de subministrament.</span><span style="font-weight: 400;"> A les factures seguir&agrave; apareixent en una l&iacute;nia diferent. </span></p>
% endif

<br>
<p><strong>Autoproducci&oacute;</strong></p>
<p><span style="font-weight: 400;">Per als contractes que tenen autoproducci&oacute; amb compensaci&oacute; simplificada, els excedents d&rsquo;autoproducci&oacute; els continuarem compensant al mateix valor de refer&egrave;ncia del cost de l&rsquo;energia que fem servir per calcular el preu de venda. Com que el preu de refer&egrave;ncia de l&rsquo;energia ha baixat, disminueix tamb&eacute; la compensaci&oacute; d&rsquo;excedents. Des de l&rsquo;1 de maig, doncs, es far&agrave; a </span><span style="font-weight: 400;">0,13</span><span style="font-weight: 400;"> euros/kWh sense impostos, </span><span style="font-weight: 400;">0,158087</span><span style="font-weight: 400;"> euros/kWh amb impostos (amb un IVA del 21%) i </span><span style="font-weight: 400;">0,137183</span><span style="font-weight: 400;"> amb impostos (amb un IVA del 5%).</span></p>
<p><span style="font-weight: 400;">Seguim treballant en el desenvolupament d&rsquo;una eina que ens permeti aplicar</span><span style="font-weight: 400;"> un descompte a aquells contractes d&rsquo;autoproducci&oacute; que tinguin excedents que no s&rsquo;hagin compensat a la factura. </span><span style="font-weight: 400;">Quan la posem en marxa tindrem en compte </span><strong>tamb&eacute;</strong> <strong>els</strong> <strong>excedents que han generat durant tot l&rsquo;any 2022 i 2023</strong><span style="font-weight: 400;"> (amb el </span><span style="font-weight: 400;">contracte actiu amb Som Energia), i que no hagin estat compensats a la factura. Tan bon punt tinguem novetats al respecte, n&rsquo;informarem.</span></p>

% if te_gkwh:
<br>
<p><strong>Generation kWh</strong></p>
<p><span style="font-weight: 400;">El cost de l&rsquo;energia generada amb el Generation kWh es mant&eacute;, per tant, als preus del Generation kWh nom&eacute;s els hem d&rsquo;aplicar les petites variacions d&rsquo;altres conceptes que hem de pagar per poder operar al mercat el&egrave;ctric. Aix&ograve; suposar&agrave; un augment de 0,015 euros/kWh a cada per&iacute;ode.</span></p>
% endif

<br>
<p><strong>Comparativa estimada</strong></p>
% if quintextes == 'casA':
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una </span><strong>estimaci&oacute; de car&agrave;cter orientatiu</strong><span style="font-weight: 400;">,</span> <span style="font-weight: 400;">a partir de les dades que tenim del teu hist&ograve;ric recent d&rsquo;&uacute;s d&rsquo;electricitat (aproximadament </span><span style="font-weight: 400;">${consum_total}</span><span style="font-weight: 400;"> kWh anuals), i prenent com a refer&egrave;ncia el repartiment horari d&rsquo;un contracte est&agrave;ndard, sense autoproducci&oacute; ni Generation kWh i sense tenir en compte el preu del mecanisme d&rsquo;ajust del gas (</span><a href="https://ca.support.somenergia.coop/article/1251-mecanisme-dajust-del-gas"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">). Segons aquestes dades, l&rsquo;actualitzaci&oacute; dels nous preus podria suposar una disminuci&oacute; aproximada de </span><span style="font-weight: 400;">${increment_total}</span><span style="font-weight: 400;"> euros anuals a la factura respecte al que costaria si mantingu&eacute;ssim els preus actuals durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de </span><span style="font-weight: 400;">${preu_nou_imp}</span><span style="font-weight: 400;"> euros amb els nous preus, i un cost anual aproximat de </span><span style="font-weight: 400;">${preu_vell_imp}</span><span style="font-weight: 400;"> euros sense actualitzar-los. En els dos casos l&rsquo;estimaci&oacute; inclou </span><span style="font-weight: 400;">l'${impost_aplicat}%</span><span style="font-weight: 400;"> i l&rsquo;impost el&egrave;ctric del 0,5%, &eacute;s a dir, impostos actuals, amb les rebaixes vigents.&nbsp;</span></p>
<p><span style="font-weight: 400;">Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades, i que els imports finals </span><strong>dependran de circumst&agrave;ncies</strong><span style="font-weight: 400;"> que no podem preveure, com per exemple els horaris i l&rsquo;&uacute;s d&rsquo;energia que finalment facis, altres variacions de preus durant l&rsquo;any, o canvis que pugui haver al mercat el&egrave;ctric.</span></p>
% elif quintextes == 'casB':
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una </span><strong>estimaci&oacute; de car&agrave;cter orientatiu,</strong><span style="font-weight: 400;"> en funci&oacute; de la pot&egrave;ncia contractada que tens i l&rsquo;&uacute;s d&rsquo;electricitat que sol haver-hi amb aquestes pot&egrave;ncies i agafant de refer&egrave;ncia un contracte est&agrave;ndard, sense autoproducci&oacute; ni Generation kWh, i sense tenir en compte el preu del mecanisme d&rsquo;ajust del gas (</span><a href="https://ca.support.somenergia.coop/article/1251-mecanisme-dajust-del-gas"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">). Segons aquestes dades, l&rsquo;actualitzaci&oacute; de preus podria suposar una disminuci&oacute; aproximada de </span><span style="font-weight: 400;">${increment_total}</span><span style="font-weight: 400;"> euros anuals a la factura respecte al que costaria </span><span style="font-weight: 400;">si mantingu&eacute;ssim els preus actuals </span><span style="font-weight: 400;">durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de </span><span style="font-weight: 400;">${preu_nou_imp}</span><span style="font-weight: 400;"> euros amb l&rsquo;actualitzaci&oacute;, i un cost anual aproximat de </span><span style="font-weight: 400;">${preu_vell_imp}</span><span style="font-weight: 400;"> euros sense l&rsquo;actualitzaci&oacute;. En els dos casos l&rsquo;estimaci&oacute; inclou </span><span style="font-weight: 400;">l'${impost_aplicat}%</span><span style="font-weight: 400;"> i l&rsquo;impost el&egrave;ctric del 0,5%, &eacute;s a dir, impostos actuals, amb les rebaixes vigents.&nbsp;</span></p>
<p><span style="font-weight: 400;">Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades, i que els imports finals </span><strong>dependran de circumst&agrave;ncies</strong><span style="font-weight: 400;"> que no podem preveure, com per exemple els horaris i l&rsquo;&uacute;s d&rsquo;energia que finalment facis, altres variacions de preus durant l&rsquo;any, o canvis que pugui haver al mercat el&egrave;ctric.</span></p>
% elif quintextes == 'casC':
<p><span style="font-weight: 400;">Tal com estableix la normativa, hem fet una </span><strong>estimaci&oacute; de car&agrave;cter orientatiu, </strong><span style="font-weight: 400;">a partir de les dades que tenim del teu hist&ograve;ric recent d&rsquo;&uacute;s d&rsquo;electricitat (aproximadament </span><span style="font-weight: 400;">${consum_total}</span><span style="font-weight: 400;"> kWh anuals), sense autoproducci&oacute; ni Generation kWh, i sense tenir en compte el preu del mecanisme d&rsquo;ajust del gas (</span><a href="https://ca.support.somenergia.coop/article/1251-mecanisme-dajust-del-gas"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">). Segons aquesta estimaci&oacute;, l&rsquo;actualitzaci&oacute; de les tarifes podria suposar una disminuci&oacute; aproximada de </span><span style="font-weight: 400;">${increment_total}</span><span style="font-weight: 400;"> euros anuals a la factura respecte al que costaria si mantingu&eacute;ssim els preus actuals durant tot l&rsquo;any. Aix&iacute; doncs, en resultaria un cost anual aproximat de </span><span style="font-weight: 400;">${preu_nou_imp}</span><span style="font-weight: 400;"> euros amb l&rsquo;actualitzaci&oacute;, i un cost anual aproximat de </span><span style="font-weight: 400;">${preu_vell_imp}</span><span style="font-weight: 400;"> euros sense actualitzar tarifes. En els dos casos l&rsquo;estimaci&oacute; inclou </span><span style="font-weight: 400;">l'${impost_aplicat}%</span><span style="font-weight: 400;"> i l&rsquo;impost el&egrave;ctric del 0,5%, &eacute;s a dir, impostos actuals, amb les rebaixes vigents.&nbsp;</span></p>
<p><span style="font-weight: 400;">Tingues en compte que aix&ograve; s&oacute;n estimacions aproximades, i que els imports finals </span><strong>dependran de circumst&agrave;ncies</strong><span style="font-weight: 400;"> que no podem preveure, com per exemple els horaris i l&rsquo;&uacute;s d&rsquo;energia que finalment facis, altres variacions de preus durant l&rsquo;any, o canvis que pugui haver al mercat el&egrave;ctric.</span></p>
% endif

<br>
<p><span style="font-weight: 400;">T&rsquo;adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si est&agrave;s d&rsquo;acord amb la baixada de preus, </span><strong>no cal que ens retornis el document signat</strong><span style="font-weight: 400;">, ja que l'actualitzaci&oacute; dels preus de les nostres tarifes s'aplica autom&agrave;ticament. Igualment, hem d&rsquo;informar-te que si, per alguna ra&oacute;, aquest canvi de preus et fes replantejar la teva pertinen&ccedil;a a la cooperativa, podries donar de baixa el teu contracte amb nosaltres, b&eacute; comunicant-nos-ho directament, o b&eacute; mitjan&ccedil;ant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni cl&agrave;usules de perman&egrave;ncia en cap moment. Aix&iacute; doncs, si decidissis marxar, nom&eacute;s et facturar&iacute;em el consum realitzat fins al dia de finalitzaci&oacute; del contracte, amb els preus vigents a cada moment.</span></p>

<br>
<p dir="ltr">Una salutaci&oacute; cordial,
<br>
Equip de Som Energia
<br>
<a href="https://somenergia.coop/ca">www.somenergia.coop</a></p>

% endif

% if  object.polissa_id.titular.lang != "ca_ES":

<p><span style="font-weight: 400;">A partir del 1 de mayo tendremos nuevos precios de la electricidad en Som Energia. El precio de la energ&iacute;a en el mercado de futuros (donde compramos la mayor parte de la energ&iacute;a) se est&aacute; moderando ligeramente, por tanto, nos permite </span><strong>bajar nuestras tarifas</strong><span style="font-weight: 400;">. Explicamos todos los detalles en </span><a href="https://blog.somenergia.coop/?p=44832"><span style="font-weight: 400;">esta noticia</span></a><span style="font-weight: 400;"> del blog, y en la p&aacute;gina web puedes consultar en cualquier momento </span><a href="https://www.somenergia.coop/es/tarifas-de-electricidad/"><span style="font-weight: 400;">todas las tarifas</span></a><span style="font-weight: 400;">. Si quieres hacer comparaciones, puedes acceder al apartado</span> <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/historico-de-tarifas-de-electricidad/"><span style="font-weight: 400;">hist&oacute;rico de tarifas</span></a><span style="font-weight: 400;">, donde est&aacute;n tambi&eacute;n los precios vigentes hasta el 30 de abril y los de per&iacute;odos anteriores.</span></p>

<br>
<p><strong>Bono social</strong></p>
<p><span style="font-weight: 400;">El coste de la financiaci&oacute;n del bono social, que hasta ahora inclu&iacute;amos en las tarifas, pasar&aacute; a ser un concepto aparte en la factura. Tal y como establece la </span><a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-2606"><span style="font-weight: 400;">orden TED/81/2023</span></a><span style="font-weight: 400;">, actualmente son aproximadamente 14,04 euros anuales para cada contrato.</span></p>

% if not insular:
<br>
<p><strong>Mecanismo de ajuste del gas (MAG)</strong></p>
<p><span style="font-weight: 400;">Seg&uacute;n el </span><a href="https://www.boe.es/buscar/act.php?id=BOE-A-2022-7843"><span style="font-weight: 400;">Real decreto ley 10/2022</span></a><span style="font-weight: 400;">, el Mecanismo de ajuste del gas (</span><a href="https://es.support.somenergia.coop/article/1252-mecanismo-de-ajuste-del-gas?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=castellano"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">) sigue vigente hasta el 31 de mayo de 2023. As&iacute; pues, seguimos como hasta ahora, </span><span style="font-weight: 400;">aplic&aacute;ndolo a la parte del precio que se prev&eacute; en la cl&aacute;usula 5.3 (ii) de las Condiciones Generales del contrato de suministro.</span><span style="font-weight: 400;"> En las facturas seguir&aacute; apareciendo en una l&iacute;nea distinta.</span></p>
% endif

<br>
<p><strong>Autoproducci&oacute;n</strong></p>
<p><span style="font-weight: 400;">Para los contratos que tienen autoproducci&oacute;n con compensaci&oacute;n simplificada, los excedentes de autoproducci&oacute;n los seguiremos compensando al mismo valor de referencia del coste de la energ&iacute;a que utilizamos para calcular el precio de venta. Como el precio de referencia de la energ&iacute;a ha descendido, disminuye tambi&eacute;n la compensaci&oacute;n de excedentes. Desde el 1 de mayo, pues, se har&aacute; a </span><span style="font-weight: 400;">0,13</span><span style="font-weight: 400;"> euros/kWh sin impuestos, </span><span style="font-weight: 400;">0,158087</span><span style="font-weight: 400;"> euros/kWh con impuestos (con un IVA del 21%) y </span><span style="font-weight: 400;">0,137183</span><span style="font-weight: 400;"> con impuestos (con un IVA del 5%).</span></p>
<p><span style="font-weight: 400;">Seguimos trabajando en el desarrollo de una herramienta que nos permita aplicar</span><span style="font-weight: 400;"> un descuento en aquellos contratos de autoproducci&oacute;n que tengan excedentes que no se hayan compensado en la factura.</span><span style="font-weight: 400;"> Cuando la pongamos en marcha tendremos en cuenta </span><strong>tambi&eacute;n</strong> <strong>los</strong> <strong>excedentes que han generado durante todo el a&ntilde;o 2022 y 2023</strong><span style="font-weight: 400;"> (con el contrato activo con Som Energia</span><span style="font-weight: 400;">), y que no hayan sido compensados ​​en la factura. En cuanto tengamos novedades al respecto, informaremos de ellas.</span></p>

% if te_gkwh:
<br>
<p><strong>Generaci&oacute;n kWh</strong></p>
<p><span style="font-weight: 400;">El coste de la energ&iacute;a generada con el Generation kWh se mantiene, por tanto, a los precios del Generation kWh s&oacute;lo debemos aplicarles las peque&ntilde;as variaciones de otros conceptos que debemos pagar para poder operar en el mercado el&eacute;ctrico. Esto supondr&aacute; un aumento de 0,015 euros/kWh en cada per&iacute;odo.</span></p>
% endif

<br>
<p><strong>Comparativa estimada</strong></p>
% if quintextes == 'casA':
<p><span style="font-weight: 400;">Tal como establece la normativa, hemos hecho una </span><strong>estimaci&oacute;n de car&aacute;cter orientativo</strong><span style="font-weight: 400;">,</span> <span style="font-weight: 400;">a partir de los datos que tenemos de tu hist&oacute;rico reciente de uso de electricidad (aproximadamente </span><span style="font-weight: 400;">${consum_total}</span><span style="font-weight: 400;"> kWh anuales), y tomando como referencia el reparto horario de un contrato est&aacute;ndar, sin autoproducci&oacute;n ni Generation kWh y sin tener en cuenta el precio del mecanismo de ajuste del gas (</span><a href="https://es.support.somenergia.coop/article/1252-mecanismo-de-ajuste-del-gas?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=castellano"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">). Seg&uacute;n estos datos, la actualizaci&oacute;n de los nuevos precios podr&iacute;a suponer una disminuci&oacute;n aproximada de </span><span style="font-weight: 400;">${increment_total}</span><span style="font-weight: 400;"> euros anuales en la factura respecto a lo que costar&iacute;a si mantuvi&eacute;semos los precios actuales durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de </span><span style="font-weight: 400;">${preu_nou_imp}</span><span style="font-weight: 400;"> euros con los nuevos precios, y un coste anual aproximado de </span><span style="font-weight: 400;">${preu_vell_imp}</span><span style="font-weight: 400;"> euros sin actualizarlos. En ambos casos la estimaci&oacute;n incluye </span><span style="font-weight: 400;">el ${impost_aplicat}%</span><span style="font-weight: 400;"> y el </span><span style="font-weight: 400;">impuesto el&eacute;ctrico del 0,5%</span><span style="font-weight: 400;">, es decir, </span><span style="font-weight: 400;">impuestos actuales, con las rebajas vigentes</span><span style="font-weight: 400;">.</span></p>
<p><span style="font-weight: 400;">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales </span><strong>depender&aacute;n de circunstancias</strong><span style="font-weight: 400;"> que no podemos prever, como por ejemplo los horarios y el uso de energ&iacute;a que finalmente realices, otras variaciones de precios durante el a&ntilde;o, o cambios que pueda haber en el mercado el&eacute;ctrico.</span></p>
% elif quintextes == 'casB':
<p><span style="font-weight: 400;">Tal como establece la normativa, hemos hecho una </span><strong>estimaci&oacute;n de car&aacute;cter orientativo,</strong><span style="font-weight: 400;"> en funci&oacute;n de la potencia contratada que tienes y el uso de electricidad que suele haber con estas potencias y cogiendo de referencia un contrato est&aacute;ndar, sin autoproducci&oacute;n ni Generation kWh, y sin tener en cuenta el precio del mecanismo de ajuste del gas (</span><a href="https://es.support.somenergia.coop/article/1252-mecanismo-de-ajuste-del-gas?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=castellano"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">). Seg&uacute;n estos datos, la actualizaci&oacute;n de precios podr&iacute;a suponer una disminuci&oacute;n aproximada de </span><span style="font-weight: 400;">${increment_total}</span><span style="font-weight: 400;"> euros anuales en la factura respecto a lo que costar&iacute;a </span><span style="font-weight: 400;">si mantuvi&eacute;ramos los precios actuales </span><span style="font-weight: 400;">durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de </span><span style="font-weight: 400;">${preu_nou_imp}</span><span style="font-weight: 400;"> euros con la actualizaci&oacute;n, y un coste anual aproximado de </span><span style="font-weight: 400;">${preu_vell_imp}</span><span style="font-weight: 400;"> euros sin la actualizaci&oacute;n. En ambos casos la estimaci&oacute;n incluye </span><span style="font-weight: 400;">el ${impost_aplicat}%</span><span style="font-weight: 400;"> y el </span><span style="font-weight: 400;">impuesto el&eacute;ctrico del 0,5%</span><span style="font-weight: 400;">, es decir, </span><span style="font-weight: 400;">impuestos actuales, con las rebajas vigentes</span><span style="font-weight: 400;">.</span></p>
<p><span style="font-weight: 400;">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales </span><strong>depender&aacute;n de circunstancias</strong><span style="font-weight: 400;"> que no podemos prever, como por ejemplo los horarios y el uso de energ&iacute;a que finalmente realices, otras variaciones de precios durante el a&ntilde;o, o cambios que pueda haber en el mercado el&eacute;ctrico.</span></p>
% elif quintextes == 'casC':
<p><span style="font-weight: 400;">Tal como establece la normativa, hemos hecho una </span><strong>estimaci&oacute;n de car&aacute;cter orientativo, </strong><span style="font-weight: 400;">a partir de los datos que tenemos de tu hist&oacute;rico reciente de uso de electricidad (aproximadamente </span><span style="font-weight: 400;">${consum_total}</span><span style="font-weight: 400;"> kWh anuales), sin autoproducci&oacute;n ni Generation kWh, y sin tener en cuenta el precio del mecanismo de ajuste del gas (</span><a href="https://es.support.somenergia.coop/article/1252-mecanismo-de-ajuste-del-gas?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=castellano"><span style="font-weight: 400;">MAG</span></a><span style="font-weight: 400;">). Seg&uacute;n esta estimaci&oacute;n, la actualizaci&oacute;n de las tarifas podr&iacute;a suponer una disminuci&oacute;n aproximada de </span><span style="font-weight: 400;">${increment_total}</span><span style="font-weight: 400;"> euros anuales en la factura respecto a lo que costar&iacute;a si mantuvi&eacute;semos los precios actuales durante todo el a&ntilde;o. As&iacute; pues, resultar&iacute;a un coste anual aproximado de </span><span style="font-weight: 400;">${preu_nou_imp}</span><span style="font-weight: 400;"> euros con la actualizaci&oacute;n, y un coste anual aproximado de </span><span style="font-weight: 400;">${preu_vell_imp}</span><span style="font-weight: 400;"> euros sin actualizar tarifas. En ambos casos la estimaci&oacute;n incluye </span><span style="font-weight: 400;">el ${impost_aplicat}%</span><span style="font-weight: 400;"> y el </span><span style="font-weight: 400;">impuesto el&eacute;ctrico del 0,5%</span><span style="font-weight: 400;">, es decir, </span><span style="font-weight: 400;">impuestos actuales, con las rebajas vigentes</span><span style="font-weight: 400;">.</span></p>
<p><span style="font-weight: 400;">Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales </span><strong>depender&aacute;n de circunstancias</strong><span style="font-weight: 400;"> que no podemos prever, como por ejemplo los horarios y el uso de energ&iacute;a que finalmente realices, otras variaciones de precios durante el a&ntilde;o, o cambios que pueda haber en el mercado el&eacute;ctrico.</span></p>
% endif

<br>
<p><span style="font-weight: 400;">Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si est&aacute;s de acuerdo con los nuevos de precios, </span><strong>no es necesario que nos devuelvas el documento firmado</strong><span style="font-weight: 400;">, puesto que la actualizaci&oacute;n de los precios de nuestras tarifas se aplica autom&aacute;ticamente. Igualmente, debemos informarte de que si, por alguna raz&oacute;n, este cambio de precios te hiciese replantear tu pertenencia a la cooperativa, podr&iacute;as dar de baja tu contrato con nosotros, bien comunic&aacute;ndolo directamente, o mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cl&aacute;usulas de permanencia en ning&uacute;n momento. As&iacute; pues, si decidieras marcharte, s&oacute;lo te facturar&iacute;amos el consumo realizado hasta el d&iacute;a de finalizaci&oacute;n del contrato, con los precios vigentes en cada momento.</span></p>

<br>
<p dir="ltr">Un saludo cordial,
<br>
Equipo de Som Energia
<br>
<a href="https://www.somenergia.coop/es/">www.somenergia.coop</a></p>

% endif

<br>

${text_legal}
</div>
</body>
</html>