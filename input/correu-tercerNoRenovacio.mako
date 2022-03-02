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

    try:
        p_obj = object.pool.get('res.partner')
        if not p_obj.vat_es_empresa(object._cr, object._uid, object.polissa_id.titular.vat):
            nom_titular =' ' + object.polissa_id.titular.name.split(',')[1].lstrip()
        else:
            nom_titular = ''
    except:
        nom_titular = ''

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
% if object.polissa_id.titular.lang != "es_ES":
    ${correu_cat()}
% else:
    ${correu_es()}
% endif
${text_legal}
</html>


<%def name="correu_cat()">
        <body>
        <p>
            Hola${nom_titular},<br>
        </p>
        <br>
        <p>
            Fa uns dies us vam escriure per explicar-vos la situació de la cooperativa i les condicions per renovar el contracte. Us enviem aquest correu perquè no hem rebut una resposta definitiva per part vostra.<br>
        </p>
        <br>
        <p>
            Malauradament, si no ens comuniqueu el contrari, us informem que <strong>no renovarem el vostre contracte ${object.polissa_id.name} amb CUPS ${object.polissa_id.cups.name}</strong> i, per tant, rescindirem el contracte de forma unilateral el pròxim <strong>${object.polissa_id.modcontractual_activa.data_final}</strong>.<br>
        </p>
        <br>
        <p>
            Us demanem que recupereu els <strong>últims correus i seguiu les recomanacions</strong> que us fem, i en cas de tenir qualsevol dubte, ens contacteu.<br>
        </p>
        <br>
        <p>
            Si necessiteu aclarir dubtes per telèfon, podeu enviar-nos un número i us trucarem tan aviat com puguem.<br>
        </p>
        <br>
        Salutacions,<br>
        <br>
        Equip de Som Energia<br>
        <a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
        <a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
        <a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>
    </body>
</%def>

<%def name="correu_es()">
    <body>
        <p>
            Hola${nom_titular},<br>
        </p>
        <br>
        <p>
           Hace unos días os escribimos para explicaros la situación de la cooperativa y las condiciones para renovar el contrato. Os escribimos este correo porque no hemos recibido una respuesta definitiva por vuestra parte.<br>
        </p>
        <br>
        <p>
           Lamentablemente, si no nos comunicáis lo contrario, os informamos que <strong>no renovaremos vuestro contrato ${object.polissa_id.name} con CUPS ${object.polissa_id.cups.name}</strong>, y por tanto, rescindiremos el contrato de forma unilateral el próximo <strong>${object.polissa_id.modcontractual_activa.data_final}</strong>.<br>
        </p>
        <br>
        <p>
            Os sugerimos que, por favor, <strong>recuperéis los últimos correo y sigáis las recomendaciones que hacemos,</strong> y en caso de tener cualquier duda, nos contactéis.<br>
        </p>
        <br>
        <p>
            Si necesitáis aclarar dudas por teléfono, podéis enviarnos un número y os llamaremos en cuanto podamos.<br>
        </p>
        <br>
        Saludos,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
        <a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
        <a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>
    </body>
</%def>
