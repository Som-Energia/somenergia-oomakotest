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

OLD_TARIFF_PRICES = {
    "2.0TD": {
        "power": [
            ("P1", 29.778),
            ("P2", 3.078),
        ],
        "energy": [
            ("P1", 0.407),
            ("P2", 0.320),
            ("P3", 0.262),
        ],
        "gkwh": [
            ("P1", 0.209),
            ("P2", 0.137),
            ("P3", 0.110),
        ]
    },
    "3.0TD": {
        "power": [
            ("P1", 16.670219),
            ("P2", 12.243338),
            ("P3", 5.934083),
            ("P4", 5.048310),
            ("P5", 3.368404),
            ("P6", 2.152216),
        ],
        "energy": [
            ("P1", 0.387),
            ("P2", 0.350),
            ("P3", 0.319),
            ("P4", 0.293),
            ("P5", 0.266),
            ("P6", 0.253),
        ],
        "gkwh": [
            ("P1", 0.163),
            ("P2", 0.146),
            ("P3", 0.120),
            ("P4", 0.107),
            ("P5", 0.094),
            ("P6", 0.100),
        ]
    },
    "6.1TD": {
        "power": [
            ("P1", 24.732072),
            ("P2", 21.529345),
            ("P3", 12.319941),
            ("P4", 9.897259),
            ("P5", 2.833920),
            ("P6", 1.571094),
        ],
        "energy": [
            ("P1", 0.340),
            ("P2", 0.310),
            ("P3", 0.291),
            ("P4", 0.267),
            ("P5", 0.243),
            ("P6", 0.231),
        ],
        "gkwh": [
            ("P1", 0.115),
            ("P2", 0.104),
            ("P3", 0.089),
            ("P4", 0.081),
            ("P5", 0.070),
            ("P6", 0.077),
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
            ("P1", 0.489),
            ("P2", 0.430),
            ("P3", 0.363),
            ("P4", 0.319),
            ("P5", 0.273),
            ("P6", 0.258),
        ],
        "gkwh": [
            ("P1", 0.265),
            ("P2", 0.226),
            ("P3", 0.163),
            ("P4", 0.133),
            ("P5", 0.101),
            ("P6", 0.105),
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
            ("P1", 0.499),
            ("P2", 0.437),
            ("P3", 0.362),
            ("P4", 0.311),
            ("P5", 0.251),
            ("P6", 0.237),
        ],
        "gkwh": [
            ("P1", 0.274),
            ("P2", 0.231),
            ("P3", 0.160),
            ("P4", 0.125),
            ("P5", 0.078),
            ("P6", 0.082),
        ]
    },
}

def getPotenciesPolissa(pol):
  potencies = {}
  for pot in pol.potencies_periode:
      potencies[pot.periode_id.name] = pot.potencia
  return potencies

def calcularPreuTotal(potencies, tarifa, preus):
  types =  {
    'power': potencies or {},
  }
  imports = 0
  for terme, values in types.items():
    for periode, quantity in values.items():
      imports += dict(preus[tarifa][terme])[periode] * quantity

  return imports

def formatNumber(number):
  return format(number, "1,.0f").replace(',','.')

potencies = getPotenciesPolissa(object.polissa_id)
tarifa = object.polissa_id.tarifa.name

preu_vell = calcularPreuTotal(potencies, tarifa, OLD_TARIFF_PRICES)
preu_nou = calcularPreuTotal(potencies, tarifa, NEW_TARIFF_PRICES)

estalvi_euros = formatNumber(abs(preu_nou - preu_vell))

%>
<br>
<p>Hola,</p>
% if  object.polissa_id.titular.lang != "es_ES":
<p>Us escrivim per comunicar-vos que el govern ha aprovat una <b>rebaixa en els càrrecs de l’electricitat</b>, un dels components regulats de la factura de la llum. Segons estableix el Reial decret llei 6/2022, els nous càrrecs són d’aplicació des del 31 de març i fins al 31 de desembre de 2022. En donem més detalls a <a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/tarifas-y-precios-de-la-luz/2022/04/actualitzacio-de-les-tarifes-amb-el-nou-valor-dels-carrecs-anunciat-pel-govern/">aquesta notícia del blog</a>.</p>
<p>Els càrrecs s’apliquen tant a la potència contractada com a l’energia utilitzada.</p>
<p>El <b>preu de la potència contractada</b> la podeu trobar en l’<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">apartat de tarifes de la cooperativa</a>. Per al vostre contracte aquesta rebaixa, en el terme de potència representarà un estalvi anual de ${estalvi_euros} € (abans d'impostos).</p>
<p>En el <b>terme d’energia</b>, com que teniu una <b>tarifa indexada</b>, els càrrecs (<b>CA</b>) ja estan inclosos en la fórmula per calcular el preu horari, tal com expliquem en aquest <a href="https://www.somenergia.coop/tarifa_indexada/CA_EiE_Explicacio_Tarifa_Indexada_Entitats_i_Empreses_Som_Energia.pdf">document</a>.
<br>
<p>PH = 1,015 * [(PrmDiari + Pc + Sc + I + POsOm) (1 + Perd) + FE + K] + PA + <a><u>CA</u></a></p>
<br>
<p>Com que el preu horari de l’energia varia cada dia i hora, no podem fer una estimació de l’estalvi que suposarà.</p>
<p>Pel que fa a la <b>rebaixa de l’impost elèctric</b>, que estava en vigor fins al 30 d’abril, el govern ha aprovat també allargar-la fins al 30 de juny. La rebaixa de l’IVA és fins a 10 kW de potència contractada, i no s’aplica en el vostre cas.</p>
<p>Com que es tracta d’un canvi normatiu, i tal com recullen les condicions particulars del contracte firmat, no és necessari formalitzar cap nou contracte o addenda.</p>
<p>Una salutació cordial,</p>
<br>
<p> Equip de Som Energia</p>
<p><a href="https://www.somenergia.coop/ca/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<p>Os escribimos para comunicaros que el gobierno ha aprobado una rebaja en los cargos de la electricidad, uno de los componentes regulados de la factura de la luz. Según establece el Real Decreto-Ley 6/2022, los nuevos cargos son de aplicación des del 31 de marzo hasta al 31 de diciembre de 2022. Para más información puedes consultar <a href="https://blog.somenergia.coop/destacados/2022/04/actualizacion-de-las-tarifas-con-el-nuevo-valor-de-los-cargos-anunciado-por-el-gobierno/">esta noticia del blog</a>. </p>
<p>Los cargos se aplican sobre la potencia contratada y la energía utilizada. </p>
<p>El <b>precio de la potencia contratada</b> la puedes encontrar en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">apartado de tarifas de la web</a>. Para vuestro contrato esta rebaja, en el término de potencia representará un ahorro anual de ${estalvi_euros} € (abans d'impostos).</p>
<p>En el <b>término de energía</b>, como tenéis una tarifa indexada, los cargos <b>(CA)</b> ya están incluidos enla fórmula para calcular el precio horario, tal como detallamos en este <a href="https://www.somenergia.coop/tarifa_indexada/ES_EiE_Explicacion_Tarifa_Indexada_Entidades_y_Empresas_Som_Energia.pdf">documento</a>.</p>
<br>
<p>PH = 1,015 * [(PrmDiario + Pc + Sc + I + POsOm)(1 + Perd) + FE + K] + PA + <b><u>CA</u></b></p>
<br>
<p>Como el precio horario de la energía varía cada día y hora, no podemos hacer una estimación del ahorro que supondrá.</p>
<p>En relación con la <b>rebaja del impuesto eléctrico</b>, que estaba en vigor hasta el 30 de abril, el gobierno ha aprobado también alargarla hasta el 30 de junio. La rebaja del IVA es has ta 10 kW de potencia contratada, y no se aplica en vuestro caso.</p>
<p>Como se trata de un cambio normativo, y tal como recogen las condiciones particulares de vuestro contrato, no es necesario formalizar ningún nuevo contrato o adenda.</p>
<p>Un saludo cordial,</p>
<br>
<p> Equipo de Som Energia</p>
<p> <a href="https://www.somenergia.coop/es/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
<br>
<p>${text_legal}</p>
</body>
</html>
