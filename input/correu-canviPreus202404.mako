<%
    email_o = object.pool.get('report.backend.mailcanvipreus')
    data = email_o.get_data(object._cr, object._uid, object.id, context={'lang': object.partner_id.lang})
%>
<!doctype html>
    <head>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
        <style>
            body{ font-family: 'Roboto Mono', Arial; font-size: 16px; text-align:'justify'}
            .margin_top{ margin-top: 2em; }

            h3 {
                margin-top: 30px;
            }

            .cuadricula td, .cuadricula th {
                border: 1px solid;
                padding: 4px 10px;
                text-align: center;
            }
            h4 {
                font-size: 15px;
                margin-top: 30px;
            }
        </style>
    </head>
    ## TODO: Passar sempre l'inliner: https://templates.mailchimp.com/resources/inline-css/
    <body style="text-align: justify; font-family: 'Roboto Mono', Arial; font-size: 14px; line-height: 175%;" >
        <div style="width:96%;max-width:1200px;margin:20px auto;">

            % if data['lang'] == "ca_ES":
                <a href="https://www.somenergia.coop/ca/"><img src="https://www.somenergia.coop/logo/logo.png"></a>
            %endif
            % if data['lang'] != "ca_ES":
                <a href="https://www.somenergia.coop/es/"><img src="https://www.somenergia.coop/logo/logo.png"></a>
            %endif

            <br>
            <br>

            <p>Hola${data['nom_titular']}</p>

            % if data['lang'] == "ca_ES":
                % if data['modcon'] == "index":
                    <figure class="table">
                        <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                            <tbody>
                                <tr>
                                    <td>
                                        <p><span style="font-weight: 400;text-align: left;">
                                            Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que s'hauria de produir en les pròximes setmanes. Igualment, com que encara estàs amb la tarifa ${data['tarifa_acces']} períodes, t'expliquem més avall els canvis de preu que hi aplicarem a partir de l'1 d'abril, i que t'afectaran si, per algun motiu, el teu contracte segueix amb la tarifa de períodes.
                                        </span></p>
                                        <p><span style="font-weight: 400;text-align: left;">
                                            La tarifa ${data['tarifa_acces']} indexada no canvia, tan sols s'actualitza l'impost elèctric que, tal com <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">va establir el govern</a>, l'1 d'abril passarà del 2,5% al 3,8%. Aquesta és una actualització legal que s'aplica a tots els contractes d'electricitat. Al nostre web pots trobar, com sempre, els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">preus de la tarifa indexada</a>.
                                        </span></p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>

                    <br/>
                    <h3>Canvis de preus de la tarifa ${data['tarifa_acces']} períodes</h3>
                % elif data['modcon'] == "atr":
                    <p><span style="font-weight: 400;text-align: left;">
                        Som conscients que el teu contracte està pendent d'un canvi de tarifa cap a la <strong>tarifa ${data['tarifa_acces']} períodes</strong> que s'hauria de produir en les pròximes setmanes. A la tarifa per períodes li aplicarem un canvi de preus <strong>lleugerament a la baixa</strong> a partir de l'1 d'abril. Ho expliquem a <a href="https://blog.somenergia.coop/?p=47158">aquesta notícia del blog</a>, i a l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#opcions-de-la-tarifa-periodes">apartat de tarifes</a> del web pots veure els nous preus.
                    </span></p>
                    <p><span style="font-weight: 400;text-align: left;">
                        La tarifa indexada (que et serà d'aplicació mentre no se t'activi el canvi) no té actualització de preus més enllà de la variació de l'impost elèctric que, tal com <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">va establir el govern</a>, l'1 d'abril passarà del 2,5% al 3,8%. Aquesta és una actualització legal que s'aplica a tots els contractes d'electricitat. Al nostre web pots trobar, com sempre, els <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-periodes/#opcions-de-la-tarifa-periodes">preus de les tarifes per períodes</a> que aplicarem a partir de l'1 d'abril i els de <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/#opcions-de-la-tarifa-indexada">les tarifes indexades</a>. També pots veure, a l'<a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/historic-de-tarifes/">apartat històric</a>, els preus anteriors a 1 d'abril de 2024.
                    </span></p>
                % endif

                % if not (data['indexada'] and data['modcon']):
                <p><span style="font-weight: 400;">
                    L'1 d'abril actualitzarem el preu de l'electricitat de les tarifes per períodes${" (la que tens ara, ho és)" if data['periodes'] else ""}.
                    El preu de l'energia al mercat majorista ha baixat, i les previsions per als propers mesos indiquen que seguiran sent baixos; això ens permet, doncs, <strong>abaixar el preu de l'energia</strong> de les nostres tarifes per períodes.
                </span></p>

                <h3>Impostos regulats</h3>

                <p><span style="font-weight: 400;">
                    Per altra banda, l'impost elèctric passarà del 2,5% al 3,8%. Forma part de les mesures que va establir el govern al <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Reial decret llei 8/2023</a>, de recuperació progressiva dels impostos.
                    %if data['te_iva10']:
                        El mateix decret estableix que <strong>l'IVA de l'electricitat seguirà rebaixat al 10% a no ser que el preu de l'energia baixi molt.</strong> Si baixa molt (si la mitjana mensual del preu de l'energia al mercat diari és inferior a 45 euros), l'IVA a aplicar serà del 21%.
                    %endif
                </span></p>
                %endif

                % if data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries']:
                    <h3>Nous preus i comparativa amb preus actuals</h3>
                    <p><span style="font-weight: 400;">
                        A continuació tens una taula amb els nous preus (vigents a partir de l'1 d'abril), i una comparació amb els preus actuals (vigents fins a 31 de març) de la tarifa que tens contractada. Els impostos aplicats són els vigents a cada moment (${data['impostos_str']}, i impost elèctric del 2,5% per als preus actuals, i del 3,8% per als preus nous).
                    </span></p>
                    <h4>Tarifa 2.0TD períodes</h4>
                    <p><strong>Preu del terme d'energia (en euros/kWh)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th colspan="3"><strong>Nous preus</strong></th>
                                    <th colspan="3"><strong>Preus actuals</strong></th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Període punta</td>
                                    <td>Període pla</td>
                                    <td>Període vall</td>
                                    <td>Període punta</td>
                                    <td>Període pla</td>
                                    <td>Període vall</td>
                                </tr>
                                <tr>
                                    <td>Sense impostos</td>
                                    <td>${data['preus_nous']['te']['P1']}</td>
                                    <td>${data['preus_nous']['te']['P2']}</td>
                                    <td>${data['preus_nous']['te']['P3']}</td>
                                    <td>${data['preus_antics']['te']['P1']}</td>
                                    <td>${data['preus_antics']['te']['P2']}</td>
                                    <td>${data['preus_antics']['te']['P3']}</td>
                                </tr>
                                <tr>
                                    <td>Amb impostos</td>
                                    <td>${data['preus_nous_imp']['te']['P1']}</td>
                                    <td>${data['preus_nous_imp']['te']['P2']}</td>
                                    <td>${data['preus_nous_imp']['te']['P3']}</td>
                                    <td>${data['preus_antics_imp']['te']['P1']}</td>
                                    <td>${data['preus_antics_imp']['te']['P2']}</td>
                                    <td>${data['preus_antics_imp']['te']['P3']}</td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                     <p><strong>Preu del terme de potència (en euros/kW a l'any)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th colspan="2"><strong>Nous preus</strong></th>
                                    <th colspan="2"><strong>Preus actuals</strong></th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Període punta</td>
                                    <td>Període vall</td>
                                    <td>Període punta</td>
                                    <td>Període vall</td>
                                </tr>
                                <tr>
                                    <td>Sense impostos</td>
                                    <td>${data['preus_nous']['tp']['P1']}</td>
                                    <td>${data['preus_nous']['tp']['P2']}</td>
                                    <td>${data['preus_antics']['tp']['P1']}</td>
                                    <td>${data['preus_antics']['tp']['P2']}</td>
                                </tr>
                                <tr>
                                    <td>Amb impostos</td>
                                    <td>${data['preus_nous_imp']['tp']['P1']}</td>
                                    <td>${data['preus_nous_imp']['tp']['P2']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P1']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P2']}</td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                %endif

                % if data['Periodes30i60TDPeninsula']:
                    <h3>Nous preus i comparativa amb preus actuals</h3>
                    <p><span style="font-weight: 400;">
                        A continuació tens una taula amb els nous preus (vigents a partir de l'1 d'abril) i els preus actuals (vigents fins al 31 de març) de la tarifa que tens contractada. Els impostos aplicats són els vigents a cada moment (${data['impostos_str']}, i impost elèctric del 2,5% per als preus actuals, i del 3,8% per als preus nous).
                    </span></p>
                    <br/>
                    <h4>Tarifa ${data['tarifa_acces']} períodes</h4>
                    <p><strong>Preu del terme d'energia (en euros/kWh)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>Sense impostos aplicats</th>
                                    <th>Amb impostos aplicats</th>
                                </tr>
                                <tr>
                                    <td rowspan="6"><strong>Nous preus</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_nous']['te']['P1']}</td>
                                    <td>${data['preus_nous_imp']['te']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_nous']['te'][periode]}</td>
                                        <td>${data['preus_nous_imp']['te'][periode]}</td>
                                    </tr>
                                % endfor
                                <tr>
                                    <td rowspan="6"><strong>Preus actuals</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_antics']['te']['P1']}</td>
                                    <td>${data['preus_antics_imp']['te']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_antics']['te'][periode]}</td>
                                        <td>${data['preus_antics_imp']['te'][periode]}</td>
                                    </tr>
                                % endfor
                            </tbody>
                        </table>
                    </figure>
                    <p><strong>Preu del terme de potència (en euros/kW a l'any)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>Sense impostos aplicats</th>
                                    <th>Amb impostos aplicats</th>
                                </tr>
                                <tr>
                                    <td rowspan="6"><strong>Nous preus</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_nous']['tp']['P1']}</td>
                                    <td>${data['preus_nous_imp']['tp']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_nous']['tp'][periode]}</td>
                                        <td>${data['preus_nous_imp']['tp'][periode]}</td>
                                    </tr>
                                % endfor
                                <tr>
                                    <td rowspan="6"><strong>Preus actuals</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_antics']['tp']['P1']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_antics']['tp'][periode]}</td>
                                        <td>${data['preus_antics_imp']['tp'][periode]}</td>
                                    </tr>
                                % endfor
                            </tbody>
                        </table>
                    </figure>
                % endif

                % if not (data['indexada'] and data['modcon']):
                    %if  data['autoconsum']['es_autoconsum'] and data['autoconsum']['compensacio']:
                        <h3>Autoproducció</h3>
                        <p><span style="font-weight: 400;">
                            Per als contractes que teniu autoproducció amb compensació simplificada, els excedents d'autoproducció els continuarem compensant al mateix valor de referència del cost de l'energia que fem servir per calcular el preu de venda. Com que el cost de referència de l'energia en hores de producció fotovoltaica ha baixat, disminueix també la compensació d'excedents, i se situa a valors de mitjans de 2021.
                        </span></p>

                        <p><strong>Preu de compensació d'excedents d'autoproducció (en euros/kWh)</strong></p>
                        <figure class="table">
                            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                                <tbody>
                                    <tr>
                                        <th></th>
                                        <th><strong>Nous preus</strong></th>
                                        <th><strong>Preus actuals</strong></th>
                                    </tr>
                                    <tr>
                                        <td>Sense impostos aplicats</td>
                                        <td>${data['auto']['nous']['sense_impostos']}</td>
                                        <td>${data['auto']['vells']['sense_impostos']}</td></td>
                                    </tr>
                                    <tr>
                                        <td>Amb impostos aplicats</td>
                                        <td>${data['auto']['nous']['amb_impostos']}</td></td>
                                        <td>${data['auto']['vells']['amb_impostos']}</td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </figure>
                        <br/>
                        <p><span style="font-weight: 400;">
                            Et recordem que també tens activat el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats/">Flux Solar</a>, que proporciona descomptes per als excedents que no poden ser compensats amb la compensació simplificada. Pots veure si tens Sols disponibles a la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a> (<a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar#sols">aquí</a> t'expliquem el camí). Si és el cas, se t'aniran aplicant a les properes factures.
                        </span></p>
                    %else:
                        <h3>Autoproducció</h3>
                        <p><span style="font-weight: 400;">
                            Com que ha baixat el preu de l'energia, abaixem també el preu de compensació dels excedents d'autoproducció. Els contractes que tenen compensació simplificada també tenen activat el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats/">Flux Solar</a>, que proporciona descomptes per als excedents que no poden ser compensats amb la compensació simplificada.
                        </span></p>
                    %endif
                

                    %if data['te_gkwh']:
                        <h3>Generation kWh</h3>
                        <p><span style="font-weight: 400;">
                            Respecte a la tarifa Generation kWh, el preu ha disminuït lleugerament. No ha variat el cost de l'energia (ja que no depèn del mercat majorista), sinó que ha baixat algun dels altres components del preu, com per exemple el que està relacionat amb les pèrdues d'energia pel trasllat per la xarxa.
                        </span></p>
                        <p><strong>Generation kWh: preu del terme d'energia (en euros/kWh)</strong></p>
                        %if data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries']:
                            <figure class="table">
                                <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                                    <tbody>
                                        <tr>
                                            <th></th>
                                            <th colspan="3"><strong>Nous preus</strong></th>
                                            <th colspan="3"><strong>Preus actuals</strong></th>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Període punta</td>
                                            <td>Període pla</td>
                                            <td>Període vall</td>
                                            <td>Període punta</td>
                                            <td>Període pla</td>
                                            <td>Període vall</td>
                                        </tr>
                                        <tr>
                                            <td>Sense impostos aplicats</td>
                                            <td>${data['preus_nous_generation']['P1']}</td>
                                            <td>${data['preus_nous_generation']['P2']}</td>
                                            <td>${data['preus_nous_generation']['P3']}</td>
                                            <td>${data['preus_antics_generation']['P1']}</td>
                                            <td>${data['preus_antics_generation']['P2']}</td>
                                            <td>${data['preus_antics_generation']['P3']}</td>
                                        </tr>
                                        <tr>
                                            <td>Amb impostos aplicats</td>
                                            <td>${data['preus_nous_generation_imp']['P1']}</td>
                                            <td>${data['preus_nous_generation_imp']['P2']}</td>
                                            <td>${data['preus_nous_generation_imp']['P3']}</td>
                                            <td>${data['preus_antics_generation_imp']['P1']}</td>
                                            <td>${data['preus_antics_generation_imp']['P2']}</td>
                                            <td>${data['preus_antics_generation_imp']['P3']}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </figure>
                        %else:
                            <figure class="table">
                                <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                                    <tbody>
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th>Sense impostos aplicats</th>
                                            <th>Amb impostos aplicats</th>
                                        </tr>
                                        <tr>
                                            <td rowspan="6">Nous preus</td>
                                            <td>P1</td>
                                            <td>${data['preus_nous_generation']['P1']}</td>
                                            <td>${data['preus_nous_generation_imp']['P1']}</td>
                                        </tr>
                                        % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                            <tr>
                                                <td>${periode}</td>
                                                <td>${data['preus_nous_generation'][periode]}</td>
                                                <td>${data['preus_nous_generation_imp'][periode]}</td>
                                            </tr>
                                        % endfor
                                        <tr>
                                            <td rowspan="6">Preus actuals</td>
                                            <td>P1</td>
                                            <td>${data['preus_antics_generation']['P1']}</td>
                                            <td>${data['preus_antics_generation_imp']['P1']}</td>
                                        </tr>
                                        % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                            <tr>
                                                <td>${periode}</td>
                                                <td>${data['preus_antics_generation'][periode]}</td>
                                                <td>${data['preus_antics_generation_imp'][periode]}</td>
                                            </tr>
                                        % endfor
                                    </tbody>
                                </table>
                            </figure>
                        %endif
                    %endif

                    <h3>Estimació</h3>
                    ## TODO validar primer paragraf que agafi bé l'origen
                    %if data['origen'] == 'consums': # Factura
                        <p><span style="font-weight: 400;">
                            Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, si apliquéssim els preus actuals i si apliquéssim els preus nous. L'estimació l'hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i sense autoproducció, ni Generation kWh, ni lloguer de comptador.
                        </span></p>

                        <p><span style="font-weight: 400;">
                            L'estimació la pots veure sense impostos i amb impostos inclosos, els vigents actualment (${data['impostos_str']} i l'impost elèctric del 2,5%).
                        </span></p>
                    %endif

                    %if data['origen'] == 'cnmc':
                        <p><span style="font-weight: 400;">
                            Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L'estimació l'hem fet a partir de les dades que tenim dels teus consums (sense tenir en compte autoproducció ni Generation kWh ni lloguer de comptador), extrapolant-les segons el consum mitjà que sol haver-hi a cada mes (segons dades de la Comissió Nacional dels Mercats i la Competència). Amb això n'hem obtingut un consum anual, que és el que fem servir per a la comparació.
                        </span></p>

                        <p><span style="font-weight: 400;">
                            L'estimació la pots veure sense impostos i amb impostos inclosos, els vigents actualment (${data['impostos_str']} i l'impost elèctric del 2,5%).
                        </span></p>
                    %endif

                    %if data['origen'] == 'estadistic':
                        <p><span style="font-weight: 400;">
                            Tal com estableix la normativa, hem fet una <strong>estimació de caràcter orientatiu</strong> del que et costaria l'energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L'estimació l'hem fet en funció de la potència contractada més alta que tens (${data['potencia_max']} kW), l'ús d'electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense autoproducció ni Generation kWh ni lloguer de comptador.
                        </span></p>

                        <p><span style="font-weight: 400;">
                            L'estimació la pots veure sense impostos o amb impostos inclosos, els vigents actualment (${data['impostos_str']} i l'impost elèctric del 2,5%).
                        </span></p>
                    %endif

                    <p><strong>
                        Cost anual estimat (euros/any) del subministrament (cost de l'energia i potència) i comparativa amb el cost actual:
                    </strong></p>

                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th>Cost estimat amb els nous preus</th>
                                    <th>Cost estimat amb els preus actuals</th>
                                </tr>
                                <tr>
                                    <td>Sense impostos aplicats</td>
                                    <td>${data['preu_nou']}</td>
                                    <td>${data['preu_vell']}</td>
                                </tr>
                                <tr>
                                    <td>Amb impostos aplicats</td>
                                    <td>${data['preu_nou_imp']}</td>
                                    <td>${data['preu_vell_imp']}</td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                    <p><span style="font-weight: 400;">
                        Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l'ús d'energia que finalment facis, altres variacions de preus durant l'any,${" la possible recuperació de l'IVA al 21% per a algun mes," if data['te_iva10'] else ""} o canvis que hi pugui haver al mercat elèctric.
                    </span></p>
                    <br/>

                    <p><span style="font-weight: 400;">
                        Al nostre blog trobaràs la <a href="https://blog.somenergia.coop/?p=47158">notícia</a> del canvi de tarifes, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l'apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de març i els de períodes anteriors.
                    </span></p>
                %endif

                <h3>Informació legal</h3>

                <p><span style="font-weight: 400;">
                    Les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusules contractuals de les Condicions Generals</a> que ens autoritzen a fer aquest canvi de preus són la clàusula 5.3 (i) per als canvis regulats per normativa (per exemple, els impostos), i la clàusula 5.3 (ii) per a les modificacions de la part del preu no regulada.
                </span></p>
                <p><span style="font-weight: 400;">
                    Pots accedir al comparador d'ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través d'<a href="https://comparador.cnmc.gob.es">aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents de les comercialitzadores del mercat lliure. Tingues en compte que possiblement, al moment de llegir aquest correu, les noves tarifes de Som Energia encara no hi seran reflectides.
                </span></p>

                % if data['modcon']:
                    <p><span style="font-weight: 400;">
                        Després d'haver-te compartit aquesta informació, si aquest canvi de preus et fes replantejar seguir amb la modificació sol·licitada, podries demanar que s'aturi la modificació de tarifa (escrivint-nos a <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a>) o bé podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                    </span></p>
                %else:
                    <p><span style="font-weight: 400;">
                        T'adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">tarifa indexada</a> (<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                    </span></p>
                %endif

                <p><span style="font-weight: 400;">
                    Una salutació cordial,
                </span></p>
                <br/>
                <p><span style="font-weight: 400;">
                    Equip de Som Energia
                </span></p>
                <p><span style="font-weight: 400;">
                    <a href="https://www.somenergia.coop/ca">www.somenergia.coop</a>
                </span></p>
            %elif data['lang'] != "ca_ES":
                %if data['modcon'] == 'index':
                    <figure class="table">
                        <table style="background-color: #D3E5C3; border: 4px solid #657557; padding-top: 1em;padding-left: 2em;padding-right: 2em;padding-bottom: 1em;">
                            <tbody>
                                <tr>
                                    <td>
                                        <p><span style="font-weight: 400;text-align: left;">
                                            Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} indexada</strong>, que debería producirse en las próximas semanas. Igualmente, como todavía estás con la tarifa ${data['tarifa_acces']} periodos, te explicamos más abajo los cambios de precio que le aplicaremos a partir del 1 de abril, y que te afectarán si, por algún motivo, tu contrato sigue con la tarifa de periodos.
                                        </span></p>
                                        <p><span style="font-weight: 400;text-align: left;">
                                            La tarifa ${data['tarifa_acces']} indexada no cambia, tan solo se actualiza el impuesto eléctrico que, tal y como  <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">estableció el gobierno</a>, el 1 de abril pasará del 2,5% al 3,8%. Esta es una actualización legal que se aplica a todos los contratos de electricidad. En nuestra web puedes encontrar, como siempre, los <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">precios de la tarifa indexada</a>.
                                        </span></p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>

                    <br/>
                    <h3>Cambios de precios de la tarifa ${data['tarifa_acces']} periodos</h3>
                %elif data['modcon'] == 'atr':
                    <p><span style="font-weight: 400;text-align: left;">
                        Somos conscientes de que tu contrato está pendiente de un cambio de tarifa hacia la <strong>tarifa ${data['tarifa_acces']} periodos</strong> que debería producirse en las próximas semanas. A la tarifa por periodos le aplicaremos un cambio de precios <strong>ligeramente a la baja</strong> a partir del 1 de abril. Lo explicamos en <a href="https://blog.somenergia.coop/?p=47160">esta noticia del blog</a>, i en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#opciones-de-la-tarifa-por-periodos">apartado de tarifas</a> de la web puedes ver los nuevos precios.
                    </span></p>
                    <p><span style="font-weight: 400;text-align: left;">
                        La tarifa indexada (que te será de aplicación mientras no se te active el cambio) no tiene actualización de precios más allá de la variación del impuesto eléctrico que, tal y como <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">estableció el gobierno</a>, el 1 de abril pasará del 2,5% al 3,8%. Esta es una actualización legal que se aplica a todos los contratos de electricidad. En nuestra web puedes encontrar, como siempre, los <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-periodos/#opciones-de-la-tarifa-por-periodos">precios de las tarifas por periodos</a> que aplicaremos a partir del 1 de abril y los de <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/#opciones-de-la-tarifa-indexada">las tarifas indexadas</a>. También puedes ver, en el <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">apartado histórico</a>, los precios anteriores a 1 de abril de 2024.
                    </span></p>
                %endif

                % if not (data['indexada'] and data['modcon']):
                <p><span style="font-weight: 400;">
                    El 1 de abril actualizaremos el precio de la electricidad de las tarifas por periodos${" (la que tienes ahora, lo es)" if data['periodes'] else ""}.
                    El precio de la energía en el mercado mayorista ha bajado, y las previsiones para los próximos meses indican que seguirán siendo bajos; esto nos permite, pues, <strong>bajar el precio de la energía</strong> de nuestras tarifas por periodos.
                </span></p>

                <h3>Impuestos regulados</h3>

                <p><span style="font-weight: 400;">
                    Por su parte, el impuesto eléctrico pasará del 2,5% al 3,8%. Forma parte de las medidas que estableció el gobierno en el <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Real decreto ley 8/2023</a>, de recuperación progresiva de los impuestos.
                    %if data['te_iva10']:
                        El mismo decreto establece que <strong>el IVA de la electricidad seguirá rebajado al 10% a menos que el precio de la energía baje mucho.</strong> Si baja mucho (si la media mensual del precio de la energía en el mercado diario es inferior a 45 euros), el IVA a aplicar será del 21%.
                    %endif
                </span></p>
                %endif

                % if data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries']:
                    <h3>Nuevos precios y comparativa con precios actuales</h3>
                    <p><span style="font-weight: 400;">
                        A continuación tienes una tabla con los nuevos precios (vigentes a partir del 1 de abril) y una comparación con los precios actuales (vigentes hasta el 31 de marzo) de la tarifa que tienes contratada. Los impuestos aplicados son los vigentes en cada momento (${data['impostos_str']}, e impuesto eléctrico del 2,5% para los precios actuales, y del 3,8% para los precios nuevos).
                    </span></p>
                    <h4>Tarifa 2.0TD periodos</h4>
                    <p><strong>Precio del término de energía (en euros/kWh)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th colspan="3"><strong>Nuevos precios</strong></th>
                                    <th colspan="3"><strong>Precios actuales</strong></th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Periodo punta</td>
                                    <td>Periodo llano</td>
                                    <td>Periodo valle</td>
                                    <td>Periodo punta</td>
                                    <td>Periodo llano</td>
                                    <td>Periodo valle</td>
                                </tr>
                                <tr>
                                    <td>Sin impuestos</td>
                                    <td>${data['preus_nous']['te']['P1']}</td>
                                    <td>${data['preus_nous']['te']['P2']}</td>
                                    <td>${data['preus_nous']['te']['P3']}</td>
                                    <td>${data['preus_antics']['te']['P1']}</td>
                                    <td>${data['preus_antics']['te']['P2']}</td>
                                    <td>${data['preus_antics']['te']['P3']}</td>
                                </tr>
                                <tr>
                                    <td>Con impuestos</td>
                                    <td>${data['preus_nous_imp']['te']['P1']}</td>
                                    <td>${data['preus_nous_imp']['te']['P2']}</td>
                                    <td>${data['preus_nous_imp']['te']['P3']}</td>
                                    <td>${data['preus_antics_imp']['te']['P1']}</td>
                                    <td>${data['preus_antics_imp']['te']['P2']}</td>
                                    <td>${data['preus_antics_imp']['te']['P3']}</td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                    <br/>
                    <p><strong>Precio del término de potencia (en euros/kW al año)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th colspan="2"><strong>Nuevos precios</strong></th>
                                    <th colspan="2"><strong>Precios actuales</strong></th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Periodo punta</td>
                                    <td>Periodo valle</td>
                                    <td>Periodo punta</td>
                                    <td>Periodo valle</td>
                                </tr>
                                <tr>
                                    <td>Sin impuestos</td>
                                    <td>${data['preus_nous']['tp']['P1']}</td>
                                    <td>${data['preus_nous']['tp']['P2']}</td>
                                    <td>${data['preus_antics']['tp']['P1']}</td>
                                    <td>${data['preus_antics']['tp']['P2']}</td>
                                </tr>
                                <tr>
                                    <td>Con impuestos</td>
                                    <td>${data['preus_nous_imp']['tp']['P1']}</td>
                                    <td>${data['preus_nous_imp']['tp']['P2']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P1']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P2']}</td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                %endif

                % if data['Periodes30i60TDPeninsula']:
                    <h3>Nuevos precios y comparativa con precios actuales</h3>
                    <p><span style="font-weight: 400;">
                        A continuación tienes una tabla con los nuevos precios (vigentes a partir del 1 de abril) y los precios actuales (vigentes hasta el 31 de marzo) de la tarifa que tienes contratada. Los impuestos aplicados son los vigentes en cada momento (${data['impostos_str']}, e impuesto eléctrico del 2,5% para los precios actuales, y del 3,8% para los precios nuevos).
                    </span></p>
                    <br/>
                    <h4>Tarifa ${data['tarifa_acces']} periodos</h4>
                    <p><strong>Precio del término de energía (en euros/kWh)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>Sin impuestos aplicados</th>
                                    <th>Con impuestos aplicados</th>
                                </tr>
                                <tr>
                                    <td rowspan="6"><strong>Nuevos precios</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_nous']['te']['P1']}</td>
                                    <td>${data['preus_nous_imp']['te']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_nous']['te'][periode]}</td>
                                        <td>${data['preus_nous_imp']['te'][periode]}</td>
                                    </tr>
                                % endfor
                                <tr>
                                    <td rowspan="6"><strong>Precios actuales</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_antics']['te']['P1']}</td>
                                    <td>${data['preus_antics_imp']['te']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_antics']['te'][periode]}</td>
                                        <td>${data['preus_antics_imp']['te'][periode]}</td>
                                    </tr>
                                % endfor
                            </tbody>
                        </table>
                    </figure>
                    <br/>
                    <p><strong>Precio del término de potencia (en euros/kW al año)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>Sin impuestos aplicados</th>
                                    <th>Con impuestos aplicados</th>
                                </tr>
                                <tr>
                                    <td rowspan="6"><strong>Nuevos precios</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_nous']['tp']['P1']}</td>
                                    <td>${data['preus_nous_imp']['tp']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_nous']['tp'][periode]}</td>
                                        <td>${data['preus_nous_imp']['tp'][periode]}</td>
                                    </tr>
                                % endfor
                                <tr>
                                    <td rowspan="6"><strong>Precios actuales</strong></td>
                                    <td>P1</td>
                                    <td>${data['preus_antics']['tp']['P1']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P1']}</td>
                                </tr>
                                % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                    <tr>
                                        <td>${periode}</td>
                                        <td>${data['preus_antics']['tp'][periode]}</td>
                                        <td>${data['preus_antics_imp']['tp'][periode]}</td>
                                    </tr>
                                % endfor
                            </tbody>
                        </table>
                    </figure>
                % endif

                % if not (data['indexada'] and data['modcon']):

                    %if data['autoconsum']['es_autoconsum'] and data['autoconsum']['compensacio']:

                        <h3>Autoproducción</h3>
                        <p><span style="font-weight: 400;">
                            Para los contratos que tienen autoproducción con compensación simplificada, como es tu caso, los excedentes de autoproducción los seguiremos compensando al mismo valor de referencia del coste de la energía que utilizamos para calcular el precio de venta. Dado que el coste de referencia de la energía en horas de producción fotovoltaica ha bajado, disminuye también la compensación de excedentes, situándose en valores de mediados de 2021.
                        </span></p>
                        <br/>

                        <p><strong>Precio de compensación de excedentes de autoproducción (en euros/kWh)</strong></p>
                        <figure class="table">
                            <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                                <tbody>
                                    <tr>
                                        <th></th>
                                        <th><strong>Nuevos precios</strong></th>
                                        <th><strong>Precios actuales</strong></th>
                                    </tr>
                                    <tr>
                                        <td>Sin impuestos aplicados</td>
                                        <td>${data['auto']['nous']['sense_impostos']}</td>
                                        <td>${data['auto']['vells']['sense_impostos']}</td></td>
                                    </tr>
                                    <tr>
                                        <td>Con impuestos aplicados</td>
                                        <td>${data['auto']['nous']['amb_impostos']}</td></td>
                                        <td>${data['auto']['vells']['amb_impostos']}</td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </figure>
                        <br/>
                        <p><span style="font-weight: 400;">
                            Te recordamos que también tienes activado el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-la-herramienta-que-proporciona-descuentos-por-los-excedentes-de-autoproduccion-no-compensados/">Flux Solar</a>, que proporciona descuentos para los excedentes que no pueden compensarse con la compensación simplificada. Puedes ver si tienes Sols disponibles en tu <a href="https://oficinavirtual.somenergia.coop/es">Oficina Virtual</a> (<a href="https://es.support.somenergia.coop/article/1372-que-es-el-flux-solar#soles">aquí</a> te explicamos el camino). Si es el caso, se te irán aplicando en las próximas facturas.
                        </span></p>
                    %else:
                        <h3>Autoproducción</h3>
                        <p><span style="font-weight: 400;">
                            Como ha bajado el precio de la energía, bajamos también el precio de compensación de los excedentes de autoproducción. Los contratos que tienen compensación simplificada también tienen activado el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-la-herramienta-que-proporciona-descuentos-por-los-excedentes-de-autoproduccion-no-compensados/">Flux Solar</a>, que proporciona descuentos para los excedentes que no pueden ser compensados ​​con la compensación simplificada.
                        </span></p>
                    %endif

                    %if data['te_gkwh']:
                        <h3>Generation kWh</h3>
                        <p><span style="font-weight: 400;">
                            Respecto a la tarifa Generation kWh, el precio ha disminuido ligeramente. No ha variado el coste de la energía (ya que no depende del mercado mayorista), sino que ha bajado alguno de los otros componentes del precio, como por ejemplo el relacionado con las pérdidas de energía por el traslado por la red.
                        </span></p>
                        <p><strong>Generation: precio del término de energía (en euros/kWh)</strong></p>
                        %if data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries']:
                            <figure class="table">
                                <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                                    <tbody>
                                        <tr>
                                            <th></th>
                                            <th colspan="3"><strong>Nuevos precios</strong></th>
                                            <th colspan="3"><strong>Precios actuales</strong></th>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Periodo punta</td>
                                            <td>Periodo llano</td>
                                            <td>Periodo valle</td>
                                            <td>Periodo punta</td>
                                            <td>Periodo llano</td>
                                            <td>Periodo valle</td>
                                        </tr>
                                        <tr>
                                            <td>Sin impuestos aplicados</td>
                                            <td>${data['preus_nous_generation']['P1']}</td>
                                            <td>${data['preus_nous_generation']['P2']}</td>
                                            <td>${data['preus_nous_generation']['P3']}</td>
                                            <td>${data['preus_antics_generation']['P1']}</td>
                                            <td>${data['preus_antics_generation']['P2']}</td>
                                            <td>${data['preus_antics_generation']['P3']}</td>
                                        </tr>
                                        <tr>
                                            <td>Con impuestos aplicados</td>
                                            <td>${data['preus_nous_generation_imp']['P1']}</td>
                                            <td>${data['preus_nous_generation_imp']['P2']}</td>
                                            <td>${data['preus_nous_generation_imp']['P3']}</td>
                                            <td>${data['preus_antics_generation_imp']['P1']}</td>
                                            <td>${data['preus_antics_generation_imp']['P2']}</td>
                                            <td>${data['preus_antics_generation_imp']['P3']}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </figure>
                        %else:
                            <figure class="table">
                                <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                                    <tbody>
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th>Sin impuestos aplicados</th>
                                            <th>Con impuestos aplicados</th>
                                        </tr>
                                        <tr>
                                            <td rowspan="6">Nuevos precios</td>
                                            <td>P1</td>
                                            <td>${data['preus_nous_generation']['P1']}</td>
                                            <td>${data['preus_nous_generation_imp']['P1']}</td>
                                        </tr>
                                        % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                            <tr>
                                                <td>${periode}</td>
                                                <td>${data['preus_nous_generation'][periode]}</td>
                                                <td>${data['preus_nous_generation_imp'][periode]}</td>
                                            </tr>
                                        % endfor
                                        <tr>
                                            <td rowspan="6">Precios actuales</td>
                                            <td>P1</td>
                                            <td>${data['preus_antics_generation']['P1']}</td>
                                            <td>${data['preus_antics_generation_imp']['P1']}</td>
                                        </tr>
                                        % for periode in ('P2', 'P3', 'P4', 'P5', 'P6'):
                                            <tr>
                                                <td>${periode}</td>
                                                <td>${data['preus_antics_generation'][periode]}</td>
                                                <td>${data['preus_antics_generation_imp'][periode]}</td>
                                            </tr>
                                        % endfor
                                    </tbody>
                                </table>
                            </figure>
                        %endif
                    %endif

                    <h3>Estimación</h3>
                    %if data['origen'] == 'consums': # Factura
                        <p><span style="font-weight: 400;">
                            Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, si aplicáramos los precios actuales y si aplicáramos los precios nuevos. La estimación la hemos hecho a partir de los datos que tenemos respecto a lo que has consumido de la red eléctrica durante los últimos 12 meses (aproximadamente ${data['consum_total']} kWh) y las potencias que tienes contratadas, y sin autoproducción, ni Generation kWh, ni alquiler de contador.
                        </span></p>

                        <p><span style="font-weight: 400;">
                            La estimación la puedes ver sin impuestos y con impuestos incluidos, los vigentes actualmente (${data['impostos_str']} y el impuesto eléctrico del 2,5%).
                        </span></p>
                    %endif

                    %if data['origen'] == 'cnmc':
                        <p><span style="font-weight: 400;">
                            Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho a partir de los datos que tenemos de tus consumos (sin tener en cuenta autoproducción ni Generation kWh ni alquiler de contador), extrapolándolos según el consumo medio que suele haber en cada mes (según datos de la Comisión Nacional de los Mercados y la Competencia). Con esto hemos obtenido un consumo anual, que es el que utilizamos para la comparación.
                        </span></p>

                        <p><span style="font-weight: 400;">
                            La estimación la puedes ver sin impuestos y con impuestos incluidos, los vigentes actualmente (${data['impostos_str']} y el impuesto eléctrico del 2,5%).
                        </span></p>
                    %endif

                    %if data['origen'] == 'estadistic':
                        <p><span style="font-weight: 400;">
                            Tal y como establece la normativa, hemos hecho una <strong>estimación de carácter orientativo</strong> de lo que te costaría la energía y la potencia durante un año, aplicando los precios actuales y los nuevos. La estimación la hemos hecho en función de la potencia contratada más alta que tienes (${data['potencia_max']} kW), el uso de electricidad que suele haber con esta potencia y cogiendo de referencia un contrato estándar, sin autoproducción ni Generation kWh ni alquiler de contador.
                        </span></p>

                        <p><span style="font-weight: 400;">
                            La estimación puedes verla sin impuestos o con impuestos incluidos, los vigentes actualmente (${data['impostos_str']} y el impuesto eléctrico del 2,5%).
                        </span></p>
                    %endif

                    <p><strong>
                        Coste anual estimado (euros/año) del suministro (coste de la energía y potencia) y comparativa con el coste actual:
                    </strong></p>

                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th>Coste estimado con los nuevos precios</th>
                                    <th>Coste estimado con los precios actuales</th>
                                </tr>
                                <tr>
                                    <td>Sin impuestos aplicados</td>
                                    <td>${data['preu_nou']}</td>
                                    <td>${data['preu_vell']}</td>
                                </tr>
                                <tr>
                                    <td>Con impuestos aplicados</td>
                                    <td>${data['preu_nou_imp']}</td>
                                    <td>${data['preu_vell_imp']}</td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                    <p><span style="font-weight: 400;">
                        Ten en cuenta que esto son estimaciones aproximadas, y que los importes finales <strong>dependerán de circunstancias</strong> que no podemos prever, como por ejemplo los horarios y el uso de energía que finalmente hagas, otras variaciones de precios durante el año,${" la posible recuperación del IVA al 21% para algún mes," if data['te_iva10'] else ""} o cambios que pueda haber en el mercado eléctrico.
                    </span></p>
                    <br/>

                    <p><span style="font-weight: 400;">
                        En nuestro blog encontrarás la <a href="https://blog.somenergia.coop/?p=47160">noticia</a> del cambio de tarifas, y en la página web puedes consultar en cualquier momento <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/">todas las tarifas</a>. Si quieres hacer comparaciones, puedes acceder al apartado <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/historico-de-tarifas-de-electricidad/">histórico de tarifas</a>, donde están también los precios vigentes hasta el 31 de marzo y los de periodos anteriores.
                    </span></p>
                %endif

                <h3>Información legal</h3>

                <p><span style="font-weight: 400;">
                    Las <a href="https://www.somenergia.coop/es/condiciones-del-contrato-de-som-energia/#precio-y-actualizacion">cláusulas contractuales de las Condiciones Generales</a> que nos autorizan a realizar este cambio de precios son la cláusula 5.3 (i) para los cambios regulados por normativa (por ejemplo, los impuestos), y la cláusula 5.3 (ii) para las modificaciones de la parte del precio no regulada.
                </span></p>
                <p><span style="font-weight: 400;">
                    Puedes acceder al comparador de ofertas que elabora la Comisión Nacional de los Mercados y la Competencia (CNMC) a través de <a href="https://comparador.cnmc.gob.es">este enlace</a>. El comparador permite consultar y comparar las distintas ofertas vigentes de las comercializadoras del mercado libre. Ten en cuenta que posiblemente, en el momento de leer este correo, las nuevas tarifas de Som Energia todavía no estarán reflejadas.
                </span></p>

                % if data['modcon']:
                    <p><span style="font-weight: 400;">
                        Después de haberte compartido esta información, si este cambio de precios te hiciese replantear seguir con la modificación solicitada, podrías pedir que se detenga la modificación de tarifa (escribiéndonos a <a href="mailto:modifica@somenergia.coop">modifica@somenergia.coop</a>), o bien podrías dar de baja tu contrato con nosotros, bien comunicándolo directamente, o mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejamos de suministrarte energía, con los precios vigentes en cada momento.
                    </span></p>
                %else:
                    <p><span style="font-weight: 400;">
                        Te adjuntamos en este correo tu contrato actualizado con los nuevos precios. Si estás de acuerdo, <strong>no es necesario que nos devuelvas el documento firmado</strong>, puesto que la actualización de los precios de nuestras tarifas se aplica automáticamente. Igualmente, debemos informarte de que si, por alguna razón, este cambio de precios te hiciese replantear seguir con esta tarifa, podrías cambiarte a la <a href="https://www.somenergia.coop/es/tarifas-de-electricidad-que-ofrecemos/tarifa-indexada/">tarifa indexada</a> (<a href="https://es.support.somenergia.coop/article/1345-modificacion-de-la-tarifa-de-periodos-a-indexada-y-de-indexada-a-periodos?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">a través de tu Oficina Virtual</a>), o podrías dar de baja tu contrato con nosotros, bien comunicándolo directamente, o mediante un cambio de comercializadora. Te recordamos que en la cooperativa no aplicamos penalizaciones ni cláusulas de permanencia en ningún momento. Así pues, si decidieras marcharte, sólo te facturaríamos el consumo realizado hasta el día en que dejamos de suministrarte energía, con los precios vigentes en cada momento.
                    </span></p>
                %endif

                <p><span style="font-weight: 400;">
                    Un cordial saludo,
                </span></p>
                <br/>
                <p><span style="font-weight: 400;">
                    Equipo de Som Energia
                </span></p>
                <p><span style="font-weight: 400;">
                    <a href="https://www.somenergia.coop/es">www.somenergia.coop</a>
                </span></p>
            %endif

            ${data['text_legal']}
        </div>
    </body>
</html>
