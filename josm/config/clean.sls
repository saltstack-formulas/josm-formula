# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if josm.pkg.use_upstream_macapp %}
       {%- set sls_package_clean = tplroot ~ '.macapp.clean' %}
{%- elif josm.pkg.use_upstream_jar %}
       {%- set sls_package_clean = tplroot ~ '.jar.clean' %}
{%- else %}
       {%- set sls_package_clean = tplroot ~ '.package.clean' %}
{%- endif %}

include:
  - {{ sls_package_clean }}

josm-config-file-managed-environ_file:
  file.absent:
    - names:
      - {{ josm.dir.jar }}/josm-ohm.sh
      - {{ josm.dir.jar }}/josm-osm.sh
      - {{ josm.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}
