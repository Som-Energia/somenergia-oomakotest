<!doctype html>
<html>
<head><meta charset="utf-8"/></head>
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

try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, object.polissa_id.titular.vat):
    nom_titular = ' ' + object.polissa_id.titular.name.split(',')[1].lstrip()
  else:
    nom_titular = ''
except:
  nom_titular = ''

gp_obj = object.pool.get('giscedata.polissa')
amb_auto_compensacio = gp_obj.read(object._cr, object._uid, object.polissa_id.id, ['autoconsumo'])['autoconsumo'] in ['41','42','43']
%>
<body>
<!-- CATALÀ -->
% if object.polissa_id.titular.lang != "es_ES":
<p>Hola${nom_titular},</p>

% if amb_auto_compensacio:
<p>Estem molt contentes de poder anunciar-te que&nbsp;<strong>d'aquí a un mes entrarà en funcionament el Flux Solar</strong>, l'eina que permetrà obtenir un descompte pels excedents generats d'autoproducció que no s'hagin compensat a la factura.</p>
<p>Som conscients que és una millora esperada des de fa temps, i ens hauria agradat poder oferir-la abans, però és un desenvolupament complex, i lamentablement no ens ha estat possible.</p>
<p>Posar en marxa el Flux Solar suposa un&nbsp;<strong>canvi a les Condicions Generals</strong> del contracte de subministrament d'energia elèctrica, i aprofitem per actualitzar alguna altra modificació que teníem pendent. A continuació et resumim el més important de cada punt.</p>
% else:
<p>Després de molts mesos treballant-hi, estem a punt de poder posar en marxa el&nbsp;<strong>Flux Solar</strong>, l'eina que permetrà, a les persones i empreses que tenen autoproducció amb compensació simplificada, obtenir un descompte pels excedents generats que no se'ls hagi compensat. Si estàs pensant a posar-te plaques solars, o coneixes persones que en tenen, això us pot interessar.&nbsp;</p>
<p>Posar en marxa aquesta eina suposa un&nbsp;<strong>canvi a les Condicions Generals</strong> del contracte de subministrament d'energia elèctrica, i aprofitem per actualitzar alguna altra modificació que teníem pendent. Les noves Condicions Generals&nbsp;<strong>s'aplicaran automàticament a partir del 18 de novembre&nbsp;</strong>(no cal fer res, ni signar el document ni enviar-lo).&nbsp;</p>
% endif
<br>
% if amb_auto_compensacio:
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
        <tbody>
            <tr>
                <td>
                    <p><strong>Flux Solar</strong></p>
                    <ul style="display: grid;">
                        <li style="padding-bottom:1em"><strong>De què va, exactament?</strong> Els excedents d'autoproducció generats que no s'hagin pogut compensar a la factura del període en qüestió, es guarden en forma de “Sols”, descomptes que s'afegiran a les factures posteriors.</li>
                        <li style="padding-bottom:1em"><strong>Quan es posarà en marxa?</strong> El Flux Solar es posarà en marxa amb el canvi de condicions generals, el dia 18 de novembre. A partir d'aquesta data ja podràs tenir factures amb el descompte aplicat.</li>
                        <li style="padding-bottom:1em"><strong>Què he de fer perquè se m'activi?</strong> No cal que facis res, serà automàtic. Quan s'activi el Flux Solar, a la teva Oficina Virtual ja apareixeran els Sols que hagis pogut generar des de gener de 2022 (sempre que hagis mantingut el teu contracte actiu amb Som Energia i tinguis la compensació simplificada d'excedents activada).</li>
                        <li style="padding-bottom:1em"><strong>De quant serà el descompte?</strong> El descompte serà del 80% del valor dels excedents no compensats en la teva facturació mensual (amb el límit de no tenir factures negatives).</li>
                        <li><strong>Tinc més dubtes… →</strong> a la&nbsp;<a href="https://blog.somenergia.coop/?p=45977"><u>notícia del blog</u></a> t'expliquem a quina part de la factura es descompta, per què s'aplica un 80%, com veure els Sols disponibles i la resta de característiques del Flux Solar. Al Centre d'Ajuda trobaràs&nbsp;<a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar"><u>un article</u></a> amb més detalls.</li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    <figure class="table">
                        <table  align="center" style="background-color: #98A43C;" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr align="center">
                                    <td align="center" style="border-radius: 2px;text-align: center;" bgcolor="#98A43C">
                                        <a href="https://blog.somenergia.coop/?p=45977" target="_blank" style="padding: 8px 12px; border: 1px solid #98A43C;border-radius: 2px;font-family: Arial, Helvetica, sans-serif;font-size: 14px; color: #ffffff;text-decoration: none;font-weight:bold;display: inline-block;">
                                            Vull saber-ne més!
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                </td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
% endif
<figure class="table">
    <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
        <tbody>
            <tr>
                <td>
                    % if amb_auto_compensacio:
                    <p><strong>Altres canvis a les Condicions Generals:</strong></p>
                    <ul style="display: grid;padding-bottom: 1em">
                    % else:
                    <p><strong>A continuació et resumim els canvis:</strong></p>
                    <ul style="display: grid;padding-bottom: 1em">
                        <li style="padding-bottom:1em"><strong>Flux Solar (clàusula 8.6)</strong>: a tots els contractes que tinguin autoproducció activada amb compensació simplificada se'ls aplicarà, automàticament, el Flux Solar: una eina que atorga descomptes pels excedents d'autoproducció no compensats. Aquests descomptes s'aplicaran a les properes factures, i el seu valor serà del 80% del valor dels excedents no compensats. Tots els detalls els expliquem en&nbsp;<a href="https://blog.somenergia.coop/?p=45977"><u>aquesta notícia</u></a> del blog.</li>
                    % endif
                        <li style="padding-bottom:1em"><strong>Modificacions de contracte (clàusula 9.5)</strong>: hi ha algunes modificacions de contracte que no és possible tramitar alhora. És a dir:
                        <ul style="display: grid;padding-top: 1em">
                            <li style="padding-bottom:1em">Si estàs tramitant un canvi de tarifa (de períodes a indexada o a l'inrevés), no pots iniciar una modificació contractual (de potència, de tensió, de modalitat d'autoproducció…). Hauràs d'esperar que es faci efectiu el canvi de tarifa (si tot va com està previst, a partir de l'endemà de la factura següent), per poder demanar qualsevol altre canvi.</li>
                            <li style="padding-bottom:1em">Si estàs tramitant una modificació contractual (de potència, de tensió, de modalitat d'autoproducció…), i et decideixes a canviar la tarifa (de períodes a indexada o a la inversa), hauràs d'esperar que es faci efectiva la modificació contractual (aproximadament, entre una i tres setmanes, segons el tràmit), abans de fer la petició de canvi de tarifa.</li>
                            <li style="list-style: none;padding-bottom:1em">Aquest afegit a les Condicions Generals és per adaptar-les a la nova tarifa indexada que tenim disponible des de l'estiu. En teniu tota la informació al <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">web</a> i al <a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2023/07/la-nova-tarifa-indexada/">blog</a>.</li>
                        </ul>
                        </li>
                        <li style="padding-bottom:1em"><strong>Baixa de punt de subministrament (clàusula 6.5):</strong> especifiquem que les baixes de subministrament corresponen, legalment, a les&nbsp;<a href="https://ca.support.somenergia.coop/article/655-les-distribuidores-d-electricitat"><u>empreses distribuïdores</u></a>. Des de Som Energia (empresa&nbsp;<a href="https://ca.support.somenergia.coop/article/660-la-comercialitzacio-delectricitat"><u>comercialitzadora</u></a>), quan rebem una petició de baixa de subministrament, la trametem a la distribuïdora corresponent, que té un termini per fer efectiva la baixa. Per això, des de Som Energia no podem garantir en quina data es farà efectiva. D'altra banda, pot ser que la distribuïdora necessiti accedir a l'equip de mesura (comptador d'electricitat) per poder fer una última lectura de dades. Per tant, si mai deixes un habitatge o local i vols donar de baixa l'electricitat, és possible que, després d'haver-nos-ho sol·licitat, hagis de facilitar l'accés al comptador a l'empresa distribuïdora. La factura final a pagar serà fins a la data en què la distribuïdora faci efectiva la baixa.&nbsp;</li>
                        <li style="padding-bottom:1em"><strong>Activació d'autoconsum (clàusula 8.1):&nbsp;</strong>quan, a Som Energia, una distribuïdora ens tramet una petició d'activació d'autoconsum d'un contracte, des de la cooperativa enviem un correu a la persona o entitat titular d'aquell contracte perquè confirmi que les dades són correctes. Des de fa un temps, algunes vegades (no sempre), la distribuïdora activa el canvi de modalitat sense esperar que hi hagi la confirmació per part de la persona o entitat titular. En aquests casos, des de Som Energia aplicarem el canvi a la modalitat d'autoconsum corresponent, entenent que si la persona titular no ha respost, ha acceptat tàcitament el canvi. En tots els casos, en el moment d'activar la modalitat d'autoconsum, des de Som Energia enviarem un correu informant-ne la persona o entitat titular.</li>
                        <li style="padding-bottom:1em"><strong>Petites modificacions</strong> per adaptar les condicions a la nova redacció de la&nbsp;<a href="https://www.boe.es/buscar/act.php?id=BOE-A-2007-20555"><u>Llei general de defensa de les persones consumidores i usuàries</u></a>, enfocades a protegir millor a les persones i empreses consumidores. Es modifiquen alguns conceptes per tal que quedin més clars i definits, i que no canvien substancialment el sentit de les condicions existents.&nbsp;</li>
                        <li style="padding-bottom:1em"><strong>Adaptació de la mida de la tipografia i l'interlineat&nbsp;</strong>de les condicions generals, per tal de facilitar-ne la lectura i que sigui més inclusiu.</li>
                    </ul>
                </td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
<p>T'adjuntem en aquest correu les noves condicions generals, en un arxiu on també hi ha les condicions específiques (en cas que tinguis tarifa indexada) i les condicions particulars. Si hi estàs d'acord,&nbsp;<strong>no cal que ens retornis el document signat</strong>, ja que aquesta actualització s'aplicarà automàticament el 18 de novembre. Igualment, hem d'informar-te que si, per alguna raó, aquests canvis et fessin replantejar la teva pertinença a la cooperativa, podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia de finalització del contracte, amb els preus vigents a cada moment.</p>
<p>&nbsp;</p>
<p>Una salutació cordial,</p>
<p>&nbsp;</p>
<p>Equip de Som Energia</p>
<p><a href="https://www.somenergia.coop/ca"><u>www.somenergia.coop</u></a></p>
% endif
<!-- FI CATALÀ -->
<!-- CASTELLÀ -->
% if object.polissa_id.titular.lang != "ca_ES":
<p>Hola${nom_titular},</p>

% if amb_auto_compensacio:
<p>Estamos muy contentas de poder anunciarte que <strong>de aqu&iacute; a un mes entrar&aacute; en funcionamiento el Flux Solar,</strong> la herramienta que permitir&aacute; obtener un descuento por los excedentes generados de autoproducci&oacute;n que no se hayan compensado en la factura.</p>
<p>Somos conscientes de que es una mejora esperada desde hace tiempo, y nos habr&iacute;a gustado poder ofrecerla antes, pero es un desarrollo complejo, y lamentablemente no nos ha sido posible.&nbsp;</p>
<p>Poner en marcha el Flux Solar supone un <strong>cambio en las Condiciones Generales</strong> del contrato de suministro de energ&iacute;a el&eacute;ctrica, y aprovechamos para actualizar alguna otra modificaci&oacute;n que ten&iacute;amos pendiente. A continuaci&oacute;n, te resumimos lo m&aacute;s importante de cada punto.</p>
% else:
<p>Despu&eacute;s de muchos meses trabajando, estamos a punto de poner en marcha el <strong>Flux Solar</strong>, la herramienta que permitir&aacute;, a las personas y empresas que tienen autoproducci&oacute;n con compensaci&oacute;n simplificada, obtener un descuento por los excedentes generados que no se les haya compensado. Si est&aacute;s pensando en ponerte placas solares, o conoces personas que tienen, esto os puede interesar.</p>
<p>Poner en marcha esta herramienta supone un <strong>cambio en las Condiciones Generales</strong> del contrato de suministro de energ&iacute;a el&eacute;ctrica, y aprovechamos para actualizar alguna otra modificaci&oacute;n que ten&iacute;amos pendiente. Las nuevas Condiciones Generales <strong>se aplicar&aacute;n autom&aacute;ticamente a partir del 18 de noviembre</strong> (no hay que hacer nada, ni firmar el documento, ni enviarlo).</p>
% endif
<br>
% if amb_auto_compensacio:
<figure class="table">
    <table style="background-color: #eeeeee; border: 4px solid gray; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
        <tbody>
            <tr>
                <td>
                    <p><strong>Flux Solar</strong></p>
                    <ul style="display: grid;">
                        <li style="padding-bottom:1em"><strong>&iquest;De qu&eacute; va, exactamente?</strong> Los excedentes de autoproducci&oacute;n generados que no se hayan podido compensar en la factura del periodo en cuesti&oacute;n, se guardan en forma de &ldquo;Soles&rdquo;, descuentos que se a&ntilde;adir&aacute;n a las facturas posteriores.</li>
                        <li style="padding-bottom:1em"><strong>&iquest;Cu&aacute;ndo se pondr&aacute; en marcha?</strong> El Flux Solar se pondr&aacute; en marcha con el cambio de condiciones generales, el d&iacute;a 18 de noviembre<strong>.</strong> A partir de esta fecha ya podr&aacute;s tener facturas con el descuento aplicado.</li>
                        <li style="padding-bottom:1em"><strong>&iquest;Qu&eacute; tengo que hacer para que se me active?</strong> No hace falta que hagas nada, ser&aacute; autom&aacute;tico. Cuando se active el Flux Solar, en tu Oficina Virtual ya aparecer&aacute;n los Soles que hayas podido generar desde enero de 2022 (siempre que hayas mantenido tu contrato activo con Som Energia y tengas la compensaci&oacute;n simplificada de excedentes activada).</li>
                        <li style="padding-bottom:1em"><strong>&iquest;De cu&aacute;nto ser&aacute; el descuento?</strong> El descuento ser&aacute; del 80% del valor de los excedentes no compensados en tu facturaci&oacute;n mensual (con el l&iacute;mite de no tener facturas negativas).</li>
                        <li><strong>Tengo m&aacute;s dudas&hellip; &rarr; </strong>en la <a href="https://blog.somenergia.coop/?p=45981" style="text-decoration:none"><u>noticia del blog</u></a> te explicamos en qu&eacute; parte de la factura se descuenta, por qu&eacute; se aplica un 80%, c&oacute;mo ver los Soles disponibles y el resto de caracter&iacute;sticas del Flux Solar. En el Centro de Ayuda encontrar&aacute;s un <a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar" style="text-decoration:none"><u>art&iacute;culo</u></a> con m&aacute;s detalles.</li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    <figure class="table">
                        <table  align="center" style="background-color: #98A43C;" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr align="center">
                                    <td align="center" style="border-radius: 2px;text-align: center;" bgcolor="#98A43C">
                                        <a href="https://blog.somenergia.coop/?p=45981" target="_blank" style="padding: 8px 12px; border: 1px solid #98A43C;border-radius: 2px;font-family: Arial, Helvetica, sans-serif;font-size: 14px; color: #ffffff;text-decoration: none;font-weight:bold;display: inline-block;">
                                            ¡Quiero saber más!
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                </td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
% endif
<figure class="table">
    <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
        <tbody>
            <tr>
                <td>
                    % if amb_auto_compensacio:
                    <p><strong>Otros cambios en las Condiciones Generales:</strong></p>
                    <ul style="display: grid;padding-bottom: 1em">
                    % else:
                    <p><strong>A continuación te resumimos los cambios:</strong></p>
                    <ul style="display: grid;padding-bottom: 1em">
                        <li style="padding-bottom:1em"><strong>Flux Solar (cl&aacute;usula 8.6)</strong>: a todos los contratos que tengan autoproducci&oacute;n activada con compensaci&oacute;n simplificada se les aplicar&aacute;, autom&aacute;ticamente, el Flux Solar: una herramienta que otorga descuentos por los excedentes de autoproducci&oacute;n no compensados. Estos descuentos se aplicar&aacute;n en las pr&oacute;ximas facturas, y su valor ser&aacute; del 80% del valor de los excedentes no compensados. Todos los detalles los explicamos en esta <a href="https://blog.somenergia.coop/?p=45981" style="text-decoration:none"><u>noticia del blog</u></a>.</li>
                    % endif
                        <li style="padding-bottom:1em"><strong>Modificaciones de contrato (cl&aacute;usula 9.5): </strong>hay algunas modificaciones de contrato que no es posible tramitar a la vez. Es decir:
                        <ul style="display: grid;padding-bottom: 1em">
                            <li style="padding-bottom:1em">Si est&aacute;s tramitando un cambio de tarifa (de periodos a indexada o al rev&eacute;s), no puedes iniciar una modificaci&oacute;n contractual (de potencia, de tensi&oacute;n, de modalidad de autoproducci&oacute;n&hellip;). Tendr&aacute;s que esperar a que se haga efectivo el cambio de tarifa (si todo va como est&aacute; previsto, a partir del d&iacute;a despu&eacute;s de la siguiente factura), para poder pedir cualquier otro cambio.</li>
                            <li style="padding-bottom:1em">Si est&aacute;s tramitando una modificaci&oacute;n contractual (de potencia, de tensi&oacute;n, de modalidad de autoproducci&oacute;n&hellip;), y te decides a cambiar la tarifa (de periodos a indexada o a la inversa), tendr&aacute;s que esperar que se haga efectiva la modificaci&oacute;n contractual (aproximadamente, entre una y tres semanas, seg&uacute;n el tr&aacute;mite), antes de hacer la petici&oacute;n de cambio de tarifa.</li>
                            <li style="list-style: none;padding-bottom:1em">Este a&ntilde;adido a las Condiciones Generales es para adaptarlas a la nueva tarifa indexada que tenemos disponible desde el verano. Ten&eacute;is toda la informaci&oacute;n en la<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/" style="text-decoration:none"> <u>web</u></a> y en el<a href="https://blog.somenergia.coop/tarifas-electricidad-y-sector-electrico/2023/07/la-nueva-tarifa-indexada/" style="text-decoration:none"><u> blog</u></a>.</li>
                        </ul>
                        </li>
                        <li style="padding-bottom:1em"><strong>Baja de punto de suministro (cl&aacute;usula 6.5): </strong>especificamos que las bajas de suministro corresponden, legalmente, a las<a href="https://es.support.somenergia.coop/article/656-las-distribuidoras-de-electricidad?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=castellano" style="text-decoration:none"><u> empresas distribuidoras</u></a>. Desde Som Energia (empresa<a href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad?utm_source=linkidiomes&amp;utm_medium=cda&amp;utm_campaign=castellano" style="text-decoration:none"><u> comercializadora</u></a>), cuando recibimos una petici&oacute;n de baja de suministro, la remitimos a la distribuidora correspondiente, que tiene un plazo para hacer efectiva la baja. Por eso, desde Som Energia no podemos garantizar en qu&eacute; fecha se har&aacute; efectiva. Por otro lado, puede ser que la distribuidora necesite acceder al equipo de medida (contador de electricidad) para poder hacer una &uacute;ltima lectura de datos. Por lo tanto, si alguna vez dejas una vivienda o local y quieres dar de baja la electricidad, es posible que, despu&eacute;s de hab&eacute;rnoslo solicitado, tengas que facilitar el acceso al contador a la empresa distribuidora. La factura final a pagar llegar&aacute; hasta la fecha en que la distribuidora haga efectiva la baja.&nbsp;</li>
                        <li style="padding-bottom:1em"><strong>Activaci&oacute;n de autoconsumo (cl&aacute;usula 8.1): </strong>cuando, en Som Energia, una distribuidora nos remite una petici&oacute;n de activaci&oacute;n de autoconsumo de un contrato, desde la cooperativa enviamos un correo a la persona o entidad titular de aquel contrato para que confirme que los datos son correctos. Desde hace un tiempo, en algunas&nbsp; ocasiones (no todas), la distribuidora activa el cambio de modalidad sin esperar que haya la confirmaci&oacute;n por parte de la persona o entidad titular. En estos casos, desde Som Energia aplicaremos el cambio a la modalidad de autoconsumo correspondiente, entendiendo que si la persona titular no ha respondido, ha aceptado t&aacute;citamente el cambio. En todos los casos, en el momento de activar la modalidad de autoconsumo, desde Som Energia enviaremos un correo informando a la persona o entidad titular.</li>
                        <li style="padding-bottom:1em"><strong>Peque&ntilde;as modificaciones </strong>para adaptar las condiciones a la nueva redacci&oacute;n de la<a href="https://www.boe.es/buscar/act.php?id=BOE-A-2007-20555" style="text-decoration:none"> <u>Ley general de defensa de las personas consumidoras y usuarias</u></a>, enfocadas a proteger mejor a las personas y empresas consumidoras. Se modifican algunos conceptos para que queden m&aacute;s claros y definidos, y que no cambian sustancialmente el sentido de las condiciones existentes.</li>
                        <li style="padding-bottom:1em"><strong>Adaptaci&oacute;n de la medida de la tipograf&iacute;a y el interlineado </strong>de las condiciones generales, para facilitar su lectura y que sea m&aacute;s inclusivo.</li>
                    </ul>
                </td>
            </tr>
        </tbody>
    </table>
</figure>
<br>
<p>Te adjuntamos en este correo las nuevas condiciones generales, en un archivo donde tambi&eacute;n est&aacute;n las condiciones espec&iacute;ficas (en caso de que tengas tarifa indexada) y las condiciones particulares. Si est&aacute;s de acuerdo, <strong>no hace falta que nos devuelvas el documento firmado,</strong> porque esta actualizaci&oacute;n se aplicar&aacute; autom&aacute;ticamente el 18 de noviembre. Igualmente, tenemos que informarte que si, por alguna raz&oacute;n, estos cambios te hicieran replantear tu pertenencia a la cooperativa, podr&iacute;as dar de baja tu contrato con nosotros, bien comunic&aacute;ndonoslo directamente o bien mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cl&aacute;usulas de permanencia en ning&uacute;n momento. As&iacute; pues, si decidieras marchar, solo te facturar&iacute;amos el consumo realizado hasta el d&iacute;a de finalizaci&oacute;n del contrato, con los precios vigentes en cada momento.</p>
<p>&nbsp;</p>
<p>Un cordial saludo,</p>
<p>&nbsp;</p>
<p>Equipo de Som Energia</p>
<p><a href="https://www.somenergia.coop/es"><u>www.somenergia.coop</u></a></p>
% endif
<!-- FI CASTELLÀ -->
<p>${text_legal}</p>
<br>
</body>
</html>
