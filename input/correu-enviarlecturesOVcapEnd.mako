<!doctype html><html><head><meta charset="utf-8" /></head><%
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
  lect_pool_obj = object.pool.get('giscedata.lectures.lectura.pool')
  compt_obj = object.pool.get('giscedata.lectures.comptador')
  comptadors_ids = compt_obj.search(object._cr, object._uid,[('polissa','=', object.id)])
  lect_ids = lect_pool_obj.search(object._cr, object._uid,[('origen_comer_id','=',4),('comptador','in',comptadors_ids)])
  lect_read = lect_pool_obj.read(object._cr, object._uid,lect_ids,['name','lectura'])
  data = lect_read[0]['name']
  lect = lect_read[0]['lectura']
  lectura = str(lect) + " kWh"
  if object.tarifa.name in ['2.0DHA','2.1DHA']:
    lect2 = lect_read[1]['lectura']
    P1 = "P1: " + str(lect) + " kWh"
    P2 = "P2: " +  str(lect2) + " kWh"
    lectura =  P1 + ' y  ' + P2
  if object.tarifa.name in ['2.0DHS','2.1DHS']:
    lect2 = lect_read[1]['lectura']
    lect3 = lect_read[2]['lectura']
    P1 = "P1: " + str(lect) + " kWh"
    P2 = "P2: " +  str(lect2) + " kWh"
    P3 = "P3 " +  str(lect3) + " kWh"
    lectura =  P1 + ' ,  ' + P2 + ' y ' + P3
except:
  data = "DATA NO ENCONTRATADA"
  lectura = "LECTURA NO FACILITADA POR EL CLIENTE"
%>
Buenos días,<br>
<br>
De nuestro cliente con:<br>
<ul><li>Contrato de suministro:  ${object.ref_dist}</li>
<li>Contador: ${object.comptador}</li>
<li>Número de CUPS: ${object.cups.name} </li></ul>
<br>
Os aportamos la lectura que nos ha sido informada:<br>
<ul><li>Lectura: ${lectura} </li>
<li>Fecha: ${data}</li></ul>
<br>
Agradecemos su colaboración y le saludamos atentamente.<br>
<br>
<br>
Gracias,
<br>
Equipo de Som Energia<br>
atr@somenergia.coop<br>
<br>
${text_legal}
</body>
</html>
</html>