.. Epics_On_RPi documentation master file, created by
   sphinx-quickstart on Sat Jan 19 11:54:35 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

========================================
Installing EPICS on the Raspberry Pi
========================================

Here is how I installed the Experimental Physics and Industrial Control System
software (EPICS) [#]_ on the Raspberry Pi [#]_.

.. sidebar:: What is EPICS?

   For those who haven't heard, the EPICS software is an open-source 
   control system used worldwide for the routine of many particle accelerators 
   such as FermiLab and SLAC, for the oepration of scientific telescopes such 
   as the Gemini and Keck telescopes, X-ray synchrotrons such as the 
   Advanced Photon Source and the Diamond Light Source, neutron diffraction
   instruments such as the Spallation Neutron Source, and lots of other neat 
   stuff.  The system is scalable and runs on lots of different hardware,
   now including the **Raspberry Pi!**

.. [#] EPICS: http://www.aps.anl.gov/epics
.. [#] RPi: http://www.raspberrypi.org/

Raspberry Pi Distribution
========================================

Started with 2012-12-16 wheezy-raspbian distribution [#]_ on a 16 GB SD card.
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

.. [#] wheezy-raspbian: http://downloads.raspberrypi.org/images/raspbian/2012-12-16-wheezy-raspbian/2012-12-16-wheezy-raspbian.zip

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

..   .. note::  This download *should* be 156159012 bytes (149 MB).
..     If, for some reason, your download is much smaller,
..      try these alternatives:
.. 
..      * http://www.aps.anl.gov/bcda/synApps/tar/synApps_5.6.tar
..      * http://shony.de/epics/synApps_5.6.tar.gz
.. 
..      The synApps documentation also describes a way to check out
..      the latest work from the version control repository trunk.

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
configure/RELEASE       ``SUPPORT=/usr/local/epics/synApps_5_6/support``
                        ``EPICS_BASE=/usr/local/epics/base``
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

xxx: remove certain configuration
------------------------------------------------

In ``xxx-5-6/configure/RELEASE``, place a comment on line 19
to remove build support for *areaDetector* in *xxx*::

    #AREA_DETECTOR=$(SUPPORT)/areaDetector-1-8beta1

Then, in ``xxx-5-6/xxxApps/src/Makefile``, comment out all
lines that refer to *areaDetector* components, such as
*ADsupport*, "NDPlugin*, *simDetector*, and *netCDF*,
as well as *dxp* support. 
Here are the lines I found::

	#iocxxxWin32_DBD += ADSupport.dbd  NDFileNetCDF.dbd
	#xxx_LIBS_WIN32 += ADBase NDPlugin netCDF
	#iocxxxCygwin_DBD += ADSupport.dbd  NDFileNetCDF.dbd
	#xxx_LIBS_cygwin32 += ADBase NDPlugin netCDF
	#iocxxxCygwin_DBD += ADSupport.dbd NDFileNetCDF.dbd
	#xxx_LIBS_cygwin32 += ADBase NDPlugin netCDF
        #iocxxxLinux_DBD += ADSupport.dbd  NDFileNetCDF.dbd
        #xxx_LIBS_Linux += ADBase NDPlugin netCDF
	#iocxxxCygwin_DBD += simDetectorSupport.dbd commonDriverSupport.dbd
	#xxx_LIBS_cygwin32 += simDetector
        #iocxxxLinux_DBD += simDetectorSupport.dbd commonDriverSupport.dbd
        #xxx_LIBS_Linux += simDetector



Install necessary EPICS Extensions
------------------------------------------

synApps requires the *msi* EPICS extension.  First, setup the extensions subdirectory

.. code-block:: guess
   :linenos:

    cd ~/Apps/epics
    wget http://www.aps.anl.gov/epics/download/extensions/extensionsTop_20120904.tar.gz
    tar xzf extensionsTop_20120904.tar.gz

Now, download *msi*, unpack, build, and install it:

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
   make rebuild

The ``make rebuild`` step took about 70 minutes.

.. build
   started at  Sun Jan 20 22:55:54 CST 2013
   finished at Mon Jan 21 00:07:22 CST 2013

Using PyEpics
==================

It is possible to run the PyEpics support from Matt Newville
(http://cars.uchicago.edu/software/python/pyepics3/)
on the Raspberry Pi!

Preparing Python
----------------

To simplify installation, we'll use *easy_install* (from *setuptools*).

.. note::  The additions to the Python installation will be done as root.
    Here's how to become root on the default wheezy-raspbian distribution.

    ::
    
        sudo su

First, install the setuptools package from the wheezy repository.
(Also, as long as we're here, the *ipython* shell is very helpful.)
Let's load them both::

    sudo apt-get install python-setuptools ipython

Next, we want to know which version of Python will be run::

    # which python
    /usr/bin/python
    ls -lAFg /usr/bin/python
    lrwxrwxrwx 1 root 9 Jun  5  2012 /usr/bin/python -> python2.7*

Python 2.7 will be run.

Install PyEpics
----------------

With the *setuptools* installed, it becomes simple to install PyEpics (still as root)::

    easy_install -U PyEpics

The installation will complain about missing EPICS support libraries (*libca* and *libCom*).
Now, we can address that (still as root)::

    cd /usr/local/lib/python2.7/dist-packages/epics
    cp /home/pi/Apps/epics/base-3.14.12.3/lib/linux-arm/libca.so.3.14 ./
    cp /home/pi/Apps/epics/base-3.14.12.3/lib/linux-arm/libCom.so.3.14 ./
    ln -s libca.so.3.14  libca.so
    ln -s libCom.so.3.14  libCom.so

Now, exit from *root* back to the *pi* account session::

    exit

Testing PyEpics
-----------------

First, you might be eager to see that PyEpics will load.  
Save this code in the file *verify.py* (in whatever folder 
you wish, we'll use */home/pi*):

.. code-block:: python
   :linenos:

    #!/usr/bin/env python
    
    import epics
    
    print epics.__version__
    print epics.__file__

Also, remember to make the file executable::

    chmod +x verify.py

Now, run this and hope for the best::

    pi@raspberrypi:~$ ./verify.py
    3.2.1
    /usr/local/lib/python2.7/dist-packages/epics/__init__.pyc

This shows that PyEpics was installed but it does not test that EPICS is working.

Testing PyEpics with an IOC
----------------------------------

.. note::  We'll need to use several tools at the same time.
   It is easiest to create several terminal windows.

To test that EPICS communications are working, we need to do some preparations.

softIoc
++++++++++

The simplest way to do this is to use the *softIoc* support from EPICS base
with a simple EPICS database.  Save this into a file called *simple.db*:

.. code-block:: guess
   :linenos:
   
   record(bo, "rpi:trigger")
   {
   	   field(DESC, "trigger PV")
   	   field(ZNAM, "off")
   	   field(ONAM, "on")
   }
   record(stringout, "rpi:message")
   {
   	   field(DESC, "message on the RPi")
   	   field(VAL,  "RPi default message")
   }

Now, run the EPICS soft IOC support with this database:

.. code-block:: guess
   :linenos:
   
   pi@raspberrypi:~$ softIoc -d simple.db
   Starting iocInit
   ############################################################################
   ## EPICS R3.14.12.3 $Date: Mon 2012-12-17 14:11:47 -0600$
   ## EPICS Base built Jan 19 2013
   ############################################################################
   iocRun: All initialization complete
   epics> dbl
   rpi:trigger
   rpi:message
   epics>

camonitor
++++++++++++++++

In a separate terminal window, watch the soft IOC for any changes
to EPICS PVs we created above::

    pi@raspberrypi:~$ camonitor rpi:trigger rpi:trigger.DESC rpi:message rpi:message.DESC
    rpi:trigger 		   <undefined> off UDF INVALID
    rpi:trigger.DESC		   <undefined> trigger PV UDF INVALID
    rpi:message 		   <undefined> RPi default message UDF INVALID
    rpi:message.DESC		   <undefined> message on the RPi UDF INVALID

Python code
++++++++++++++++

Now, let's communicate with the PVs of the softIoc.
Put this code in file *test.py*:

.. code-block:: python
   :linenos:

    #!/usr/bin/env python
    
    import epics
    
    print epics.caget('rpi:trigger.DESC')
    print epics.caget('rpi:trigger')
    print epics.caget('rpi:message.DESC')
    print epics.caget('rpi:message')

    epics.caput('rpi:message', 'setting trigger')
    epics.caput('rpi:trigger', 1)
    print epics.caget('rpi:trigger.DESC')
    print epics.caget('rpi:trigger')
    print epics.caget('rpi:message.DESC')
    print epics.caget('rpi:message')

    epics.caput('rpi:message', 'clearing trigger')
    epics.caput('rpi:trigger', 0)
    print epics.caget('rpi:trigger.DESC')
    print epics.caget('rpi:trigger')
    print epics.caget('rpi:message.DESC')
    print epics.caget('rpi:message')

Make the file executable and then run it::

    pi@raspberrypi:~$ chmod +x test.py
    pi@raspberrypi:~$ ./test.py
    trigger PV
    0
    message on the RPi
    RPi default message
    trigger PV
    1
    message on the RPi
    setting trigger
    trigger PV
    0
    message on the RPi
    clearing trigger
    pi@raspberrypi:~$


Note that new messages have also printed on the terminal running *camonitor*::

   rpi:message     2013-01-21 08:20:28.658746 setting trigger
   rpi:trigger     2013-01-21 08:20:28.664845 on
   rpi:message     2013-01-21 08:20:28.697210 clearing trigger
   rpi:trigger     2013-01-21 08:20:28.702967 off


..
	-----------------------
	
	Contents:
	
	.. toctree::
	   :maxdepth: 2

	Indices and tables
	==================
	
	* :ref:`genindex`
	* :ref:`modindex`
	* :ref:`search`

