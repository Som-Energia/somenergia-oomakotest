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

    template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header')[1]
    template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer')[1]
    plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
    plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>

${plantilla_header}

<table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0" role="presentation">
  <tr>
    <td align="center">
      <table class="email-content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
        <tr>
          <td class="email-masthead">
            <table align="center" width="570" cellpadding="0" cellspacing="0" role="presentation" class="header">
              <tr>
                <th>
                  % if object.polissa_id.titular.lang == "ca_ES":
                      <a href="https://www.somenergia.coop/ca/"><img src="https://www.somenergia.coop/logo/Logotip-Som-Energia.png" alt="SOM Energia" style="height: 106px"/></a>
                  %endif
                  % if object.polissa_id.titular.lang != "ca_ES":
                      <a href="https://www.somenergia.coop/es/"><img src="https://www.somenergia.coop/logo/Logotip-Som-Energia.png" alt="SOM Energia" style="height: 106px"/></a>
                  %endif
                </th>
              </tr>
            </table>
          </td>
        </tr>
        <br/>
        <!-- Email Body -->
        <tr>
          <td class="email-body" width="570" cellpadding="0" cellspacing="0">
            <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0" role="presentation">
              <!-- Body content -->
              <tr>
                <td class="content-cell">
                  <div class="f-fallback">
                    % if object.polissa_id.titular.lang == "ca_ES":
                    <p>
                      Benvolgut/da,
                    </p>
                    <p>
                      Volem expressar-te el nostre sincer suport davant els efectes dels recents episodis de pluges torrencials i inundacions. Som conscients de les dificultats que aquesta situació està causant a moltes persones arreu del territori, especialment al País Valencià, Castella-la Manxa i Andalusia.
                    </p>
                    <h3>
                      Quins són els teus drets si t'has vist afectat/da per la DANA?
                    </h3>
                    <ul>
                      <li>
                        Si és impossible garantir el subministrament d'electricitat de manera permanent (per exemple, per danys a la infraestructura o perquè l'habitatge ha quedat inhabitable), <b>no rebràs cap factura posterior al 29 d'octubre.</b> Si per error t'arribés alguna factura després de la DANA, si us plau, posa't en contacte amb nosaltres perquè ho puguem corregir.
                      </li>
                      <li>
                        Quan no es pugui garantir el subministrament d'electricitat i d'accés a la xarxa elèctrica de forma temporal, el contracte quedarà <b>suspès automàticament,</b> i no es generaran factures mentre no disposis de servei elèctric. En cas que rebis una factura posterior al 29 d'octubre, avisa'ns perquè ho puguem revisar.
                      </li>
                      <li>
                        Si, malgrat tenir subministrament elèctric, <b>no pots viure temporalment al teu domicili a causa dels efectes de la DANA</b> (entenem que és per motius tècnics, personals o altres), tens dret a sol·licitar la suspensió temporal del contracte. Això implica que no <b>es generaran factures mentre el contracte estigui suspès.</b> ATENCIÓ, en aquest cas, <b>cal que ens avisis</b> per activar aquesta mesura i confirmar la situació.
                      </li>
                    </ul>
                    <p>
                      En qualsevol cas, tens dret a donar de baixa el punt de subministrament i a canviar de comercialitzadora <b>sense cap cost.</b> I també podràs ajustar la <a href="https://ca.support.somenergia.coop/article/269-com-puc-saber-la-potencia-que-necessito">potència contractada</a> per adaptar-la a la nova situació <b>sense càrrec,</b> sempre i quan compleixis els requisits del Reial Decret llei  7/2024.
                    </p>
                    <p>
                      Trobaràs més detalls sobre els teus drets al <a href="https://www.boe.es/buscar/pdf/2024/BOE-A-2024-22928-consolidado.pdf">Reial decret llei 6/2024</a>, concretament als articles 46, 47 i 48,  i en especial  al <a href="https://www.boe.es/buscar/pdf/2024/BOE-A-2024-23422-consolidado.pdf">Reial Decret llei  7/2024</a>, concretament als articles 2, 4, 6 i 9 que parlen de les mesures adoptades en matèria d'energia.
                    </p>
                    <h3>
                      Què estem fent des de Som Energia?
                    </h3>
                    <p>
                      Davant d'aquesta situació excepcional, a part d'aplicar les mesures legals, hem decidit <b>aplicar el nostre protocol de catàstrofe natural de manera proactiva.</b> Això significa que <b>no cobrarem de manera automàtica la facturació del consum corresponent a l'última factura, o sigui, el mes abans de la DANA. Som Energia assumirà aquesta despesa.</b>
                    </p>
                    <p>
                      A més a més:
                    </p>
                    <ul>
                      <li>
                        Donarem més flexibilitat en els terminis de pagament.
                      </li>
                      <li>
                        No efectuarem cap tall de subministrament per impagament.
                      </li>
                      <li>
                        Donem l'opció de sol·licitar un assessorament personalitzat per gestionar el teu contracte durant aquesta situació, com per exemple si necessiteu canviar la potència contractada o canviar de tarifa.
                      </li>
                    </ul>
                    <p>
                      Si coneixes alguna persona sòcia de Som Energia que ha estat afectada i no ha rebut aquest comunicat, anima-la a contactar amb nosaltres i revisarem la seva situació per si podem incloure-la en aquestes mesures.
                    </p>
                    <h4>
                      Mesures específiques adoptades des de Som Energia per a instal·lacions d'autoconsum
                    </h4>
                    <p>
                      Per protegir-te econòmicament en aquests moments difícils:
                    </p>
                    <ul>
                      <li>
                        Podràs desactivar temporalment el servei del <a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar?utm_source=linkidiomes&utm_medium=cda&utm_campaign=catal%C3%A0">Flux Solar</a> i l'aplicació de Sols, perquè no se't descomptin en la teva facturació de manera automàtica. Només cal que et posis en contacte amb nosaltres. Podràs activar-lo de nou quan ho consideris oportú.
                      </li>
                    </ul>
                    <h3>
                      Com pots contactar amb nosaltres?
                    </h3>
                    <p>
                      Estem al teu costat pel que necessitis, per això et recordem com ho pots fer:
                    </p>
                    <ul>
                      <li>Correu electrònic: <a href="mailto:info@somenergia.coop">info@somenergia.coop</a></li>
                      <li>Telèfon d'atenció: de dilluns a divendres de 9 a 14 h, al <a href="tel:872 202 550">872 202 550</a> o <a href="tel:900 103 605">900 103 605</a></li>
                    </ul>
                    <p>
                      Trobaràs més informació sobre el teu contracte a l'<a href="https://oficinavirtual.somenergia.coop">Oficina Virtual</a>.
                    </p>
                    <p>
                      El nostre equip està preparat per atendre les teves necessitats energètiques específiques i acompanyar-te en tot el procés.
                    </p>
                    <p>
                      Una cordial salutació,
                    </p>
                    <p>
                      L'equip de Som Energia 💚
                    </p>
                    %endif
                    % if object.polissa_id.titular.lang != "ca_ES":
                      <p>
                        Bienvenido/a,
                      </p>
                      <p>
                        Queremos expresarte nuestro sincero apoyo frente a los efectos de los recientes episodios de lluvias torrenciales e inundaciones. Somos conscientes de las dificultades que esta situación está causando a muchas personas en todo el territorio, especialmente en la País Valencià, Castilla-La Mancha y Andalucía.
                      </p>
                      <h3>
                        ¿Cuáles son tus derechos si te has visto afectado/a por la DANA?
                      </h3>
                      <ul>
                        <li>
                          Si es imposible garantizar el suministro de electricidad de forma permanente (por ejemplo, por daños en la infraestructura o porque la vivienda ha quedado inhabitable), <b>no recibirás ninguna factura posterior al 29 de octubre.</b> Si por error te llegara alguna factura después de la DANA, por favor, ponte en contacto con nosotros para que podamos corregirlo.
                        </li>
                        <li>
                          Cuando no se pueda garantizar el suministro de electricidad y de acceso a la red eléctrica de forma temporal, el contrato quedará <b>suspendido automáticamente,</b> y no se generarán facturas mientras no dispongas de servicio eléctrico. En caso de que recibas una factura posterior al 29 de octubre, avísanos para que lo podamos revisar.
                        </li>
                        <li>
                          Si, a pesar de tener suministro eléctrico, <b>no puedes vivir temporalmente en tu domicilio debido a los efectos de la DANA</b> (entendemos que es por motivos técnicos, personales u otros), tienes derecho a solicitar la suspensión temporal del contrato. Esto implica que <b>no se generarán facturas mientras el contrato esté suspendido.</b> ATENCIÓN, en este caso, <b>debes avisarnos</b> para activar esta medida y confirmar la situación.
                        </li>
                      </ul>
                      <p>
                        En cualquier caso, tienes derecho a dar de baja el punto de suministro y a cambiar de comercializadora <b>sin coste alguno.</b> Y también podrás ajustar la <a href="https://es.support.somenergia.coop/article/282-como-puedo-saber-la-potencia-que-necesito?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">potencia contratada</a> para adaptarla a la nueva situación <b>sin cargo,</b> siempre y cuando cumplas los requisitos del Real Decreto ley 7/2024.
                      </p>
                      <p>
                        Encontrarás más detalles sobre tus derechos en el <a href="https://www.boe.es/buscar/pdf/2024/BOE-A-2024-22928-consolidado.pdf">Real decreto ley 6/2024</a>, concretamente en los artículos 46, 47 y 48, y en especial en el <a href="https://www.boe.es/buscar/pdf/2024/BOE-A-2024-23422-consolidado.pdf">Real Decreto ley 7/2024</a>, concretamente en los artículos 2, 4, 6 y 9 que hablan de las medidas adoptadas en materia de energía.
                      </p>
                      <h3>
                        ¿Qué estamos haciendo desde Som Energia?
                      </h3>
                      <p>
                        Ante esta situación excepcional, aparte de aplicar las medidas legales, hemos decidido <b>aplicar nuestro protocolo de catástrofe natural de forma proactiva. Esto significa que no cobraremos de forma automática la facturación del consumo correspondiente a la última factura, o sea, el mes antes de la DANA. Som Energia asumirá este gasto.</b>
                      </p>
                      <p>
                        Además:
                      </p>
                      <ul>
                        <li>
                          Daremos más flexibilidad en los plazos de pago.
                        </li>
                        <li>
                          No efectuaremos ningún corte de suministro por impago.
                        </li>
                        <li>
                          Damos la opción de solicitar un asesoramiento personalizado para gestionar tu contrato durante esta situación, como por ejemplo si necesitas cambiar la potencia contratada o cambiar de tarifa.
                        </li>
                      </ul>
                      <p>
                        Si conoces a alguna persona socia de Som Energia que ha sido afectada y no ha recibido este comunicado, anímala a contactar con nosotros y revisaremos su situación por si podemos incluirla en estas medidas.
                      </p>
                      <h4>
                        Medidas específicas adoptadas desde Som Energia para instalaciones de autoconsumo
                      </h4>
                      <p>
                        Para protegerte económicamente en estos momentos difíciles:
                      </p>
                      <ul>
                        <li>
                          Podrás desactivar temporalmente el servicio del <a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">Flux solar</a> y la aplicación de Sols, para que no se te descuenten en tu facturación de forma automática. Solo tienes que ponerte en contacto con nosotros. Podrás activarlo de nuevo cuando lo consideres oportuno.
                        </li>
                      </ul>
                      <h3>
                        ¿Cómo puedes contactar con nosotros?
                      </h3>
                      <p>
                        Estamos a tu lado para lo que necesites, por eso te recordamos cómo puedes hacerlo:
                      </p>
                      <ul>
                        <li>Correo electrónico: <a href="mailto:info@somenergia.coop">info@somenergia.coop</a> </li>
                        <li>Teléfono de atención: de lunes a viernes de 9 a 14 h, en el <a href="tel:872 202 550">872 202 550</a> o <a href="tel:900 103 605">900 103 605</a></li>
                      </ul>
                      <p>
                        Encontrarás más información sobre tu contrato en la <a href="https://oficinavirtual.somenergia.coop/es/">Oficina Virtual</a>.
                      </p>
                      <p>
                        Nuestro equipo está preparado para atender tus necesidades energéticas específicas y acompañarte en todo el proceso.
                      </p>
                      <p>
                        Un cordial saludo,
                      </p>
                      <p>
                        El equipo de Som Energia 💚
                      </p>
                    %endif
                    <p></p>
                  </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>



${plantilla_footer}