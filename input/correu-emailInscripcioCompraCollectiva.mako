<!doctype html>
<html>
<head><meta charset='utf8'></head><body>
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
<div align="right"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
% if object.partner_id.lang != "es_ES":
<p><br>
Hola, <br>
<br>
Enhorabona, ja estàs formalment inscrit a la compra col·lectiva de Som Energia.<br>
<br>
Hem rebut el teu pagament de 150 € del qual t’adjuntem la factura en aquest mateix correu. A la factura posa forma de pagament mitjançant transferència, no en feu cas si us plau, aquest missatge surt a totes les factures per defecte i per ara no ho podem treure. Si rebeu la factura és que ja hem rebut el pagament.<br>
<br>
Et recordem quins seran els següents passos a partir d’ara:<br>
<ol>
    <li>
        <b>Preinforme:</b> D’aquí uns dies o setmanes (depenent de l’estat de les inscripcions) l’empresa instal·ladora adjudicatària de la compra col·lectiva es posarà en contacte amb tu per fer-te arribar un <b>preinforme</b> on es contrasta el model fotovoltaic que has escollit amb el teu ús de l’energia, l’orientació de la seva teulada i possibles ombres que afectin el rendiment de les plaques solars.<br>
    </li>
    <li>
        <b>Visita tècnica:</b> Haureu d’acordar una data per que els tècnics de l’empresa instal·ladora vinguin a conèixer de primera mà l’emplaçament on s’ha de fer el muntage de la instal·lació. Aquest és un moment important per resoldre dubtes i rebre l’assessorament dels experts.<br>
    </li>
    <li>
        <b>Contracte Clau en Mà:</b> Desprès d’acceptar la oferta definitiva, haureu de signar el contracte clau en mà per la ue l’empresa instal·ladora pugui iniciar la tramitació dels permisos d’obra. En aquest moment haureu de fer el pagament del 50% de la instal·lació. És important que no demoreu la signatura!<br>
    </li>
    <li>
        <b>Muntatge i posada en marxa:</b> En tenir la llicència municipal caldrà acordar una data d’obra. Les obres com a molt han de durar un màxim de 5 dies i una vegada finalitzades, quan tot estigui al seu lloc i en funcionament, haureu de signar l’acta de recepció. Serà el moment de fer un pagament del 40% de la instal·lació.<br>
    </li>
    <li>
        <b>Legalització:</b> Finalment l’empresa instal·ladora s’encarregarà de fer la inscripció al registre d’autoconsum autonòmic. Serà el moment de fer el pagament del 10% restant.<br>
    </li>
</ol>

És important prendre consciència que en participar d’una compra col·lectiva, el servei no es rep de forma instantània i cal que les persones participants s’adaptin a les temporalitats i ritmes establerts. Per altra banda, l’empresa instal·ladora es compromet a informar de forma regular i atendre totes les consultes, dubtes i incidències amb diligència, agilitat i qualitat.<br>
<br>
Per qualsevol dubte, consulta o proposta, restem a la vostra disposició.<br>
<br>
Salut i bona energia!<br>
<br>
Equip de Som Energia<br>
<a href="mailto:auto@somenergia.coop">auto@somenergia.coop</a><br>
<a href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
% endif
% if object.partner_id.lang != "ca_ES":
<p><br>
Hola,<br>
<br>
Enhorabuena, ya estás formalmente inscrito a la compra colectiva de Som Energia.<br>
<br>
Hemos recibido tu pago de 150 € del que te adjuntamos la factura en este mismo correo. (En la factura pone forma de pago mediante transferencia, no hagáis caso por favor, este mensaje sale en todas las facturas por defecto.)<br>
<br>
Te recordamos cuáles serán los siguientes pasos a partir de ahora:<br>
<ol>
    <li>
        <b>Preinforme</b>: Dentro de unos días o semanas (dependiendo del estado de las inscripciones) la empresa instaladora adjudicataria de la compra colectiva se pondrá en contacto contigo para hacerte llegar un <b>preinforme</b> donde se contrasta el modelo fotovoltaico que has escogido con tu uso de la energía, la orientación de su tejado y posibles sombras que afecten el rendimiento de las placas solares.<br>
    </li>
    <li>
        <b>Visita técnica</b>: Deberéis acordar una fecha con los técnicos de la empresa instaladora para que vengan a conocer de primera mano el emplazamiento donde se hará el montaje de la instalación. Este es un momento importante para resolver dudas y recibir el asesoramiento de los expertos.<br>
    </li>
    <li>
        <b>Contrato Llave en Mano</b>: Después de aceptar la oferta definitiva, deberéis firmar el contrato llave en mano para la que la empresa instaladora pueda iniciar la tramitación de los permisos de obra. En este momento deberéis  hacer el pago del 50% de la instalación. Para el buen funcionamiento de la campaña és importante que no demoréis esta firma!<br>
    </li>
    <li>
        <b>Montaje y puesta en marcha</b>: Al tener la licencia municipal deberéis acordar una fecha de obra. Las obras como mucho deben durar un máximo de 5 días y una vez finalizadas, cuando todo esté en su sitio y en funcionamiento, deberéis firmar el acta de recepción. Será el momento de hacer un pago del 40% de la instalación.<br>
    </li>
    <li>
        <b>Legalización</b>: Finalmente la empresa instaladora se encargará de hacer la inscripción en el registro de autoconsumo autonómico. Será el momento de hacer el pago del 10% restante.<br>
    </li>
</ol>
Es importante tomar conciencia de que al participar de una compra colectiva, el servicio no se recibe de forma instantánea y es necesario que las personas participantes se adapten a las temporalidades y ritmos establecidos. Por otra parte, la empresa instaladora se compromete a informar de forma regular y atender todas las consultas, dudas e incidencias con diligencia, agilidad y calidad.<br>
<br>
Para cualquier duda, consulta o propuesta, quedamos a su disposición.<br>
<br>
Salud y buena energía!<br>
<br>
Equipo de Som Energia<br>
<a href="mailto:auto@somenergia.coop">auto@somenergia.coop</a><br>
<a href="https://www.somenergia.coop/es">www.somenergia.coop</a><br>
% endif
${text_legal}
</body>
</html>
