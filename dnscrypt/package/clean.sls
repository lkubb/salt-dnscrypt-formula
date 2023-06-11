# vim: ft=sls

{#-
    Removes the dnscrypt package.
    Has a dependency on `dnscrypt.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as dnscrypt with context %}

include:
  - {{ sls_config_clean }}

dnscrypt-proxy is removed:
  pkg.removed:
    - name: {{ dnscrypt.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
