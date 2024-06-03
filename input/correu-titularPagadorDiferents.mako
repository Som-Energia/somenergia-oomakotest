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
<p>Et fem arribar aquest correu perquè hem detectat que el contracte corresponent a l'adreça ${adreca_cups}  amb CUPS ${cups_name} té associades <strong>dades de més d'una persona</strong>, i això podria indicar que la persona que fa ús del subministrament elèctric no es correspongui amb la persona titular del contracte.</p>
<p>Això seria una irregularitat, segons <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2000-24019#a79" alt="l'article 79.3 del Reial decret 1955/2000">l'article 79.3 del Reial decret 1955/2000</a>, que estableix que "el contracte de subministrament és personal, i el seu titular haurà de ser l'efectiu usuari de l'energia".</p>
<p>Per tal de resoldre la situació, caldrà que realitzeu una d'aquestes dues accions:</p>
<p><strong>Si la persona que consta com a pagadora del contracte</strong> és la persona usuària efectiva de l'energia, serà necessari que tramiti el canvi de titularitat del contracte a favor seu a través del formulari <a href="https://oficinavirtual.somenergia.coop/ca/change-ownership/" alt="Canvi de titular">Canvi de titular</a> del nostre web.</p>
<br>
<p style="text-align:center;"><a href="https://oficinavirtual.somenergia.coop/ca/change-ownership/" style="font-size: 14px;background-color: #99A43C;border: none;color: white;padding: 15px 20px;text-align: center;text-decoration: none;display: inline-block;margin: 4px 2px;cursor: pointer;">Fes un canvi de titular</a></p>
<br>
<p><strong>En cas que la persona que consta actualment com a titular del contracte</strong> sigui la persona usuària efectiva del punt de subministrament, necessitem que aquesta persona ens respongui el correu i ens confirmi el compte bancari on domiciliar el pagament de les factures. En aquest cas únicament la persona titular del contracte tindrà accés i permisos d'ús de l'Oficina Virtual, i serà a qui se li enviarà informació (factures, etc.) i qui podrà realitzar modificacions o reclamacions.</p>
<p>T'agraïm la teva comprensió i quedem a la teva disposició per a qualsevol dubte que et pugui sorgir.</p>
<p>Gràcies i salutacions,</p>
<p>Equip de Som Energia</p>
<p><a href="http://www.somenergia.coop" alt="www.somenergia.coop">www.somenergia.coop</a></p>

% else:

<p>Buenos días,</p>
<p>Te enviamos este correo porque hemos detectado que el contrato correspondiente a la dirección ${adreca_cups} con CUPS ${cups_name} tiene asociados <strong>datos de más de una persona</strong>, lo que podría indicar que la persona que hace uso del suministro eléctrico no se corresponda con la persona titular del contrato.</p>
<p>Esto sería una irregularidad, según <a href="https://www.boe.es/buscar/act.php?id=BOE-A-2000-24019#a79" alt="el artículo 79.3 del Real Decreto 1955/2000">el artículo 79.3 del Real Decreto 1955/2000</a>, que establece que "el contrato de suministro es personal, y su titular deberá ser el efectivo usuario de la energía".</p>
<p>Para resolver la situación, deberéis realizar una de estas dos acciones:</p>
<p><strong>Si la persona que consta como pagadora del contrato</strong> es la persona usuaria efectiva de la energía, es necesario que tramite el cambio de titularidad del contrato a su favor a través del formulario <a href="https://oficinavirtual.somenergia.coop/es/change-ownership/" alt="Cambio de titular">Cambio de titular</a> de nuestra web.</p>
<br>
<p style="text-align:center;"><a href="https://oficinavirtual.somenergia.coop/es/change-ownership/" style="font-size: 14px;background-color: #99A43C;border: none;color: white;padding: 15px 20px;text-align: center;text-decoration: none;display: inline-block;margin: 4px 2px;cursor: pointer;">Haz un cambio de titular</a></p>
<br>
<p><strong>En caso de que la persona que consta actualmente como titular del contrato</strong> sea la persona usuaria efectiva del punto de suministro, necesitamos que esta persona responda el correo y nos confirme la cuenta bancaria donde domiciliar el pago de las facturas. En este caso únicamente la persona titular del contrato tendrá acceso y permisos de uso de la Oficina Virtual, siendo a quien se le enviará información (facturas, etc.) y quien podrá realizar modificaciones o reclamaciones.</p>
<p>Te agradecemos tu comprensión y quedamos a tu disposición para cualquier duda que pueda surgirte.</p>
<p>Gracias y saludos,</p>
<p>Equipo de Som Energia</p>
<p><a href="http://www.somenergia.coop" alt="www.somenergia.coop">www.somenergia.coop</a></p>
% endif

<p> ${text_legal}</p>