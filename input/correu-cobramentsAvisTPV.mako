<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <table width="100%" frame="below" bgcolor="#E8F1D4">
      <tr>
        <td height=2px>
          <FONT SIZE=2><strong>Contracte Som Energia nº ${object.polissa_id.name}:</strong></font>
        </td>
        <td VALIGN=TOP rowspan="4">
          <align="right">
            <align="right"><img width='130' height='65'
                src="https://www.somenergia.coop/wp-content/uploads/2014/11/logo-somenergia.png">
        </td>
      </tr>
      <tr>
        <td height=2px>
          <FONT SIZE=1>Adreça punt subministrament: ${object.cups_id.direccio}</font>
        </td>
      </tr>
      <tr>
        <td height=2px>
          <FONT SIZE=1>Codi CUPS: ${object.cups_id.name}</font>
        </td>
      </tr>
      <tr>
        <td height=2px>
          <FONT SIZE=1>Factura: ${object.number}</font>
        </td>
      </tr>
      <tr>
        <td height=2px>
          <FONT SIZE=1>Estat pendent: ${object.pending_state.name}</font>
        </td>
      </tr>
      <tr>
        <td height=2px width=100%>
          <FONT SIZE=1>Titular: ${object.polissa_id.titular.name}</font>
        </td>
      </tr>
    </table>
  </head>

  <br/>

  <body>
    Aquest missatge és un avís a l'equip de Cobraments pel pagament d'una factura des de la OV.
  </body>
</html>