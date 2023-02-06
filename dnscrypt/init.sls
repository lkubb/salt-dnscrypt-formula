# vim: ft=sls

{#-
    *Meta-state*.

    This installs the dnscrypt package,
    manages the dnscrypt configuration file
    and then starts the associated dnscrypt service.
#}

include:
  - .package
  - .config
  - .service
