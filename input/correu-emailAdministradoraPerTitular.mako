<!doctype html>
<html>
% if object.titular.lang == "ca_ES":
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia núm. ${object.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuïdora: ${object.distribuidora.name}</font></td></tr></table></head>
% else:
<head><meta charset='utf8'><table width="100%" frame="below" BGCOLOR="#F2F2F2"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.cups_direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Distribuidora: ${object.distribuidora.name}</font></td></tr></table></head>
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

titular = "vsjlnvsolvfs"
administradora = "jsvjlbvsjñbjv"
contractes = ['01234','12234','23242']
contractes = ', '.join(contractes)
%>
<br>
Hola${titular}<br>
% if object.titular.lang != "es_ES":
<br>
Reps aquest correu perquè has sol·licitat, a través de l'oficina virtual, que ${administradora} pugui veure i gestionar la informació dels contractes nº ${contractes} que tens amb Som Energia.<br>
<br>
Per a qualsevol dubte seguim en contacte.<br>
<br>
Equip de Som Energia<br>
<br>
% endif
% if  object.titular.lang != "ca_ES" and  object.pagador.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.titular.lang != "ca_ES":
<br>
Recibes este correo porque has solicitado, a través de la oficina virtual, que ${administradora} pueda ver y gestionar la información de los contratos nº ${contractes} que tienes con Som Energia. <br>
<br>
Para cualquier duda seguimos en contacto. <br>
<br>
Equipo de Som Energia<br>
<br>
% endif
${text_legal}
</body>
</html>
