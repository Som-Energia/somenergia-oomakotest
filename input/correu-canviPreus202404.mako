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

            .cuadricula td, .cuadricula th {
                border: 1px solid;
                padding: 4px 10px;
                text-align: center;
            }
        </style>
    </head>
    ## TODO: Passar sempre l'inliner: https://templates.mailchimp.com/resources/inline-css/
    <body style="text-align: justify; font-family: 'Roboto Mono', Arial; font-size: 14px; line-height: 175%;" >
        <div style="width:96%;max-width:1200px;margin:20px auto;">

            % if data['lang'] == "ca_ES":
                <a href="https://www.somenergia.coop/ca/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
            %endif
            % if data['lang'] != "ca_ES":
                <a href="https://www.somenergia.coop/es/"><img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png"></a>
            %endif

            <br>
            <br>

            <p>Hola${data['nom_titular']}</p>

            % if data['lang'] == "ca_ES":
                <p><span style="font-weight: 400;">
                    L'1 d'abril actualitzarem el preu de l'electricitat de les tarifes per períodes (la que tens ara, ho és). El preu de l'energia al mercat majorista ha baixat, i les previsions per als propers mesos indiquen que seguiran sent baixos; això ens permet, doncs, abaixar el preu de l'energia de les nostres tarifes.
                </span></p>

                <p><span style="font-weight: 400;"><strong>Impostos regulats</strong></span></p>

                <p><span style="font-weight: 400;">
                    Per altra banda, l'impost elèctric passarà del 2,5% al 3,8%. Forma part de les mesures que va establir el govern al <a href="https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-26452">Reial decret llei 8/2023</a>, de 27 de desembre, de recuperació progressiva dels impostos.
                    %if data['Periodes20TDPeninsulaFins10kw']:
                        El mateix decret estableix que l'IVA de l'electricitat seguirà rebaixat al 10% a no ser que el preu de l'energia baixi molt. Si baixa molt (si la mitjana mensual del preu de l'energia al mercat diari és inferior a 45 euros), l'IVA a aplicar serà del 21%.
                    %endif
                </span></p>

                <p><span style="font-weight: 400;">
                    <strong>Nous preus i comparativa amb preus actuals </strong>
                </span></p>
                <p><span style="font-weight: 400;">
                    A continuació tens una taula amb els nous preus (vigents a partir de l'1 d'abril), i una comparació amb els preus actuals (vigents fins a 31 de març) de la tarifa que tens contractada. Els impostos aplicats són els vigents a cada moment (${data['impostos_str']}, i impost elèctric del 2,5% per als preus actuals, i del 3,8% per als preus nous).
                </span></p>
                <br>

                % if data['Periodes20TDPeninsulaFins10kw'] or data['Periodes20TDPeninsulaMesDe10kw'] or data['Periodes20TDCanaries']:
                    <p><strong>Nous preus i comparativa amb preus actuals</strong></p>
                    <p><span style="font-weight: 400;">
                        A continuació tens una taula amb els nous preus d'energia i potència (vigents a partir de l'1 de gener de 2024), i una comparació amb els preus actuals (vigents fins a 31 de desembre de 2023) de la tarifa que tens contractada actualment. En els dos casos els impostos aplicats són ${data['impostos_str']} i impost elèctric del 5,11%.
                    </span></p>
                    <br>
                    <p><strong>Tarifa 2.0TD períodes</strong></p>
                    <p><strong>Preu del terme d'energia (en euros/kWh)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th colspan="3">Nous preus</th>
                                    <th colspan="3">Preus actuals</th>
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
                                    <td>Abans d'impostos</td>
                                    <td>${data['preus_nous']['te']['P1']}</td>
                                    <td>${data['preus_nous']['te']['P2']}</td>
                                    <td>${data['preus_nous']['te']['P3']}</td>
                                    <td>${data['preus_antics']['te']['P1']}</td>
                                    <td>${data['preus_antics']['te']['P2']}</td>
                                    <td>${data['preus_antics']['te']['P3']}</td>
                                </tr>
                                <tr>
                                    <td>Després d'impostos</td>
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
                    <p><strong>Preu del terme de potència (en euros/kW i dia)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th colspan="2">Nous preus</th>
                                    <th colspan="2">Preus actuals</th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Període punta</td>
                                    <td>Període vall</td>
                                    <td>Període punta</td>
                                    <td>Període vall</td>
                                </tr>
                                <tr>
                                    <td>Abans d'impostos</td>
                                    <td>${data['preus_nous']['tp']['P1']}</td>
                                    <td>${data['preus_nous']['tp']['P2']}</td>
                                    <td>${data['preus_antics']['tp']['P1']}</td>
                                    <td>${data['preus_antics']['tp']['P2']}</td>
                                </tr>
                                <tr>
                                    <td>Després d'impostos</td>
                                    <td>${data['preus_nous_imp']['tp']['P1']}</td>
                                    <td>${data['preus_nous_imp']['tp']['P2']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P1']}</td>
                                    <td>${data['preus_antics_imp']['tp']['P2']}</td>
                                </tr>
                            </tbody>
                        </table>
                    </figure>
                    <br/>
                %endif

                % if data['Periodes30i60TDPeninsula']:
                    <p><strong>Nous preus i comparativa amb preus actuals</strong></p>
                    <p><span style="font-weight: 400;">
                        A continuació tens una taula amb els nous preus (vigents a partir de l'1 d'abril) i els preus actuals (vigents fins al 31 de març) de la tarifa que tens contractada. Els impostos aplicats són els vigents a cada moment (${data['impostos_str']} , i impost elèctric del 2,5% per als preus actuals, i del 3,8% per als preus nous).
                    </span></p>
                    <br/>
                    <p><strong>Tarifa ${data['tarifa_acces']} períodes</strong></p>
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
                                    <td rowspan="6">Nous preus</td>
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
                                    <td rowspan="6">Preus actuals</td>
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
                    <p><strong>Preu del terme de potència (en euros/kW i dia)</strong></p>
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
                                    <td rowspan="6">Preus actuals</td>
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
                    <br/>
                % endif

                %if autoproduccio and sense autoproduccio amb compensacio simplificada: #TODO

                    <p><strong>Autoproducció</strong></p>
                    <p><span style="font-weight: 400;">
                        Com que ha baixat el preu de l'energia, abaixem també el preu de compensació dels excedents d'autoproducció. Els contractes que tenen compensació simplificada també tenen activat el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats/">Flux Solar</a>, que proporciona descomptes per als excedents que no poden ser compensats amb la compensació simplificada.
                    </span></p>
                    <br/>

                %endif

                %if autoproduccio and autoproduccio amb compensacio simplifcata #TODO

                    <p><strong>Autoproducció</strong></p>
                    <p><span style="font-weight: 400;">
                        Per als contractes que teniu autoproducció amb compensació simplificada, els excedents d'autoproducció els continuarem compensant al mateix valor de referència del cost de l'energia que fem servir per calcular el preu de venda. Com que el cost de referència de l'energia en hores de producció fotovoltaica ha baixat, disminueix també la compensació d'excedents, i se situa a valors de mitjans de 2021.
                    </span></p>
                    <br/>

                    <p><strong>Preu de compensació d'excedents d'autoproducció (en euros/kWh)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th>Nous preus</th>
                                    <th>Preus actuals</th>
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
                        Et recordem que també tens activat el <a href="https://blog.somenergia.coop/som-energia/2023/10/flux-solar-leina-que-proporciona-descomptes-pels-excedents-dautoproduccio-no-compensats/">Flux Solar</a>", que proporciona descomptes per als excedents que no poden ser compensats amb la compensació simplificada. Pots veure si tens Sols disponibles a la teva <a href="https://oficinavirtual.somenergia.coop/ca/">Oficina Virtual</a> (<a href="https://ca.support.somenergia.coop/article/1371-que-es-el-flux-solar#sols">aquí</a> t'expliquem el camí). Si és el cas, se t'aniran aplicant a les properes factures.
                    </span></p>
                %endif

                %if data['te_gkwh']:
                    <p><strong>Generation kWh</strong></p>
                    <p><span style="font-weight: 400;">
                        Respecte a la tarifa Generation kWh, el preu ha disminuït lleugerament. No ha variat el cost de l'energia (ja que no depèn del mercat majorista), sinó que ha baixat algun dels altres components del preu, com per exemple el que està relacionat amb les pèrdues d'energia pel trasllat per la xarxa.
                    </span></p>
                    <p><strong>Generation kWh: preu del terme d'energia (en euros/kWh)</strong></p>
                    <figure class="table">
                        <table class="cuadricula" style="background-color: #eeeeee; border: 4px solid gray; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th colspan="3">Nous preus</th>
                                    <th colspan="3">Preus actuals</th>
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
                %endif


                %if data['origen'] == 'consums': # Factura
                    <p><span style="font-weight: 400;">
                        Tal com estableix la normativa, hem fet una estimació de caràcter orientatiu del que et costaria l'energia i la potència durant un any, si apliquéssim els preus actuals i si apliquéssim els preus nous. L'estimació l'hem fet a partir de les dades que tenim respecte al que has consumit de la xarxa elèctrica durant els últims 12 mesos (aproximadament ${data['consum_total']} kWh) i les potències que tens contractades, i sense autoproducció, ni Generation kWh, ni lloguer de comptador.
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
                        Tal com estableix la normativa, hem fet una estimació de caràcter orientatiu del que et costaria l'energia i la potència durant un any, aplicant-hi els preus actuals i els preus nous. L'estimació l'hem fet en funció de la potència contractada més alta que tens (XXX kW), l'ús d'electricitat que sol haver-hi amb aquesta potència i agafant de referència un contracte estàndard, sense autoproducció ni Generation kWh ni lloguer de comptador.  ##TODO
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
                <br/>

                <p><span style="font-weight: 400;">
                    Tingues en compte que això són estimacions aproximades, i que els imports finals <strong>dependran de circumstàncies</strong> que no podem preveure, com per exemple els horaris i l'ús d'energia que finalment facis, altres variacions de preus durant l'any
                    %if iva10: #TODO
                        [, la possible recuperació de l'IVA al 21% per a algun mes,]
                    %endif
                    o canvis que hi pugui haver al mercat elèctric.
                </span></p>

                <p><span style="font-weight: 400;">
                    Al nostre blog trobaràs la <a href="https://blog.somenergia.coop/?p=47158">notícia</a> del canvi de tarifes, i a la pàgina web pots consultar en qualsevol moment <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/">totes les tarifes</a>. Si vols fer-ne comparacions, pots accedir a l'apartat <a href="https://www.somenergia.coop/ca/tarifes-d-electricitat/historic-de-tarifes/">històric de tarifes</a>, on hi ha també els preus vigents fins al 31 de març i els de períodes anteriors.
                </span></p>

                <p><strong>Informació legal</strong></p>

                <p><span style="font-weight: 400;">
                    Les <a href="https://www.somenergia.coop/ca/condicions-del-contracte-de-som-energia/#preu-i-actualitzacio">clàusules contractuals de les Condicions Generals</a> que ens autoritzen a fer aquest canvi de preus són la clàusula 5.3 (i) per als canvis regulats per normativa (per exemple, els impostos), i la clàusula 5.3 (ii) per a les modificacions de la part del preu no regulada.
                </span></p>
                <p><span style="font-weight: 400;">
                    Pots accedir al comparador d'ofertes que elabora la Comissió Nacional dels Mercats i la Competència (CNMC) a través d'<a href="https://comparador.cnmc.gob.es">aquest enllaç</a>. El comparador permet consultar i comparar les diferents ofertes vigents de les comercialitzadores del mercat lliure. Tingues en compte que possiblement, al moment de llegir aquest correu, les noves tarifes de Som Energia encara no hi seran reflectides.
                </span></p>

                <p><span style="font-weight: 400;">
                    T'adjuntem en aquest correu el teu contracte actualitzat amb els nous preus. Si hi estàs d'acord, <strong>no cal que ens retornis el document signat</strong>, ja que l'actualització dels preus de les nostres tarifes s'aplica automàticament. Igualment, hem d'informar-te que si, per alguna raó, aquest canvi de preus et fes replantejar seguir amb aquesta tarifa, podries canviar-te a la <a href="https://www.somenergia.coop/ca/tarifes-delectricitat-que-oferim/tarifa-indexada/">tarifa indexada</a> (<a href="https://ca.support.somenergia.coop/article/1344-modificacio-de-la-tarifa-de-periodes-a-indexada-i-dindexada-a-periodes">a través de la teva Oficina Virtual</a>), o podries donar de baixa el teu contracte amb nosaltres, bé comunicant-nos-ho directament, o bé mitjançant un canvi de comercialitzadora. Et recordem que a la cooperativa no apliquem penalitzacions ni clàusules de permanència en cap moment. Així doncs, si decidissis marxar, només et facturaríem el consum realitzat fins al dia en què deixem de subministrar-te energia, amb els preus vigents a cada moment.
                </span></p>

                <p><span style="font-weight: 400;">
                    Una salutació cordial,
                </span></p>
                <br/>
                <p><span style="font-weight: 400;">
                    Equip de Som Energia
                </span></p>
                <p><span style="font-weight: 400;">
                    <a href="https://www.somenergia.coop/ca">www.somenergia.coop ​</a>
                </span></p>
            %endif

            ${data['text_legal']}

        </div>
    </body>
</html>
