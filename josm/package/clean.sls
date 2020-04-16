# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import josm with context %}

    {%- if grains.os_family in ('Debian', 'Suse') and josm.pkg.use_upstream_repo %}

include:
  - .repo.clean

josm-package-remove-pkg-removed:
  pkg.removed:
    - names:
      - {{ josm.pkg.name }}
      - josm-plugins
      {{ '- josm-fonts' if grains.os_family == 'Suse' else '' }}
    - reload_modules: true

    {%- elif grains.os_family == 'MacOS' %}

josm-package-remove-cmd-run-cask:
  cmd.run:
    - name: brew cask remove {{ josm.pkg.name }}
    - runas: {{ josm.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

josm-package-remove-cmd-run-snap:
  cmd.run:
    - name: snap remove {{ josm.pkg.name }}
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- endif %}
