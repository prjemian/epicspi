
# BEGIN instrument.cmd ------------------------------------------------------------

# sample-wheel
#dbLoadRecords("$(STD)/stdApp/Db/sampleWheel.db", "P=rgt:,ROWMOTOR=rgt:m7,ANGLEMOTOR=rgt:m8")


# Slow feedback
#dbLoadTemplate "pid_slow.substitutions"

### Queensgate piezo driver
#dbLoadRecords("$(IP)/ipApp/Db/pzt_3id.db","P=rgt:")
#dbLoadRecords("$(IP)/ipApp/Db/pzt.db","P=rgt:")

### Queensgate Nano2k piezo controller
#dbLoadRecords("$(STD)/stdApp/Db/Nano2k.db","P=rgt:,S=s1")

### Load database records for Femto amplifiers
#dbLoadRecords("$(STD)/stdApp/Db/femto.db","P=rgt:,H=fem01:,F=seq01:")

### Load database records for dual PF4 filters
#dbLoadRecords("$(OPTICS)/opticsApp/Db/pf4common.db","P=rgt:,H=pf4:,A=A,B=B")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/pf4bank.db","P=rgt:,H=pf4:,B=A")
#dbLoadRecords("$(OPTICS)/opticsApp/Db/pf4bank.db","P=rgt:,H=pf4:,B=B")


# END instrument.cmd --------------------------------------------------------------
