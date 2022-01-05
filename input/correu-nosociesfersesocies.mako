<!doctype html>
<html>

% if object.polissa_id.titular.lang == "ca_ES":
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Adreça punt subministrament: ${object.polissa_id.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Codi CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% else:
<head><meta charset="utf-8" /><table width="100%" frame="below" BGCOLOR="#E8F1D4"><tr><td height = 2px><FONT SIZE=2><strong>Contrato Som Energia nº ${object.polissa_id.name}: </strong></font></td><td VALIGN=TOP rowspan="4"><align="right"><align="right"><img width='130' height='65' src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png"></td></tr><tr><td height = 2px><FONT SIZE=1>Dirección punto suministro: ${object.polissa_id.cups.direccio}</font></td></tr><tr><td height = 2px><FONT SIZE=1>Código CUPS: ${object.polissa_id.cups.name}</font></td></tr><tr><td height = 2px width=100%><FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font></td></tr></table></head>
% endif

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
<p>Benvolgut/da ${nom_titular},</p>
<br>
<p>T’escrivim perquè actualment tens un contracte de subministrament elèctric vigent a la nostra cooperativa, des del <b>${object.polissa_id.data_alta}</b>, que encara no està vinculat a cap persona sòcia. Això pot haver passat per diferents raons com, per exemple, que passessis a tenir la titularitat d’un contracte que ja estava a Som Energia anteriorment i no et vas fer soci o sòcia en aquell moment, o bé que qui et va convidar per poder contractar amb nosaltres s’hagi desvinculat del teu contracte.</p>
<p>El fet és que, tal com consta a les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/">Condicions Generals</a>, com que Som Energia és una cooperativa, totes les persones que hi tenen el contracte de llum han de ser sòcies o bé estar vinculades a una altra persona o entitat sòcia.</p>
<p>Com et vam explicar a la <a href="https://blog.somenergia.coop/som-energia/2021/12/noves-mesures-per-fer-front-a-les-tensions-actuals-del-mercat-energetic/">comunicació de la setmana passada</a> sobre la situació excepcional del mercat elèctric, ara necessitem més que mai enfortir el capital social de la cooperativa per fer front a l’augment de preus i de garanties que requereix cada contracte.</p>
<p>És per això que una de les mesures que hem pres és regularitzar la situació i que no hi hagi contractes sense sòcia o soci.</p>
<p>Per tant, hem de demanar-te que, <b>si vols continuar formant part de la cooperativa i donant suport a aquest projecte, facis el pas d’esdevenir soci/sòcia de Som Energia</b>.</p>
<br>
<p><b>Què has de fer si vols seguir amb Som Energia?</b></p>
<ul>
<li>
Fer-te soci o sòcia, de manera que es reforci el teu compromís amb la cooperativa i amb el model energètic renovable, democràtic, transparent i en mans de la ciutadania. Pots veure què significa associar-s’hi en <a href="https://ca.support.somenergia.coop/article/186-quins-son-els-avantatges-de-ser-soci-a-de-som-energia">aquest article</a> del Centre d’Ajuda.
</li>
</ul>
<p style="text-align:center"><a href="https://www.somenergia.coop/ca/fes-te-n-soci-a/">Fes-te’n soci/a</a></p>
<ul>
<li>
O bé indicar-nos quina persona sòcia passarà a vincular-se al teu contracte. Pots consultar com vincular el teu contracte a una persona sòcia en <a href="https://ca.support.somenergia.coop/article/1221-com-vincular-un-contracte-a-una-persona-socia">aquest altre article</a> del Centre d’Ajuda.
</li>
</ul>
<p style="text-align:center"><a href="https://oficinavirtual.somenergia.coop/ca/">Vincula el teu contracte a una persona sòcia</a></p>
<br>
<p>A causa del moment excepcional que vivim, només podem oferir-te cinc dies perquè regularitzis la situació del teu contracte. En cas contrari, procedirem a rescindir el contracte ${object.polissa_id.name} amb l’adreça de subministrament ${object.polissa_id.cups.direccio} i es farà efectiu durant els propers 20 dies. D’aquesta manera, el teu contracte d’electricitat passarà a ser gestionat per l’empresa comercialitzadora de referència, que pots consultar en aquest enllaç. Si ho prefereixes, pots fer un canvi de comercialitzadora i escollir amb quina vols estar.</p>
<p>Des de Som Energia volem comptar amb tu i és per això que t’animem a quedar-te i formar part d’aquest projecte cooperatiu, basat en les necessitats comunes de consum i no en el lucre, i ajudar-nos a demostrar que és només a través de la ciutadania organitzada que podrem fer una transició del model energètic realment transformadora.</p>
<p>Moltes gràcies pel teu suport.</p>
<p>Salut i bona energia,</p>
<br>
<p> Equip de Som Energia</p>
<p><a href="https://www.somenergia.coop/ca/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif
% if  object.polissa_id.titular.lang!= "ca_ES" and  object.polissa_id.titular.lang != "es_ES":
----------------------------------------------------------------------------------------------------
% endif
% if  object.polissa_id.titular.lang != "ca_ES":
<br>
<p>Apreciado/a ${nom_titular},</p>
<br>
<p>Te escribimos porque actualmente tienes un contrato de suministro eléctrico vigente en nuestra cooperativa, desde el <b>${object.polissa_id.data_alta}</b>, que todavía no está vinculado a ninguna persona socia. Eso puede haber pasado por diferentes razones como, por ejemplo, que pasaras a tener la titularidad de un contrato que ya estaba en Som Energia anteriormente y no te asociaste en aquel momento, o bien que quien te invitó para poder contratar con nosotros se haya desvinculado de tu contrato.</p>
<p>El hecho es que, tal y como consta en las <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/">Condiciones Generales</a>, como Som Energia es una cooperativa, todas las personas que tienen el contrato de la luz tienen que ser socias o bien estar vinculadas a otra persona o entidad socia.</p>
<p>Como te explicamos en la <a href="https://blog.somenergia.coop/som-energia/2021/12/nuevas-medidas-para-hacer-frente-a-las-tensiones-actuales-del-mercado-energetico/">comunicación de la semana pasada</a> sobre la situación excepcional del mercado eléctrico, ahora necesitamos más que nunca fortalecer el capital social de la cooperativa para hacer frente al aumento de precios y de garantías que requiere cada contrato.</p>
<p>Por este motivo, una de las medidas que hemos tomado es la regularización de esta situación, eliminando así la existencia de contratos sin socia o socio.</p>
<p>Por lo tanto, tenemos que pedirte que, <b>si quieres continuar formando parte de la cooperativa y apoyando a este proyecto, des el paso de convertirte en socio/socia de Som Energia</b>.</p>
<br>
<p><b>¿Qué tienes que hacer si quieres seguir con Som Energia?</b></p>
<ul>
<li>
Hacerte socio o socia, de forma que se refuerce tu compromiso con la cooperativa y con el modelo energético renovable, democrático, transparente y en manos de la ciudadanía. Puedes ver qué significa asociarse a la cooperativa en <a href="https://es.support.somenergia.coop/article/144-cuales-son-las-ventajas-de-ser-socio-a-de-som-energia">este artículo</a> del Centro de Ayuda.
</li>
</ul>
<p style="text-align:center"><a href="https://www.somenergia.coop/es/hazte-socio-a/">Hazte socio/a</a></p>
<ul>
<li>
O bien indicarnos qué persona socia pasará a vincularse a tu contrato. Puedes consultar cómo vincular tu contrato a una persona socia en <a href="https://es.support.somenergia.coop/article/1222-como-vincular-un-contrato-a-una-persona-socia">este otro artículo</a> del Centro de Ayuda.
</li>
</ul>
<p style="text-align:center"><a href="https://oficinavirtual.somenergia.coop/es/">Vincula tu contrato a una persona socia</a></p>
<br>
<p>A causa del momento excepcional que vivimos, solo podemos ofrecerte cinco días para que regularices la situación de tu contrato. En caso contrario, procederemos a rescindir el contrato ${object.polissa_id.name} con la dirección de suministro ${object.polissa_id.cups.direccio} y se hará efectivo durante los próximos 20 días. De este modo, tu contrato de electricidad pasará a estar gestionado por la empresa comercializadora de referencia, que puedes consultar en <a href="https://es.support.somenergia.coop/article/661-la-comercializacion-de-electricidad?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">este enlace</a>. Si lo prefieres, puedes hacer un cambio de comercializadora y escoger con la que quieres estar.</p>
<p>Desde Som Energia queremos contar contigo y es por eso que te animamos a quedarte y formar parte de este proyecto cooperativo, basado en las necesidades comunes de consumo y no en el lucro, y ayudarnos a demostrar que solamente a través de la ciudadanía organizada podremos hacer una transición del modelo energético realmente transformadora.</p>
<p>Muchas gracias por tu apoyo.</p>
<p>Salud y buena energía,</p>
<br>
<p> Equipo de Som Energia</p>
<p> <a href="https://www.somenergia.coop/es/" alt="www.somenergia.coop">www.somenergia.coop</a>​</p>
% endif

<p>${text_legal}</p>
</body>
</html>
