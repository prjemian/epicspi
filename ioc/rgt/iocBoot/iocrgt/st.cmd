# Linux startup script

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

################################################################################
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in the software we just loaded (rgt.munch)
dbLoadDatabase("../../dbd/iocrgtLinux.dbd")
iocrgtLinux_registerRecordDeviceDriver(pdbbase)

### save_restore setup
# We presume a suitable initHook routine was compiled into rgt.munch.
# See also create_monitor_set(), after iocInit() .
< save_restore.cmd

# serial support
< serial.cmd

# Motors
#dbLoadTemplate("basic_motor.substitutions")
#dbLoadTemplate("motor.substitutions")
dbLoadTemplate("softMotor.substitutions")
#dbLoadTemplate("pseudoMotor.substitutions")
#!< motorSim.cmd

#< areaDetector.cmd

### Allstop, alldone
# This database must agree with the motors and other positioners you've actually loaded.
# Several versions (e.g., all_com_32.db) are in stdApp/Db
dbLoadRecords("$(MOTOR)/db/motorUtil.db", "P=rgt:")

< optics.cmd
< instrument.cmd

### Scan-support software
# crate-resident scan.  This executes 1D, 2D, 3D, and 4D scans, and caches
# 1D data, but it doesn't store anything to disk.  (See 'saveData' below for that.)
dbLoadRecords("$(SSCAN)/sscanApp/Db/scan.db","P=rgt:,MAXPTS1=8000,MAXPTS2=1000,MAXPTS3=10,MAXPTS4=10,MAXPTSH=8000")

# A set of scan parameters for each positioner.  This is a convenience
# for the user.  It can contain an entry for each scannable thing in the
# crate.
#dbLoadTemplate("scanParms.substitutions")

< userProgramming.cmd

# Miscellaneous PV's, such as burtResult
dbLoadRecords("$(STD)/stdApp/Db/misc.db","P=rgt:")
#dbLoadRecords("$(STD)/stdApp/Db/VXstats.db","P=rgt:")

dbLoadRecords("$(TOP)/db/userMbbos10.db","P=rgt:")

###############################################################################
iocInit

#< seq.cmd

### Start up the autosave task and tell it what to do.
# The task is actually named "save_restore".
# Note that you can reload these sets after creating them: e.g., 
# reload_monitor_set("auto_settings.req",30,"P=rgt:")
#save_restoreDebug=20
#
# save positions every five seconds
create_monitor_set("auto_positions.req",5,"P=rgt:")
# save other things every thirty seconds
create_monitor_set("auto_settings.req",30,"P=rgt:")

### Start the saveData task.
saveData_Init("saveData.req", "P=rgt:")

dbcar(0,1)

# motorUtil (allstop & alldone)
motorUtilInit("rgt:")

dbl > dbl.txt
