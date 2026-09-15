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
template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_footer_v2')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

try:
  p_obj = object.pool.get('res.partner')
  if not p_obj.vat_es_empresa(object._cr, object._uid, 'object.partner_id.vat'):
    nom_pagador = ' ' + object.partner_id.name.split(',')[1].lstrip()
  else:
    nom_pagador = ''
except:
  nom_pagador = ''
%>

${plantilla_header}

% if object.polissa_id.titular.lang != "es_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contracte Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Adreça punt subministrament: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Codi CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${object.polissa_id.titular.name}</span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola${nom_pagador},<br/>
<br/>
No hem pogut cobrar correctament la teva factura a través de la targeta facilitada.<br/>
<br/>
Per tal de regularitzar-la, pots fer el pagament mitjançant:<br/>
<ul>
  <li>El document adjunt amb codi de barres: online amb targeta mitjançant l'enllaç que trobaràs sota el codi de barres del document o bé en els caixers de l'entitat <a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAC-2FgvKIxA1xdUHxtoBdT9EGYRTB0yAJeXRwA-2Ft9LhmlzuvgXcexC8-2FwFTSKKIOz-2B-2BAag5uJI2eUh4Kt38FEXxy8-3DZ1g6_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRtJFXjHinlholk7zlyyIPN-2FR5MsaTP6KgQzKMVfdxfFOLli5BT6lEcFNF-2FTbst2Joa1-2FEIfQdhGrdkmezQYTzofK0kYjEZ8GXsd-2BDRH94eRGzZn2lP8o4os7j4BqKsbbJrzA4mR-2BiNrpdUh0-2FCIaawl">CaixaBank</a>.</li>
  <li>Fent una transferència bancària al número de compte ES82 1491 0001 2920 2709 8223 de Triodos Bank a nom de SOM ENERGIA, SCCL i indicant, com a concepte, el número de contracte o de factura.</li>
</ul>
Al següent article t'ho expliquem amb més detall: <a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAASM66xC-2Fj-2F24l5h9I2SMP7acT5e6eFlm3AqFGqLFIcjqegvjCq-2BlyR-2FAI2vtKiypaZPDF1-2FR-2BjiB2hUCMhAkA0QzxY3cP-2FYa6ZF8hjUlWK7qY8M_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRs6qV1qppbckuOBEKoXaHYZGelp3tgfdKtRGhQhgj4oDEAhKeho19LddVPvzDCwnDv1OYrm7bMkiGtJeDoFw2aD1uHLPxRTzEsvNzGD-2FKihV-2BAL36BjRC-2FAwcDATylaSLQheYZQLYolDMBng4SSzcAS">Què fer si una factura queda impagada?</a><br/>
<br/>
<u>Resum de la factura</u><br/>
<br/>
- Número de factura: ${object.number}<br/>
- Data factura: ${object.invoice_id.date_invoice}<br/>
- Període del ${object.data_inici} al ${object.data_final}<br/>
- Import total: ${object.invoice_id.amount_total}€<br/>
<br/>
T'informem que si et trobes en una situació de vulnerabilitat econòmica, i en compliment de la legislació vigent (Reial decret 897/2017, de 6 d'octubre, pel qual es regula la figura del consumidor vulnerable, el bo social i altres mesures de protecció per als consumidors domèstics d'energia elèctrica), el teu contracte hauria de passar a la comercialitzadora de referència per poder-te acollir al bo social. Som Energia no el pot aplicar per llei, malgrat que el financi.<br/>
<br/>
Si ets una persona electrodependent o bé en el teu punt de subministrament hi viu alguna persona que ho sigui, envia'ns el certificat d'empadronament i el certificat mèdic oficial que ho acrediti a cobraments@somenergia.coop<br/>
<br/>
Cordialment,<br/>
<br/>
Equip de Som Energia<br/>
cobraments@somenergia.coop<br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAEK1WLA6ierpleg9uk-2BtKXN8h2H5UAwAmWhsCb0KCON4doHy_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRsngxT0tWdE1fCRprY5TAto2jmflxehiOvzZREtxAeUQ5GopbC054P5L-2FrsNpF928dukcyLzILrPL29r6UdagVSXvD8CLJOErveIwgWnPKtEkc6ss75dVqb15l7l-2BryVsF-2BgsbNjW-2BfkQ-2FPqK1SuqDu">www.somenergia.coop</a><br/>
<br/>
<font size="1" style="color:grey">
Si compliu els requisits per ser consumidor vulnerable, podeu sol·licitar a una de les empreses comercialitzadores de referència acollir-se al bo social, que suposa un descompte sobre el preu voluntari per al petit consumidor (PVPC). El canvi de modalitat en el contracte per passar a PVPC, sempre que no es modifiquin els paràmetres que recull el contracte d'accés de tercers a la xarxa, s'ha de portar a terme sense cap tipus de penalització ni cost addicional. Una vegada acollit al PVPC, i sempre que s'hagin acreditat els requisits per ser consumidor vulnerable, el termini perquè se us pugui suspendre el subministrament d'electricitat, en cas que no s'hagi abonat la quantitat deguda, passa a ser de 4 mesos (comptats sempre des de la recepció del requeriment fefaent de pagament).<br/>
<br/>
L'enllaç a la pàgina web de la CNMC, en la qual trobareu les dades necessàries per contactar amb la comercialitzadora de referència, és el següent: <a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeANNDj4kg9-2Fx6E2sYbzgJloECOJFGbM8BUBDFFynHMOPPUtRGWuPFnXCiTWRZS7QoP-2F42X8IEcaiZYLpsjf4HvW1NfsXR4mHvxXRd074XnKBftb4X_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRv1LH6LmBqe5e-2F4wZxOGdX72NPooMgg-2BdKy7FfHq4PRdVsdw44G6trZJB3vMU5S0xyOzCxVCi-2Bp34QXJFwa2rqSHlGqxrGUsOp3l3tzrqn3ETd7RVlyGXbwfq2-2BpYKGiHdpMYd8CxsWGYjpZbcMgQdA">https://www.cnmc.es/ambitos-de-actuacion/energia/mercado-electrico#listados</a><br/>
<br/>
Addicionalment, si compliu els requisits per ser vulnerable sever, us podeu posar en contacte amb els serveis socials del municipi i la comunitat autònoma en què residiu perquè us informin sobre la possibilitat d'atendre el pagament del vostre subministrament d'electricitat. Els requisits per ser consumidor vulnerable es recullen a l'article 3 del Reial decret 897/2017, de 6 d'octubre, pel qual es regula la figura del consumidor vulnerable, el bo social i altres mesures de protecció per als consumidors domèstics d'energia elèctrica, del qual us remetem un extracte.<br/>
<br/>
Article 3. Definició de consumidor vulnerable.<br/>
<br/>
Als efectes d'aquest Reial decret i altres normatives aplicables, té la consideració de consumidor vulnerable el titular d'un punt de subministrament d'electricitat a la residència habitual que, sent persona física, estigui acollit al preu voluntari per al petit consumidor (PVPC) i compleixi la resta de requisits d'aquest article.<br/>
Perquè un consumidor d'energia elèctrica es pugui considerar consumidor vulnerable, ha de complir algun dels requisits següents:<br/>
Que la seva renda o, en cas de formar part d'una unitat familiar, la renda conjunta anual de la unitat familiar a la qual pertanyi sigui igual o inferior:<br/>
a 1,5 vegades l'indicador públic de renda d'efectes múltiples (IPREM) de 14 pagues, en cas que no formi part d'una unitat familiar o no hi hagi cap menor en la unitat familiar;<br/>
a 2 vegades l'índex IPREM de 14 pagues, en cas que hi hagi un menor en la unitat familiar;<br/>
a 2,5 vegades l'índex IPREM de 14 pagues, en cas que hi hagi dos menors en la unitat familiar.<br/>
A aquests efectes, es considera unitat familiar la constituïda d'acord amb el que disposa la Llei 35/2006, de 28 de novembre, de l'impost sobre la renda de les persones físiques i de modificació parcial de les lleis dels impostos sobre societats, sobre la renda de no residents i sobre el patrimoni.<br/>
<br/>
Tenir el títol de família nombrosa.<br/>
Que el mateix consumidor i, en cas de formar part d'una unitat familiar, tots els membres d'aquesta que tinguin ingressos, siguin pensionistes del Sistema de la Seguretat Social per jubilació o incapacitat permanent, percebent la quantia mínima vigent en cada moment per a les classes de pensió esmentades, i no percebin altres ingressos.<br/>
<br/>
Els multiplicadors de renda respecte de l'índex IPREM de 14 pagues que estableix l'apartat 2.a) s'han d'incrementar, en cada cas, en 0,5, sempre que concorri alguna de les circumstàncies especials següents:<br/>
Que el consumidor o algun dels membres de la unitat familiar tingui discapacitat reconeguda igual o superior al 33%.<br/>
Que el consumidor o algun dels membres de la unitat familiar acrediti la situació de violència de gènere, de conformitat amb el que estableix la legislació vigent.<br/>
Que el consumidor o algun dels membres de la unitat familiar tingui la condició de víctima de terrorisme, de conformitat amb el que estableix la legislació vigent.<br/>
Quan, complint els requisits anteriors, el consumidor i, si s'escau, la unitat familiar a la qual pertanyi, tinguin una renda anual inferior o igual al 50% dels llindars que estableix l'apartat 2.a), incrementats si s'escau d'acord amb el que disposa l'apartat 3, el consumidor s'ha de considerar vulnerable sever. Així mateix, també s'ha de considerar vulnerable sever quan el consumidor i, si s'escau, la unitat familiar a la qual pertanyi, tinguin una renda anual inferior o igual a una vegada l'IPREM a 14 pagues o dues vegades aquest, en cas que estigui en la situació de l'apartat 2.c) o 2.b), respectivament.<br/>
En tot cas, perquè un consumidor sigui considerat vulnerable ha d'acreditar el compliment dels requisits que recull aquest article en els termes que s'estableixin per ordre del ministre d'Energia, Turisme i Agenda Digital.<br/>
<br/>
En cas que un consumidor que compleixi els requisits per percebre el bo social i vulgui sol·licitar-ne l'aplicació no figuri com a titular del punt de subministrament d'electricitat en vigor, la sol·licitud de modificació de titularitat del contracte de subministrament d'electricitat es pot fer de manera simultània a la sol·licitud del bo social. En aquest cas, no s'aplica el que disposa l'article 83.5 del Reial decret 1955/2000, d'1 de desembre, pel qual es regulen les activitats de transport, distribució, comercialització, subministrament d'electricitat i procediments d'autorització d'instal·lacions d'energia elèctrica, sobre la revisió de les instal·lacions de més de vint anys.<br/>
<br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAASM66xC-2Fj-2F24l5h9I2SMP7acT5e6eFlm3AqFGqLFIcjAifi-2FbZNE1B80JsvGbHTlLI86Rihhld2hXIA7TINm5c-3DA-zU_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRv-2ByxiXvoZAovRdCHaeL139DjackKwjMPYgMbaUQhV7njKYcxKDp9fZQ5UUhpcezcW76RZNJ5zYwC-2F-2BBLhmbvfWPB4-2BXsCuWOa1tv8T2w91La85aeGVFcl78Sg9vT47IBOeYZSZsd2gIO3Z1gqlZjE-2F">El Bo Social. Article a Som Energia</a><br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAASM66xC-2Fj-2F24l5h9I2SMP7acT5e6eFlm3AqFGqLFIcjRBbOJ8MGTuXZue91YrAHq3l38IUj8iugghfFidiuNEl0PXdsoj8L8oAEJ2bl4ARhLbtMvVy6JzLeKsKHuoI8gpLuwNPWMDB2thKUIhTGMA5s745irlAAiNDT3FoyAbUlFYW6_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRvVsX6ghLZlZWwqRvvo9PPkwf46OxwnEkCx43JZnLZK4sI9XPxqApRch5I-2BwOdUV25aHZCZ6h2-2FSUeT1uaix48TSBiFdLy-2F6mqJuXxesmIZxMf6WBlacRAvP7T-2FnR8FZEDgxWzYjtPU6-2FKSZ199-2BEmd">Què cal fer si et trobes en situació de pobresa o vulnerabilitat energètica?</a><br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAASM66xC-2Fj-2F24l5h9I2SMP7acT5e6eFlm3AqFGqLFIcjeCtzp1d97O0srmx66Cb1Jr8i7r51azPHpoc4mzxA61qTSSgYQh7KYZOZlPMQqP4K1stY9MwvLAPIX5emYPSbRGbjNnq9qZq9QaA54GhBTsSRvvi5HIcS-2Ff8S-2BPnRVcGVjkxSSxRvIak6QbpmwLjBdQ-3D-3Dh07I_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRt8qRcC7MzapeqKNuFNf6Vgu3ymJzAak8D8CJzSAC7zogxnwr-2BKK9JRw-2FhjG-2B40nYe-2B8TEDPJrX0DSuBnn8oq0P0DCEH2c6CZfaQjhgYSlWLkwdaOG6huma-2BJ2QPvUFgWrv7AoovltyPAgQ5B-2FMxZGr">Què és el PVPC?</a><br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAEZcbcdR7HTPpCIeMPHWFOxHrz1XoOYv98fI3JGy-2BoITCy7gq-2BqsSHE5XfBemjcmewQIVKs6hiuqeYmLzmGrLnrMZfcnkLoO1x0LhdghYFnNt-2FXVsJcI5ugBh4bVacwbng-3D-3DDGTO_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSG7A8E1Z1ZSGYyB3FkW7VN4pHftuCzuD8N-2F6dKAYTCRsaZukemwOI91ip6U8TmhtGqcFIsUvOy4Dt83S-2FE9ajeLqkXDjviMHpyp3Dr7t6CvFuGO-2BRf9Ooe7T27ZCI9VDkiyB3fC23R4LLdC7HRO39-2BCH-2BAw9lZHIT-2BRqRRKYkz1VbikfvME2BUrsODwL-2FYAGn">Preguntes freqüents sobre el bo social a la Web del Ministeri d'Energia.</a><br/>
</font>
% endif

% if object.polissa_id.titular.lang != "ca_ES" and object.polissa_id.titular.lang != "es_ES":
<br/><hr align="left" size="1" width="400" color="black" noshade><br/>
% endif

% if object.polissa_id.titular.lang != "ca_ES":
<table width="100%" frame="below">
<tbody>
<tr>
  <td height="2px"><span style="font-size: small;"><strong>Contrato Som Energia nº ${object.polissa_id.name}</strong></span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Dirección punto suministro: ${object.cups_id.direccio}</span></td>
</tr>
<tr>
  <td height="2px"><span style="font-size: xx-small;">Código CUPS: ${object.cups_id.name}</span></td>
</tr>
<tr>
  <td width="100%" height="2px"><span style="font-size: xx-small;">Titular: ${object.polissa_id.titular.name}</span></td>
</tr>
</tbody>
</table>
<br/>
<br/>
Hola${nom_pagador},<br/>
<br/>
No hemos podido cobrar correctamente tu factura a través de la tarjeta facilitada.<br/>
<br/>
Para regularizarla, puedes hacer el pago mediante:<br/>
<ul>
  <li>El documento adjunto con código de barras: online con tarjeta mediante el enlace que encontrarás bajo el código de barras del documento o bien en los cajeros de la entidad <a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAL1-2BCbsaIMnb6WhL7NtG1yh34aFXtz-2FlN8ZsrVDirS3wkhZVktY5sKOi-2BBmGulsYVulau3tY16-2BGysW55pl00ZQ-3D2lLi_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aJoMA8nOab8tADYklEoz1kV78MAAmf-2FGWAVvUleo7gIdv0kHKh27UQlQJUaKHFymuCFZj3zG-2BWXtzMgLqS37GI48Qx8WgR4WRRU4qnQysJ83Z4W687eU6-2BmmQ1fkKvexk5JfKuLpM4sifTQ1dGuVyhi">CaixaBank</a>.</li>
  <li>Haciendo una transferencia bancaria al número de cuenta ES82 1491 0001 2920 2709 8223 de Triodos Bank a nombre de SOM ENERGIA, SCCL e indicando, como concepto, el número de contrato o de factura.</li>
</ul>
En el siguiente artículo te lo explicamos con más detalle: <a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeABvAljh6CO6BCUB4zcO-2BgdPAolMrpO6ZujYLG0IelbkFQ4LAoeU2OZAcdpR-2FlVPLtGvem4GR3RQq5Zum4XC6PIe3SXIdo9b-2FesG9yYNkcCFs5Gf8_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aJd7eF-2F7s6m7fW7m32aVBqdy9bkNa3dkDuP8EPQmzaCGmEqVEtTF7cy30HX9ADgFQ0sLjrnioG4MbSGrfFjQuQdRVP27dKIObXtGX4ynoQjp-2Bok8m7yCgfT0ecAYbRLsvKcoAIaSVPC5v-2FRP35KjylQ">¿Qué hacer si una factura queda impagada?</a><br/>
<br/>
<u>Resumen de la factura</u><br/>
<br/>
- Número factura: ${object.number}<br/>
- Fecha factura: ${object.invoice_id.date_invoice}<br/>
- Periodo del ${object.data_inici} al ${object.data_final}<br/>
- Importe total: ${object.invoice_id.amount_total}€<br/>
<br/>
Te informamos que si te encuentras en una situación de vulnerabilidad económica, y en cumplimiento de la legislación vigente (Real Decreto 897/2017, de 6 de ocutbre, por el cual se regula la figura del consumidor vulnerable, el bono social y otras medidas de protección para los consumidores domésticos de energía eléctrica), tu contrato tendría que pasar a la comercializadora de referencia para poderte acoger al bono social. Som Energia no lo puede aplicar por ley, a pesar de que lo financia.<br/>
<br/>
Si eres una persona electrodependiente o bien en tu punto de suministro vive alguna persona que lo sea, envíanos el certificado de empadronamiento y el certificado médico oficial que lo acredite a cobros@somenergia.coop<br/>
<br/>
Saludos,<br/>
<br/>
Equipo de Som Energia<br/>
cobros@somenergia.coop<br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.ABrddyO6O5lstH8RY5E7E2er9wdti-2FE-2BItK5Uw5Cu-2BLjArp4fNsGj0d4Oj19jxHaq2LS_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aLYxTq2Bz1Qd13Nb-2BrXwbTV583ovW-2FX99EKbPvxXCucE9ZpgiET-2FoXPImdmOEckTHGuIn2q-2BmjGGIzOz7YRk4ZpJ0ZRsTEgpqqciGscjYbeao4aO9w-2BslKTKDrSzNOQhTlq4DTTy20C0o5fCdPI2IAD">www.somenergia.coop</a><br/>
<br/>
<font size="1" style="color:grey">
Si usted cumple los requisitos para ser consumidor vulnerable, puede solicitar a una de las empresas comercializadoras de referencia acogerse al bono social, que supone un descuento sobre el precio voluntario para el pequeño consumidor (PVPC). El cambio de modalidad en el contrato para pasar a PVPC, siempre que no se modifiquen los parámetros recogidos en el contrato de acceso de terceros a la red, se llevará a cabo sin ningún tipo de penalización ni coste adicional. Una vez acogido al PVPC, y siempre que se hayan acreditado los requisitos para ser consumidor vulnerable, el plazo para que su suministro de electricidad pueda ser suspendido, de no haber sido abonada la cantidad adeudada, pasará a ser 4 meses (contados siempre desde la recepción del requerimiento fehaciente de pago).<br/>
<br/>
El enlace a la página web de la CNMC donde encontrará los datos necesarios para contactar con la comercializadora de referencia es el siguiente: <a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeANNDj4kg9-2Fx6E2sYbzgJloECOJFGbM8BUBDFFynHMOPPUtRGWuPFnXCiTWRZS7QoP-2F42X8IEcaiZYLpsjf4HvW1NfsXR4mHvxXRd074XnKBf4DVt_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aKSSCj83slU2Bvd7Yous5GOAyyqzZWUsDr3k89SLC4qE8TDiQ3BDeVlCu2JwW7stlvToHyMfciw8AjjT6ZWGeoh4Wr7hhQLzmhdNPDB0kNOyltJ407pVXah94jriu-2Bn06ak2StzT4NJ0dh7vnIYh8RY">https://www.cnmc.es/ambitos-de-actuacion/energia/mercado-electrico#listados</a><br/>
<br/>
Adicionalmente, si usted cumple los requisitos para ser vulnerable severo, puede ponerse en contacto con los servicios sociales del municipio y comunidad autónoma donde reside, para que le informen sobre la posibilidad de atender el pago de su suministro de electricidad. Los requisitos para ser consumidor vulnerable vienen recogidos en el artículo 3 del Real Decreto 897/2017, de 6 de octubre, por el que se regula la figura del consumidor vulnerable, el bono social y otras medidas de protección para los consumidores domésticos de energía eléctrica, del que le remitimos un extracto.<br/>
<br/>
Artículo 3. Definición de consumidor vulnerable.<br/>
A los efectos de este real decreto y demás normativa de aplicación, tendrá la consideración de consumidor vulnerable el titular de un punto de suministro de electricidad en su vivienda habitual que, siendo persona física, esté acogido al precio voluntario para el pequeño consumidor (PVPC) y cumpla los restantes requisitos del presente artículo.<br/>
Para que un consumidor de energía eléctrica pueda ser considerado consumidor vulnerable, deberá cumplir alguno de los requisitos siguientes:<br/>
Que su renta o, caso de formar parte de una unidad familiar, la renta conjunta anual de la unidad familiar a que pertenezca sea igual o inferior:<br/>
a 1,5 veces el Indicador Público de Renta de Efectos Múltiples (IPREM) de 14 pagas, en el caso de que no forme parte de una unidad familiar o no haya ningún menor en la unidad familiar;<br/>
a 2 veces el índice IPREM de 14 pagas, en el caso de que haya un menor en la unidad familiar;<br/>
a 2,5 veces el índice IPREM de 14 pagas, en el caso de que haya dos menores en la unidad familiar.<br/>
A estos efectos, se considera unidad familiar a la constituida conforme a lo dispuesto en la Ley 35/2006, de 28 de noviembre, del Impuesto sobre la Renta de las Personas Físicas y de modificación parcial de las leyes de los Impuestos sobre Sociedades, sobre la Renta de no Residentes y sobre el Patrimonio.<br/>
<br/>
Estar en posesión del título de familia numerosa.<br/>
Que el propio consumidor y, en el caso de formar parte de una unidad familiar, todos los miembros de la misma que tengan ingresos, sean pensionistas del Sistema de la Seguridad Social por jubilación o incapacidad permanente, percibiendo la cuantía mínima vigente en cada momento para dichas clases de pensión, y no perciban otros ingresos.<br/>
<br/>
Los multiplicadores de renta respecto del índice IPREM de 14 pagas establecidos en el apartado 2.a) se incrementarán, en cada caso, en 0,5, siempre que concurra alguna de las siguientes circunstancias especiales:<br/>
Que el consumidor o alguno de los miembros de la unidad familiar tenga discapacidad reconocida igual o superior al 33%.<br/>
Que el consumidor o alguno de los miembros de la unidad familiar acredite la situación de violencia de género, conforme a lo establecido en la legislación vigente.<br/>
Que el consumidor o alguno de los miembros de la unidad familiar tenga la condición de víctima de terrorismo, conforme a lo establecido en la legislación vigente.<br/>
Cuando, cumpliendo los requisitos anteriores, el consumidor y, en su caso, la unidad familiar a la que pertenezca, tengan una renta anual inferior o igual al 50% de los umbrales establecidos en el apartado 2.a), incrementados en su caso conforme a lo dispuesto en el apartado 3, el consumidor será considerado vulnerable severo. Asimismo también será considerado vulnerable severo cuando el consumidor, y, en su caso, la unidad familiar a que pertenezca, tengan una renta anual inferior o igual a una vez el IPREM a 14 pagas o dos veces el mismo, en el caso de que se encuentre en la situación del apartado 2.c) o 2.b), respectivamente.<br/>
En todo caso, para que un consumidor sea considerado vulnerable deberá acreditar el cumplimiento de los requisitos recogidos en el presente artículo en los términos que se establezcan por orden del Ministro de Energía, Turismo y Agenda Digital.<br/>
<br/>
En el caso de que un consumidor que cumpla los requisitos para percibir el bono social y quiera solicitar su aplicación, no figure como titular del punto de suministro de electricidad en vigor, la solicitud de modificación de titularidad del contrato de suministro de electricidad se podrá realizar de forma simultánea a la solicitud del bono social. En este caso, no se aplicará lo dispuesto en el artículo 83.5 del Real Decreto 1955/2000, de 1 de diciembre, por el que se regulan las actividades de transporte, distribución, comercialización, suministro de electricidad y procedimientos de autorización de instalaciones de energía eléctrica, sobre la revisión de las instalaciones de más de veinte años.<br/>
<br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeABvAljh6CO6BCUB4zcO-2BgdPAolMrpO6ZujYLG0IelbkFDKvrqsUfFyqyB7vZh87Ds8TEmjMeZTk-2FXb969jO6WL4-3DkVUn_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aJfx0LM8UeHxEth0rZPBbebnoHme-2FkuYye4fKQKeoSm1l2XRA46oSf43hVMZJssDYUZ6t87Sosqv-2FZVDG-2BXfBJWAhGXQ3eUL5f-2B-2BmoOFcrPalhahFtEOo4BEfmY8IzafiHK9dsS3LDp68miVydISTjU">El Bono Social. Artículo en Som Energia</a><br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeABvAljh6CO6BCUB4zcO-2BgdPAolMrpO6ZujYLG0IelbkFw32JPVo5NOk8JNgVeTkXjBgbpHrEgjLhhRA345DzifbN3FTNZLSkD-2FCIC8H8b1pCC-2FcgpG-2Bq3jpSyx2my-2BgQKQHuKItPOAybgKsxvW7yQgBft04PDLzDPuUVX99pjLDobKZH_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aLWOK-2BdYHi8dWTpnV2y0RVfEk4H1q0OsNHAj7odtzPiSfgULYtuUtZWhMkgU8ohx-2BIWuSJzG2-2FG5KXOvf1Y5w-2FOJpSboOmfcek131I-2BjnbaqayXwgXOGlx65wnFYq-2FxEkLjUPk3DKXvLFK1FTt9NXdc">¿Què hacer si te encuentras en situación de pobreza o vulnerabilidad energética?</a><br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeABvAljh6CO6BCUB4zcO-2BgdPAolMrpO6ZujYLG0IelbkFxEJlCtwCUOQBpEEooocKTv8ouPufwPwx-2BKh0NFG0Mre2KuFydhFA7569P8pF4JHHAHR8_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aIWmKXD9eL-2BIzuKwKd0e5zaXGIAnUVyZRfg0aKDMvXoGdqxtpd4B21gf2t2JF2LEOQMS1KM9Ht1rYEuOG4-2FfGiPLrlVjn6GngsUZJsmGcmhjdhlZpQKDfgdMeb4H1McU741GIyPws5iV-2F0Z2p0naKfx">¿Qué es el PVPC?</a><br/>
<a href="https://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAEZcbcdR7HTPpCIeMPHWFOxHrz1XoOYv98fI3JGy-2BoITCy7gq-2BqsSHE5XfBemjcmewQIVKs6hiuqeYmLzmGrLnrMZfcnkLoO1x0LhdghYFnNt-2FXVsJcI5ugBh4bVacwbng-3D-3D2u7q_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wS-2F8RIqFGim3W6aTP9gpxoXyPs7Y0XNyARcz6-2FpsEe0aLC-2B3ySqQXyQOi1yYMxA-2FUGZyjAoeB6DaA6fw3fIzwoHOasyKNon5jTn0RhcbmO0TE-2FElk9-2BkohAjmrJe706CKh-2FhmJu5WfYf78gwFQZWgBSM-2FbyjeR7BiRfvzVRBLp8QzjMY2rwGtudbPBtTQ83xFS">Preguntas frecuentes sobre el bono social en la Web del Ministerio de Energía.</a><br/>
</font>
% endif

${plantilla_footer}
