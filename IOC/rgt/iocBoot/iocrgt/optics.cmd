
# BEGIN optics.cmd ------------------------------------------------------------

### Slits
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2slit.db","P=rgt:,SLIT=Slit1V,mXp=m3,mXn=m4")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2slit.db","P=rgt:,SLIT=Slit1H,mXp=m5,mXn=m6")

# under development...
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2slit_soft.db","P=rgt:,SLIT=Slit2V,mXp=m13,mXn=m14")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2slit_soft.db","P=rgt:,SLIT=Slit2H,mXp=m15,mXn=m16")

# X-ray Instrumentation Associates Huber Slit Controller
# supported by a customized version of the SNL program written by Pete Jemian
#dbLoadRecords("$(OPTICS)/opticsApp/Db/xia_slit.db", "P=rgt:, HSC=hsc1:")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/xia_slit.db", "P=rgt:, HSC=hsc2:")
#dbLoadRecords("$(IP)/ipApp/Db/generic_serial.db", "P=rgt:,C=0,SERVER=serial7")


### 2-post mirror
#dbLoadRecords("$(OPTICS)/opticsApp/Db/2postMirror.db","P=rgt:,Q=M1,mDn=m18,mUp=m17,LENGTH=0.3")

### User filters
#dbLoadRecords("$(OPTICS)/opticsApp/Db/filterMotor.db","P=rgt:,Q=fltr1:,MOTOR=m1,LOCK=fltr_1_2:")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/filterMotor.db","P=rgt:,Q=fltr2:,MOTOR=m2,LOCK=fltr_1_2:")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/filterLock.db","P=rgt:,Q=fltr2:,LOCK=fltr_1_2:,LOCK_PV=rgt:DAC1_1.VAL")

### Optical tables
#tableRecordDebug=1
#dbLoadRecords("$(OPTICS)/opticsApp/Db/table.db","P=rgt:,Q=Table1,T=table1,M0X=m1,M0Y=m2,M1Y=m3,M2X=m4,M2Y=m5,M2Z=m6,GEOM=SRI")

### Monochromator support ###
# Kohzu and PSL monochromators: Bragg and theta/Y/Z motors
# standard geometry (geometry 1)
#dbLoadRecords("$(OPTICS)/opticsApp/Db/kohzuSeq.db","P=rgt:,M_THETA=m9,M_Y=m10,M_Z=m11,yOffLo=17.4999,yOffHi=17.5001")
# modified geometry (geometry 2)
#dbLoadRecords("$(OPTICS)/opticsApp/Db/kohzuSeq.db","P=rgt:,M_THETA=m9,M_Y=m10,M_Z=m11,yOffLo=4,yOffHi=36")

# Spherical grating monochromator
#dbLoadRecords("$(OPTICS)/opticsApp/Db/SGM.db","P=rgt:,N=1,M_x=m7,M_rIn=m6,M_rOut=m8,M_g=m9")

# 4-bounce high-resolution monochromator
#dbLoadRecords("$(OPTICS)/opticsApp/Db/hrSeq.db","P=rgt:,N=1,M_PHI1=m9,M_PHI2=m10")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/hrSeq.db","P=rgt:,N=2,M_PHI1=m11,M_PHI2=m12")

### Orientation matrix, four-circle diffractometer (see seq program 'orient' below)
#dbLoadRecords("$(OPTICS)/opticsApp/Db/orient.db", "P=rgt:,O=1,PREC=4")
#dbLoadTemplate("orient_xtals.substitutions")

# Load single element Canberra AIM MCA and ICB modules
#< canberra_1.cmd

# Load 13 element detector software
#< canberra_13.cmd

# Load 3 element detector software
#< canberra_3.cmd

# END optics.cmd --------------------------------------------------------------
