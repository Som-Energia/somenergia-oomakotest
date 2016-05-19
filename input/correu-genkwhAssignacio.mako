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

def contractDescription(ids):
    if not ids:
        return u"- Cap contracte"

    return u'\n'.join([
u"""
- Número de contracte {name}
- Adreça  {adreca}
- CUPS: {cups}
- Titular: {titular}
- Pagador: {pagador}
""".format(
    name = contract.name,
    adreca = contract.cups_direccio,
    cups = contract.cups.name,
    titular = contract.titular.name,
    pagador = contract.pagador.name,
    )
    for contract in Contract.browse(object._cr, object._uid, ids)
    ])

%>
Hola ${object.name},

Ens alegra comunicar-te que en breu la teva inversió del Generation kWh començarà a generar energia i ja es veurà reflectida a les teves factures, o a les d’aquells contractes que ens indiquis.

Per defecte, s’han assignat tots els contractes on ets la persona titular o pagadora. S’ha fixat un contracte com a prioritari (aquell que ens consta amb més ús elèctric anual) i els kWh que cada mes no utilitzi aquest contracte, els podran anar aprofitant la resta de contractes. 

%if contracts:

La prioritat establerta que hem definit inicialment és la següent:

Contracte assignat amb més prioritat:

${ contractDescription(contracts[0:1]) }

Contractes assignats amb menys prioritat:

${ contractDescription(contracts[1:]) }

%else:

En el teu cas no tens cap contracte on figuris com a persona titular o pagadora i no s'ha fet cap assignació per defecte.

<b>Per aprofitar la teva inversió, et recomanem que assignis com a mínim un contracte.</b>

%endif

Si vols modificar aquesta assignació per defecte, pots fer-ho contestant aquest mateix missatge. 

Pots assignar energia a qualsevol contracte que estigui amb la cooperativa (no cal que estigui al teu nom), però per a cadascun d’ells, necessitarem saber el seu número de contracte o en el seu defecte el seu número de CUPS.

Salutacions i seguim en contacte, amb encara més bona energia!




 
