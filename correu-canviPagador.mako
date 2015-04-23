<!doctype html>
<html>
<body>
% if object.titular.lang == "ca_ES":
<table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table>
% else:
<table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table>
% endif
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid,'object.pagador.vat'):
    nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.pagador.name)['nom']
  else:
    nom_pagador = ''
except:
  nom_pagador = ''

try:
  from datetime import datetime
  date = datetime.strptime(object.comptadors[0].lectures[0].name,'%Y-%m-%d')
  data_ultima_lectura = date.strftime('%d/%m/%Y')
except:
  data_ultima_lectura = ''

try:
  lectures = object.comptadors[0].lectures
except:
  lectures = []

def lecturesPn(*args):
  return ', '.join((
      'P%s %s kWh'%(i+1,lectures[l].lectura)
      for i,l in enumerate(args)
      ))

try:
  if 'DHA' in object.tarifa.name:
    ultima_lectura = lecturesPn(0,1)
  elif 'DHS' in object.tarifa.name:
    ultima_lectura = lecturesPn(0,1,2)
  elif '3.0A' in object.tarifa.name:
    ultima_lectura = lecturesPn(0,2,4,6,8,10)
  elif '3.1A' in object.tarifa.name:
    ultima_lectura = lecturesPn(0,2,4)
  else:
    ultima_lectura = '%s kWh'%(lectures[0].lectura)
except:
  ultima_lectura = ''

%>
Hola${nom_pagador},
% if  object.titular.lang != "es_ES":

Tal i com ens heu sol·licitat, hem canviat la persona pagadora del següent contracte:

<b>Dades del contacte</b>:
- Número:  ${object.name}
- CUPS: ${object.cups.name}
- Adreça: ${object.cups.direccio}

<b>Dades del canvi de pagador:</b>
- Data del canvi: ${data_ultima_lectura}
- Lectura comptador: ${ultima_lectura}  
- Nova persona pagadora: ${object.pagador.name}

Per a qualsevol dubte o consulta, estem en contacte.

Salutacions,

Equip de Som Energia
factura@somenergia.coop
<a href="www.somenergia.coop">www.somenergia.coop</a>
<div align="center"><img src="https://www.somenergia.coop/images/stories/moduls/ca/energia-verda.jpg" border=0></div>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":

Tal y como nos habéis solicitado, hemos cambiado la persona pagadora del siguiente contrato:

<b>Datos del contrato:</b>
- Número:  ${object.name}
- CUPS: ${object.cups.name}
- Dirección: ${object.cups.direccio}

<b>Datos del cambio:</b>
- Fecha de cambio: ${data_ultima_lectura}
- Lectura del contador: ${ultima_lectura}
- Nova persona pagadora:  ${object.pagador.name}

Para cualquier duda o consulta,

Atentamente,

Equipo de Som Energia
factura@somenergia.coop
<a href="http://www.somenergia.coop/es/">www.somenergia.coop</a>
<div align="center"><img src="https://www.somenergia.coop/images/stories/moduls/es/energia-verda-cast.jpg" border=0></div>
% endif
</body>
</html>
