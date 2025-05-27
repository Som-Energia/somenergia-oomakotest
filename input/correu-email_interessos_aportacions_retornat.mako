<!doctype html>
<html>
    <body>
        <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"><br>
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
        template_id = md_obj.get_object_reference(
                            object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                        )[1]
        text_legal = render(t_obj.read(
            object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
            object
        )
        %>
        % if object.partner_id.lang != "es_ES":
            <br>
            Hola ${object.partner_id.name.split(',')[-1]},<br>
            <br>
            Avui ens ha vingut retornada la transferència de ${object.amount_total} € corresponent als interessos de la teva aportació voluntària al capital social de la cooperativa (número de liquidació ${object.number})<br>
            <br>
            La transferència la varem fer al número de compte  **** **** **** **** **** ${object.partner_bank.iban[-4:]}.<br>
            <br>
            Ens hauries d'informar d'un nou número de compte on et puguem fer l'ingrés.
            <br>
            Salutacions,<br>
            <br>
            <br>
            Som Energia, SCCL<br>
            <a href="http://www.somenergia.coop/ca/">www.somenergia.coop</a><br>
        % else:
            <br>
            Hola ${object.partner_id.name.split(',')[-1]},<br>
            <br>
            Hoy nos ha llegado devuelta la transferencia de ${object.amount_total} € correspondiente a los intereses de tu aportación voluntaria al capital social de la cooperativa (número de liquidación ${object.number})<br>
            <br>
            La transferencia la realizamos al número de cuenta  **** **** **** **** **** ${object.partner_bank.iban[-4:]}.<br>
            <br>
            Nos deberías informar de un nuevo número de cuenta donde te podamos realizar el ingreso.
            <br>
            Saludos,<br>
            <br>
            <br>
            Som Energia, SCCL<br>
            <a href="http://www.somenergia.coop/ca/">www.somenergia.coop</a><br>
        % endif
        <br>
        ${text_legal}
    </body>
</html>