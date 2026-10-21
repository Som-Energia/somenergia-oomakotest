# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

import codecs
import os
import unittest

from lxml import html
import yaml

from price_change_fixtures import fixture_data, render_case


ROOT = os.path.dirname(os.path.abspath(__file__))


class TestPriceChangeRendering(unittest.TestCase):
    def test_registered_cases_preserve_numbers_and_legal_content(self):
        cases_file = os.path.join(ROOT, 'testcases.yaml')
        with codecs.open(cases_file, encoding='utf-8') as stream:
            case = yaml.safe_load(stream)['canviPreusReutilitzable']
        for name, options in case['cases'].items():
            data = fixture_data(options)
            template_path = os.path.join(ROOT, case['template'])
            rendered = render_case(template_path, options)
            tree = html.fromstring('<div>' + rendered + '</div>')
            text = tree.text_content()
            self.assertIn('HEADER', text, name)
            self.assertIn('FOOTER', text, name)
            self.assertIn('2026-09-30', text, name)
            self.assertIn('2026-10-01', text, name)
            self.assertNotIn('20251127', rendered, name)
            self.assertNotIn('30 de setembre', rendered, name)
            self.assertNotIn('30 de septiembre', rendered, name)
            estimate_keys = ('preu_vell', 'preu_nou',
                             'preu_vell_imp', 'preu_nou_imp')
            for key in estimate_keys:
                self.assertIn(data[key], text, name)
            prices = ('preus_antics', 'preus_nous',
                      'preus_antics_imp', 'preus_nous_imp')
            for prefix in prices:
                for term in ('te', 'tp'):
                    if term == 'te' and data['mode_facturacio'] != 'atr':
                        continue
                    for value in data[prefix][term].values():
                        self.assertIn(value, text, name)
            self.assertIn(data['impostos_str'], text, name)
            clause = '3.3' if data['mode_facturacio'] == 'atr' else '5.3 (ii)'
            self.assertIn(clause, text, name)
            self.assertIn(data['impost_electric_str'], text, name)
            self.assertIn('CNMC', text, name)
            self.assertIn('https://comparador.cnmc.gob.es/', rendered, name)
            if data['lang'] == 'ca_ES':
                self.assertIn('document de desistiment', text, name)
                self.assertIn('no apliquem penalitzacions', text, name)
                self.assertIn('MOTIU', text, name)
                self.assertIn('COMIAT', text, name)
            else:
                self.assertIn('documento de desistimiento', text, name)
                self.assertIn('no aplicamos penalizaciones', text, name)
                self.assertIn('MOTIVO', text, name)
                self.assertIn('DESPEDIDA', text, name)
            compensation = (data['autoconsum']['compensacio']
                            and data['mode_facturacio'] == 'atr')
            self.assertEqual('AUTOCONSUM' in text, compensation, name)
            if data['modcon']:
                self.assertLess(text.index('pendent'),
                                text.index('Hola'), name)
                self.assertNotIn('T’adjuntem', text, name)
            if data['te_gkwh']:
                self.assertIn('Generation kWh', text, name)
                if data['gkwh_estimation']['origen'] == 'no_data':
                    self.assertIn('No hay datos suficientes', text, name)
                else:
                    for key in estimate_keys:
                        self.assertIn(data['gkwh_estimation'][key], text, name)

    def test_html_escapes_policy_holder_name(self):
        from price_change_fixtures import fixture_object
        from mako.template import Template
        from template_lookup import addon_template_lookup
        data = fixture_data({})
        data['nom_titular'] = '<script>unsafe</script>'
        template = ('<%include file="/som_polissa_condicions_generals/'
                    'report/mailcanvipreus/campaign.mako"/>')
        lookup = addon_template_lookup(
            os.environ.get('OPENERP_ADDONS_PATH', '.'))
        rendered = Template(template, lookup=lookup).render_unicode(
            object=fixture_object(data))
        self.assertNotIn('<script>', rendered)
        self.assertIn('&lt;script&gt;', rendered)


if __name__ == '__main__':
    unittest.main()
