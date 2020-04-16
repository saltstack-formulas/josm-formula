# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

include:
  - josm.config.clean

josm-package-jar-clean-file-absent:
  file.absent:
    - names:
      - {{ josm.pkg.jar.name }}
      - {{ josm.dir.jar }}
    - require:
      - sls: josm.config.clean
