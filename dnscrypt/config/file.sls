# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}

include:
  - {{ sls_package_install }}

dnscrypt-config-file-file-managed:
  file.serialize:
    - name: {{ dnscrypt.lookup.config }}
    - mode: 644
    - user: root
    - group: {{ dnscrypt.lookup.rootgroup }}
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
    - serializer: toml
    - dataset: {{ dnscrypt.config | json }}
    - merge_if_exists: {{ dnscrypt.merge_existing_config | to_bool }}
