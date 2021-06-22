<!doctype html><html><head><meta charset="utf-8" /></head><body style='font-family:sans'><div style="float: right"><img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
<%
Contract = object.pool.get('giscedata.polissa')
Assignment = object.pool.get('generationkwh.assignment')
Investment = object.pool.get('generationkwh.investment')

import datetime

def slashdate(date):
    return date.strftime('%d/%m/%Y')

md_obj = object.pool.get('ir.model.data')
gkwh_emission_id = md_obj.get_object_reference(
                    object._cr, object._uid,  'som_generationkwh', 'emissio_genkwh'
                )[1]

today = datetime.date.today().strftime('%Y-%m-%d')

investment_ids = Investment.search(
    object._cr, object._uid,
    [
    ('member_id', '=', object.id),
    ('first_effective_date', '!=', False),
    ('first_effective_date', '>=', today),
    ('emission_id', '=', gkwh_emission_id)
    ],
    order='first_effective_date ASC',
)

if investment_ids:
    effectivedate = Investment.read(
        object._cr, object._uid,
        investment_ids[0],
        ['first_effective_date'],
        )['first_effective_date']
else:
    effectivedate = None

if effectivedate:
    effectivedate = datetime.datetime.strptime(effectivedate, "%Y-%m-%d").date()
    effectivedate = slashdate(effectivedate)
else:
    effectivedate = "???"

def assignedContracts():
    assignments_ids = Assignment.search(object._cr, object._uid, [
        ('member_id','=',object.id),
        ], 0,0, 'priority asc',)
    assignments = Assignment.browse(object._cr, object._uid, assignments_ids)
    return [
        assignment['contract_id'].id
        for assignment in assignments
        ]

contracts = assignedContracts()

cadenes = dict(
    ca = dict(
        descripcio= u"""\
- Número de contracte: {name}<br/>
- Adreça:  {adreca}<br/>
- CUPS: {cups}<br/>
- Persona titular: {titular}<br/>
- Persona pagadora: {pagador}<br/>""",
        capContracte=u"- Cap contracte",
        ),
    es = dict(
        descripcio= u"""\
- Número de contrato: {name}<br/>
- Dirección:  {adreca}<br/>
- CUPS: {cups}<br/>
- Persona titular: {titular}<br/>
- Persona pagadora: {pagador}<br/>""",
        capContracte=u"- Ningún contrato",
        ),
    )

def contractDescription(ids, idioma):
    templates = cadenes[idioma]
    if not ids:
        return templates['capContracte']

    return u'\n'.join([templates['descripcio'].format(
        name = contract.name,
        adreca = contract.cups_direccio,
        cups = contract.cups.name,
        titular = contract.titular.name,
        pagador = contract.pagador.name,
        )
        for contract in Contract.browse(object._cr, object._uid, ids)
        ])


from mako.template import Template

def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )

t_obj = object.pool.get('poweremail.templates')
template_id = md_obj.get_object_reference(
                    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                )[1]

text_legal = render(t_obj.read(
    object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
%>
Hola,<br/>
<br/>
%if object.lang != 'es_ES':
Ens alegra comunicar-te que a partir del dia ${ effectivedate } la teva inversió del <em>Generation kWh</em> començarà a generar energia i ja es veurà reflectida a les teves factures, o a les d’aquells contractes que ens indiquis.<br/>
<br/>
Per defecte, se t’han assignat tots els contractes dels quals ets la persona titular o pagadora. S’ha fixat un contracte com a prioritari (aquell que ens consta amb més ús elèctric anual) i els kWh que cada mes no utilitzi aquest contracte, els podran anar aprofitant la resta de contractes. <br/>
<br/>
%if contracts:
La prioritat que hem establert inicialment és la següent:<br/>
<br/>
Contracte assignat amb més prioritat:<br/>
<br/>
${ contractDescription(contracts[0:1],'ca') }
<br/>
Contractes assignats amb menys prioritat:<br/>
<br/>
${ contractDescription(contracts[1:],'ca') }
<br/>
Si vols modificar aquesta assignació per defecte, pots demanar-ho contestant aquest mateix missatge. <br/>
%else:
En el teu cas no tens cap contracte on figuris com a persona titular o pagadora i no s'ha fet cap assignació per defecte.<br/>
<br/>
<b>Per aprofitar la teva inversió, et recomanem que assignis com a mínim un contracte.</b> Pots demanar-ho contestant aquest mateix missatge.<br/>
%endif
<br/>
Pots assignar energia a qualsevol contracte que estigui amb la cooperativa (no cal que estigui al teu nom), però per a cadascun d’ells, necessitarem saber el seu número de contracte o en el seu defecte el seu número de CUPS.<br/>
<br/>
<br/>
Salutacions i seguim en contacte, amb encara més bona energia!<br/>
<br/>
Equip de Som Energia.<br/>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
<a href="https://www.generationkwh.org/ca">www.generationkwh.org</a><br/>
%elif object.lang != 'ca_ES':
Nos alegra comunicarte que el día ${ effectivedate } tu inversión del <em>Generation kWh</em> comenzará a generar energía y ya se verá reflejada en tus facturas, o en las de aquellos contratos que nos indiques.<br/>
<br/>
Por defecto, se te han asignado todos los contratos de los que eres la persona titular o pagadora. Se ha fijado un contrato como prioritario (aquel que nos consta con más uso eléctrico anual) y los kWh que cada mes no utilice este contrato, los podrán ir aprovechando el resto de contratos. <br/>
<br/>
%if contracts:
La prioridad que hemos establecido inicialmente es la siguiente:<br/>
<br/>
Contrato asignado con más prioridad:<br/>
<br/>
${ contractDescription(contracts[0:1],'es') }
<br/>
Contratos asignados con menos prioridad:<br/>
<br/>
${ contractDescription(contracts[1:],'es') }
<br/>
Si quieres modificar esta asignación por defecto, puedes pedirlo contestando este mismo mensaje.<br/>
%else:
En tu caso no tienes ningún contrato donde figuras como persona titular o pagadora y no se ha hecho ninguna asignación por defecto.<br/>
<br/>
<b>Para aprovechar tu inversión, te recomendamos que asignes al menos un contrato.</b> Puedes pedirlo contestando este mismo mensaje.<br/>
%endif
<br/>
Puedes asignar energía a cualquier contrato que esté con la cooperativa (no hace falta que esté a tu nombre), pero para cada uno de ellos, necesitaremos saber su número de contrato o en su defecto su número de CUPS.<br/>
<br/>
<br/>
Saludos y seguimos en contacto, ¡con aún más buena energía!<br/>
<br/>
Equipo de Som Energia.<br/>
<a href="https://www.somenergia.coop/es">www.somenergia.coop</a><br/>
<a href="https://www.generationkwh.org/es">www.generationkwh.org</a><br/>
%endif
<br/>
${text_legal}
</body>
</html>
