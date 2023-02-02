<%
import datetime
data_inici = datetime.datetime.strptime(object.data_inici, '%Y-%m-%d').strftime('%d-%m-%Y')
data_final = datetime.datetime.strptime(object.data_final, '%Y-%m-%d').strftime('%d-%m-%Y')
id_soci_fact= object.polissa_id.soci.id
id_soci_energetica = 38039

polissa_retrocedida = False
de_lot = object.lot_facturacio and object.lot_facturacio.id != False
if de_lot:
    clot_obj = object.pool.get('giscedata.facturacio.contracte_lot')
    clot_id = clot_obj.search(object._cr, object._uid, [('polissa_id', '=', object.polissa_id.id), ('lot_id', '=', object.lot_facturacio.id)])
    if clot_id:
        n_retrocedir_lot = clot_obj.read(object._cr, object._uid, clot_id[0], ['n_retrocedir_lot'])['n_retrocedir_lot']
        polissa_retrocedida = n_retrocedir_lot > 0
%>
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

def getLink(language, potencia):
    link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-la-factura-per-a-contractes-domestics-i-petites-empreses/"
    if potencia > 15.0:
        link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-factura-per-a-contractes-dempreses-de-mes-de-15-kw/" if language != "es_ES" else "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-cambio-de-factura-para-contratos-de-empresas-de-mas-de-15-kw/"
    else:
        link = "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-canvi-de-la-factura-per-a-contractes-domestics-i-petites-empreses/" if language != "es_ES" else "https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2021/02/el-cambio-de-la-factura-para-contratos-domesticos-y-pequenas-empresas/"
    return link

def isTariffChange(f):
    ppu = {}
    for line in f.linies_energia:
        if line.name in ppu:
            if line.price_unit != ppu[line.name]:
                return True
        else:
            ppu[line.name] = line.price_unit
    ppu = {}
    for line in f.linies_potencia:
        if line.name in ppu:
            if line.price_unit != ppu[line.name]:
                return True
        else:
            ppu[line.name] = line.price_unit
    return False

%>
% if id_soci_fact == id_soci_energetica:
<div align="right"><img src="https://blog.somenergia.coop/wp-content/uploads/2018/10/som-energia-energetica-logos.jpg"></div>
% endif:
% if id_soci_fact != id_soci_energetica:
<div align="right"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></div>
% endif:
% if object.partner_id.lang != "es_ES":
<p><br>Benvolgut, benvolguda,</p>
<p>T'enviem
% if not polissa_retrocedida:
la
% else:
una altra
%endif
<strong>factura</strong> d'electricitat de Som Energia.</p>
% if polissa_retrocedida:
<p>Aquest mes has rebut m&eacute;s d&rsquo;una factura a causa d'un endarreriment de les factures, o perqu&egrave; la distribu&iuml;dora ens ha enviat lectures d&rsquo;un per&iacute;ode m&eacute;s curt. Si vols, podem canviar la data de venciment per cobrar-la quan et vagi millor.</p>
% endif
<p dir="ltr">Com sempre, carregarem l'import d'aquesta factura al teu n&uacute;mero de compte durant els pr&ograve;xims dies.</p>
<p dir="ltr"><span style="text-decoration: underline;"><strong>Resum del contingut de la factura</strong></span></p>
<ul>
<li>N&uacute;mero de factura: ${object.number}</li>
<li>El per&iacute;ode facturat &eacute;s del<strong id="docs-internal-guid-6536ca4e-7fff-dbd9-04a0-3e9d7d100756"> </strong>${data_inici} al ${data_final}</li>
<li>Titular del contracte: ${object.polissa_id.titular.name}</li>
<li>N&uacute;mero de contracte: ${object.polissa_id.name}</li>
<li>Codi CUPS: ${object.cups_id.name}</li>
<li>Adre&ccedil;a del punt de subministrament: ${object.cups_id.direccio}</li>
<li><strong><strong id="docs-internal-guid-531dd379-7fff-ff8b-79e9-ac3d592033e4">Import a carregar</strong>: ${object.invoice_id.amount_total}</strong>&euro;</li>
</ul>
<p dir="ltr">Al Centre d'Ajuda t'expliquem <a href="https://ca.support.somenergia.coop/article/488-entendre-la-factura">els diferents apartats de la factura</a>.</p>
<p dir="ltr">Pots accedir a l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> per veure les teves factures i gestionar els contractes que tens amb la cooperativa. Si hi detectes algun error, ens ho pots comunicar responent a aquest mateix correu.&nbsp;</p>
<p dir="ltr">Aprofitem per recordar-te que els per&iacute;odes horaris que t&rsquo;afecten s&oacute;n els que descrivim al nostre web. Si tens la tarifa 2.0TD (la que tenen la majoria de contractes dom&egrave;stics), continues tenint vigents els tres per&iacute;odes: punta, pla i vall (descrits a l&rsquo;<a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/#tarifa20TD">apartat de tarifes</a> del web, i en <a href="https://ca.support.somenergia.coop/article/1003-la-tarifa-2-0td">aquest article</a> del Centre d&rsquo;Ajuda). No cal que facis cas del que diuen alguns mitjans de comunicaci&oacute; i aplicacions sobre &ldquo;l&rsquo;hora m&eacute;s barata del dia&rdquo;, ja que es refereixen &uacute;nicament a les tarifes del mercat regulat, i Som Energia est&agrave; al mercat lliure.<strong id="docs-internal-guid-e9117f73-7fff-25dd-bcc5-080017a0d8b8"></strong></p>
% if isTariffChange(object):
<p>Com que en el per&iacute;ode que compr&egrave;n la teva factura hi ha hagut un canvi de tarifes, una part del terme d&rsquo;energia i del terme de pot&egrave;ncia est&agrave; facturada amb les tarifes d&rsquo;abans del canvi, i l&rsquo;altra part est&agrave; facturada amb les noves tarifes. Aix&ograve; fa que, a la factura, apareguin dues l&iacute;nies (amb els dos preus) de cadascun dels conceptes d&rsquo;energia i pot&egrave;ncia.</p>
% endif
<p>Atentament,</p>
<p>Equip de Som Energia</p>
<a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://www.somenergia.coop/factura/dubtes_socia_som_energia.png" alt="" width="189" height="182"></a>
<p dir="ltr" style="text-align: center;"><a href="https://ca.support.somenergia.coop/article/926-que-puc-fer-si-estic-en-desacord-amb-la-factura-de-la-llum"><strong>Resol els teus dubtes amb la factura</strong></a></p>
% endif
% if object.partner_id.lang != "ca_ES" and object.partner_id.lang != "es_ES":
<p>----------------------------------------------------------------------------------------------------</p>
% endif
% if object.partner_id.lang != "ca_ES":
<p><br>Estimado, estimada,</p>
<p>Te enviamos
% if not polissa_retrocedida:
la
% else:
otra
%endif
<strong>factura</strong> de electricidad de Som Energia.</p>
% if polissa_retrocedida:
<p>Este mes has recibido m&aacute;s de una factura debido a un retraso de las facturas, o porque la distribuidora nos ha enviado lecturas de un per&iacute;odo m&aacute;s corto. Si quieres, podemos cambiar la fecha de vencimiento para cobrarla cuando te vaya mejor.</p>
% endif
<p dir="ltr">En el Centro de Ayuda te explicamos <a href="https://es.support.somenergia.coop/article/489-entender-la-factura-20td">los diferentes apartados de la factura</a>.</p>
<p dir="ltr">Como siempre, cargaremos el importe de esta factura en tu n&uacute;mero de cuenta durante los pr&oacute;ximos d&iacute;as.</p>
<p dir="ltr"><span style="text-decoration: underline;"><strong>Resumen del contenido de la factura</strong></span></p>
<ul>
<li>N&uacute;mero factura: ${object.number}</li>
<li>El periodo facturado es del ${data_inici} al ${data_final}</li>
<li>Titular del contrato: ${object.polissa_id.titular.name}</li>
<li>N&uacute;mero de contrato: ${object.polissa_id.name}</li>
<li>Codigo CUPS: ${object.cups_id.name}</li>
<li>Direcci&oacute;n del punto de suministro: ${object.cups_id.direccio}</li>
<li><strong>Importe a cargar: ${object.invoice_id.amount_total}</strong>&euro;</li>
</ul>
<p dir="ltr">Puedes acceder a la <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a> para ver tus facturas y gestionar tus contratos con la cooperativa. Si detectas alg&uacute;n error, puedes comunicarlo respondiendo a este mismo correo.</p>
<p dir="ltr">Aprovechamos para recordarte que los periodos horarios que te afectan son los que describimos en nuestro web. Si tienes la tarifa 2.0TD (la que tienen la mayor&iacute;a de contratos dom&eacute;sticos), sigues teniendo vigentes los tres periodos: punta, llano y valle (descritos en el&nbsp;<a href="https://www.somenergia.coop/es/tarifas-de-electricidad/">apartado de tarifas</a> del web, y en <a href="https://es.support.somenergia.coop/article/1004-la-tarifa-2-0td">este art&iacute;culo</a> del Centro de Ayuda). No hace falta que hagas caso de lo que dicen algunos medios de comunicaci&oacute;n y aplicaciones sobre &ldquo;la hora m&aacute;s barata del d&iacute;a&rdquo;, ya que se refieren &uacute;nicamente a las tarifas del mercado regulado, y Som Energia est&aacute; en el mercado libre.</p>
% if isTariffChange(object):
<p>Como en el periodo que comprende tu factura ha habido un cambio de tarifas, una parte del t&eacute;rmino de energ&iacute;a y del t&eacute;rmino de potencia est&aacute; facturada con las tarifas de antes del cambio, y la otra parte est&aacute; facturada con las nuevas tarifas. Esto hace que, en la factura, aparezcan dos l&iacute;neas (con los precios distintos) de cada uno de los conceptos de energ&iacute;a y potencia.</p>
% endif
<p>Atentamente,</p>
<p>Equipo de Som Energia</p>
<a href="https://es.support.somenergia.coop/article/927-que-puedo-hacer-si-estoy-en-desacuerdo-con-la-factura-de-la-luz"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://www.somenergia.coop/factura/dubtes_socia_som_energia.png" alt="" width="189" height="182"></a>
<p dir="ltr" style="text-align: center;"><strong><a href="https://es.support.somenergia.coop/article/927-que-puedo-hacer-si-estoy-en-desacuerdo-con-la-factura-de-la-luz">Resuelve tus dudas con la factura</a></strong></p>
<p style="text-align: center;">&nbsp;</p>
% endif
<p>${text_legal}</p>