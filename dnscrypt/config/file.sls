# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}

include:
  - {{ sls_package_install }}

dnscrypt-proxy configuration is managed:
  file.serialize:
    - name: {{ dnscrypt.lookup.config }}
    - mode: '0644'
    - user: root
    - group: {{ dnscrypt.lookup.rootgroup }}
    - makedirs: true
    - require:
      - sls: {{ sls_package_install }}
    - serializer: toml
    - dataset: {{ dnscrypt.config | json }}
    - merge_if_exists: {{ dnscrypt.merge_existing_config | to_bool }}
