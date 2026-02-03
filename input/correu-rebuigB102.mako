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
    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

    p_obj = object.pool.get('res.partner')

    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ""
%>

${plantilla_header}

% if object.cups_polissa_id.titular.lang == "ca_ES":
    ${cabecera_cat()}
    <br><br>
    ${salutacio_cat()}
    <p>${notificacio_text_cat()}</p>
    ${footer_cat()}
% else:
    ${cabecera_es()}
    <br><br>
    ${salutacio_es()}
    <p>${notificacio_text_es()}</p>
    ${footer_es()}
% endif

${plantilla_footer}


<%def name="cabecera_cat()">
    <head>
        <table width="100%" frame="below">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
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
</%def>

<<%def name="cabecera_es()">
    <head>
        <table width="100%" frame="below">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${object.cups_polissa_id.name}</strong></font>
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
</%def>

<%def name="salutacio_cat()">
    <p>
        Hola${nom_titular}, <br>
    </p>
    <p>
        Fa uns dies vas sol·licitar una baixa amb tall de subministrament per aquest contracte.
    </p>
</%def>

<%def name="salutacio_es()">
    <p>
        Hola${nom_titular}, <br>
    </p>
    <p>
        Recientemente has solicitado una baja con corte de suministro para este contrato.
    </p>
</%def>

<%def name="notificacio_text_cat()">
    <p>
        L'<a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat">empresa distribuïdora</a> de la teva zona, l'encarregada de fer efectiva la baixa, ha rebutjat la teva sol·licitud amb el següent motiu:
    </p>
    <p>
        <strong>Existencia de Solicitud previa en curso C2</strong>
    </p>
    <p>
        Això vol dir, que per aquest punt de subministrament, també s'ha sol·licitat un canvi de comercialitzadora amb modificacions contractuals (el més probable és que es tracti d'un canvi de comercialitzadora amb canvi de titularitat). En aquest cas, l'empresa distribuïdora no tramitarà la baixa de subministrament, ja que es prioritza el canvi de companyia.
    </p>
    <p>
        Ben aviat, rebràs un correu electrònic en el qual t'indicarem la data efectiva del canvi de comercialitzadora.
    </p>
</%def>

<%def name="notificacio_text_es()">
    <p>
        La <a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad">empresa distribuidora</a> de tu zona, la encargada hacer efectiva la baja, ha rechazado tu solicitud con el siguiente motivo:
    </p>
    <p>
        <strong>Existencia de Solicitud previa en curso C2</strong>
    </p>
    <p>
        Esto quiere decir, que para este punto de suministro, también se ha solicitado un cambio de comercializadora con modificaciones contractuales (lo más probable es que se trate de un cambio de comercializadora con cambio de titularidad). En este caso, la empresa distribuidora no tramitará la baja de suministro, ya que se prioriza el cambio de compañía.
    </p>
    <p>
        En los próximos días, recibirás un correo electrónico en el que te indicaremos la fecha efectiva del cambio de comercializadora.
    </p>
</%def>

<%def name="footer_cat()">
    <p>
        Gràcies per la teva atenció, estem en contacte per a qualsevol dubte o consulta.<br>
    </p>
    Atentament,<br>
    <br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
    <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
</%def>

<%def name="footer_es()">
    <p>
        Muchas gracias por tu atención, estamos en contacto para cualquier duda o consulta.<br>
    </p>
    Atentamente,<br>
    <br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
