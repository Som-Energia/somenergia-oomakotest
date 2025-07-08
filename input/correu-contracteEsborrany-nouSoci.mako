<%
import time
from mako.template import Template
def render(text_to_render, object_):
    templ = Template(text_to_render)
    return templ.render_unicode(
        object=object_,
        format_exceptions=True
    )
t_obj = object.pool.get('poweremail.templates')
md_obj = object.pool.get('ir.model.data')
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

template_id = md_obj.get_object_reference(
        object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_rejection_text'
    )[1]

text_desistiment = render(
    t_obj.read(object._cr, object._uid, [template_id], ['def_body_text'])[0]['def_body_text'],
    object
)
tarifa_a_mostrar = ""

from gestionatr.defs import TABLA_113
from som_polissa.giscedata_cups import TABLA_113_dict
autoconsum_description = False
if object.autoconsumo != '00':
    autoconsum_description = object.autoconsumo + ' - '
    if object.titular.lang == 'ca_ES':
        autoconsum_description += TABLA_113_dict[object.autoconsumo]
    else:
        autoconsum_description += dict(TABLA_113)[object.autoconsumo]

try:
    lang = object.titular.lang
    pol_o = object.pool.get('giscedata.polissa')
    llista_preu_o = object.pool.get('product.pricelist')

    tarifes_ids = llista_preu_o.search(object._cr, object._uid, [])
    llista_preus = pol_o.escull_llista_preus(object._cr, object._uid, object.id, tarifes_ids, context={'lang': lang})

    tarifa_a_mostrar = llista_preus.nom_comercial or llista_preus.name
except Exception as error:
    pass

ingres = time.strftime('%d/%m/%y')
def socifilter(text):
    return str(int(''.join([a for a in text if a.isdigit()])))

%>

${plantilla_header}

            % if object.titular.lang == "ca_ES":
<p>Benvingut/da a Som Energia!<br><br></p>
<p dir="ltr">Ens alegra que formis part de la cooperativa que construeix un model energ&egrave;tic renovable en mans de la ciutadania, des de la participaci&oacute; i la transpar&egrave;ncia. Esperem que juntes podrem assolir el nostre objectiu de transformar el model energ&egrave;tic, apostant per les energies renovables i l&rsquo;efici&egrave;ncia energ&egrave;tica.</p>
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center">N&uacute;mero de soci/a: <strong>${object.soci.ref | socifilter}</strong></p>
<p align="center">Nom: ${object.soci.name}</p>
<p align="center">Data d'ingr&eacute;s: ${ingres}</p>
<p align="center">Aportaci&oacute; obligat&ograve;ria al capital social: 100&euro;</p>
<p align="center">Titular del contracte d'electricitat: ${object.titular.name}</p>
<p align="center">Adreça punt subministrament: ${object.cups_direccio}</p>
<p align="center">Codi CUPS: ${object.cups.name}</p>
<p align="center">Tarifa: ${tarifa_a_mostrar}</p>
% if object.donatiu:
<p align="center">Donatiu Voluntari (0,01€/kWh): Si</p>
%endif
%if autoconsum_description:
<p align="center">Modalitat autoconsum: ${autoconsum_description}</p>
%endif
</fieldset></td>
</tr>
</tbody>
</table>

%if autoconsum_description:
<p>Si la teva modalitat d’autoconsum és amb compensació d’excedents, també s’ha activat el <a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar">Flux Solar</a>. </p>
%endif

% if object.mode_facturacio == "index":
<p>T'adjuntem les condicions generals, específiques i particulars del teu contracte.</p>
% else:
<p>T'adjuntem les condicions generals i particulars del teu contracte.</p>
% endif

            % if not object.observacions or 'proces: A3' not in object.observacions:
<p>Recorda que el titular del contracte de subministrament ha de ser l’usuari efectiu de l’electricitat contractada i que ha de tenir un just títol (contracte d’arrendament, etc.) sobre el punt de subministrament.</p>
<p>El procés de canvi de comercialitzadora consta dels següents passos:<br><br>1. <strong>Enviament de la sol·licitud a la distribuïdora</strong>. Pas en el qual estem actualment. Enviem la petició de canvi de comercialitzadora amb les dades facilitades.<br><br>2. <strong>Recepció de la resposta per part de la distribuïdora</strong>. En un període màxim d'una setmana rebrem la resposta de si el procés de canvi de companyia es pot efectuar o si requereixen més informació. Si la sol·licitud s'ha acceptat, t'informarem via correu electrònic de la data prevista d'activació del teu contracte amb Som Energia. En cas contrari, també ens posarem en contacte amb tu.<br><br>3. <strong>Activació del contracte</strong>. Una vegada la distribuïdora ens confirmi que el canvi s’ha fet efectiu i el contracte ja està <strong>actiu</strong> amb la cooperativa t’ho comunicarem per correu electrònic. A partir d'aleshores ja facturarem des de Som Energia, però tingues en compte que encara rebràs l'última factura de la teva antiga comercialitzadora. En cas de voler fer <strong> un canvi de potència</strong> serà a partir d'aquest moment que ho podràs sol·licitar <a href="http://ca.support.somenergia.coop/article/271-com-puc-fer-una-modificacio-de-potencia-o-de-tarifa-i-quant-costa">(més informació)</a>.</p>
            % else:
<p>El procés d’alta de subministrament consta dels següents passos:<br><br>1. <strong>Enviament de la sol·licitud a la distribuïdora.</strong> Pas en què estem actualment. Enviem la petició d’alta amb les dades facilitades.<br><br>2. <strong>Recepció de la resposta per part de la distribuïdora.</strong> En uns dies rebrem la resposta d’inici d’actuacions.<br>    - <em>Si la sol·licitud s'ha acceptat</em>, t'informarem via correu electrònic; en aquest moment, la distribuïdora disposarà de 15 dies per efectuar l’alta de subministrament. En cas necessari, contactaran amb tu al telèfon que vares facilitar en emplenar el formulari.<br>    - <em>En cas contrari,</em> t’informarem dels passos a seguir.<br><br>3. <strong>Activació del contracte.</strong> Quan l’alta sigui efectiva, ens ho faran saber i t’enviarem un darrer correu electrònic indicant la data exacta. Amb aquesta comunicació el procés d’alta haurà finalitzat.<br><br>4. Posteriorment, <strong>a la primera factura</strong> inclourem els costos de l’alta (que cobra la distribuïdora) desglossats. Pots consultar un càlcul orientatiu dels costos en <a href="http://ca.support.somenergia.coop/article/225-no-tinc-llum-actualment-puc-sol-licitar-un-nou-punt-de-consum">aquest enllaç</a>.</p>
            % endif
<p>Informació rellevant en el procés de contractació:</p>
<p>${text_desistiment}</p>
<p dir="ltr"><strong>Quins avantatges tens com a membre de Som Energia?&nbsp;</strong></p>
<ul>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation"><a href="https://www.somenergia.coop/ca/produeix-energia-renovable/" target="_blank" rel="noopener">Participar</a> en projectes renovables amb aportacions a partir de 100 euros.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Accedir a <a href="https://www.somenergia.coop/ca/produeix-energia-renovable/autoproduccio/" target="_blank" rel="noopener">compres col&middot;lectives</a> d&rsquo;instal&middot;lacions fotovoltaiques dom&egrave;stiques.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Acc&eacute;s il&middot;limitat a l&rsquo;<a href="https://aulapopular.somenergia.coop/">Aula Popular</a>, on trobar&agrave;s formacions sobre energia i cooperativisme.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Pots participar en els <a href="https://www.somenergia.coop/ca/participa/escola-de-som-energia/" target="_blank" rel="noopener">Espais de trobada</a> amb altres persones s&ograve;cies</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Tens acc&eacute;s a&nbsp;<a href="https://www.somenergia.coop/ca/altres-activitats/" target="_blank" rel="noopener">Serveis d&rsquo;entitats</a> amb qui tenim signats acords de col&middot;laboraci&oacute;</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation"><a href="http://www.somenergia.coop/ca/contracta-la-llum/" target="_blank" rel="noopener">Contractar el subministrament d&rsquo;electricitat</a> i convidar fins a 5 contractes d&rsquo;altres persones.</p>
</li>
</ul>
<p>A Som Energia <strong>no tens cap obligació de permanència.</strong> En el moment que vulguis, pots canviar de companyia comercialitzadora. Som una cooperativa d’electricitat 100% renovable sense ànim de lucre i un dels nostres principis és oferir el preu més ajustat possible. No oferim ofertes especials, ni clàusules addicionals, ni lletra petita. La transparència, el bon tracte, uns preus ajustats, el treball per un canvi de model energètic, són alguns dels valors de Som Energia i el motiu pel qual tanta gent se suma al projecte i continua amb nosaltres sense cap clàusula de permanència.</p>
<p dir="ltr">A m&eacute;s, podr&agrave;s gestionar i consultar les teves dades, contractes i serveis al teu espai de <a href="https://oficinavirtual.somenergia.coop/ca/" target="_blank" rel="noopener">l'Oficina Virtual</a></p>
<p dir="ltr">Si tens dubtes, al <a href="http://links.somenergia.coop/ls/click?upn=0TIWnd5-2FSibmBIPHvRB-2BipLZJoBdtE76a9j18KyPRYJqP9Z5sZLUJbPDBFba0HUYKKFx_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQDMlnr8Gf-2FWzasSAH21TcRBvLaT7GiyKHTqoZDk6GVPZUViNMc-2FSxWe0F3b4bQN9b1pLT4dKFaozK5RmYwZBFjNGc5Q5hM2IuYfOywT4wUZF1efIxS4-2BL7F7f2bJKrrlJ5kQuqaEXoPFo4SlCSp-2F4zh" target="_blank" rel="noopener">Centre d'Ajuda</a> trobar&agrave;s resolts les consultes m&eacute;s habituals.&nbsp;</p>
<p dir="ltr">&nbsp;</p>
<p dir="ltr"><strong>Vols ajudar-nos a difondre el projecte?&nbsp;</strong></p>
<p dir="ltr">Pots afegir-nos com a amic a <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ01ny-2BuMev4LnSMYwaJUg8B3ZswJ7ZLOkyniDNrY0gFTsHXLh_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQCYrg4GdRFA4-2BG4rPJ2ws8PFfypsvo3wgDLhDb0zVG3zC37D8wfLDBBy96-2FDHEZUwM-2B1ePWdG3oE-2BfyOUnf-2FRNou89EZZwpeP2jo9jXxznSrCdbvTdc1WE-2BZ42b9D2-2BwCOVbzBYO1JlXwnbkpWpBxd-2F" target="_blank" rel="noopener">Facebook</a>, seguir-nos a <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ0zhnivjbQG4gVE1Fjrkp0nue0Xi09k3wEy8NA-2Fjk37LG6Cet_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQDumtX9i7lgoywek2gVJA70fPMGCbDfCi8QEr5pN6X5jFjSpH3MgOri9-2FTgTLavCypO-2FnztQncsdAYTkgqCOXO-2BUtt-2F8Uda11ZjZPvVbhCYA31tPD14vUKw0zFnUSaJZ-2BKuxcmMAxTgDjJVEWtyw83R" target="_blank" rel="noopener">Twitter</a>, <a href="https://www.instagram.com/somenergia/" target="_blank" rel="noopener">Instagram</a> o <a href="https://t.me/somenergia" target="_blank" rel="noopener">Telegram</a>.</p>
<p dir="ltr">Si vols participar de la cooperativa d'una forma m&eacute;s activa, pots unir-te al <a href="https://www.somenergia.coop/ca/participa/#grupslocals" target="_blank" rel="noopener">Grup local</a> de la teva zona.&nbsp;</p>
<p dir="ltr">Finalment, pots <a href="https://blog.somenergia.coop/" target="_blank" rel="noopener">subscriure&rsquo;t al nostre blog</a> per estar al dia de les nostres not&iacute;cies.&nbsp;</p>
<p dir="ltr">&nbsp;</p>
<p>Moltes gràcies per triar bona energia!<br><br>Atentament,</p>
<p>Equip de Som Energia<br><a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br><a href="https://www.somenergia.coop/ca">www.somenergia.coop</a></p>


        % else:
<p>&iexcl;Bienvenido/a a Som Energia!<br><br></p>
<p dir="ltr">Nos alegra que formes parte de la cooperativa que construye un modelo energ&eacute;tico renovable en manos de la ciudadan&iacute;a, desde la participaci&oacute;n y la transparencia. Esperamos poder conseguir juntas nuestro objetivo de transformar el modelo energ&eacute;tico, apostando por las energ&iacute;as renovables y la eficiencia energ&eacute;tica.</p>
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="width: 100%;"><fieldset>
<p align="center">N&uacute;mero de socio/a: <strong>${object.soci.ref | socifilter}</strong></p>
<p align="center">Nombre: ${object.soci.name}</p>
<p align="center">Fecha de ingreso: ${ingres}</p>
<p align="center">Aportaci&oacute;n obligatoria al capital social: 100&euro;</p>
<p align="center">Titular del contrato de electricidad: ${object.titular.name}</p>
<p align="center">Dirección punto de suministro: ${object.cups_direccio}</p>
<p align="center">Código CUPS: ${object.cups.name}</p>
<p align="center">Tarifa: ${tarifa_a_mostrar}</p>
% if object.donatiu:
<p align="center">Donativo Voluntario (0,01€/kWh): Si</p>
%endif
%if autoconsum_description:
<p align="center">Modalidad autoconsumo: ${autoconsum_description}</p>
%endif
</fieldset></td>
</tr>
</tbody>
</table>

%if autoconsum_description:
<p>Si tu modalidad de autoconsumo es con compensación de excedentes, también se ha activado el <a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar">Flux Solar</a>.</p>
%endif

% if object.mode_facturacio == "index":
<p>Te adjuntamos las condiciones generales, específicas y particulares de tu contrato.</p>
% else:
<p>Te adjuntamos las condiciones generales y particulares de tu contrato.</p>
% endif

% if not object.observacions or 'proces: A3' not in object.observacions:
<p>Recuerda que el titular del contrato de suministro tiene que ser el usuario efectivo de la electricidad contratada y que tiene que tener un justo título (contrato de arrendamiento, etc.) sobre el punto de suministro.</p>
<p>El proceso de cambio de comercializadora consta de los siguientes pasos:<br>1. <strong>Envío de la solicitud a la distribuidora</strong>. Paso en el que estamos en estos momentos. Enviamos la petición de cambio de comercializadora con los datos facilitados.<br><br>2. <strong>Recepción de la respuesta por parte de la distribuidora</strong>. En un periodo máximo de una semana, recibiremos la respuesta de si el proceso de cambio de compañía se puede efectuar, o si requieren más información. Si la solicitud se ha aceptado, te informaremos vía correo electrónico de la fecha prevista de activación de tu contrato con Som Energia. En caso contrario, también nos pondremos en contacto contigo.<br><br>3. <strong> Activación del contrato </strong>. Una vez la distribuidora nos confirme que el cambio se ha hecho efectivo y que el contrato ya está <strong>activo</strong> con la cooperativa, te lo comunicaremos por correo electrónico. A partir de entonces ya facturaremos desde Som Energia, pero ten en cuenta que aún recibirás la última factura de tu antigua comercializadora. En caso de querer hacer <strong> un cambio de potencia</strong> será a partir de este momento cuando lo podrás solicitar <a href="http://es.support.somenergia.coop/article/284-como-puedo-hacer-una-modificacion-de-potencia-o-de-tarifa-y-cuanto-cuesta">(más información)</a>.<br><br></p>
% else:
<p>El proceso de alta de suministro consta de los siguientes pasos:<br>1. <strong>Envío de la solicitud a la distribuidora.</strong> Paso en el que estamos actualmente. Enviamos la petición de alta con los datos facilitados.<br><br>2. <strong>Recepción de la respuesta por parte de la distribuidora.</strong> En unos días recibiremos la respuesta de inicio de actuaciones.<br>    - <em>Si la solicitud se acepta,</em> te informaremos vía correo electrónico; en ese momento, la distribuidora dispondrá de 15 días para efectuar el alta de suministro. Si fuera necesario, contactará contigo al teléfono que facilitaste al rellenar el formulario.<br>    - <em>De lo contrario,</em> te informaremos de las gestiones necesarias.<br><br>3. <strong>Activación del contrato.</strong> Cuando el alta sea efectiva, nos lo comunicarán y te enviaremos un último correo electrónico indicando la fecha exacta. Con esta comunicación, el proceso de alta habrá finalizado.<br><br>4. Posteriormente, en <strong>la primera factura</strong> se reflejará el coste del alta (que cobra la distribuidora) desglosado. Puedes consultar un cálculo orientativo en <a href="http://es.support.somenergia.coop/article/245-no-tengo-luz-actualmente-puedo-solicitar-un-nuevo-punto-de-consumo">este enlace</a>.</p>
% endif

<p>Información referente al proceso de contratación:</p>
<p>${text_desistiment}</p>

<p dir="ltr"><strong>&iquest;Qu&eacute; ventajas tienes como miembro de Som Energia?</strong></p>
<ul>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Puedes <a href="https://www.somenergia.coop/es/produce-energia-renovable/" target="_blank" rel="noopener">participar</a> en proyectos renovables con aportaciones a partir de 100&euro;.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Acceder a <a href="https://www.somenergia.coop/es/produce-energia-renovable/autoproduccion/" target="_blank" rel="noopener">compras colectivas</a> de instalaciones fotovoltaicas dom&eacute;sticas.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Acceso ilimitado al <a href="https://aulapopular.somenergia.coop/es/inicio/" target="_blank" rel="noopener">Aula Popular</a>, donde encontrar&aacute;s formaciones sobre energ&iacute;a y cooperativismo.</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Puedes <a href="https://www.somenergia.coop/es/participa/" target="_blank" rel="noopener">participar</a> en los Espacios de encuentro con otras personas socias</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Tienes acceso a los <a href="https://www.somenergia.coop/es/otras-actividades/" target="_blank" rel="noopener">servicios de entidades</a> con los que tenemos firmados acuerdos de colaboraci&oacute;n</p>
</li>
<li dir="ltr" aria-level="1">
<p dir="ltr" role="presentation">Puedes <a href="https://www.somenergia.coop/es/contrata-la-luz/" target="_blank" rel="noopener">contratar el suministro de electricidad</a> e invitar hasta a 5 contratos de otras personas.</p>
</li>
</ul>

<p>En Som Energia <strong>no tienes obligación de permanencia.</strong> Cuando quieras, puedes cambiar de compañia comercializadora. Somos una cooperativa 100% renovable sin ánimo de lucro y uno de nuestros principios es ofrecer el precio lo más ajustado posible. No ofrecemos ofertas especiales, ni cláusulas adicionales ni letra pequeña. La transparencia, el buen trato, unos precios ajustados, el trabajo para un cambio de modelo energético, son algunos de los valores de Som Energia y el motivo por el cual tanta gente se suma al proyecto y sigue con nosotros, sin ninguna cláusula de permanencia.</p>
<p dir="ltr">Adem&aacute;s, podr&aacute;s gestionar y consultar tus datos, contratos y servicios en <a href="https://oficinavirtual.somenergia.coop/es/login/" target="_blank" rel="noopener">tu espacio de la Oficina Virtual.</a></p>
<p dir="ltr">Si tienes dudas, en el <a href="https://es.support.somenergia.coop/" target="_blank" rel="noopener">Centro de Ayuda</a> encontrar&aacute;s resueltas las consultas m&aacute;s habituales.</p>
<p><strong>&nbsp;</strong></p>
<p dir="ltr"><strong>&iquest;Quieres ayudarnos a difundir el proyecto?</strong></p>
<p dir="ltr">Puedes a&ntilde;adirnos como amigo en <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ01ny-2BuMev4LnSMYwaJUg8B3ZswJ7ZLOkyniDNrY0gFTsHXLh_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQCYrg4GdRFA4-2BG4rPJ2ws8PFfypsvo3wgDLhDb0zVG3zC37D8wfLDBBy96-2FDHEZUwM-2B1ePWdG3oE-2BfyOUnf-2FRNou89EZZwpeP2jo9jXxznSrCdbvTdc1WE-2BZ42b9D2-2BwCOVbzBYO1JlXwnbkpWpBxd-2F" target="_blank" rel="noopener">Facebook</a>, seguirnos en <a href="http://links.somenergia.coop/ls/click?upn=83HzMisLio5Lsskq9pHZ0zhnivjbQG4gVE1Fjrkp0nue0Xi09k3wEy8NA-2Fjk37LG6Cet_-2BHB8d5C343hfLp7ljYtulZRPdYJjccH-2By-2F0RP75QR3-2FKTPuW1Vuj-2Fk31dntYYC6WmtwCyKxRepGYjZADTq6hx6bjpKGZE7tCeNqS8-2BaWUQDumtX9i7lgoywek2gVJA70fPMGCbDfCi8QEr5pN6X5jFjSpH3MgOri9-2FTgTLavCypO-2FnztQncsdAYTkgqCOXO-2BUtt-2F8Uda11ZjZPvVbhCYA31tPD14vUKw0zFnUSaJZ-2BKuxcmMAxTgDjJVEWtyw83R" target="_blank" rel="noopener">Twitter</a>, <a href="https://www.instagram.com/somenergia/" target="_blank" rel="noopener">Instagram</a> o <a href="https://t.me/somenergia_es" target="_blank" rel="noopener">Telegram</a>.</p>
<p dir="ltr">Si quieres participar de la cooperativa de forma m&aacute;s activa, puedes unirte al <a href="https://www.somenergia.coop/es/participa/#gruposlocales" target="_blank" rel="noopener">Grupo local de tu zona</a>.</p>
<p dir="ltr">Por &uacute;ltimo, puedes <a href="https://blog.somenergia.coop/" target="_blank" rel="noopener">suscribirte a nuestro blog</a> para estar al d&iacute;a de nuestras noticias.</p>
<p>&nbsp;</p>

<p>¡Muchas gracias por escoger consumir buena energía!<br><br>Atentamente,</p>
<p>Equip de Som Energia<br><a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br><a href="http://www.somenergia.coop">www.somenergia.coop</a></p>
        % endif

${plantilla_footer}
