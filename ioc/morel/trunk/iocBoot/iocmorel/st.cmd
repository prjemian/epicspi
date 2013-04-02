# Linux startup script

# For devIocStats
epicsEnvSet("ENGINEER","engineer")
epicsEnvSet("LOCATION","location")

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

< areaDetector.cmd

# Autosave info node example
#dbLoadRecords("$(AUTOSAVE)/asApp/Db/infoExample.db","P=morel:")

# Soft function generator
dbLoadRecords("$(CALC)/calcApp/Db/FuncGen.db","P=morel:,Q=fgen,OUT=morel:m7.VAL")

# user-assignable ramp/tweak
dbLoadRecords("$(STD)/stdApp/Db/ramp_tweak.db","P=morel:,Q=rt1")

### save_restore setup
# We presume a suitable initHook routine was compiled into morel.munch.
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

#< areaDetector.cmd

### Allstop, alldone
dbLoadRecords("$(MOTOR)/db/motorUtil.db", "P=morel:")

### Insertion-device control
#dbLoadRecords("$(STD)/stdApp/Db/IDctrl.db","P=morel:,xx=02us")

### Scan-support software
# crate-resident scan.  This executes 1D, 2D, 3D, and 4D scans, and caches
# 1D data, but it doesn't store anything to disk.  (See 'saveData' below for that.)
dbLoadRecords("$(SSCAN)/sscanApp/Db/scan.db","P=morel:,MAXPTS1=8000,MAXPTS2=1000,MAXPTS3=100,MAXPTS4=100,MAXPTSH=8000")

# A set of scan parameters for each positioner.  This is a convenience
# for the user.  It can contain an entry for each scannable thing in the
# crate.
dbLoadTemplate("scanParms.substitutions")

### Slits
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2slit.db","P=morel:,SLIT=Slit1V,mXp=m3,mXn=m4")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2slit.db","P=morel:,SLIT=Slit1H,mXp=m5,mXn=m6")

# X-ray Instrumentation Associates Huber Slit Controller
# supported by a customized version of the SNL program written by Pete Jemian
#dbLoadRecords("$(OPTICS)/opticsApp/Db/xia_slit.db", "P=morel:, HSC=hsc1:")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/xia_slit.db", "P=morel:, HSC=hsc2:")
#dbLoadRecords("$(IP)/ipApp/Db/generic_serial.db", "P=morel:,C=0,SERVER=serial7")


### 2-post mirror
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2postMirror.db","P=morel:,Q=M1,mDn=m1,mUp=m2,LENGTH=0.3")

### User filters
#dbLoadRecords("$(OPTICS)/opticsApp/Db/filterMotor.db","P=morel:,Q=fltr1:,MOTOR=m1,LOCK=fltr_1_2:")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/filterMotor.db","P=morel:,Q=fltr2:,MOTOR=m2,LOCK=fltr_1_2:")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/filterLock.db","P=morel:,Q=fltr2:,LOCK=fltr_1_2:,LOCK_PV=morel:DAC1_1.VAL")

### Optical tables
#tableRecordDebug=1
#dbLoadRecords("$(OPTICS)/opticsApp/Db/table.db","P=morel:,Q=Table1,T=table1,M0X=m1,M0Y=m2,M1Y=m3,M2X=m4,M2Y=m5,M2Z=m6,GEOM=SRI")

### Monochromator support ###
# Kohzu and PSL monochromators: Bragg and theta/Y/Z motors
# standard geometry (geometry 1)
#dbLoadRecords("$(OPTICS)/opticsApp/Db/kohzuSeq.db","P=morel:,M_THETA=m1,M_Y=m2,M_Z=m3,yOffLo=17.4999,yOffHi=17.5001")
# modified geometry (geometry 2)
#dbLoadRecords("$(OPTICS)/opticsApp/Db/kohzuSeq.db","P=morel:,M_THETA=m1,M_Y=m2,M_Z=m2,yOffLo=4,yOffHi=36")

# Spherical grating monochromator
#dbLoadRecords("$(OPTICS)/opticsApp/Db/SGM.db","P=morel:,N=1,M_x=m7,M_rIn=m6,M_rOut=m8,M_g=m9")

# 4-bounce high-resolution monochromator
#dbLoadRecords("$(OPTICS)/opticsApp/Db/hrSeq.db","P=morel:,N=1,M_PHI1=m1,M_PHI2=m2")

### Orientation matrix, four-circle diffractometer (see seq program 'orient' below)
#dbLoadRecords("$(OPTICS)/opticsApp/Db/orient.db", "P=morel:,O=1,PREC=4")
#dbLoadTemplate("orient_xtals.substitutions")

# Load single element Canberra AIM MCA and ICB modules
#< canberra_1.cmd

# Load 13 element detector software
#< canberra_13.cmd

# Load 3 element detector software
#< canberra_3.cmd

### Stuff for user programming ###
dbLoadRecords("$(CALC)/calcApp/Db/userCalcs10.db","P=morel:")
dbLoadRecords("$(CALC)/calcApp/Db/userCalcOuts10.db","P=morel:")
dbLoadRecords("$(CALC)/calcApp/Db/userStringCalcs10.db","P=morel:")
var aCalcArraySize, 2000
dbLoadRecords("$(CALC)/calcApp/Db/userArrayCalcs10.db","P=morel:,N=2000")
dbLoadRecords("$(CALC)/calcApp/Db/userTransforms10.db","P=morel:")
dbLoadRecords("$(CALC)/calcApp/Db/userAve10.db","P=morel:")
# string sequence (sseq) records
dbLoadRecords("$(CALC)/calcApp/Db/userStringSeqs10.db","P=morel:")
# 4-step measurement
dbLoadRecords("$(STD)/stdApp/Db/4step.db", "P=morel:")
# interpolation
dbLoadRecords("$(CALC)/calcApp/Db/interp.db", "P=morel:,N=2000")
dbLoadRecords("$(CALC)/calcApp/Db/interpNew.db", "P=morel:,Q=1,N=2000")
# array test
dbLoadRecords("$(CALC)/calcApp/Db/arrayTest.db", "P=morel:,N=2000")
# pvHistory (in-crate archive of up to three PV's)
dbLoadRecords("$(STD)/stdApp/Db/pvHistory.db","P=morel:,N=1,MAXSAMPLES=1440")
# busy record
dbLoadRecords("$(BUSY)/busyApp/Db/busyRecord.db", "P=morel:,R=mybusy")

# Slow feedback
#dbLoadTemplate "pid_slow.substitutions"

# PID-based feedback
#dbLoadTemplate "fb_epid.substitutions"

# Miscellaneous PV's, such as burtResult
dbLoadRecords("$(STD)/stdApp/Db/misc.db","P=morel:")

# devIocStats
dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminSoft.db","IOC=morel")

### Queensgate piezo driver
#dbLoadRecords("$(IP)/ipApp/Db/pzt_3id.db","P=morel:")
#dbLoadRecords("$(IP)/ipApp/Db/pzt.db","P=morel:")

### Queensgate Nano2k piezo controller
#dbLoadRecords("$(STD)/stdApp/Db/Nano2k.db","P=morel:,S=s1")

### Load database records for Femto amplifiers
#dbLoadRecords("$(STD)/stdApp/Db/femto.db","P=morel:,H=fem01:,F=seq01:")

### Load database records for dual PF4 filters
#dbLoadRecords("$(OPTICS)/opticsApp/Db/pf4common.db","P=morel:,H=pf4:,A=A,B=B")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/pf4bank.db","P=morel:,H=pf4:,B=A")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/pf4bank.db","P=morel:,H=pf4:,B=B")

###############################################################################
iocInit
###############################################################################

# write all the PV names to a local file
dbl > dbl-all.txt

### startup State Notation Language programs
#seq &kohzuCtl, "P=morel:, M_THETA=m1, M_Y=m2, M_Z=m3, GEOM=1, logfile=kohzuCtl.log"
#seq &hrCtl, "P=morel:, N=1, M_PHI1=m1, M_PHI2=m2, logfile=hrCtl1.log"

# Keithley 2000 series DMM
# channels: 10, 20, or 22;  model: 2000 or 2700
#seq &Keithley2kDMM,("P=morel:, Dmm=D1, channels=22, model=2700")

# X-ray Instrumentation Associates Huber Slit Controller
# supported by a SNL program written by Pete Jemian and modified (TMM) for use with the
# sscan record
#seq  &xia_slit, "name=hsc1, P=morel:, HSC=hsc1:, S=morel:seriala[6]"

# Orientation-matrix
#seq &orient, "P=morel:orient1:,PM=morel:,mTTH=m9,mTH=m10,mCHI=m11,mPHI=m12"

# Start PF4 filter sequence program
#seq pf4,"name=pf1,P=morel:,H=pf4:,B=A,M=morel:BraggEAO,B1=morel:Unidig1Bo3,B2=morel:Unidig1Bo4,B3=morel:Unidig1Bo5,B4=morel:Unidig1Bo6"
#seq pf4,"name=pf2,P=morel:,H=pf4:,B=B,M=morel:BraggEAO,B1=morel:Unidig1Bo7,B2=morel:Unidig1Bo8,B3=morel:Unidig1Bo9,B4=morel:Unidig1Bo10"

# Start Femto amplifier sequence programs
#seq femto,"name=fem1,P=morel:,H=fem01:,F=seq01:,G1=morel:Unidig1Bo6,G2=morel:Unidig1Bo7,G3=morel:Unidig1Bo8,NO=morel:Unidig1Bo10"

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

### Start the saveData task.
saveData_Init("saveData.req", "P=morel:")

dbcar(0,1)

# motorUtil (allstop & alldone)
motorUtilInit("morel:")

# print the time our boot was finished
date
