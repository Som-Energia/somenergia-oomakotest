<%!
    from datetime import datetime

    def socifilter(text):
        return str(int(''.join([a for a in text if a.isdigit()])))

    def dateFormat(text):
        temp = datetime.strptime(text, '%Y-%m-%d')
        return temp.strftime('%d/%m/%Y')

%>

<img src="http://www.somenergia.coop/wp-content/uploads/2014/07/logo.png">

Benvingut/da a Som Energia! 

Ens complau que formis part de la cooperativa que construeix un model energètic renovable en mans de la ciutadania, des de la participació i la transparència. Esperem que junts puguem assolir els nostres objectius de transformar el model energètic apostant per les energies renovables i l'eficiència energètica.

<table width="30%" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td><fieldset><P ALIGN=center> Número de soci/a: <b>${object.partner_id.ref | socifilter}</b>
 Nom del soci/a: ${object.partner_id.name}
 Data d'ingrés: ${object.date | dateFormat} !
 Aportació al capital social: 100€</fieldset></td></tr></table>

Per fer front a les <a href="https://blog.somenergia.coop/som-energia/2021/12/noves-mesures-per-fer-front-a-les-tensions-actuals-del-mercat-energetic/">tensions actuals del mercat energètic</a>, hem obert una emissió d’aportacions voluntàries per augmentar en 15 milions d’euros el capital social de la cooperativa. <b>T’animem a fer la teva aportació</b> <a href="https://www.somenergia.coop/ca/produeix-energia-renovable/aporta-al-capital-social/">des d’aquest formulari</a> on també trobaràs resposta a les preguntes més freqüents.

Al mateix temps, t'encoratgem que ens ajudis a difondre el projecte de Som Energia, fent-te amic al <a href="https://es-es.facebook.com/somenergia">Facebook</a>, seguint-nos al <a href="https://twitter.com/SomEnergia">Twitter</a> o enviant un enllaç de la <a href="www.somenergia.coop/ca">nostra pàgina web</a> a qui creguis pugui estar interessat/da.<br> 

Si vols participar de la cooperativa d'una forma més activa pots consultar a l'apartat de <a href="http://www.somenergia.coop/ca/participa/">participació de la nostra web</a>; formar part d'un grup local, de la plataforma, consultar el nostre blog, tot ho trobaràs al mateix link. 


Informació d'interès:
<ul><li><a href="http://www.somenergia.coop/ca/contracta-la-llum/">Contractar la llum</a>: Amb el número de soci ja pots contractar la llum de tots els contractes que vulguis al teu nom i a 5 més que no estiguin al teu nom.</li>
<li><a href="http://bit.ly/gkwh-soci-CA">Generació kWh</a>:  Ara també pots generar la teva pròpia energia renovable de forma col·lectiva. A l'enllaç trobaràs un vídeo explicatiu.</li>
<li><a href="https://www.somenergia.coop/ca/produccion/">Projectes de Generació de la cooperativa</a>: Pots consultar els nostres (teus!) projectes d'energia renovable, l'estat en el que es troben i altres dades d'interès.</li>
<li><a href="http://ca.support.somenergia.coop/">Centre de Suport de Som Energia</a>: Pots consultar tots els dubtes que tinguis de la cooperativa, de contractació de la llum, del mercat elèctric a través del Centre d'Ajuda.</li></ul>

Moltes gràcies pel teu suport!

Atentament,

L'equip de Som Energia
<a href="www.somenergia.coop/ca">www.somenergia.coop</a>
info@somenergia.coop
<a href="http://ca.support.somenergia.coop/article/470-com-puc-contactar-amb-la-cooperativa-mail-telefon-etc">Contactar amb Som Energia</a>

</body>
</html>