# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

josm-package-repo-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(josm.pkg.repo) }}
    - onlyif: {{ josm.pkg.repo and josm.pkg.use_upstream_repo }}
