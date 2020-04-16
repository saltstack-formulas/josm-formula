# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

josm-package-jar-install-extract:
  pkg.installed:
    - names: {{ josm.pkg.deps|json }}
  file.directory:
    - unless: test -d {{ josm.pkg.jar.name }}
    - name: {{ josm.pkg.jar.name }}
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: josm-package-jar-install-extract
  cmd.run:
    - names:
      - curl -Lo {{ josm.pkg.jar.name }}/josm.jar {{ josm.pkg.jar.source }}
      - chmod 640 {{ josm.pkg.jar.name }}/josm.jar
    - retry: {{ josm.retry_option }}
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
  module.run:
    - name: file.check_hash
    - path: {{ josm.pkg.jar.name }}/josm.jar
    - file_hash: {{ josm.pkg.jar.source_hash }}
    - require:
      - cmd: josm-package-jar-install-extract
    - onlyif: {{ 'source_hash' in josm.pkg.jar and not josm.pkg.jar.skip_verify }}
