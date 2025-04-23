<!doctype html>
<body>
<img src="https://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"/>
<%
from mako.template import Template
import datetime

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
previous_year = str(datetime.date.today().year - 1)
%>
% if object.partner_id.lang != "es_ES":
<br>
<p>Benvolgut/da,</p>
<br>
<p>Com cada any per aquestes dates, ha començat la campanya de la Renda ${previous_year}.</p>
<p>T'enviem, per si és del teu interès, el comunicat dels rendiments obtinguts i les retencions aplicades de les teves aportacions voluntàries al capital social de SOM ENERGIA durant l'any ${previous_year}.</p>
<p>Aprofitem per agrair-te una vegada més la teva implicació en el nostre projecte.</p>
<br>
<p>Atentament,</p>
<br>
<p>Equip Som Energia</p>
<p>aporta@somenergia.coop</p>
<p><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a></p>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if object.partner_id.lang != "ca_ES":
<br>
<p>Apreciado/a,</p>
<br>
<p>Como cada año por estas fechas, ha empezado la campaña de Renta ${previous_year}.</p>
<p>Te enviamos, por si es de tu interés, comunicado de los rendimientos y retenciones aplicadas a tus aportaciones voluntarias al capital social de SOM ENERGIA durante el año ${previous_year}.</p>
<p>Aprovechamos una vez más para agradecer tu implicación en nuestro proyecto.</p>
<br>
<p>Atentamente,</p>
<br>
<p>Equipo de Som Energia</p>
<p>aporta@somenergia.coop</p>
<p><a href="https://www.somenergia.coop">www.somenergia.coop</a></p>
% endif
<br>
${text_legal}
</body>
</html>
