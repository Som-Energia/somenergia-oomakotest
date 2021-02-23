<%!
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

%>
<!doctype html>
<html>
    <head>
        <meta charset='utf-8'>
    </head>
    % if object.cups_polissa_id.titular.lang == "ca_ES":
        ${correu_cat()}
    % else:
        ${correu_es()}
    % endif
    ${text_legal}
</html>

<%def name="correu_cat()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contracte Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Adreça punt subministrament: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codi CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
        </table>
        <p>
            Bon dia,
        </p>
        <p>
            Recentment l'empresa de distribució elèctrica ens ha fet arribar les teves dades donat que estan associades a una instal·lació d'autoconsum d'un CUPS comercialitzat per Som Energia.
        </p>
        <p>
            Per poder gestionar l'aplicació de l'autoconsum necessitem que ens donis autorització per tractar les teves dades.
        </p>
        <p>
            T'enviem la informació relacionada amb la protecció de dades per què ens autoritzis el tractament d'aquestes responent aquest mateix correu.
        </p>
        <p>
            INFORMACIÓ DE PROTECCIÓ DE DADES DE SOM ENERGIA
        </p>
        <p>
            <b>Responsabilitats:</b> SOM ENERGIA, SCCL. (F55091367), C / Pic de Peguera, 11, 17003 de Girona, somenergia@delegado-datos.com. <b>Finalitats:</b> Tramitar l'alta de l'autoconsum associat a la seva instal·lació. <b>Legitimació:</b> Acord de serveis amb el titular de la instal·lació fotovoltaica. <b>Destinataris:</b> No estan previstes cessions, tret entre el client, el titular de la instal·lació i Som Energia i, les legalment previstes. <b>Drets:</b> Pot retirar el seu consentiment en qualsevol moment, així com accedir, rectificar, suprimir les seves dades i altres drets a somenergia@delegado-datos.com. <b>Informació Addicional:</b><a href="https://www.somenergia.coop/ca/avis-legal/#politica-de-privacitat">Política de Privadesa.</a>
        </p>
        <p>
            Esperem la teva resposta per continuar o no amb la gestió,
        </p>
	    Salutacions,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a> - facebook <a href="https://www.facebook.com/somenergia/">https://www.facebook.com/somenergia/</b> - twitter <a href="https://twitter.com/somenergia">https://twitter.com/somenergia</b>
    </body>
</%def>
<%def name="correu_es()">
    <body>
        <table width="100%" frame="below" bgcolor="#E8F1D4">
            <tr>
                <td height=2px>
                    <font size=2><strong> Contrato Som Energia nº ${polissa.name}</strong></font>
                </td>
                <td valign=top rowspan="4" align="right">
                    <img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Dirección del punto de suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Código CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
        </table>
        <p>
            Buenos días,
	    </p>
        <p>
            Recientemente la empresa de distribución eléctrica nos ha hecho llegar tus datos dado que están asociadas a una instalación de autoconsumo de un CUPS comercializado por Som Energia.        </p>
        <p>
            Para poder gestionar la aplicación del autoconsumo necesitamos que nos des autorización para tratar tus datos.
        </p>
        <p>
            Te enviamos la información relacionada con la protección de datos para que nos autorices el tratamiento de estas respondiendo a este mismo correo.        </p>
        <p>
            INFORMACIÓN DE PROTECCIÓN DE DATOS DE SOM ENERGIA
        </p>
        <p>
            Esperamos tu respuesta para continuar o no con la gestión, 
        </p>
        <p>
            <b>Responsabilidades:</b> SOM ENERGIA, SCCL. (F55091367), C/ Pic de Peguera, 11, 17003 de Girona, somenergia@delegado-datos.com. <b>Finalidades:</b> Tramitar el alta del autoconsumo asociado a su instalación.<b> Legitimación:</b> Acuerdo de servicios con el titular de la instalación fotovoltaica. <b>Destinatarios:</b> No están previstas cesiones, salvo entre el cliente, el titular de la instalación y Som Energia y, las legalmente previstas. <b>Derechos:</b>  Puede retirar su consentimiento en cualquier momento, así como acceder, rectificar, suprimir sus datos y demás derechos en somenergia@delegado-datos.com. <b>Información Adicional:</b> <a href="https://www.somenergia.coop/es/aviso-legal/#politica-de-privacidad">Política de Privacidad</a>.
        </p>
        Saludos,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a> - facebook <a href="https://www.facebook.com/somenergia/">https://www.facebook.com/somenergia/</b> - twitter <a href="https://twitter.com/somenergia">https://twitter.com/somenergia</b>
    </body>
</%def>