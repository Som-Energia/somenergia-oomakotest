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

<!doctype html>
<html>
% if object.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${text_legal}
</html>

<%def name="correu_cat()">
<p>Hola, </p>

<p>Segons l'acord de renovació firmat, hem procedit a fer les modificacions oportunes per tal de passar a facturar el contracte núm. ${object.name} i CUPS ${object.cups.name} amb tarifa indexada.</p>

<p>La data d'activació del canvi és el ${object.modcontractual_activa.data_inici}.</p>

<p>Recorda que tens més informació del funcionament de la tarifa indexada en aquest document.</p>

<p>Per qualsevol dubte, estem en contacte.</p>

<p>Salutacions,</p>

</%def>

<%def name="correu_es()">
<p>Hola, </p>

<p>Según el acuerdo de renovación firmado, hemos procedido a realizar las modificaciones oportunas a fin de cambiar la facturación del contrato ${object.name} y CUPS ${object.cups.name} a tarifa indexada.</p>

<p>La fecha de activación del cambio es el ${object.modcontractual_activa.data_inici}.</p>

<p>Recuerda que tienes más información del funcionamiento de la tarifa indexada en este documento.</p>

<p>Para cualquier duda, estamos en contacto.</p>

<p>Un saludo,</p>

</%def>