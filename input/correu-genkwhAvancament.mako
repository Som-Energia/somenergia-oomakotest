<!doctype html><html><head><meta charset="utf-8" /></head><body style='font-family:sans'><div style="float: right"><img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
<%
import datetime
Investment = object.pool.get('generationkwh.investment')

investment_ids = Investment.search(
    object._cr, object._uid,
    [
    ('member_id', '=', object.id),
    ],
    order='purchase_date ASC',
)

if not investment_ids:
    raise Exception("No investments for member {}".format(object.id))

purchasedate = Investment.read(
    object._cr, object._uid,
    investment_ids[0],
    ['purchase_date'],
    )['purchase_date']
purchasedate = datetime.datetime.strptime(purchasedate, "%Y-%m-%d").date()

lastbonuseddate = datetime.date(2016,4,26)

if purchasedate > lastbonuseddate:
    raise Exception(
        "Earliest investment at {} after the bonused date {}"
        .format(purchasedate, lastbonuseddate))

today = datetime.date(2019,5,13) # debug
today = datetime.date.today()

effectivedate = purchasedate + datetime.timedelta(days=+335)
def slashdate(date):
    return date.strftime('%d/%m/%Y')

try:
  if not object.vat_es_empresa(object.vat):
    name =' ' + object.name.split(',')[-1].strip()
  else:
    name = ''
except:
  name = ''


%>
Hola${name},

%if object.lang != 'es_ES':
<div style='text-align:center'>Ara que la Generació kWh ha començat a produir, gràcies a la teva confiança, i a la de moltes altres persones,</div>
<div style='text-align:center'>ara que ja podem començar a gaudir de la nostra energia a través de la factura elèctrica,</div>
<div style='text-align:center'>volem fer un gest d’agraïment a les primeres persones que heu donat suport a aquest nou model d’inversió quan encara només era una idea!</div>

<div style='text-align:center; font-weight:bold; font-size:160%'>Et regalem un mes de retorn energètic!</div>

Segons el que estava acordat, per començar a rebre l’energia, havia de passar un any des de que vas fer l’aportació, que va ser el dia ${slashdate(purchasedate)}. Però, en el teu cas, començarem un mes abans com a mostra d’agraïment.

%if effectivedate < today:
Així doncs, ja tens acumulats els kWh produïts a la planta d’Alcolea a partir del dia ${slashdate(effectivedate)} i es reflectirà a les factures que emetrem a partir d’ara als contractes que hagis assignat.
%else:
Així doncs, començarás a acumular els kWh produïts a la planta d’Alcolea a partir del dia ${slashdate(effectivedate)} i es reflectirà a les factures que emetrem a partir de llavors als contractes que hagis assignat.
%endif

<div style='text-align:center; font-size:160%'>Moltes gràcies i bona energia!!</div>

Equip de Som Energia.
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
<a href="http://www.generationkwh.org/ca">www.generationkwh.org</a>
%endif
%if object.lang != 'ca_ES':
<div style='text-align:center'>Ahora que la Generación kWh ha comenzado a producir, gracias a tu confianza, y a la de muchas otras personas,</div>
<div style='text-align:center'>ahora que ya podemos empezar a disfrutar de nuestra propia energía en la factura eléctrica,</div>
<div style='text-align:center'>¡Queremos hacer un gesto de agradecimiento a las primeras personas que apoyasteis este nuevo modelo de inversión cuando sólo era una idea!</div>

<div style='text-align:center; font-weight:bold; font-size:160%'>¡Te regalamos un mes de retorno energético!</div>

Según lo que estaba acordado, para empezar a recibir la energía, tenía que pasar un año desde que hiciste la aportación, que fue el dia ${slashdate(purchasedate)}. Pero, en tu caso, comenzaremos un mes antes como muestra de agradecimiento.

%if effectivedate < today:
Así pues, ya tienes acumulados los kWh producidos en la planta de Alcolea a partir del día ${slashdate(effectivedate)} y se reflejará en las facturas que emitiremos a partir de ahora en los contratos que hayas asignado.
%else:
Así pues, comenzarás a acumular los kWh producidos en la planta de Alcolea a partir del día ${slashdate(effectivedate)} y se reflejará en las facturas que emitiremos a partir de entonces en los contratos que hayas asignado.
%endif

<div style='text-align:center; font-size:160%'>¡¡ Muchas gracias y buena energía !!</div>

Equipo de Som Energia.
<a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
<a href="http://www.generationkwh.org/es">www.generationkwh.org</a>
%endif
</body></html>
