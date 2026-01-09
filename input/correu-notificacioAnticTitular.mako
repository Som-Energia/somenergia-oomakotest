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
    <tr>
    <td width="100%" height="2px"><span style="font-size: xx-small;"> Titular: ${nom_antic_tiular} </span></td>
    </tr>
    </tbody>
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
    <tr>
    <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${nom_antic_tiular} </span></td>
    </tr>
    </tbody>
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
</%def>
