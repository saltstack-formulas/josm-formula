# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- for comp in ('osm', 'ohm') %}

josm-config-{{ comp }}-file-managed-script_file:
  file.managed:
    - name: {{ josm.dir.jar }}/bin/josm-{{ comp }}.sh
    - source: {{ files_switch('josm-script.sh.jinja'],
                              lookup='josm-config-{{ comp }}-file-managed-script_file'
                 )
              }}
    - mode: 640
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        comp: {{ comp }}
        path: {{ josm.config.path|json }}

    {%- endfor %}
