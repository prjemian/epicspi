#!/bin/sh

# $Author: jemian $
# $Date: 2011-09-07 15:22:38 -0500 (Wed, 07 Sep 2011) $
# $Id: in-screen.sh 1716 2011-09-07 20:22:38Z jemian $
# $Rev: 1716 $
# $URL: http://svn.jemian.org/svn/regitte/IOC/prj/iocBoot/iocLinux/in-screen.sh $

/usr/bin/screen -d -m ./run

# start the IOC in a screen session
#  type:
#   screen -r   to start interacting with the IOC command line
#   ^a-d        to stop interacting with the IOC command line
#   ^c          to stop the IOC
