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
            Hola ${nom_titular},<br>
        </p>
        <p>
            Fa uns dies us vam escriure per explicar-vos la situació de la cooperativa i la proposta de renovació del vostre contracte. A continuació us detallem les condicions d’aquesta proposta:<br>
        </p>
        <p>
            <strong>Oferta amb tarifa indexada</strong><br>
            <ul>
                <li>El marge de comercialització amb els costos pel desviament inclosos és de <strong>${marge} €/MWh</strong>. Podeu consultar els detalls de l’oferta en el document adjunt.</li>
                <li>En aquest altre <a href="https://www.somenergia.coop/tarifa_indexada/CA_EiE_Explicacio_Tarifa_Indexada_Entitats_i_Empreses_Som_Energia.pdf">document</a> expliquem què és la tarifa indexada i el seu funcionament.</li>
            </ul>
        </p>
        <p>
           <strong>Garantia en forma de dipòsit bancari</strong><br>
           <ul>
                <li>La contractació amb tarifa indexada està supeditada al pagament d’una garantia en forma de dipòsit bancari, executable en cas d’impagament.</li>
                <li>L'import de la garantia s'ha calculat a partir de l’ús d’energia de l’últim any i de la nostra predicció dels preus indexats pels pròxims mesos, sense tenir en compte els descomptes del govern espanyol en l’impost elèctric i els càrrecs. Aquest import és una estimació del que podria representar una factura si el preu de l'electricitat es mantingués elevat durant totes les hores del mes. </li>
                <li>En el vostre cas, l’import de la garantia és de <strong>${garantia} €</strong>.</li>
                <li>El compte on realitzar l'ingrés és ES82 1491 0001 2920 2709 8223 (Triodos Bank) i en el concepte cal indicar "garantia + número CIF".</li>
                <li>L’últim dia per rebre l’ingrés és el <strong>${data_limit}</strong>. </li>
                <li>Abans d’ingressar la garantia caldrà signar el nou contracte amb tarifa indexada, que inclou la clàusula sobre la garantia.</li>
           </ul>
        </p>
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
        <p>
            També cal que ens faciliteu el document dels poders notarials i que ens envieu el <strong>document SEPA</strong> adjunt complimentat i firmat. Ens l'hauríeu d'enviar amb <strong>firma digital</strong>, però si no és possible, per correu postal a: Som Energia, SCCL. Parc Científic i Tecnològic de la UdG. C/Pic de Peguera, 9 (1a planta) 17003 Girona.<br>
        </p>
        <p>
           Un cop tinguem preparat el contracte, procedirem a la firma digital d'aquest a través de la plataforma <a href="https://www.signaturit.com/es">Signaturit</a> (no cal registrar-se). 
        </p>
        <p>
            Si necessiteu aclarir dubtes per telèfon, podeu enviar-nos un número i us trucarem tan aviat com puguem.<br>
        </p>
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
            Hola ${nom_titular},<br>
        </p>
        <p>
           Hace unos días os escribimos para explicaros la situación de la cooperativa y la propuesta de renovación de vuestro contrato. A continuación os detallamos las condiciones de esta propuesta:<br>
        </p>
        <p>
            <strong>Oferta con tarifa indexada</strong><br>
            <ul>
                <li>El margen de comercialización con los costes de desvío incluidos es de <strong>${marge} €/MWh</strong>. Podéis consultar los detalles de la oferta en el documento adjunto. </li>
                <li>En este otro <a href="https://www.somenergia.coop/tarifa_indexada/ES_EiE_Explicacion_Tarifa_Indexada_Entidades_y_Empresas_Som_Energia.pdf">documento</a> explicamos qué es la tarifa indexada y su funcionamiento.  </li>
            </ul>
        </p>
        <p>
           <strong>Garantía en forma de depósito bancario</strong><br>
           <ul>
                <li> La contratación con tarifa indexada está supeditada al pago de una garantía en forma de depósito bancario, ejecutable en caso de impago.</li>
                <li> El importe de la garantía se ha calculado a partir del uso de energía del último año y de nuestra predicción de precios indexados para los próximos meses, sin tener en cuenta los descuentos del gobierno español en el impuesto eléctrico y los cargos. Así pues, este importe es nuestra estimación de lo que puede representar una factura si el precio de la electricidad se mantuviera elevado durante todas las horas del mes.</li>
                <li> En vuestro caso, el importe de la garantía es de <strong>${garantia} €</strong>.</li>
                <li> La cuenta donde realizar el ingreso es ES82 1491 0001 2920 2709 8223 (Triodos Bank) y en el concepto hay que indicar "garantía + número CIF".</li>
                <li> El último día para recibir el ingreso es el <strong>${data_limit}</strong>.</li>
                <li> Antes de ingresar la garantía hay que firmar el nuevo contrato con tarifa indexada, que incluye la cláusula sobre la garantía.</li>
           </ul>
        </p>
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
        <p>
        También será necesario que nos facilitéis el documento de los poderes notariales y que nos enviéis el <strong>documento SEPA</strong> adjunto cumplimentado y firmado. Nos lo deberíais enviar con <strong>firma digital</strong>, pero si no es posible, por correo postal a: Som Energia, SCCL. Parque Científico y Tecnológico de la UdG. C/Pic de Peguera, 9 (1ª planta) 17003 Girona.<br>
        </p>
        <p>
            Una vez tengamos preparado el contrato, procederemos a la firma digital del mismo a través de la plataforma <a href="https://www.signaturit.com/es">Signaturit</a> (no es necesario registrarse).
        </p>
        <p>
            Si necesitáis aclarar dudas por teléfono, podéis enviarnos un número y os llamaremos en cuanto podamos.<br>
        </p>
        Saludos,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
        <a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
        <a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>
    </body>
</%def>
