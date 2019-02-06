<!doctype html><html><%
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
Buenos días,

De nuestro cliente con:
<ul><li>Contrato de suministro:  ${object.ref_dist}</li>
<li>Contador: ${object.comptador}</li>
<li>Número de CUPS: ${object.cups.name} </li></ul>

Os aportamos la lectura que nos ha sido informada:
<ul><li>Lectura: ${lectura} </li>
<li>Fecha: ${data}</li></ul>

Agradecemos su colaboración y le saludamos atentamente.


Gracias,

Equipo de Som Energia
atr@somenergia.coop

</body>
</html>
</html>