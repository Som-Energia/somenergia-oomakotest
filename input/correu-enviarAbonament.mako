<!doctype html>
<html>
<head><meta charset='utf8'></head>
<body>
<table width="100%" frame="below" BGCOLOR="#F2F2F2">
% if object.invoice_id.partner_id.lang == "ca_ES":
<tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td>
<td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font></td></tr>
<tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr>
% else:
<tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td>
<td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr>
<tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_id.direccio}</font></td></tr>
<tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups_id.name}</font></td></tr>
<tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr>
% endif
</table>
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
<%
import datetime
data_inici = datetime.datetime.strptime(object.data_inici, '%Y-%m-%d').strftime('%d-%m-%Y')
data_final = datetime.datetime.strptime(object.data_final, '%Y-%m-%d').strftime('%d-%m-%Y')

def getLink(language, potencia):
    link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-la-factura-per-a-contractes-domestics-i-petites-empreses/"
    if potencia > 15.0:
        link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-factura-per-a-contractes-dempreses-de-mes-de-15-kw/" if language != "es_ES" else "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-cambio-de-factura-para-contratos-de-empresas-de-mas-de-15-kw/"
    else:
        link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-la-factura-per-a-contractes-domestics-i-petites-empreses/" if language != "es_ES" else "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-cambio-de-la-factura-para-contratos-domesticos-y-pequenas-empresas/"
    return link

%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.polissa_id.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object.polissa_id._cr, object.polissa_id._uid,object.polissa_id.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>
<br>
Hola${nom_pagador},<br>
% if object.invoice_id.partner_id.lang != "es_ES":
<br>
T'enviem la <B>factura d'abonament</B> d'una factura anterior d'electricitat de Som Energia, ja que les lectures facturades no eren correctes.<br>
<br>
Aquesta factura d'abonament anul·la la que havíem emès anteriorment per al mateix període.<br>
<br>
En cas d'haver-te cobrat la factura original, la setmana vinent realitzarem els moviments bancaris corresponents.<br>
<br>
<U>Resum de la factura ABONADA</U><br>
- Adreça punt subministrament: ${object.cups_id.direccio}<br>
- Codi CUPS: ${object.cups_id.name}<br>
- Titular: ${object.polissa_id.titular.name}<br>
- Número de factura: ${object.number}<br>
- Data factura: ${object.invoice_id.date_invoice}<br>
- Període del ${data_inici} al ${data_final}<br>
-<B> Import total: ${object.invoice_id.amount_total}</B>€ <br>
<br>
Si tens qualsevol dubte, pots respondre aquest mateix correu.<br>
<br>
Pots accedir a l'<b><a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a></b> per veure les teves factures i gestionar els contractes que tens amb la cooperativa.<br>
<br>
Al Centre d’Ajuda també t’expliquem detalladament a què correspon <b><a href="https://ca.support.somenergia.coop/article/488-entendre-la-factura">cadascun dels apartats de la factura</a></b>. Si detectes algun error en la factura, ens ho pots comunicar responent aquest mateix correu. T’informem que l’Equip de Treball de Som Energia es troba en un <b><a href="https://blog.somenergia.coop/som-energia/2021/09/moment-excepcional-en-el-servei-de-comercialitzacio-de-som-energia/">moment excepcional</a></b> de càrrega de feina i això pot fer que triguem uns dies més en respondre.<br>
<br>
<br>
Atentament,<br>
<br>
Equip de Som Energia<br>
factura@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES" and  object.invoice_id.partner_id.lang != "es_ES":
<HR align="LEFT" size="1" width="400" color="Black" noshade>
% endif
% if  object.invoice_id.partner_id.lang != "ca_ES":
<br>
Te enviamos la <B>factura abonadora</B> de una factura anterior de electricidad de Som Energia, ya que las lecturas facturadas no eran correctas.<br>
<br>
Esta factura abonadora anula la que habíamos emitido anteriormente para el mismo periodo.<br>
<br>
En caso de haber cobrado la factura original, la próxima semana realizaremos los movimientos bancarios correspondientes.<br>
<br>
<U>Resumen de la factura ABONADA</U><br>
- Dirección punto suministro: ${object.cups_id.direccio}<br>
- Titular: ${object.polissa_id.titular.name}<br>
- Codigo CUPS: ${object.cups_id.name}<br>
- Número factura: ${object.number}<br>
- Fecha factura: ${object.invoice_id.date_invoice}<br>
- Periodo del ${data_inici} al ${data_final}<br>
- <B>Importe total: ${object.invoice_id.amount_total}</B>€<br>
<br>
Si tienes cualquier duda, puedes responder este mismo correo.<br>
<br>
Accede a la <b><a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a></b> para ver tus facturas y gestionar tus contratos de la cooperativa.<br>
<br>
En el Centro de Ayuda también te explicamos detalladamente <b><a href="https://es.support.somenergia.coop/article/489-entender-la-factura">a qué corresponde cada uno de los apartados de la factura</a></b>. Si detectas algún error en la factura, nos lo puedes comunicar respondiendo este mismo correo. Te informamos que el Equipo de Som Energia se encuentra en un <b><a href="https://blog.somenergia.coop/som-energia/2021/09/momento-excepcional-en-el-servicio-de-comercializacion-de-som-energia/">momento excepcional</a></b> de carga de trabajo y esto puede suponer que tardemos unos días más en responder.<br>
<br>
<br>
Atentamente,<br>
<br>
Equipo de Som Energia<br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop/">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
</html>