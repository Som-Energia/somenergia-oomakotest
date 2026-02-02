<%
    lang = False
    # Hack to render only the legal footer paragraf of the language of the template object
    if object.__hasattr__('step_ids') and len(object.step_ids) > 0 and object.step_ids[0].pas_id.dades_client.lang and object.__hasattr__('proces_id') and object.proces_id.name == 'M1':
        lang = object.step_ids[0].pas_id.dades_client.lang
    elif object.__hasattr__('cups_polissa_id') and object.cups_polissa_id and object.cups_polissa_id.__hasattr__('titular') and object.cups_polissa_id.titular and object.cups_polissa_id.titular.lang:
        lang = object.cups_polissa_id.titular.lang
    elif object.__hasattr__('titular') and object.titular and object.titular.lang:
        lang = object.titular.lang
    else:
        lang = 'other'
%>

% if lang != "es_ES":

<p>
    <b>Dret de desistiment.</b> Totes les persones consumidores de la cooperativa disposen de 14 dies naturals des de la data de contracte per desistir dels serveis. Si vols desistir, cal que ens ho notifiquis per correu electrònic a <a target="_blank" href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a>, per correu postal a SOM ENERGIA SCCL c/Riu Güell 68, 17005 Girona o per qualsevol de les vies de contacte que consten <a target="_blank" href="http://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAASM66xC-2Fj-2F24l5h9I2SMP7acT5e6eFlm3AqFGqLFIcjD2yci2ngg7EkAF-2Fi-2FrbCh-2Fa8Z9Z1ieju15QJIGy6Eifdb9LHs9rXZCc0GxpFJtlDk6uplhTPkbuHdmzqq9vCmA-3D-3DMzOW_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSwMh7yS9a1ZjpU2-2BgomEiFKjTftBd67Ur8Jbgl36fXs2uCXwKavTuYVMg2-2FfsW7Xp8tiBJi9n2FdoEMuyXczD9g4UEONryyS21BcZ40kky90VXFfMJ-2FUBhxF5lAPP7XTJBAUrTYePIH0hlB7wiS-2B0oBQHPHRTsM6IoOEEy8WsSIpDQq0ZWCQ-2FizQ6CxcxBHFl">al nostre portal d'internet</a>. Per fer-ho, pots utilitzar el text que trobaràs <a target="_blank" href="http://links.somenergia.coop/ls/click?upn=u001.iUI1qEwdC6v-2BIbeyhbXeAEK1WLA6ierpleg9uk-2BtKXMWU4biE2HPFG2gmWIPbO7XGwcJ6rN8lpoiVIsZ7fspDb5-2BmNPV7QoeyuuyK2N79Ok-3DG-nc_wmc-2BViHeaSAOdjPZKiSJ-2FVcOKOAbmR5ULBVWco9ury5XwylQ9ILpuG9d09vR-2F1wSwMh7yS9a1ZjpU2-2BgomEiFKjTftBd67Ur8Jbgl36fXs3MM3F1qgLCGY-2B0kPYS2jhQa9vTmtb9GmuKMDgbYRXDcEC7Cy3PyesvsJnf5vU9fhOlI4WbbhC5NC-2BTgDzUWnX1o5KJaUCylTG7pnB-2FrRf7suogrT9hnt-2Fqij8-2Bka-2BoOYudY6XzW0PUK20qDjtTpbbS">en aquesta plantilla</a>.
</p>
<p>
    <b>Conseqüències del desistiment.</b> Et tornarem tots els pagaments rebuts, si n’hi ha, dintre dels 14 dies naturals a partir de la data en què ens comuniquis la teva decisió. Efectuarem aquest reemborsament sense que suposi cap més despesa per a tu, i farem servir el mateix mitjà de pagament que hagis emprat per a la transacció inicial, si no és que ens indiques el contrari. En cas que ja es trobi actiu el subministrament d’electricitat, ens hauràs d’abonar el consum corresponent als dies en què t’hàgim prestat servei, així com la resta de costos associats a la contractació i, si s’escau, la reposició a la situació anterior.
</p>

% endif
% if lang != "ca_ES":

<p>
    <b>Derecho de desistimiento.</b> Todas las personas consumidoras de la cooperativa disponen de 14 días naturales desde la fecha del contrato para desistir de los servicios. Si quieres desistir, es necesario que nos lo notifiques por correo electrónico a <a target="_blank" href="mailto:comercialitzacio@somenergia.coop">comercializacion@somenergia.coop</a>, por correo postal a SOM ENERGIA SCCL c/Riu Güell 68, 17005 Girona o por cualquiera de las vías de contacto que constan en nuestra <a target="_blank" href="https://es.support.somenergia.coop/article/471-como-puedo-contactar-con-la-cooperativa-mail-telefono-etc?utm_source=linkidiomes&utm_medium=cda&utm_campaign=castellano">página en internet</a>.Para hacerlo, puedes utilizar el texto que figura <a target="_blank" href="https://www.somenergia.coop/contracte/Desistimiento_Plantilla_CAST.pdf">en esta plantilla</a>.
</p>
<p>
    <b>Consecuencias del desistimiento.</b> Te devolveremos todos los pagos recibidos, si los hay, dentro de 14 días naturales a partir de la fecha en la que nos comuniques tu decisión. Efectuaremos dicho reembolso, sin que esto suponga ningún gasto para ti, utilizando el mismo medio de pago que hayas empleado para la transacción inicial, a no ser que nos indiques lo contrario. En caso de que ya se encuentre activo el suministro de electricidad, deberás abonarnos el consumo correspondiente a los días en que te hayamos prestado servicio, así como el resto de costes asociados a la contratación y, en su caso, reposición de la situación anterior.
</p>

% endif
