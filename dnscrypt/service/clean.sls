# vim: ft=sls

{#-
    Stops the dnscrypt service and disables it at boot time.
#}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}

dnscrypt-proxy is dead:
  service.dead:
    - name: {{ dnscrypt.lookup.service.name }}
    - enable: False
