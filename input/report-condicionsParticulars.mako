## -*- encoding: utf-8 -*-
<%
import calendar
import time, babel
from datetime import datetime
from giscedata_facturacio.report.utils import get_atr_price
from som_extend_facturacio_comer.utils import get_gkwh_atr_price
from giscedata_polissa.giscedata_polissa import TIPO_AUTOCONSUMO
from giscedata_polissa.report.utils import localize_period, datetime_to_date

def clean_text(text):
    return text or ''
%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<head>
    <style>
        @font-face {
            font-family: "Roboto";
            src: url("${assets_path}/fonts/Roboto/Roboto-Regular.ttf") format('truetype');
            font-weight: normal;
        }
        @font-face {
            font-family: "Roboto";
            src: url("${assets_path}/fonts/Roboto/Roboto-Bold.ttf") format('truetype');
            font-weight: bold;
        }
        @font-face {
            font-family: "Roboto";
            src: url("${assets_path}/fonts/Roboto/Roboto-Thin.ttf") format('truetype');
            font-weight: 200;
        }
    </style>
    <style type="text/css">
        ${css}
    </style>
    <link rel="stylesheet" href="${addons_path}/som_polissa_condicions_generals/report/condicions_particulars.css"/>
</head>
<body>
    <%def name="clean(text)">
        ${text or ''}
    </%def>
    <%def name="enviament(diferent, text)">
        %if diferent:
            ${clean(text)}
        %endif
    </%def>
    %for polissa in objects:
        <%
            lang = polissa.titular.lang
            if lang not in ['ca_ES', 'es_ES']:
                lang = 'es_ES'
            setLang(lang)
        %>
        <div id="capcelera">
            <div id="logo_capcelera">
                <img id="logo" src="data:image/jpeg;base64,${company.logo}" style='height: 80px'/>
                <br/>
                <b>${_(u"Som Energia, SCCL")}<br/></b>
                ${_(u"CIF: F55091367")}<br/>
                ${_(u"Domicili: C/Pic de Peguera, 9 (1a planta) 17003, Girona")}<br/>
                ${_(u"Adreça electrònica: info@somenergia.coop")}
            </div>
            <div id="dades_capcelera">
                <div id="titol_dades">
                    <h3>${_(u"DADES DEL CONTRACTE")}</h3>
                </div>
                <div id="taula_dades_capcelera">
                    <table class="no_border">
                        <%
                            data_final = polissa.modcontractual_activa.data_final or ''
                            data_inici = polissa.data_alta or ''
                        %>
                        <tr>
                            <td><b>${_(u"Contracte núm.")}</b> ${polissa.name}</td>
                        </tr>
                        <tr>
                            <td><b>${_(u"Data d'inici del subministrament:")}</b>
                            %if polissa.state == 'esborrany':
                                &nbsp;
                            %else:
                                ${formatLang(data_inici, date=True)}
                            %endif
                            </td>
                        </tr>
                        <tr>
                            <td><b>${_(u"Data de renovació del subministrament:")}</b>
                            %if polissa.state == 'esborrany':
                                &nbsp;
                            %else:
                                ${formatLang(data_final, date=True)}
                            %endif
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="titol">
            <h2 style="font-size: 13px;">${_(u"CONDICIONS PARTICULARS DEL CONTRACTE DE SUBMINISTRAMENT D'ENERGIA ELÈCTRICA DE BAIXA TENSIÓ")}</h2>
        </div>

        %if polissa.state == 'esborrany':
            <div class="titol2" style="text-align: center; color: orange">
                <h2 style="font-size: 13px;">${_(" - LES DADES D'AQUEST CONTRACTE ESTAN PENDENTS DE VALIDACIÓ - ")}</h2>
            </div>
        %endif

        <%
            direccio_titular = polissa.titular.address[0]
            direccio_envio = polissa.direccio_notificacio
            diferent = (polissa.direccio_notificacio != direccio_titular)
            periodes_energia, periodes_potencia = [], []
        %>

        <h3>${_("PERSONA TITULAR")}</h3>
        <table class="taula_custom" style="margin-top: 5px;">
            <tr>
                <td class="label">${_(u"Nom/Raó social:")}</td>
                <td class="field">${polissa.titular.name}</td>
                <td class="label">${_(u"NIF/CIF:")}</td>
                <td class="field">${polissa.titular and (polissa.titular.vat or '').replace('ES', '')}</td>
            </tr>
        </table>
        <table class="taula_custom">
            <tr>
                <td class="label">${_(u"Adreça:")}</td>
                <td class="field">${clean(direccio_titular.street)}</td>
            </tr>
            <tr>
                <td class="label">${_(u"Codi postal i municipi:")}</td>
                <td class="field">${clean(direccio_titular.zip)} ${clean(direccio_titular.city)}</td>
                <td class="label">${_(u"Província i país:")}</td>
                <td class="field">${clean(direccio_titular.state_id.name)} ${clean(direccio_titular.country_id.name)}</td>
            </tr>
        </table>
        <table class="taula_custom">
            <tbody>
                <tr>
                    <td class="label">${_(u"Adreça electrònica:")}</td>
                    <td class="field">${clean(direccio_titular.email)}</td>
                    <td class="label">${_(u"Telèfon:")}</td>
                    <td class="field">${clean(direccio_titular.mobile)}</td>
                    <td class="label">${_(u"Telèfon 2:")}</td>
                    <td class="field">${clean(direccio_titular.phone)}</td>
                </tr>
            </tbody>
        </table>

        %if diferent:
        <h3> ${_("DADES DE CONTACTE")} </h3>
        <table style="margin-top: 5px;">
            <tr>
                <td class="label">${_(u"Nom/Raó social:")}</td>
                <td class="field">${enviament(diferent, direccio_envio.name)}</td>
            </tr>
        </table>
        <table style="margin-top: 5px;">
            <tr>
                <td class="label">${_(u"Adreça:")}</td>
                <td class="field">${enviament(diferent, direccio_envio.street)}</td>
            </tr>
            <tr>
                <td class="label">${_(u"Codi postal i municipi:")} </td>
                <td class="field">
                    ${enviament(diferent,
                        '{0} {1}'.format(
                            clean_text(direccio_envio.zip), clean_text(direccio_envio.city)
                        )
                    )}
                </td>
                <td class="label">${_(u"Província i país:")} </td>
                <td class="field">
                    ${enviament(diferent,
                        '{0} {1}'.format(
                            clean_text(direccio_envio.state_id.name), clean_text(direccio_envio.country_id.name)
                        )
                    )}
                </td>
            </tr>
        </table>
        <table class="taula_custom" style="margin-top: 5px;">
            <tr>
                <td class="label">${_(u"Adreça electrònica:")} </td>
                <td class="field">${enviament(diferent,
                        '{0}'.format(
                            clean_text(direccio_envio.email)
                        )
                    )}</td>
                <td class="label">${_(u"Telèfon:")}</td>
                <td class="field">${enviament(diferent,
                        '{0}'.format(
                            clean_text(direccio_envio.mobile)
                        )
                    )}</td>
                <td class="label">${_(u"Telèfon 2:")}</td>
                <td class="field">${enviament(diferent,
                        '{0}'.format(
                            clean_text(direccio_envio.phone)
                        )
                    )}</td>
            </tr>
        </table>
        %endif
        <div class="titol">
            <h2 class="center" style="font-size: 13px;">${_(u"CONDICIONS TÈCNIQUES I ECONÒMIQUES")}</h2>
        </div>

        <h3> ${_("DADES DEL PUNT DE SUBMINISTRAMENT")} </h3>

        <table style="margin-top: 5px;">
            <colgroup>
                <col style="width: 15%"/>
                <col style="width: 35%"/>
                <col style="width: 25%"/>
                <col style="width: 25%"/>
            </colgroup>
            <tr>
                <td class="label">${_(u"Adreça:")}</td>
                <td class="field" colspan=3>${polissa.cups.direccio}</td>
            </tr>
            <tr>
                <td class="label">${_(u"Província i país:")}</td>
                <td class="field">${polissa.cups.id_provincia.name} ${polissa.cups.id_provincia.country_id.name}</td>
            </tr>
        </table>
        <table style="margin-top: 5px;">
            <colgroup>
                <col style="width: 20%"/>
                <col style="width: 25%"/>
                <col style="width: 20%"/>
                <col style="width: 35%"/>
            </colgroup>
            <tr>
                <td class="label">${_(u"CUPS:")}</td>
                <td class="field">${polissa.cups.name}</td>
                <td class="label">${_(u"CNAE:")}</td>
                <td class="field">${polissa.cnae.name}</td>
            </tr>
            <tr>
                <td class="label">${_(u"Contracte d'accés:")}</td>
                <td class="field">${clean(polissa.ref_dist)}</td>
                <td class="label">${_(u"Activitat principal:")}</td>
                <td class="field">${polissa.cnae.descripcio}</td>
            </tr>
        </table>
        <table style="margin-top: 5px;">
            <tr>
                <td class="label">${_(u"Empresa distribuïdora:")}</td>
                <td class="field">${polissa.cups.distribuidora_id.name}</td>
                <td class="label">${_(u"Tensió Nominal (V):")}</td>
                <td class="field">${clean(polissa.tensio)}</td>
            </tr>
        </table>

        <h3> ${_("PEATGE D'ACCÉS (Definit al RD 1164/2001)")} </h3>

        <table style="margin-top: 5px;">
            <tr>
                <td class="label">${_(u"Tarifa contractada:")}</td>
                <td class="field">${clean(polissa.tarifa_codi)}</td>
            </tr>
        </table>
        <table class="taula_custom">
            <tr>
                <td class="label">${_(u"Potència contractada (kW):")} </div></td>
                <%
                    potencies = polissa.potencies_periode
                    periodes = []
                    for i in range(0, 6):
                        if i < len(potencies):
                            periode = potencies[i]
                        else:
                            periode = False
                        periodes.append((i+1, periode))
                %>
                %for p in periodes:
                    <td style="width: 60px;">
                    %if p[1] and p[1].potencia:
                        <span class="label">${"P{0}".format(p[0])}</span>
                        <span class="field">${p[1] and p[1].potencia or ' '}</span>
                    </td>
                    %endif
                %endfor
            </tr>
        </table>
        <table>
            <tr>
                <%
                    autoconsum = polissa.autoconsumo
                    if autoconsum:
                        autoconsum = dict(TIPO_AUTOCONSUMO)[autoconsum]
                %>

                <td class="label">${_(u"Modalitat de contractació d'autoconsum (si s'escau):")}</td>
                <td class="field">${autoconsum}</td>
            </tr>
        </table>

        <h3> ${_("TARIFES D'ELECTRICITAT")}
        %if not polissa.llista_preu:
            <span style="font-size: 10px; color: orange">${_(" (Tarifa vigent en el moment d'activació del contracte)")}
                <br/> ${_("Per a més informació:")}
            </span>
            <a href="${_(u"https://www.somenergia.coop/ca/tarifes-d-electricitat/")}">${_(u"https://www.somenergia.coop/ca/tarifes-d-electricitat/")}</a>
        %endif
        </h3>
        <%
            periodes_potencia = []
            potencies = polissa.potencies_periode
            if potencies:
                periodes = []
                for i in range(0, 6):
                    if i < len(potencies):
                        periode = potencies[i]
                    else:
                        periode = False
                    periodes.append((i+1, periode))
            ctx = {'date': False}
            if potencies:
                ctx['sense_agrupar'] = True
                periodes_energia = sorted(polissa.tarifa.get_periodes(context=ctx).keys())
                periodes_potencia = sorted(polissa.tarifa.get_periodes('tp', context=ctx).keys())
                if periodes:
                    if data_final:
                        data_llista_preus = min(datetime.strptime(data_final, '%Y-%m-%d'), datetime.today())
                        ctx['date'] = data_llista_preus
                    data_i = data_inici and datetime.strptime(polissa.modcontractual_activa.data_inici, '%Y-%m-%d')
                    if data_i and calendar.isleap(data_i.year):
                        dies = 366
                    else:
                        dies = 365
        %>
        <table class="taula_custom taula_potencies">
            <tr>
                <td class="border-less">&nbsp;</td>
                <td class="center bold">P1</td>
                <td class="center bold">P2</td>
                <td class="center bold">P3</td>
                <td class="center bold">P4</td>
                <td class="center bold">P5</td>
                <td class="center bold">P6</td>
            </tr>
            <tr>
                <td class="bold">${_("Terme potència (€/kW i dia)")}</td>
                %for p in periodes_potencia:
                    <td style="width: 60px;" class="center">
                    %if polissa.llista_preu:
                        <span class="center">${formatLang(get_atr_price(cursor, uid, polissa, p, 'tp', ctx, with_taxes=True)[0], digits=6)}</span>
                    %else:
                            &nbsp;
                    %endif
                    </td>
                %endfor
                %if len(periodes_potencia) < 6:
                    %for p in range(0, 6-len(periodes_potencia)):
                        <td style="width: 60px;" class="">
                            &nbsp;
                        </td>
                    %endfor
                %endif
            </tr>
            <tr>
                <td class="bold">${_("Terme energia (€/kWh)")}</td>
                %for p in periodes_energia:
                    %if polissa.llista_preu:
                        <td style="width: 60px;" class="center">
                            <span class="">${formatLang(get_atr_price(cursor, uid, polissa, p, 'te', ctx, with_taxes=True)[0], digits=3)}</span>
                        </td>
                    %else:
                        <td style="width: 60px;" class="">
                            &nbsp;
                        </td>
                    %endif
                %endfor
                %if len(periodes_energia) < 6:
                    %for p in range(0, 6-len(periodes_energia)):
                        <td style="width: 60px;" class="">
                            &nbsp;
                        </td>
                    %endfor
                %endif
            </tr>
            <tr>
                <td class="bold">${_("(1) GenerationkWh (€/kWh)")}</td>
                %for p in periodes_energia:
                    %if polissa.llista_preu:
                        <td style="width: 60px;" class="center">
                            <span class="">${formatLang(get_gkwh_atr_price(cursor, uid, polissa, p, ctx, with_taxes=True)[0], digits=3)}</span>
                        </td>
                    %else:
                        <td style="width: 60px;" class="">
                            &nbsp;
                        </td>
                    %endif
                %endfor
                %if len(periodes_energia) < 6:
                    %for p in range(0, 6-len(periodes_energia)):
                        <td style="width: 60px;" class="">
                            &nbsp;
                        </td>
                    %endfor
                %endif
            </tr>
            %if polissa.autoconsumo != '00':
                <tr>
                    <td class="bold">${_("(2) Autoproducció (€/kWh)")}</td>
                    %for p in periodes_energia:
                        %if polissa.llista_preu:
                            %if polissa.autoconsumo != '00':
                                <td style="width: 60px;" class="center">
                                    <span>${formatLang(get_atr_price(cursor, uid, polissa, p, 'ac', ctx)[0], digits=3)}</span>
                                </td>
                            %else:
                                <td style="width: 60px;">
                                    &nbsp;
                                </td>
                            %endif
                        %else:
                            <td style="width: 60px;">
                                &nbsp;
                            </td>
                        %endif
                    %endfor
                    %if len(periodes_energia) < 6:
                        %for p in range(0, 6-len(periodes_energia)):
                            <td style="width: 60px;">
                                &nbsp;
                            </td>
                        %endfor
                    %endif
                </tr>
            %endif
        </table>
        <span>
            <span class="bold">(1) </span> ${_("Terme d'energia en cas de participar-hi, segons condicions del contracte GenerationkWh.")}<br/>
            %if polissa.autoconsumo != '00':
                <span class="bold">(2) </span> ${_("Preu de la compensació d'excedents, si és aplicable.")}
            %endif
        </span>
        <%
            owner_b = ''
            if polissa.bank.owner_name:
                owner_b = polissa.bank.owner_name
            nif = ''
            bank_obj = pool.get('res.partner.bank')
            field = ['owner_id']
            exist_field = bank_obj.fields_get(
                cursor, uid, field)
            if exist_field:
                owner = polissa.bank.owner_id
                if owner:
                    nif = owner.vat or ''
                nif = nif.replace('ES', '')
        %>

        <h3> ${_("DADES DE PAGAMENT")} </h3>

        <table style="margin-top: 5px;">
            <tr>
                <td class="label">${_(u"Titular del compte:")}</td>
                <td class="field">${owner_b}</td>
                <td class="label">${_(u"NIF:")}</td>
                <td class="field">${nif}</td>
            </tr>
        </table>
        <table class="taula_custom" style="margin-top: 5px;">
            <% iban = polissa.bank and polissa.bank.iban[4:] or '' %>
            <tr>
                <td class="label">${_(u"Entitat financera:")}</td>
                <td class="field">${iban[0:4]}</td>
                <td class="label">${_(u"Sucursal:")}</td>
                <td class="field">${iban[4:8]}</td>
                <td class="label">${_(u"DC:")}</td>
                <td class="field">${iban[8:10]}</td>
                <td class="label">${_(u"Núm. de compte:")}</td>
                <td class="field">${iban[10:]}</td>
            </tr>
        </table>
        <div id="footer">
            <div class="agreement_footer">
                ${_("La contractant accepta expressament les condicions generals que s'acompanyen a continuació i que formen part integrant i inseparable d'aquest contracte, si bé les parts declaren que en cas de discrepància prevaldrà el que preveuen les condicions particulars. En cas de modificació de les condicions generals es procedirà conforme a la clàusula 12 relativa a la modificació de les mateixes")}.
                % if polissa.state != 'esborrany':
                    <br/>
                    ${_("Aquestes condicions particulars es poden haver modificat després de l'activació del subministrament d'acord amb l'establert a les condicions generals")}.
                % endif
            </div>
            <div class="city_date">
            <%
                if polissa.data_firma_contracte:
                    data_firma =  datetime.strptime(datetime_to_date(polissa.data_firma_contracte), '%Y-%m-%d')
                else:
                    data_firma =  datetime.today()
            %>
                ${company.partner_id.address[0]['city']},
                ${_(u"a {0}".format(localize_period(data_firma, 'es_ES' )))}
            </div>
            <div style="clear:both"></div>
                % if polissa.state == 'esborrany':
                    <div class="signatura">
                        <div style="position:absolute; top: 0px; min-width:100%; min-height:50px">${_(u"EL CLIENT")}</div>
                        <div style="position:absolute; bottom: 0px; min-width:100%;">${polissa.pagador.name}</div>
                    </div>
                    <div class="signatura">
                        <div style="position:absolute; top: 0px; min-width:100%;">${_(u"LA COMERCIALITZADORA")}</div>
                        <img src="${addons_path}/som_polissa_condicions_generals/report/assets/signatura_contracte.png"/>
                        <div style="position:absolute; bottom: 0px; min-width:100%;">${company.name}</div>
                    </div>
                % endif
                <div class="observacions">
                    ${polissa.print_observations or ""}
                </div>
            </div>
        </div>
        <hr/>

        %if polissa != objects[-1]:
            <p style="page-break-after:always;"></p>
        %endif

    %endfor
    <p style="page-break-after:always;"></p>
    %if lang == 'ca_ES':
        <%include file="/som_polissa_condicions_generals/report/condicions_generals.mako"/>
    %else:
        <%include file="/som_polissa_condicions_generals/report/condiciones_generales.mako"/>
    %endif
</body>
</html>
