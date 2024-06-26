<%
    from mako.template import Template

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )
%>
<%
    polissa = object.cups_polissa_id

    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    template_id = md_obj.get_object_reference(
                        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_legal_footer'
                    )[1]

    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        object
    )
    p_obj = object.pool.get('res.partner')
    nom_titular = ' {}'.format(p_obj.separa_cognoms(
        object._cr, object._uid, polissa.titular.name
    )['nom']) if not object.vat_enterprise() else ''
    cups = polissa.cups.name
    adreca = polissa.cups_direccio

%>

    % if object.cups_polissa_id.titular.lang == "ca_ES":
<p>${correu_cat()}</p>
    % else:
<p>${correu_es()}</p>
    % endif
<p>${text_legal}</p>
<%def name="correu_cat()">
<p dir="ltr">Hola ${nom_titular},</p>
<p dir="ltr">L'empresa de distribuci&oacute; el&egrave;ctrica de la teva zona ens comunica que existeix una instal&middot;laci&oacute; d'autoproducci&oacute; associada al punt de subministrament amb codi CUPS ${cups} corresponent a l'adre&ccedil;a ${adreca}.</p>
<p dir="ltr">En el teu cas, ens informen tamb&eacute;, que el titular de la instal&middot;laci&oacute; generadora &eacute;s una altra persona.&nbsp;</p>
<p dir="ltr"><span style="text-decoration: underline;">Li hem enviat un correu electr&ograve;nic a la persona titular de la instal&middot;laci&oacute;</span> a l&rsquo;adre&ccedil;a electr&ograve;nica indicada en el registre de la comunitat aut&ograve;noma. Per confirmar que us arriba la informaci&oacute; relacionada amb la protecci&oacute; de dades, tamb&eacute; us la fem arribar a continuaci&oacute;:</p>
<p dir="ltr">INFORMACI&Oacute; DE PROTECCI&Oacute; DE DADES DE SOM ENERGIA</p>
<p dir="ltr"><strong>Responsabilitats:</strong> SOM ENERGIA, SCCL. (F55091367), C / Pic de Peguera, 11, 17003 de Girona, <span style="color: rgb(0, 0, 0);">somenergia@delegado-datos.com</span>. <strong>Finalitats:</strong> Tramitar l'alta de l'autoconsum associat a la seva instal&middot;laci&oacute;. <strong>Legitimaci&oacute;:</strong> Acord de serveis amb el titular de la instal&middot;laci&oacute; fotovoltaica o normativa vigent. <strong>Destinataris:</strong> No estan previstes cessions, tret entre el client, el titular de la instal&middot;laci&oacute; i Som Energia i, les legalment previstes. <strong>Drets:</strong> Pot retirar el seu consentiment en qualsevol moment, aix&iacute; com accedir, rectificar, suprimir les seves dades i altres drets a somenergia@delegado-datos.com. <strong>Informaci&oacute; Addicional:</strong> <a href="https://www.somenergia.coop/ca/avis-legal/#politica-de-privacitat">Pol&iacute;tica de Privadesa.</a></p>
<p dir="ltr">Salutacions,</p>
<p dir="ltr">Equip de Som Energia<br><a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br><strong id="docs-internal-guid-76ffb9ed-7fff-9759-f978-f6609b69da79"><a href="http://links.somenergia.coop/ls/click?upn=yvjDAe5RAIe8cyScmogXw1ZkKc1fqS-2BiMitOa-2B3QTTRT3-2BiN8UgK7PfGP0pPn9xnbPA__-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WVdX3bxDaYFj4FZmpJslEz4kzcYHn04ljnbojbPh-2BfAomzSAUvoiwYCCy37rsRbJKYtCCW1KuLOSZmWNio4imafMtYTgx-2BGJRg5gUuATUwcTuPP-2BIMHNq3-2Ff9TYgi5uiXPCyElMUpXK8d06-2BxzU1z7z7dhPGLM4If6nhsoPg8RNfDDXtvKGNtKCTEObx9KeEk">www.somenergia.coop</a>&nbsp;<img src="https://lh4.googleusercontent.com/1NiPjgDDlUrgUnX_RbDFy5uO8q5DWYflODYt8O3VnwvSF2zhpB1jZXzzx6KZn199rqYyd4c3Xl8k9Yj3w46OWyT9lITrL1cxpMQSuQ_aRAR4n3I2X48vWqf6yOM3tjEGm6E2B5Fr64MHnJ1HJx9hhet83BtDg0xVWKQJ1k8bz1PdGbjFJwPDvETsJV8wOQ" width="1" height="1"></strong></p>
</%def>
<%def name="correu_es()">
<p dir="ltr">Hola ${nom_titular},</p>
<p dir="ltr">La empresa de distribuci&oacute;n el&eacute;ctrica de tu zona nos comunica que existe una instalaci&oacute;n de autoproducci&oacute;n asociada al punto de suministro con c&oacute;digo CUPS ${cups} correspondiente a la direcci&oacute;n ${adreca}</p>
<p dir="ltr">En tu caso, nos informan tambi&eacute;n, que el titular de la instalaci&oacute;n generadora es otra persona.</p>
<p dir="ltr"><span style="text-decoration: underline;">Le hemos enviado un correo a la persona titular de la instalaci&oacute;n</span> a la direcci&oacute;n electr&oacute;nica indicada en el registro de la comunidad aut&oacute;noma. Para confirmar que os llega la informaci&oacute;n relacionada con la protecci&oacute;n de datos, tambi&eacute;n os la facilitamos a continuaci&oacute;n:</p>
<p dir="ltr">INFORMACI&Oacute;N DE PROTECCI&Oacute;N DE DATOS DE SOM ENERGIA</p>
<p dir="ltr"><strong>Responsabilidades:</strong> SOM ENERGIA, SCCL. (F55091367), C/ Pic de Peguera, 11, 17003 de Girona, somenergia@delegado-datos.com. <strong>Finalidades: </strong>Tramitar el alta del autoconsumo asociado a su instalaci&oacute;n. <strong>Legitimaci&oacute;n: </strong>Acuerdo de servicios con el titular de la instalaci&oacute;n fotovoltaica. <strong>Destinatarios:</strong> No est&aacute;n previstas cesiones, salvo entre el cliente, el titular de la instalaci&oacute;n y Som Energia y, las legalmente previstas. <strong>Derechos:</strong> Puede retirar su consentimiento en cualquier momento, as&iacute; como acceder, rectificar, suprimir sus datos y dem&aacute;s derechos en somenergia@delegado-datos.com. <strong>Informaci&oacute;n Adicional:</strong> <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ0zr-2BDJKbwOfu4-2Bz9vzCUm2aE6ZMOttbXHcIsFhtxJJ2OHMT9GMLMhq0CZfejdpzv2lbA7D-2FhBa0g4NWGupn3fjY-3DU3F-_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WCgT9pFhnBsLN635LDNoXP6jY8IljyD4oaJCFRuYz1umbDQX6LNcWSW5Vq7GAqjszLFXwQWxfeY4s2Auqr77RTxf-2FT-2BI0qf8vhQiGID5WNCv3rEZi62y3BtFNIA6NoMeN4IARcXrv0zwqSgB-2FB4WaPsHh-2BE8xf7G9uK7SZgAbSlMsZThNWGeWneSp2yDhJdWY">Pol&iacute;tica de Privacidad</a>.</p>
<p dir="ltr">Saludos,</p>
<p dir="ltr">Equipo de Som Energia<br><a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br><a href="http://links.somenergia.coop/ls/click?upn=yvjDAe5RAIe8cyScmogXw1ZkKc1fqS-2BiMitOa-2B3QTTS2C21TxuQjLgsBm-2FuOuA-2F5Uoul_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WyIGnLp96O2FE2HgIH4a8tlBUPosKbDvj52Tn-2BsI9ya81xX-2BjsCOeEqh-2FfsS1vOM5JpxDatpmMiWH-2BAmm9nGNtN6wPTLMfMISvV3t6TTi3avz6fOH010nvPA5kOw84142c3g6csn4vddDdc3AyDO8M5Mr6OwTeZOggliCLOhLDwvfvTKFmS1WAucBA-2BpTSW-2Ft">www.somenergia.coop</a> <img src="https://lh3.googleusercontent.com/5clpPDNRY-uWFBhmRKiRlYFpOoMGROFaqh60IJftNQIwLmqhkATCw97I-2quHx5jbHbJ_l1rrQ5boinsHbFuPRv4fyp8fS4W4s_qlbcDkfFZ6JJan1ddQrqAXAIdAPMheCDzV-F1PLjWY0Do5k2zW41Th7rFdUurPyKozJL7--btvKmMj4Z4rrzcq2sDqw" width="1" height="1"></p>
</%def>
