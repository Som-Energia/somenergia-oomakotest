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
<p>
Benvolgut/da,<br>
<br>
T'enviem la <B>factura</B> d'electricitat de Som Energia. <br>
<br>
Carregarem l'import d'aquesta factura al teu número de compte durant els propers dies.<br>
</p>
<br>
<U><B>Resum de la factura</B></U><br>
<ul><li>Número de factura: ${object.number}</li>
<li>Codi CUPS: ${object.cups_id.name}</li>
<li>Adreça punt subministrament: ${object.cups_id.direccio}</li>
<li>Titular: ${object.polissa_id.titular.name}</li>
<li>Període del  ${data_inici} al  ${data_final}</li>
<li><B> Import total: ${object.invoice_id.amount_total}</B>€</li>
</ul><br>
Accedeix a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b> per veure les teves factures i gestionar els teus contractes amb la cooperativa.<br>
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
<p>
Saludos,<br>
<br>
Te enviamos la <B>factura</B> de electricidad de Som Energia. <br>
<br>
Cargaremos el importe en tu cuenta bancaria durante los próximos días. <br>
</p>
<br>
<U>Resumen de la factura</U><br>
<ul><li>Número factura: ${object.number}</li>
<li>Codigo CUPS: ${object.cups_id.name}</li>
<li>Dirección punto suministro: ${object.cups_id.direccio}</li>
<li>Titular: ${object.polissa_id.titular.name}</li>
<li>Periodo del  ${data_inici} al  ${data_final}</li>
<li><B>Importe total: ${object.invoice_id.amount_total}</B>€</li>
</ul><br>
<br>
Accede a la <b><a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a></b> para ver tus facturas y gestionar tus contratos de la cooperativa.<br>
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
