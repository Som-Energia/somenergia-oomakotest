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
      if model.startswith('giscedata.switching.t1.06'):
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
            T'escrivim per informar-te que en data <b>${date}</b> s'ha realitzat el canvi de comercialitzadora que gestiona el teu contracte, i, per tant, s’ha donat de baixa de Som Energia.
        </p>
        <p>
            Recorda que els canvis de comercialitzadora no representen cap afectació sobre el subministrament elèctric, ni talls, ni canvis en la potència contractada.
        </p>
        <p>
            El teu contracte d'electricitat ha passat a ser gestionat per l'empresa comercialitzadora de referència, que pots consultar en <a href="http://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">aquest enllaç</a>.
        </p>

        <p>
            Gràcies per confiar amb Som Energia tot aquest temps.
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
            Te escribimos para informarte que en fecha <b>${date}</b> se ha realizado el cambio de comercializadora que gestiona tu contrato, y, por lo tanto, se ha dado de baja con Som Energia.
        </p>
        <p>
            Recuerda que los cambios de comercializadora no representan ninguna afectación sobre el suministro eléctrico, ni cortes, ni cambios en la potencia contratada.
        </p>
        <p>
            Este contrato ha pasado a estar gestionado por la empresa comercializadora de referencia, que puedes consultar en <a href="http://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">este enlace</a>.
        </p>
        <p>
            Gracias por confiar en Som Energia todo este tiempo.
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
