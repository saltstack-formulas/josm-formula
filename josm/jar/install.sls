# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

include:
  - josm.config.script

josm-package-jar-install-extract:
  pkg.installed:
    - name: unzip
  file.directory:
    - unless: test -d {{ josm.pkg.jar.name }}
    - name: {{ josm.pkg.jar.name }}
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - jar: josm-package-jar-install-extract
  archive.extracted:
    {{- format_kwargs(josm.pkg.jar) }}
    - archive_format: {{ josm.pkg.format }}
    - retry: {{ josm.retry_option }}
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - require:
      - sls: josm.config.script
