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
            nom_titular = ' ' + object.polissa_id.titular.name.split(',')[1].lstrip()
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
            Tal com segurament ja sabeu, fa molts mesos que el mercat majorista diari de l'electricitat està a preus molt elevats, amb fortes oscil·lacions i alta volatilitat, una nova realitat a la qual ens hem hagut d’adaptar a la cooperativa.
        </p>
        <br>
        <p>
            En aquest sentit, no ens és possible seguir oferint una tarifa de preus fixos per contractes amb un ús energètic elevat, com el vostre, i us hem de comunicar que <strong>no podem renovar el contracte ${object.polissa_id.name} amb CUPS ${object.polissa_id.cups.name} amb una tarifa de preus fixos </strong>, com teniu ara.
        </p>
        <br>
        <p>
            Per tal de renovar el contracte, <strong>us proposem una contractació amb tarifa indexada</strong>, en què el preu de l'electricitat no serà fix sinó que variarà hora a hora en funció del preu del mercat majorista.
        </p>
        <br>
        <p>
            En cas que aquesta proposta no sigui del vostre interès,<strong> us comuniquem la nostra voluntat de no prorrogar automàticament el contracte i resoldre'l a partir del ${object.polissa_id.modcontractual_activa.data_final}</strong>, data en què finalitza el contracte vigent, i sempre d'acord amb el previst a les condicions generals.
        </p>
        <br>
        <p>
            En aquest cas, caldrà que busqueu una nova comercialitzadora, almenys durant aquest període excepcional de preus alts, i contracteu amb alguna de les empreses <a href="https://sede.cnmc.gob.es/listado/censo/2">comercialitzadores existents</a> (a l’enllaç podreu consultar les comercialitzadores que garanteixen el 100% d'energia renovable).
        </p>
        <br>
        <p>
            En cas de no dur a terme el canvi de comercialitzadora abans de la data de finalització del contracte, el vostre subministrament es traspassarà a la <a href="https://sede.cnmc.gob.es/listado/censo/10">Comercialitzadora de Referència (COR)</a>. Com que es tracta d'un subministrament amb més de 10 kW de potència contractada, la COR aplica unes penalitzacions i és més beneficiós per a vosaltres contractar la llum en el mercat lliure. Adjuntem la <a href="https://www.cnmc.es/ambitos-de-actuacion/energia/guia-informativa-para-el-cambio-de-comercializador-de-electricidad-o-gas">Guia publicada per la CNMC</a> sobre què cal tenir en compte a l'hora de canviar de comercialitzadora, per ajudar-vos en aquesta decisió.
        </p>
        <br>
        <p>
            En cas que tingueu interès a donar suport a la cooperativa i mantenir el contracte, us farem arribar per correu electrònic els <strong>detalls de la tarifa indexada</strong>.
        </p>
        <br>
        <p>
            Lamentem molt aquesta situació. Si voleu conèixer més motius i la resta de <a href="https://blog.somenergia.coop/som-energia/2021/12/noves-mesures-per-fer-front-a-les-tensions-actuals-del-mercat-energetic/">mesures que estem prenent per fer front a les tensions actuals del mercat energètic</a>, podeu llegir aquesta notícia.
        </p>
        <br>
        <p>
            Estem a la vostra disposició per comentar tots els detalls. Si ho desitgeu, envieu-nos un telèfon i us trucarem tan aviat com puguem.
        </p>
        <br>
        <p>
            Quedem a l'espera de la vostra resposta.
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
            Tal y como seguramente ya sabéis, hace muchos meses que el mercado mayorista diario de electricidad está a precios muy elevados, con fuertes oscilaciones y una volatilidad alta, una nueva realidad a la que hemos tenido que adaptarnos en la cooperativa.
        </p>
        <br>
        <p>
            En este sentido, no podemos seguir ofreciendo una tarifa de precios fijos para contratos con un uso energético elevado, como el vuestro, y os tenemos que comunicar que <strong>no podemos renovar el contrato ${object.polissa_id.name} con CUPS ${object.polissa_id.cups.name} con una tarifa de precios fijos</strong>, como la que tenéis actualmente.
        </p>
        <br>
        <p>
            Para la renovación, <strong>os proponemos una contratación con tarifa indexada</strong>, en la que el precio de la electricidad no será fijo, sino que variará hora a hora en función del precio del mercado mayorista.
        </p>
        <br>
        <p>
            En caso de que la propuesta no fuese de vuestro interés, <strong>os comunicamos nuestra voluntad de no prorrogar automáticamente el contrato y resolverlo a partir del ${object.polissa_id.modcontractual_activa.data_final}</strong>, fecha en la que finaliza vuestro contrato vigente, y siempre de acuerdo con lo previsto en las condiciones generales.
        </p>
        <br>
        <p>
            Es este caso, será necesario que busquéis una nueva comercializadora, al menos durante este período excepcional de precios altos, y contratéis con alguna de las empresas <a href="https://sede.cnmc.gob.es/listado/censo/2">comercializadoras existentes</a> (en el enlace podréis consultar las comercializadoras que garantizan el 100% de energía renovable).
        </p>
        <br>
        <p>
            En caso de no realizar el cambio de comercializadora antes de la fecha de fin del contrato, vuestro suministro se traspasará a la <a href="https://sede.cnmc.gob.es/listado/censo/10">Comercializadora de Referencia (COR)</a>. Al tratarse de un suministro con más de 10 kW de potencia contratada, la COR aplica unas penalizaciones y es más beneficioso para vosotros contratar la luz en el mercado libre. Adjuntamos la <a href="https://www.cnmc.es/ambitos-de-actuacion/energia/guia-informativa-para-el-cambio-de-comercializador-de-electricidad-o-gas">Guía publicada por la CNMC</a> sobre qué tener en cuenta a la hora de cambiar de comercializadora, para ayudaros en esta decisión.
        </p>
        <br>
        <p>
            En caso de que tengáis interés en apoyar a la cooperativa y mantener el contrato, os haremos llegar por correo electrónico los <strong>detalles de la tarifa indexada</strong>.
        </p>
        <p>
            Lamentamos mucho esta situación. Si queréis conocer las motivaciones y el resto de <a href="https://blog.somenergia.coop/som-energia/2021/12/nuevas-medidas-para-hacer-frente-a-las-tensiones-actuales-del-mercado-energetico/">medidas que estamos tomando para hacer frente a la situación del mercado eléctrico</a>, podéis leer esta noticia.
        </p>
        <br>
        <p>
            Estamos a vuestra disposición para comentar todos los detalles. Si lo deseáis, enviadnos un teléfono y os llamaremos en cuanto podamos.
        </p>
        <br>
        <p>
            Quedamos a la espera de vuestra respuesta.
        </p>
        <br>

        Un saludo,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
        <a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
        <a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>
    </body>
</%def>
