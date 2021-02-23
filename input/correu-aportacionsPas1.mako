<!doctype html>
<html>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
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
% if object.partner_id.lang != "es_ES":
Benvolgut/da ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Et confirmem que hem rebut correctament la teva sol•licitud per fer una aportació voluntària al capital social de Som Energia, amb les següents dades:<br/>							
<br/>
Soci/Sòcia: ${object.partner_id.name}<br/>
Compte de càrrec: ${object.bank_id.printable_iban[:-4]}****<br/>
Import aportació: ${int(abs(object.amount_currency))} €<br/>
<br/>
En els propers dies rebràs el càrrec bancari en aquest compte, siusplau verifica que totes les dades facilitades són correctes i que disposes dels diners que vols invertir, per tal que no hi hagi cap incidència en el gir del rebut.<br/>
<br/>
Un cop verificada la validesa del pagament realitzat rebràs una nova notificació confirmant l'aportació realitzada i detallant les condicions particulars de la teva aportació.<br/>
<br/>
Agrair la teva implicació amb la cooperativa i informar-te que per a qualsevol dubte o aclariment pots consultar el web <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a> o bé mitjançant un mail a <a href="mailto:invertir@somenergia.coop">invertir@somenergia.coop</a>.<br/>
<br/>
Moltes gràcies i bona energia!<br/>
<br/>
Atentament,<br/>
<br/>
<br/>
Som Energia, SCCL<br/>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if  object.partner_id.lang != "ca_ES":
Apreciado/a ${object.partner_id.name.split(',')[-1]},<br/>
<br/>
Te confirmamos que hemos recibido correctamente tu solicitud para realizar una aportación voluntaria al capital social de Som Energia, con los siguientes datos:<br/>
<br/>
Socio/a: ${object.partner_id.name}<br/>
Cuenta de cargo: ${object.bank_id.printable_iban[:-4]}****<br/>
Importe aportación: ${int(abs(object.amount_currency))} €<br/>
<br/>
En los próximos dias recibirás el cargo bancario en esta cuenta, por favor verifica que todos los datos facilitados sean correctos y dispones del dinero que quieres invertir, para evitar cualquier incidencia en el giro del recibo.<br/>
<br/>
Una vez verificada la validez del pago realizado recibirás una nueva notificación confirmando la aportación realizada y detallando las condiciones particulares de tu aportación.<br/>
<br/>
Agradecer tu implicación con la cooperativa y informarte que para cualquier duda o aclaración puedes consultar nuestra web <a href="https://www.somenergia.coop">www.somenergia.coop</a> o enviarnos un correo electrónico a <a href="mailto:invertir@somenergia.coop">invertir@somenergia.coop</a></br>
<br/>
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