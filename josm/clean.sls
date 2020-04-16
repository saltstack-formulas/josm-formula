# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

include:
                  {%- if josm.pkg.use_upstream_macapp %}
  - .macapp.clean
                  {%- elif josm.pkg.use_upstream_jar %}
  - .jar.clean
  - .config.clean
                  {%- else %}
  - .package.clean
                  {%- endif %}
