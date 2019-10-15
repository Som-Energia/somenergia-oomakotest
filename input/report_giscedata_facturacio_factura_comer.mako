<% from operator import attrgetter
from datetime import datetime, timedelta
import json
from collections import Counter
import locale
import calendar
locale.setlocale(locale.LC_NUMERIC,'es_ES.utf-8')
year_graph = 2018
pool = objects[0].pool
polissa_obj = objects[0].pool.get('giscedata.polissa')
factura_linia_obj = objects[0].pool.get('giscedata.facturacio.factura.linia')
model_obj = objects[0].pool.get('ir.model.data')
sup_territorials_tec_271_comer_obj = pool.get(
    'giscedata.suplements.territorials.2013.tec271.comer'
)

model_ids = model_obj.search(cursor, uid,
                                 [('module','=','giscedata_facturacio'),
                                  ('name','=','pricelist_tarifas_electricidad')])
tarifa_elect_atr = model_obj.read(cursor, uid, model_ids[0],['res_id'])['res_id']


comptador_factures = 0
def lap_year(date):
    a=datetime.strptime(date, '%Y-%m-%d').year
    return a % 4 == 0 and a % 100 != 0 or a % 400 == 0

gkwh_products = factura_linia_obj.get_gkwh_products(cursor, uid)

def get_atr_price(cursor, uid, tarifa, linia):
    pricelist_obj = linia.pool.get('product.pricelist')
    uom_obj = linia.pool.get('product.uom')
    model_obj = objects[0].pool.get('ir.model.data')
    factura_obj = objects[0].pool.get('giscedata.facturacio.factura')
    period_obj = objects[0].pool.get('giscedata.polissa.tarifa.periodes')

    tipus = linia.tipus
    uom_data = {'uom_name': linia.uos_id.name, 'factor': 1}
    quantity = linia.quantity
    product_id = linia.product_id.id

    if tipus == 'potencia':
        uom_data = {'uom_name': 'kW/mes', 'factor': 1}
    elif tipus == 'reactiva':
        model_ids = model_obj.search(cursor, uid,
                                     [('module','=','giscedata_facturacio'),
                                      ('name','=','product_cosfi')])
        product_id = model_obj.read(cursor, uid, model_ids[0],['res_id'])['res_id']
        quantity = l.cosfi * 100
    elif product_id in gkwh_products:
        # GKWH product. We need atr product to calc "peatges"
        period_atr_id = factura_obj.get_fare_period(
            cursor, uid, product_id, context=context
        )
        product_id = period_obj.read(
            cursor, uid, period_atr_id, ['product_id'], context=context
        )['product_id'][0]

    uom_id = uom_obj.search(cursor, uid, [('name', '=', uom_data['uom_name'])])[0]

    atr_price = pricelist_obj.price_get(cursor, uid, [tarifa],
                                        product_id, quantity,
                                        factura.company_id.partner_id.id,
                                        {'date': linia.data_desde,
                                         'uom_name': uom_id
                                         })[tarifa]
    return atr_price

def get_origen_lectura(cursor, uid, lectura):
    """Busquem l'origen de la lectura cercant-la a les lectures de facturació"""
    res = {lectura.data_actual: '',
           lectura.data_anterior: ''}

    lectura_obj = lectura.pool.get('giscedata.lectures.lectura')
    tarifa_obj = lectura.pool.get('giscedata.polissa.tarifa')
    origen_obj = lectura.pool.get('giscedata.lectures.origen')
    origen_comer_obj = lectura.pool.get('giscedata.lectures.origen_comer')

    estimada_id = origen_obj.search(cursor, uid, [('codi', '=', '40')])[0]
    sin_lectura_id = origen_obj.search(cursor, uid, [('codi', '=', '99')])[0]
    estimada_som_id = origen_comer_obj.search(cursor, uid,
                                              [('codi', '=', 'ES')])[0]

    #Busquem la tarifa
    tarifa_id = tarifa_obj.search(cursor, uid, [('name', '=',
                                                lectura.name[:-5])])
    if tarifa_id:
        tipus = lectura.tipus == 'activa' and 'A' or 'R'

        search_vals = [('comptador', '=', lectura.comptador),
                       ('periode.name', '=', lectura.name[-3:-1]),
                       ('periode.tarifa', '=', tarifa_id[0]),
                       ('tipus', '=', tipus),
                       ('name', 'in', [lectura.data_actual,
                                       lectura.data_anterior])]
        lect_ids = lectura_obj.search(cursor, uid, search_vals)
        lect_vals = lectura_obj.read(cursor, uid, lect_ids,
                                     ['name', 'origen_comer_id', 'origen_id'])
        for lect in lect_vals:
            # En funció dels origens, escrivim el text
            # Si Estimada (40) o Sin Lectura (99) i Estimada (ES): Estimada Somenergia
            # Si Estimada (40) o Sin Lectura (99) i F1/Q1/etc...(!ES): Estimada distribuïdora
            # La resta: Real
            origen_txt = _(u"real")
            if lect['origen_id'][0] in [ estimada_id, sin_lectura_id ]:
                if lect['origen_comer_id'][0] == estimada_som_id:
                    origen_txt = _(u"calculada per Som Energia")
                else:
                    origen_txt = _(u"estimada distribuïdora")

            res[lect['name']] = "%s" % (origen_txt)

    return res

def get_distri_phone(cursor, uid, polissa):
    """ Per telèfons de ENDESA segons CUPS, aprofitant funció de switching"""
    sw_obj = polissa.pool.get('giscedata.switching')
    pa_obj = polissa.pool.get('res.partner.address')

    partner_id = sw_obj.partner_map(cursor, uid,
                                    polissa.cups, polissa.distribuidora.id)
    if partner_id:
        pa_ids = pa_obj.search(cursor, uid, [('partner_id', '=', partner_id)])
        return (pa_obj.read(cursor, uid, [pa_ids[0]],['phone'])[0]['phone'] or
                polissa.distribuidora.address[0].phone)
    else:
        return polissa.distribuidora.address[0].phone

def get_gkwh_owner(cursor, uid, line):
    """Gets owner of gkwh line kwh"""
    if not line.is_gkwh().values()[0]:
        return ""

    line_owner_obj = line.pool.get('generationkwh.invoice.line.owner')
    line_owner_id = line_owner_obj.search(
        cursor, uid,([('factura_line_id', '=', l.id)])
    )
    if not line_owner_id:
        return ""
    partner_obj = line.pool.get('res.partner')

    owner_vals = line_owner_obj.read(
       cursor, uid, line_owner_id[0], ['owner_id']
    )

    owner = partner_obj.browse(cursor, uid, owner_vals['owner_id'][0])

    return get_nom_cognoms(cursor, uid, owner)

def get_nom_cognoms(cursor, uid, owner):
   """ Returns name surnames. It considers enterprise/person """

   partner_obj = owner.pool.get('res.partner')

   name_dict = partner_obj.separa_cognoms(cursor, uid, owner.name)
   is_enterprise = partner_obj.vat_es_empresa(cursor, uid, owner.vat)

   if is_enterprise:
       return name_dict['nom']

   return "{0} {1}".format(name_dict['nom'], ' '.join(name_dict['cognoms']))

historic_sql = """SELECT * FROM (
SELECT mes AS mes,
periode AS periode,
sum(suma_fact) AS facturat,
sum(suma_consum) AS consum,
min(data_ini) AS data_ini,
max(data_fin) AS data_fin
FROM (
SELECT f.polissa_id AS polissa_id,
       to_char(f.data_inici, 'YYYY/MM') AS mes,
       pt.name AS periode,
       COALESCE(SUM(il.quantity*(fl.tipus='energia')::int*(CASE WHEN i.type='out_refund' THEN -1 ELSE 1 END)),0.0) as suma_consum,
       COALESCE(SUM(il.price_subtotal*(fl.tipus='energia')::int*(CASE WHEN i.type='out_refund' THEN -1 ELSE 1 END)),0.0) as suma_fact,
       MIN(f.data_inici) data_ini,
       MAX(f.data_final) data_fin
       FROM
            giscedata_facturacio_factura f
            LEFT JOIN account_invoice i on f.invoice_id = i.id
            LEFT JOIN giscedata_facturacio_factura_linia fl on f.id=fl.factura_id
            LEFT JOIN account_invoice_line il on il.id=fl.invoice_line_id
            LEFT JOIN product_product pp on il.product_id=pp.id
            LEFT JOIN product_template pt on pp.product_tmpl_id=pt.id
       WHERE
            fl.tipus = 'energia' AND
            f.polissa_id = %(p_id)s AND
            f.data_inici <= %(data_inicial)s AND
            f.data_inici >= date_trunc('month', date %(data_final)s) - interval '14 month'
            AND (fl.isdiscount IS NULL OR NOT fl.isdiscount)
            AND i.type IN ('out_invoice','out_refund')
       GROUP BY
            f.polissa_id, pt.name, f.data_inici
       ORDER BY f.data_inici DESC ) AS consums
GROUP BY polissa_id, periode, mes
ORDER BY mes DESC, periode ASC
) consums_ordenats
ORDER BY mes ASC"""

# Repartiment segons BOE
rep_BOE = {'i': 39.44, 'c': 40.33 ,'o': 20.23}

%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<head>
<link rel="stylesheet" href="${addons_path}/giscedata_facturacio_comer_som/report/pie.css"/>
<link rel="stylesheet" href="${addons_path}/giscedata_facturacio_comer_som/report/consum.css"/>
<link rel="stylesheet" href="${addons_path}/giscedata_facturacio_comer_som/report/giscedata_facturacio_comer_som.css"/>
<script src="${addons_path}/giscedata_facturacio_comer/report/assets/d3.min.js"></script>
</head>
<body>
%for factura in objects:
<% setLang(factura.lang_partner)

polissa = polissa_obj.browse(cursor, uid, factura.polissa_id.id,
                             context={'date': factura.data_final.val})

# Agreement partners
agreementPartners = {'S019753': {'ref': 'S019753', 'invoice_data_background': '#499944'}}
agreementPartner = agreementPartners[polissa.soci.ref] if polissa.soci.ref in agreementPartners.keys() else None

invoice_data_background = "#bdc83f"
if agreementPartner:
    invoice_data_background = agreementPartner['invoice_data_background']


tarifa_elect_som = polissa.llista_preu.id

dphone = get_distri_phone(cursor, uid, polissa)
cphone = factura.company_id.partner_id.address[0].phone
distri_phone = '.'.join([dphone[i:i+3] for i in range(0,len(dphone),3)])
comer_phone = '.'.join([cphone[i:i+3] for i in range(0,len(cphone),3)])

factura._cr.execute(historic_sql,{'p_id':factura.polissa_id.id,
                                  'data_inicial': factura.data_inici,
                                  'data_final': factura.data_final,
                                  })
historic = factura._cr.dictfetchall()

historic_graf = {}
periodes_graf = []

for row in historic:
    historic_graf.setdefault(row['mes'],{})
    historic_graf[row['mes']].update({row['periode']: row['consum']})
    periodes_graf.append(row['periode'])

periodes_graf = list(set(periodes_graf))

historic_js = []
for mes in sorted(historic_graf):
    consums = historic_graf[mes]
    p_js = {'mes': datetime.strptime(mes, '%Y/%m').strftime('%m/%y')}
    for p in periodes_graf:
        p_js.update({p: consums.get(p, 0.0)})
    historic_js.append(p_js)

total_historic_kw = sum([h['consum'] for h in historic])
total_historic_eur = sum([h['facturat'] for h in historic])
data_ini = min([h['data_ini'] for h in historic])
data_fin = max([h['data_fin'] for h in historic])
historic_dies = (datetime.strptime(data_fin, '%Y-%m-%d') - datetime.strptime(data_ini, '%Y-%m-%d')).days

mes_any_inicial = (datetime.strptime(factura.data_inici,'%Y-%m-%d') - timedelta(days=365)).strftime("%Y/%m")
total_any = sum([h['consum'] for h in historic if h['mes'] > mes_any_inicial])

iese_lines = [l for l in factura.tax_line if 'IVA' not in l.name and 'IGIC' not in l.name]
iva_lines = [l for l in factura.tax_line if 'IVA' in l.name]
igic_lines = [l for l in factura.tax_line if 'IGIC' in l.name]

impostos = {}
for l in factura.tax_line:
    impostos.update({l.name: l.amount})

iese = sum([v for k, v in impostos.items() if 'IVA' not in k and 'IGIC' not in k])

#TODO:  Quan es processin les línies, repassar una forma + eficient
lloguer_lines = [l for l in factura.linia_ids if l.tipus in 'lloguer']
bosocial_lines = [l for l in factura.linia_ids if l.tipus in 'altres'
                  and l.invoice_line_id.product_id.code == 'BS01']
donatiu_lines = [l for l in factura.linia_ids if l.tipus in 'altres'
                and l.invoice_line_id.product_id.code == 'DN01']
altres_lines = [l for l in factura.linia_ids if l.tipus in 'altres'
                and l.invoice_line_id.product_id.code not in ('DN01', 'BS01')]

donatiu = sum([l.price_subtotal for l in donatiu_lines])
total_bosocial = sum([l.price_subtotal for l in bosocial_lines])
total_altres = sum([l.price_subtotal for l in altres_lines])

periodes_a = sorted(list(set([lectura.name[-3:-1]
                            for lectura in factura.lectures_energia_ids
                            if lectura.tipus == 'activa'])))

periodes_r = sorted(list(set([lectura.name[-3:-1]
                            for lectura in factura.lectures_energia_ids
                            if lectura.tipus == 'reactiva'])))

periodes_m = sorted(list(set([lectura.name
                              for lectura in factura.lectures_potencia_ids])))

fact_pot_txt = ((polissa.facturacio_potencia=='max' or len(periodes_a)>3)
                    and _(u"facturació per maxímetre")
                 or _(u"facturació per ICP"))

# lectures (activa) ordenades per comptador i període
lectures_a = {}
lectures_r = {}
lectures_m = []
lectures_real_a = {}
lectures_real_r = {}

for lectura in factura.lectures_energia_ids:
    origens = get_origen_lectura(cursor, uid, lectura)
    if lectura.tipus == 'activa':
        lectures_a.setdefault(lectura.comptador,[])
        lectures_a[lectura.comptador].append((lectura.name[-3:-1],
                                            lectura.lect_anterior,
                                            lectura.lect_actual,
                                            lectura.consum,
                                            lectura.data_anterior,
                                            lectura.data_actual,
                                            origens[lectura.data_anterior],
                                            origens[lectura.data_actual],
                                            lectura.ajust,
                                            ))
        lectura_real = sorted([lectura_real for lectura_real in lectura.comptador_id.pool_lectures if lectura_real.tipus == "A" and "{} ({})".format(lectura_real.periode.tarifa.name,lectura_real.periode.product_id.name) == lectura.name and lectura_real.origen_id.id not in [7,9,22,23] and datetime.strptime(lectura_real.name, '%Y-%m-%d')<datetime.strptime(lectura.data_actual, '%Y-%m-%d')], reverse=True, key=lambda l:l.name)
        lectures_real_a.setdefault(lectura.comptador,[])
        if len(lectura_real)>0:
            lectures_real_a[lectura.comptador].append((lectura.name[-3:-1],lectura_real[0].lectura,lectura_real[0].name))
        else:
            lectura_real = sorted([lectura_real for lectura_real in lectura.comptador_id.lectures if lectura_real.tipus == "A" and  "{} ({})".format(lectura_real.periode.tarifa.name,lectura_real.periode.product_id.name) == lectura.name and lectura_real.origen_id.id not in [7,9,22,23] and datetime.strptime(lectura_real.name, '%Y-%m-%d')<datetime.strptime(lectura.data_actual, '%Y-%m-%d')], reverse=True, key=lambda l:l.name)
            if len(lectura_real)>0:
                lectures_real_a[lectura.comptador].append((lectura.name[-3:-1],lectura_real[0].lectura,lectura_real[0].name))

    elif lectura.tipus == 'reactiva':
        lectures_r.setdefault(lectura.comptador,[])
        lectures_r[lectura.comptador].append((lectura.name[-3:-1],
                                            lectura.lect_anterior,
                                            lectura.lect_actual,
                                            lectura.consum,
                                            lectura.data_anterior,
                                            lectura.data_actual,
                                            origens[lectura.data_anterior],
                                            origens[lectura.data_actual],
                                            ))
        lectura_real = sorted([lectura_real for lectura_real in lectura.comptador_id.pool_lectures if lectura_real.tipus == "R" and "{} ({})".format(lectura_real.periode.tarifa.name,lectura_real.periode.product_id.name) == lectura.name and lectura_real.origen_id.id not in [7,22,23] and datetime.strptime(lectura_real.name, '%Y-%m-%d')<datetime.strptime(lectura.data_actual, '%Y-%m-%d')], reverse=True, key=lambda l:l.name)
        lectures_real_r.setdefault(lectura.comptador,[])
        if len(lectura_real)>0:
            lectures_real_r[lectura.comptador].append((lectura.name[-3:-1],lectura_real[0].lectura,lectura_real[0].name))
        else:
            lectura_real = sorted([lectura_real for lectura_real in lectura.comptador_id.lectures if lectura_real.tipus == "R" and  "{} ({})".format(lectura_real.periode.tarifa.name,lectura_real.periode.product_id.name) == lectura.name and lectura_real.origen_id.id not in [7,22,23] and datetime.strptime(lectura_real.name, '%Y-%m-%d')<datetime.strptime(lectura.data_actual, '%Y-%m-%d')], reverse=True, key=lambda l:l.name)
            if len(lectura_real)>0:
                lectures_real_r[lectura.comptador].append((lectura.name[-3:-1],lectura_real[0].lectura,lectura_real[0].name))

for lectura in factura.lectures_potencia_ids:
    lectures_m.append((lectura.name, lectura.pot_contract,
                       lectura.pot_maximetre ))

for lects in lectures_a.values():
    sorted(lectures_a, key=lambda x: x[0])

for lects in lectures_r.values():
    sorted(lectures_r, key=lambda x: x[0])

for lects in lectures_m:
    sorted(lectures_m, key=lambda x: x[0])

total_lectures_a = dict([(p, 0) for p in periodes_a])
total_lectures_r = dict([(p, 0) for p in periodes_r])
fact_potencia = dict([(p,0) for p in periodes_m])

dies_factura = (datetime.strptime(factura.data_final, '%Y-%m-%d') - datetime.strptime(factura.data_inici, '%Y-%m-%d')).days + 1
diari_factura_actual_eur = factura.total_energia / (dies_factura or 1.0)
diari_factura_actual_kwh = (factura.energia_kwh * 1.0) / (dies_factura or 1.0)

for c, ls in lectures_a.items():
    for l in ls:
        total_lectures_a[l[0]] += l[3]

for c, ls in lectures_r.items():
    for l in ls:
        total_lectures_r[l[0]] += l[3]

for p in [(p.product_id.name, p.quantity) for p in factura.linies_potencia]:
    fact_potencia.update({p[0]: max(fact_potencia.get(p[0], 0), p[1])})

# ATR Peatges Energia dict
atr_linies_energia = {}

for l in sorted(sorted(factura.linies_energia, key=attrgetter('data_desde')), key=attrgetter('name')):
    l_count = Counter({
        'quantity': int(l.quantity),
        'atrprice_subtotal': l.atrprice_subtotal
    })
    l_name = l.name[:2]
    if not l_name in atr_linies_energia.keys():
        atr_linies_energia[l.name[:2]] = l_count
        atr_linies_energia[l.name[:2]].update(
            {'price': get_atr_price(cursor, uid, tarifa_elect_atr,l)}
        )
    else:
        atr_linies_energia[l.name[:2]] += l_count

#comprovem si té alguna lectura de maxímetre

te_maximetre = polissa.facturacio_potencia=='max' or len(periodes_a)>3

text_lateral = (_(u"%s Amb seu social a %s . %s - %s - Inscrita al Registre General de Cooperatives, full 13936, Inscripció 1a CIF: %s")
                % (factura.company_id.name,factura.company_id.partner_id.address[0].street,
                   factura.company_id.partner_id.address[0].zip, factura.company_id.partner_id.address[0].city,
                   factura.company_id.partner_id.vat.replace('ES','')))

# DADES PIE CHART
pie_total = factura.amount_total - factura.total_lloguers
pie_regulats = (factura.total_atr + total_altres)
pie_impostos = float(factura.amount_tax)
pie_costos = (pie_total - pie_regulats - pie_impostos )

reparto = { 'i': ((pie_regulats * rep_BOE['i'])/100),
            'c': ((pie_regulats * rep_BOE['c'])/100),
            'o': ((pie_regulats * rep_BOE['o'])/100)
           }

dades_reparto = [
    [[0, rep_BOE['i']], 'i', _(u"Incentius a les energies renovables, cogeneració i residus"), formatLang(reparto['i'])],
     [[rep_BOE['i'] , rep_BOE['i'] + rep_BOE['c']], 'c', _(u"Cost de xarxes de distribució i transport"), formatLang(reparto['c'])] ,
     [[rep_BOE['i'] + rep_BOE['c'], 100.00], 'o', _(u"Altres costos regulats (inclosa anualitat del dèficit)"), formatLang(reparto['o'])]
    ]
%>
<%def name="emergency_complaints(factura)">
    <div class="emergency">
        <h1>${_(u"AVARIES I URGÈNCIES")}</h1>
        <p style="line-height: 1.0;">${_(u"Empresa distribuïdora:")} <span style="font-weight: bold;">${polissa.distribuidora.name}</span> <br />
        ${_(u"Núm. de contracte de la distribuïdora:")} <span style="font-weight: bold;">${polissa.ref_dist or ''}</span> <br />
        ${_(u"AVARIES I URGÈNCIES DEL SUBMINISTRAMENT (distribuïdora): %s (24 hores)") % distri_phone}<br />
        </p>
    </div>
    <div class="complaints">
        <h1>${_(u"RECLAMACIONS")}</h1>
        <p style="line-height: 1.0;">${_(u"RECLAMACIONS COMERCIALITZACIÓ (SOM ENERGIA): Horari d'atenció de 9 a 14 h. 900 103 605 (cost de la trucada per a la cooperativa).<br />"
               u"Si tens tarifa plana, pots contactar igualment al %s, sense cap cost.<br />"
               u"Adreça electrònica: reclama@somenergia.coop<br />"
               u"Adreça postal: C/ Pic de Peguera, 11, A 2 8. Edifici Giroemprèn. 17003 - Girona<br />") % (comer_phone,)}
               % if agreementPartner:
                   ${_ (u"Som Energia és la teva comercialitzadora elèctrica a mercè de l'acord firmat amb")} ${polissa.soci.name} <br />
               % endif
        </p>
    </div>
</%def>
<div class="lateral_container">
    <div class="lateral" style="top: 250px;">${text_lateral}</div>
    <div class="lateral" style="top: 1350px;">${text_lateral}</div>
    <div class="lateral" style="top: 2450px;">${text_lateral}</div>
</div>
<div id="container">
    <div class="company_address" style="font-size: .7em;">
        <div class="logo" style="margin-bottom: 15px; ">
            % if agreementPartner:
                <img src="${addons_path}/giscedata_facturacio_comer_som/report/logo_som.png" width="95px"/>
                <img src="${addons_path}/giscedata_facturacio_comer_som/report/logo_${agreementPartner['ref']}.png" width="95px"/>
            % else:
                <img src="${addons_path}/giscedata_facturacio_comer_som/report/logo_som.png" width="125px"/>
            % endif
        </div>
    <span style="font-weight: bold;">${factura.company_id.partner_id.name}</span><br />
    ${_(u"CIF:")} ${factura.company_id.partner_id.vat.replace('ES','')} <br />
    ${_(u"Domicili:")} ${factura.company_id.partner_id.address[0].street} ${factura.company_id.partner_id.address[0].zip} - ${factura.company_id.partner_id.address[0].city}<br />
    ${_(u"Adreça electrònica:")} ${factura.company_id.partner_id.address[0].email}
    </div>
    <div class="invoice_data">
        % if factura.is_gkwh:
              <div class="logo_gkwh">
                  <img src="${addons_path}/giscedata_facturacio_comer_som/report/logo_gkwh.png" width="95px"/>
              </div>
        % endif
        <h1 style="background-color: ${invoice_data_background};">${_(u"DADES DE LA FACTURA")}</h1>
         <div style="font-weight: 900;font-size: 1.3em">${_("IMPORT DE LA FACTURA:  %s &euro;") % formatLang(factura.amount_total)}
         % if factura.invoice_id.type == 'out_refund':
             (${_(u"ABONAMENT")})
         % endif
         </div>
        <p>${_(u"Núm. de factura:")} <span style="font-weight: bold;">${factura.number}</span> <br />
        % if factura.invoice_id.type == 'out_refund' and factura.ref:
            ${_(u"Aquesta factura anul·la la factura")} ${factura.ref.number} <br />
        % endif
        ${_(u"Data de la factura:")} <span style="font-weight: bold;">${factura.date_invoice}</span> <br />
        ${_(u"Període facturat:")} <span style="font-weight: bold;">${_("del %s al %s") % (factura.data_inici, factura.data_final)}</span> <br />
        ${_(u"Núm. de contracte:")} <span style="font-weight: bold;">${polissa.name}</span> <br />
        ${_(u"Adreça de subministrament:")} <span style="font-weight: bold;">${factura.cups_id.direccio}</span> <br />
        </p>
        <div style="background-color: ${invoice_data_background}; height: 2px; padding: 0px;"></div>
    </div>

    <%
        total_exces_consumida = 0.0
        exces_potencia = sorted(sorted([l for l in factura.linia_ids if l.tipus == 'exces_potencia'], key=attrgetter('price_unit_multi'), reverse=True), key=attrgetter('name'))
        if exces_potencia:
            for line in exces_potencia:
                total_exces_consumida += line.price_subtotal
    %>

    <div class="invoice_summary">
        <h1>${_(u"RESUM DE LA FACTURA")}</h1>
        <table>
        <tr><td>${_(u"Per energia utilitzada")}</td><td class="e">${"%s &euro;" % formatLang(factura.total_energia)}</td></tr>
        <tr><td>${_(u"Per potència contractada")}</td><td class="e">${"%s &euro;" % formatLang(factura.total_potencia)}</td></tr>
    % if exces_potencia:
        <tr><td>${_(u"Excés de potència")}</td><td class="e">${"%s &euro;" % formatLang(total_exces_consumida)}</td></tr>
    % endif
    % if factura.total_reactiva > 0:
        <tr><td>${_("Penalització per energia reactiva")}</td><td class="e">${"%s &euro;" % formatLang(factura.total_reactiva)}</td></tr>
    % endif
        <tr><td>${_(u"Impost d'electricitat")}</td><td class="e">${"%s &euro;" % formatLang(iese)}</td></tr>
        <tr><td>${_(u"Lloguer del comptador")}</td><td class="e">${"%s &euro;" % formatLang(factura.total_lloguers)}</td></tr>
    % if (total_altres + total_bosocial) != 0:
        <tr><td>${_("Altres conceptes")}</td><td class="e">${"%s &euro;" % formatLang(total_altres + total_bosocial)}</td></tr>
    % endif
    % for n, v in impostos.items():
        % if "IVA" in n or "IGIC" in n:
            <tr><td>${n}</td><td class="e">${"%s &euro;" % formatLang(v)}</td></tr>
        % endif
    % endfor
    % if donatiu > 0:
        <tr><td>${_(u"Donatiu voluntari (0,01 &euro;/kWh) (exempt d'IVA)")}</td><td class="e">${"%s &euro;" % formatLang(donatiu)}</td></tr>
    % endif
        <tr class="total"><td>${_(u"TOTAL IMPORT FACTURA")}</td><td class="e">${"%s &euro;" % formatLang(factura.amount_total)}</td></tr>
        </table>
    </div>
    <div class="partner_data">
        <div class="owner_data">
            <h1>${_(u"DADES DEL TITULAR")}</h1>
            <p>${_(u"Nom del / de la titular del contracte: ")} <span style="font-weight: bold;">${polissa.titular.name}</span><br />
            ${_(u"NIF/CIF:")} <span style="font-weight: bold;">${polissa.titular.vat.replace('ES','')}</span> <br /></p>
        </div>
        <div class="payment_data">
            % if factura.invoice_id.type == 'out_refund':
                <h1>${_(u"DADES D'ABONAMENT")}</h1>
            % endif
            % if not factura.invoice_id.type == 'out_refund':
                <h1>${_(u"DADES DE PAGAMENT")}</h1>
            % endif
            <p>${_(u"Nom de la persona pagadora:")} <span style="font-weight: bold;">${factura.partner_id.name}</span> <br />
            ${_(u"NIF/CIF:")} <span style="font-weight: bold;">${factura.partner_id.vat.replace('ES','')}</span> <br />
            ${_(u"Entitat bancària:")} <span style="font-weight: bold;">${factura.partner_bank.bank.name if polissa.tipo_pago.code != 'TRANSFERENCIA_CSB' else _(u"TRANSFERÈNCIA")}</span> <br />
            ${_(u"Núm. compte bancari:")} <span style="font-weight: bold;">${factura.partner_bank.iban[:-5]+"*****" if polissa.tipo_pago.code != 'TRANSFERENCIA_CSB' else polissa.payment_mode_id.bank_id.iban+" (Som Energia, SCCL)"}</span> <br />
              </p>
            <hr />
            % if not factura.invoice_id.type == 'out_refund':
                % if polissa.tipo_pago.code != 'TRANSFERENCIA_CSB':
                    <p style="font-size: .8em">${_(u"L'import d'aquesta factura es carregarà al teu compte. El seu pagament queda justificat amb l'apunt bancari corresponent.")}</p>
                % else:
                    <p style="font-size: .8em">${_(u"L'import d'aquesta factura es pagarà mitjançant transferència bancària al compte indicat.")}</p>
                % endif
            % endif
        </div>
    </div>
    <!-- LECTURES ACTIVA i GRÀFIC BARRES -->
    <div class="energy_info">
        <h1>${_(u"INFORMACIÓ DEL CONSUM ELÈCTRIC")}</h1>
        <div class="lectures${len(periodes_a)>3 and '30' or ''}">
            <table>
            <tr><th>&nbsp;</th>
% for periode in periodes_a:
            <th style="text-align: center;">${periode}</th>
% endfor
            </tr>
<%
    ajust_periode = []
    hi_ha_ajust = False
%>
% for comptador in sorted(lectures_a):
            <tr>
                <th>${_(u"Núm. de comptador")}</th>
            % for p in periodes_a:
                <td style="font-weight: normal;text-align: center;">${comptador}</td>
            % endfor
            </tr>
            <tr>
                <th>${_(u"Lectura anterior")}<span style="font-weight: 100">&nbsp;(${lectures_a[comptador][0][4]})<br/>(${lectures_a[comptador][0][6]})</span></th>
    <!--%for lectura in lectures_a[comptador]:-->
    % for periode in periodes_a:
                  <%
                    for lectura in lectures_a[comptador]:
                        if lectura[8] == 0:
                            ajust_periode.append(False)
                        else:
                            ajust_periode.append(True)
                            hi_ha_ajust = True
                  %>
                  % if periode not in [lectura[0] for lectura in lectures_a[comptador]]:
                      <td></td>
                  % else:
                      <td style="text-align: center;">${int([lectura[1] for lectura in lectures_a[comptador] if lectura[0] == periode][0])} kWh</td>
                  % endif
    %endfor
            </tr>
                <th>${_(u"Lectura final")}<span style="font-weight: 100">&nbsp;(${lectures_a[comptador][0][5]})<br/>(${lectures_a[comptador][0][7]})</span></th>
    % for periode in periodes_a:
                  % if periode not in [lectura[0] for lectura in lectures_a[comptador]]:
                      <td></td>
                  % else:
                      <td style="text-align: center;">${int([lectura[2] for lectura in lectures_a[comptador] if lectura[0] == periode][0])} kWh</td>
                  % endif
    %endfor
            </tr>
% endfor
            <tr>
                <th style="border-top: 1px solid #4c4c4c">${_(u"Total període")}</th>
    %for p in periodes_a:
                <td style="border-top: 1px solid #4c4c4c; text-align: center;">${formatLang(total_lectures_a[p], digits=0)} kWh
                    % if ajust_periode[periodes_a.index(p)]:
                        *
                    %endif
                </td>
    %endfor
            </tr>
            </table>
            <div style="text-align: center"><p>${_(u"La despesa diària és de %s € que correspon a %s kWh/dia (%s dies).") % (formatLang(diari_factura_actual_eur), formatLang(diari_factura_actual_kwh), dies_factura or 1)}</p></div>
            % if hi_ha_ajust:
                <div style="text-align: center"><p>${_("* Aquesta factura recull un ajust de consum de períodes anteriors per part de la distribuïdora.")}</p></div>
            % endif
        </div>
        <div class="chart_consum_container">
            <div class="chart_consum" id="chart_consum_${factura.id}"></div>
            <div class="chart_estadistica"><p>${(_(u"La despesa mitjana diària en els últims %.0f mesos (%s dies) ha estat de <b>%s</b> €, que corresponen a <b>%s</b> kWh/dia.")
                       % ((historic_dies*1.0 / 30), historic_dies or 1.0, formatLang((total_historic_eur * 1.0) / (historic_dies or 1.0)), formatLang((total_historic_kw * 1.0) / (historic_dies or 1.0))))}<br />
                    ${_(u"L'electricitat utilitzada durant el darrer any: <b>%s</b> kWh.") % formatLang(total_any, digits=0)}
                 </p></div>
        </div>
        %if any([lectures_a[comptador][0][7] != "real" for comptador in sorted(lectures_a) if len(lectures_real_a[comptador])>0]):
            <div class="lectures${len(periodes_a)>3 and '30' or ''}">
                <table>
                % for comptador in sorted(lectures_real_a):
                  % if len(lectures_real_a[comptador])>0:  
                      <tr>
                        <th>&nbsp;</th>
                        % for periode in periodes_a:
                          <th style="text-align: center;">${periode}</th>
                        % endfor
                      </tr>
                      <tr>
                        <th>${_(u"Núm. de comptador")}</th>
                        % for p in periodes_a:
                          <td style="font-weight: normal;text-align: center;">${comptador}</td>
                        % endfor
                      </tr>
                      <tr>
                        <th>${_(u"Darrera lectura real ")}<span style="font-weight: 100">(${lectures_real_a[comptador][0][2]})</span></th>
                        % for periode in periodes_a:
                          % if periode not in [lectura_real[0] for lectura_real in lectures_real_a[comptador]]:
                            <td></td>
                          % else:
                            <td style="text-align: center;">${int([lectura_real[1] for lectura_real in lectures_real_a[comptador] if lectura_real[0] == periode][0])} KWh</td>
                          % endif
                        % endfor
                      </tr>
                  %endif
                % endfor
                </table>
            </div>
        %endif
    </div>
    <div class="contract_data">
        <h1>${_(u"DADES DEL CONTRACTE")}</h1>
        <p>${_(u"Adreça de subministrament:")} <span style="font-weight: bold;">${factura.cups_id.direccio}</span> <br />
        ${_(u"Potència contractada (kW):")} <span style="font-weight: bold;">${"%s (%s)" % (locale.str(locale.atof(formatLang(polissa.potencia, digits=3))),fact_pot_txt)}</span> <br />
        ${_(u"Tarifa contractada:")} <span style="font-weight: bold;">${polissa.tarifa.name}</span> <br />
        ${_(u"CUPS:")} <span style="font-weight: bold;">${factura.cups_id.name}</span> <br />
        ${_(u"Comptador telegestionat:")} <span style="font-weight: bold;">${polissa.tg in ['1','3'] and _(u'Sí') or _(u'No')}</span> <br />
        ${_(u"CNAE:")} <span style="font-weight: bold;">${polissa.cnae.name}</span> <br />
        ${_(u'Data d\'alta del contracte: <span style="font-weight: bold;">%s</span>, sense condicions de permanència') % polissa.data_alta} <br />
        ${_(u'Forma de pagament: rebut domiciliat')} <br />
        ${_(u'Data de renovació automàtica: <span style="font-weight: bold;">%s</span>') % datetime.strptime(polissa.data_alta, '%Y-%m-%d').replace(datetime.now().year + 1).strftime('%Y-%m-%d')}
        </p>
    </div>
% if len(periodes_a) <= 3:
${emergency_complaints(factura)}
% endif
    <p style="page-break-after:always"></p>
<!-- DESTI DE LA FACTURA -->
% if len(periodes_a) <= 3:
    <div class="destination">
        <h1>${_(u"DESTÍ DE L'IMPORT DE LA FACTURA")}</h1>
        <p>${_(u"El destí de l'import de la teva factura, %s euros, és el següent:") % formatLang(factura.amount_total)}</p>
        <div class="chart_desti" id="chart_desti_${factura.id}"></div>
% if factura.total_lloguers:
        <p>${_(u"Als imports indicats en el diagrama s'ha d'afegir, si s'escau, el lloguer dels equips de mesura i control: %s €.") % formatLang(factura.total_lloguers)}</p>
% endif
    </div>
% endif
<!-- LECTURES REACTIVA I MAXÍMETRE -->
% if len(periodes_r) or te_maximetre:
    <div class="other_measures">
        % if len(periodes_r):
        <div class="lectures_reactiva${len(periodes_r)>3 and '30' or ''}">
        <h1>${_(u"ENERGIA REACTIVA")}</h1>
            <table style="margin: 1em">
            <tr><th>&nbsp;</th>
% for periode in periodes_r:
            <th style="text-align: center;">${periode}</th>
% endfor
            </tr>
% for comptador in sorted(lectures_r):
            <tr>
                <th>${_(u"Núm. de comptador")}</th>
            % for p in periodes_r:
                <td style="font-weight: normal;text-align: center;">${comptador}</td>
            % endfor
            </tr>
            <tr>
                <th>${_(u"Lectura anterior")}<span style="font-weight: 100">&nbsp;(${lectures_r[comptador][0][4]})<br/>(${lectures_r[comptador][0][6]})</span></th>
   % for periode in periodes_r:
                  % if periode not in [lectura[0] for lectura in lectures_r[comptador]]:
                      <td></td>
                  % else:
                      <td style="text-align: center;">${int([lectura[1] for lectura in lectures_r[comptador] if lectura[0] == periode][0])} kVArh</td>
                  % endif
    %endfor
            </tr>
                <th>${_(u"Lectura final")}<span style="font-weight: 100">&nbsp;(${lectures_r[comptador][0][5]})<br/>(${lectures_r[comptador][0][7]})</span></th>
    % for periode in periodes_r:
                  % if periode not in [lectura[0] for lectura in lectures_r[comptador]]:
                      <td></td>
                  % else:
                      <td style="text-align: center;">${int([lectura[2] for lectura in lectures_r[comptador] if lectura[0] == periode][0])} kVArh</td>
                  % endif
    %endfor
            </tr>
% endfor
            <tr>
                <th style="border-top: 1px solid #4c4c4c">${_(u"Total període")}</th>
    %for p in periodes_r:
                <td style="border-top: 1px solid #4c4c4c; text-align: center;">${formatLang(total_lectures_r[p], digits=0)} kVArh</td>
    %endfor
            </tr>
            </table>
        %if any([lectures_r[comptador][0][7] != "real" for comptador in sorted(lectures_r) if len(lectures_real_r[comptador])>0]):
            <table style="margin: 1em">
            % for comptador in sorted(lectures_real_r):
              % if len(lectures_real_r[comptador])>0:
                <tr>
                  <th>&nbsp;</th>
                  % for periode in periodes_a:
                    <th style="text-align: center;">${periode}</th>
                  % endfor
                </tr>
                <tr>
                  <th>${_(u"Núm. de comptador")}</th>
                  % for p in periodes_a:
                    <td style="font-weight: normal;text-align: center;">${comptador}</td>
                  % endfor
                </tr>
                <tr>
                  <th>${_(u"Darrera lectura real ")}<span style="font-weight: 100">(${lectures_real_r[comptador][0][2]})</span></th>
                  % for periode in periodes_r:
                    % if periode not in [lectura_real[0] for lectura_real in lectures_real_r[comptador]]:
                      <td></td>
                    % else:
                      <td style="text-align: center;">${int([lectura_real[1] for lectura_real in lectures_real_r[comptador] if lectura_real[0] == periode][0])} KVArh</td>
                    % endif
                  % endfor
              % endif
            %endfor
                </tr>
            </table>
        %endif

        </div>
    % endif
    % if te_maximetre:
    <div class="lectures_max${len(periodes_r)>3 and '30' or ''}">
        <h1>${_(u"MAXÍMETRE")}</h1>
            <table style="margin: 1em">
            <tr><th>&nbsp;</th>
% for periode in periodes_m:
            <th style="text-align: center;">${periode}</th>
% endfor
            </tr>
            <tr><th>${_(u"Potència contractada")}</th>
% for lectura in lectures_m:
            <td style="text-align: center;">${locale.str(locale.atof(formatLang(lectura[1], digits=3)))}</td>
% endfor
            </tr>
            <tr><th>${_(u"Lectura maxímetre")}</th>
% for lectura in lectures_m:
            <td style="text-align: center;">${locale.str(locale.atof(formatLang(lectura[2], digits=3)))}</td>
% endfor
            </tr>
            <tr><th>${_(u"Potència facturada")}</th>
% for periode in sorted(fact_potencia):
            <td style="text-align: center;">${locale.str(locale.atof(formatLang(fact_potencia[periode], digits=3)))}</td>
% endfor
            </tr>
% if exces_potencia:
            <tr><th>${_(u"Quantitat excedida")}</th>
% for periode in sorted(fact_potencia):
    <% trobat = False %>
    % for exces in exces_potencia:
        % if exces.name == periode:
            <td style="text-align: center;">${int(exces.quantity)}</td>
            <% trobat = True %>
        % endif
    % endfor
    % if not trobat:
        <td style="text-align:center;">0</td>
    % endif
% endfor
            </tr>
            <tr><th>${_(u"Import excés de Potència(€)")}</th>
% for periode in sorted(fact_potencia):
    <% trobat = False %>
    % for exces in exces_potencia:
        % if exces.name == periode:
            <td style="text-align: center;">${formatLang(exces.price_subtotal)}</td>
            <% trobat = True %>
        % endif
    % endfor
    % if not trobat:
        <td style="text-align:center;">0</td>
    % endif
% endfor
            </tr>
% endif
            </table>
        </div>
        % endif
    </div>
    % endif




<!-- DETALL FACTURA -->
    <div class="invoice_detail">
        <h1>${_(u"DETALL DE LA FACTURA")}</h1>
        <!-- POTÈNCIA -->
        <p><span style="font-weight: bold;">${_(u"Facturació per potència contractada")}</span> <br />
            ${_(u"Detall del càlcul del cost segons potència contractada:")} <br /></p>
        % for l in sorted(sorted(factura.linies_potencia, key=attrgetter('data_desde')), key=attrgetter('name')):
        <% dies_any = calendar.isleap(datetime.strptime(l.data_desde, '%Y-%m-%d').year) and 366 or 365 %>
         <div style="float: left;width:50%;margin: 0px 10px;">
             <div style="font-weight: bold;float:left">${_(u"(%s) %s kW x %s €/kW i any x (%.f/%d) dies") % (l.name, locale.str(locale.atof(formatLang(l.quantity, digits=3))), locale.str(locale.atof(formatLang(get_atr_price(cursor, uid, tarifa_elect_som,l), digits=6))),int(l.multi), dies_any)}</div>
             <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.price_subtotal)}</div>
         </div><br />
        % endfor
        <p>${_(u"Tot aquest import correspon al cost per peatges d'accés, ja que a Som Energia no afegim cap marge sobre aquest concepte.")}
        </p>
        <br />
        <hr />
        <!-- ENERGIA -->
        <p><span style="font-weight: bold;">${_(u"Facturació per electricitat utilitzada")}</span> <br />
            ${_(u"Detall del càlcul del cost segons l'energia utilitzada:")} <br /></p>
        % for l in sorted(sorted(factura.linies_energia, key=attrgetter('data_desde')), key=attrgetter('name')):
         <div style="float: left;width:50%;margin: 0px 10px;">
             <div style="border: 1px;font-weight: bold;float:left;width: 15%">${_(u"(%s)") % (l.name,)}</div>
             <div style="border: 1px;font-weight: bold;float:left;width: 35%">${_(u"%s kWh x %s €/kWh") % (int(l.quantity), locale.str(locale.atof(formatLang(l.price_unit_multi, digits=6))))}</div>
             <div style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; border: 1px;font-weight: bold;float:left;width: 30%">${get_gkwh_owner(cursor, uid, l)}</div>
             <div style="border: 1px;font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.price_subtotal)}</div>
         </div><br />
        % endfor

        % if polissa.tarifa.codi_ocsum not in ('012', '013', '014', '015', '016', '017'):
            <p>${_(u"D'aquest import, el cost per peatge d'accés ha estat de:")}
            </p>

            % for k, l in sorted(atr_linies_energia.items()):
                <div style="float: left;width:50%;margin: 0px 10px;">
                    <div style="font-weight: bold;float:left">${_(u"(%s) %s kWh x %s €/kWh") % (k, int(l['quantity']), locale.str(locale.atof(formatLang(l['price'], digits=6))))}</div>
                    <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l['atrprice_subtotal'])}</div>
                </div><br />
            % endfor
        % endif



        <p>${_(u"En el terme d'energia, afegim el marge necessari per a desenvolupar la nostra activitat de comercialització. Donem més pes al terme variable de la factura, que depèn del nostre ús de l'energia. Busquem incentivar l'estalvi i l'eficiència energètica de les persones sòcies i clientes.")}
        </p>
        <hr />
    % if factura.total_reactiva:
        <!-- REACTIVA -->
        <p><span style="font-weight: bold;">${_(u"Facturació per penalització de reactiva")}</span> <br />
            ${_(u"Detall del càlcul del cost segons la penalització per reactiva:")} <br /></p>
        % for l in sorted(sorted(factura.linies_reactiva, key=attrgetter('data_desde')), key=attrgetter('name')):
         <div style="float: left;width:50%;margin: 0px 10px;">
             <div style="font-weight: bold;float:left">${_(u"(%s) %s kVArh x %s €/kVArh") % (l.name, formatLang(l.quantity), locale.str(locale.atof(formatLang(l.price_unit_multi, digits=6))))}</div>
             <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.price_subtotal)}</div>
         </div><br />
        % endfor
        <p>${_(u"Detall del cost per peatge de penalització de reactiva inclós en l'import resultant:")}
        </p>
        % for l in sorted(sorted(factura.linies_reactiva, key=attrgetter('data_desde')), key=attrgetter('name')):
         <div style="float: left;width:50%;margin: 0px 10px;">
             <div style="font-weight: bold;float:left">${_(u"(%s) %s kVArh x %s €/kVArh") % (l.name, formatLang(l.quantity), locale.str(locale.atof(formatLang(get_atr_price(cursor, uid, tarifa_elect_atr,l), digits=6))))}</div>
             <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.atrprice_subtotal)}</div>
         </div><br />
        % endfor
        <br />
        <hr />
    % endif
        <!-- ALTRES -->
        <p>${_(u"A aquests imports hauràs de sumar els altres costos que detallem a continuació:")}<br /></p>
        % for l in bosocial_lines:
        <div style="float: left;width:75%;margin: 0px 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"Bo social (RD 7/2016 23 desembre)")}</div>
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"%s dies x %s €/dia") % (int(l.quantity), locale.str(locale.atof(formatLang(l.price_unit, digits=3))))}</div>
            <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.price_subtotal)}</div>
        </div>
        % endfor
        % for l in iese_lines:
        <div style="float: left;width:75%;margin: 0px 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"Impost de l'electricitat")}</div>
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"%s x 5,11269%%") % (formatLang(l.base_amount))}</div>
            <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.tax_amount)}</div>
        </div>
        % endfor
        % for l in lloguer_lines:
        <div style="float: left;width:75%;margin: 0px 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"Lloguer de comptador")}</div>
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"%s dies x %s €/dia") % (int(l.quantity), locale.str(locale.atof(formatLang(l.price_unit, digits=6))))}</div>
            <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.price_subtotal)}</div>
        </div>
        % endfor
        % for l in altres_lines:
        <div style="float: left;width:75%;margin: 0px 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${l.name}</div>
            <div style="font-weight: bold; float:left; width: 25em;">&nbsp;</div>
            <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.price_subtotal)}</div>
        </div>
        % endfor
        % for l in iva_lines:
        <div style="float: left;width:75%;margin: 0px 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${l.name}</div>
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"%s €") % (formatLang(l.base))}${_(u"(BASE IMPOSABLE)")}</div>
            <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.amount)}</div>
        </div>
        % endfor
        % for l in igic_lines:
        <div style="float: left;width:75%;margin: 0px 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${l.name}</div>
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"%s €") % (formatLang(l.base))}${_(u"(BASE IMPOSABLE)")}</div>
            <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.amount)}</div>
        </div>
        % endfor
        % for l in donatiu_lines:
        <div style="float: left;width:75%;margin: 2em 10px 0px 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"Donatiu voluntari (exempt d'IVA)")}</div>
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"%s kWh x %s €/kWh" % (formatLang(l.quantity), formatLang(l.price_unit_multi)))}</div>
            <div style="font-weight: bold; float:right;">${_(u"%s €") % formatLang(l.price_subtotal)}</div>
        </div>
        % endfor
        <p></p>
        <br />
        <div style="float: left; margin-top: 1em; width:100%;"><hr /></div>
        <div style="float: left;width:75%;margin: .5em 10px .5em 10px;">
            <div style="font-weight: bold; float:left; width: 25em;">${_(u"TOTAL IMPORT FACTURA")}</div>
            <div style="font-weight: bold; float:left; width: 25em;">&nbsp;</div>
            <div style="font-weight: bold; float:right;">${_(u"%s &euro;") % formatLang(factura.amount_total)}</div>
        </div>
        <br />
    </div>

    <p style="font-size: .8em"><br />
        %if factura.journal_id.code.startswith('RECUPERACION_IVA') and factura.comment:
            <div>${factura.comment}</div>
        %endif
        ${_(u"Els preus dels termes de peatge d'accés són els publicats a ORDRE IET/107/2014.")}<br />
        ${_(u"Els preus del lloguer dels comptadors són els establerts a ORDRE ITC/3860/2007.")}<br />
        ${_(u"Totes les comercialitzadores estan obligades a finançar el bo social que només poden oferir les comercialitzadores de referència ")}
        %if factura.lang_partner == 'ca_ES':
            <a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2017/08/el-bo-social-a-les-factures-de-som-energia/">${_("(més informació).")}</a>
        %else:
            <a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2017/08/el-bono-social-en-las-facturas-de-som-energia/">${_("(més informació).")}</a>
        %endif
    </p>
% if factura.has_tec271_line():
    <div class="destination">
            <%
                cups = polissa_obj.read(cursor, uid, factura.polissa_id.id, ['cups'])['cups'][1]
            %>
            <div class="supl">
                <h1 style="font-weight: bold; font-size:1.2em; padding: 0em 0.5em 0.5em 0.5em;">${_(u"TAULA DETALLADA DELS SUPLEMENTS AUTONÒMICS 2013 (*)")}</h1>
                <%
                    html_table = sup_territorials_tec_271_comer_obj.get_info_html(cursor, uid, cups)
                %>
                ${html_table}
                En caso de que el importe total de la regularización supere los dos euros, sin incluir impuestos, el mismo será fraccionado en partes iguales superiores a 1€ por las empresas comercializadoras en las facturas que se emitan en el plazo de 12 meses a partir de la primera regularización
                <br>
                * Tabla informativa conforme a lo establecido en la TEC/271/2019 de 6 de marzo, por la cual le informamos de los parámetros para el cálculo de los suplementos territoriales facilitados por su empresa distribuidora ${polissa.distribuidora.name}
                <br>
                <%
                    text = sup_territorials_tec_271_comer_obj.get_info_text(cursor, uid, cups)
                    if text:
                        text = text.format(distribuidora=polissa.distribuidora.name)
                %>
                ${text}
            </div>
        </div>
% endif
% if len(periodes_a) > 3:
    ${emergency_complaints(factura)}
% endif
    <p style="page-break-after:always"></p>
    <div class="elect_information">
        <h1>${_(u"INFORMACIÓ DE L'ELECTRICITAT")}</h1>
        <p style="line-height: 1.0;">
            ${_(u"L'electricitat que entra a les nostres llars ens arriba a través de la xarxa de distribució, l'electricitat que circula per ella prové "
                u"de diferents fonts, però utilitzant el sistema de certificats de garantia d'origen que emet la CNMC. A Som Energia podem garantir que "
                u"el volum d'electricitat que comercialitzem prové 100% de fonts renovables.")}<br />
        </p>
        <p style="line-height: 1.0;">
            ${_(u"En el gràfic següent mostrem el desglosament de la barreja de tecnologies de producció nacional per poder comparar el percentatge de "
                u"l'energia produïda a escala nacional amb el porcentatge d'energia venuda a través de la nostra cooperativa.")}<br />
        </p>
        <br />
        <hr />
        <p style="margin: 0px 0px;font-size: 1.5em; font-weight: 900">${_(u"ORIGEN DE L'ELECTRICITAT")}</p>
        <hr />
        <div class="mix">
            <div class="mix_som">
                <div class="titol" style="width: 100%"><span>${_("Mix Som Energia, SCCL")}</span></div>
                <div class="graf" style="text-align:center;width: 100%">
                    <img src="${addons_path}/giscedata_facturacio_comer_som/report/graf2_html.png"/>
                </div>
                <div class="peu">&nbsp;</div>
            </div>
            <div class="mix_esp">
                <div class="titol" style="width: 100%;"><span>${_(u"Mix producció en el sistema elèctric espanyol {year}").format(year=year_graph)}</span></div>
                <div class="graf" style="text-align:center; width: 100%">
                    <img src="${addons_path}/giscedata_facturacio_comer_som/report/graf1_html_${factura.lang_partner.lower()}_2018.png"/>
                </div>
                <div class="peu"><p>${_(u"El sistema elèctric espanyol ha importat un 4,3% de producció neta total")}</p></div>
            </div>
        </div>
        <div class="mix_taula">
            <table>
                <thead>
                    <tr>
                        <th>${_("Origen")}</th><th style="width: 30%">Som Energia, SCCL</th><th style="width: 30%">${_("Mix producció en el sistema elèctric espanyol {year}").format(year=year_graph)}</th>
                    </tr>
                </thead>
                <tbody>
                <tr>
                    <td>${_("Renovable")}</td><td>100%</td><td>38,2%</td>
                </tr>
                <tr>
                    <td>${_("Cogeneració alta eficiència")}</td><td>0%</td><td>4,4%</td>
                </tr>
                <tr>
                    <td>${_("Cogeneració")}</td><td>0%</td><td>6,9%</td>
                </tr>
                <tr>
                    <td>${_("CC Gas natural")}</td><td>0%</td><td>11,7%</td>
                </tr>
                <tr>
                    <td>${_("Carbó")}</td><td>0%</td><td>14,5%</td>
                </tr>
                <tr>
                    <td>${_("Fuel/Gas")}</td><td>0%</td><td>2,6%</td>
                </tr>
                <tr>
                    <td>${_("Nuclear")}</td><td>0%</td><td>20,7%</td>
                </tr>
                <tr>
                    <td>${_("Altres")}</td><td>0%</td><td>1,0%</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="environment_impact">
        <h1>${_(u"IMPACTE AMBIENTAL")}</h1>
        <p class="env_imp_desc">
            ${_(u"L'impacte ambiental de l'electricitat que utilitzem depèn de les fonts de generació que s'utilitzen per a la seva producció.")}
        <br />
            ${_(u"En una escala de A a G (on A indica el mínim impacte ambiental i G el màxim), i tenint en compte que el valor mitjà nacional correspon al nivell D, "
                u"l'energia comercialitzada per Som Energia, SCCL, té els valors següents:")}
        </p>
        <div class="env_imp">
            <div class="env_imp_carbo" >
                <div class="env_titol"><p>${_(u"Emissions de diòxid de carboni ")}<br /><span style="font-weight: 900">Som Energia, SCCL</span></p></div>
                <div class="env_img_lleg">${_(u"Menys diòxid de carboni")}</div>
                <div class="env_img">
                    <img class="a_g" src="${addons_path}/giscedata_facturacio_comer_som/report/graella_html.png"/>
                </div>
                <div class="env_mitjana" >
                    <p>${_(u'Mitjana nacional')}<br /><span style="font-weight: 900;">0,26</span></p>
                </div>
                <div class="env_marc">${_(u'Contingut de carboni<br />Quilograms de diòxid de carboni per kWh')}<br /><span style="font-weight: 900;font-size: 1.1em">0,00</span></div>
                <div class="env_img_lleg">${_(u"Més diòxid de carboni")}</div>
            </div>
        <div class="env_imp_nuclear" >
                <div class="env_titol"><p>${_(u"Residus radioactius d'alta activitat ")}<br /><span style="font-weight: 900">Som Energia, SCCL</span></p></div>
                <div class="env_img_lleg">${_(u"Menys residus radioactius")}</div>
                <div class="env_img">
                    <img class="a_g" src="${addons_path}/giscedata_facturacio_comer_som/report/graella_html.png"/>
                </div>
                <div class="env_mitjana">
                    <p>${_(u'Mitjana nacional')}<br /><span style="font-weight: 900;">0,51</span></p>
                </div>
                <div class="env_marc">${_(u'Residus radioactius<br />Mil·ligrams per kWh')}<br /><span style="font-weight: 900;font-size: 1.1em">0,00</span></div>
                <div class="env_img_lleg">${_(u"Més residus radioactius")}</div>
            </div>
        </div>
    </div>
    <div class="certificate_origin">
        <h1>${_(u"DETALL DELS CERTIFICATS DE GARANTIA D'ORIGEN PER A SOM ENERGIA")}</h1>
        <div class="cert_orig_info">
            <div class="cert_orig_taula">
                <table>
                    <thead>
                    <tr>
                        <th>${_(u"Font renovable")}</th><th>${_(u"Energia MWh")}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>${_(u"Eòlica")}</td><td>363.595</td>
                    </tr>
                    <tr>
                        <td>${_(u"Solar fotovoltaica")}</td><td>29.434</td>
                    </tr>
                    <tr>
                        <td>${_(u"Minihidràulica")}</td><td>2.650</td>
                    </tr>
                    <tr>
                        <td>${_(u"Biogàs")}</td><td>4.288</td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td>${_(u"TOTAL")}</td><td>399.967</td>
                    </tr>
                    </tfoot>
                </table>
            </div>
            ${_(u"Pots veure l'origen dels certificats de garantia d'origen en l'enllaç següent:")}<br/><a href="http://bit.ly/GdO15${factura.lang_partner.lower()[0:2]}")}>http://bit.ly/GdO15${factura.lang_partner.lower()[0:2]}</a>
        </div>
        <div class="cert_orig_grafic">
            <img class="orig" src="${addons_path}/giscedata_facturacio_comer_som/report/graf3_html_${factura.lang_partner.lower()}_2018.png"/>
        </div>

    </div>
</div>
<script>
var pie_total = ${pie_total};
var pie_data = [{val: ${pie_regulats}, perc: 30, code: "REG"},
                {val: ${pie_costos}, perc: 55, code: "PROD"},
                {val: ${pie_impostos},  perc: 15 ,code: "IMP"}
               ];

var pie_etiquetes = {'REG': {t: ['${formatLang(float(pie_regulats))} €','${_(u"Costos regulats")}'], w:100},
                     'IMP': {t: ['${formatLang(float(pie_impostos))} €','${_(u"Impostos aplicats")}'], w:100},
                     'PROD': {t: ['${formatLang(float(pie_costos))} €','${_(u"Costos de producció electricitat")}'], w:150}
                    };

var reparto = ${json.dumps(reparto)}
var dades_reparto = ${json.dumps(dades_reparto)}

var factura_id = ${factura.id}
var data_consum = ${json.dumps(historic_js)}
var es30 = ${len(periodes_a)>3 and 'true' or 'false'}

</script>
<script src="${addons_path}/giscedata_facturacio_comer_som/report/consum.js"></script>
<script src="${addons_path}/giscedata_facturacio_comer_som/report/pie.js"></script>
</div>
<%
comptador_factures += 1;
%>
% if comptador_factures<len(objects):
    <p style="page-break-after:always"></p>
% endif
%endfor
</body>
</html>