
            <!doctype html>
<html>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"><br>
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
% if object.partner_id.lang != "es_ES":
<br>
Hola ${object.partner_id.name.split(',')[-1]},<br>
<br>
Avui ens ha vingut retornat el rebut de ${int(object.amount_total)} euros corresponent a la teva aportació voluntària al capital social de Som Energia SCCL. Si segueixes interessat/da en fer-la, t'agrairem que ens facis una transferència com més aviat millor al següent número de compte: ES19 3025 0016 12 1400005159. En el concepte de la transferència cal informar del número de la teva aportació: ${object.origin}<br>
<br>
Si pel contrari has canviat d'idea i ja no la vols fer, t'agrairem que ens ho comuniquis contestant aquest mateix correu.<br>
<br>
Salutacions,<br>
<br>
<br>
Equip de Som Energia,<br>
<a href="http://www.somenergia.coop/ca/">www.somenergia.coop</a><br>
% endif
% if  object.partner_id.lang != "ca_ES" and  object.partner_id.lang != "es_ES":
<br><HR align="LEFT" size="1" width="400" color="Black" noshade><br>
% endif
% if  object.partner_id.lang != "ca_ES":
<br>
Hola ${object.partner_id.name.split(',')[-1]},<br>
<br>
Hoy nos ha venido devuelto el recibo de ${int(object.amount_total)} euros correspondiente a tu aportación voluntaria al capital social de Som Energia SCCL. Si sigues interesado/a en participar, te agradeceremos que hagas una transferencia lo antes posible al siguiente número de cuenta: ES19 3025 0016 12 1400005159. En el concepto de la transferencia es necesario informar del número de tu aportación: ${object.origin}<br>
<br>
Si por el contrario ya no te interesa aportar al capital social de Som Energia te agradeceremos que nos lo comuniques contestando este correo.<br>
<br>
Un saludo,<br>
<br>
<br>
Equipo de Som Energia,<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif
<br>
${text_legal}
</body>
</html>