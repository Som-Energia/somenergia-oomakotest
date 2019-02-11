<!doctype html>
<html>
% if object.pagador.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia núm. ${object.name} :</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name} : </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
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
  date = datetime.strptime(object.data_alta, '%Y-%m-%d')
  data_alta = date.strftime('%d/%m/%Y')
except:
  data_alta = u"Error: no tenim d'alta alta registrada"
%>
<br>
Hola${nom_pagador},<br>
<br>
% if  object.pagador.lang != "es_ES":
Ens posem en contacte amb tu en relació a la facturació del teu contracte de llum.<br>
<b>En els últims 5 mesos no ens consta cap lectura real del teu comptador</b>  i hem hagut d’estimar lectures per generar les factures. <br>
<br>
Per evitar possibles facturacions errònies, et recomanem informar de la lectura del teu comptador. En el següent enllaç trobaràs la forma d’enviar la lectura fàcilment a la cooperativa a través de l’Oficina Virtual.<br>
<br>
<div align="center"><b><h2><a href="http://ca.support.somenergia.coop/article/265-puc-facilitar-jo-la-lectura">Com puc facilitar la lectura? </a></h2></b></div><br>
En aquest cas, també et recomanem enviar la lectura a la distribuïdora.<br>
<br>
<br>
Moltes gràcies,<br>
<br>
Atentament,<br>
<br>
Equip de Som Energia<br>
<a href="http://ca.support.somenergia.coop/">Centre de Suport</a><br>
<a href="http://www.somenergia.coop/ca">Web</a> - <a href="https://blog.somenergia.coop/">Blog</a><br>
% endif
% if  object.pagador.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.pagador.lang != "ca_ES":
Nos ponemos en contacto contigo en relación a la facturación de tu contrato de luz.<br>
<b>En los últimos 5 meses no nos consta ninguna lectura real de tu contador</b> y hemos tenido que estimar lecturas para generar facturas.<br>
<br>
Para evitar posibles facturaciones erróneas, te recomendamos informar de la lectura de tu contador. En el siguiente enlace, encontrarás la forma de enviar la lectura fácilmente a la cooperativa a través de la Oficina Virtual. <br>
<br>
<div align="center"><b><h2><a href="http://es.support.somenergia.coop/article/535-como-puedo-facilitar-la-lectura">¿Cómo facilitar la lectura?</a></b></h2></div><br>
En este caso, también recomendamos enviar la lectura a la distribuidora.<br>
<br>
<br>
Muchas gracias,<br>
<br>
Atentamente,<br>
<br>
Equipo de Som Energia<br>
<a href="http://es.support.somenergia.coop/">Centro de Ayuda</a><br>
<a href="http://www.somenergia.coop/">Web</a> - <a href="https://blog.somenergia.coop/">Blog</a><br>
% endif
${text_legal}
</body>
</html>
</html>