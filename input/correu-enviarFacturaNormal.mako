<!doctype html>
<html>
<head><meta charset='utf8'></head><body>
<%
import datetime
data_inici = datetime.datetime.strptime(object.data_inici, '%Y-%m-%d').strftime('%d-%m-%Y')
data_final = datetime.datetime.strptime(object.data_final, '%Y-%m-%d').strftime('%d-%m-%Y')
id_soci_fact= object.polissa_id.soci.id
id_soci_energetica = 38039
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
% if id_soci_fact == id_soci_energetica:
<div align="right"><img src="https://blog.somenergia.coop/wp-content/uploads/2018/10/som-energia-energetica-logos.jpg"></div>
% endif:
% if id_soci_fact != id_soci_energetica:
<div align="right"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
% endif:
% if object.partner_id.lang != "es_ES":
<p><br>
Benvolgut/da,<br>
<br>
T'enviem la <B>factura</B> d'electricitat de Som Energia. <br>
<br>
Carregarem l'import d'aquesta factura al teu número de compte durant els propers dies.<br>
<br>
Si tens dificultats per afrontar el pagament d’aquesta factura arran de la crisi de la <B>COVID-19</B>, t'oferim la possibilitat d'ajornar-lo un mes. Per fer-ho, ens ho pots sol·licitar responent aquest mateix correu.
<br>
Si ja has ajornat el pagament d’alguna factura anterior i segueixes tenint dificultats, podem oferir-te el fraccionament del deute.
<br>
Si aquesta factura correspon al contracte d’una empresa, també pots respondre aquest correu i demanar el fraccionament del pagament de les factures que es generin mentre duri l’estat d’alarma, tal i com regula el <a href="https://boe.es/buscar/pdf/2020/BOE-A-2020-4208-consolidado.pdf">Reial Decret-llei 11/2020</a>.
<br>
Si ets autònom o autònoma, també pots acollir-te a aquest pagament fraccionat però, en aquest cas, necessitem que ens enviïs una còpia del Justificant d’Alta en el Règim Especial de Treballadors Autònoms de la Seguretat Social (RETA) amb la teva petició.
<br>
</p>
<br>
<U><B>Resum de la factura</B></U><br>
<ul><li>Número de factura: ${object.number}</li><br>
<li>Codi CUPS: ${object.cups_id.name}</li><br>
<li>Adreça punt subministrament: ${object.cups_id.direccio}</li><br>
<li>Titular: ${object.polissa_id.titular.name}</li><br>
<li>Període del  ${data_inici} al  ${data_final}</li><br>
<li><B> Import total: ${object.invoice_id.amount_total}</B>€</li><br>
</ul>
Accedeix a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b> per veure les teves factures i gestionar els teus contractes amb la cooperativa.<br>
<br>
Aprofitem l’avinentesa per informar-te que, tal com ha regulat la Comissió Nacional dels Mercats i la Competència, a partir de novembre de 2020, entrarà en vigor un canvi en la tarificació de les factures de subministrament elèctric.<br>
<br>
En aquesta <b><a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2020/01/com-canviara-la-factura-delectricitat/">notícia del nostre blog</a></b> trobaràs més informació sobre els canvis.<br>
<br>
<h2 align="center">Vols produir electricitat verda de forma col·lectiva? <br>
Participa en la <a href="http://www.generationkwh.org/ca/">Generació kWh</a> i suma't al canvi!</h2><br>
<br>
Atentament,<br>
<br>
Equip de Som Energia<br>
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre de Suport</a><br>
factura@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
<p><br>
Saludos,<br>
<br>
Te enviamos la <B>factura</B> de electricidad de Som Energia. <br>
<br>
Cargaremos el importe en tu cuenta bancaria durante los próximos días. <br>
<br>
Si tienes dificultades para afrontar el pago de esta factura a raíz de la crisis de la <B>COVID-19</B>, te ofrecemos la posibilidad de aplazarlo un mes. Para ello, puedes solicitarlo respondiendo este mismo correo.
<br>
Si ya has aplazado el pago de alguna factura anterior y sigues teniendo dificultades, podemos ofrecerte el fraccionamiento de la deuda.
<br>
Si esta factura corresponde al contrato de una empresa, también puedes responder este correo y pedir el pago fraccionado de las facturas que se generen mientras dure el estado de alarma, tal como regula el <a href="https://boe.es/buscar/pdf/2020/BOE-A-2020-4208-consolidado.pdf">Real Decreto-ley 11/2020</a>.
<br>
Si eres autónomo o autónoma, también puedes acogerte a este pago fraccionado pero, en este caso, necesitamos que nos envíes una copia del Justificante de Alta en el Régimen Especial de Trabajadores Autónomos de la Seguridad Social (RETA) con tu petición.
<br>
</p>
<br>
<U><B>Resumen de la factura</B></U><br>
<ul><li>Número factura: ${object.number}</li><br>
<li>Codigo CUPS: ${object.cups_id.name}</li><br>
<li>Dirección punto suministro: ${object.cups_id.direccio}</li><br>
<li>Titular: ${object.polissa_id.titular.name}</li><br>
<li>Periodo del  ${data_inici} al  ${data_final}</li><br>
<li><B>Importe total: ${object.invoice_id.amount_total}</B>€</li><br>
</ul>
Accede a la <b><a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a></b> para ver tus facturas y gestionar tus contratos de la cooperativa.<br>
<br>
Aprovechamos la ocasión para informarte de que, tal como ha regulado la Comisión Nacional de los Mercados y la Competencia, a partir de noviembre de 2020, entrará en vigor un cambio en la tarificación de las facturas de suministro eléctrico.<br>
<br>
En esta <b><a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2020/01/como-cambiara-la-factura-de-electricidad/">noticia de nuestro blog</a></b> encontrarás más información sobre los cambios.<br>
<br>
<h2 align="center">¿Quieres producir electricidad verde de forma colectiva? <br>
Participa en la <a href="http://www.generationkwh.org">Generación kWh</a> ¡y súmate al cambio!</h2><br>
<br>
Atentamente,<br>
<br>
Equipo de Som Energia<br>
<a href="http://es.support.somenergia.coop/category/139-ya-tengo-la-luz-contratada">Centro de Ayuda</a><br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
