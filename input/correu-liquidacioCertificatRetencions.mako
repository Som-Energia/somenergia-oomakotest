<!doctype html>
<html><body>
<img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">
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
<br />
Benvolgut/da,<br />
<br />
Com cada any per aquestes dates, ha començat la campanya de la Renda ${object.date_invoice.split('-')[0]}.<br />
<br />
T’enviem, per si és del teu interès, el comunicat dels rendiments obtinguts i les retencions aplicades en relació a les teves inversions en títols participatius de SOM ENERGIA durant l’any ${object.date_invoice.split('-')[0]}.<br />
<br />
Aprofitem per agrair-te una vegada més la teva implicació en el nostre projecte.<br />
<br />
Atentament,<br />
<br />
Equip Som Energia<br />
invertir@somenergia.coop<br />
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br />
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
<br />
Apreciado/a,<br />
<br />
Como cada año por estas fechas, ha empezado la campaña de Renta ${object.date_invoice.split('-')[0]}.<br />
<br />
Te enviamos, por si es de tu interés, comunicado de los rendimientos obtenidos y retenciones aplicadas en relación a tus inversiones en aportaciones voluntarias de SOM ENERGIA durante el año ${object.date_invoice.split('-')[0]}.<br />
<br />
Aprovechamos una vez más para agradecer tu implicación en nuestro proyecto.<br />
<br />
Atentamente,<br />
<br />
Equipo de Som Energia<br />
invertir@somenergia.coop<br />
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br />
% endif
<br />
${text_legal}
</body>
</html>
