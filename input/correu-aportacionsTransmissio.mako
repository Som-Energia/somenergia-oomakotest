
<!doctype html>
<html>
<body>
<img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
<br/><br/>
<%
Soci = object.pool.get('somenergia.soci')
Partner = object.pool.get('res.partner')
soci_id = object.member_id.id
soci_obj = Soci.read(object._cr, object._uid, soci_id)
part_obj = Partner.read(object._cr,object._uid,soci_obj['partner_id'][0])
lang = part_obj['lang']
data_transmissio = object.first_effective_date

nom_pagador = ''
es_empresa = Partner.vat_es_empresa(object._cr, object._uid, object.member_id.vat)
if not es_empresa:
    nom_pagador =' ' + Partner.separa_cognoms(object._cr, object._uid, object.member_id.name)['nom']
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
% if lang != "es_ES":
Benvolgut/da${nom_pagador},<br/>
<br/>
T'informem que en la darrera reunió del Consell Rector en data ${data_transmissio} es va autoritzar la transmissió de les aportacions voluntàries segons la teva sol·licitud adjunta en aquest correu electrònic. Dita autorització va quedar degudament recollida en acta i la transmissió d'aportacions s'entén realitzada des de la mencionada data.<br/>
<br/>
<br/>
Si tens qualsevol pregunta al respecte no dubtis a contactar amb nosaltres.
<br/>
<br/>
Atentament,<br/>
<br/>
<br/>
Equip de Som Energia,<br/>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br/>
% endif
% if lang != "ca_ES" and lang != "es_ES":
<br/><HR align="LEFT" size="1" width="400" color="Black" noshade><br/>
% endif
% if lang != "ca_ES":
Apreciado/a${nom_pagador},<br/>
<br/>
Te informamos que en la última reinión del Consejo Rector en fecha ${data_transmissio} se autorizó la transmisión de las aportaciones voluntarias según tu solicitud adjuntada en este correo electrónico. Dicha autorización quedó debidamente recojida en acta y la transmisión de aportaciones se entiende realizada desde la mencionada fecha.<br/>
<br/>
<br/>
Si tienes cualquier pregunta al respecto no dudes en contactar con nosotros.
<br/>
<br/>
Atentamente,<br/>
<br/>
<br/>
Equipo de Som Energia,<br/>
<a href="https://www.somenergia.coop">www.somenergia.coop</a><br/>
% endif
<br/>
${text_legal}
</body>
</html>
