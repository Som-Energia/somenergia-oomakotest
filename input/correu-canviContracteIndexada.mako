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

from datetime import datetime
data_inici = datetime.strptime(object.modcontractual_activa.data_inici, '%Y-%m-%d').strftime('%d-%m-%Y')
%>

<!doctype html>
<html>
% if object.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
<br>
${text_legal}
</html>

<%def name="correu_cat()">
<p>Hola, </p>

<p>Segons l'acord de renovació firmat, hem procedit a fer les modificacions oportunes per tal de passar a facturar el contracte núm. ${object.name} i CUPS ${object.cups.name} amb tarifa indexada.</p>

<p>La data d'activació del canvi és el ${data_inici}.</p>

<p>Recorda que tens més informació del funcionament de la tarifa indexada en aquest <a href="https://www.somenergia.coop/tarifa_indexada/CA_EiE_Explicacio_Tarifa_Indexada_Entitats_i_Empreses_Som_Energia.pdf">document</a>.</p>

<p>Per qualsevol dubte, estem en contacte.</p>

<p>Salutacions,</p>
<br>
Equip de Som Energia<br>
<a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
<a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
<a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>

</%def>

<%def name="correu_es()">
<p>Hola, </p>

<p>Según el acuerdo de renovación firmado, hemos procedido a realizar las modificaciones oportunas a fin de cambiar la facturación del contrato ${object.name} y CUPS ${object.cups.name} a tarifa indexada.</p>

<p>La fecha de activación del cambio es el ${data_inici}.</p>

<p>Recuerda que tienes más información del funcionamiento de la tarifa indexada en este <a href="https://www.somenergia.coop/tarifa_indexada/ES_EiE_Explicacion_Tarifa_Indexada_Entidades_y_Empresas_Som_Energia.pdf">documento</a>.</p>

<p>Para cualquier duda, estamos en contacto.</p>

<p>Un saludo,</p>
<br>
Equipo de Som Energia<br>
<a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
<a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
<a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>
</%def>
