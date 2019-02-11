<!doctype html>
<html>
<body>
% if object.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
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
  data_tall_dt = datetime.strptime(object.comptadors[0].data_alta,'%Y-%m-%d')
  data_tall = "el  " + data_tall_dt.strftime('%d/%m/%Y')
except:
  data_tall = ''

try:
  lectures_tall = object.comptadors[1].lectures
  pool_lectures = object.comptadors[1].pool_lectures
  lectures_alta = object.comptadors[0].lectures
except:
  lectures_tall = []
  pool_lectures = []
  lectures_alta =[]

try:
  def lecturesPn(lectures, *args):
    if lectures[1].tipus == 'R':
      return ', '.join((
           'P%s %s kWh'%(i+1,lectures[l].lectura)
           for i,l in [(0,0),(1,2)]
            ))
    else:
      return ', '.join((
           'P%s %s kWh'%(i+1,lectures[l].lectura)
           for i,l in enumerate(args)
            ))

  def lecturesAlta(lectures):
    if lectures[1].tipus == 'R':
      return ', '.join((
           'P%s %s kWh'%(i+1,lectures[l].lectura)
           for i,l in [(0,-1),(1,-3)]
            ))
    else:
      return ', '.join((
           'P%s %s kWh'%(i+1,lectures[l].lectura)
           for i,l in [(0,-2),(1,-1)]
            ))
except:
  lecturesPn = ''
  lecturesAlta = ''

try:
  if 'DHA' in object.tarifa.name:
    ultima_lectura = lecturesPn(lectures_tall,0,1)
    lectura_tall = lecturesPn(pool_lectures,0,1)
    lectura_inici = lecturesAlta(lectures_alta)
  else:
    ultima_lectura = '%s kWh'%(lectures_tall[0].lectura)
    lectura_tall = '%s kWh'%(pool_lectures[0].lectura)
    lectura_inici = '%s kWh'%(lectures_alta[-1].lectura)
except:
  ultima_lectura = ''
  lectura_tall = ''
  lectura_inici = ''

try:
  from datetime import datetime
  data_sobreestimada_dt = datetime.strptime(object.comptadors[0].lectures[0].name,'%Y-%m-%d')
  data_sobreestimada = "a " + data_sobreestimada_dt.strftime('%d/%m/%Y')
except:
  data_sobreestimada = "error"
  

%>
<br>
Hola${nom_pagador},<br>
% if  object.pagador.lang != "es_ES":
<br>
Et comuniquem que  ${data_tall} l’empresa distribuïdora va canviar el comptador del contracte ${object.name}, ja que n’és la responsable i estan obligades a fer-ho abans del 2018. <br>
<br>
Lamentablement, no hem rebut aquesta informació fins després d’haver fet una factura amb consum calculat per Som Energia seguint els consums del comptador antic.<br>
<br>
La lectura de tall comunicada per la distribuïdora per al dia del canvi és de ${lectura_tall}.<br>
<br>
Com que ja t’havíem fet una factura amb una lectura calculada per Som Energia ${data_sobreestimada}  per valor de ${ultima_lectura}, la primera factura del comptador nou l’encetem amb una lectura de ${lectura_inici}.<br>
<br>
Així, els kWh que ja vares pagar en el seu moment (o encara no has pagat), es compensen en la primera factura del comptador nou.<br>
<br>
Disculpa les molèsties. <br>
<br>
Per a qualsevol dubte, pots contactar amb nosaltres a factura@somenergia.coop. <br>
<br>
<br>
Atentament, <br>
<br>
Equip de Som Energia<br>
factura@somenergia.coop<br>
<a href="www.somenergia.coop">www.somenergia.coop</a><br>
% endif
% if  object.pagador.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.pagador.lang != "ca_ES":
<br>
Te comunicamos que ${data_tall} la empresa distribuidora cambió el contador del contrato ${object.name}, ya que es la responsable y están obligadas a hacerlo antes del 2018.<br>
<br>
Lamentablemente, no hemos recibido esta información hasta después de haber hecho una factura con consumo calculado por Som Energia siguiendo los consumos del contador antiguo.<br>
<br>
La lectura de corte comunicada por la distribuidora para el día del cambio es de ${lectura_tall}.<br>
<br>
Como ya te habíamos hecho una factura con una lectura calculada por Som Energia ${data_sobreestimada} por valor de ${ultima_lectura}, la primera factura del contador nuevo la empezamos con una lectura de ${lectura_inici}.<br>
<br>
Así, los kWh que ya pagaste en su momento (o aún no has pagado), se compensan en la primera factura del contador nuevo.<br>
<br>
Disculpa las molestias.<br>
<br>
Para cualquier duda, puedes contactar con nosotros en el correo de factura@somenergia.coop.<br>
<br>
<br>
Atentamente,<br>
<br>
<br>
Equipo de Som Energia<br>
factura@somenergia.coop<br>
<a href="http://www.somenergia.coop/es/">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
