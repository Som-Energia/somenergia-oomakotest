<%
import datetime
md_obj = object.pool.get('ir.model.data')
fact_obj = object.pool.get('giscedata.facturacio.factura')

exclosos = [('giscedata_facturacio_comer_bono_social', 'correct_bono_social_pending_state'),
('account_invoice_pending', 'default_invoice_pending_state'),
('som_account_invoice_pending', 'pacte_fraccio_pending_state'),
('som_account_invoice_pending', 'default_pacte_fraccio_pending_state'),
('som_account_invoice_pending', 'probresa_energetica_certificada_pending_state'),
('som_account_invoice_pending', 'no_reclamable_pending_state'),
('som_account_invoice_pending', 'fracc_manual_bo_social_pending_state'),
('som_account_invoice_pending', 'fracc_manual_default_pending_state'),
('som_account_invoice_pending', 'electrodependencia_bo_social_pending_state'),
('som_account_invoice_pending', 'default_fraccionament_covid'),
('som_account_invoice_pending', 'bo_social_fraccionament_covid')]

ids_exclosos = []
for module, sem_id in exclosos:
    ids_exclosos.append(md_obj.get_object_reference(object._cr, object._uid, module, sem_id)[1])

polissa_id = object.polissa_id.id
polissa = object.polissa_id.name

factures_pendents = len(fact_obj.search(object._cr, object._uid, [
    ('polissa_id', '=', polissa_id),
    ('type', 'in', ['out_invoice', 'out_refund']),
    ('pending_state', '!=', False),
    ('pending_state', 'not in', ids_exclosos)]))

data_venciment = (datetime.date.today() + datetime.timedelta(days=20)).strftime("%d-%m-%Y")
%>

% if object.invoice_id.partner_id.lang == "ca_ES":
SOM ENERGIA. ${factures_pendents} factura/es pendent/s de pagament. Tall de subministrament previst per ${data_venciment}. Contracte: ${polissa}. Per contactar: 900103605
% else:
SOM ENERGIA. ${factures_pendents} factura/as pendiente/es de pago. Corte de suministro previsto para ${data_venciment}. Contrato: ${polissa} Para contactar: 900103605
% endif

