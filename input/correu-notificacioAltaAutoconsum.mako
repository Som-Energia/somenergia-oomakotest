<%!
    from mako.template import Template
    from datetime import datetime, timedelta
    from gestionatr.utils import get_description

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
    partner_diferent = False
    polissa = object.cups_polissa_id
    GiscedataPolissa = object.pool.get('giscedata.polissa')
    polissa_nif = GiscedataPolissa.read(object._cr, object._uid, polissa.id, ['titular_nif'])['titular_nif']
    pot_installada = ' '

    d = object.step_ids[0].pas_id
    if d.motiu_canvi == '04' or d.motiu_canvi == '15':
        if d.generadors:
            nif_generador = d.generadors[0].identificador
            if nif_generador != polissa_nif:
                partner_diferent = True
    elif d.motiu_canvi == '07' or d.motiu_canvi == '12':
        if d.generadors:
            pot_installada = d.generadors[0].pot_installada_gen or ' '

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
    <body>
    % if object.cups_polissa_id.titular.lang == "ca_ES":
        ${capcalera_cat()}
    % else:
        ${capcalera_es()}
    % endif
    <br>
    % if d.motiu_canvi == '01' and object.cups_polissa_id.titular.lang == "ca_ES":
        ${correu_ca_motiu_01()}
    % elif d.motiu_canvi == '01' and object.cups_polissa_id.titular.lang == "es_ES":
        ${correu_es_motiu_01()}
    % elif d.motiu_canvi == '07' and object.cups_polissa_id.titular.lang == "ca_ES":
        ${correu_ca_motiu_07()}
    % elif d.motiu_canvi == '07' and object.cups_polissa_id.titular.lang == "es_ES":
        ${correu_es_motiu_07()}
    % elif object.cups_polissa_id.titular.lang == "ca_ES":
        ${correu_cat()}
    % else:
        ${correu_es()}
    % endif
    ${text_legal}
    </body>
</html>

<%def name="capcalera_cat()">
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
</%def>

<%def name="capcalera_es()">
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
</%def>


<%def name="correu_cat()">
    <p>
        Hola${get_partner_name(object)},
    </p>
    <p>
        L'empresa de distribució elèctrica de la teva zona ens comunica que existeix una instal·lació d'autoproducció associada al punt de subministrament amb codi CUPS ${object.cups_id.name} corresponent a l’adreça ${object.cups_id.direccio}.
    </p>
    <p>
        Pots accedir a través d'<a href="http://oficinavirtual.somenergia.coop/ca">aquest enllaç</a> a la teva oficina virtual i veure les característiques de la mateixa segons la informació que ens trasllada la distribuïdora.
    </p>
    <p>
        Necessitem que acceptis o rebutgis, en el cas de que no estiguis d’acord amb la informació que ens indiquen, la comunicació que ens faciliten per poder continuar amb les gestions pertinents. Seguint aquests passos:  Apartat <b>Contractes > Els meus tràmits d'autoconsum > Detalls</b>
    </p>
    %if partner_diferent:
    <p>
        En el teu cas, ens informen també, que <b>el titular de la instal·lació generadora és una altra persona.</b> Si aquesta informació no és correcta, i el titular de la instal·lació correspon amb el titular del contracte, et demanem que ens avisis responent aquest mateix correu, abans d’acceptar o rebutjar les dades de l’Oficina Virtual.
    </p>
    %endif
    <p>
        En cas que la informació sigui correcta, i hagis acceptat el tràmit, podràs demanar la modificació del contracte per aplicar la modalitat triada seguint els passos que et va indicant la oficina virtual. També et permet sol·licitar alguna altra modificació del contracte com pot ser la potència, tarifa o tensió del subministrament; si vols, pots aprofitar aquest mateix tràmit per fer-ho.
    </p>
    <p>
        Recorda que tens més informació sobre l’autoconsum, el preu  de compensació, les modalitats, i els tràmits associats al centre d’ajuda de la nostra web dins l’apartat <a href="https://ca.support.somenergia.coop/category/777-autoproduccio">Autoproducció</a>. També pots consultar en el següent enllaç les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/">condicions generals</a> de contractació que vas acceptar en el moment de contractar amb Som Energia (la clàusula 8 tracta l’autoconsum).
    </p>
    <p>
        Qualsevol dubte continuem en contacte.
    </p>
    Salutacions,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
</%def>
<%def name="correu_es()">
    <p>
        Hola${get_partner_name(object)},
    </p>
    <p>
        La empresa de distribución eléctrica de tu zona nos comunica que existe una instalación de autoproducción asociada al punto de suministro con código CUPS ${object.cups_id.name} correspondiente a la dirección ${object.cups_id.direccio}.
    </p>
    <p>
        Puedes acceder a través de <a href="http://oficinavirtual.somenergia.coop/es">este enlace</a> a tu oficina virtual y ver las características de la misma según la información que nos traslada la distribuidora.  Siguiendo estos pasos: Apartado <b>Contratos> Mis trámites de autoconsumo> Detalles</b>
    </p>
    <p>
        Necesitamos que aceptes o rechaces, en el caso de que no estés de acuerdo con la información que nos indican, la comunicación que nos facilitan para poder continuar con las gestiones pertinentes.
    </p>
    %if partner_diferent:
    <p>
        En tu caso, nos informan también, que <b>el titular de la instalación generadora es otra persona.</b> Si esta información no es correcta, y el titular de la instalación se corresponde con el titular del contrato, te pedimos que nos avises respondiendo este correo, antes de aceptar o rechazar los datos en tu Oficina Virtual.
    </p>
    %endif
    <p>
        En caso de que la información sea correcta, y hayas aceptado el trámite, podrás pedir la modificación del contrato para aplicar la modalidad elegida siguiendo los pasos que te va indicando la oficina virtual. También te permite solicitar alguna otra modificación del contrato como puede ser la potencia, tarifa o tensión del suministro; si quieres, puedes aprovechar este mismo trámite para hacerlo.
    </p>
    <p>
        Recuerda que tienes más información sobre el autoconsumo, el precio de compensación, las modalidades, y los trámites asociados en el centro de ayuda de nuestra web dentro del apartado <a href="https://es.support.somenergia.coop/category/779-autoproduccion">Autoproducción</a>. También puedes consultar en el siguiente enlace las <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/">condiciones generales</a> de contratación que aceptaste en el momento de contratar con Som Energia (la cláusula 8 trata el autoconsumo).
    </p>
    <p>
        Cualquier duda seguimos en contacto.
    </p>
    Saludos,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
<%def name="correu_ca_motiu_01()">
    <p>
        Hola${get_partner_name(object)},
    </p>
    L’empresa de distribució elèctrica ens ha confirmat que ha activat la telegestió operativa amb CCH mensual.<br>
    <br>
    Qualsevol dubte seguim en contacte.<br>
    <br>
    Salutacions,<br>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
</%def>

<%def name="correu_es_motiu_01()">
    <p>
        Hola${get_partner_name(object)},
    </p>
	La empresa de distribución eléctrica nos ha confirmado que ha activado la telegestión operativa con CCH mensual.<br>
	<br>
	Cualquier duda seguimos en contacto.<br>
	<br>
	Saludos,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>

<%def name="correu_ca_motiu_07()">
    <p>
        Hola${get_partner_name(object)},
    </p>
        L'empresa de distribució elèctrica de la teva zona ens comunica una <strong>modificació de potència de generació</strong> de la instal·lació d'autoproducció associada al punt de subministrament amb codi CUPS ${object.cups_id.name} corresponent a l’adreça ${object.cups_id.direccio}.
    </p>
    <p>
        La nova potència de generació indicada per la distribuïdora és: <strong>${pot_installada} kW</strong>
    </p>
    <p>
        En cas que la informació sigui correcta, necessitem que ens contestis aquest mateix correu, i tramitarem la modificació contractual per actualitzar aquesta dada.
    </p>
    <p>
        Qualsevol dubte continuem en contacte.
    </p>
    <p>
        Salutacions,
    </p>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
</%def>

<%def name="correu_es_motiu_07()">
    <p>
        Hola${get_partner_name(object)},
    </p>
	La empresa de distribución eléctrica de tu zona nos comunica una <strong>modificación de la potencia de generación </strong> de la instalación de autoproducción asociada al punto de suministro con código CUPS ${object.cups_id.name} correspondiente a la dirección ${object.cups_id.direccio}.<br>
	<br>
	La nueva potencia de generación indicada por la distribuidora es:<strong> ${pot_installada} kW</strong><br>
	<br>
    En caso de que la información sea correcta, necesitamos que contestes a este mismo correo, y tramitaremos la modificación contractual para actualizar este dato.<br>
    <br>
    Cualquier duda seguimos en contacto. <br>
    <br>
	Saludos,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>

<%def name="correu_ca_motiu_12()">
    <p>
        Hola${get_partner_name(object)},
    </p>
        L'empresa de distribució elèctrica de la teva zona ens comunica una <strong>modificació de potència de generació</strong> de la instal·lació d'autoproducció associada al punt de subministrament amb codi CUPS ${object.cups_id.name} corresponent a l’adreça ${object.cups_id.direccio}.
    </p>
    <p>
    <p>
        La nova potència de generació indicada per la distribuïdora és: <strong>${pot_installada} kW</strong>
    </p>
        En cas que la informació sigui correcta, necessitem que ens contestis aquest mateix correu, i tramitarem la modificació contractual per actualitzar aquesta dada.
    </p>
    <p>
        Tingues en compte que l'empresa distribuïdora pot cobrar costos de gestió per aquest canvi que es veuran reflectits en la teva factura.
    </p>
    <p>
        Qualsevol dubte continuem en contacte.
    </p>
    <p>
        Salutacions,
    </p>
    <br>
    Equip de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/ca">www.somenergia.coop</a>
</%def>

<%def name="correu_es_motiu_12()">
    <p>
        Hola${get_partner_name(object)},
    </p>
	La empresa de distribución eléctrica de tu zona nos comunica una <strong>modificación de la potencia de generación </strong> de la instalación de autoproducción asociada al punto de suministro con código CUPS ${object.cups_id.name} correspondiente a la dirección ${object.cups_id.direccio}.<br>
	<br>
	La nueva potencia de generación indicada por la distribuidora es:<strong> ${pot_installada} kW</strong><br>
	<br>
    Si la información sea correcta, necesitamos que contestes a este mismo correo para tramitar la modificación contractual correspondiente.<br>
    <br>
    Ten en cuenta que la distribuidora puede cobrar costes de gestión por este cambio que se verán reflejados en tu factura.<br>
    <br>
    Para cualquier otra aclaración, estamos en contacto.<br>
    <br>
	Saludos,<br>
    <br>
    Equipo de Som Energia<br>
    <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a><br>
    <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
