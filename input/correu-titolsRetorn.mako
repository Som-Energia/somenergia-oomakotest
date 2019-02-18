<!doctype html>
<html>
<body>
<img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">
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
<br />
% if object.partner_id.lang != "es_ES":
<br />
Benvolgut/da ${object.partner_id.name.split(',')[-1]},<br />
<br />
Aquest mes  farà  5 anys de la teva compra de títols participatius de SOM ENERGIA SCCL. <br />
<br />
Com que es tracta d’una inversió amb venciment a 5 anys, procedirem a realitzar-te la transferència de l’import invertit al següent número de compte:<br />
<br />
IBAN: ${object.bank_id.printable_iban[:-4]}****<br />
<br />
Siusplau, verifica que el compte bancari és correcte i si s’ha de modificar contesta aquest correu el més aviat possible informant-nos del nou compte on vulguis que et fem la transferència.<br />
<br />
Els interessos generats des de la última liquidació efectuada (30/06/2017) fins a la data del venciment, els abonarem el 30/03/2018.<br />
<br />
Agraïr-te en nom de SOM ENERGIA SCCL la teva implicació en el nostre projecte i recordar-te que per qualsevol dubte pots consultar el nostre web.<br />
<br />
Atentament,<br />
<br />
Som Energia, SCCL<br />
<a href="https://www.somenergia.coop/ca/">www.somenergia.coop</a><br />
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<br />----------------------------------------------------------------------------------------------------<br />
% endif
% if object.partner_id.lang != "ca_ES":
<br />
Apreciado/a  ${object.partner_id.name.split(',')[-1]},<br />
<br />
Este mes hará 5 años de tu compra de títulos participativos de SOM ENERGIA SCCL. <br />
<br />
Cómo se trata de una inversión con vencimiento a 5 años, procederemos a realizarte la transferencia del importe invertido al siguiente número de cuenta:<br />
<br />
IBAN: ${object.bank_id.printable_iban[:-4]}****<br />
<br />
Por favor, verifica que la cuenta bancaria es la correcta y si se tiene que modificar contesta este correo lo antes posible informando de la nueva cuenta dónde quieras que te hagamos la transferencia.<br />
<br />
Los intereses devengados desde la última liquidación efectuada (30/06/2017) hasta la fecha del vencimiento, los abonaremos el 30/03/2018.<br />
<br />
Te agradecemos una vez más des de SOM ENERGIA  tu implicación en nuestro proyecto y te recordamos que para cualquier duda puedes consultar nuestra web .<br />
<br />
Atentamente,<br />
<br />
Som Energia, SCCL<br />
<a href="https://www.somenergia.coop/es/">www.somenergia.coop</a><br />
% endif
<br />
${text_legal}
</body>
</html>
