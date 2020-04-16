# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

josm-macos-app-install-curl:
  file.directory:
    - name: {{ josm.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - names: {{ josm.pkg.deps|json }}
  cmd.run:
    - name: curl -Lo {{ josm.dir.tmp }}/josm-{{ josm.version }} {{ josm.pkg.macapp.source }}
    - unless: test -f {{ josm.dir.tmp }}/josm-{{ josm.version }}
    - require:
      - file: josm-macos-app-install-curl
      - pkg: josm-macos-app-install-curl
    - retry: {{ josm.retry_option }}

        {%- if not josm.pkg.macapp.skip_verify %}

josm-macos-app-install-checksum:
  module.run:
    - onlyif: {{ josm.pkg.macapp.source_hash and not josm.pkg.macapp.skip_verify }}
    - name: file.check_hash
    - path: {{ josm.dir.tmp }}/josm-{{ josm.version }}
    - file_hash: {{ josm.pkg.macapp.source_hash }}
    - require:
      - cmd: josm-macos-app-install-curl
    - require_in:
      - macpackage: josm-macos-app-install-macpackage
  file.absent:
    - name: {{ josm.dir.tmp }}/josm-{{ josm.version }}
    - onfail:
      - module: josm-macos-app-install-checksum

        {%- endif %}
        {%- if josm.pkg.format in ('dmg', 'pkg') %}

josm-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ josm.dir.tmp }}/josm-{{ josm.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: josm-macos-app-install-curl

        {%- else %}

josm-macos-app-install-archive:
  archive.extracted:
    {{- format_kwargs(josm.pkg.macapp) }}
    - retry: {{ josm.retry_option }}
    - user: {{ josm.identity.rootuser }}
    - group: {{ josm.identity.rootgroup }}
    - force: True
    - onchanges:
      - cmd: josm-macos-app-install-curl
  file.absent:
    - names:
      - {{ josm.pkg.macapp.name }}/CONTRIBUTION
      - {{ josm.pkg.macapp.name }}/LICENSE
      - {{ josm.pkg.macapp.name }}/README
    - onchanges:
      - archive: josm-macos-app-install-archive

        {%- endif %}
    {%- else %}

josm-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The josm macpackage is only available on MacOS

    {%- endif %}
