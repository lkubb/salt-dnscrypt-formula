# vim: ft=yaml
---
dnscrypt:
  lookup:
    master: template-master
    # Just for testing purposes
    winner: lookup
    added_in_lookup: lookup_value
    pkg:
      name: dnscrypt-proxy
    config: '/etc/dnscrypt-proxy/dnscrypt-proxy.toml'
    bin:
      hash: eeb5e78e8930cd5ef8e332a4ee2730d02a19bb5097221a56d15ae4b582f4abd2
      pkg: https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.1.5/dnscrypt-proxy-linux_x86_64-2.1.5.tar.gz
    paths:
      bin: /opt/dnscrypt-proxy
    pip_pkg: python3-pip
    service:
      name: dnscrypt-proxy
      unit: /etc/systemd/system/{name}.service
    user: dnscrypt-proxy
  config: {}
  install_method: bin
  merge_existing_config: true

  tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    files_switch:
      - any/path/can/be/used/here
      - id
      - roles
      - osfinger
      - os
      - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://dnscrypt/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   dnscrypt-config-file-file-managed:
    #     - 'example_alt.tmpl'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    source_files:
      dnscrypt-config-file-file-managed:
        - 'example.tmpl.jinja'

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
