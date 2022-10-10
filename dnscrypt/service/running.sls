# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}

include:
  - {{ sls_config_file }}

dnscrypt-service-running-service-running:
  service.running:
    - name: {{ dnscrypt.lookup.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
      - dnscrypt-proxy is installed
      - dnscrypt-proxy service is installed
