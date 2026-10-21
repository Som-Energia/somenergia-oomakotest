# -*- coding: utf-8 -*-
"""Synthetic, offline rendering cases: no ERP connection and no recipients."""
from __future__ import absolute_import, unicode_literals

import os

from template_lookup import addon_template_lookup


class Record(object):
    def __init__(self, **values):
        self.__dict__.update(values)


def fixture_data(options):
    data = dict(
        lang=options.get('lang', 'ca_ES'), nom_titular=' Ada,',
        codi_polissa='SYNTHETIC', tarifa_acces=options.get('tariff', '2.0TD'),
        mode_facturacio=options.get('mode', 'atr'),
        modcon=options.get('modcon', False),
        impostos_str=options.get('tax', 'IVA del 21%'),
        impost_electric_str=options.get('electric_tax', '5,11%'),
        origen=options.get('origin', 'pdf'),
        consum_total='1234', potencia='4.6',
        preu_vell='341', preu_nou='359',
        preu_vell_imp='434', preu_nou_imp='457',
        te_gkwh=options.get('generation', False),
        autoconsum=dict(compensacio=options.get('compensation', False)),
        campaign=dict(selection_date='2026-08-27', old_price_date='2026-09-30',
                      effective_date='2026-10-01'),
        dades_index=dict(f_antiga='11.200', f_nova='10.100'),
    )
    prices = [('preus_antics', 0.1), ('preus_nous', 0.09),
              ('preus_antics_imp', 0.1272), ('preus_nous_imp', 0.1145)]
    for name, base in prices:
        periods = 3 if data['tarifa_acces'] == '2.0TD' else 6
        data[name] = dict(
            te=dict(('P%d' % index, '%.3f' % (base + index / 1000.0))
                    for index in range(1, periods + 1)),
            tp=dict(('P%d' % index, '%.3f' % (base * 100 + index))
                    for index in range(1, (2 if periods == 3 else 6) + 1)),
        )
        data[name + '_generation'] = dict(data[name]['te'])
    # Actual backend key names place the tax suffix after generation.
    data['preus_antics_generation_imp'] = data['preus_antics_imp_generation']
    data['preus_nous_generation_imp'] = data['preus_nous_imp_generation']
    data.update(preu_auto_antic='0.040', preu_auto_nou='0.035',
                preu_auto_antic_imp='0.051', preu_auto_nou_imp='0.045')
    data['gkwh_estimation'] = dict(
        origen=options.get('generation_origin', 'consums_periods'),
        consum_total='500',
        preu_vell='50', preu_nou='45', preu_vell_imp='64', preu_nou_imp='57')
    ca = data['lang'] == 'ca_ES'
    data['banners'] = {
        'CANVI_PREUS_MOTIU': '<p>MOTIU</p>' if ca else '<p>MOTIVO</p>',
        'CANVI_PREUS_COMIAT': '<p>COMIAT</p>' if ca else '<p>DESPEDIDA</p>',
    }
    if data['autoconsum']['compensacio'] and data['mode_facturacio'] == 'atr':
        data['banners']['CANVI_PREUS_AUTOCONSUM'] = '<p>AUTOCONSUM</p>'
    return data


def fixture_object(data):
    class Backend(object):
        def get_campaign_data(self, cursor, uid, record_id, context=None):
            # Deliberately different from the policy ID.
            assert record_id == 701
            assert context['pem_template_id'] == 901
            assert context['lang'] == data['lang']
            return data

    class ModelData(object):
        def get_object_reference(self, cursor, uid, module, name):
            return 'poweremail.templates', 1 if 'header' in name else 2

    class Templates(object):
        def read(self, cursor, uid, record_id, fields, context=None):
            assert context['lang'] == data['lang']
            body = ('<div>HEADER</div>' if record_id == 1
                    else '<div>FOOTER</div>')
            return dict(def_body_text=body)

    class Pool(object):
        def get(self, model):
            models = {'report.backend.mailcanvipreus': Backend(),
                      'ir.model.data': ModelData(),
                      'poweremail.templates': Templates()}
            return models[model]

    return Record(id=701, _cr=None, _uid=1, pool=Pool(),
                  polissa_id=Record(id=801, titular=Record(lang=data['lang'])),
                  lot_enviament=Record(email_template=Record(id=901)))


def render_case(template, options, addons_path=None):
    from mako.template import Template
    import codecs
    data = fixture_data(options)
    lookup = addon_template_lookup(
        addons_path or os.environ.get('OPENERP_ADDONS_PATH', '.'))
    with codecs.open(template, encoding='utf-8') as stream:
        source = stream.read()
    return Template(source, lookup=lookup).render_unicode(
        object=fixture_object(data))
