# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

josm-package-repo-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ josm.pkg.repo.name }}
    - onlyif: {{ josm.pkg.repo and josm.pkg.use_upstream_repo }}
