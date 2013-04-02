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

#LIBRARY_IOC += morelSupport

# morelRecord.h will be created from morelRecord.dbd
#DBDINC += morelRecord
# install support-library .dbd into <top>/dbd
#DBD += morelSupport.dbd

# The following are compiled and added to the Support library
#morelSupport_SRCS += morelRecord.c

#morelSupport_LIBS += $(EPICS_BASE_IOC_LIBS)
#morel_Common_LIBS += morelSupport

#=============================
# build an ioc application

PROD_IOC = morel

# Note that the order in which .dbd files are added to a list variable
# doesn't matter, but the order of libraries does.

# <name>.dbd will be created from <name>Include.dbd
ifeq (win32-x86,$(findstring win32-x86, $(T_A)))
	DBD  += iocmorelWin32.dbd
	iocmorelWin32_DBD += morelCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support uncomment the following line
	#iocmorelWin32_DBD += mcaCanberraSupport.dbd

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following lines
	iocmorelWin32_DBD += dxpSupport.dbd
	iocmorelWin32_DBD += ADSupport.dbd  NDFileNetCDF.dbd
	morel_LIBS_WIN32 += dxp handel
	morel_LIBS_WIN32 += ADBase NDPlugin netCDF
	morel_LIBS_WIN32 += DLPORTIO PlxApi
	morel_SYS_LIBS_WIN32 += setupapi

	ifdef DEVIOCSTATS
		iocmorelWin32_DBD += devIocStats.dbd iocAdmin.dbd
	endif
endif

ifeq (windows-x64,$(findstring windows-x64, $(T_A)))
	DBD  += iocmorelWin64.dbd
	iocmorelWin64_DBD += morelCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support uncomment the following line
	iocmorelWin32_DBD += mcaCanberraSupport.dbd

	ifdef DEVIOCSTATS
		iocmorelWin32_DBD += devIocStats.dbd iocAdmin.dbd
	endif
endif

ifeq ($(EPICS_HOST_ARCH), cygwin-x86)
	DBD  += iocmorelCygwin.dbd
	iocmorelCygwin_DBD += morelCommonInclude.dbd
	# for simDetector
	iocmorelCygwin_DBD += ADSupport.dbd  NDFileNetCDF.dbd
	morel_LIBS_cygwin32 += ADBase NDPlugin netCDF
	iocmorelCygwin_DBD += simDetectorSupport.dbd commonDriverSupport.dbd
	morel_LIBS_cygwin32 += simDetector

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following six lines
	#iocmorelCygwin_DBD += dxpSupport.dbd
	#iocmorelCygwin_DBD += ADSupport.dbd NDFileNetCDF.dbd
	#morel_LIBS_cygwin32 += dxp handel
	#morel_LIBS_cygwin32 += ADBase NDPlugin netCDF
	#morel_SYS_LIBS_cygwin32 += DLPORTIO PlxApi
	#morel_SYS_LIBS_cygwin32 += setupapi

	morel_SYS_LIBS_cygwin32 += $(CYGWIN_RPC_LIB)

	ifdef DEVIOCSTATS
		iocmorelCygwin_DBD += devIocStats.dbd iocAdmin.dbd
	endif

endif

ifeq (vxWorks,$(findstring vxWorks, $(T_A)))
	DBD  += iocmorelVX.dbd
	#iocmorelVX_DBD += iocmorelVXInclude.dbd

	iocmorelVX_DBD += morelCommonInclude.dbd

	iocmorelVX_DBD += vmeVXSupport.dbd
	iocmorelVX_DBD += stdVXSupport.dbd
	iocmorelVX_DBD += ipVXSupport.dbd
	iocmorelVX_DBD += SIS38XXSupport.dbd
	iocmorelVX_DBD += ipUnidigSupport.dbd
	iocmorelVX_DBD += dac128VSupport.dbd
	iocmorelVX_DBD += ip330Support.dbd

	iocmorelVX_DBD += camacSupport.dbd
	iocmorelVX_DBD += devCamacSupport.dbd
ifdef ALLEN_BRADLEY
	iocmorelVX_DBD += allenBradley.dbd
endif
	iocmorelVX_DBD += drvAPS_EM.dbd
	iocmorelVX_DBD += mcaCanberraSupport.dbd
	iocmorelVX_DBD += devLove.dbd
	# from ipac
	iocmorelVX_DBD += tyGSOctal.dbd
	iocmorelVX_DBD += drvIpac.dbd
	# from asyn
	iocmorelVX_DBD += drvGsIP488.dbd
	ifndef DEVIOCSTATS
		iocmorelVX_DBD += vxStats.dbd
	endif
	iocmorelVX_DBD += softGlueSupport.dbd
	# from motor
	iocmorelVX_DBD += devDeltaTau.dbd
	iocmorelVX_DBD += devOms.dbd

	ifdef DEVIOCSTATS
		iocmorelVX_DBD += devIocStats.dbd iocAdmin.dbd
		iocmorelVX_DBD += devVxStats.dbd
	endif
endif

ifneq (,$(findstring linux, $(T_A)))
	DBD  += iocmorelLinux.dbd
	iocmorelLinux_DBD += morelCommonInclude.dbd
	iocmorelLinux_DBD += ADSupport.dbd  NDFileNetCDF.dbd
	morel_LIBS_Linux += ADBase NDPlugin netCDF
	iocmorelLinux_DBD += simDetectorSupport.dbd commonDriverSupport.dbd
	morel_LIBS_Linux += simDetector

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support, set LINUX_NET_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_NET_INSTALLED), YES)
		iocmorelLinux_DBD += mcaCanberraSupport.dbd
		morel_LIBS_Linux += mcaCanberra
		morel_SYS_LIBS_Linux += net pcap
	endif
	# If your host supports parallel port or USB interfaces to Saturn DXP, set
	# LINUX_USB_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_USB_INSTALLED), YES)
		iocmorelLinux_DBD += dxpSupport.dbd
		morel_LIBS_Linux  += dxp handel
		morel_SYS_LIBS_Linux += usb
	endif

	ifdef DEVIOCSTATS
		iocmorelLinux_DBD += devIocStats.dbd iocAdmin.dbd
	endif
endif

ifeq ($(OS_CLASS), solaris)
	DBD  += iocmorel_solaris.dbd
	iocmorel_solaris_DBD += morelCommonInclude.dbd
	ifdef DEVIOCSTATS
		iocmorel_solaris_DBD += devIocStats.dbd iocAdmin.dbd
		morel_SYS_LIBS_solaris += kstat
	endif
endif

ifeq ($(OS_CLASS), Darwin)
	DBD  += iocmorelDarwin.dbd
	iocmorelDarwin_DBD += morelCommonInclude.dbd
	ifdef DEVIOCSTATS
		iocmorelDarwin_DBD += devIocStats.dbd iocAdmin.dbd
	endif
endif



# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
morel_SRCS_vxWorks  += iocmorelVX_registerRecordDeviceDriver.cpp
morel_SRCS_Linux    += iocmorelLinux_registerRecordDeviceDriver.cpp     morelMain.cpp
ifeq ($(T_A),win32-x86)
morel_SRCS_WIN32    += iocmorelWin32_registerRecordDeviceDriver.cpp     morelMain.cpp
endif
ifeq ($(T_A),windows-x64)
morel_SRCS_WIN32    += iocmorelWin64_registerRecordDeviceDriver.cpp     morelMain.cpp
endif
morel_SRCS_cygwin32 += iocmorelCygwin_registerRecordDeviceDriver.cpp    morelMain.cpp
morel_SRCS_solaris  += iocmorel_solaris_registerRecordDeviceDriver.cpp  morelMain.cpp
morel_SRCS_Darwin   += iocmorelDarwin_registerRecordDeviceDriver.cpp    morelMain.cpp

morel_Common_LIBS += mca
morel_Common_LIBS += calc
morel_Common_LIBS += busy
morel_Common_LIBS += sscan
morel_Common_LIBS += autosave
morel_Common_LIBS += optics
morel_Common_LIBS += std
morel_Common_LIBS += ip
#morel_Common_LIBS += quadEM
morel_Common_LIBS += Acs acsTech80 Aerotech Attocube Faulhaber Ims KohzuMotor Mclennan
morel_Common_LIBS += Micos MicroMo NewFocus Newport Oriel PI PIJena Parker SmartMotor
morel_Common_LIBS += ThorLabs softMotor motorSimSupport motor
morel_Common_LIBS += asyn
morel_Common_LIBS += stream streamSynApps
morel_Common_LIBS += seqDev seq pv
morel_Common_LIBS += $(EPICS_BASE_IOC_LIBS)
ifdef DEVIOCSTATS
	morel_Common_LIBS += devIocStats
endif

ifdef ALLEN_BRADLEY
morel_LIBS_vxWorks += allenBradley
endif
morel_LIBS_vxWorks += SIS38XX
morel_LIBS_vxWorks += mcaCanberra
morel_LIBS_vxWorks += ip330
morel_LIBS_vxWorks += ipUnidig
morel_LIBS_vxWorks += dac128V
morel_LIBS_vxWorks += camac devCamac
morel_LIBS_vxWorks += love
ifndef DEVIOCSTATS
	morel_LIBS_vxWorks += vxStats
endif
morel_LIBS_vxWorks += vme
morel_LIBS_vxWorks += TyGSOctal Ipac
morel_LIBS_vxWorks += oms DeltaTau
morel_LIBS_vxWorks += softGlue

#The following adds support from base/src/vxWorks
morel_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

morel_LIBS_vxWorks  += $(morel_Common_LIBS)
morel_LIBS_Linux    += $(morel_Common_LIBS)
morel_LIBS_solaris  += $(morel_Common_LIBS)
morel_LIBS_cygwin32 += $(morel_Common_LIBS)
morel_LIBS_WIN32    += $(morel_Common_LIBS)
morel_LIBS_Darwin   += $(morel_Common_LIBS)


# areaDetector provides a Makefile for things it needs and supplies
ifneq (solaris,$(findstring solaris, $(T_A)))
ifneq (vxWorks,$(findstring vxWorks, $(T_A)))
	-include $(AREA_DETECTOR)/ADApp/commonDriverMakefile
endif
endif
#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
