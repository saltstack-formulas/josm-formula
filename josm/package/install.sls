# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

    {%- if grains.os_family in ('Debian', 'Suse') and josm.pkg.use_upstream_repo %}

include:
  - .repo

josm-package-install-pkg-installed:
  pkg.installed:
    - names:
      - {{ josm.pkg.name }}
      {{ '- josm-fonts' if grains.os_family == 'Suse' else '' }}
    - reload_modules: true

    {%- elif grains.os_family == 'MacOS' %}

josm-package-install-cmd-run-cask:
  cmd.run:
    - names:
      - brew cask install {{ josm.pkg.name }}
      - brew cask upgrade {{ josm.pkg.name }}
    - runas: {{ josm.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

josm-package-install-cmd-run-snap:
  # do bare minimium here
  pkg.installed:
    - name: snapd
  service.running:
    - name: snapd
  cmd.run:
    - name: snap install {{ josm.pkg.name }}
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- endif %}
