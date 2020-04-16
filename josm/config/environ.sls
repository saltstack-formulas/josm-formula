# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if josm.environ %}

    {%- if josm.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- elif josm.pkg.use_upstream_jar %}
        {%- set sls_package_install = tplroot ~ '.jar.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.package.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

josm-config-file-managed-environ_file:
  file.managed:
    - name: {{ josm.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='josm-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        environ: {{ josm.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
