<%!
    from datetime import datetime
    from mako.template import Template


    class E106Template:
        STEP06 = '06'
        UNKNOWN_VALUE = ' - '

        def __init__(self, object_):
            self._case = object_
            self._lang = self.contract.titular.lang

            self.SelfConsumption = self._case.pool.get('giscedata.autoconsum')
            self.E106 = self._case.pool.get('giscedata.switching.e1.06')

        @property
        def contract(self):
            if hasattr(self, '_contract'):
                return self._contract

            self._contract = self.case.polissa_ref_id or self.case.cups_polissa_id
            return self._contract

        @property
        def case(self):
            return self._case

        @property
        def lang(self):
            return self._lang

        @property
        def contract_number(self):
            return self.contract.name

        @property
        def cups(self):
            return self.case.cups_id.name

        @property
        def cups_address(self):
            return self.case.cups_id.direccio

        @property
        def owner_name(self):
            return self.contract.titular.name

        @property
        def owner_vat(self):
            return self.contract.titular_nif

        @property
        def member_name(self):
            return self.contract.soci.name

        @property
        def step_06(self):
            if hasattr(self, '_step_06'):
                return self._step_06

            for step in self.case.step_ids:
                if step.step_id.name == self.STEP06:
                    self._step_06 = step.pas_id
                    return self._step_06

        @property
        def selfconsumption_code(self):
            if hasattr(self, '_selfconsumption_code'):
                return self._selfconsumption_code

            self._selfconsumption_code = self.contract.autoconsumo
            return self._selfconsumption_code

        @property
        def selfconsumption_description(self):
            if hasattr(self, '_selfconsumption_description'):
                return self._selfconsumption_description

            if self.contract.autoconsumo and self.contract.autoconsumo != '00':
                selfconsumption_types = dict(
                    self.SelfConsumption.fields_get(
                        self.case._cr, self.case._uid, context={'lang': self.lang}
                    )['tipus_autoconsum']['selection']
                )
                description = selfconsumption_types.get(self.selfconsumption_code, '')
                self._selfconsumption_description = description.replace('[', '').replace(']', '')
                return self._selfconsumption_description

            self._selfconsumption_description = ''
            return self._selfconsumption_description

        @property
        def activation_date(self):
            try:
                date = datetime.strptime(self.step_06.data_activacio, '%Y-%m-%d')
                data_activacio = date.strftime('%d/%m/%Y')
            except:
                data_activacio = ''
            return data_activacio

        @property
        def atr_tariff(self):
            if hasattr(self, '_atr_tariff'):
                return self._atr_tariff

            tariff_map = dict(
                self.E106.fields_get(
                    self.case._cr, self.case._uid
                )['tarifaATR']['selection']
            )
            tariff = tariff_map.get(
                self.step_06.tarifaATR, self.UNKNOWN_VALUE
            ) or self.UNKNOWN_VALUE
            self._atr_tariff = tariff if tariff != 'None' else self.UNKNOWN_VALUE
            return self._atr_tariff

        @property
        def powers_description(self):
            if hasattr(self, '_powers_description'):
                return self._powers_description

            powers = '\n'.join((
                '&nbsp;&nbsp;&nbsp;&nbsp;- <strong> %s: </strong>%s W <br/>' % (p.name, p.potencia)
                for p in self.step_06.header_id.pot_ids
                if p.potencia != 0
            ))
            if self.atr_tariff == "2.0TD" and self.lang == 'ca_ES':
                self._powers_description = powers.replace("P1:", "Punta:").replace("P2:", "Vall:")
                return self._powers_description

            if self.atr_tariff == "2.0TD" and self.lang == 'es_ES':
                self._powers_description = powers.replace("P1:", "Punta:").replace("P2:", "Valle:")
                return self._powers_description

            self._powers_description = powers
            return self._powers_description





%>

<%
  def render(text_to_render, object_):
      templ = Template(text_to_render)
      return templ.render_unicode(
          object=object_,
          format_exceptions=True
  )
  e106_template = E106Template(object)

  p_obj = object.pool.get('res.partner')
  nom_titular = ' {}'.format(p_obj.separa_cognoms(
      object._cr, object._uid, e106_template.owner_name
  )['nom']) if not object.vat_enterprise() else ''
  t_obj = object.pool.get('poweremail.templates')
  md_obj = object.pool.get('ir.model.data')

  template_header_id = md_obj.get_object_reference(object._cr, object._uid, 'som_poweremail_common_templates', 'common_template_header_v2')[1]
  template_footer_id = md_obj.get_object_reference(object._cr, object._uid,  'som_poweremail_common_templates', 'common_template_footer_v2')[1]
  plantilla_header = render(t_obj.read(object._cr, object._uid, [template_header_id], ['def_body_text'])[0]['def_body_text'], object)
  plantilla_footer = render(t_obj.read(object._cr, object._uid, [template_footer_id], ['def_body_text'])[0]['def_body_text'], object)
%>


${plantilla_header}
% if e106_template.lang == "ca_ES":
  ${correu_cat()}
% else:
  ${correu_es()}
% endif
${plantilla_footer}


<%def name="correu_cat()">
  <table width="100%" frame="below">
      <tr>
          <td height=2px>
              <span style="font-size: small;"><strong> Contracte Som Energia nº ${e106_template.contract_number}</strong></span>
          </td>
      </tr>
      <tr>
          <td height=2px>
              <span style="font-size: xx-small;"> Adreça punt subministrament: ${e106_template.cups_address}</span>
          </td>
      </tr>
      <tr>
          <td height=2px>
              <span style="font-size: xx-small;"> Codi CUPS: ${e106_template.cups}</span>
          </td>
      </tr>
      <tr>
          <td height=2px width=100%>
              <span style="font-size: xx-small;"> Titular: ${e106_template.owner_name}</span>
          </td>
      </tr>
  </table>

  <br/>
  <br/>
  <p>
    Hola${nom_titular},<br/>
    <br>
    Ens plau comunicar-te que el procés de canvi de comercialitzadora ha finalitzat, <font color="green"><strong>el contracte està activat amb Som Energia</strong></font> des del ${e106_template.activation_date}.<br/>
  </p>
  <p>
    Per a qualsevol consulta o aclariment, aquestes són les teves dades:<br/>
    <ul>
      <li><strong>Número de contracte amb Som Energia: </strong>${e106_template.contract_number}</li>
      <li><strong>CUPS: </strong>${e106_template.cups}</li>
      <li><strong>Adreça del punt de subministrament: </strong>${e106_template.cups_address}</li>
      <li><strong>Titular: </strong>${e106_template.owner_name}</li>
      <li><strong>NIF/CIF/NIE Titular: </strong>${e106_template.owner_vat}</li>
      <li><strong>Soci/a vinculat/da: </strong>${e106_template.member_name}</li>
      <li><strong> Tarifa: </strong>${e106_template.atr_tariff}</li>
      <li><strong> Potència: </strong><br/>
      ${e106_template.powers_description}</li>
      %if e106_template.selfconsumption_description:
        <li><strong> Modalitat autoconsum: </strong> ${e106_template.selfconsumption_description}</li>
      %endif
    </ul>
  </p>
  <p>
    T’adjuntem les condicions particulars i generals. Recorda que el contracte <strong> s'activa amb les mateixes condicions contractuals (tarifa i potència) que tenies amb l'anterior comercialitzadora. </strong>  Si vols modificar-les pots fer-ho a través de la teva <a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a>.<br/>
    <br/>
    A l'<a href="https://oficinavirtual.somenergia.coop/ca/login/">Oficina Virtual</a> també pots consultar les dades del contracte i veure totes les teves factures.<br/>
    <br/>
    Si tens algun dubte, trobaràs les preguntes més freqüents al <a href="https://ca.support.somenergia.coop/">Centre de Suport</a>.<br/>
  </p>
  <br/>
  <br/>
  Atentament,<br>
  <br>
  Equip de Som Energia<br>
  <a href="mailto:comercialitzacio@somenergia.coop">comercialitzacio@somenergia.coop</a><br>
  <a href="www.somenergia.coop/ca">www.somenergia.coop</a><br>

</%def>

<%def name="correu_es()">
  <table width="100%" frame="below">
      <tr>
          <td height=2px>
              <span style="font-size: small;"><strong> Contrato Som Energia nº ${e106_template.contract_number}</strong></span>
          </td>
      </tr>
      <tr>
          <td height=2px>
              <span style="font-size: small;"> Dirección del punto de suministro: ${e106_template.cups_address}</span>
          </td>
      </tr>
      <tr>
          <td height=2px>
              <span style="font-size: small;"> Codigo CUPS: ${e106_template.cups}</span>
          </td>
      </tr>
      <tr>
          <td height=2px width=100%>
              <span style="font-size: small;"> Titular: ${e106_template.owner_name}</span>
          </td>
      </tr>
  </table>

  <br>
  <br>
  <p>
    Hola${nom_titular},<br/>
    <br>
    Nos complace informarte que el proceso de cambio de comercializadora ha finalizado, <font color="green"><strong>tu contrato con Som Energia está activado </strong></font> desde el ${e106_template.activation_date}.<br/>
  </p>
  <p>
    Los datos del nuevo contrato son:<br/>
    <ul>
      <li><strong>Número de contrato con Som Energia: </strong>${e106_template.contract_number}</li>
      <li><strong>CUPS: </strong>${e106_template.cups}</li>
      <li><strong>Dirección del punto de suministro: </strong>${e106_template.cups_address}</li>
      <li><strong>Titular del contrato: </strong>${e106_template.owner_name}</li>
      <li><strong>NIF/CIF/NIE Titular: </strong>${e106_template.owner_vat}</li>
      <li><strong>Socio/a vinculado/a: </strong>${e106_template.member_name}</li>
      <li><strong> Tarifa: </strong>${e106_template.atr_tariff}</li>
      <li><strong> Potencia: </strong> <br/>
      ${e106_template.powers_description}</li>
      % if e106_template.selfconsumption_description:
          <li><strong> Modalidad autoconsumo: </strong> ${e106_template.selfconsumption_description}</li>
      % endif
    </ul>
  </p>
  <p>
    Te adjuntamos las condiciones particulares y generales. Recuerda que el contrato <strong> se activa con las mismas condiciones contractuales (tarifa y potencia) que tenías con el anterior comercializadora. </strong> Si quieres modificarlas puedes hacerlo a través de tu <a href="https://oficinavirtual.somenergia.coop/es/login/">Oficina Virtual</a>. <br/>
    <br/>
    En la <a href="https://oficinavirtual.somenergia.coop/es/login/"> Oficina Virtual </a> también puedes consultar los datos del contrato y ver todas tus facturas. <br/>
    <br/>
    Si tienes alguna duda, encontrarás las preguntas más frecuentes en el <a href="https://es.support.somenergia.coop/"> Centro de Apoyo </a>.<br/>
  </p>
  <br/>
  <br/>
      Atentamente,<br>
      <br>
      Equipo de Som Energia<br>
      <a href="mailto:comercializacion@somenergia.coop">comercializacion@somenergia.coop</a><br>
      <a href="http://www.somenergia.coop/es">www.somenergia.coop</a>
</%def>
