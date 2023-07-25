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
p_obj = object.pool.get('res.partner')
nom_titular =' ' + p_obj.separa_cognoms(object._cr, object._uid,object.titular.name)['nom']
tarifaComer = object.cups_polissa_id.modcontractuals_ids[0].llista_preu.nom_comercial or object.cups_polissa_id.modcontractuals_ids[0].llista_preu.name
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
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${object.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Adreça punt subministrament: ${object.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Codi CUPS: ${object.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <br>
        Hola${nom_titular},<br>
        <br>
        <p>Hem rebut una sol·licitud de modificació del contracte ${object.name} amb Som Energia:</p>
        <b>Dades del contracte:</b>
        <ul>
        <li> CUPS: ${object.cups.name} </li>
        <li> Adreça: ${object.cups.direccio} </li>
        </ul>

        <b>Dades de la sol·licitud:</b>
        <ul>
        <li> Modificació de tarifa comercialitzadora: <b>${tarifaComer}</b> </li>
        </ul>
        <p>T'enviarem un nou correu electrònic quan se't comenci a aplicar la nova tarifa.</p>
        <br>

        <p><b>Informació rellevant en el procés de contractació:</b></p>
        <p><b>Dret de desistiment.</b>
          Totes les persones consumidores de la cooperativa disposen de 14 dies naturals des de la data de contracte per desistir dels serveis.
          Si vols desistir, cal que ens ho notifiquis per correu electrònic a comercialitzacio@somenergia.coop, per correu postal a SOM ENERGIA SCCL c/Pic de Peguera 11, 17003 Girona o 
          per qualsevol de les vies de contacte que consten <a href="https://ca.support.somenergia.coop/article/470-com-puc-contactar-amb-la-cooperativa-mail-telefon-etc"> al nostre portal d'internet</a>
          Per fer-ho, pots utilitzar el text que trobaràs <a href="https://docs.google.com/document/d/10CzheqAYQs5lwvKpJBkaiBEdsHZjY6TZoeBDN-mOfT0/edit"> <b>en aquesta plantilla</b>.</a>
        </p>
        <p><b>Conseqüències del desistiment.</b>
          Et tornarem tots els pagaments rebuts, si n'hi ha, dintre dels 14 dies naturals a partir de la data en què ens comuniquis la teva decisió.
          Efectuarem aquest reemborsament sense que suposi cap més despesa per a tu, i farem servir el mateix mitjà de pagament que hagis emprat per a la transacció inicial,
          si no és que ens indiques el contrari. En cas que ja es trobi actiu el subministrament d'electricitat, ens hauràs d'abonar el consum corresponent als dies en què t'hàgim prestat servei,
          així com la resta de costos associats a la contractació i, si s'escau, la reposició a la situació anterior.
        </p>
        <br>
        <br>
        Salutacions,<br>
        <br>
        <p>
            Equip de Som Energia <br>
            <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
            <a href="www.somenergia.coop/ca">www.somenergia.coop</a>
        </p>
    </body>
</%def>

<%def name="correu_es()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${object.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Dirección punto suministro: ${object.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Código CUPS: ${object.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <br>
        Hola${nom_titular},<br>
        <br>
      <p>Hemos recibido una solicitud de modificación del contrato ${object.name} con Som Energia:</p><br>

      <b>Datos del contrato:</b>
      <ul>
      <li>CUPS: ${object.cups.name} </li>
      <li>Dirección: ${object.cups.direccio} </li>
      </ul>

      <b>Dades de la sol·licitud:</b>
      <ul>
      <li> Modificación de tarifa comercializadora: <b>${tarifaComer}</b> </li>
      </ul>

      <p>Te enviaremos un nuevo correo electrónico cuando se te empiece a aplicar la nueva tarifa. </p><br>
      <p><b>Información referente al proceso de contratación:</b></p>
      <p><b>Derecho de desistimiento.</b> Todas las personas consumidoras de la cooperativa disponen de 14 días naturales desde la fecha del contrato para desistir de los servicios. Si quieres desistir, es necesario que nos lo notifiques por correo electrónico a comercializacion@somenergia.coop, por correo postal a SOM ENERGIA SCCL c/Pic de Peguera 11, 17003 Girona o por cualquiera de las vías de contacto que constan en nuestra <a href="https://es.support.somenergia.coop/article/471-como-puedo-contactar-con-la-cooperativa-mail-telefono-et">página en internet</a>. Para hacerlo, puedes utilizar el texto que figura en <a href="https://docs.google.com/document/d/1KOnlw370Fkv8VX8mw2qfC7zvPKnAmptcGsvXU-4tMCc/edit">esta plantilla</a>.</p>
      <p><b>Consecuencias del desistimiento.</b> Te devolveremos todos los pagos recibidos, si los hay, dentro de 14 días naturales a partir de la fecha en la que nos comuniques tu decisión. Efectuaremos dicho reembolso, sin que esto suponga ningún gasto para ti, utilizando el mismo medio de pago que hayas empleado para la transacción inicial, a no ser que nos indiques lo contrario. En caso de que ya se encuentre activo el suministro de electricidad, deberás abonarnos el consumo correspondiente a los días en que te hayamos prestado servicio, así como el resto de costes asociados a la contratación y, en su caso, reposición de la situación anterior.</p><br>
      <br>
      Un saludo,<br>
      <br>
        <p>
            Equipo de Som Energia <br>
            <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
            <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
        </p>
    </body>
</%def>
