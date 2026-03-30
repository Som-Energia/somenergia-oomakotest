<%
import time
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
%>

${plantilla_header}

% if object.polissa_id.titular.lang == "ca_ES":
    <br>
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
        <tr>
        <td colspan="2">
            <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Contracte</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.name}</p>
                </td>
            </tr>
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Adreça del punt de subministrament</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.cups.direccio}</p>
                </td>
            </tr>
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Codi CUPS</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.cups.name}</p>
                </td>
            </tr>
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Titular</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.titular.name}</p>
                </td>
            </tr>
            </table>
        </td>
        </tr>
    </table>
    <br>
    Hola,<br>
    <br>
    Amb aquest informe energètic personalitzat del <a href="https://ca.support.somenergia.coop/article/905-el-servei-infoenergia-per-a-entitats-i-empreses">servei Infoenergia per entitats i empreses</a> volem ajudar-vos a entendre millor els costos de la factura per tal que pugueu estalviar diners i recursos.<br>
    <br>
    <strong>Ajustar la potència contractada és la primera mesura d'estalvi</strong>. Us convidem a llegir l'informe i optimitzar el vostre contracte, si s'escau.<br>
    <br>
    Aprofitem l'avinentesa per informar-vos d'un parell de canvis normatius aprovats recentment sobre les modificacions de potència:<br>
    <ul>
        <li>
        Per una banda, el Reial decret 88/2026 estableix que <strong>a partir del mes d'agost es podran demanar modificacions temporals de la potència contractada</strong> per diferents intervals de temps (trimestral, mensual, diari i horari).
        </li>
        <li>
        Per altra banda, el Reial decret-llei 7/2026 permet a les <strong>empreses i persones d'alta al RETA demanar més d'un canvi de potències durant aquest any 2026 sense cost,</strong> excepte si augmenta la potència màxima contractada, si cal canviar el comptador i si hi ha supervisió de les instal·lacions.
        </li>
    </ul>
    <br>
    Així doncs, si sou una empresa o esteu donats d'alta al RETA, <u>us recomanem aprofitar la gratuïtat del tràmit per ajustar la potència del vostre contracte.</u><br>
    <br>
    Des de Som Energia us continuarem informant de les novetats normatives que puguin sorgir.<br>
    <br>
    <p>Moltes gràcies per la vostra confiança.<br></p>
    <p>Bona energia!<br><br></p>
    <p>Equip d'Entitats i Empreses de Som Energia</p>
    <a href="http://www.somenergia.coop">www.somenergia.coop</a>
% else:
    <br>
    <table class="purchase" width="100%" cellpadding="0" cellspacing="0" role="presentation">
        <tr>
        <td colspan="2">
            <table class="purchase_content" width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Contrato</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.name}</p>
                </td>
            </tr>
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Dirección del punto de suministro</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.cups.direccio}</p>
                </td>
            </tr>
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Código CUPS</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.cups.name}</p>
                </td>
            </tr>
            <tr>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback purchase_total purchase_total--label">Titular</p>
                </td>
                <td width="50%" class="purchase_footer" valign="middle">
                <p class="f-fallback">${object.polissa_id.titular.name}</p>
                </td>
            </tr>
            </table>
        </td>
        </tr>
    </table>
    <br>
    Hola,<br>
    <br>
    Con este informe personalizado del <a href="https://es.support.somenergia.coop/article/906-el-servicio-infoenergia-para-entidades-y-empresas">servicio Infoenergía para entidades y empresas</a> queremos ayudaros a entender mejor los costes de la factura para que podáis ahorrar dinero y recursos.<br>
    <br>
    <strong>Ajustar la potencia es la primera medida de ahorro</strong>. Os invitamos a leer el informe y optimizar vuestro contrato, si procede.<br>
    <br>
    Aprovechamos para informaros de un par de cambios normativos aprobados recientemente sobre las modificaciones de potencia:<br>
    <ul>
        <li>
        Por un lado, el Real decreto 88/2026 establece que <strong>a partir del mes de agosto se podrán solicitar modificaciones temporales de la potencia contratada</strong> para diferentes intervalos de tiempo (trimestral, mensual, diario y horario). 
        </li>
        <li>
        Por otro lado, el Real decreto-ley 7/2026 permite a las <strong>empresas y personas de alta al RETA pedir más de un cambio de potencias durante este año 2026 sin coste,</strong> excepto si se aumenta la potencia máxima contratada, si se requiere cambiar el contador y si hay supervisión de las instalaciones.
        </li>
    </ul>
    <br>
    En este sentido, si sois una empresa o estáis de alta al RETA, <u>os recomendamos aprovechar la gratuidad del trámite para ajustar la potencia de vuestro contrato.</u><br>
    <br>
    Desde Som Energia os continuaremos informando de les novedades normativas que puedan surgir.<br>
    <br>
    <p>Muchas gracias por vuestra confianza.<br></p>
    <p>¡Buena energía!<br><br></p>
    <p>Equipo de Entidades y Empresas de Som Energia</p>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
% endif

${plantilla_footer}
