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

#=============================
# build an ioc application

PROD_IOC_DEFAULT = morel
PROD_IOC_solaris = morel

# <name>.dbd will be created from <name>Include.dbd
ifeq ($(OS_CLASS), WIN32)
  DBD  += iocmorelWin32.dbd
else
  ifeq ($(EPICS_HOST_ARCH), cygwin-x86)
    DBD  += iocmorelCygwin.dbd
  else
    ifeq ($(OS_CLASS), vxWorks)
      DBD  += iocmorelVX.dbd
    else
      ifeq ($(OS_CLASS), Linux)
  	DBD  += iocmorelLinux.dbd
      else
  	ifeq ($(OS_CLASS), solaris)
  	  DBD  += iocmorel_solaris.dbd
  	else
  	  DBD  += iocmorel.dbd
  	endif
      endif
    endif
  endif
endif

# If your host supports libpcap and libnet and you want to build Canberra network
# support, set LINUX_NET_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
iocmorelLinux_DBD += morelCommonInclude.dbd
ifneq ($(OS_CLASS), Linux)
  iocmorelLinux_DBD += mcaCanberraSupport.dbd
else
  ifeq ($(LINUX_NET_INSTALLED), YES)
  iocmorelLinux_DBD += mcaCanberraSupport.dbd
  endif
endif
# If your host supports parallel port or USB interfaces to Saturn DXP, set
# LINUX_USB_INSTALLED to YES in <synApps>/configure/CONFIG_SITE.
ifneq ($(OS_CLASS), Linux)
  iocmorelLinux_DBD += dxpSupport.dbd
else
  ifeq ($(OS_CLASS), Linux)
    ifeq ($(LINUX_USB_INSTALLED), YES)
      iocmorelLinux_DBD += dxpSupport.dbd
    endif
    iocmorelLinux_DBD += modbus.dbd
    iocmorelLinux_DBD += modbusSupport.dbd
    morel_Linux_LIBS  += modbus
  endif
endif


# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
morel_SRCS_DEFAULT  += iocmorel_registerRecordDeviceDriver.cpp          morelMain.cpp
#morel_SRCS_vxWorks  += iocmorelVX_registerRecordDeviceDriver.cpp
morel_SRCS_Linux    += iocmorelLinux_registerRecordDeviceDriver.cpp     morelMain.cpp
#morel_SRCS_WIN32    += iocmorelWin32_registerRecordDeviceDriver.cpp     morelMain.cpp
#morel_SRCS_cygwin32 += iocmorelCygwin_registerRecordDeviceDriver.cpp    morelMain.cpp
#morel_SRCS_solaris  += iocmorel_solaris_registerRecordDeviceDriver.cppa morelMain.cpp
#morel_SRCS_vxWorks  += -nil-

#morel_Common_LIBS += morelSupport
morel_Common_LIBS += mca
morel_Common_LIBS += calc
morel_Common_LIBS += busy
morel_Common_LIBS += sscan
morel_Common_LIBS += autosave
morel_Common_LIBS += optics
#morel_Common_LIBS += vme
morel_Common_LIBS += std
morel_Common_LIBS += ip
#morel_Common_LIBS += brukerCCD
#morel_Common_LIBS += marCCD
#morel_Common_LIBS += roperCCD

morel_Common_LIBS += Acs Faulhaber Ims Mclennan Micos MicroMo NewFocus
morel_Common_LIBS += Newport PI Parker
morel_Common_LIBS += softMotor motorSimSupport motor

morel_Common_LIBS += asyn
#morel_Common_LIBS += stream streamSynApps
morel_Common_LIBS += seqDev seq pv
morel_Common_LIBS += $(EPICS_BASE_IOC_LIBS)

#morel_vxWorks_LIBS += allenBradley
#morel_vxWorks_LIBS += mcaSIS
#morel_vxWorks_LIBS += mcaCanberra
#morel_vxWorks_LIBS += ip330
#morel_vxWorks_LIBS += ipUnidig
#morel_vxWorks_LIBS += dac128V
#morel_vxWorks_LIBS += quadEM
#morel_vxWorks_LIBS += camac devCamac
#morel_vxWorks_LIBS += dxp handel
#morel_vxWorks_LIBS += love
#morel_vxWorks_LIBS += vxStats
#morel_vxWorks_LIBS += TyGSOctal Ipac
#morel_vxWorks_LIBS += oms DeltaTau

#The following adds support from base/src/vxWorks
#morel_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

ifeq ($(LINUX_USB_INSTALLED), YES)
morel_Linux_LIBS  += dxp handel
endif
ifeq ($(LINUX_NET_INSTALLED), YES)
morelLinux_LIBS += mcaCanberra
endif

#morel_cygwin_LIBS += dxp handel

#morel_WIN32_LIBS += dxp handel

#morel_solaris_LIBS += genSub
#morel_solaris_LIBS += mca
#morel_solaris_LIBS += calc
#morel_solaris_LIBS += busy
#morel_solaris_LIBS += sscan
#morel_solaris_LIBS += autosave
#morel_solaris_LIBS += optics
##morel_solaris_LIBS += vme
#morel_solaris_LIBS += std
#morel_solaris_LIBS += ip
#morel_solaris_LIBS += brukerCCD
#morel_solaris_LIBS += marCCD
#morel_solaris_LIBS += roperCCD
#morel_solaris_LIBS += motor softMotor motorSimSupport
#morel_solaris_LIBS += asyn
#morel_solaris_LIBS += seqDev seq pv
#morel_solaris_LIBS += $(EPICS_BASE_IOC_LIBS)


morel_LIBS_DEFAULT = $(morel_Common_LIBS)
morel_LIBS_vxWorks = $(morel_vxWorks_LIBS) $(morel_Common_LIBS)
morel_LIBS_Linux   = $(morel_Linux_LIBS)   $(morel_Common_LIBS)
morel_LIBS_solaris = $(morel_solaris_LIBS)
morel_LIBS_cygwin32 = $(morel_cygwin_LIBS) $(morel_Common_LIBS)
morel_LIBS_WIN32    = $(morel_WIN32_LIBS)  $(morel_Common_LIBS)

# If the host has libnet and libpcap for mca/Canberra support
# uncomment the following line.
#morel_SYS_LIBS_Linux += net pcap
# For USB support on Saturn
#morel_SYS_LIBS_Linux += usb
morel_SYS_LIBS_vxWorks += -nil-

# This is needed by areaDetector on Linux and WIN32
morel_LIBS_WIN32        += PvAPI
ifeq ($(LINUX_TIFF_INSTALLED), YES)
morel_LIBS_Linux        += PvAPI
endif

# This is needed by dxp on cygwin and WIN32
morel_SYS_LIBS_cygwin32 += DLPORTIO PlxApi setupapi
morel_LIBS_WIN32        += DLPORTIO PlxApi
morel_SYS_LIBS_WIN32    += setupapi
# This is needed by saveData and asyn VXI-11 on cygwin
morel_SYS_LIBS_cygwin32 += rpc


#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
