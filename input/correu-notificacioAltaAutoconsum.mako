<%!
    from mako.template import Template
    from datetime import datetime, timedelta

    def render(text_to_render, object_):
        templ = Template(text_to_render)
        return templ.render_unicode(
            object=object_,
            format_exceptions=True
    )

    def get_contract_number_by_cups(object_, cups):
        Polissa = object_.pool.get('giscedata.polissa')
        new_contract_id = Polissa.search(
            object_._cr, object_._uid, [('cups.name', '=', cups)]
        )[-1]
        return Polissa.read(object_._cr, object_._uid, new_contract_id, [])['name']

    def get_partner_name(object_):
        p_obj = object_.pool.get('res.partner')
        if not object_.vat_enterprise():
            nom_titular =' ' + p_obj.separa_cognoms(object_._cr, object_._uid, object_.cups_polissa_id.titular.name)['nom']
        else:
            nom_titular = ''
	return nom_titular
%>
<%
    d = object.step_ids[0].pas_id
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
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${get_partner_name(object)},
        </p>
	L’empresa de distribució elèctrica de la teva zona ens comunica que tens una instal·lació d’autoproducció associada al punt de subministrament amb codi CUPS ${object.cups_id.name} corresponent a l’adreça ${object.cups_id.direccio} amb les següents característiques segons els ha informat l’organisme competent de la teva comunitat autònoma:<br>
	<br>
	Codi autoconsum: ${d.cau}<br>
	Modalitat: ${d.seccio_registre}<br>
   %if d.generadors[0].cil:
	Instalació col·lectiva: Si<br>
   %else:
	Instalació col·lectiva: No<br>
   %endif
	CIL: ${d.generadors[0].cil}<br>
	Tecnologia: ${d.generadors[0].tec_generador}<br>
	Potència instal·lada: ${d.generadors[0].pot_installada_gen}<br>
	Tipus instal·lació: ${d.generadors[0].tipus_installacio}<br>
   %if d.generadors[0].ssaa:
	Serveis auxiliars: Si<br>
   %else:
	Serveis auxiliars: No<br>
   %endif
	<br>
	Si és correcte cal que ens ho confirmis responent aquest mateix correu, indicant expressament que vols que demanem la modificació corresponent a la modalitat d’autoproducció triada a la distribuïdora per aplicar-ho al teu contracte i a la teva facturació mensual tal com s’estableix a les CONDICIONS GENERALS.<br>
	El preu que estableix la cooperativa per els kWh d’energia excedentària es de 0,56€/kWh.<br>
	<br>
	Si la informació que ens traslladen no es correcta ens ho heu de notificar per comunicar-ho a la distribuïdora i també us heu d’adreçar a l’organisme pertinent de la vostra comunitat autònoma per tal que modifiquin/verifiquin la informació que els hi consta i tornin a passar la informació correctament a l’empresa distribuïdora.<br>
	<br>
	Quan ho hagin fet ens tornaran a enviar la informació actualitzada i t’informarem novament.<br>
	<br>
	Qualsevol dubte seguim en contacte.<br>
	<br>
	Salutacions,<br>
        <br>
        Equip de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
    </body>
</%def>


<%def name="correu_es()">
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
                    <font size=1> Dirección del punto de suministro: ${object.cups_id.direccio}</font>
                </td>
            </tr>
            <tr>
                <td height=2px>
                    <font size=1> Codigo CUPS: ${object.cups_id.name}</font>
                </td>
            </tr>
            %if is_pot_tar:
            <tr>
                <td height=2px width=100%>
                    <font size=1> Titular: ${object.cups_polissa_id.titular.name}</font>
                </td>
            </tr>
            %endif
        </table>
        <p>
            Hola${get_partner_name(object)},
	</p>
	La empresa de distribución eléctrica de tu zona nos comunica que tienes una instalación de autoproducción asociada al punto de suministro con CUPS ${object.cups_id.name} de ${object.cups_id.direccio} con las siguientes características según les informó el organismo competente de tu comunidad autónoma:<br>
	<br>
	Código autoconsumo: ${d.cau}<br>
	Modalidad: ${d.seccio_registre}<br>
   %if d.generadors[0].cil:
	Instalación colectiva: Si<br>
   %else:
	Instalación colectiva: No<br>
   %endif
	CIL: ${d.generadors[0].cil}<br>
	Tecnología: ${d.generadors[0].tec_generador}<br>
	Potencia instalada: ${d.generadors[0].pot_installada_gen}<br>
	Tipo instalación : ${d.generadors[0].tipus_installacio}<br>
   %if d.generadors[0].ssaa:
	Servicios auxiliares: Si<br>
   %else:
	Servicios auxiliares: No<br>
   %endif
	<br>
	Si es correcto es necesario que nos lo confirmes respondiendo este mismo correo, indicando en él expresamente que deseas que solicitemos la modificación correspondiente a la modalidad de autoproducción elegida a la distribuidora para aplicarlo a tu contrato y en tu facturación mensual tal como se establece en las CONDICIONES GENERALES.<br>
	<br>
	Si la información que nos trasladan no es correcta nos lo debes notificar para comunicarlo a la distribuidora y también debes dirigirte al organismo correspondiente de tu Comunidad Autónoma para que modifiquen/verifiquen la información que les consta y vuelvan a pasar la información correctamente a la empresa distribuidora.<br>
	<br>
	Cuando lo hayan hecho nos volverán a enviar la información actualizada y te informaremos nuevamente.<br>
	<br>
	Cualquier duda seguimos en contacto.<br>
	<br>
	Saludos,<br>
        <br>
        Equipo de Som Energia<br>
        <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
        <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
    </body>
</%def>
