# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if "bin" == dnscrypt.install_method %}

dnscrypt-proxy user/group is present:
  user.present:
    - name: {{ dnscrypt.lookup.user }}
    - system: true
    - usergroup: true

dnscrypt-proxy bin dir is present:
  file.directory:
    - name: {{ dnscrypt.lookup.paths.bin }}
    - user: root
    - group: {{ dnscrypt.lookup.rootgroup }}
    - makedirs: true

dnscrypt-proxy is installed:
  archive.extracted:
    - name: {{ dnscrypt.lookup.paths.bin }}
    - source: {{ dnscrypt.lookup.bin.pkg }}
    - source_hash: {{ dnscrypt.lookup.bin.hash }}
    - user: root
    - group: {{ dnscrypt.lookup.rootgroup }}
    - options: --strip-components=1
    - enforce_toplevel: false
    - overwrite: true
    - clean: true
    - require:
      - dnscrypt-proxy bin dir is present

{%-   if dnscrypt.merge_existing_config %}

dnscrypt-proxy config dir is present:
  file.directory:
    - name: {{ salt["file.dirname"](dnscrypt.lookup.config) }}
    - makedirs: true
    - user: root
    - group: {{ dnscrypt.lookup.rootgroup }}
    - mode: '0755'

dnscrypt-proxy example config is copied:
  file.copy:
    - name: {{ dnscrypt.lookup.config }}
    - source: {{ dnscrypt.lookup.paths.bin | path_join("example-dnscrypt-proxy.toml") }}
    # https://github.com/saltstack/salt/issues/62426
    # file.copy makedirs uses file permissions on directories
    # - makedirs: true
    - user: root
    - group: {{ dnscrypt.lookup.rootgroup }}
    - mode: '0644'
    - require:
      - dnscrypt-proxy is installed
      - dnscrypt-proxy config dir is present
{%- endif %}

dnscrypt-proxy service is installed:
  file.managed:
    - name: {{ dnscrypt.lookup.service.unit.format(name=dnscrypt.lookup.service.name) }}
    - source: {{ files_switch(['dnscrypt-proxy.service', 'dnscrypt-proxy.service.j2'],
                              lookup='dnscrypt-proxy service is installed'
                 )
              }}
    - user: root
    - group: {{ dnscrypt.lookup.rootgroup }}
    - mode: '0644'
    - makedirs: true
    - template: jinja
    - context:
        dnscrypt: {{ dnscrypt | json }}
{%- else %}

dnscrypt-proxy is installed:
  pkg.installed:
    - name: {{ dnscrypt.lookup.pkg.name }}
{%- endif %}

Pip is installed for dnscrypt-proxy:
  pkg.installed:
    - name: {{ dnscrypt.lookup.pip_pkg }}

Toml python library is installed for dnscrypt-proxy:
  pip.installed:
    - name: toml
    - reload_modules: true
    - require:
      - Pip is installed for dnscrypt-proxy

Restart salt minion on installation of toml for dnscrypt-proxy:
  cmd.run:
    - name: 'salt-call service.restart salt-minion'
    - bg: true
    - onchanges:
      - pip: toml
