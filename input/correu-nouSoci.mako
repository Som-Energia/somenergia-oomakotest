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
% if object.partner_id.lang == "ca_ES":
Benvingut/da a Som Energia!<br> 
<br> 
Ens complau que formis part de la cooperativa que construeix un model energètic renovable en mans de la ciutadania, des de la participació i la transparència. Esperem que junts puguem assolir els nostres objectius de transformar el model energètic apostant per les energies renovables i l'eficiència energètica.<br> 
<br> 
<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td><fieldset><P ALIGN=center> Número de soci/a: <b>${object.partner_id.ref | socifilter}</b><br>
 Nom del soci/a: ${object.name}<br>
 Data d'ingrés: ${ingres}<br>
 Aportació al capital social: 100€</fieldset></td></tr></table><br>
<br>
Per fer front a les <a href="https://blog.somenergia.coop/som-energia/2021/12/noves-mesures-per-fer-front-a-les-tensions-actuals-del-mercat-energetic/">tensions actuals del mercat energètic</a>, hem obert una emissió d’aportacions voluntàries per augmentar en 15 milions d’euros el capital social de la cooperativa. <b>T’animem a fer la teva aportació</b> <a href="https://www.somenergia.coop/ca/produeix-energia-renovable/aporta-al-capital-social/">des d’aquest formulari</a> on també trobaràs resposta a les preguntes més freqüents.
<br>
Al mateix temps, t'encoratgem que ens ajudis a difondre el projecte de Som Energia, fent-te amic al <a href="https://es-es.facebook.com/somenergia">Facebook</a>, seguint-nos al <a href="https://twitter.com/SomEnergia">Twitter</a> o enviant un enllaç de la <a href="www.somenergia.coop/ca">nostra pàgina web</a> a qui creguis pugui estar interessat/da.<br> 
Si vols participar de la cooperativa d'una forma més activa pots consultar a l'apartat de <a href="http://www.somenergia.coop/ca/participa/">participació de la nostra web</a>; formar part d'un grup local, de la plataforma, consultar el nostre blog, tot ho trobaràs al mateix link.<br> 
<br> 
<br> 
Informació d'interès:<br> 
<ul><li><a href="http://www.somenergia.coop/ca/contracta-la-llum/">Contractar la llum</a>: Amb el número de soci ja pots contractar la llum de tots els contractes que vulguis al teu nom i a 5 més que no estiguin al teu nom.</li><br> 
<li><a href="http://bit.ly/gkwh-soci-CA">Generació kWh</a>:  Ara també pots generar la teva pròpia energia renovable de forma col·lectiva. A l'enllaç trobaràs un vídeo explicatiu.</li><br> 
<li><a href="https://www.somenergia.coop/ca/produccion/">Projectes de Generació de la cooperativa</a>: Pots consultar els nostres (teus!) projectes d'energia renovable, l'estat en el que es troben i altres dades d'interès.</li><br> 
<li><a href="http://ca.support.somenergia.coop/">Centre de Suport de Som Energia</a>: Pots consultar tots els dubtes que tinguis de la cooperativa, de contractació de la llum, del mercat elèctric a través del Centre d'Ajuda.</li></ul>
<br> 
Moltes gràcies pel teu suport!<br> 
<br> 
Atentament,<br> 
<br> 
L'equip de Som Energia<br> 
<a href="www.somenergia.coop/ca">www.somenergia.coop</a><br> 
info@somenergia.coop<br> 
<a href="http://ca.support.somenergia.coop/article/470-com-puc-contactar-amb-la-cooperativa-mail-telefon-etc">Contactar amb Som Energia</a><br> 
% else:
¡Bienvenido/a a Som Energia!<br> 
<br> 
Nos complace que formes parte de la cooperativa que construye un modelo energético renovable en manos de la ciudadanía, desde la participación y la transparencia. Esperamos que juntos podamos lograr nuestros objetivos de transformar el modelo energético apostando por las energías renovables y la eficiencia energética.<br> 
<br> 
<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td><fieldset><P ALIGN=left>Número de socio/a: <b>${object.partner_id.ref | socifilter}</b><br>
Nombre del socio/a: ${object.name}<br>
Fecha de ingreso: ${ingres}<br>
Aportación al capital social: 100€</fieldset></td></tr></table><br>
<br> 
Para hacer frente a las <a href="https://blog.somenergia.coop/som-energia/2021/12/nuevas-medidas-para-hacer-frente-a-las-tensiones-actuales-del-mercado-energetico/">tensiones actuales del mercado energético</a>, hemos abierto una emisión de aportaciones voluntarias para aumentar en 15 millones de euros el capital social de la cooperativa. <b>Te animamos a realizar tu aportación</b> <a href="https://www.somenergia.coop/es/produce-energia-renovable/aporta-al-capital-social/">desde este formulario</a> donde también encontrarás respuesta a las preguntas más frecuentes.
<br>
Además, puedes ayudar a difundir el proyecto de Som Energia, haciéndote amigo/a en <a href="https://es-es.facebook.com/somenergia">Facebook</a> siguiéndonos en <a href="https://twitter.com/SomEnergia">Twitter</a> o enviando un enlace de <a href="www.somenergia.coop">nuestra página web</a> a quien creas pueda estar interesado/a.<br>
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
% endif
<br>
${text_legal} 
</body>
</html>
