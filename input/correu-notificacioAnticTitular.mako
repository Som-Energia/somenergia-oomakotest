<%!
    from mako.template import Template
    from datetime import datetime, timedelta

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )


    def get_nom_cognoms(object_, owner):
        partner_obj = object_.pool.get('res.partner')
        name_dict = partner_obj.separa_cognoms(object_._cr, object_._uid, owner.name)

        if partner_obj.vat_es_empresa(object_._cr, object_._uid, owner.vat):
            return name_dict['nom']

        return "{0} {1}".format(name_dict['nom'], ' '.join(name_dict['cognoms']))

    def get_pas01(cas):
        for step_id in cas.step_ids:
            proces_name = step_id.proces_id.name
            step_name = step_id.step_id.name
            if proces_name == "M1" and step_name == "01":
                return step_id
        return None
%>

<%
    pas01 = get_pas01(object)
    es_ct_subrogacio = pas01.pas_id.sollicitudadm == "S" and pas01.pas_id.canvi_titular == "S"

    nom_antic_tiular = get_nom_cognoms(object, object.cups_polissa_id.titular)

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')

    template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
    )[1]

    text_legal = render(
        t_obj.read(object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
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
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${nom_antic_tiular}</font>
                </td>
            </tr>
        </table>
        <p>
		    Benvolgut/da ${nom_antic_tiular},
        </p>
        <p>
            T’informem que hem rebut correctament la sol·licitud de canvi de titular per al contracte número ${object.cups_polissa_id.name} amb el CUPS: ${object.cups_id.name} i adreça ${object.cups_id.direccio}
        </p>
        % if not es_ct_subrogacio:
            <p>
            En les properes setmanes rebràs una última factura fins a la data d’activació del contracte amb la nova persona titular.
            </p>
		% endif
        <p>
            En cas que siguis l’usuari efectiu d’aquest punt de subministrament, i aquesta sol·licitud sigui per tant incorrecta, t’agrairem responguis aquest mateix correu electrònic al més aviat possible acreditant aquesta circumstància.
        </p>
        <p>
            Us informem que el nou titular disposa d’un termini de 14 dies per desistir de la contractació. En cas de fer-ho, el contracte tornaria a la situació anterior. En aquest cas, si ja no ets el usuari efectiu de la llum, i aquest no demana un canvi de titular al seu favor, podràs demanar una baixa del contracte de subministrament.mitjançant el següent formulari <a href="https://ca.support.somenergia.coop/article/771-baixa-de-subministrament-electric">baixa del subministrament elèctric</a>.
        </p>
        <br>
        Salutacions,<br>
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
            <tr>
                <td height=2px width=100%>
                    <font size=1>Titular: ${nom_antic_tiular}</font>
                </td>
            </tr>
        </table>
        <p>
            Estimado/a ${nom_antic_tiular},
        </p>
        <p>
            Te informamos que hemos recibido correctamente la solicitud de cambio de titular del contrato número ${object.cups_polissa_id.name} con el CUPS: ${object.cups_id.name} y dirección ${object.cups_id.direccio}
	    </p>
        % if not es_ct_subrogacio:
            <p>
                En las próximas semanas recibirás una última factura hasta la fecha de activación del contrato con la nueva persona titular.
            </p>
        % endif
        <p>
            En caso de que seas el usuario efectivo de este punto de suministro, y esta solicitud sea por lo tanto incorrecta, te agradeceremos que respondas este mismo correo electrónico lo antes posible acreditando esta circunstancia.
        </p>
        <p>
            Os informamos que el nuevo titular dispone de un plazo de 14 días para desistir en la contratación. En caso de hacerlo, el contrato volvería a la situación anterior. En este caso, si ya no eres el usuario efectivo de la luz, y este no pide un cambio de titular a su favor, podrás pedir una baja del contrato de suministro mediante el siguiente formulario <a href="https://es.support.somenergia.coop/article/772-baja-del-suministro-electrico">baja del suministro eléctrico</a>.
        </p>
        <br>
	    Saludos,<br/>
	    <br/>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>
