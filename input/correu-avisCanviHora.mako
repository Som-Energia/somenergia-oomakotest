<!doctype html>
<html>
<head><meta charset="utf-8"/></head>
<body>
% if object.pagador.lang == "ca_ES":
<table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia núm. ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table>
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
<br/>
Hola,<br/>
<br/>
 % if object.pagador.lang != "es_ES":
T'informem que <strong>durant la matinada del dissabte 27 al diumenge 28 d’octubre hi haurà el canvi d'hora oficial.</strong> Aquest fet té efecte sobre els períodes de la tarifa amb discriminació horària que tens contractada.<br/>
<br/>
A partir d'aquest dia i fins el canvi d'hora següent (darrer cap de setmana de març) la tarificació horària serà la d'hivern:<br/>
% if object.tarifa.name == '2.0DHA' or object.tarifa.name == '2.1DHA':
<br/>
- Punta (P1): de 12 a 22h<br/>
- Vall (P2): de 22 a 12h<br/>
% elif object.tarifa.name =='3.0A':
<br/>
A la Península Ibèrica i a les Illes Canàries:<br/>
- Punta (P1): de 18 a 22h<br/>
- Pla (P2): de 8 a 18h i de 22 a 24h<br/>
- Vall (P3): de 0 a 8h <br/>
<br/>
A les Illes Balears els horaris són els mateixos tot l’any: <br/>
- Punta (P1): de 18 a 22h<br/>
- Pla (P2): de 8 a 18 h i de 22 a 24h<br/>
- Vall (P3): de 0 a 8h<br/>
<br/>
Per a més informació consulta aquesta <a href="https://ca.support.somenergia.coop/article/255-quins-horaris-tenen-els-periodes-de-la-tarifa-3-0a">web.</a><br/>
<br/>
% elif (object.tarifa.name == '3.1A') or (object.tarifa.name == '3.1A LB'):
A la Península Ibèrica i a les Illes Canàries:<br/>
Dies laborables:<br/>
- Punta (P1): de 17 a 23h<br/>
- Pla (P2): de 8 a 17h i de 23 a 24h<br/>
- Vall (P3): de 0 a 8h <br/>
Caps de setmana i festius:<br/>
- Pla (P2): de 18 a 24h<br/>
- Vall (P3): de 0 a 18h <br/>
<br/>
A les Illes Balears els horaris són els mateixos tot l’any:<br/>
Dies laborables:<br/>
- Punta (P1): de 17 a 23h<br/>
- Pla (P2): de 8 a 17 h i de 23 a 24h<br/>
- Vall (P3): de 0 a 8h<br/>
Caps de setmana i festius:<br/>
- Pla (P2): de 18 a 24h<br/>
- Vall (P3): de 0 a 18h <br/>
<br/>
% endif
<br/>
Seguim amb Bona Energia!<br/>
<br/>
Atentament,<br/>
<br/>
Equip de Som Energia<br/>
<br/>
<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> - <a href="https://ca.support.somenergia.coop">Centre d’Ajuda</a><br/>
<br/>
% endif
% if object.pagador.lang != "ca_ES" and object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.pagador.lang != "ca_ES":
Te informamos que <strong>durante la madrugada del sábado 27 al domingo 28 de octubre se producirá el cambio de hora oficial.</strong> Este hecho tiene relación directa con los períodos de la tarifa con discriminación horaria que tienes contratada.<br/>
<br/>
A partir de este día y hasta el siguiente cambio de hora (último fin de semana de marzo) la tarificación horaria será la de invierno:<br/>
% if object.tarifa.name == '2.0DHA' or object.tarifa.name == '2.1DHA':
<br/>
- Punta (P1): de 12 a 22h<br/>
- Valle (P2): de 22 a 12h<br/>
% elif object.tarifa.name =='3.0A':
<br/>
En la Península Ibérica y en las Islas Canarias:<br/>
- Punta (P1): de 18 a 22h<br/>
- Llano (P2): de 8 a 18h y de 22 a 24h<br/>
- Valle (P3): de 0 a 8h <br/>
<br/>
En las Islas Baleares los horarios son los mismos todo el año: <br/>
- Punta (P1): de 18 a 22h<br/>
- Llano (P2): de 8 a 18 h y de 22 a 24h<br/>
- Valle (P3): de 0 a 8h<br/>
<br/>
Para más información consulta esta <a href="https://es.support.somenergia.coop/article/176-que-horarios-tienen-los-periodos-de-la-tarifa-3-0a">web.</a><br/>
<br/>
% elif (object.tarifa.name == '3.1A') or (object.tarifa.name == '3.1A LB'):
<br/>
En la Península Ibérica y en las Islas Canarias:<br/>
Días laborables:<br/>
- Punta (P1): de 17 a 23h<br/>
- Llano (P2): de 8 a 17h y de 23 a 24h<br/>
- Valle (P3): de 0 a 8h <br/>
Fines de semana y festivos:<br/>
- Llano (P2): de 18 a 24h<br/>
- Valle (P3): de 0 a 18h <br/>
<br/>
<br/>
En las Islas Baleares los horarios son los mismos todo el año:<br/>
Días laborables:<br/>
- Punta (P1): de 17 a 23h<br/>
- Llano (P2): de 8 a 17 h y de 23 a 24h<br/>
- Valle (P3): de 0 a 8h<br/>
Fines de semana y festivos:<br/>
- Llano (P2): de 18 a 24h<br/>
- Valle (P3): de 0 a 18h <br/>
<br/>
% endif
<br/>
¡Seguimos con Buena Energía!<br/>
<br/>
Equipo de Som Energia<br/>
<br/>
<a href="https://es.support.somenergia.coop">Ayuda</a> - <a href="https://eu.support.somenergia.coop">Laguntza</a> - <a href="https://gl.support.somenergia.coop">Axuda</a>
<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> - <a href="https://oficinavirtual.somenergia.coop/eu/login/">Bulego birtuala</a> - <a href="https://oficinavirtual.somenergia.coop/gl/login/">Oficina Virtual</a><br/>
<br/>
% endif
<br/>
${text_legal}
</body>
</html>