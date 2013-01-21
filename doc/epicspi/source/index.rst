.. Epics_On_RPi documentation master file, created by
   sphinx-quickstart on Sat Jan 19 11:54:35 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

========================================
Installing EPICS on the Raspberry Pi
========================================

Here is how I installed the Experimental Physics and Industrial Control System
software (EPICS) [#]_ on the RaspberryPi.

.. [#] EPICS: http://www.aps.anl.gov/epics

Raspberry Pi Distribution
========================================

Started with 2012-12-16 wheezy-raspbian distribution on a 16 GB SD card.
(It is helpful, but not necessary, to expand the 
partition to use the full memory of the SD card 
using ``raspi-config`` before starting X11):

=============== ====  ==== ===== ==== =======================
Filesystem      Size  Used Avail Use% Mounted on
=============== ====  ==== ===== ==== =======================
rootfs           15G  2.4G   12G  18% /
/dev/root        15G  2.4G   12G  18% /
devtmpfs        220M     0  220M   0% /dev
tmpfs            44M  252K   44M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs            88M   68K   88M   1% /run/shm
/dev/mmcblk0p1   56M   17M   40M  30% /boot
=============== ====  ==== ===== ==== =======================

Preparing for EPICS
========================================

EPICS is flexible about where (which directory path) it is placed.
Still, it helps to use standard locations.  We'll build it from 
a directory in the `pi` account, 
but make a link to that directory called ``/usr/local/epics``.
You'll need to open a terminal window:

.. code-block:: guess
   :linenos:
  
   cd ~
   mkdir -p ~/Apps/epics
   sudo su
   cd /usr/local
   ln -s /home/pi/Apps/epics
   exit
   cd ~/Apps/epics

By making the *epics* directory in *pi* account,
we will be able to modify any of our EPICS resources
without needing to gain higher privileges.

EPICS Base
========================================

Downloading
----------------------------------------

The latest stable version of EPICS Base is 3.14.12.3 
(3.15 is released but is still not recommended for production use):

.. code-block:: guess
   :linenos:

   wget http://www.aps.anl.gov/epics/download/base/baseR3.14.12.3.tar.gz
   tar xzf baseR3.14.12.3.tar.gz
   ln -s ./base-3.14.12.3 ./base

Building
----------------------------------------

EPICS base can be built for many different operating systems
and computers.  Each build is directed by the ``EPICS_HOST_ARCH`` 
environment variable.  A command is provided to determine
the best choice amongst all the systems for which EPICS currently
has definitions.  Here is the way to set the environment variable
on any UNIX or Linux OS.:

.. code-block:: guess
   :linenos:
   
   export EPICS_HOST_ARCH=`/usr/local/epics/base/startup/EpicsHostArch`

We can check this value by printing it to the command-line:

.. code-block:: guess
   :linenos:
   :emphasize-lines: 2

   root@raspberrypi:/usr/local/epics# echo $EPICS_HOST_ARCH
   linux-arm

Good!  EPICS base will build for a Linux OS on an ARM architecture.
This matches my Raspberry Pi.

.. tip::  The export command above will be useful for future
   software development.  Add it to the ``~/.bash_aliases`` 
   file if it exists, otherwise add it to the ``~/.bashrc`` 
   file with a text editor (such as ``nano ~/.bashrc``).

Now, build EPICS base for the first time:

.. code-block:: guess
   :linenos:

   cd ~/Apps/epics/base
   make

This process took about 50 minutes.

.. build
   started at  Sat Jan 19 17:16:21 CST 2013
   finished at Sat Jan 19 18:06:20 CST 2013

Starting
----------------------------------------

It is possible to start an EPICS IOC at this point, although there
is not much added functionality configured.  We can prove to
ourselves that things will start.  Use this linux command:

.. code-block:: guess
   :linenos:

   ./bin/linux-arm/softIoc

and EPICS will start with a basic command line prompt:

.. code-block:: guess
   :linenos:

   epics>

At this prompt, type::

  iocInit

and lines like these (different time stamp) will be printed:

.. code-block:: guess
   :linenos:
   
   Starting iocInit
   ############################################################################
   ## EPICS R3.14.12.3 $Date: Mon 2012-12-17 14:11:47 -0600$
   ## EPICS Base built Jan 19 2013
   ############################################################################
   iocRun: All initialization complete
   epics> 



Congratulations!  EPICS Base has now been built on the Raspberry Pi.

Environment Declarations
--------------------------------------

To simplify using the tools from EPICS base,
consider making these declarations in your environment 
(``~/.bash_aliases``):

.. code-block:: guess
   :linenos:

   export EPICS_ROOT=/usr/local/epics
   export EPICS_BASE=$(EPICS_ROOT)/base
   export EPICS_HOST_ARCH=`$(EPICS_BASE)/startup/EpicsHostArch`
   export EPICS_BASE_BIN=$(EPICS_BASE)/bin/$(EPICS_HOST_ARCH)
   export EPICS_BASE_LIB=$(EPICS_BASE)/lib/$(EPICS_HOST_ARCH)
   export LD_LIBRARY_PATH=$(EPICS_BASE_LIB):
   export PATH=$(PATH):$(EPICS_BASE_BIN)


After EPICS base has been built, we see that it has taken 
~35 MB of storage:

.. code-block:: guess
   :linenos:
   
   pi@raspberrypi:~/Apps/epics$ du -sc base-3.14.12.3
   35636  base-3.14.12.3



synApps
========================================

*synApps* is a collection of software tools that help to create a 
control system for beamlines. 
It contains beamline-control and data-acquisition components 
for an EPICS based control system. 

.. [#] synApps: http://www.aps.anl.gov/bcda/synApps/

There are instructions for installing synApps posted online:
http://www.aps.anl.gov/bcda/synApps/synApps_5_6.html

Download
------------------------

The current release of synApps is v5.6.  
The compressed source archive file is available from the BCDA group at APS.
The file should be 149 MB:

.. code-block:: guess
   :linenos:

    wget http://www.aps.anl.gov/bcda/synApps/tar/synApps_5_6.tar.gz
    tar xzf synApps_5_6.tar.gz

..

   .. note::  This download *should* be 156159012 bytes (149 MB).
      If, for some reason, your download is much smaller,
      try these alternatives:
 
      * http://www.aps.anl.gov/bcda/synApps/tar/synApps_5.6.tar
      * http://shony.de/epics/synApps_5.6.tar.gz
 
      The synApps documentation also describes a way to check out
      the latest work from the version control repository trunk.

Uncompressed and unconfigured, the synApps_5_6 source folder is ~541 MB.

Configuring
------------------------

All work will be relative to this folder:

.. code-block:: guess
   :linenos:
   
   cd ~/Apps/epics/synApps_5_6/support

Follow the instructions in the README file.
These are the changes I made to run on the Raspberry Pi.

======================  =================================================
file                    changes
======================  =================================================
configure/CONFIG_SITE   no changes
configure/RELEASE       ``EPICS_ROOT=/usr/local/epics``
                        ``SUPPORT=$(EPICS_ROOT)/synApps_5_6/support``
                        ``EPICS_BASE=$(EPICS_ROOT)/base``
======================  =================================================

After modifying ``configure/RELEASE``, propagate changes to all 
module RELEASE files by running::

   cd ~/Apps/epics/synApps_5_6/support
   make release

Edit ``Makefile`` and remove support for these modules:

    * ALLEN_BRADLEY
    * DAC128V
    * IP330
    * IPUNIDIG
    * LOVE
    * IP
    * VAC
    * SOFTGLUE
    * QUADEM
    * DELAYGEN
    * CAMAC
    * VME
    * AREA_DETECTOR
    * DXP

Install necessary EPICS Extensions
------------------------------------------

synApps requires the *msi* EPICS extension.  First, setup the extensions subdirectory

.. code-block:: guess
   :linenos:

    cd ~/Apps/epics
    wget http://www.aps.anl.gov/epics/download/extensions/extensionsTop_20120904.tar.gz
    tar xzf extensionsTop_20120904.tar.gz

Now, download *msi*, build, and install it:

.. code-block:: guess
   :linenos:

    wget http://www.aps.anl.gov/epics/download/extensions/msi1-5.tar.gz
    cd extensions/src
    tar xzf ../../msi1-5.tar.gz
    cd msi1-5
    make

Make these additional declarations in your environment 
(``~/.bash_aliases``):

.. code-block:: guess
   :linenos:

   export EPICS_EXT=$(EPICS_ROOT)/extensions
   export EPICS_EXT_BIN=$(EPICS_EXT)/bin/$(EPICS_HOST_ARCH)
   export EPICS_EXT_LIB=$(EPICS_EXT)/lib/$(EPICS_HOST_ARCH)
   export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):$(EPICS_EXT_LIB)
   export PATH=$(PATH):$(EPICS_EXT_BIN)

Install other support
------------------------

The EPICS sequencer needs the *re2c* package (http://re2c.org/).
This is available through the standard package installation repositories:

.. code-block:: guess
   :linenos:
   
   sudo apt-get install re2c

Building
----------------------------------------

Now, build the components of synApps selected in the *Makefile*:

.. code-block:: guess
   :linenos:

   cd ~/Apps/epics/synApps_5_6/support
   make release
   make

(This process will take a while if there are no errors.)

Contents:

.. toctree::
   :maxdepth: 2



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

