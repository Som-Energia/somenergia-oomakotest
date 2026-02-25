<%!
    from mako.template import Template
    from datetime import datetime

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
        )
%>

<%
    data_activacio = datetime.strptime(
        object.step_ids[-1].pas_id.data_activacio, '%Y-%m-%d'
    ).strftime('%d/%m/%Y')

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

%>

${plantilla_header}
% if object.cups_polissa_id.titular.lang == "ca_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${plantilla_footer}


<%def name="correu_cat()">
    <table width="100%" frame="below">
    <tbody>
    <tr>
    <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${object.cups_id.direccio}</span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.cups_id.name}</span></td>
    </tr>
    </tbody>
    </table>
        <br>
        <p>
        Hola,<br>
        </p>
        <p>
        El <b>canvi de titular del contracte ${object.cups_polissa_id.name}</b> i adreça de subministrament ${object.cups_polissa_id.cups_direccio} ha estat realitzat amb èxit.
        </p>
        <p>
        Així doncs, has deixat de ser titular d’aquest contracte a data <b>${data_activacio}</b>.
        </p>
        <p>
        Recorda que rebràs una última factura fins aquesta data.
        </p>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="correu_es()">
    <table width="100%" frame="below">
    <tbody>
    <tr>
    <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${object.cups_id.direccio}</span></td>
    </tr>
    <tr>
    <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${object.cups_id.name}</span></td>
    </tr>
    </tbody>
    </table>
    <br>
    <p>
    Hola,<br>
    </p>
    <p>
    El <b>cambio de titular del contrato ${object.cups_polissa_id.name}</b> y dirección de suministro ${object.cups_polissa_id.cups_direccio} ha sido llevado a cabo con éxito.
    </p>
    <p>
    Así pues, ya no eres titular de este contrato desde la fecha <b>${data_activacio}</b>.
    </p>
    <p>
    Recuerda que recibirás una última factura hasta esta fecha.
    </p>
    Atentamente,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop">www.somenergia.coop</a>


</%def>

