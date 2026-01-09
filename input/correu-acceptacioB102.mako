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
    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

    p_obj = object.pool.get('res.partner')

    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ''
%>

${plantilla_header}
% if object.cups_polissa_id.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${plantilla_footer}


<%def name="correu_cat()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Adreça punt subministrament: ${object.cups_id.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: xx-small;"> Codi CUPS: ${object.cups_id.name}</span>
            </td>
        </tr>
        <tr>
            <td height=2px width=100%>
                <span style="font-size: xx-small;"> Titular: ${object.cups_polissa_id.titular.name}</span>
            </td>
        </tr>
    </table>
    <br>
    <br>
    <p>
        Hola${nom_titular},<br>
    </p>
    <p>
        Hem sol·licitat la baixa amb tall de subministrament del contracte corresponent a ${object.cups_polissa_id.cups_direccio} i ha estat acceptada.<br>
    </p>
    <p>
        <a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">L'empresa de distribució elèctrica</a> té 5 dies hàbils per donar de baixa aquest punt de subministrament i que deixi d'haver-hi llum.<br>
    </p>
    <p>
        Recorda que la cooperativa emetrà una última factura fins que la baixa sigui efectiva.<br>
    </p>
    <p>
        De seguida que ens comuniquin la data, us informarem.<br>
    </p>
    <br>
    <br>
    <p>
        Atentament,
    </p>
    <br>
    <p>
        Equip de Som Energia <br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a>
    </p>

</%def>

<%def name="correu_es()">
    <table width="100%" frame="below">
        <tr>
            <td height=2px>
                <span style="font-size: small;"><strong> Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Dirección del punto de suministro: ${object.cups_id.direccio}</span>
            </td>
        </tr>
        <tr>
            <td height=2px>
                <span style="font-size: small;"> Codigo CUPS: ${object.cups_id.name}</span>
            </td>
        </tr>
        %if is_pot_tar:
        <tr>
            <td height=2px width=100%>
                <span style="font-size: small;"> Titular: ${object.cups_polissa_id.titular.name}</span>
            </td>
        </tr>
        %endif
    </table>
    <br>
    <br>
    <p>
        Hola${nom_titular},<br>
    </p>
    <p>
        Hemos solicitado la baja con corte de suministro del contrato correspondiente a la dirección ${object.cups_polissa_id.cups_direccio} y ha sido aceptada.<br>
    </p>
    <p>
        <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">La empresa de distribución eléctrica</a> tiene 5 días hábiles para dar de baja este punto de suministro y que deje de haber luz.<br>
    </p>
    <p>
        Recuerda que la cooperativa emitirá una última factura hasta que la baja sea efectiva.<br>
    </p>
    <p>
        En cuanto nos comuniquen la fecha exacta, os informaremos.<br>
    </p>
    <p>
        Atentamente,
    </p>
    <br>
    <p>
        Equipo de Som Energia <br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </p>
</%def>
