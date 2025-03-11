<%
    from mako.template import Template
    from datetime import datetime, timedelta

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_motiu_modificacio(object_, motiu, lang):
        M205 = object_.pool.get('giscedata.switching.m2.05')
        motiu_modificacio = dict(M205.fields_get(object_._cr, object_._uid, context={'lang': lang})['motiu_modificacio']['selection'])
        return motiu + " - " + motiu_modificacio[motiu]

    def get_potencia_generacio(object_, pas):
        data = []
        for cau in pas.dades_cau:
            cau_name = cau.cau
            cau_pot = 0
            for instalacio in cau.dades_instalacio_gen:
                cau_pot += instalacio.pot_installada_gen
            data.append((cau_name, cau_pot))
        return data

    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, object.cups_polissa_id.titular.name
        )['nom']) if not object.vat_enterprise() else ''

    pas01 = object.step_ids[0].pas_id if len(object.step_ids) > 0 else None
    pas05 = object.step_ids[-1].pas_id if len(object.step_ids) > 0 else None
    date_activacio = datetime.strptime(pas05.data_activacio, '%Y-%m-%d').strftime('%d/%m/%Y')

    motiu_modificacio = get_motiu_modificacio(object, pas05.motiu_modificacio, object.cups_polissa_id.titular.lang)
    pots_generacio = get_potencia_generacio(object, pas05)
    

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]

    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        object
    )
%>

<!doctype html>
<html>
    <head>
        <meta charset='utf-8'>
    </head>
    % if object.cups_polissa_id.titular.lang == "ca_ES":
        ${correu_cat()}
    % else:
        adeu
        ${correu_es()}
    % endif
    ${text_legal}
</html>


<%def name="correu_cat()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Adreça punt subministrament: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codi CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${nom_titular},
        </p>
        ${pot_gen_ca()}
        Atentament,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>

<%def name="correu_es()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${object.cups_polissa_id.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Dirección del punto de suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codigo CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${nom_titular},
        </p>
        ${pot_gen_es()}
        Atentamente,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>

<%def name="pot_gen_ca()">
    <p>
        La sol·licitud de la modificació contractual ha estat ACTIVADA, amb data ${date_activacio}.
    </p>
    <p>
        Les condicions contractuals actuals del teu contracte amb Som Energia són:
    </p>
    <ul>
        <li>Autoconsum:
            <ul>
                <li>Motiu: ${motiu_modificacio}</li>
                <li>Potència generació:
                    <ul>
                    % for pot_generacio in pots_generacio:
                        <li>CAU: ${pot_generacio[0]} - ${pot_generacio[1]} kW</li>
                    % endfor
                    </ul>
                </li>
            </ul>
        </li>
    </ul>

    <p>
        Les dades del contracte que s'ha fet la modificació contractual són les següents:
    </p>
    <ul>
        <li>Titular del contracte: ${object.cups_polissa_id.titular.name}</li>
        <li>Adreça: ${object.cups_polissa_id.cups_direccio}</li>
        <li>CUPS: ${object.cups_id.name}</li>
        <li>Número de contracte amb Som Energia: ${object.cups_polissa_id.name}</li>
        <li>Soci/a Som Energia: ${object.cups_polissa_id.soci.name}</li>
    </ul>
    <p>
        Estem en contacte per a qualsevol dubte o consulta.
    </p>
</%def>

<%def name="pot_gen_es()">
    <p>
        La solicitud de la modificación contractual ha sido ACTIVADA con fecha ${date_activacio}.
    </p>
    <p>
        Las condiciones contractuales actuales de tu contrato con Som Energia son:
    </p>
    <ul>
        <li>Autoconsumo:
            <ul>
                <li>Motiu: ${motiu_modificacio}</li>
                <li>Potencia generación:
                    <ul>
                    % for pot_generacio in pots_generacio:
                        <li>CAU: ${pot_generacio[0]} - ${pot_generacio[1]} kW</li>
                    % endfor
                    </ul>
                </li>
            </ul>
        </li>
    </ul>

    <p>
        Los datos del contrato con el que se ha hecho la modificación contractual son los siguientes:
    </p>
    <ul>
        <li>Titular del contrato: ${object.cups_polissa_id.titular.name}</li>
        <li>Dirección: ${object.cups_polissa_id.cups_direccio}</li>
        <li>CUPS: ${object.cups_id.name}</li>
        <li>Número de contrato con Som Energia: ${object.cups_polissa_id.name}</li>
        <li>Soci/a Som Energia: ${object.cups_polissa_id.soci.name}</li>
    </ul>
    <p>
        Estamos en contacto para cualquier duda o consulta.
    </p>
</%def>
