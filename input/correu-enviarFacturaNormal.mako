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

def getLink(language, potencia):
    link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-la-factura-per-a-contractes-domestics-i-petites-empreses/"
    if potencia > 15.0:
        link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-factura-per-a-contractes-dempreses-de-mes-de-15-kw/" if language != "es_ES" else "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-cambio-de-factura-para-contratos-de-empresas-de-mas-de-15-kw/"
    else:
        link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-la-factura-per-a-contractes-domestics-i-petites-empreses/" if language != "es_ES" else "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-cambio-de-la-factura-para-contratos-domesticos-y-pequenas-empresas/"
    return link

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
T'informem que l'1 de juny de 2021 va entrar en vigor un canvi en la tarificació de les factures de subministrament elèctric regulat per la Comissió Nacional dels Mercats i la Competència. Si ets titular d'un contracte de fins a 15 kW (majoritàriament domèstics i algunes petites empreses i locals comercials), pots visitar el nostre blog, on hi ha <b><a href="https://blog.somenergia.coop/destacados/2021/04/la-nova-tarifa-2-0td-per-a-contractes-domestics-i-petites-empreses/">més informació sobre la nova tarifa</a></b>. Al Centre d’Ajuda també t’expliquem detalladament a què correspon <b><a href="https://ca.support.somenergia.coop/article/488-entendre-la-factura">cadascun dels apartats de la factura</a></b>.<br>
<br>
Per a contractes de més de 15 kW de potència contractada, trobareu informació més detallada en <b><a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/tarifa-3-0/2021/04/les-noves-tarifes-per-a-contractes-de-mes-de-15-kw-o-dalta-tensio/">aquest altre enllaç del blog</a></b>.<br>
<br>
Aquest canvi en la tarificació requereix una etapa d’adaptació. Per aquest motiu, és possible que durant les setmanes posteriors a l’1 de juny de 2021, s’emetin factures amb un període de facturació més curt de l’habitual, que coincideixin dos càrrecs en un mateix mes, o bé, que s’endarrereixi l’enviament d’alguna de les factures.<br>
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
Pots accedir a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b> per veure les teves factures i gestionar els contractes que tens amb la cooperativa.<br>
<br>
Atentament,<br>
<br>
Equip de Som Energia<br>
<a href="http://ca.support.somenergia.coop/category/183-ja-tinc-la-llum-contractada">Centre d'ajuda</a><br>
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
Te informamos que el 1 de junio de 2021 entró en vigor un cambio en la tarificación de las lecturas de suministro eléctrico regulado por la Comisión Nacional de los Mercados y la Competencia. Si eres titular de un contrato de hasta 15 kW (mayoritariamente domésticos y algunas pequeñas empresas y locales comerciales), puedes visitar nuestro blog, donde hay <b><a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/tarifas-y-precios-de-la-luz/2021/04/la-nueva-tarifa-2-0td-para-contratos-domesticos-y-pequenas-empresas/">más información sobre la nueva tarifa</a></b>. En el Centro de Ayuda también te explicamos detalladamente <b><a href="https://es.support.somenergia.coop/article/489-entender-la-factura">a qué corresponde cada uno de los apartados de la factura</a></b>.<br>
<br>
Para contratos de más de 15 kW de potencia contratada, encontraréis información más detallada en <b><a href="https://blog.somenergia.coop/destacados/2021/04/las-nuevas-tarifas-para-contratos-de-mas-de-15-kw-o-de-alta-tension/">este otro enlace del blog</a></b>.<br>
<br>
Este cambio en la tarificación requiere una etapa de adaptación. Por este motivo, es posible que durante las semanas posteriores al 1 de junio de 2021, se emitan facturas con un período de facturación más corto de lo habitual, que coincidan dos cargos en un mismo mes, o bien, que se retrase el envío de alguna de las facturas.<br>
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
