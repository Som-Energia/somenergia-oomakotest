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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>
${plantilla_header}

<table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0" role="presentation">
  <tr>
    <td align="center">
      <table class="email-content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
        <tr>
          <td class="email-masthead">
            <table align="center" width="570" cellpadding="0" cellspacing="0" role="presentation" class="header">
              <tr>
                <th>
                  <img src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png" alt="SOM Energia" style="height: 100px"/>
                </th>
              </tr>
            </table>
          </td>
        </tr>
        <!-- Email Body -->
        <tr>
          <td class="email-body" width="570" cellpadding="0" cellspacing="0">
            <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0" role="presentation">
              <!-- Body content -->
              <tr>
                <td class="content-cell">
                  <div class="f-fallback">
% if object.polissa_id.titular.lang != "es_ES":
<span class="preheader">Volem ajudar-vos a entendre millor els costos de la teva factura per tal que pugueu estalviar</span>
<br>
Hola,<br>
<br>
Amb aquest informe energètic personalitzat del <a href="https://ca.support.somenergia.coop/article/905-el-servei-infoenergia-per-a-entitats-i-empreses">servei Infoenergia per entitats i empreses</a> volem ajudar-vos a entendre millor els costos de la teva factura per tal que pugueu estalviar.<br>
<br>
Us convidem a llegir l’informe i optimitzar el vostre contracte, si s'escau.<br>
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
            <p class="f-fallback purchase_total purchase_total--label">Adreça punt subministrament</p>
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
A més a més, us recordem que <strong>fins al juny el tràmit de la modificació de potències és gratuït pels contractes d’empreses i treballadors/es autònoms/es</strong><br> (podeu consultar més informació <a href="https://ca.support.somenergia.coop/article/1270-modificacions-temporals-de-potencia-rd18-2022">aquí</a>).<br>
<br>
Moltes gràcies per la vostra confiança.<br>
<br>
Bona energia!
<br>
Equip de Som Energia<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif

% if object.polissa_id.titular.lang != "ca_ES" and object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif

% if object.polissa_id.titular.lang != "ca_ES":
<span class="preheader">Queremos ayudaros a entender mejor los costes de la factura para que podáis ahorrar</span>
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
Con este informe personalizado del <a href="https://es.support.somenergia.coop/article/906-el-servicio-infoenergia-para-entidades-y-empresas">servicio Infoenergía para entidades y empresas</a> queremos ayudaros a entender mejor los costes de la factura para que podáis ahorrar.<br>
<br>
Os invitamos a leer el informe y optimizar vuestro contrato, si es posible.<br>
<br>
Además, os recordamos que <strong>hasta junio el trámite de la modificación de potencias es gratuito para los contratos de empresas y trabajadores/as autónomos/as</strong> (podéis consultar más información <a href="https://es.support.somenergia.coop/article/1271-modificaciones-temporales-de-potencia-rd18-2022">aquí</a>).<br>
<br>
Muchas gracias por vuestra confianza.<br>
<br>
¡Buena energía!
<br>
Equipo de Som Energia<br>
<a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
% endif
                  </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
${plantilla_footer}
