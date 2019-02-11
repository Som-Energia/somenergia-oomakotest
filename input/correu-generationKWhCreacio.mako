<!doctype html>
<html>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
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
% if lang == "ca_ES":
Hola ${name.split(',')[-1]},<br/>
<br/>
Et confirmem que hem rebut correctament la teva sol·licitud per fer una aportació als projectes de la Generació kWh, amb les següents dades:<br/>
<br/>
Soci/Sòcia: ${name}<br/>
Compte de càrrec: ${iban[:-4]}****<br/>
Import aportació: ${int(abs(amount_currency))} €<br/>
<br/>
En els propers dies rebràs el càrrec bancari en aquest compte, si us plau verifica que totes les dades facilitades són correctes i que disposes dels diners que hi vols invertir, per tal que no hi hagi cap incidència en el gir del rebut.<br/>
<br/>
Un cop passem el rebut d’aquest import, t’enviarem un altre mail per confirmar la teva aportació i detallar-ne les condicions particulars.<br/>
<br/>
Agraïm la teva participació en l’impuls de nous projectes i et recordem que per a qualsevol dubte o aclariment hi ha el <a href="http://ca.support.somenergia.coop/category/580-generation-kwh">Centre d’Ajuda</a> de la web. També pots respondre a aquest correu o escriure a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>.<br/>
<br/>
Pots fer córrer la veu i explicar el projecte a familiars i amistats. Si estàs connectat a les xarxes socials també pots compartir fàcilment un missatge des d'aquest enllaç a <a href="http://ctt.ec/7Yr1X">Twitter</a>, a <a href="https://www.facebook.com/sharer/sharer.php?u=http://www.generationkwh.cat">Facebook</a>, <a href="https://www.linkedin.com/cws/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Linkedin</a> i, fins tot, a <a href="https://plus.google.com/share?url=http://www.generationkwh.cat&utm_source=Preinscripción+GenerationkWh&utm_campaign=98c4d8873e-_ES_2a_Newsletter_Generation_kWh6_13_2015&utm_medium=email&utm_term=0_b8985e435a-98c4d8873e-311450445">Google+</a>. Quantes més siguem, més energia verda generarem!<br/>
<br/>
Moltes gràcies i bona energia!<br/>
<br/>
Som Energia, SCCL<br/>
<a href="http://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if  lang != "ca_ES" and  lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  lang == "es_ES":
Hola ${name.split(',')[-1]},<br/>
<br/>
Te confirmamos que hemos recibido correctamente tu solicitud para hacer una aportación en los proyectos de la Generación kWh, con los siguientes datos:<br/>
<br/>
Socio/Socia: ${name}<br/>
Cuenta de cargo: ${iban[:-4]}****<br/>
Importe aportación: ${int(abs(amount_currency))} €<br/>
<br/>
En los próximos días recibirás el cargo bancario en esta cuenta, por favor verifica que todos los datos facilitados son correctos y que dispones del dinero que quieres invertir, para que no haya ninguna incidencia en el giro del recibo.<br/>
<br/>
Una vez pasemos el recibo de este importe, te mandaremos otro mail para confirmar tu aportación y detallar las condiciones particulares.<br/>
<br/>
Agradecemos tu participación en el impulso de nuevos proyectos y te recordamos que para cualquier duda o aclaración existe el <a href="http://es.support.somenergia.coop/category/595-generation-kwh">Centro de Ayuda</a> de la web. También puedes responder directamente este correo o escribir a <a href="mailto:generationkwh@somenergia.coop">generationkwh@somenergia.coop</a>.<br/>
<br/>
Puedes hacer correr la voz y explicar el proyecto a familiares y amistades. Si estás conectado a las redes sociales también puedes compartir fácilmente un mensaje desde este enlace en  <a href="http://ctt.ec/134fX">Twitter</a>, en <a href="https://www.facebook.com/sharer/sharer.php?u=http://www.generationkwh.es">Facebook</a>, en <a href="http://generationkwh.us2.list-manage.com/track/click?u=56d8bf2e8806722821a650fd1&id=45ac0c2d2d&e=6e8d00bf75">Linkedin</a> e, incluso, <a href="http://generationkwh.us2.list-manage1.com/track/click?u=56d8bf2e8806722821a650fd1&id=870e457cc5&e=6e8d00bf75">Google+</a>. Cuantas más seamos, ¡más energía verde generaremos!<br/>
<br/>
¡Muchas gracias y buena energía!<br/>
<br/>
Som Energia, SCCL<br />
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
<br/>
</body>
</html>
