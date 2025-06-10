<%
    from datetime import datetime
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

    data_act = datetime.strptime(
        object.step_ids[1].pas_id.data_activacio, '%Y-%m-%d'
    ).strftime('%d-%m-%Y') if len(object.step_ids) > 1 else ""

    p_obj = object.pool.get('res.partner')

    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
    )['nom']) if not object.vat_enterprise() else ""
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
                    % if object.cups_polissa_id.titular.lang == 'ca_ES':
                        ${correu_cat()}
                    % else:
                        ${correu_es()}
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

<%def name="correu_cat()">
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
    <body>
        <br>
        <br>
        <p>
            Hola${nom_titular},<br>
            <br>
            Ens plau comunicar-te que <strong>la sol·licitud del canvi ha estat acceptada</strong>.<br>
        </p>
        <p>
            % if data_act:
            La data de l’activació serà aproximadament el dia ${data_act}.<br>
            <br>
            % endif
            T'enviarem un e-mail per comunicar-te que el contracte ja està actiu amb la cooperativa.<br>
            <br>
            Tingues en compte que encara t'arribarà una factura (la darrera) de la companyia actual.<br>
        </p>
        <p>
            Les dades del contracte són les següents:<br>
            - Número de contracte amb Som Energia: ${object.cups_polissa_id.name}<br>
            - Titular del contracte: ${object.cups_polissa_id.titular.name}<br>
            - Soci/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
            <br>
            - Adreça: ${object.cups_polissa_id.cups_direccio}<br>
            - CUPS: ${object.cups_id.name}<br>
        </p>
        <br>
        <br>
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
    </body>
</%def>

<%def name="correu_es()">
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
    <body>
        <br>
        <br>
        <p>
            Hola${nom_titular},<br>
            <br>
            Nos complace comunicarte que <strong>la solicitud del cambio ha sido aceptada</strong>.<br>
        </p>
        <p>
            % if data_act:
            La fecha de activación será aproximadamente el día ${data_act}.<br>
            <br>
            % endif
            Cuando nos lo comuniquen, te enviaremos un e-mail indicando que el contrato ya es activo con la cooperativa.<br>
            <br>
            En cualquier caso, todavía te llegará una factura (la última) de la compañía actual.<br>
        </p>
        <p>
            Los datos del contrato son los siguientes:<br>
            - Número de contrato con Som Energia: ${object.cups_polissa_id.name}<br>
            - Titular del contrato: ${object.cups_polissa_id.titular.name}<br>
            - Socio/a Som Energia: ${object.cups_polissa_id.soci.name}<br>
            <br>
            - Dirección: ${object.cups_polissa_id.cups_direccio}<br>
            - CUPS: ${object.cups_id.name}<br>
        </p>
        <br>
        <br>
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>
