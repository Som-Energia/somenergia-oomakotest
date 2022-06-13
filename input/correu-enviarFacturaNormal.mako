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

def isTariffChange(f):
    ppu = {}
    for line in f.linies_energia:
        if line.name in ppu:
            if line.price_unit != ppu[line.name]:
                return True
        else:
            ppu[line.name] = line.price_unit
    ppu = {}
    for line in f.linies_potencia:
        if line.name in ppu:
            if line.price_unit != ppu[line.name]:
                return True
        else:
            ppu[line.name] = line.price_unit
    return False

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
Al Centre d’Ajuda també t’expliquem detalladament a què correspon <b><a href="https://ca.support.somenergia.coop/article/488-entendre-la-factura">cadascun dels apartats de la factura</a></b>.<br>
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
Pots accedir a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b> per veure les teves factures i gestionar els contractes que tens amb la cooperativa. Si detectes algun error en la factura, ens ho pots comunicar responent aquest mateix correu. T’informem que l’Equip de Treball de Som Energia es troba en un <b><a href="https://blog.somenergia.coop/som-energia/2021/09/moment-excepcional-en-el-servei-de-comercialitzacio-de-som-energia/">moment excepcional</a></b> de càrrega de feina i això pot fer que triguem uns dies més en respondre.<br>
<br>
% if isTariffChange(object):
Com que en el període que comprèn la teva factura hi ha hagut un canvi de tarifes, una part del terme d’energia i del terme de potència està facturada amb les tarifes d’abans del canvi, i l’altra part està facturada amb les noves tarifes. Això fa que, a la factura, apareguin dues línies (amb els dos preus) de cadascun dels conceptes d’energia i potència.<br>
<br>
% endif
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
En el Centro de Ayuda también te explicamos detalladamente <b><a href="https://es.support.somenergia.coop/article/489-entender-la-factura">a qué corresponde cada uno de los apartados de la factura</a></b>.<br>
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
Accede a la <b><a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a></b> para ver tus facturas y gestionar tus contratos de la cooperativa. Si detectas algún error en la factura, nos lo puedes comunicar respondiendo este mismo correo. Te informamos que el Equipo de Som Energia se encuentra en un <b><a href="https://blog.somenergia.coop/som-energia/2021/09/momento-excepcional-en-el-servicio-de-comercializacion-de-som-energia/">momento excepcional</a></b> de carga de trabajo y esto puede suponer que tardemos unos días más en responder.<br>
<br>
% if isTariffChange(object):
Como en el periodo que comprende tu factura ha habido un cambio de tarifas, una parte del término de energía y del término de potencia está facturada con las tarifas de antes del cambio, y la otra parte está facturada con las nuevas tarifas. Esto hace que, en la factura, aparezcan dos líneas (con los precios distintos) de cada uno de los conceptos de energía y potencia.<br>
<br>
% endif
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
