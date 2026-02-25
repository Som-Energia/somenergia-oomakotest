<%
Soci = object.pool.get('somenergia.soci')
Partner = object.pool.get('res.partner')
PartnerBank = object.pool.get('res.partner.bank')
GenerationkwhInvestment = object.pool.get('generationkwh.investment')
soci_id = object.member_id.id
soci_obj = Soci.read(object._cr, object._uid, soci_id)
part_obj = Partner.read(object._cr,object._uid,soci_obj['partner_id'][0])
bank_obj = PartnerBank.read(object._cr, object._uid, part_obj['bank_inversions'][0])
lang = part_obj['lang']
name = part_obj['name']
iban = bank_obj['iban']
amount_currency= int(object.nshares) * 100
emission_id = object.emission_id.id
total_amount_in_emission = GenerationkwhInvestment.get_investments_amount(object._cr, object._uid, soci_id, emission_id=emission_id)
is_higher_5k = total_amount_in_emission > 5000

nom_pagador = ''
es_empresa = Partner.vat_es_empresa(object._cr, object._uid, object.member_id.vat)
if not es_empresa:
    nom_pagador =' ' + Partner.separa_cognoms(object._cr, object._uid, object.member_id.name)['nom']
%>

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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>

${plantilla_header}

% if lang != "es_ES":
Benvolgut/da${nom_pagador},<br/>
<br/>
Et confirmem que hem rebut correctament la teva sol•licitud per fer una aportació voluntària al capital social de Som Energia, amb les següents dades:<br/>
<br/>
Soci/Sòcia: ${name}<br/>
Compte de càrrec: ${iban[:-4]}****<br/>
Import aportació: ${int(abs(amount_currency))} €<br/>
<br/>
% if es_empresa:
<p>Et recordem que per fer l'aportació en nom d'una persona jurídica has d'estar documentalment acreditat. </p>
<p>Per aquesta raó, necessitem que ens responguis aquest correu adjuntant la següent documentació addicional:</p>
<ul>
    <li>el teu DNI (en tant que persona representant de la persona jurídica) </li>
    <li>escriptures de poders de representació vigents </li>
    <li>escriptura constitutiva i, si escau, escriptura de titularitat real </li>
    <li>número CNAE activitat econòmica </li>
</ul>
<p>Un cop rebuda i verificada la documentació, procedirem a realitzar el corresponent càrrec en compte per l'import que ens has sol.licitat.</p>
% else:
En els propers dies rebràs el càrrec bancari en aquest compte, si us plau verifica que totes les dades facilitades són correctes i que disposes dels diners, per tal que no hi hagi cap incidència en el gir del rebut.<br/>
<br/>
Un cop verificada la validesa del pagament realitzat rebràs una nova notificació confirmant l'aportació realitzada i detallant les condicions particulars de la teva aportació.<br/>
% endif
<br/>
% if is_higher_5k:
D’acord amb la nostra política de prevenció de blanqueig de capitals, a partir de 5.000 euros d’aportació en una sola emissió, és necessari verificar l'origen dels fons aportats a Som Energia. És per això que més endavant t’enviarem un formulari d’identificació perquè ens el signis aixi com la sol.licitud d’una serie de documentació identificativa (DNI, escriptura constitució en cas de societats…)<br/>
<br/>
En cas que no ens poguessis aportar aquesta informació, i d’acord amb la nostra política en matèria de prevenció del blanqueig de capitals, hauriem de reemborsar-te l’import de la teva aportació.<br/>
<br/>
% endif
T’informem que per a qualsevol dubte o aclariment pots consultar el <a href="https://ca.support.somenergia.coop/article/195-puc-fer-aportacions-a-la-cooperativa" >Centre d’Ajuda</a>. També pots respondre aquest correu o escriure a aporta@somenergia.coop.<br/>
<br/>
Els socis i les sòcies de la cooperativa són les que sempre heu ajudat a tirar aquest projecte endavant. T’agraïm la teva aportació i t’animem a fer córrer la veu a familiars i amistats. Si estàs connectat a les xarxes socials també pots compartir fàcilment un missatge des d’aquest enllaç a <a href="https://ctt.ac/dc162">Twitter</a>, a <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.somenergia.coop/ca/produeix-energia-renovable/aporta-al-capital-social/">Facebook</a> i a <a href="https://www.linkedin.com/sharing/share-offsite/?url=https://www.somenergia.coop/ca/produeix-energia-renovable/aporta-al-capital-social/">Linkedin</a>.<br/>
<br/>
Demostrem, un cop més, la força del cooperativisme.<br/>
<br/>
Moltes gràcies i bona energia!<br/>
<br/>
Atentament,<br/>
<br/>
<br/>
Equip de Som Energia,<br/>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if lang != "ca_ES" and lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if lang != "ca_ES":
Apreciado/a${nom_pagador},<br/>
<br/>
Te confirmamos que hemos recibido correctamente tu solicitud para realizar una aportación voluntaria al capital social de Som Energia, con los siguientes datos:<br/>
<br/>
Socio/a: ${name}<br/>
Cuenta de cargo: ${iban[:-4]}****<br/>
Importe aportación: ${int(abs(amount_currency))} €<br/>
<br/>
% if es_empresa:
<p>Te recordamos que para hacer la aportación en nombre de una persona jurídica tienes que estar documentalmente acreditado.</p>
<p>Es por esta razón que necesitamos que respondas este correo adjuntando la siguiente documentación:</p>
<ul>
    <li>tu DNI (en tanto que persona representante de la persona jurídica)</li>
    <li>escrituras de poderes de representación vigentes</li>
    <li>escritura constitutiva y si procede, escritura de titularidad real</li>
    <li>número CNAE actividad económica</li>
</ul>
<p>Una vez recibida y verificada la doncumentación, procederemos a realizar el correspondiente cargo en cuenta por el importe que nos has solicitado.</p>
% else:
En los próximos dias recibirás el cargo bancario en esta cuenta, por favor verifica que todos los datos facilitados sean correctos y dispones del dinero, para evitar cualquier incidencia en el giro del recibo.<br/>
<br/>
Una vez verificada la validez del pago realizado recibirás una nueva notificación confirmando la aportación realizada y detallando las condiciones particulares de tu aportación.<br/>
% endif
<br/>
% if is_higher_5k:
De acuerdo con nuestra política de prevención de blanqueo de capitales, a partir de 5.000 euros de aportación por emisión, es necesario verificar el orígen de los fondos aportados a Som Energia. Es por eso que más adelante,  te enviaremos un formulario de identificación para que nos firmes así como la solicitud de la documentación justificativa (DNI, escrituras constitución en caso de sociedades…)<br/>
<br/>
En caso de que no pudieras aportar esta información, y de acuerdo con nuestra política en materia de prevención del blanqueo de capitales, tendriamos que reembolsarte el importe de tu aportación.<br/>
<br/>
% endif
Te informamos que para cualquier duda o aclaración puedes consultar el <a href="https://es.support.somenergia.coop/article/150-puedo-realizar-aportaciones-en-la-cooperativa">Centro de Ayuda</a>. También puedes responder este correo o escribir al correo aporta@somenergia.coop.<br/>
<br/>
Los socios y las socias son las que siempre habéis ayudado a la cooperativa a avanzar. Te agradecemos tu aportación y te animamos a contárselo a familiares y amistades. Si estás conectado a las redes sociales también puedes compartir fácilmente un mensaje desde este enlace en <a href="https://ctt.ac/FS4uH" >Twitter</a>, en <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.somenergia.coop/es/produce-energia-renovable/aporta-al-capital-social/" >Facebook</a> y en <a href="https://www.linkedin.com/sharing/share-offsite/?url=https://www.somenergia.coop/es/produce-energia-renovable/aporta-al-capital-social/" >Linkedin</a>.<br/>
<br/>
Demostremos, una vez más, la fuerza del cooperativismo.<br/>
<br/>
¡Muchas gracias y buena energía!<br/>
<br/>
Atentamente,<br/>
<br/>
<br/>
Equipo de Som Energia,<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${plantilla_footer}
