# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

include:
            {%- if josm.pkg.use_upstream_macapp %}
  - .macapp
  - .config
            {%- elif josm.pkg.use_upstream_jar %}
  - .jar
  - .config
            {%- else %}
  - .package
  - .config.script
            {%- endif %}
