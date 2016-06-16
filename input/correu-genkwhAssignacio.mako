<!doctype html><html><body><div style="float: right"><img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
<%
Contract = object.pool.get('giscedata.polissa')
Assignment = object.pool.get('generationkwh.assignment')

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
- Número de contracte: {name}
- Adreça:  {adreca}
- CUPS: {cups}
- Persona titular: {titular}
- Persona pagadora: {pagador}""",
        capContracte=u"- Cap contracte",
        ),
    es = dict(
        descripcio= u"""\
- Número de contrato: {name}
- Dirección:  {adreca}
- CUPS: {cups}
- Persona titular: {titular}
- Persona pagadora: {pagador}""",
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

%>
Hola,

%if object.lang != 'es_ES':
Ens alegra comunicar-te que en breu la teva inversió del Generation kWh començarà a generar energia i ja es veurà reflectida a les teves factures, o a les d’aquells contractes que ens indiquis.

Per defecte, se t’han assignat tots els contractes dels quals ets la persona titular o pagadora. S’ha fixat un contracte com a prioritari (aquell que ens consta amb més ús elèctric anual) i els kWh que cada mes no utilitzi aquest contracte, els podran anar aprofitant la resta de contractes. 

%if contracts:
La prioritat que hem establert inicialment és la següent:

Contracte assignat amb més prioritat:

${ contractDescription(contracts[0:1],'ca') }

Contractes assignats amb menys prioritat:

${ contractDescription(contracts[1:],'ca') }

Si vols modificar aquesta assignació per defecte, pots demanar-ho contestant aquest mateix missatge. 
%else:
En el teu cas no tens cap contracte on figuris com a persona titular o pagadora i no s'ha fet cap assignació per defecte.

<b>Per aprofitar la teva inversió, et recomanem que assignis com a mínim un contracte.</b> Pots demanar-ho contestant aquest mateix missatge.
%endif

Pots assignar energia a qualsevol contracte que estigui amb la cooperativa (no cal que estigui al teu nom), però per a cadascun d’ells, necessitarem saber el seu número de contracte o en el seu defecte el seu número de CUPS.


Salutacions i seguim en contacte, amb encara més bona energia!

Equip de Som Energia.
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
<a href="http://www.generationkwh.org/ca">www.generationkwh.org</a>
%elif object.lang != 'ca_ES':
Nos alegra comunicarte que en breve tu inversión del <em>Generation kWh<em> comenzará a generar energía y ya se verá reflejada en tus facturas, o en las de aquellos contratos que nos indiques.

Por defecto, se te han asignado todos los contratos de los que eres la persona titular o pagadora. Se ha fijado un contrato como prioritario (aquel que nos consta con más uso eléctrico anual) y los kWh que cada mes no utilice este contrato, los podrán ir aprovechando el resto de contratos. 

%if contracts:
La prioridad que hemos establecido inicialmente es la siguiente:

Contrato asignado con más prioridad:

${ contractDescription(contracts[0:1],'es') }

Contratos asignados con menos prioridad:

${ contractDescription(contracts[1:],'es') }

Si quieres modificar esta asignación por defecto, puedes pedirlo contestando este mismo mensaje.
%else:
En tu caso no tienes ningún contrato donde figuras como persona titular o pagadora y no se ha hecho ninguna asignación por defecto.

<b>Para aprovechar tu inversión, te recomendamos que asignes al menos un contrato.</b> Puedes pedirlo contestando este mismo mensaje.
%endif

Puedes asignar energía a cualquier contrato que esté con la cooperativa (no hace falta que esté a tu nombre), pero para cada uno de ellos, necesitaremos saber su número de contrato o en su defecto su número de CUPS.


Saludos y seguimos en contacto, ¡con aún más buena energía!

Equipo de Som Energia.
<a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
<a href="http://www.generationkwh.org/es">www.generationkwh.org</a>
%endif
</body></html>
