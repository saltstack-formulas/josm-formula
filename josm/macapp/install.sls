# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

josm-macos-app-install-curl:
  file.directory:
    - name: {{ josm.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ josm.dir.tmp }}/josm-{{ josm.version }} {{ josm.pkg.macapp.source }}
    - unless: test -f {{ josm.dir.tmp }}/josm-{{ josm.version }}
    - require:
      - file: josm-macos-app-install-curl
      - pkg: josm-macos-app-install-curl
    - retry: {{ josm.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
josm-macos-app-install-checksum:
  module.run:
    - onlyif: {{ josm.pkg.macapp.source_hash }}
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

josm-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The josm macpackage is only available on MacOS

    {%- endif %}
