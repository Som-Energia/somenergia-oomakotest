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
<br>
<br>
Aprofitem l’avinentesa per informar-te que, tal com ha regulat la Comissió Nacional dels Mercats i la Competència, a partir de novembre de 2020, entrarà en vigor un canvi en la tarificació de les factures de subministrament elèctric.<br>
<br>
Pels punts de subministrament de menys de 15 KW de potència contractada, s’establiran tres preus diferents pel terme d’energia que correspondran a les franges horàries següents:<br>
<br>
<ul>
<li>Període punta (el més car): De dilluns a divendres (laborables) entre les 10 i les 14h i entre les 18 i les 22h.</li>
<li>Període pla (preu intermig): De dilluns a divendres (laborables) de 8 a 10h, entre les 14 i 18h i entre les 22h i la mitjanit.</li>
<li>Període vall (el més econòmic): De dilluns a divendres (laborables) de mitjanit a les 8h i totes les hores del dia els dissabtes, diumenges i festius d’àmbit estatal.</li>
</ul>
<br>
Pel que fa a la potència contractada, s’obrirà la possibilitat de contractar dues potències diferents: Una pel tram horari entre les 8 del matí i la mitjanit i una altra entre la mitjanit i les 8h. Els preus per potència contractada podrien ser diferents en aquests dos horaris.<br>
<br>
Pels contractes 3.0A, de més de 15 KW, s’establiran sis períodes de facturació diferents que dependran de la franja horària i el mes de l’any.<br>
<br>
Pròximament publicarem una notícia al nostre blog on informarem més detalladament d’aquests canvis.<br>
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
<br>
<br>
Aprovechamos la ocasión para informarte de que, tal como ha regulado la Comisión Nacional de los Mercados y la Competencia, a partir de noviembre de 2020, entrará en vigor un cambio en la tarificación de las facturas de suministro eléctrico.<br>
<br>
Para aquellos puntos de suministro de menos de 15 KW de potencia contratada, se establecerán tres precios diferentes para el término de energía que corresponderán a las siguientes franjas horarias:<br>
<br>
<ul>
<li>Período punta (el más caro): De lunes a viernes (laborables) entre las 10 y las 14h y entre las 18 y las 22h.</li>
<li>Período llano (precio intermedio): De lunes a viernes (laborables) de 8 a 10h, entre las 14 y las 18h y entre las 22h y la medianoche.</li>
<li>Período valle (el más económico): De lunes a viernes (laborables) desde medianoche a las 8h y todas las horas del día en sábados, domingos y festivos de ámbito estatal.</li>
</ul>
<br>
En lo que respecta a la potencia contratada, se abrirá la posibilidad de contratar dos potencias diferentes: Una para el tramo horario entre las 8 de la mañana y la medianoche y otra entre medianoche y las 8h. Los precios por potencia contratada podrían ser diferentes en estos dos horarios.<br>
<br>
Para contratos 3.0A, de más de 15 KW, se establecerán seis períodos de facturación diferentes que dependerán de la franja horaria y el mes del año.<br>
<br>
Próximamente publicaremos una noticia en nuestro blog donde informaremos más detalladamente de estos cambios.<br>
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
