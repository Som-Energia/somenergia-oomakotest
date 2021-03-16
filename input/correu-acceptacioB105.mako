<%!
    from datetime import datetime
    from mako.template import Template
%>

<%
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
    for step in object.step_ids:
      obj = step.pas_id
      model = obj._table_name
      if model.startswith('giscedata.switching.b1.05'):
        pas5 = obj
        break

    date = datetime.strptime(pas5.data_activacio, '%Y-%m-%d')
    date = date.strftime('%d/%m/%Y')
%>

<!doctype html>
<html>
% if object.cups_polissa_id.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${text_legal}
</html>


<%def name="correu_cat()">
    <head>
        <meta charset="utf-8"/>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Adreça punt subministrament: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Codi CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <p>
            Hola,
        </p>

        <p>
            Des de l'empresa distribuïdora ens ha arribat la confirmació que la baixa amb tall de subministrament del contracte de l’adreça <b>${object.cups_polissa_id.cups_direccio}</b> es va fer efectiva el dia <b>${date}</b>.
        </p>

        <p>
            Durant els propers dies generarem l'última factura d'aquest contracte, si no l’has rebuda ja, que serà fins a la data que ha deixat d'estar actiu.
        </p>

        <p>
            T’informem que com a titular del contracte tens dret a que et facin el retorn del dipòsit de garantia si es va facilitar en el moment de tramitar l’alta del subministrament. Per tal de saber si et correspon i que et facin aquest retorn has de contactar directament amb <a href="http://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">la distribuïdora de la teva zona</a> ja que cadascuna d’elles té diferents protocols i t’indicaran els passos a seguir. D’acord amb el protocol que t’indiqui la Distribuidora, Som Energia està a la teva disposició per realitzar qualsevol gestió.
        </p>

        <p>
            Seguim en contacte.
        </p>

        <p>
            Salutacions,
        </p>
        <p>
            Equip de Som Energia <br>
            <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
            <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a>
        </p>
    </body>
</%def>


<%def name="correu_es()">
    <head>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Dirección punto suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Código CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
    <body>
        <p>
            Hola,
        </p>
        <p>
            Desde la empresa distribuidora nos ha llegado la confirmación de que la baja con corte de suministro del contrato de la dirección <b>${object.cups_polissa_id.cups_direccio}</b> se hizo efectiva el día <b>${date}</b>.
        </p>
        <p>
            Durante los próximos días generaremos la última factura de este contrato,  si no la has recibido ya, que será hasta la fecha que ha dejado de estar activo.
        </p>
        <p>
            Te informamos que como titular del contrato tienes derecho a que te hagan el retorno del depósito de garantía si se facilitó en el momento de tramitar el alta del suministro. Para saber si te corresponde y que te hagan esta devolución debes contactar directamente con <a href="http://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">la distribuidora de tu zona</a> ya que cada una de ellas tiene diferentes protocolos y te indicarán los pasos a seguir. De acuerdo con el protocolo que te indique la Distribuidora, Somos Energía está a tu disposición para realizar cualquier gestión.
        </p>
        <p>
            Seguimos en contacto.
        </p>
        <p>
            Saludos,
        </p>

        <p>
            Equipo de Som Energia <br>
            <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
            <a href="https://www.somenergia.coop/es">www.somenergia.coop</a>
        </p>
    </body>
</%def>
