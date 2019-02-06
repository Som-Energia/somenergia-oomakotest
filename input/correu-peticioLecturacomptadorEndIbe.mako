<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><img width='170' height='85' src="https://www.somenergia.coop/templates/somenergia/images/logo_web.jpg"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head><body>
% else:
<head><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><img width='170' height='85' src="https://www.somenergia.coop/templates/somenergia/images/logo_web.jpg"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head><body>
% endif
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
Hola${nom_titular},

% if object.titular.lang != "es_ES":
Ens posem en contacte amb tu en relació a la facturació dels últims mesos. 
Les tres últimes lectures (com a mínim)  facilitades per la distribuïdora han estat <b>estimades</b>. 

Per evitar possibles facturacions errònies, et recomanem informar de la lectura que marca el teu comptador a través del portal de la distribuïdora.  N'hi haurà prou en prendre nota de la lectura, sense decimals, i:

% if object.distribuidora.name == 'ENDESA DISTRIBUCIÓN ELÉCTRICA S. L.':
<ul>1. Accedir a la pàgina web: <a href="http://www.lecturas.endesadistribucion.es/lecturas/">Endesa: introducció de lectures</a>. L'horari de funcionament del portal és de 8:00 a 20:00 h.</ul>
<ul>2. Omplir els camps amb la informació <strong>en negreta</strong>:</ul>
<ul><ul><li>En el primer camp, omplir els sis primers dígits del CUPS: <strong>${cups_digits_endesa}</strong> </li>
<li>En el segon, el contracte amb la distribuïdora: <strong>${object.ref_dist}</strong></li>
<li>Accedeixes a la pàgina a la que introdueixes la lectura del comptador</li></ul></ul>
Si tens algun problema amb la introducció de la lectura a través del portal, pots trucar al telèfon gratuït de Endesa distribución: <b>902 50 96 00</b>
% elif  object.distribuidora.name == 'IBERDROLA DISTRIBUCIÓN ELÉCTRICA, S.A.U':
<ul><li>1. Accedir a la pàgina web: <a href="https://www.iberdroladistribucionelectrica.com/01disd/clienteswtg/Iberdrola?IDPAG=ESWTG_AUTOLECTURAS_PUA">Iberdrola: introducció de lectures</a></li></ul>
<ul>2. Omplir els camps amb la informació <strong>en negreta</strong>:</ul>
<ul><ul><li>Seleccionar <u>NIF</u> i introduir el del titular:<strong>${object.titular_nif[2:]}</strong> </li>
<li>Seleccionar <u>(conozco CUPS)</u> i introduir els 20 primers dígits del codi CUPS: <strong>${cups_digits_iberdrola}</strong></li>
<li>Accedeixes a la pàgina a la que introdueixes la lectura del comptador</li></ul></ul>
Si tens algun problema amb la introducció de la lectura a través del portal, pots trucar al telèfon gratuït de Iberdrola distribución: <b>900 17 11 71</b>
% endif


Moltes gràcies, 

Atentament,

Equip de Som Energia
factura@somenergia.coop
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":
Nos ponemos en contacto contigo en relación a la facturación de los últimos meses. 
Las tres últimas lecturas, como mínimo, facilitadas por la distribuidora han sido <b>estimadas</b>.

Para evitar posibles facturaciones erróneas, te recomendamos comunicar la lectura de tu contador en el portal web de la distribuidora. Bastará con tomar nota de la lectura, sin decimales, y; 

% if object.distribuidora.name == 'ENDESA DISTRIBUCIÓN ELÉCTRICA S. L.':
<ul>1. Acceder a la página web: <a href="http://www.lecturas.endesadistribucion.es/lecturas/">Endesa: introducción de lecturas</a>. El horario de funcionamiento del portal es de 8:00 a 20:00 h.</ul>
<ul>2. Rellenar los campos con la información <strong> en negrita </strong>: </ul>
<ul><ul><li>En el primer campo, escribe los séis primeros dígitos del CUPS: <strong>${cups_digits_endesa}</strong> </li>
<li>En el segundo, el contrato con la distribuidora: <strong>${object.ref_dist}</strong></li>
<li>Ya puedes indicar la lectura del contador.</li></ul></ul>
Si tienes algún problema con la introducción de la lectura mediante el portal, puedes llamar al teléfono gratuito de Endesa distribución: <b>902 50 96 00</b>
% elif  object.distribuidora.name == 'IBERDROLA DISTRIBUCIÓN ELÉCTRICA, S.A.U':
<ul>1. Acceder a la página web: <a href="https://www.iberdroladistribucionelectrica.com/01disd/clienteswtg/Iberdrola?IDPAG=ESWTG_AUTOLECTURAS_PUA">Iberdrola: introducción de lecturas</a></ul>
<ul>2. Rellenar unos campos con la información <strong>en negrita</strong> que tienes a continuación:</ul>
<ul><ul><li>Selecciona e introduce el <u>NIF</u> del titular:<strong>${object.titular_nif[2:]}</strong></li>
<li>Selecciona <u>(conozco CUPS)</u> con los 20 primeros dígitos del código CUPS: <strong>${cups_digits_iberdrola}</strong></li>
<li>Ya puedes indicar la lectura del contador.</li></ul></ul>
Si tienes algún problema con la introducción de la lectura mediante el portal, puedes llamar al teléfono gratuito de Iberdrola distribución: <b>900 17 11 71</b>
% endif

Muchas gracias,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop">www.somenergia.coop</a>
% endif
</body>
</html>
</html>