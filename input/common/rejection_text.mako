<%
￼￼    lang = False
￼￼    # Hack to render only the legal footer paragraf of the language of the template object
￼￼    if object.__hasattr__('cups_polissa_id') and object.cups_polissa_id and object.cups_polissa_id.__hasattr__('titular') and object.cups_polissa_id.titular and object.cups_polissa_id.titular.lang:
￼￼        lang = object.cups_polissa_id.titular.lang
￼￼    else:
￼￼        lang = 'other'
￼%>
￼
% if lang != "es_ES":

<p>
    <b>Dret de desistiment.</b> Totes les persones <b>consumidores de la cooperativa disposen de 14 dies naturals des de la data de contracte per desistir dels serveis. Si vols desistir, cal que ens ho notifiquis per correu electrònic a </b><a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a>, per correu postal a SOM ENERGIA SCCL c/Pic de Peguera 11, 17003 Girona o per qualsevol de les vies de contacte que consten <a href="https://ca.support.somenergia.coop/article/470-com-puc-contactar-amb-la-cooperativa-mail-telefon-etc">al nostre portal d'internet</a>. Per fer-ho, pots utilitzar el text que trobaràs <b><a href="https://www.somenergia.coop/contracte/Desistiment_Plantilla_CAT.pdf">en aquesta plantilla</a></b>.
</p>
<p>
    <b>Conseqüències del desistiment.</b> Et tornarem tots els pagaments rebuts, si n’hi ha, dintre dels 14 dies naturals a partir de la data en què ens comuniquis la teva decisió. Efectuarem aquest reemborsament sense que suposi cap més despesa per a tu, i farem servir el mateix mitjà de pagament que hagis emprat per a la transacció inicial, si no és que ens indiques el contrari. En cas que ja es trobi actiu el subministrament d’electricitat, ens hauràs d’abonar el consum corresponent als dies en què t’hàgim prestat servei, així com la resta de costos associats a la contractació i, si s’escau, la reposició a la situació anterior.
</p>

% endif
% if lang != "ca_ES":

<p>
    <b>Derecho de desistimiento.</b> Todas las personas consumidoras de la cooperativa disponen de 14 días naturales desde la fecha del contrato para desistir de los servicios. Si quieres desistir, es necesario que nos lo notifiques por correo electrónico a comercializacion@somenergia.coop, por correo postal a SOM ENERGIA SCCL c/Pic de Peguera 11, 17003 Girona o por cualquiera de las vías de contacto que constan en nuestra <a href="https://ca.support.somenergia.coop/article/470-com-puc-contactar-amb-la-cooperativa-mail-telefon-etc">página en internet</a>.Para hacerlo, puedes utilizar el texto que figura <a href="https://www.somenergia.coop/contracte/Desistimiento_Plantilla_CAST.pdf">en esta plantilla</a>.
</p>
<p>
    <b>Consecuencias del desistimiento.</b> Te devolveremos todos los pagos recibidos, si los hay, dentro de 14 días naturales a partir de la fecha en la que nos comuniques tu decisión. Efectuaremos dicho reembolso, sin que esto suponga ningún gasto para ti, utilizando el mismo medio de pago que hayas empleado para la transacción inicial, a no ser que nos indiques lo contrario. En caso de que ya se encuentre activo el suministro de electricidad, deberás abonarnos el consumo correspondiente a los días en que te hayamos prestado servicio, así como el resto de costes asociados a la contratación y, en su caso, reposición de la situación anterior.
</p>

% endif
