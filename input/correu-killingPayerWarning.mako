<!doctype html>
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
<html>
<body>
<br>
% if object.titular.lang  == "ca_ES":
<br>
Bon dia,<br>
<br>
Us fem arribar aquesta comunicació en tant que les vostres dades de contacte estan associades al mateix contracte de subministrament segons la informació que ens vareu fer arribar a través del formulari de contractar la llum.<br>
<br> 
Ens consten dades de més d'una persona associades al contracte corresponent a l’adreça ${object.cups_direccio} amb CUPS ${object.cups.name}, i podria ser  que l'usuari efectiu de l’electricitat no es correspongui  amb el titular (ambdós en copia en aquest correu).<br>
<br>
L'article 79. 3 del RD 1955/2000 diu <b>"El contrato de suministro es personal, y su titular deberá ser el efectivo usuario de la energía, que no podrá utilizarla en lugar distinto para el que fue contratada, ni cederla, ni venderla a terceros".</b><br>
<br>
Amb la voluntat de regularitzar aquesta situació, sol·licitem a l'actual usuari efectiu de l'energia (la persona que fa ús en aquests moments  del punt de subministrament)  que tramiti el canvi del titular del contracte a favor seu, en cas que no en sigui el titular a dia d’avui, a través del formulari <a href="https://ca.support.somenergia.coop/article/520-com-fer-un-canvi-de-titular-del-contracte">Canvi de titular</a> de la nostra web . L’article 83.3 del RD 1955/2000 estableix que <b>“En los casos en que el usuario efectivo de la energía o del uso efectivo de las redes, con justo título, sea persona distinta al titular que figura en el contrato, podrá exigir, siempre que se encuentre al corriente de pago, el cambio a su nombre del contrato existente, sin más trámites"</b><br>
<br>
En cas de que no rebem cap sol·licitud de canvi de titular del contracte de subministrament en el termini d’un mes des del moment de rebre aquesta comunicació, entendrem que l’actual titular n’és l’usuari efectiu. En conseqüència, restringirem l’ús de l’oficina virtual i l’enviament d’informació (factures, etc.) així com la possibilitat de realitzar modificacions o reclamacions al titular del contracte. De la mateixa manera, Som Energia, en cas d’incompliment contractual, només podrà reclamar i dirigir-se a la persona titular.<br>
<br>
En qualsevol cas, seguirem domiciliant el pagament de les factures en el compte corrent associat al contracte com fins a dia d’avui.<br>
<br>
<br>
Qualsevol consulta estem en contacte.<br>
<br>
Gràcies i salutacions,<br>
<br>
% endif
% if  object.titular.lang  != "ca_ES":
<br>
Buenos días,<br>
<br>
Os hacemos llegar esta comunicación en tanto que sus datos de contacto están asociadas al mismo contrato de suministro según la información que nos hicisteis llegar a través del formulario de contratar la luz.<br>
<br>
Nos constan datos de más de una persona asociadas al contrato correspondiente a la dirección ${object.cups_direccio} con CUPS ${object.cups.name}, y podría ser que el usuario efectivo de la electricidad no se corresponda con el titular (ambos en copia en este correo).<br>
<br>
El artículo 79. 3 del RD 1955/2000 dice <b>"El contrato de suministro es personal, y su titular deberá ser el efectivo usuario de la energía, que no podrá utilizarla en lugar distinto para el que fue contratada, ni cederla, ni venderla a terceros".</b><br>
<br>
Con la voluntad de regularizar esta situación, solicitamos al actual usuario efectivo de la energía (la persona que hace uso en este momento el punto de suministro) que tramite el cambio de titular del contrato a su favor, en caso de que no sea el titular a día de hoy, a través del formulario <a href="https://es.support.somenergia.coop/article/528-como-hacer-un-cambio-de-titular-del-contrato">Cambio de titular</a> de nuestra web. El artículo 83.3 del RD 1955/2000 establece que <b>“En los casos en que el usuario efectivo de la energía o del uso efectivo de las redes, con justo título, sea persona distinta al titular que figura en el contrato, podrá exigir, siempre que se encuentre al corriente de pago, el cambio a su nombre del contrato existente, sin más trámites"</b><br>
<br>
En caso de que no recibamos ninguna solicitud de cambio de titular del contrato de suministro en el plazo de un mes desde el momento de recibir esta comunicación, entenderemos que el actual titular es el usuario efectivo. En consecuencia, restringiremos el uso de la oficina virtual y el envío de información (facturas, etc.) así como la posibilidad de realizar modificaciones o reclamaciones al titular del contrato. Del mismo modo, Som Energia, en caso de incumplimiento contractual, sólo podrá reclamar y dirigirse a la persona titular.<br>
<br>
En cualquier caso, seguiremos domiciliando el pago de las facturas en la cuenta corriente asociada al contrato como hasta el día de hoy.<br>
<br>
<br>
Cualquier consulta estamos en contacto.<br>
<br>
Gracias y saludos,<br>
<br>
% endif
${text_legal}
</body>
</html>