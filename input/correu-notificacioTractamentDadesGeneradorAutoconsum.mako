<%!
    from mako.template import Template

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )
%>
<%
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
    </table>
    <p>
        Bon dia,
    </p>
    <p>
        Recentment, l'empresa de distribució elèctrica ens ha fet arribar les teves dades, en compliment de  la normativa vigent en matèria d’autoconsum, i et volem informar del tractament que farem de les teves dades personals donat que estan associades a una instal·lació d'autoconsum d'un CUPS comercialitzat per Som Energia.
    </p>
    <p>
        T'enviem la informació relacionada amb aquest tractament:
    </p>
    <p>
        INFORMACIÓ DE PROTECCIÓ DE DADES DE SOM ENERGIA
    </p>
    <p>
        <b>Responsabilitats:</b> SOM ENERGIA, SCCL. (F55091367), C/ Riu Güell, 68, 17005 de Girona, somenergia@delegado-datos.com. <b>Finalitats:</b> Tramitar l'alta de l'autoconsum associat a la seva instal·lació. <b>Legitimació:</b> Acord de serveis amb el titular de la instal·lació fotovoltaica o normativa vigent. <b>Destinataris:</b> No estan previstes cessions, tret entre el client, el titular de la instal·lació i Som Energia i, les legalment previstes. <b>Drets:</b> Pot retirar el seu consentiment en qualsevol moment, així com accedir, rectificar, suprimir les seves dades i altres drets a somenergia@delegado-datos.com. <b>Informació Addicional:</b><a href="https://www.somenergia.coop/ca/avis-legal/#politica-de-privacitat">Política de Privadesa.</a>
    </p>
    Salutacions,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
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
    </table>
    <p>
        Buenos días,
    </p>
    <p>
        Recientemente, la empresa de distribución eléctrica nos ha hecho llegar tus datos, en cumplimiento de la normativa vigente en materia de autoconsumo, y te queremos informar del tratamiento que haremos de tus datos personales que están asociados a una instalación de autoconsumo de un CUPS comercializado por Som Energia.
    </p>
    <p>
        Te enviamos la información relacionada con este tratamiento:
    <p>
        INFORMACIÓN DE PROTECCIÓN DE DATOS DE SOM ENERGIA
    </p>
    <p>
        <b>Responsabilidades:</b> SOM ENERGIA, SCCL. (F55091367), C/ Riu Güell, 68, 17005 de Girona, somenergia@delegado-datos.com. <b>Finalidades:</b> Tramitar el alta del autoconsumo asociado a su instalación.<b> Legitimación:</b> Acuerdo de servicios con el titular de la instalación fotovoltaica o normativa vigente. <b>Destinatarios:</b> No están previstas cesiones, salvo entre el cliente, el titular de la instalación y Som Energia y, las legalmente previstas. <b>Derechos:</b>  Puede retirar su consentimiento en cualquier momento, así como acceder, rectificar, suprimir sus datos y demás derechos en somenergia@delegado-datos.com. <b>Información Adicional:</b> <a href="https://www.somenergia.coop/es/aviso-legal/#politica-de-privacidad">Política de Privacidad</a>.
    </p>
    Saludos,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
</%def>