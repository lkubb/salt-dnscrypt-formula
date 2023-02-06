# vim: ft=sls

{#-
    Starts the dnscrypt service and enables it at boot time.
    Has a dependency on `dnscrypt.config`_.
#}

include:
  - .running
