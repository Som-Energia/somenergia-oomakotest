
<!doctype html>
<html>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
<br/><br/>
<%
Soci = object.pool.get('somenergia.soci')
Partner = object.pool.get('res.partner')
PartnerBank = object.pool.get('res.partner.bank')
soci_id = object.member_id.id
soci_obj = Soci.read(object._cr, object._uid, soci_id)
part_obj = Partner.read(object._cr,object._uid,soci_obj['partner_id'][0])
bank_obj = PartnerBank.read(object._cr, object._uid, part_obj['bank_inversions'][0])
lang = part_obj['lang']
name = part_obj['name']
iban = bank_obj['iban']
amount_currency= int(object.nshares) * 100

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
template_id = md_obj.get_object_reference(
                    object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                )[1]
text_legal = render(t_obj.read(
    object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
%>
<br/>
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
En els propers dies rebràs el càrrec bancari en aquest compte, siusplau verifica que totes les dades facilitades són correctes i que disposes dels diners, per tal que no hi hagi cap incidència en el gir del rebut.<br/>
<br/>
Un cop verificada la validesa del pagament realitzat rebràs una nova notificació confirmant l'aportació realitzada i detallant les condicions particulars de la teva aportació.<br/>
<br/>
Agrair la teva implicació amb la cooperativa i informar-te que per a qualsevol dubte o aclariment pots consultar el web <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a> o bé mitjançant un mail a <a href="mailto:aporta@somenergia.coop">aporta@somenergia.coop</a>.<br/>
<br/>
% endif
Moltes gràcies i bona energia!<br/>
<br/>
Atentament,<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
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
<br/>
Agradecer tu implicación con la cooperativa y informarte que para cualquier duda o aclaración puedes consultar nuestra web <a href="https://www.somenergia.coop">www.somenergia.coop</a> o enviarnos un correo electrónico a <a href="mailto:aporta@somenergia.coop">aporta@somenergia.coop</a><br/>
<br/>
% endif
¡Muchas gracias y buena energía!<br/>
<br/>
Atentamente,<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
</body>
</html>
