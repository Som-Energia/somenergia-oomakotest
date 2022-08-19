<%
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
    cups_name = object.polissa_id.cups.name
    adreca_cups = object.polissa_id.cups_direccio

%>

% if object.polissa_id.titular.lang != "es_ES":
<p>Bon dia,</p>
<br>
<p>Et fem arribar aquest correu perquè hem detectat que les teves dades de contacte estan associades a un contracte de subministrament que també té dades de contacte d'una altra persona, segons la informació que ens vau fer arribar a través del formulari de contractar la llum (també estem enviant aquesta notificació a l'altra persona de contacte).</p>
<br>
<p>Potser no n'estàs al corrent; no passa res, a continuació t'expliquem de què es tracta i com es pot resoldre.</p>
<br>
<p>Primer de tot, recorda que estem parlant d'una irregularitat amb el contracte: no té res a veure amb el número de soci/a o amb el fet que estigui vinculat a una altra persona sòcia.</p>
<br>
<p>El cas és que a la nostra base de dades, el contracte corresponent a l'adreça ${adreca_cups} amb CUPS ${cups_name} té associades dades de més d'una persona, i això podria indicar que la persona que fa ús del subministrament elèctric no es correspongui amb la persona titular del contracte.</p>
<br>
<p>Això seria una irregularitat, segons <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2000-24019#a79" alt="l'article 79.3 del Reial decret 1955/2000">l'article 79.3 del Reial decret 1955/2000</a>, que estableix que "el contracte de subministrament és personal, i el seu titular haurà de ser l'efectiu usuari de l'energia".</p>
<br>
<p>És necessari, per tant, que <strong>la persona usuària efectiva de l'energia tramiti el canvi de titularitat del contracte a favor seu a través del formulari <a href="https://oficinavirtual.somenergia.coop/ca/change-ownership/" alt="Canvi de titular">Canvi de titular</a> del nostre web.</strong></p>
<br>
<p style="text-align:center;"><a href="https://oficinavirtual.somenergia.coop/ca/change-ownership/" style="font-size: 14px;background-color: #99A43C;border: none;color: white;padding: 15px 20px;text-align: center;text-decoration: none;display: inline-block;margin: 4px 2px;cursor: pointer;">Fes un canvi de titular</a></p>
<br>
<p><strong>En cas que la persona que consta actualment com a titular del contracte sigui la persona usuària efectiva del punt de subministrament, necessitem que aquesta persona ens confirmi aquesta circumstància responent aquest correu i indicant també el compte bancari on domiciliar el pagament de les factures.</strong>
En aquest cas únicament la persona titular del contracte tindrà accés i permisos d'ús de l'Oficina Virtual, i serà a qui se li enviarà informació (factures, etc.) i qui podrà realitzar modificacions o reclamacions.</p>
<br>
<p>En cas que aquesta duplicitat no es solucioni en el <strong>termini d'un mes</strong> des del moment de rebre aquesta comunicació, al no donar-se les condicions de contractació que consten a les nostres <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/" alt="Condicions Generals">Condicions Generals</a> (clàusula 1.4), aquest contracte d'electricitat passarà a ser gestionat per l'empresa comercialitzadora de referència, que pots consultar <a href="https://ca.support.somenergia.coop/article/660-la-comercialitzacio-delectricitat?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=catal%C3%A0" alt="en aquest enllaç">en aquest enllaç</a>. Si ho prefereixes, pots fer un canvi de comercialitzadora i escollir amb quina vols estar.</p>
<br>
<p>T'agraïm la teva comprensió i quedem a la teva disposició per a qualsevol dubte que et pugui sorgir.</p>
<br>
<p>Gràcies i salutacions,</p>
<br>
<p>Equip de Som Energia</p>
<p><a href="http://www.somenergia.coop" alt="www.somenergia.coop">www.somenergia.coop</a></p>

% else:

<p>Buenos días,</p>
<br>
<p>Te enviamos este correo porque hemos detectado que tus datos de contacto están asociados a un contrato de suministro que también tiene datos de contacto de otra persona, según la información que nos hicisteis llegar a través del formulario de contratar la luz (también estamos enviando esta notificación a la otra persona de contacto).</p>
<br>
<p>Quizás no estás al corriente; no pasa nada, a continuación te explicamos de qué se trata y cómo se puede resolver.</p>
<br>
<p>Ante todo, recuerda que estamos hablando de una irregularidad con el contrato: nada tiene que ver con el número de socio/a o en si está vinculado a otra persona socia.</p>
<br>
<p>El caso es que en nuestra base de datos, el contrato correspondiente a la dirección ${adreca_cups} con CUPS ${cups_name} tiene asociados datos de más de una persona, lo que podría indicar que la persona que hace uso del suministro eléctrico no se corresponda con la persona titular del contrato.</p>
<br>
<p>Esto sería una irregularidad, según <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2000-24019#a79" alt="el artículo 79.3 del Real Decreto 1955/2000">el artículo 79.3 del Real Decreto 1955/2000</a>, que establece que "el contrato de suministro es personal, y su titular deberá ser el efectivo usuario de la energía".</p>
<br>
<p>Es necesario, por tanto, que <strong>la persona usuaria efectiva de la energía tramite el cambio de titularidad del contrato a su favor</strong> a través del formulario <a href="https://oficinavirtual.somenergia.coop/es/change-ownership/" alt="Cambio de titular">Cambio de titular</a> de nuestra web.</p>
<br>
<p style="text-align:center;"><a href="https://oficinavirtual.somenergia.coop/es/change-ownership/" style="font-size: 14px;background-color: #99A43C;border: none;color: white;padding: 15px 20px;text-align: center;text-decoration: none;display: inline-block;margin: 4px 2px;cursor: pointer;">Haz un cambio de titular</a></p>
<br>
<p><strong>En caso de que la persona que consta actualmente como titular del contrato sea la persona usuaria efectiva del punto de suministro, necesitamos que esta persona nos confirme esta circunstancia respondiendo este correo e indicando también la cuenta bancaria donde domiciliar el pago de las facturas.</strong> En este caso únicamente la persona titular del contrato tendrá acceso y permisos de uso de la Oficina Virtual, siendo a quien se le enviará información (facturas, etc.) y quien podrá realizar modificaciones o reclamaciones.</p>
<br>
<p>En caso de que esta duplicidad no se solucione en el <strong>plazo de un mes</strong> desde el momento de recibir esta comunicación, al no darse las condiciones de contratación que constan en nuestras <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/" alt="Condiciones Generales">Condiciones Generales</a> (cláusula 1.4), este contrato de electricidad pasará a ser gestionado por la empresa comercializadora de referencia, que puedes consultar <a href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano" alt="en este enlace">en este enlace</a>. Si lo prefieres, puedes realizar un cambio de comercializadora y escoger con cuál quieres estar.</p>
<br>
<p>Te agradecemos tu comprensión y quedamos a tu disposición para cualquier duda que pueda surgirte.</p>
<br>
<p>Gracias y saludos,&nbsp;</p>
<br>
<p>Equipo de Som Energia</p>
<p><a href="http://www.somenergia.coop" alt="www.somenergia.coop">www.somenergia.coop</a></p>
% endif

<p> ${text_legal}</p>