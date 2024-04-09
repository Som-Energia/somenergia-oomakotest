<!doctype html>
<html>
<body>
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
%>
<%
try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, object.polissa_id.titular.vat):
    nom_titular =' ' + object.polissa_id.titular.name.split(',')[1].lstrip()
  else:
    nom_titular = ''
except:
  nom_titular = ''
%>
<br>
% if  object.polissa_id.titular.lang != "es_ES":
<br>
<p>Bon dia ${nom_titular},</p>
<br>
<p>Ens posem en contacte amb tu per consultar-te sobre el contracte ${object.polissa_id.name} amb CUPS ${object.polissa_id.cups.name} situat a ${object.polissa_id.cups.direccio}, gestionat per Som Energia, per saber si es tracta d'un <b>Punt de Subministrament Essencial</b>.</p>
<p>L'empresa distribuïdora E-DISTRIBUCIÓN REDES DIGITALES S. L. ha contactat amb la cooperativa per aclarir aquesta situació.</p>
<p>Aquests subministraments disposen d’una protecció oficial perquè <b>no se’ls pot suspendre el subministrament elèctric</b>. Segons l’article 52 de la Llei 24/2013, de 26 de desembre, del Sector Elèctric, es poden considerar subministraments essencials els que compleixin algun dels criteris següents:</p>
<ol>
<li><b>Enllumenat públic</b> a càrrec de les administracions públiques. No s’hi inclouen els enllumenats ornament​als de places, monuments, fonts o de qualsevol altre edifici o lloc d’interès.</li>
<li><b>Subministrament d’aigües</b> per al consum humà a través de xarxa.</li>
<li><b>Aquarteraments i institucions directament vinculades a la defensa nacional, a les forces i els cossos de seguretat, als bombers, a protecció civil i a la policia municipal</b>, llevat de les construccions dedicades a habitatges, economat i zones d’esbarjo del personal.</li>
<li><b>Centres penitenciaris</b>, però no els seus annexos dedicats a la població no reclusa, així com seus de jutjats i tribunals.</li>
<li><b>Transports de servei públic</b> i els seus equipaments i les installacions dedicades directament a la seguretat del trànsit terrestre, marítim o aeri.</li>
<li><b>Centres sanitaris on hi hagi sales d’operacions, sales de cures i aparells d’alimentació elèctrica acoblables als pacients.</b></li>
<li><b>Hospitals.</b></li>
<li><b>Serveis funeraris.</b></li>
<li><a href="https://ca.support.somenergia.coop/article/827-dependencia-energetica-per-motius-de-salut">Dependència energètica per motius de salut</a>. En aquest cas, les persones que us trobeu en aquesta situació ens heu de fer arribar el <b><u>certificat mèdic</u></b> que ho acredita responent aquest mateix correu.</li>
</ol>
<br>
<p>Si aquest punt de subministrament és un Punt de Subministrament Essencial, indiqueu-nos-el responent aquest mateix correu electrònic.</p>
<p><b><u>Quedem a l’espera de la teva resposta.</u></b></p>
<p>Salutacions,</p>
<br>
<p> Equip de Som Energia</p>
<p><a href="https://www.somenergia.coop/ca/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<br>
<p>Buenos días ${nom_titular},</p>
<br>
<p>Nos ponemos en contacto contigo para consultarte sobre el contrato ${object.polissa_id.name} con CUPS ${object.polissa_id.cups.name} situado a ${object.polissa_id.cups.direccio}, gestionado por Som Energia, para saber si se trata de un <b>Punto de Suministro Esencial</b>.</p>
<p>La empresa distribuidora E-DISTRIBUCIÓN REDES DIGITALES S. L. ha contactado con la cooperativa para aclarar esta situación.</p>
<p>Estos suministros disponen de una protección oficial porque <b>no se les puede suspender el suministro eléctrico</b>. Según el artículo 52 de la Ley 24/2013, de 26 de diciembre, del Sector Eléctrico, se pueden considerar suministros esenciales los que cumplan alguno de los criterios siguientes:</p>
<ol>
<li><b>Alumbrado público</b> a cargo de las administraciones públicas. No se incluyen los alumbrados ornamentales de plazas, monumentos, fuentes o de cualquier otro edificio o lugar de interés.</li>
<li><b>Suministro de aguas</b> para el consumo humano a través de red.</li>
<li><b>Acuartelamientos e instituciones directamente vinculadas a la defensa nacional, a las fuerzas y los cuerpos de seguridad, a los bomberos, a protección civil y a la policía municipal</b>, salvo las construcciones dedicadas a viviendas, economato y zonas de recreo del personal.</li>
<li><b>Centros penitenciarios</b>, pero no sus anexos dedicados a la población no reclusa, así como sientas de juzgados y tribunales.</li>
<li><b>Transportes de servicio público</b> y sus equipaciones y las instalaciones dedicadas directamente a la seguridad del tráfico terrestre, marítimo o aéreo.</li>
<li><b>Centros sanitarios donde haya salas de operaciones, salas de curas y aparatos de alimentación eléctrica acoplables a los pacientes.</b></li>
<li><b>Hospitales.</b></li>
<li><b>Servicios funerarios</b></li>
<li><a href="https://ca.support.somenergia.coop/article/827-dependencia-energetica-per-motius-de-salut">Dependencia energética por motivos de salud</a>. En este caso, las personas que os encontréis en esta situación, tenéis que enviarnos el <b>certificado médico</b> que lo acredite respondiendo este mismo correo.</li>
</ol>
<br>
<p>Si este punto de suministro es un Punto de Suministro Esencial, indicádnoslo respondiendo este mismo correo electrónico.</p>
<p><b><u>Quedamos a la espera de tu respuesta.</u></b></p>
<p>Saludos,</p>
<br>
<p> Equipo de Som Energia</p>
<p> <a href="https://www.somenergia.coop/es/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif

<p>${text_legal}</p>
</body>
</html>