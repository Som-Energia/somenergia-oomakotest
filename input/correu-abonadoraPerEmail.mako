

<!doctype html>
<html>
<head></head>
<body>
Benvolgut/da ${object.polissa_id.direccio_pagament.name},

Li abonem una factura anterior <B>${object.ref.number}</B> que compren el període de <B>${object.data_inici.replace('-', '/')}</B> al <B>${object.data_final.replace('-', '/')}</B> és de <B> ${object.invoice_id.amount_total}€</B>.

Si us plau, trobi adjunta la factura en format PDF.

Atentament,

${object.invoice_id.company_id.name}
</body>
</html>
