<%
    import time
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

    ingres = time.strftime('%d/%m/%y')
    def socifilter(text):
        return str(int(''.join([a for a in text if a.isdigit()])))
%>
<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"><br>
<br>
¡Bienvenido/a a Som Energia!<br> 
<br> 
Nos complace que formes parte de la cooperativa que construye un modelo energético renovable en manos de la ciudadanía, desde la participación y la transparencia. Esperamos que juntos podamos lograr nuestros objetivos de transformar el modelo energético apostando por las energías renovables y la eficiencia energética.<br> 
<br> 
<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td><fieldset><P ALIGN=left>Número de socio/a: <b>${object.partner_id.ref | socifilter}</b>
Nombre del socio/a: ${object.name}
Fecha de ingreso: ${ingres}
Aportación al capital social: 100€</fieldset></td></tr></table>
<br> 
Te animamos a que nos ayudes a difundir el proyecto de Som Energia, haciéndote amigo/a en <a href="https://es-es.facebook.com/somenergia">Facebook</a> siguiéndonos en <a href="https://twitter.com/SomEnergia">Twitter</a> o enviando un enlace de <a href="www.somenergia.coop">nuestra página web</a> a quien creas pueda estar interesado/a.<br>
Si quieres participar de la cooperativa de una forma más activa puedes consultar en el apartado de <a href="http://www.somenergia.coop/participa/">participación de nuestra web</a>: formar parte de un grupo local, de la plataforma, consultar nuestro blog.<br> 
<br> 
<br> 
Información de interés:<br> 
<ul><li><a href="http://www.somenergia.coop/contrata-la-luz/">Contratar la luz</a>: Recuerda que cada socio/a puede tener todos los contratos que quiera a su nombre (como titular). Y se puede responsabilizar de hasta cinco contratos de otros titulares.</li><br>
<li><a href="http://bit.ly/gkwh-socio-ES">Generación kWh</a>: Ahora también puedes generar tu propia energía renovable de forma colectiva. En el enlace encontrarás un vídeo explicativo.</li><br>
<li><a href="https://www.somenergia.coop/es/produccion-de-ias-renovables/">Proyectos de Generación de la cooperativa</a>: Puedes consultar los proyectos de producción de electricidad verde, el estado en que se encuentran y de otros datos de interés.</li><br>
<li><a href="http://es.support.somenergia.coop/">Centro de Ayuda de Som Energia</a>: Aquí puedes consultar todas las dudas que tengas de la cooperativa, de contratación de la luz, del mercado eléctrico, etc. </li><br>
</ul>
<br> 
¡Muchas gracias por tu apoyo!<br> 
<br> 
Atentamente,<br> 
<br> 
El equipo de Som Energia<br> 
<a href="www.somenergia.coop">www.somenergia.coop</a><br> 
<a href="http://es.support.somenergia.coop/article/471-como-puedo-contactar-con-la-cooperativa-mail-telefono-etc">Contactar con Som Energia</a><br> 
${text_legal}<br> 
</body>
</html>
