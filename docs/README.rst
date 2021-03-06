.. _readme:

josm-formula
=============

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/josm-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/josm-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Formula to install JavaOpenStreetMap (JOSM) on GNU/Linux and MacOS.

Two bonus scripts are installed:

- /usr/local/bin/josm-osm.sh for openstreetmap perhaps
- /usr/local/bin/josm-ohm.sh for openhistoricalmap perhaps

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Available states
----------------

.. contents::
   :local:

``josm``
^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs JOSM package on GNU/Linux and MacOS.

``josm.config``
^^^^^^^^^^^^^^^

This state configure environment (if provided) and bonus scripts (josm-osm.sh, josm-ohm.sh) on GNU/Linux and MacOS.

``josm.jar``
^^^^^^^^^^^^^^^^^^^

This state will install JOSM jar file on GNU/Linux and MacOS.

``josm.package``
^^^^^^^^^^^^^^^^^^^

This state will install JOSM package on GNU/Linux (package or snap) and MacOS (brew).

``josm.macapp``
^^^^^^^^^^^^^^^^

This state will install JOSM App on MacOS.

``josm.macapp.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove JOSM App on MacOS.

``josm.package.clean``
^^^^^^^^^^^^^^^^^^^^^^

This state will remove JOSM package from GNU/Linux (package or snap) and MacOS (brew).

``josm.jar.clean``
^^^^^^^^^^^^^^^^^^

This state will remove JOSM jar file from GNU/Linux and MacOS.

``josm.config.clean``
^^^^^^^^^^^^^^^^^^^^^^

This state will remove JOSM configuration on GNU/Linux and MacOS.

``josm.clean``
^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``josm`` meta-state in reverse order.


Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``josm`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

