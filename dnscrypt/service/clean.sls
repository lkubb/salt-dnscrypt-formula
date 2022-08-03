# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}

dnscrypt-service-clean-service-dead:
  service.dead:
    - name: {{ dnscrypt.lookup.service.name }}
    - enable: False
