#!../../bin/linux-x86/regit

## You may have to change regit to something else
## everywhere it appears in this file

< envPaths

# save_restore.cmd needs the full path to the startup directory, which
# envPaths currently does not provide
epicsEnvSet(STARTUP,$(TOP)/iocBoot/$(IOC))

# Increase size of buffer for error logging from default 1256
errlogInit(20000)

# Specify largest array CA will transport
# Note for N sscanRecord data points, need (N+1)*8 bytes, else MEDM
# plot doesn't display
epicsEnvSet EPICS_CA_MAX_ARRAY_BYTES 64008

cd ${TOP}

################################################################################
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in the software we just loaded (regit.munch)
## Register all support components
dbLoadDatabase "dbd/iocregitLinux.dbd"
iocregitLinux_registerRecordDeviceDriver pdbbase

# ******************************************************************************

cd ${STARTUP}

### save_restore setup
# We presume a suitable initHook routine was compiled into regit.munch.
# See also create_monitor_set(), after iocInit() .
< save_restore.cmd

# serial support
#< serial.cmd

# Motors
#dbLoadTemplate("basic_motor.substitutions")
#dbLoadTemplate("motor.substitutions")
dbLoadTemplate("softMotor.substitutions")
#dbLoadTemplate("pseudoMotor.substitutions")
< motorSim.cmd


### Allstop, alldone
# This database must agree with the motors and other positioners you've actually loaded.
# Several versions (e.g., all_com_32.db) are in stdApp/Db
dbLoadRecords("$(MOTOR)/db/motorUtil.db", "P=regit:")

### Scan-support software
# crate-resident scan.  This executes 1D, 2D, 3D, and 4D scans, and caches
# 1D data, but it doesn't store anything to disk.  (See 'saveData' below for that.)
dbLoadRecords("$(SSCAN)/sscanApp/Db/scan.db","P=regit:,MAXPTS1=8000,MAXPTS2=1000,MAXPTS3=10,MAXPTS4=10,MAXPTSH=8000")
dbLoadRecords("$(SSCAN)/sscanApp/Db/saveData.db","P=regit:")

# A set of scan parameters for each positioner.  This is a convenience
# for the user.  It can contain an entry for each scannable thing in the
# crate.
dbLoadTemplate("scanParms.substitutions")

### Stuff for user programming ###
dbLoadRecords("$(CALC)/calcApp/Db/userCalcs10.db","P=regit:")
dbLoadRecords("$(CALC)/calcApp/Db/userCalcOuts10.db","P=regit:")
dbLoadRecords("$(CALC)/calcApp/Db/userStringCalcs10.db","P=regit:")
var aCalcArraySize, 2000
dbLoadRecords("$(CALC)/calcApp/Db/userArrayCalcs10.db","P=regit:,N=2000")
dbLoadRecords("$(CALC)/calcApp/Db/userTransforms10.db","P=regit:")
# extra userCalcs (must also load userCalcs10.db for the enable switch)
dbLoadRecords("$(CALC)/calcApp/Db/userCalcN.db","P=regit:,N=I_Detector")
dbLoadRecords("$(CALC)/calcApp/Db/userAve10.db","P=regit:")
# string sequence (sseq) records
dbLoadRecords("$(STD)/stdApp/Db/userStringSeqs10.db","P=regit:")
# string sequence (sseq) record
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=regit:,S=Sseq1")
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=regit:,S=Sseq2")
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=regit:,S=Sseq3")
#!#   # 4-step measurement
#!#   dbLoadRecords("$(STD)/stdApp/Db/4step.db", "P=regit:")
# interpolation
dbLoadRecords("$(CALC)/calcApp/Db/interp.db", "P=regit:,N=2000")
# array test
dbLoadRecords("$(CALC)/calcApp/Db/arrayTest.db", "P=regit:,N=2000")

# Slow feedback
#dbLoadTemplate "pid_slow.substitutions"

# Miscellaneous PV's, such as burtResult
dbLoadRecords("$(STD)/stdApp/Db/misc.db","P=regit:")


###############################################################################
###############################################################################
###############################################################################
cd ${TOP}/iocBoot/${IOC}
iocInit
###############################################################################
###############################################################################
###############################################################################


############################
# write all the PVs to a file
#
dbl > dbl.txt

## Start any State Notation Language (SNL, sequence) programs

#seq &kohzuCtl, "P=regit:, M_THETA=m9, M_Y=m10, M_Z=m11, GEOM=1, logfile=kohzuCtl.log"
#seq &hrCtl, "P=regit:, N=1, M_PHI1=m9, M_PHI2=m10, logfile=hrCtl1.log"

# Keithley 2000 series DMM
# channels: 10, 20, or 22;  model: 2000 or 2700
#seq &Keithley2kDMM,("P=regit:, Dmm=D1, channels=22, model=2700")

# X-ray Instrumentation Associates Huber Slit Controller
# supported by a SNL program written by Pete Jemian and modified (TMM) for use with the
# sscan record
#seq  &xia_slit, "name=hsc1, P=regit:, HSC=hsc1:, S=regit:seriala[6]"



### Start up the autosave task and tell it what to do.
# The task is actually named "save_restore".
# Note that you can reload these sets after creating them: e.g., 
# reload_monitor_set("auto_settings.req",30,"P=regit:")
#save_restoreDebug=20
#
# save positions every five seconds
create_monitor_set("auto_positions.req",5,"P=regit:")
# save other things every thirty seconds
create_monitor_set("auto_settings.req",30,"P=regit:")

### Start the saveData task.
saveData_Init("saveData.req", "P=regit:")

dbcar(0,1)

# motorUtil (allstop & alldone)
motorUtilInit("regit:")

