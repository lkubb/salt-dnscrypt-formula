.. _readme:

dnscrypt-proxy Formula
======================

|img_sr| |img_pc|

.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release
.. |img_pc| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
   :alt: pre-commit
   :scale: 100%
   :target: https://github.com/pre-commit/pre-commit

Manage dnscrypt-proxy with Salt.

This formula is pretty basic and does not take care of resolv[.]conf, NetworkManager etc. I use it to install it as an upstream of dnsmasq in PiHole.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please refer to:

- `how to configure the formula with map.jinja <map.jinja.rst>`_
- the ``pillar.example`` file
- the `Special notes`_ section

Special notes
-------------
* Socket activation is provided by the Debian package by default, but is unsupported. This is why I implemented installing from Github releases as well.

Configuration
-------------
An example pillar is provided, please see `pillar.example`. Note that you do not need to specify everything by pillar. Often, it's much easier and less resource-heavy to use the ``parameters/<grain>/<value>.yaml`` files for non-sensitive settings. The underlying logic is explained in `map.jinja`.


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



Contributing to this repo
-------------------------

Commit messages
^^^^^^^^^^^^^^^

**Commit message formatting is significant!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``. ::

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

State documentation
~~~~~~~~~~~~~~~~~~~
There is a script that semi-autodocuments available states: ``bin/slsdoc``.

If a ``.sls`` file begins with a Jinja comment, it will dump that into the docs. It can be configured differently depending on the formula. See the script source code for details currently.

This means if you feel a state should be documented, make sure to write a comment explaining it.
