<!doctype html>
<html>
<body>
% if object.titular.lang == "ca_ES":
<table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table>
% else:
<table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table>
% endif
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
    ultima_lectura = lecturesPn(*range(0,12,2))
  elif '3.1A' in object.tarifa.name:
    ultima_lectura = lecturesPn(*range(0,6,2))
  else:
    ultima_lectura = '%s kWh'%(lectures[0].lectura)
except:
  ultima_lectura = ''

%>
<br>
Hola${nom_pagador},<br>
% if  object.titular.lang != "es_ES":
<br>
Tal i com ens heu sol·licitat, hem canviat la persona pagadora del següent contracte:<br>
<br>
<b>Dades del contacte</b>:<br>
- Número:  ${object.name}<br>
- CUPS: ${object.cups.name}<br>
- Adreça: ${object.cups.direccio}<br>
<br>
<b>Dades del canvi de pagador: </b><br>
- Data del canvi: ${data_ultima_lectura}<br>
- Lectura comptador: ${ultima_lectura}<br>
- Nova persona pagadora: ${object.pagador.name}<br>
<br>
Per a qualsevol dubte o consulta, estem en contacte.<br>
<br>
Salutacions,<br>
<br>
Equip de Som Energia<br>
factura@somenergia.coop<br>
<a href="www.somenergia.coop">www.somenergia.coop</a><br>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":
<br>
Tal y como nos habéis solicitado, hemos cambiado la persona pagadora del siguiente contrato:<br>
<br>
<b>Datos del contrato:</b><br>
- Número:  ${object.name}<br>
- CUPS: ${object.cups.name}<br>
- Dirección: ${object.cups.direccio}<br>
<br>
<b>Datos del cambio:</b><br>
- Fecha de cambio: ${data_ultima_lectura}<br>
- Lectura del contador: ${ultima_lectura}<br>
- Nova persona pagadora:  ${object.pagador.name}<br>
<br>
Para cualquier duda o consulta,<br>
<br>
Atentamente,<br>
<br>
Equipo de Som Energia<br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop/es/">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
