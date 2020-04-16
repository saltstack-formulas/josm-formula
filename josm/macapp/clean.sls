# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

josm-macos-app-clean-files:
  file.absent:
    - names:
      - {{ josm.dir.tmp }}
      - /Applications/JOSM.app

    {%- else %}

josm-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The josm macpackage is only available on MacOS

    {%- endif %}
