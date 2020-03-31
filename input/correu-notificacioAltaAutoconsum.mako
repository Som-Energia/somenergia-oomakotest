<%!
    from mako.template import Template
    from datetime import datetime, timedelta
    from gestionatr.utils import get_description
    import netsvc


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

    def get_auto_code_name(object_, code):
        if not code:
            return "Codigo desconocido"
        return get_description(code,'TABLA_127')

    def get_auto_colective_name(object_, code):
        switcher = {
            True: "Si",
            False: "No",
        }
        return switcher.get(code, "Codigo desconocido")

    def get_auto_technologi_name(object_, code):
        if not code:
            return "Codigo desconocido"
        return get_description(code,'TABLA_126')

    def get_auto_type_name(object_, code):
        if not code:
            return "Codigo desconocido"
        return get_description(code,'TABLA_129')

    def get_auto_section_name(object_, code):
        if not code:
            return "Sin excedentes"
        return get_description(code,'TABLA_128')

    def getStep01(swCase):
        return getStep(swCase,'01')

    def getStep(swCase,step_name):
        for case_step_id in swCase.step_ids:
            step_obj_name,step_id = case_step_id.pas_id.split(',')
            if step_obj_name.endswith(step_name):
                step_obj = swCase.pool.get(step_obj_name)
                return step_obj.browse(swCase._cr, swCase._uid, int(step_id))

    def getSomething(swCase,model,data,value,field):
        tbl_obj = swCase.pool.get(model)
        ids = tbl_obj.search(swCase._cr, swCase._uid,[(data,'=',value)])
        if ids:
            return tbl_obj.read(swCase._cr, swCase._uid, ids[0],[field])[field]



%>
<%
    logger = netsvc.Logger()
    partner_diferent = False
    polissa = object.cups_polissa_id
    GiscedataPolissa = object.pool.get('giscedata.polissa')
    polissa_nif = GiscedataPolissa.read(object._cr, object._uid, polissa.id, ['titular_nif'])['titular_nif']
    d = getStep01(object)
    if d.generadors:
        nif_generador = d.generadors[0].identificador
        if nif_generador != polissa_nif:
            partner_diferent = True

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
	<b>Codi autoconsum:</b> ${d.cau}<br>
	<b>Modalitat:</b> ${get_auto_code_name(object, d.seccio_registre)}<br>
        <b>Tipus modalitat:</b> ${get_auto_section_name(object, d.subseccio)}<br>
	<b>Instalació col·lectiva:</b> No<br>
        % if d.generadors[0].cil:
	<b>CIL:</b> ${d.generadors[0].cil}<br>
        % endif
	<b>Tecnologia:</b> ${get_auto_technologi_name(object,d.generadors[0].tec_generador)}<br>
	<b>Potència instal·lada:</b> ${d.generadors[0].pot_installada_gen} kW<br>
	<b>Tipus instal·lació:</b> ${get_auto_type_name(object, d.generadors[0].tipus_installacio)}<br>
	<b>Serveis auxiliars:</b> No<br>
	<br>
        % if partner_diferent:
Ens informen també que la persona titular de la instal·lació generadora és una persona diferent de la titular del contracte.<br>
	<br>
        % endif
	Si és correcte cal que ens ho confirmis responent aquest mateix correu, <b>indicant expressament que vols que demanem la modificació corresponent a la modalitat d’autoproducció triada a la distribuïdora</b> per aplicar-ho al teu contracte i a la teva facturació mensual tal com s’estableix a les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/">CONDICIONS GENERALS</a>. <b>En cas que es tracti d’una instal·lació registrada a la Comunitat Autònoma de Catalunya cal que també ens facis arribar el Certificat d’Instal·lació Elèctrica i el document de la declaració responsable complert de la instal·lació generadora en aquest mateix correu</b><br>
	El preu que estableix la cooperativa per els kWh d’energia excedentària és de 0,056€/kWh. <br>
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
	<b>Código autoconsumo:</b> ${d.cau}<br>
	<b>Modalidad:</b> ${get_auto_code_name(object, d.seccio_registre)}<br>
        <b>Tipo modalidad:</b> ${get_auto_section_name(object, d.subseccio)}<br>
	<b>Instalación colectiva:</b> No<br>
        % if d.generadors[0].cil:
	<b>CIL:</b> ${d.generadors[0].cil}<br>
        % endif
	<b>Tecnología:</b> ${get_auto_technologi_name(object, d.generadors[0].tec_generador)}<br>
	<b>Potencia instalada:</b> ${d.generadors[0].pot_installada_gen} kW<br>
	<b>Tipo instalación:</b> ${get_auto_type_name(object, d.generadors[0].tipus_installacio)}<br>
	<b>Servicios auxiliares:</b> No<br>
	<br>
        % if partner_diferent:
Nos informan también que la persona titular de la instalación generadora es una persona diferente a la titular del contrato.
	<br>
        % endif
	Si es correcto es necesario que nos lo confirmes respondiendo este mismo correo, <b>indicando en él expresamente que deseas que solicitemos la modificación correspondiente a la modalidad de autoproducción elegida a la distribuidora</b> para aplicarlo a tu contrato y en tu facturación mensual tal como se establece en las <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/">CONDICIONES GENERALES</a>.  <b>En caso de que se trate de una instalación registrada en la Comunidad Autónoma de Cataluña es necesario también que nos hagas llegar el Certificado de Instalación Eléctrica y el documento de la Declaración responsable completo de la Instalación generadora en el mismo correo.</b><br>
        El precio que establece la cooperativa para los kWh de energía excedentaria es de 0,056€/kWh.
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
