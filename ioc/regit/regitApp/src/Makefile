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

#LIBRARY_IOC += regitSupport

# regitRecord.h will be created from regitRecord.dbd
#DBDINC += regitRecord
# install support-library .dbd into <top>/dbd
#DBD += regitSupport.dbd

# The following are compiled and added to the Support library
#regitSupport_SRCS += regitRecord.c

#regitSupport_LIBS += $(EPICS_BASE_IOC_LIBS)
#regit_Common_LIBS += regitSupport

#=============================
# Build the IOC application

PROD_IOC = regit


# Note that the order in which .dbd files are added to a list variable
# doesn't matter, but the order of libraries does.

# <name>.dbd will be created from <name>Include.dbd
ifeq ($(OS_CLASS), WIN32)
	DBD  += iocregitWin32.dbd
	iocregitWin32_DBD += regitCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support uncomment the following line
	#iocregitWin32_DBD += mcaCanberraSupport.dbd

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following two lines
	iocregitWin32_DBD += dxpSupport.dbd
	regit_LIBS_WIN32 += dxp handel
endif

ifeq ($(EPICS_HOST_ARCH), cygwin-x86)
	DBD  += iocregitCygwin.dbd
	iocregitCygwin_DBD += regitCommonInclude.dbd

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following two lines
	iocregitCygwin_DBD += dxpSupport.dbd
	regit_LIBS_cygwin32 += dxp handel
endif

ifeq (vxWorks,$(findstring vxWorks, $(T_A)))
	DBD  += iocregitVX.dbd
	#iocregitVX_DBD += iocregitVXInclude.dbd

	iocregitVX_DBD += regitCommonInclude.dbd

	iocregitVX_DBD += vmeVXSupport.dbd
	iocregitVX_DBD += stdVXSupport.dbd
	iocregitVX_DBD += ipVXSupport.dbd
	iocregitVX_DBD += mcaSISSupport.dbd
	iocregitVX_DBD += ipUnidigSupport.dbd
	iocregitVX_DBD += dac128VSupport.dbd
	iocregitVX_DBD += ip330Support.dbd

	iocregitVX_DBD += camacSupport.dbd
	iocregitVX_DBD += devCamacSupport.dbd
	iocregitVX_DBD += dxpSupport.dbd
ifdef ALLEN_BRADLEY
	iocregitVX_DBD += allenBradley.dbd
endif
	iocregitVX_DBD += quadEMSupport.dbd
	iocregitVX_DBD += mcaCanberraSupport.dbd
	iocregitVX_DBD += devLove.dbd
	# from ipac
	iocregitVX_DBD += tyGSOctal.dbd
	iocregitVX_DBD += drvIpac.dbd
	# from asyn
	iocregitVX_DBD += drvGsIP488.dbd
	iocregitVX_DBD += vxStats.dbd
	iocregitVX_DBD += softGlueSupport.dbd
	# from motor
	iocregitVX_DBD += devDeltaTau.dbd
	iocregitVX_DBD += devOms.dbd
endif

ifeq ($(OS_CLASS), Linux)
	DBD  += iocregitLinux.dbd
	iocregitLinux_DBD += regitCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support, set LINUX_NET_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_NET_INSTALLED), YES)
		iocregitLinux_DBD += mcaCanberraSupport.dbd
		regit_LIBS_Linux += mcaCanberra
	endif
	# If your host supports parallel port or USB interfaces to Saturn DXP, set
	# LINUX_USB_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_USB_INSTALLED), YES)
		iocregitLinux_DBD += dxpSupport.dbd
		regit_LIBS_Linux  += dxp handel
	endif
endif

ifeq ($(OS_CLASS), solaris)
	DBD  += iocregit_solaris.dbd
	iocregit_solaris_DBD += regitCommonInclude.dbd
endif



# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
regit_SRCS_vxWorks  += iocregitVX_registerRecordDeviceDriver.cpp
regit_SRCS_Linux    += iocregitLinux_registerRecordDeviceDriver.cpp     regitMain.cpp
regit_SRCS_WIN32    += iocregitWin32_registerRecordDeviceDriver.cpp     regitMain.cpp
regit_SRCS_cygwin32 += iocregitCygwin_registerRecordDeviceDriver.cpp    regitMain.cpp
regit_SRCS_solaris  += iocregit_solaris_registerRecordDeviceDriver.cppa regitMain.cpp

regit_Common_LIBS += mca
regit_Common_LIBS += calc
regit_Common_LIBS += busy
regit_Common_LIBS += sscan
regit_Common_LIBS += autosave
regit_Common_LIBS += optics
regit_Common_LIBS += std
regit_Common_LIBS += ip
regit_Common_LIBS += Acs acsTech80 Aerotech Attocube Faulhaber Ims KohzuMotor Mclennan
regit_Common_LIBS += Micos MicroMo NewFocus Newport Oriel PI PIJena Parker SmartMotor
regit_Common_LIBS += ThorLabs softMotor motorSimSupport motor
#regit_Common_LIBS += ADBase NDPlugin netCDF
regit_Common_LIBS += simDetector NDPlugin netCDF ADBase
regit_Common_LIBS += asyn
regit_Common_LIBS += stream streamSynApps
regit_Common_LIBS += seqDev seq pv
regit_Common_LIBS += $(EPICS_BASE_IOC_LIBS)

ifdef ALLEN_BRADLEY
regit_LIBS_vxWorks += allenBradley
endif
regit_LIBS_vxWorks += mcaSIS
regit_LIBS_vxWorks += mcaCanberra
regit_LIBS_vxWorks += ip330
regit_LIBS_vxWorks += ipUnidig
regit_LIBS_vxWorks += dac128V
regit_LIBS_vxWorks += quadEM
regit_LIBS_vxWorks += camac devCamac
regit_LIBS_vxWorks += dxp handel
regit_LIBS_vxWorks += love
regit_LIBS_vxWorks += vxStats
regit_LIBS_vxWorks += vme
regit_LIBS_vxWorks += TyGSOctal Ipac
regit_LIBS_vxWorks += oms DeltaTau
regit_LIBS_vxWorks += softGlue

#The following adds support from base/src/vxWorks
regit_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

regit_LIBS_vxWorks  += $(regit_Common_LIBS)
regit_LIBS_Linux    += $(regit_Common_LIBS)
regit_LIBS_solaris  += $(regit_Common_LIBS)
regit_LIBS_cygwin32 += $(regit_Common_LIBS)
regit_LIBS_WIN32    += $(regit_Common_LIBS)

# If the host has libnet and libpcap for mca/Canberra support
# uncomment the following line.
#regit_SYS_LIBS_Linux += net pcap

# For USB support on Saturn uncomment the following line
#regit_SYS_LIBS_Linux += usb

# This is needed (and provided) by areaDetector on Linux and WIN32
regit_LIBS_WIN32        += PvAPI ImageLib
regit_LIBS_Linux        += PvAPI ImageLib

# This is needed by dxp on cygwin and WIN32
regit_SYS_LIBS_cygwin32 += DLPORTIO PlxApi setupapi
regit_LIBS_WIN32        += DLPORTIO PlxApi
regit_SYS_LIBS_WIN32    += setupapi

# This is needed by saveData and asyn VXI-11 on cygwin
regit_SYS_LIBS_cygwin32 += rpc

# areaDetector needs these
regit_SYS_LIBS_solaris   += tiff
regit_LIBS_solaris   += jpeg sz z
regit_LIBS_solaris += NeXus hdf5_cpp hdf5

# areaDetector needs (and provides) these
regit_LIBS_WIN32    += libtiff jpeg libNeXus.dll
regit_LIBS_cygwin32 += libtiff jpeg libNeXus.dll


# To use versions of these libraries supplied with areaDetector use this line
regit_LIBS_Linux        += NeXus mfhdf df hdf5 mxml
# To use system versions of these libraries use this line
#regit_SYS_LIBS_Linux    += NeXus mfhdf df hdf5 mxml

# To use versions of these libraries supplied with areaDetector use this line
regit_LIBS_Linux        += tiff jpeg z
# To use system versions of these libraries use this line
#regit_SYS_LIBS_Linux    += tiff jpeg z

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
