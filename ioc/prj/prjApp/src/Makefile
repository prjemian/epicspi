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

#LIBRARY_IOC += prjSupport

# prjRecord.h will be created from prjRecord.dbd
#DBDINC += prjRecord
# install support-library .dbd into <top>/dbd
#DBD += prjSupport.dbd

# The following are compiled and added to the Support library
#prjSupport_SRCS += prjRecord.c

#prjSupport_LIBS += $(EPICS_BASE_IOC_LIBS)
#prj_Common_LIBS += prjSupport

#=============================
# build an ioc application

PROD_IOC = prj

# Note that the order in which .dbd files are added to a list variable
# doesn't matter, but the order of libraries does.

# <name>.dbd will be created from <name>Include.dbd
ifeq ($(OS_CLASS), WIN32)
	DBD  += iocprjWin32.dbd
	iocprjWin32_DBD += prjCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support uncomment the following line
	#iocprjWin32_DBD += mcaCanberraSupport.dbd

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following two lines
	iocprjWin32_DBD += dxpSupport.dbd
	prj_LIBS_WIN32 += dxp handel
endif

ifeq ($(EPICS_HOST_ARCH), cygwin-x86)
	DBD  += iocprjCygwin.dbd
	iocprjCygwin_DBD += prjCommonInclude.dbd

	# If you want to build parallel port or USB interfaces to Saturn and/or xMAP DXP
	# then uncomment the following two lines
	iocprjCygwin_DBD += dxpSupport.dbd
	prj_LIBS_cygwin32 += dxp handel
endif

ifeq (vxWorks,$(findstring vxWorks, $(T_A)))
	DBD  += iocprjVX.dbd
	#iocprjVX_DBD += iocprjVXInclude.dbd

	iocprjVX_DBD += prjCommonInclude.dbd

	iocprjVX_DBD += vmeVXSupport.dbd
	iocprjVX_DBD += stdVXSupport.dbd
	iocprjVX_DBD += ipVXSupport.dbd
	iocprjVX_DBD += mcaSISSupport.dbd
	iocprjVX_DBD += ipUnidigSupport.dbd
	iocprjVX_DBD += dac128VSupport.dbd
	iocprjVX_DBD += ip330Support.dbd

	iocprjVX_DBD += camacSupport.dbd
	iocprjVX_DBD += devCamacSupport.dbd
	iocprjVX_DBD += dxpSupport.dbd
ifdef ALLEN_BRADLEY
	iocprjVX_DBD += allenBradley.dbd
endif
	iocprjVX_DBD += quadEMSupport.dbd
	iocprjVX_DBD += mcaCanberraSupport.dbd
	iocprjVX_DBD += devLove.dbd
	# from ipac
	iocprjVX_DBD += tyGSOctal.dbd
	iocprjVX_DBD += drvIpac.dbd
	# from asyn
	iocprjVX_DBD += drvGsIP488.dbd
	iocprjVX_DBD += vxStats.dbd
	iocprjVX_DBD += softGlueSupport.dbd
	# from motor
	iocprjVX_DBD += devDeltaTau.dbd
	iocprjVX_DBD += devOms.dbd
endif

ifeq ($(OS_CLASS), Linux)
	DBD  += iocprjLinux.dbd
	iocprjLinux_DBD += prjCommonInclude.dbd

	# If your host supports libpcap and libnet and you want to build Canberra network
	# support, set LINUX_NET_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_NET_INSTALLED), YES)
		iocprjLinux_DBD += mcaCanberraSupport.dbd
		prj_LIBS_Linux += mcaCanberra
	endif
	# If your host supports parallel port or USB interfaces to Saturn DXP, set
	# LINUX_USB_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
	ifeq ($(LINUX_USB_INSTALLED), YES)
		iocprjLinux_DBD += dxpSupport.dbd
		prj_LIBS_Linux  += dxp handel
	endif
endif

ifeq ($(OS_CLASS), solaris)
	DBD  += iocprj_solaris.dbd
	iocprj_solaris_DBD += prjCommonInclude.dbd
endif




# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
prj_SRCS_vxWorks  += iocprjVX_registerRecordDeviceDriver.cpp
prj_SRCS_Linux    += iocprjLinux_registerRecordDeviceDriver.cpp     prjMain.cpp
prj_SRCS_WIN32    += iocprjWin32_registerRecordDeviceDriver.cpp     prjMain.cpp
prj_SRCS_cygwin32 += iocprjCygwin_registerRecordDeviceDriver.cpp    prjMain.cpp
prj_SRCS_solaris  += iocprj_solaris_registerRecordDeviceDriver.cppa prjMain.cpp

prj_Common_LIBS += mca
prj_Common_LIBS += calc
prj_Common_LIBS += busy
prj_Common_LIBS += sscan
prj_Common_LIBS += autosave
prj_Common_LIBS += optics
prj_Common_LIBS += std
prj_Common_LIBS += ip
prj_Common_LIBS += Acs acsTech80 Aerotech Attocube Faulhaber Ims KohzuMotor Mclennan
prj_Common_LIBS += Micos MicroMo NewFocus Newport Oriel PI PIJena Parker SmartMotor
prj_Common_LIBS += ThorLabs softMotor motorSimSupport motor
#prj_Common_LIBS += ADBase NDPlugin netCDF
prj_Common_LIBS += simDetector NDPlugin netCDF ADBase
prj_Common_LIBS += asyn
prj_Common_LIBS += stream streamSynApps
prj_Common_LIBS += seqDev seq pv
prj_Common_LIBS += $(EPICS_BASE_IOC_LIBS)

ifdef ALLEN_BRADLEY
prj_LIBS_vxWorks += allenBradley
endif
prj_LIBS_vxWorks += mcaSIS
prj_LIBS_vxWorks += mcaCanberra
prj_LIBS_vxWorks += ip330
prj_LIBS_vxWorks += ipUnidig
prj_LIBS_vxWorks += dac128V
prj_LIBS_vxWorks += quadEM
prj_LIBS_vxWorks += camac devCamac
prj_LIBS_vxWorks += dxp handel
prj_LIBS_vxWorks += love
prj_LIBS_vxWorks += vxStats
prj_LIBS_vxWorks += vme
prj_LIBS_vxWorks += TyGSOctal Ipac
prj_LIBS_vxWorks += oms DeltaTau
prj_LIBS_vxWorks += softGlue

#The following adds support from base/src/vxWorks
prj_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

prj_LIBS_vxWorks  += $(prj_Common_LIBS)
prj_LIBS_Linux    += $(prj_Common_LIBS)
prj_LIBS_solaris  += $(prj_Common_LIBS)
prj_LIBS_cygwin32 += $(prj_Common_LIBS)
prj_LIBS_WIN32    += $(prj_Common_LIBS)

# If the host has libnet and libpcap for mca/Canberra support
# uncomment the following line.
#prj_SYS_LIBS_Linux += net pcap

# For USB support on Saturn uncomment the following line
#prj_SYS_LIBS_Linux += usb


# This is needed by saveData and asyn VXI-11 on cygwin
prj_SYS_LIBS_cygwin32 += rpc


#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
