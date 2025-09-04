<%!
    from datetime import datetime, timedelta
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

    data_limit = datetime.strptime(object.polissa_id.modcontractual_activa.data_final, '%Y-%m-%d') - timedelta(days=7)
    data_limit = data_limit.strftime('%d/%m/%Y')

    if object.extra_text:
        text_extra = eval(object.extra_text)
        marge = text_extra.get('marge', 0)
        garantia = text_extra.get('import_garantia', 0)
    else:
        marge = 0
        garantia = 0
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
            Fa uns dies us vam escriure per explicar-vos la situació de la cooperativa i la proposta de renovació del vostre contracte. A continuació us detallem les condicions d’aquesta proposta:<br>
        </p>
        <br>
        <p>
            <strong>Oferta amb tarifa indexada</strong><br>
            <ul>
                <li>El marge de comercialització amb els costos pel desviament inclosos és de <strong>${marge} €/MWh</strong>. Podeu consultar els detalls de l’oferta en el document adjunt.</li>
                <li>En aquest altre <a href="https://www.somenergia.coop/documentacio_EiE/CA_EiE_Explica_Tarifa%20Indexada%20per%20Entitats%20i%20Empreses_Som%20Energia.pdf">document</a> expliquem què és la tarifa indexada i el seu funcionament.</li>
            </ul>
        </p>
        <br>
        <p>
            <strong>Signatura del nou contracte</strong><br>
            Per preparar el nou contracte necessitem les següents dades:<br>
            <ul>
                <li>Domicili social. </li>
                <li>Direcció postal de notificació. </li>
                <li>Nom de la persona representant que firmarà el contracte. </li>
                <li>NIF de la persona representant. </li>
                <li>Correu de contacte de la persona representant. </li>
                <li>Data de firma dels poders notarials. </li>
                <li>Municipi de la firma dels poders notarials. </li>
                <li>Nom del notari o notària. </li>
                <li>Número de protocol dels poders. </li>
            </ul>
        </p>
        <br>
        <p>
            També cal que ens faciliteu el document dels poders notarials i que ens envieu el <strong>document SEPA</strong> adjunt complimentat i firmat. Ens l'hauríeu d'enviar amb <strong>firma digital</strong>, però si no és possible, per correu postal a: Som Energia, SCCL. C/Riu Güell, 68 - 17005 Girona.<br>
        </p>
        <br>
        <p>
           Un cop tinguem preparat el contracte, procedirem a la firma digital d'aquest a través de la plataforma <a href="https://www.signaturit.com/es">Signaturit</a> (no cal registrar-se). <br>
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
           Hace unos días os escribimos para explicaros la situación de la cooperativa y la propuesta de renovación de vuestro contrato. A continuación os detallamos las condiciones de esta propuesta:<br>
        </p>
        <br>
        <p>
            <strong>Oferta con tarifa indexada</strong><br>
            <ul>
                <li>El margen de comercialización con los costes de desvío incluidos es de <strong>${marge} €/MWh</strong>. Podéis consultar los detalles de la oferta en el documento adjunto. </li>
                <li>En este otro <a href="https://www.somenergia.coop/documentacio_EiE/ES_EiE_Explica_Tarifa%20Indexada%20para%20Entidades%20y%20Empresas_Som%20Energia.pdf">documento</a> explicamos qué es la tarifa indexada y su funcionamiento.  </li>
            </ul>
        </p>
        <br>
        <p>
            <strong>Signatura del nuevo contrato </strong><br>
            Para preparar el nuevo contrato necesitamos los siguientes datos:<br>
            <ul>
                <li> Domicilio social.</li>
                <li> Dirección postal de notificación.</li>
                <li> Nombre de la persona representante que firmará el contrato.</li>
                <li> NIF de la persona representante.</li>
                <li> Correo de contacto de la persona representante.</li>
                <li> Fecha de firma de los poderes notariales.</li>
                <li> Municipio de firma de los poderes notariales.</li>
                <li> Nombre del notario o notaria.</li>
                <li> Número de protocolo de los poderes.</li>
            </ul>
        </p>
        <br>
        <p>
        También será necesario que nos facilitéis el documento de los poderes notariales y que nos enviéis el <strong>documento SEPA</strong> adjunto cumplimentado y firmado. Nos lo deberíais enviar con <strong>firma digital</strong>, pero si no es posible, por correo postal a: Som Energia, SCCL. C/Riu Güell, 68 - 17005 Girona.<br>
        </p>
        <br>
        <p>
            Una vez tengamos preparado el contrato, procederemos a la firma digital del mismo a través de la plataforma <a href="https://www.signaturit.com/es">Signaturit</a> (no es necesario registrarse).
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
