<%!
    from mako.template import Template

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_partner_name(object_):
        p_obj = object_.pool.get('res.partner')
        if not object_.vat_enterprise():
            nom_titular =' ' + p_obj.separa_cognoms(object_._cr, object_._uid, object_.cups_polissa_id.titular.name)['nom']
        else:
            nom_titular = ''
        return nom_titular
%>
<%
    polissa = object.cups_polissa_id

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
        ${correu_es()}
    % endif
    ${text_legal}
</html>

<%def name="correu_cat()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${polissa.name}</strong></font>
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
        </table>
        <p>
            Hola${get_partner_name(object)},
        </p>
        <p>
            Ens ha arribat la notificació que no estàs d’acord amb les dades que ens ha passat l’empresa de distribució elèctrica referent a la teva instal·lació d’autoconsum associada al CUPS ${object.cups_id.name} amb direcció de subministrament ${object.cups_id.direccio}.
        </p>
        <p>
            Enviem el rebuig, amb el detall del motiu de desacord que ens has indicat a través de la teva oficina virtual, a la distribuïdora.
        </p>
        <p>
            Si es tracta d’un error en la comunicació per part de la distribuïdora ens faran arribar una nova comunicació corregida, si pel contrari es tracta d’un error a l’hora de fer el registre o de la comunicació per part de la Comunitat Autònoma cal que contacteu amb la mateixa per tal de modificar la informació i que comenci el procés novament.
        </p>
        <p>
            Malauradament, la distribuïdora no ens indica si es tracta d’una o altra casuística pel que et recomanem que contactis directament amb la distribuïdora i el departament corresponent de la teva Comunitat Autònoma per aclarir-ho.
        </p>
        <p>
            Qualsevol dubte seguim en contacte.
        </p>
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
                    <font size=2><strong> Contrato Som Energia nº ${polissa.name}</strong></font>
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
                    <font size=1> Código CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
        </table>
        <p>
            Hola${get_partner_name(object)},
	    </p>
        <p>
	        Nos ha llegado la notificación que no estás de acuerdo con los datos que nos ha pasado la empresa de distribución eléctrica referente a tu instalación de autoconsumo asociada al CUPS ${object.cups_id.name} con dirección de suministro ${object.cups_id.direccio}.
        </p>
        <p>
            Enviamos el rechazo, con el detalle del motivo de desacuerdo que nos has indicado a través de tu oficina virtual, a la distribuidora.
        </p>
        <p>
            Si se trata de un error en la comunicación por parte de la distribuidora nos harán llegar una nueva comunicación corregida, si por el contrario se trata de un error a la hora de hacer el registro o de la comunicación por parte de la Comunidad Autónoma deberás ponerte en contacto con la misma a fin de modificar la información y que comience el proceso nuevamente.
        </p>
        <p>
            Desgraciadamente, la distribuidora no nos indica si se trata de una u otra casuística por lo que te recomendamos que contactes directamente con la distribuidora y el departamento correspondiente de tu Comunidad Autónoma para aclararlo.
        </p>
        <p>
            Cualquier duda seguimos en contacto.
        </p>
        Saludos,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>