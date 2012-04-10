
# BEGIN userProgramming.cmd ------------------------------------------------------------

### Stuff for user programming ###
dbLoadRecords("$(CALC)/calcApp/Db/userCalcs10.db","P=rgt:")
dbLoadRecords("$(CALC)/calcApp/Db/userCalcOuts10.db","P=rgt:")
dbLoadRecords("$(CALC)/calcApp/Db/userStringCalcs10.db","P=rgt:")
var aCalcArraySize, 2000
dbLoadRecords("$(CALC)/calcApp/Db/userArrayCalcs10.db","P=rgt:,N=2000")
dbLoadRecords("$(CALC)/calcApp/Db/userTransforms10.db","P=rgt:")
# extra userCalcs (must also load userCalcs10.db for the enable switch)
dbLoadRecords("$(CALC)/calcApp/Db/userCalcN.db","P=rgt:,N=I_Detector")
dbLoadRecords("$(CALC)/calcApp/Db/userAve10.db","P=rgt:")
# string sequence (sseq) record
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=rgt:,S=Sseq1")
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=rgt:,S=Sseq2")
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=rgt:,S=Sseq3")
# 4-step measurement
dbLoadRecords("$(STD)/stdApp/Db/4step.db", "P=rgt:")
# interpolation
dbLoadRecords("$(CALC)/calcApp/Db/interp.db", "P=rgt:,N=2000")
# array test
dbLoadRecords("$(CALC)/calcApp/Db/arrayTest.db", "P=rgt:,N=2000")

# END userProgramming.cmd --------------------------------------------------------------
