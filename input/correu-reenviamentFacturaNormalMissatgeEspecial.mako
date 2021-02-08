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
Ens posem en contacte amb tu perquè hem detectat que hi ha hagut una incidència durant l’enviament de la <B>darrera factura</B>. El document que t’hem enviat no es podia obrir correctament.<br>
<br>
Ja ho hem resolt i te la tornem a fer arribar adjunta en aquest correu. Disculpa les molèsties.<br>
<br>
Com et comentàvem, carregarem l'import d'aquesta factura al teu número de compte durant els pròxims dies.<br>
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
Aprofitem l'avinentesa per informar-te que, tal com ha regulat la Comissió Nacional dels Mercats i la Competència, a partir de l’abril de 2021 entrarà en vigor un canvi en la tarificació de les factures de subministrament elèctric (inicialment previst pel novembre de 2020).<br>
<br>
En aquesta <b><a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2020/01/com-canviara-la-factura-delectricitat/">notícia del nostre blog</a></b> trobaràs més informació sobre els canvis.<br>
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
Nos ponemos en contacto contigo porqué hemos detectado que ha habido una incidencia durante el envío de la <B>última factura</B>. El documento que te hemos mandado no se podía abrir correctamente.<br>
<br>
Ya hemos resuelto el problema y te la adjuntamos nuevamente en este correo. Disculpa las molestias.<br>
<br>
Como te comentábamos, cargaremos el importe en tu cuenta bancaria durante los próximos días. <br>
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
Aprovechamos la ocasión para informarte de que, tal como ha regulado la Comisión Nacional de los Mercados y la Competencia, a partir de abril de 2021 entrará en vigor un cambio en la tarificación de las facturas de suministro eléctrico (inicialmente previsto para noviembre de 2020).<br>
<br>
En esta <b><a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2020/01/como-cambiara-la-factura-de-electricidad/">noticia de nuestro blog</a></b> encontrarás más información sobre los cambios.<br>
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
