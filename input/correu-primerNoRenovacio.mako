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
            Hola ${nom_titular},<br>
        </p>
        <p>
            Us escrivim amb una notícia difícil de donar.<br>
        </p>
        <p>
            Tal com segurament ja sabeu, els darrers mesos el cost de l'electricitat al mercat majorista diari ha pujat desorbitadament, situant els preus a més de 400 €/MWh en hores puntuals durant el mes de desembre. Amb la volatilitat actual en el mercat elèctric aquesta situació es podria repetir, i fins i tot, superar aquest preu.<br>
        </p>
        <p>
            El vostre contracte d'electricitat finalitza aviat, i us hem de comunicar que <strong> no podem renovar el contracte ${object.polissa_id.name} amb CUPS ${object.polissa_id.cups.name} amb una tarifa a preu fix,</strong> com teníeu fins ara. Per a la cooperativa no és possible continuar oferint una tarifa fixa, fins i tot amb les actualitzacions de tarifa recents, a causa de la volatilitat dels preus actuals, i també l'augment dels costos associats a la comercialització d'energia elèctrica que hem d'afrontar: d'una banda, l'obligació de dipositar un volum de garanties molt elevat davant de l'operador del mercat majorista i, de l'altra, el fet que hem d'avançar l'import de la compra de l'energia (que paguem setmanalment i facturem a final de mes), que provoca importants tensions a la tresoreria de la cooperativa<br>
        </p>
        <p>
            Tot i això, en cas de seguir interessats a mantenir aquest contracte d'electricitat amb Som Energia, podem oferir-vos una contractació <strong> amb tarifa indexada </strong>, en què el preu de l'electricitat no serà fix sinó que variarà hora a hora juntament amb el preu del mercat majorista. A més, necessitarem incloure una <strong>garantia en forma de dipòsit bancari en el compte de Som Energia.</strong><br>
        </p>
        <p>
            Aquesta garantia no és un aval, sinó un dipòsit que caldrà aportar i que serà executable en cas d'impagament. Evidentment, en el moment que finalitzi el contracte, si no hi ha hagut cap impagament, aquest dipòsit es retornarà.<br>
        </p>
        <p>
            L'import de la garantia equival aproximadament al cost d'una factura mensual calculada a partir de l'ús d'energia fet servir l'últim any, aplicant una predicció de preu indexat dels mesos vinents suposant un <strong>escenari de preus elevats</strong> i sense els descomptes provisionals que actualment està aplicant l'Estat.<br>
        </p>
        <p>
            En cas que aquesta proposta no sigui del vostre interès, <strong>us comuniquem la nostra voluntat de no prorrogar automàticament el contracte i resoldre'l a partir del ${object.polissa_id.modcontractual_activa.data_final}</strong>, data en què finalitza el vostre contracte vigent, i sempre d'acord amb el previst a les condicions generals.<br>
        </p>
        <p>
            En aquest cas, caldrà que busqueu una nova comercialitzadora, almenys durant aquest període excepcional de preus alts, i contracteu amb alguna de les empreses <a href="https://www.cnmc.es/ambitos-de-actuacion/energia/mercado-electrico#listados">comercialitzadores existents</a> (a l’enllaç podreu consultar les comercialitzadores que garanteixen el 100% d'energia renovable).<br>
        </p>
        <p>
            En cas de no dur a terme el canvi de comercialitzadora abans de la data de finalització del contracte, el vostre subministrament es traspassarà a la <a href="https://sede.cnmc.gob.es/listado/censo/10">Comercialitzadora de Referència (COR)</a>. Com que es tracta d'un subministrament amb més de 10 kW de potència contractada, la COR aplica unes penalitzacions i és més beneficiós per a vosaltres contractar la llum en el mercat lliure. Adjuntem la <a href="https://www.cnmc.es/ambitos-de-actuacion/energia/guia-informativa-para-el-cambio-de-comercializador-de-electricidad-o-gas">Guia publicada per la CNMC</a> sobre què cal tenir en compte a l'hora de canviar de comercialitzadora, per ajudar-vos en aquesta decisió.<br>
        </p>
        <p>
            En cas que tingueu interès a donar suport a la cooperativa i mantenir el contracte, us farem arribar per correu electrònic els <strong>detalls de la tarifa indexada i l’import de la garantia</strong> que us correspondria ingressar.
        </p>
        <p>
            Lamentem molt aquesta situació. Si voleu conèixer més motius i la resta de <a href="https://blog.somenergia.coop/som-energia/2021/12/noves-mesures-per-fer-front-a-les-tensions-actuals-del-mercat-energetic/">mesures que estem prenen per fer front a les tensions actuals del mercat energètic</a>, podeu llegir aquesta notícia.
        </p>
        <p>
            Estem a la vostra disposició per comentar tots els detalls. Si ho desitgeu, envieu-nos un telèfon i us trucarem tan aviat com puguem.
        </p>
        <p>
            Quedem a l'espera de la vostra resposta.
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
            Os escribimos con una noticia difícil de dar.<br>
        </p>
        <p>
            Tal y como seguramente ya sabéis, en los últimos meses el coste de la electricidad en el mercado mayorista diario ha subido desorbitadamente, situando los precios a más de 400 €/MWh en horas puntuales durante el mes de diciembre. Con la volatilidad actual en el mercado eléctrico, esta situación se podría repetir e incluso se podría superar este precio.<br>
        </p>
        <p>
            Vuestro contrato de electricidad finaliza en breve, y os tenemos que comunicar que <strong>no podemos renovar el contrato ${object.polissa_id.name} amb CUPS ${object.polissa_id.cups.name} con una tarifa a precio fijo,</strong> como el actual. Para la cooperativa no es posible seguir ofreciendo una tarifa fija, incluso con las recientes actualizaciones de tarifa, debido a la volatilidad de los precios actuales, y también al aumento en los costes asociados a la comercialización de energía eléctrica que debemos afrontar: por un lado, la obligación de dipositar un volumen de garantías muy elevado ante el operador del mercado mayorista y, por el otro, el hecho de que debemos avanzar el importe de la compra de la energía (que pagamos semanalmente y facturamos a final de mes), lo que provoca importantes tensiones en la tesorería de la cooperativa. <br>
        </p>
        <p>
            Sin embargo, en caso de seguir interesados en mantener este contrato de electricidad con Som Energia, podemos ofrecer una contratación con <strong>tarifa indexada</strong>, en la que el precio de la electricidad no será fijo sino que variará hora a hora junto con el precio del mercado mayorista. Además, necesitaremos incluir una <strong>garantía en forma de depósito bancario</strong> en la cuenta de Som Energia.<br>
        </p>
        <p>
            Esta garantía no es un aval, sino un depósito que se deberá aportar y que será ejecutable en caso de impago. Evidentemente, en el momento que finalice el contrato, si no ha habido ningún impago, este depósito se devolverá.<br>
        </p>
        <p>
           El importe de la garantía equivale aproximadamente al coste de una factura mensual calculada a partir del uso de energía utilizada el último año, aplicando una predicción de precio indexado de los próximos meses suponiendo un escenario de precios elevados y sin los descuentos provisionales que actualmente está aplicando el estado.<br>
        </p>
        <p>
            En caso de que la propuesta no fuese de vuestro interés, <strong>os comunicamos nuestra voluntad de no prorrogar automáticamente el contrato y resolverlo a partir del ${object.polissa_id.modcontractual_activa.data_final}</strong>, fecha en la que finaliza vuestro contrato vigente, y siempre de acuerdo con lo previsto en las condiciones generales.<br>
        </p>
        <p>
            Es este caso, será necesario que busquéis una nueva comercializadora, al menos durante este período excepcional de precios altos, y contratéis con alguna de las empresas <a href="https://sede.cnmc.gob.es/listado/censo/10">comercializadoras existentes</a> (en el enlace podréis consultar las comercializadoras que garantizan el 100% de energía renovable). <br>
        </p>
        <p>
            En caso de no realizar el cambio de comercializadora antes de la fecha de fin del contrato, vuestro suministro se traspasará a la <a href="https://sede.cnmc.gob.es/listado/censo/10">Comercializadora de Referencia (COR)</a>. Al tratarse de un suministro con más de 10 kW de potencia contratada, la COR aplica unas penalizaciones y es más beneficioso para vosotros contratar la luz en el mercado libre. Adjuntamos la <a href="https://www.cnmc.es/ambitos-de-actuacion/energia/guia-informativa-para-el-cambio-de-comercializador-de-electricidad-o-gas">Guía publicada por la CNMC</a> sobre qué tener en cuenta a la hora de cambiar de comercializadora, para ayudaros en esta decisión.<br>
        </p>
        <p>
            En caso de que tengáis interés en apoyar a la cooperativa y mantener el contrato, os haremos llegar por correo electrónico los <strong>detalles de la tarifa indexada y el importe de la garantía</strong> que os correspondería ingresar.
        </p>
        <p>
            Lamentamos mucho esta situación. Si queréis conocer las motivaciones y el resto de <a href="https://blog.somenergia.coop/som-energia/2021/12/nuevas-medidas-para-hacer-frente-a-las-tensiones-actuales-del-mercado-energetico/">medidas que estamos tomando para hacer frente a la situación del mercado eléctrico</a>, podéis leer esta noticia. <br>
        </p>
        <p>
            Estamos a vuestra disposición para comentar todos los detalles. Si lo deseáis, enviadnos un teléfono y os llamaremos en cuanto podamos.
        </p>
        <p>
            Quedamos a la espera de vuestra respuesta.
        </p>

        Un saludo,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
        <a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
        <a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>
    </body>
</%def>
