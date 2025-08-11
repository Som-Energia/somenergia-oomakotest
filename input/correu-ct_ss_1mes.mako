<%
    from datetime import datetime
    from mako.template import Template
    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
        )
    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

    data_enviament_cor = object.cor_submission_date.strftime('%d/%m/%Y') if object.cor_submission_date else "????"

    p_obj = object.pool.get('res.partner')
    nom_titular = nom_titular =' ' + p_obj.separa_cognoms(
        object._cr, object._uid, object.titular.name
    )['nom'] if not p_obj.vat_es_empresa(object._cr, object._uid, object.titular.vat) else ""
%>

${plantilla_header}

% if object.titular.lang == 'ca_ES':
    ${correu_cat()}
% else:
    ${correu_es()}
% endif

${plantilla_footer}

<%def name="correu_cat()">
    <div class="preheader">S’acaba el termini…</div>

    <p>Hola${nom_titular}!</p>
    <p>Com passa el temps… Ja fa quasi un any que ets a Som Energia!</p>
    <p>Què tal? Com està anant? Has tingut bones (o males) experiències, tenint una comercialitzadora elèctrica que és cooperativa?</p>
    <p>Has fet alguna formació? Has anat a algun acte o xerrada? Has pogut conèixer alguna persona que sigui sòcia?</p>
    <p>Potser simplement has llegit algun correu o algun post a xarxes, i has seguit amb la teva vida, i això també està bé!</p>
    <p>Sigui com sigui, <strong>esperem que estiguis a gust</strong> i que sentis que et tractem bé, en aquesta gran família :)</p>
    <p>A nosaltres ens agrada molt que hi siguis, ja que tot suma i <strong>tothom és important</strong>, perquè</p>
    <p>
        <strong>AIXÒ NO VA DE LLUM</strong>
        <br>Va de transformar el model energètic.
        <br>Va de consum responsable.
        <br>Va de les decisions preses per les persones.
        <br>
        <br>Va de canviar el món.
    </p>
    <p><br>Esperem també que ens hagis pogut conèixer bé, veure què vol dir que siguem una cooperativa sense ànim de lucre, i que hagis pogut comprovar que, a part de comercialitzar energia 100% renovable, apliquem els valors de <strong>transparència</strong> i <strong>sostenibilitat</strong> i, gràcies al suport de més de 86.000 persones i entitats sòcies, treballem cada dia per transformar el model energètic en un de <strong>100% renovable, distribuït, just i en mans de la ciutadania</strong>.</p>
    <p>Com que vas entrar amb un canvi de titularitat, has pogut gaudir d’<strong>un any especial</strong>, amb un contracte d’electricitat sense tenir cap sòcia vinculada.</p>
    <p><strong>Ara, per quedar-te, t’hauries de <a href='https://www.somenergia.coop/ca/fes-te-n-soci-a/'>fer soci/a</a> o bé que una altra persona sòcia t’aculli.</strong></p>
    <p class='align-center'><a class='button' href='https://www.somenergia.coop/ca/fes-te-n-soci-a/'>Em vull associar!</a></p>
    <p>Si coneixes alguna altra persona sòcia, li pots demanar que t’aculli. Això a ella no li implica res, ni es farà responsable ni tindrà informació de cap tema relacionat amb el teu contracte. Simplement hauria de deixar-te el seu número de sòcia i DNI o NIE. I, quan els tinguis, segueixes <a href='https://ca.support.somenergia.coop/article/1221-com-vincular-un-contracte-a-una-persona-socia#vincular'>aquests passos</a>.</p>
    <p>Al nostre Centre d’Ajuda pots veure <strong><a href='https://ca.support.somenergia.coop/article/1221-com-vincular-un-contracte-a-una-persona-socia#vincular'>com vincular el contracte</a> a una altra persona sòcia</strong>.</p>
    <p>I si no coneixes cap altra persona sòcia, pots acostar-te a algun Grup Local o bé escriure’ns a participa@somenergia.coop.</p>
    <p>
        Com ja et vam explicar quan vas entrar, aquesta situació especial només pot durar un any. <strong>Si no t’associes o vincules el teu contracte abans del ${data_enviament_cor}, no se’t podrà renovar el contracte d’electricitat</strong>. Aleshores:
        <ul>
        <li>El teu contracte amb la direcció de subministrament ${object.cups.direccio} es donarà de baixa amb Som Energia.</li>
        <li>Aquest contracte passarà a estar gestionat per l’empresa comercialitzadora de referència, les pots <a href='https://ca.support.somenergia.coop/article/660-la-comercialitzacio-delectricitat?#referencia'>consultar aquí</a>. Si ho prefereixes, pots gestionar tu un canvi de comercialitzadora i escollir amb quina et vols quedar.</li>
        <li><strong>En cap cas se’t farà cap tall de llum.</strong></li>
        <li>Som Energia et trobarà a faltar. Sempre tindràs les portes obertes per si mai volguessis tornar!</li>
        </ul>
    </p>
    <br>
    <br>
    Atentament,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
    <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
</%def>

<%def name="correu_es()">
    <div class="preheader">Se acaba el plazo…</div>

    <p>Hola${nom_titular}!</p>
    <p>Cómo pasa el tiempo… ¡Ya llevas casi un año en Som Energia! </p>
    <p>¿Qué tal? ¿Cómo está yendo? ¿Has tenido buenas (o malas) experiencias, teniendo una comercializadora eléctrica que es cooperativa?</p>
    <p>¿Has realizado alguna formación? ¿Has ido a algún acto o charla? ¿Has podido conocer a alguna persona que sea socia?</p>
    <p>Quizás simplemente has leído algún correo o algún post en redes, y has seguido con tu vida, ¡y eso también está bien!</p>
    <p>Sea como sea, <strong>esperamos que estés a gusto</strong> y que sientas que te tratamos bien, en esta gran familia :)</p>
    <p>A nosotros nos gusta mucho que estés aquí, ya que todo suma y <strong>todo el mundo es importante</strong>, porque</p>
    <p>
        <strong>ESTO NO VA DE LUZ</strong>
        <br>Va de transformar el modelo energético.
        <br>Va de consumo responsable.
        <br>Va sobre las decisiones tomadas por las personas.
        <br>
        <br>Va de cambiar el mundo.
    </p>
    <p><br>Esperamos también que nos hayas podido conocer bien, ver lo que significa que seamos una cooperativa sin ánimo de lucro, y que hayas podido comprobar que, aparte de comercializar energía 100% renovable, aplicamos los valores de <strong>transparencia</strong> y <strong>sostenibilidad</strong> y, gracias al apoyo de más de 86.000 personas y entidades socias, trabajamos cada día para transformar el modelo energético en uno <strong>100% renovable, distribuido, justo y en manos de la ciudadanía</strong>.</p>
    <p>Puesto que entraste con un cambio de titularidad, has podido disfrutar de<strong>un año especial</strong>, con un contrato de electricidad sin tener ninguna socia vinculada.</p>
    <p><strong>Ahora, para quedarte, deberías <a href='https://www.somenergia.coop/es/cooperativa/asociarse'>o bien que otra persona socia te acoja.</strong></p>
    <p class='align-center'><a class='button' href='https://www.somenergia.coop/es/cooperativa/asociarse'>¡Quiero asociarme!</a></p>
    <p>Si conoces a otra persona socia, puedes pedirle que te acoja. Esto a ella no le implica nada, ni se hará responsable ni tendrá información de ningún tema relacionado con tu contrato. Simplemente debería dejarte su número de socia y DNI o NIE. Y, cuando los tengas, sigues <a href='https://es.support.somenergia.coop/article/1222-como-vincular-un-contrato-a-una-persona-socia?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano'>estos pasos</a>.</p>
    <p>En nuestro Centro de Ayuda puedes ver <strong><a href='https://es.support.somenergia.coop/article/1222-como-vincular-un-contrato-a-una-persona-socia?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano'>cómo vincular el contrato</a> a otra persona socia</strong>.</p>
    <p>Y si no conoces a otra persona socia, puedes acercarte a algún Grupo Local o escribirnos a participa@somenergia.coop.</p>
    <p>
        Como ya te contamos cuando entraste, esta situación especial sólo puede durar un año. <strong>Si no asocias ni vinculas tu contrato antes del ${data_enviament_cor}, no se podrá renovar el contrato de electricidad</strong>. Entonces:
        <ul>
        <li>Tu contrato con la dirección de suministro ${object.cups.direccio} se dará de baja con Som Energia.</li>
        <li>Este contrato pasará a estar gestionado por la empresa comercializadora de referencia, las puedes <a href='https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad#referencia'>consultar aquí</a>. Si lo prefieres, puedes gestionar tú un cambio de comercializadora y escoger con cuál te quieres quedar.</li>
        <li><strong>En ningún caso se te hará ningún corte de luz.</strong></li>
        <li>Som Energia te echará de menos. ¡Siempre tendrás las puertas abiertas por si alguna vez quieres volver!</li>
        </ul>
    </p>
    <br>
    <br>
    Atentamente,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
