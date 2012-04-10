TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

# For Kate Feng's implementation of devScaler.c, which uses Till
# Straumann's basicIoOps.h to bridge any mismatch between endianness
# of Joerger scaler hardware and endianness of processor.
#USR_CFLAGS += -DHAS_IOOPS_H

#==================================================
# build a support library that some other application can use

#LIBRARY_IOC += rgtSupport

# rgtRecord.h will be created from rgtRecord.dbd
#DBDINC += rgtRecord
# install support-library .dbd into <top>/dbd
#DBD += rgtSupport.dbd

# The following are compiled and added to the Support library
#rgtSupport_SRCS += rgtRecord.c

#rgtSupport_LIBS += $(EPICS_BASE_IOC_LIBS)
#rgt_Common_LIBS += rgtSupport

#=============================
# build an ioc application

PROD_IOC = rgt

# Note that the order in which .dbd files are added to a list variable
# doesn't matter, but the order of libraries does.

# <name>.dbd will be created from <name>Include.dbd
ifeq ($(OS_CLASS), WIN32)
	DBD  += iocrgtWin32.dbd
	iocrgtWin32_DBD += rgtCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support uncomment the following line
	#iocrgtWin32_DBD += mcaCanberraSupport.dbd

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following two lines
	iocrgtWin32_DBD += dxpSupport.dbd
	rgt_LIBS_WIN32 += dxp handel
endif

ifeq ($(EPICS_HOST_ARCH), cygwin-x86)
	DBD  += iocrgtCygwin.dbd
	iocrgtCygwin_DBD += rgtCommonInclude.dbd

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following two lines
	iocrgtCygwin_DBD += dxpSupport.dbd
	rgt_LIBS_cygwin32 += dxp handel
endif

ifeq (vxWorks,$(findstring vxWorks, $(T_A)))
	DBD  += iocrgtVX.dbd
	#iocrgtVX_DBD += iocrgtVXInclude.dbd

	iocrgtVX_DBD += rgtCommonInclude.dbd

	iocrgtVX_DBD += vmeVXSupport.dbd
	iocrgtVX_DBD += stdVXSupport.dbd
	iocrgtVX_DBD += ipVXSupport.dbd
	iocrgtVX_DBD += mcaSISSupport.dbd
	iocrgtVX_DBD += ipUnidigSupport.dbd
	iocrgtVX_DBD += dac128VSupport.dbd
	iocrgtVX_DBD += ip330Support.dbd

	iocrgtVX_DBD += camacSupport.dbd
	iocrgtVX_DBD += devCamacSupport.dbd
	iocrgtVX_DBD += dxpSupport.dbd
ifdef ALLEN_BRADLEY
	iocrgtVX_DBD += allenBradley.dbd
endif
	iocrgtVX_DBD += quadEMSupport.dbd
	iocrgtVX_DBD += mcaCanberraSupport.dbd
	iocrgtVX_DBD += devLove.dbd
	# from ipac
	iocrgtVX_DBD += tyGSOctal.dbd
	iocrgtVX_DBD += drvIpac.dbd
	# from asyn
	iocrgtVX_DBD += drvGsIP488.dbd
	iocrgtVX_DBD += vxStats.dbd
	iocrgtVX_DBD += softGlueSupport.dbd
	# from motor
	iocrgtVX_DBD += devDeltaTau.dbd
	iocrgtVX_DBD += devOms.dbd
endif

ifeq ($(OS_CLASS), Linux)
	DBD  += iocrgtLinux.dbd
	iocrgtLinux_DBD += rgtCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support, set LINUX_NET_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_NET_INSTALLED), YES)
		iocrgtLinux_DBD += mcaCanberraSupport.dbd
		rgt_LIBS_Linux += mcaCanberra
	endif
	# If your host supports parallel port or USB interfaces to Saturn DXP, set
	# LINUX_USB_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_USB_INSTALLED), YES)
		iocrgtLinux_DBD += dxpSupport.dbd
		rgt_LIBS_Linux  += dxp handel
	endif
endif

ifeq ($(OS_CLASS), solaris)
	DBD  += iocrgt_solaris.dbd
	iocrgt_solaris_DBD += rgtCommonInclude.dbd
endif




# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
rgt_SRCS_vxWorks  += iocrgtVX_registerRecordDeviceDriver.cpp
rgt_SRCS_Linux    += iocrgtLinux_registerRecordDeviceDriver.cpp     rgtMain.cpp
rgt_SRCS_WIN32    += iocrgtWin32_registerRecordDeviceDriver.cpp     rgtMain.cpp
rgt_SRCS_cygwin32 += iocrgtCygwin_registerRecordDeviceDriver.cpp    rgtMain.cpp
rgt_SRCS_solaris  += iocrgt_solaris_registerRecordDeviceDriver.cppa rgtMain.cpp

rgt_Common_LIBS += mca
rgt_Common_LIBS += calc
rgt_Common_LIBS += busy
rgt_Common_LIBS += sscan
rgt_Common_LIBS += autosave
rgt_Common_LIBS += optics
rgt_Common_LIBS += std
rgt_Common_LIBS += ip
rgt_Common_LIBS += Acs acsTech80 Aerotech Attocube Faulhaber Ims KohzuMotor Mclennan
rgt_Common_LIBS += Micos MicroMo NewFocus Newport Oriel PI PIJena Parker SmartMotor
rgt_Common_LIBS += ThorLabs softMotor motorSimSupport motor
#rgt_Common_LIBS += ADBase NDPlugin netCDF
rgt_Common_LIBS += simDetector NDPlugin netCDF ADBase
rgt_Common_LIBS += asyn
rgt_Common_LIBS += stream streamSynApps
rgt_Common_LIBS += seqDev seq pv
rgt_Common_LIBS += $(EPICS_BASE_IOC_LIBS)

ifdef ALLEN_BRADLEY
rgt_LIBS_vxWorks += allenBradley
endif
rgt_LIBS_vxWorks += mcaSIS
rgt_LIBS_vxWorks += mcaCanberra
rgt_LIBS_vxWorks += ip330
rgt_LIBS_vxWorks += ipUnidig
rgt_LIBS_vxWorks += dac128V
rgt_LIBS_vxWorks += quadEM
rgt_LIBS_vxWorks += camac devCamac
rgt_LIBS_vxWorks += dxp handel
rgt_LIBS_vxWorks += love
rgt_LIBS_vxWorks += vxStats
rgt_LIBS_vxWorks += vme
rgt_LIBS_vxWorks += TyGSOctal Ipac
rgt_LIBS_vxWorks += oms DeltaTau
rgt_LIBS_vxWorks += softGlue

#The following adds support from base/src/vxWorks
rgt_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

rgt_LIBS_vxWorks  += $(rgt_Common_LIBS)
rgt_LIBS_Linux    += $(rgt_Common_LIBS)
rgt_LIBS_solaris  += $(rgt_Common_LIBS)
rgt_LIBS_cygwin32 += $(rgt_Common_LIBS)
rgt_LIBS_WIN32    += $(rgt_Common_LIBS)

# If the host has libnet and libpcap for mca/Canberra support
# uncomment the following line.
#rgt_SYS_LIBS_Linux += net pcap

# For USB support on Saturn uncomment the following line
rgt_SYS_LIBS_Linux += usb

# This is needed (and provided) by areaDetector on Linux and WIN32
rgt_LIBS_WIN32        += PvAPI ImageLib
rgt_LIBS_Linux        += PvAPI ImageLib

# This is needed by dxp on cygwin and WIN32
rgt_SYS_LIBS_cygwin32 += DLPORTIO PlxApi setupapi
rgt_LIBS_WIN32        += DLPORTIO PlxApi
rgt_SYS_LIBS_WIN32    += setupapi

# This is needed by saveData and asyn VXI-11 on cygwin
rgt_SYS_LIBS_cygwin32 += rpc

# areaDetector needs these
rgt_SYS_LIBS_solaris   += tiff
rgt_LIBS_solaris   += jpeg sz z
rgt_LIBS_solaris += NeXus hdf5_cpp hdf5

# areaDetector needs (and provides) these
rgt_LIBS_WIN32    += libtiff jpeg libNeXus.dll
rgt_LIBS_cygwin32 += libtiff jpeg libNeXus.dll


# To use versions of these libraries supplied with areaDetector use this line
rgt_LIBS_Linux        += NeXus mfhdf df hdf5 mxml
# To use system versions of these libraries use this line
#rgt_SYS_LIBS_Linux    += NeXus mfhdf df hdf5 mxml

# To use versions of these libraries supplied with areaDetector use this line
rgt_LIBS_Linux        += tiff jpeg z
# To use system versions of these libraries use this line
#rgt_SYS_LIBS_Linux    += tiff jpeg z

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
