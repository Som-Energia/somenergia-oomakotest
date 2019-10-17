<%!
    from mako.template import Template
%>

<%
    CCAAs_cat = ['09']
    CCAAs_oth = ['01','02','03','06','07','11','12','13','14','15']
%>

<%
    pol_obj = object.pool.get('giscedata.polissa')
    pol_ids = pol_obj.search(object._cr, object._uid,[('cups','like',object.cups[:20])])

    if len(pol_ids) != 1:
        raise Exception("Sense polissa associada!")

    polissa = pol_obj.browse(object._cr, object._uid,pol_ids[0])
    language = polissa.pagador.lang
    zone = polissa.cups.id_municipi.state.comunitat_autonoma.codi
    CCAA_name = polissa.cups.id_municipi.state.comunitat_autonoma.name
    CCAA_name = (' '.join(reversed(CCAA_name.split(',')))).strip()
%>

<%
    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
        )
    t_obj = object.pool.get('poweremail.templates')
    md_obj = object.pool.get('ir.model.data')
    template_id = md_obj.get_object_reference(
                        object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_legal_footer'
                    )[1]
    text_legal = render(t_obj.read(
        object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
        polissa
    )
%>

<%
    try:
        p_obj = object.pool.get('res.partner')
        if not p_obj.vat_es_empresa(object._cr, object._uid,'polissa.pagador.vat'):
            nom_pagador =' ' + p_obj.separa_cognoms(object._cr, object._uid,polissa.pagador.name)['nom']
        else:
            nom_pagador = ''
    except:
        nom_pagador = ''
%>

<!doctype html>
<html>
% if language == 'ca_ES':
    ${header_cat()}
    %if zone in CCAAs_cat:
        ${correu_CAT_cat()}
    % else:
        ${correu_RES_cat()}
    % endif
    ${sentence_cat()}
    ${footer_cat()}
% else:
    ${header_es()}
    %if zone in CCAAs_cat:
        ${correu_CAT_es()}
    % else:
        ${correu_RES_es()}
    % endif
    ${sentence_es()}
    ${footer_es()}
% endif
${text_legal}
</html>

<%def name="correu_CAT_cat()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        Ens posem en contacte amb tu per fer-te saber que, per tal de donar compliment a la normativa vigent, en la propera factura d’electricitat procedirem al cobrament dels suplements territorials, segons estableix l’ordre TEC/271/2019 dictada pel Ministeri per a la Transició Ecològica.<br>
        En el cas que aquest import sigui superior a 2 €, aquest es cobrarà de forma fraccionada en diverses factures, durant les properes mensualitats.<br>
	<br>
	A continuació t’adjuntem la comunicació que el Ministeri per a la Transició Ecològica ens ha enviat per tal que us la transmetem:<br>
        <br>
        <i>
        SOM ENERGIA S.C.C.L.<br>
        <br>
        Els peatges d'accés d'energia elèctrica formen part del preu de l'electricitat, i estan destinats a cobrir diferents partides de costos del sector elèctric amb retribució regulada. Entre d'altres, cobreixen el cost de les activitats de xarxes (transport i distribució d'energia elèctrica) i producció a partir de fonts d'energia renovables, cogeneració i residus amb règim primat.<br>
        L'any 2013 la normativa contemplava que en cas que aquestes activitats elèctriques estiguessin subjectes a tributs de caràcter autonòmic, el peatge d'accés inclouria un suplement territorial pels consumidors d'aquesta Comunitat Autònoma, si bé aquest suplement no es va arribar a aprovar pel Govern.<br>
        En execució de les sentències<sup>1</sup> del Tribunal Suprem dictades com a resultat dels recursos interposats per empreses que exerceixen la seva activitat en el sector elèctric, es va aprovar l'Ordre ETU/35/2017, de 23 de gener, per la qual s'estableixen els suplements territorials en determinades comunitats autònomes, d’entre elles, Catalunya. Per això, els suplements territorials s’han aplicat en les seves factures, sobre els consums que va realitzar l'any 2013.<br>
        El Tribunal Suprem, instat per les empreses recorrents, ha determinat que aquesta execució va ser parcial, de manera que la ministra per a la Transició Ecològica ha aprovat una ordre ministerial amb els suplements territorials addicionals per la seva Comunitat Autònoma que li seran aplicats en les pròximes factures, sobre els consums que va realitzar l'any 2013.<br>
        Per això, Som Energia S.C.C.L. procedirà a regularitzar les quantitats que resulten de la diferència entre el valor fixat en concepte de suplement territorial a Catalunya i el valor que es va utilitzar per determinar els suplements territorials aprovats en l'ordre ETU / 35/2017, de 23 de gener.<br>
        Aquesta regularització se li aplicarà en la seva factura, i vindrà identificada pel concepte «Suplement territorial per tributs autonòmics de la Comunitat Autònoma Catalunya de l'any 2013».<br>
        <br>
        </i>
    </body>
</%def>

<%def name="correu_CAT_es()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        Nos ponemos en contacto contigo para hacerte saber que, a fin de dar cumplimiento a la normativa vigente, en la próxima factura de electricidad procederemos al cobro de los suplementos territoriales, según establece la orden TEC/271/2019, dictada por el Ministerio para la Transición Ecológica.<br>
        En el caso que este importe sea superior a 2 €, éste se cobrará de forma fraccionada en varias facturas, durante las próximas mensualidades.<br>
	<br>
	A continuación te adjuntamos la comunicación que el Ministerio para la Transición Ecológica nos ha enviado para que os la transmitamos:<br>
        <br>
        <i>
        SOM ENERGIA S.C.C.L.<br>
        <br>
        Los peajes de acceso de energía eléctrica forman parte del precio de la electricidad, y están destinados a cubrir diferentes partidas de costes del sector eléctrico con retribución regulada. Entre otros, cubren el coste de las actividades de redes (transporte y distribución de energía eléctrica) y producción a partir de fuentes de energía renovables, cogeneración y residuos con régimen primado.<br>
        En el año 2013 la normativa contemplaba que en caso de que estas actividades eléctricas fueran gravadas con tributos de carácter autonómico, al peaje de acceso se le incluiría un suplemento territorial para los consumidores de esa Comunidad Autónoma, si bien dicho suplemento no se llegó a aprobar por el Gobierno.<br>
        En ejecución de las sentencias<sup>1</sup> del Tribunal Supremo dictadas a resultas de los recursos interpuestos por empresas que ejercen su actividad en el sector eléctrico, se aprobó la Orden ETU/35/2017, de 23 de enero, por la que se establecen los suplementos territoriales en determinadas comunidades autónomas, entre ellas, Cataluña. Por ello, los suplementos territoriales han sido aplicado en sus facturas, sobre los consumos que realizó en el año 2013.<br>
        El Tribunal Supremo, instado por las empresas recurrentes, ha determinado que esta ejecución fue parcial, por lo que la Ministra para la Transición Ecológica ha aprobado una orden ministerial con los suplementos territoriales adicionales para su Comunidad Autónoma que le serán aplicados en próximas facturas, sobre los consumos que realizó en el año 2013.<br>
        Por ello, Som Energia S.C.C.L. va a proceder a regularizar las cantidades que resultan de detraer al valor fijado en concepto de suplemento territorial en Cataluña y el valor que se utilizó para determinar los suplementos territoriales aprobados en la orden ETU/35/2017, de 23 de enero.<br>
        Esta regularización se le aplicará en su factura, y vendrá identificada por el concepto «Suplemento territorial por tributos autonómicos de la Comunidad Autónoma Catalunya del año 2013».<br>
        <br>
        </i>
    </body>
</%def>

<%def name="correu_RES_cat()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        Ens posem en contacte amb tu per fer-te saber que,  per tal de donar compliment a la normativa vigent, en la propera factura d’electricitat procedirem al cobrament dels suplements territorials, segons estableix l’ordre TEC/271/2019 dictada pel Ministeri per a la Transició Ecològica.<br>
        En el cas que aquest import sigui superior a 2 €, aquest es cobrarà de forma fraccionada en diverses factures, durant les properes mensualitats.<br>
	<br>
	A continuació t’adjuntem la comunicació que el Ministeri per a la Transició Ecològica ens ha enviat per tal que us la transmetem:<br>
        <br>
        <i>
        SOM ENERGIA S.C.C.L.<br>
        <br>
        Els peatges d'accés d'energia elèctrica formen part del preu de l'electricitat, i estan destinats a cobrir diferents partides de costos del sector elèctric amb retribució regulada. Entre d'altres, cobreixen el cost de les activitats de xarxes (transport i distribució d'energia elèctrica) i producció a partir de fonts d'energia renovables, cogeneració i residus amb règim primat.<br>
        L'any 2013 la normativa contemplava que en cas que aquestes activitats elèctriques estiguessin subjectes a tributs de caràcter autonòmic, el peatge d'accés inclouria un suplement territorial pels consumidors d'aquesta Comunitat Autònoma, si bé aquest suplement no es va arribar a aprovar pel Govern.<br>
        En execució de les sentències<sup>1</sup> del Tribunal Suprem dictades com a resultat dels recursos interposats per empreses que exerceixen la seva activitat en el sector elèctric, la ministra per a la Transició Ecològica ha aprovat una ordre ministerial amb els suplements territorials per a la seva comunitat autònoma que li seran aplicats en pròximes factures, sobre els consums que va realitzar l'any 2013.<br>
        Per això, Som Energia S.C.C.L. procedirà a regularitzar les quantitats que resulten de l'aplicació del valor fixat en concepte de suplement territorial de la comunitat autònoma.<br>
        Aquesta regularització se li aplicarà en la seva factura, i vindrà identificada pel concepte «Suplement territorial per tributs autonòmics de la Comunitat Autònoma ${CCAA_name} de l'any 2013».<br>
        <br>
        </i>
    </body>
</%def>

<%def name="correu_RES_es()">
    <body>
        <br>
        <br>
        Hola${nom_pagador},<br>
        <br>
        Nos ponemos en contacto contigo para hacerte saber que, a fin de dar cumplimiento a la normativa vigente, en la próxima factura de electricidad procederemos al cobro de los suplementos territoriales, según establece la orden TEC/271/2019, dictada por el Ministerio para la Transición Ecológica.<br>
        En el caso que este importe sea superior a 2 €, éste se cobrará de forma fraccionada en varias facturas, durante las próximas mensualidades.<br>
        <br>
	A continuación te adjuntamos la comunicación que el Ministerio para la Transición Ecológica nos ha enviado para que os la transmitamos:<br>
	<br>
        <i>
        SOM ENERGIA S.C.C.L.<br>
        <br>
        Los peajes de acceso de energía eléctrica forman parte del precio de la electricidad, y están destinados a cubrir diferentes partidas de costes del sector eléctrico con retribución regulada. Entre otros, cubren el coste de las actividades de redes (transporte y distribución de energía eléctrica) y producción a partir de fuentes de energía renovables, cogeneración y residuos con régimen primado.<br>
        En el año 2013 la normativa contemplaba que en caso de que estas actividades eléctricas fueran gravadas con tributos de carácter autonómico, al peaje de acceso se le incluiría un suplemento territorial para los consumidores de esa Comunidad Autónoma, si bien dicho suplemento no se llegó a aprobar por el Gobierno.<br>
        En ejecución de las sentencias<sup>1</sup> del Tribunal Supremo dictadas a resultas de los recursos interpuestos por empresas que ejercen su actividad en el sector eléctrico, la Ministra para la Transición Ecológica ha aprobado una orden ministerial con los suplementos territoriales para su Comunidad Autónoma que le serán aplicados en próximas facturas, sobre los consumos que realizó en el año 2013.<br>
        Por ello, Som Energia S.C.C.L. va a proceder a regularizar las cantidades que resultan de la aplicación del valor fijado en concepto de suplemento territorial de dicha Comunidad Autónoma.<br>
        Esta regularización se le aplicará en su factura, y vendrá identificada por el concepto «Suplemento territorial por tributos autonómicos de la Comunidad Autónoma ${CCAA_name} del año 2013».<br>
        <br>
        </i>
    </body>
</%def>

<%def name="sentence_cat()">
    <body>
        <i>
        <font size="2" style="color:black">
        <sup>1</sup> Sentències del Tribunal Suprem relatives als recursos contenciós-administratius nombre 102/2013, contra l'Ordre IET / 221/2013, de 14 de febrer, en la qual es declara que l'article 9.1 d'aquesta Ordre no és conforme a l'ordenament jurídic, i nombre 379/2013, contra Ordre IET / 1491/2013, d'1 d'agost, per la qual es declara que l'article 1 i l'Annex i de la mateixa no eren conformes a l'ordenament jurídic.<br>
        </font>
        <br>
        </i>
    </body>
</%def>

<%def name="sentence_es()">
    <body>
        <i>
        <font size="2" style="color:black">
        <sup>1</sup> Sentencias del Tribunal Supremo relativas a los recursos contencioso-administrativos número 102/2013, contra la Orden IET/221/2013, de 14 de febrero, en la que se declara que el artículo 9.1 de dicha Orden no es conforme al ordenamiento jurídico, y número 379/2013, contra Orden IET/1491/2013, de 1 de agosto, por la que se declara que el artículo 1 y el Anexo I de la misma no eran conformes al ordenamiento jurídico.<br>
        </font>
        <br>
        </i>
    </body>
</%def>

<%def name="footer_cat()">
    <body>
        Per a qualsevol dubte o aclariment, seguim en contacte.<br>
        <br>
        Salutacions,<br>
        <br>
        Equip de Som Energia<br>
        <a href="http://ca.support.somenergia.coop">Centre de Suport</a><br>
        factura@somenergia.coop<br>
        <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>
        <br>
    </body>
</%def>

<%def name="footer_es()">
    <body>
        Para cualquier duda o aclaración, seguimos en contacto.<br>
        <br>
        Un saludo, <br>
        <br>
        Equipo de Som Energia<br>
        <a href="http://es.support.somenergia.coop">Centro de Ayuda</a><br>
        factura@somenergia.coop<br>
        <a href="http://www.somenergia.coop">www.somenergia.coop</a><br>
        <br>
    </body>
</%def>

<%def name="header_cat()">
    <head>
        <meta charset="utf-8" />
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=1px>
                    <font size=2><strong>Contracte Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Adreça punt subministrament: ${polissa.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Codi CUPS: ${polissa.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100% >
                    <font size=1>Titular: ${polissa.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>

<%def name="header_es()">
    <head>
        <meta charset="utf-8" />
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong>Contrato Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4">
                    <align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Dirección punto suministro: ${polissa.cups.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1>Código CUPS: ${polissa.cups.name}</font>
                </td>
            </tr>
            <tr>
                <td height=2px width=100% >
                    <font size=1>Titular: ${polissa.titular.name}</font>
                </td>
            </tr>
        </table>
    </head>
</%def>
