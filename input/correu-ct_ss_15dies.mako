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
    nom_titular = ', ' + p_obj.separa_cognoms(
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
    <p>Hola${nom_titular}!</p>
    <p>Ens agrada que formis part de Som Energia.</p>
    <p>Creiem que encara tenim camí per recórrer, encara falta feina per fer, per aconseguir la transformació del model energètic en un de 100% renovable, en mans de la ciutadania. Un futur que tingui comercialitzadores amb qui pots parlar i en qui pots confiar, transparents i que no intentin exprimir-te.</p>
    <p>I creiem que tu <strong>ens hi pots ajudar</strong>. Sigui involucrant-te a algun grup de <a target='_blank' href='https://www.somenergia.coop/ca/cooperativa/grups-locals'>Sòcies Activistes</a>, sigui fent alguna formació, o sigui <strong>simplement associant-te</strong> a Som Energia, <strong>tot suma!</strong></p>
    <p>És per això que no volem dir-te adéu. S’acosta la data de finalització de la situació excepcional en què et trobes, i si no t’associes o vincules el teu contracte a una altra persona sòcia, el teu contracte no es podrà renovar.</p>
    <p class='align-center'><a class='button' target='_blank' href='https://www.somenergia.coop/ca/cooperativa/associar-se'>Sí, vull quedar-me amb Som Energia!</a></p>
    <p class='align-center'><a class='button' target='_blank' href='https://ca.support.somenergia.coop/article/1221-com-vincular-un-contracte-a-una-persona-socia#vincular'>Vull vincular el contracte a una altra persona sòcia</a></p>

    <p><br>Durant aquest any ens has conegut i has vist com som.</p>
    <p><strong>Què t’atura?</strong></p>
    <p>Hi ha alguna cosa que podríem fer, per ajudar-te a prendre la decisió?</p>

    <p>
        <br>Lamentablement, si no t’associes o vincules el teu contracte abans del dia ${data_enviament_cor} <strong>no se’t podrà renovar el contracte d’electricitat</strong>. Aleshores:
        <ul>
        <li>El teu contracte ${object.name} amb la direcció de subministrament ${object.cups.direccio} i CUPS ${object.cups.name} es donarà de baixa amb Som Energia.</li>
        <li>Aquest contracte passarà a estar gestionat per l’empresa comercialitzadora de referència, les pots <a target='_blank' href='https://ca.support.somenergia.coop/article/660-la-comercialitzacio-delectricitat?#referencia'>consultar aquí</a>. Si ho prefereixes, pots gestionar tu un canvi de comercialitzadora i escollir amb quina et vols quedar.</li>
        <li><strong>En cap cas se’t farà cap tall de llum.</strong></li>
        <li>Som Energia et trobarà a faltar. Sempre tindràs les portes obertes per si mai volguessis tornar!</li>
        </ul>
    </p>

    <p><br>Evidentment, si tens qualsevol dubte o pregunta, contacta’ns! Som tot orelles.</p>
    <p>Ens pots respondre aquest mateix correu, o bé ens pots trucar al 872.202.550 (de dilluns a divendres de 9 a 14 h).</p>
    <br>
    <br>
    Atentament,<br>
    <br>
    Som Energia<br>
    <a target='_blank' href="https://www.somenergia.coop/ca">www.somenergia.coop</a><br>
</%def>

<%def name="correu_es()">
    <p>¡Hola${nom_titular}!</p>
    <p>Nos gusta que formes parte de Som Energia.</p>
    <p>Creemos que todavía tenemos camino por recorrer, todavía falta trabajo por hacer, para conseguir la transformación del modelo energético en uno 100% renovable, en manos de la ciudadanía. Un futuro que tenga comercializadoras con quienes puedes hablar y en quienes puedes confiar, transparentes y que no intenten exprimirte.</p>
    <p>Y creemos que tú <strong>nos puedes ayudar</strong>. Sea involucrándote en algún grupo de <a target='_blank' href='https://www.somenergia.coop/es/cooperativa/grupos-locales'>Socias Activistas</a>, sea haciendo alguna formación, o sea <strong>simplemente asociándote</strong> a Som Energia, <strong>¡todo suma!</strong></p>
    <p>Por eso no queremos decirte adiós. Se acerca la fecha de finalización de la situación excepcional en la que te encuentras, y si no te asocias o vinculas tu contrato a otra persona socia, tu contrato no se podrá renovar.</p>
    <p class='align-center'><a class='button' target='_blank' href='https://www.somenergia.coop/es/cooperativa/asociarse'>¡Sí, quiero quedarme en Som Energia!</a></p>
    <p class='align-center'><a class='button' target='_blank' href='https://es.support.somenergia.coop/article/1222-como-vincular-un-contrato-a-una-persona-socia'>Quiero vincular el contrato a otra persona socia</a></p>

    <p><br>Durante este año nos has conocido y has visto cómo somos.</p>
    <p><strong>¿Qué te detiene?</strong></p>
    <p>¿Hay algo que podríamos hacer para ayudarte a tomar la decisión?</p>

    <p>
        <br>Desafortunadamente, si no te asocias o no vinculas tu contrato antes del día ${data_enviament_cor} <strong>no se podrá renovar el contrato de electricidad</strong>. Entonces:
        <ul>
        <li>Tu contrato ${object.name} con la dirección de suministro ${object.cups.direccio} y CUPS ${object.cups.name} se dará de baja con Som Energia.</li>
        <li>Este contrato pasará a estar gestionado por la empresa comercializadora de referencia, las puedes <a target='_blank' href='https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad#referencia'>consultar aquí</a>. Si lo prefieres, puedes gestionar tú un cambio de comercializadora y escoger con cuál te quieres quedar.</li>
        <li><strong>En ningún caso se te hará ningún corte de luz.</strong></li>
        <li>Som Energia te echará de menos. ¡Siempre tendrás las puertas abiertas por si alguna vez quieres volver!</li>
        </ul>
    </p>

    <p><br>Evidentemente, si tienes cualquier duda o pregunta, ¡contáctanos! Te escuchamos.</p>
    <p>Nos puedes responder este mismo correo, o puedes llamarnos al 872.202.550 (de lunes a viernes de 9 a 14 h).</p>
    <br>
    <br>
    Atentamente,<br>
    <br>
    Som Energia<br>
    <a target='_blank' href="https://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
