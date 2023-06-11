Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``dnscrypt``
^^^^^^^^^^^^
*Meta-state*.

This installs the dnscrypt package,
manages the dnscrypt configuration file
and then starts the associated dnscrypt service.


``dnscrypt.package``
^^^^^^^^^^^^^^^^^^^^
Installs the dnscrypt package only.


``dnscrypt.config``
^^^^^^^^^^^^^^^^^^^
Manages the dnscrypt service configuration.
Has a dependency on `dnscrypt.package`_.


``dnscrypt.service``
^^^^^^^^^^^^^^^^^^^^
Starts the dnscrypt service and enables it at boot time.
Has a dependency on `dnscrypt.config`_.


``dnscrypt.clean``
^^^^^^^^^^^^^^^^^^
*Meta-state*.

Undoes everything performed in the ``dnscrypt`` meta-state
in reverse order, i.e.
stops the service,
removes the configuration file and then
uninstalls the package.


``dnscrypt.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the dnscrypt package.
Has a dependency on `dnscrypt.config.clean`_.


``dnscrypt.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the configuration of the dnscrypt service and has a
dependency on `dnscrypt.service.clean`_.


``dnscrypt.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the dnscrypt service and disables it at boot time.


