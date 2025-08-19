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

template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header')[1]
template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer')[1]
plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)

try:
    p_obj = object.pool.get('res.partner')
if not p_obj.vat_es_empresa(object._cr, object._uid, object.vat):
    nom_soci =' ' + object.name.split(',')[1].lstrip()
else:
    nom_soci = ''
except:
    nom_soci = ''

def socifilter(text):
return str(int(''.join([a for a in text if a.isdigit()])))
%>

${plantilla_header}

<!-- Email Body -->
<table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0" role="presentation">
  <tr>
    <td align="center">
      <table class="email-content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
        <tr>
          <td class="email-masthead">
            <table align="center" width="570" cellpadding="0" cellspacing="0" role="presentation" class="header">
              <tr>
                <th>
                  % if object.partner_id.lang == "ca_ES":
                      <a href="https://www.somenergia.coop/ca/"><img src="https://www.somenergia.coop/logo/Logotip-Som-Energia.png" alt="SOM Energia" style="height: 106px"/></a>
                  %endif
                  % if object.partner_id.lang != "ca_ES":
                      <a href="https://www.somenergia.coop/es/"><img src="https://www.somenergia.coop/logo/Logotip-Som-Energia.png" alt="SOM Energia" style="height: 106px"/></a>
                  %endif
                </th>
              </tr>
            </table>
          </td>
        </tr>
        <br/>
        <!-- Email Body -->
        <tr>
          <td class="email-body" width="570" cellpadding="0" cellspacing="0">
             <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0" role="presentation">
              <!-- Body content -->
              <tr>
                <td class="content-cell">
                  <div class="f-fallback">
                    <p>
                      Hola, ${nom_soci}!!
                    </p>
                    <p>
                      T'acabes de fer soci/a de Som Energia! <strong>Benvinguda a la cooperativa d'energia verda! </strong>
                    </p>
                    <p style="text-align:center;">
                      <strong>El teu núm. de soci/a és: ${object.partner_id.ref | socifilter}</strong>
                      Nom: ${object.name}
                    </p>
                    <p>
                      Si també vols contractar la llum amb Som Energia (no és el mateix que associar-se), has de clicar <a href="https://www.somenergia.coop/ca/contracta-la-llum/">aquí</a>:
                    </p>
                    <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                      <tr>
                        <td align="center">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                            <tr>
                              <td align="center">
                                <a href="https://www.somenergia.coop/ca/contracta-la-llum/" class="f-fallback button button--blue" target="_blank">Vull contractar la llum</a>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <p>
                        Si ja tenies un contracte de llum amb la cooperativa, el passarem automàticament al teu número de soci/a.
                    </p>
                    <p>
                        Ara pots tenir tants contractes de llum al teu nom com vulguis, i a més, pots tenir associats fins a 5 contractes dels quals no siguis titular.
                    </p>
                    <h1>Quina tarifa vols contractar?</h1>
                    <p>
                        A Som Energia tenim dos tipus de tarifes d'electricitat: les tarifes per períodes i les tarifes indexades. Així grosso modo, les <strong>tarifes per períodes</strong> tenen tres preus diferents segons els horaris en què utilitzis l'electricitat, i ja es coneixen amb antelació.
                    </p>
                    <p>
                        Amb les <strong>tarifes indexades</strong>, en canvi, el preu de l'energia canvia cada hora de cada dia, i reflecteix directament les pujades i baixades del mercat elèctric. Tenim una eina on es pot consultar la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/preu-avui/">tendència</a> de preus de les properes 24 hores.
                    </p>
                    <p>
                        Al nostre web tens més informació de les <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/">tarifes per períodes</a> i les <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">tarifes indexades</a>, i si et queden dubtes, ens els pots fer arribar responent aquest correu.
                    </p>
                    <h1> Saps on has anat a parar?</h1>
                    <p>
                        Som Energia és una cooperativa que produeix i comercialitza energia verda.
                    </p>
                    <p>
                        Som (ara, tu també en formes part!) una cooperativa, per tant, som <strong>molt més</strong> que una “simple” comercialitzadora.
                    </p>
                    <p>
                        A diferència de la majoria de comercialitzadores, <strong>l'objectiu</strong> no és guanyar diners, sinó <strong>transformar el model energètic en un de 100% renovable, distribuït i en mans de la ciutadania</strong>. I volem fer-ho seguint els <strong>valors i principis</strong> que ens defineixen. Els coneixes? Te'ls imagines?
                    </p>
                    <p>
                        Com a cooperativa, a part de tenir valors i un objectiu ben diferent, tenim altres “particularitats”: la formació, la participació, la intercooperació, els Grups Locals…
                    </p>
                    <p>
                        Els propers dies t'explicarem què vol dir tot això, i com te'n pots beneficiar, pel fet de ser soci/a.
                    </p>
                    <h1>Per cert, saps com va començar tot?</h1>
                    <p>
                        Fa 14 anys, un grup de persones vam pensar que n'estàvem fartes, de les grans empreses que imposaven les seves maneres de fer amb l'únic objectiu d'enriquir-se, sense tenir en compte la ciutadania. “Per què no podem comercialitzar electricitat, nosaltres també?” I enlloc de buscar la resposta, ens vam posar a treballar, i vam començar per investigar i estudiar el mercat elèctric.
                    </p>
                    <p>
                        Han anat passant els anys, i ens hem tornat unes expertes en el tema (és el que té estudiar-ho en detall per voler fer-ho bé). També hem crescut molt, ja som més de 85.000 persones i entitats sòcies, fet que ens converteix en <strong>la cooperativa d'energia verda més gran d'Europa</strong>.
                    </p>
                    <p>
                        Comptem amb la força de la ciutadania organitzada, que ens ajuda a tirar endavant. Justament això és el que vam explicar a una Ted Talk (TedxDanubia), una xerrada de 20 minuts que es retransmet arreu del món. Encara ara ens emociona veure-la:
                    </p>
                    <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                      <tr>
                        <td align="center">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                            <tr>
                              <td align="center">
                                <a href="https://www.youtube.com/watch?v=RcPgnnxzDvo" class="f-fallback button button--blue" target="_blank">Anar a la xerrada Ted Talk</a>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <p>
                      <strong> ${nom_soci} tu ara també formes part de tot això. I ens fa molta il·lusió tenir-te entre nosaltres. </strong>
                    </p>
                    IMATGE GIF
                    <p>
                      Com a soci/sòcia de Som Energia se t'obre un nou ventall de possibilitats i avantatges. D'aquí a pocs dies t'enviarem un altre correu explicant-te'ls, no te'l perdis!
                    </p>
                    <p>
                      Instagram: <a href="https://www.instagram.com/somenergia/">https://www.instagram.com/somenergia/</a>
                      Twitter: <a href="https://x.com/SomEnergia"> https://x.com/SomEnergia</a>
                      Mastodon: <a href="https://mastodon.economiasocial.org/@SomEnergia"> https://mastodon.economiasocial.org/@SomEnergia</a>
                      Telegram: <a href="https://t.me/somenergia"> https://t.me/somenergia</a> / <a href="https://t.me/somenergia_es"> https://t.me/somenergia_es </a>
                      Facebook: <a href="https://www.facebook.com/somenergia/"> https://www.facebook.com/somenergia/</a>
                      LinkedIn: <a href="https://es.linkedin.com/company/somenergia"> https://es.linkedin.com/company/somenergia</a>
                    </p>
                  </td>
                </div>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>


${plantilla_footer}