# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if josm.config %}
           {%- if josm.pkg.use_upstream_macapp %}
               {%- set sls_package_install = tplroot ~ '.macapp.install' %}
           {%- elif josm.pkg.use_upstream_jar %}
               {%- set sls_package_install = tplroot ~ '.jar.install' %}
           {%- else %}
               {%- set sls_package_install = tplroot ~ '.package.install' %}
           {%- endif %}

include:
  - {{ sls_package_install }}

josm-config-osm-file-managed-script_file:
  file.managed:
    - name: {{ josm.dir.jar }}/bin/josm-osm.sh
    - source: {{ files_switch(['josm-osm.sh.jinja'],
                              lookup='josm-config-osm-file-managed-script_file'
                 )
              }}
    - mode: 555
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        path: {{ josm.config.path }}
    - require:
      - sls: {{ sls_package_install }}

josm-config-ohm-file-managed-script_file:
  file.managed:
    - name: {{ josm.dir.jar }}/bin/josm-ohm.sh
    - source: {{ files_switch(['josm-ohm.sh.jinja'],
                              lookup='josm-config-ohm-file-managed-script_file'
                 )
              }}
    - mode: 555
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
      path: {{ josm.config.path }}
    - require:
      - sls: {{ sls_package_install }}

    {%- endif %}
