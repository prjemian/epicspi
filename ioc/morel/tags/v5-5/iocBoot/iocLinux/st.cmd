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
# etc. in the software we just loaded (morel.munch)
dbLoadDatabase("../../dbd/iocmorelLinux.dbd")
iocmorelLinux_registerRecordDeviceDriver(pdbbase)

### save_restore setup
# We presume a suitable initHook routine was compiled into morel.munch.
# See also create_monitor_set(), after iocInit() .
< save_restore.cmd

# serial support
###< serial.cmd

# Motors
#dbLoadTemplate("basic_motor.substitutions")
dbLoadTemplate("motor.substitutions")
#dbLoadTemplate("softMotor.substitutions")
#dbLoadTemplate("pseudoMotor.substitutions")

dbLoadRecords("$(MOTOR)/db/motorUtil.db", "P=morel:")


### Scan-support software
< scanSupport.cmd

### Stuff for user programming ###
< userProgramming.cmd


     # talk with a (Koyo) Automation Direct DL06 PLC, address 67
< koyo_67.cmd


###############################################################################
###############################################################################
###############################################################################
iocInit
###############################################################################
###############################################################################
###############################################################################

     # report all known PVs into a file
dbl > dbl-all.txt
casr

### Start up the autosave task and tell it what to do.
     # The task is actually named "save_restore".
     # Note that you can reload these sets after creating them: e.g.,
     # reload_monitor_set("auto_settings.req",30,"P=morel:")
     #save_restoreDebug=20
     #
     # save positions every five seconds
create_monitor_set("auto_positions.req",5,"P=morel:")
     # save other things every thirty seconds
create_monitor_set("auto_settings.req",30,"P=morel:")

     # Start the saveData task.
saveData_Init("saveData.req", "P=morel:")

dbcar(0,1)

     # motorUtil (allstop & alldone)
motorUtilInit("morel:")

date
