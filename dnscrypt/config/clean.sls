# vim: ft=sls

{#-
    Removes the configuration of the dnscrypt service and has a
    dependency on `dnscrypt.service.clean`_.
#}

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}

include:
  - {{ sls_service_clean }}

dnscrypt-proxy configuration is absent:
  file.absent:
    - name: {{ dnscrypt.lookup.config }}
    - require:
      - sls: {{ sls_service_clean }}
