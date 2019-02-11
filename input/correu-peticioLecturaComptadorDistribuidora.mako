<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><img width='170' height='85' src="https://www.somenergia.coop/templates/somenergia/images/logo_web.jpg"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><img width='170' height='85' src="https://www.somenergia.coop/templates/somenergia/images/logo_web.jpg"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
% endif
<body>
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
cups_digits_endesa = object.cups.name [2:8]
cups_digits_iberdrola = object.cups.name[:19]
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.titular.vat'):
    nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.titular.name)['nom']
  else:
    nom_titular = ''
except:
  nom_titular = ''
try:
  from datetime import datetime
  date = datetime.strptime(object.data_ultima_lectura, '%Y-%m-%d')
  data_ultima_lectura = date.strftime('%d/%m/%Y')
except:
  data_ultima_lectura = 'Error'
%>
<br>
Hola${nom_titular},<br>
<br>
% if object.titular.lang != "es_ES":
Ens posem en contacte amb tu en relació a la facturació dels últims mesos. <br>
La distribuïdora encara no ens ha facilitat la lectura del teu comptador, per aquest motiu no t’hem pogut enviar les factures pertinents.<br>
<br>
% if data_ultima_lectura != 'Error':
Ens consta que la darrera  lectura és del <strong>${data_ultima_lectura}</strong><br>
% endif
<br>
% if object.distribuidora.ref == '0031' or object.distribuidora.ref == '0021':
Per aquesta raó, et demanem que introdueixis la lectura manualment al portal web que la distribuïdora té per a aquests tipus de casos; n'hi haurà prou en prendre nota de la lectura, sense decimals.<br>
 <br>
% if object.distribuidora.ref == '0031':
<ul>1. Accedeix a la pàgina web: <a href="http://www.lecturas.endesadistribucion.es/lecturas/">Endesa: introducció de lectures</a>. L'horari de funcionament del portal és de 8:00 a 20:00 h.</ul>
<ul>2. Omple els camps amb la informació <strong>en negreta</strong>:</ul>
<ul><ul><li>En el primer camp, has d'omplir els sis primers dígits del CUPS: <strong>${cups_digits_endesa}</strong> </li>
<li>En el segon, el contracte amb la distribuïdora: <strong>${object.ref_dist}</strong></li>
<li>Accedeixes a la pàgina a la que introdueixes la lectura del comptador</li></ul></ul>
Si tens problemes amb la introducció de la lectura a través del portal, pots trucar al telèfon  gratuït de Endesa distribución: <b>902 50 96 00</b><br>
<br>
% elif object.distribuidora.ref == '0021':
<ul>1. Accedeix a la pàgina web: <a href="https://www.iberdroladistribucionelectrica.com/01disd/clienteswtg/Iberdrola?IDPAG=ESWTG_AUTOLECTURAS_PUA">Iberdrola: introducció de lectures</a></ul>
<ul>2. Omple els camps amb la informació <strong>en negreta</strong>:</ul>
<ul><ul><li>Selecciona i introdueix el <u>NIF</u> del titular: <strong>${object.titular_nif[2:]}</strong> </li>
<li>Selecciona <u>(conozco CUPS)</u> amb els 20 primers dígits del codi CUPS: <strong>${cups_digits_iberdrola}</strong></li>
<li>Accedeixes a la pàgina a la que introdueixes la lectura del comptador</li></ul></ul>
Si tens problemes amb la introducció de la lectura a través del portal, pots trucar al telèfon  gratuït de Iberdrola distribución: <b>900 17 11 71</b><br>
<br>
% endif
% else:
La responsable de realitzar la lectura del teu comptador segueix sent la companyia distribuïdora. A vegades, per diferent motius (el comptador està en el interior del domicili, cases aïllades, etc.) no es realitzen les lectures en el temps estipulat.  Per això, les diferents distribuïdores posen a disposició de l'usuari les següents pàgines web per que es pugui aportar la lectura:<br>
<br>
- E.ON Distribución (CUPS que comencen per ES0027); funciona amb registre previ, en 2 passos. <a href="http://www.eonspaindistribution.com/web/guest/autolectura-publico;jsessionid=E4CF2434482A52A067105AA05DC6AB09.sliferay1portalexp">E.on: introducció de lectures</a><br>
<br>
<br>
- FENOSA-GasNatural; (CUPS que comencen per ES0022) us demanaran NIF/CIF y el codi CUPS (20 dígits)<a href="http://www.unionfenosadistribucion.com/es/gestiones+en+linea/lectura+del+contador/1297101959899/facilitar+lectura.html">Unión Fenosa:  introducció de lectures</a><br>
<br>
<br>
- EDP - Hidroeléctrica del Cantábrico (CUPS que comencen per ES0026) us demanaran les dades del titular que apareixen a la factura. <a href="https://www.edphcenergia.es/gestionesonlineluz(bD1lcyZjPTAwMg==)/gestionesWeb.do?action=cwFormRequest&action_ex=X17"> EDP: introducció de lectures</a><br>
% endif
<br>
Esperem fer-te la factura el més aviat possible.<br>
<br>
Moltes gràcies.<br>
<br>
Atentament,<br>
<br>
Equip de Som Energia<br>
factura@somenergia.coop<br>
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":
Nos ponemos en contacto contigo en relación con la facturación de los últimos meses.<br>
La distribuidora de tu zona todavía no nos ha facilitado la lectura de tu contador, por este motivo no te hemos podido enviar las facturas pertinentes.<br>
<br>
% if data_ultima_lectura != 'Error':
Nos consta que la última lectura es del: <strong>${data_ultima_lectura}</strong>.<br>
% endif
<br>
% if object.distribuidora.ref == '0031' or object.distribuidora.ref == '0021':
Por esta razón, te pedimos que introduzcas la lectura manualmente en el portal web de la distribuidora para este tipo de casos: Bastará con tomar nota de la lectura, sin decimales.<br>
<br>
% if object.distribuidora.ref == '0031':
<ul>1. Accede a la página web: <a href="http://www.lecturas.endesadistribucion.es/lecturas/">Endesa: introducción de lecturas</a>. El horario de funcionamiento del portal es de 8:00 a 20:00</ul>
<br>
<ul>2. Rellena los campos con la información <strong> en negrita </strong>: </ul>
<ul><ul><li>En el primer campo tienes que escribir los séis primeros dígitos del CUPS: <strong>${cups_digits_endesa}</strong> </li>
<li>En el segundo, el contrato con la distribuidora: <strong>${object.ref_dist}</strong></li>
<li>Accedes a la página en la que se introduce la lectura del contador.</li></ul></ul>
Si tiene problema con la introducción de la lectura mediante el portal, puedes llamar al teléfono gratuito de Endesa distribución: <b>902 50 96 00</b><br>
<br>
% elif object.distribuidora.ref == '0021':
<ul>1. Accede a la página web: <a href="https://www.iberdroladistribucionelectrica.com/01disd/clienteswtg/Iberdrola?IDPAG=ESWTG_AUTOLECTURAS_PUA">Iberdrola: introducción de lecturas</a></ul>
<ul>2. Tendrás que rellenar unos campos con la información <strong>en negrita</strong> que tienes a continuación:</ul>
<ul><ul><li>Selecciona e introduce el <u>NIF</u> del titular:<strong>${object.titular_nif[2:]}</strong></li>
<li>Selecciona <u>(conozco CUPS)</u> con los 20 primeros dígitos del código CUPS: <strong>${cups_digits_iberdrola}</strong></li>
<li>Accedes a la página en la que se introduce la lectura del contador.</li></ul></ul>
Si tiene problema con la introducción de la lectura mediante el portal, puedes llamar al teléfono gratuito de Iberdrola distribución: <b>900 17 11 71</b><br>
% endif
<br>
% else:
La responsable de realizar la lectura de tu contador sigue siendo la compañía distribuidora. A veces, por diferentes motivos (el contador está en el interior del domicilio, casas aisladas, etc) no se realizan las lecturas en el tiempo estipulado. Para ello las diferentes distribuidoras ponen a disposición del usuario diferentes aplicaciones para que éste pueda aportar la lectura cómodamente desde su casa: <br>
<br>
A continuación os indicamos cuáles son las distribuidoras según vuestra zona: <br>
<br>
- E.ON Distribución (CUPS que empiezan por ES0027); funciona con registro previo, en 2 pasos. <a href="http://www.eonspaindistribution.com/web/guest/autolectura-publico;jsessionid=E4CF2434482A52A067105AA05DC6AB09.sliferay1portalexp">E.on: introducción de lecturas</a><br>
<br>
<br>
- FENOSA-GasNatural; (CUPS que empiezan por ES0022) os pedirán el NIF/CIF y el código CUPS (20 dígitos)<a href="http://www.unionfenosadistribucion.com/es/gestiones+en+linea/lectura+del+contador/1297101959899/facilitar+lectura.html">Unión Fenosa:  introducción de lecturas</a><br>
<br>
<br>
- EDP - Hidroeléctrica del Cantábrico (CUPS que empiezan por ES0026) os pedirán los datos del titular que aparecen en la factura. <a href="https://www.edphcenergia.es/gestionesonlineluz(bD1lcyZjPTAwMg==)/gestionesWeb.do?action=cwFormRequest&action_ex=X17"> EDP: introducción de lecturas</a><br>
% endif
<br>
<br>
Una vez envíes la información, esperamos poder enviar la factura lo antes possible.<br>
<br>
Muchas gracias.<br>
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