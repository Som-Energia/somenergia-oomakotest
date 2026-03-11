<%
from datetime import datetime, timedelta
from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
year = (datetime.now() - timedelta(days=365)).year
%>
${plantilla_header}
% if object.partner_id.lang != "es_ES":
<br />
Benvolgut/da,<br />
<br />
Com cada any per aquestes dates, ha començat la campanya de la Renda ${year}.<br />
T’enviem, per si és del teu interès, el comunicat dels rendiments en espècie obtinguts i les retencions aplicades en relació al projecte GenerationkWh de SOM ENERGIA durant l’any ${year}.<br />
Aprofitem per agrair-te una vegada més la teva implicació en el nostre projecte.<br />
Atentament,<br />
<br />
Equip Som Energia<br />
generationkwh@somenergia.coop<br />
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br />
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
<br />
Apreciado/a,<br />
<br />
Como cada año por estas fechas, ha empezado la campaña de Renta ${year}.<br />
Te enviamos, por si es de tu interés, comunicado de los rendimientos en especie obtenidos y retenciones aplicadas en relación al proyecto GenerationKWh de SOM ENERGIA durante el año ${year}.<br />
Aprovechamos una vez más para agradecer tu implicación en nuestro proyecto.<br />
Atentamente,<br />
<br />
Equipo de Som Energia<br />
generationkwh@somenergia.coop<br />
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br />
% endif
<br />
${plantilla_footer}