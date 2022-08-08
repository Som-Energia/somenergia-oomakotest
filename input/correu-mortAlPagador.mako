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
<p>
  Et fem arribar aquest correu perquè hem detectat que les teves dades de
  contacte estan associades a un contracte de subministrament que també té dades
  de contacte d'una altra persona, segons la informació que ens vau fer arribar
  a través del formulari de contractar la llum (també estem enviant aquesta
  notificació a l'altra persona de contacte).
</p>
<p>
  Així doncs, ens consten dades de més d'una persona associades al contracte
  corresponent a l'adreça ${adreca_cups} amb CUPS ${cups_name}, i això podria
  indicar que la persona que fa ús del subministrament elèctric no es
  correspongui amb la persona titular del contracte.&nbsp;
</p>
<p>
  Això seria una irregularitat, segons
  <a
    href="https://www.boe.es/buscar/act.php?id=BOE-A-2000-24019#a79"
    alt="l'article 79.3 del Reial decret 1955/2000"
    >l'article 79.3 del Reial decret 1955/2000</a>, que estableix que "el contracte de subministrament és personal, i el seu
  titular haurà de ser l'efectiu usuari de l'energia".
</p>
<p>
  L'article 83.3 del RD 1955/2000 estableix també que "En els casos en què
  l'usuari efectiu de l'energia o de l'ús efectiu de les xarxes, amb just títol,
  sigui persona diferent al titular que figura en el contracte, podrà exigir,
  sempre que es trobi al corrent del pagament, el canvi al seu nom del contracte
  existent, sense més tràmits".
</p>
<p>
  <strong
    >És necessari, per tant, que la persona usuària efectiva de l'energia
    tramiti el canvi de titularitat del contracte a favor seu a través del
    formulari
    <a
      href="https://oficinavirtual.somenergia.coop/ca/change-ownership/"
      alt=“Canvi de titular”
      >“Canvi de titular”</a
    >
    del nostre web.</strong
  >&nbsp;
</p>
<br />
<p style="text-align:center;">
    <a href="https://oficinavirtual.somenergia.coop/ca/change-ownership/"
        style="background-color: #99A43C;border: none;color: white;padding: 15px 20px;text-align: center;text-decoration: none;display: inline-block;margin: 4px 2px;cursor: pointer;">
        Fes un canvi de titular</a>
</p>
<p><br /></p>
<p>
  <strong
    >En cas que la persona que consta actualment com a titular del contracte
    sigui la persona usuària efectiva del punt de subministrament, necessitem
    que aquesta persona ens confirmi aquesta circumstància</strong
  >
  enviant un correu electrònic a
  <a
    href="mailto:modifica@somenergia.coop"
    alt="modifica@somenergia.coop"
    >modifica@somenergia.coop</a
  ><strong
    > i indicant també el compte bancari on domiciliar el pagament de les
    factures.</strong
  >
  En aquest cas únicament la persona titular del contracte tindrà accés i
  permisos d'ús de l'Oficina Virtual, i serà a qui se li enviarà informació
  (factures, etc.) i qui podrà realitzar modificacions o reclamacions. En cas
  que aquesta duplicitat no es solucioni en el
  <strong>termini d'un mes</strong> des del moment de rebre aquesta comunicació,
  al no donar-se les condicions de contractació que consten a les nostres
  <a
    href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/"
    alt="Condicions Generals"
    >Condicions Generals</a
  >
  (clàusula 1.4), el teu contracte d'electricitat passarà a ser gestionat per
  l'empresa comercialitzadora de referència, que pots consultar
  <a
    href="https://ca.support.somenergia.coop/article/660-la-comercialitzacio-delectricitat?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=catal%C3%A0"
    alt="en aquest enllaç"
    >en aquest enllaç</a
  >. Si ho prefereixes, pots fer un canvi de comercialitzadora i escollir amb
  quina vols estar.&nbsp;
</p>

<p>
  T'agraïm la teva comprensió i quedem a la teva disposició per a qualsevol
  dubte que et pugui sorgir.
</p>
<p>Gràcies i salutacions,&nbsp;</p>
<p><br /></p>
<p>Equip de Som Energia</p>
<p>
  <a href="http://www.somenergia.coop" alt="www.somenergia.coop&nbsp;"
    >www.somenergia.coop&nbsp;</a
  >
</p>

% else:

<p>Buenos días,</p>
<p>
  Te enviamos este correo porque hemos detectado que tus datos de contacto están asociados a un contrato de suministro que también tiene datos de contacto de otra persona, según la información que nos hicisteis llegar a través del formulario de contratar la luz (también estamos enviando esta notificación a la otra persona de contacto).
</p>
<p>
  Así pues, nos constan datos de más de una persona asociados al contrato correspondiente a la dirección ${adreca_cups} con CUPS ${cups_name}, lo que podría indicar que la persona que hace uso del suministro eléctrico no se corresponda con la persona titular del contrato.
</p>
<p>
  Esto sería una irregularidad, según
  <a
    href="https://www.boe.es/buscar/act.php?id=BOE-A-2000-24019#a79"
    alt="el artículo 79.3 del Real Decreto 1955/2000"
    >el artículo 79.3 del Real Decreto 1955/2000</a>, que establece que "el contrato de suministro es personal, y su titular deberá ser el efectivo usuario de la energía".
</p>
<p>
  El artículo 83.3 del RD 1955/2000 establece también que "En los casos en que el usuario efectivo de la energía o del uso efectivo de las redes, con justo título, sea persona distinta a la persona titular que figura en el contrato, podrá exigir, siempre que se encuentre al corriente del pago, el cambio a su nombre del contrato existente, sin más trámites".
</p>
<p>
  <strong>
    Es necesario, por tanto, que la persona usuaria efectiva de la energía tramite el cambio de titularidad del contrato a su favor a través del formulario
    <a
      href="https://oficinavirtual.somenergia.coop/es/change-ownership/"
      alt="Cambio de titular"
      >Cambio de titular</a
    >
    de nuestra web.
  </strong>
</p>
<br />
<p style="text-align:center;">
  <a href="https://oficinavirtual.somenergia.coop/es/change-ownership/"
    style="background-color: #99A43C;border: none;color: white;padding: 15px 20px;text-align: center;text-decoration: none;display: inline-block;margin: 4px 2px;cursor: pointer;">
    Haz un cambio de titular
  </a>
</p>
<br />
<p>
  <strong>
    En caso de que la persona que consta actualmente como titular del contrato sea la persona usuaria efectiva del punto de suministro, necesitamos que esta persona nos confirme esta circunstancia
  </strong>
  enviando un correo electrónico a
  <a
    href="mailto:modifica@somenergia.coop"
    alt="modifica@somenergia.coop">modifica@somenergia.coop</a>,<strong> indicando también la cuenta bancaria donde domiciliar el pago de las facturas</strong>.
  En este caso únicamente la persona titular del contrato tendrá acceso y permisos de uso de la Oficina Virtual, siendo a quien se le enviará información (facturas, etc.) y quien podrá realizar modificaciones o reclamaciones. En caso de que esta duplicidad no se solucione en el&nbsp;
  <strong>plazo de un mes</strong>&nbsp;desde el momento de recibir esta comunicación, al no darse las condiciones de contratación que constan en las nuestras
  <a
    href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/"
    alt="Condiciones Generales"
    >Condiciones Generales
  </a>
  (cláusula 1.4), tu contrato de electricidad pasará a ser gestionado por la empresa comercializadora de referencia, que puedes consultar
  <a
    href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano"
    alt="en este enlace"
    >en este enlace</a
  >. Si lo prefieres, puedes realizar un cambio de comercializadora y escoger con cuál quieres estar.
</p>
<p>
  Te agradecemos tu comprensión y quedamos a tu disposición para cualquier duda que pueda surgirte.
</p>
<p>Gracias y saludos,&nbsp;</p>
<br />
<p>Equipo de Som Energia</p>
<p>
  <a href="http://www.somenergia.coop" alt="www.somenergia.coop"
    >www.somenergia.coop
  </a>
</p>
% endif
<p> ${text_legal}</p>
