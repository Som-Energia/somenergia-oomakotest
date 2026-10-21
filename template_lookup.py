# -*- coding: utf-8 -*-
"""Poweremail-compatible addon includes, optionally from a named worktree."""
from __future__ import absolute_import

import os

from mako.lookup import TemplateLookup


def addon_template_lookup(addons_path):
    extra_paths = os.environ.get('OPENERP_TEMPLATE_ADDONS_PATH', '')
    directories = [path for path in extra_paths.split(os.pathsep) if path]
    directories.append(addons_path)
    return TemplateLookup(directories=directories, input_encoding='utf-8')
