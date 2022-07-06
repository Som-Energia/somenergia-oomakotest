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
            El govern espanyol ha aprovat recentment que l’IVA de l’electricitat serà del 5% per als contractes de fins a 10 kW de potència contractada (la majoria de domèstics), en les mateixes condicions en què hi havia la rebaixa de l’IVA al 10%. La mesura és vigent des de l’1 de juliol i fins al 31 de desembre d’enguany. Per altra banda, l’impost elèctric (IE) del 0,5% es prorroga també fins al 31 de desembre.
        </p>
        <br>
        <p>
            Així doncs, això rebaixa lleugerament els preus finals de les tarifes de Som Energia. En donem més detalls a <a href="https://blog.somenergia.coop/?p=42759">aquesta notícia del blog</a>, i pots veure quins són els preus amb i sense impostos a l’<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/">apartat de tarifes</a> del web. Si vols fer-ne comparacions, pots accedir a l’<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha els preus vigents en períodes anteriors.
        </p>
        <br>
        <p>
            Si, per alguna raó, aquest canvi de preus et fes replantejar la teva pertinença a la cooperativa, podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia de finalització del contracte, amb els preus vigents a cada moment.
        </p>
        <br>
        <p>
            Estem a la teva disposició per a qualsevol dubte. Et demanem que, en cas que en tinguis, ens escriguis un correu a info@somenergia.coop.
        </p>
        <br>
        Una salutació cordial,,<br>
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
            El gobierno español ha aprobado recientemente que el IVA de la electricidad será del 5% para los contratos de hasta 10 kW de potencia contratada (la mayoría de domésticos), en las mismas condiciones que había con la rebaja del IVA al 10%. La medida está vigente desde el 1 de julio y hasta el 31 de diciembre de este año. Por su parte, el impuesto eléctrico (IE) del 0,5% se prorroga también hasta el 31 de diciembre.
        </p>
        <br>
        <p>
            Así pues, eso rebaja ligeramente los precios finales de las tarifas de Som Energia. Damos más detalles en <a href="https://blog.somenergia.coop/?p=42761">esta noticia del blog</a>, y puedes ver cuáles son los precios con y sin impuestos en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">apartado de tarifas</a> de la web. Si quieres hacer comparaciones, puedes acceder al  <a href="https://www.somenergia.coop/es/tarifas-de-electricidad/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde hay los precios vigentes en periodos anteriores.
        </p>
        <br>
        <p>
            Si, por alguna razón, este cambio de precios te hiciera replantear tu pertenencia a la cooperativa, podrías dar de baja tu contrato con Som Energia, bien comunicándonoslo directamente, o mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día de finalización del contrato, con los precios vigentes en cada momento.
        </p>
        <br>
        <p>
            Estamos a tu disposición para cualquier duda. Te pedimos que, en caso de que las tengas, nos escribas un correo a info@somenergia.coop.
        </p>
        <br>
        Un saludo cordial,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="http://ca.support.somenergia.coop/">Suport</a> / <a href="http://es.support.somenergia.coop/">Ayuda</a> / <a href="http://eu.support.somenergia.coop/">Laguntza</a> / <a href="http://gl.support.somenergia.coop/">Axuda<br>
        <a href="https://www.facebook.com/somenergia">Facebook</a> - <a href="https://twitter.com/SomEnergia">Twitter</a> - <a href="https://www.youtube.com/SomEnergia">Youtube</a><br>
        <a href="http://www.somenergia.coop/es">Web</a> - <a href="http://blog.somenergia.coop/">Blog</a> - <a href="https://t.me/somenergia">Telegram</a><br>
    </body>
</%def>
