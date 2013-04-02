
### Stuff for user programming ###
dbLoadRecords("$(CALC)/calcApp/Db/userCalcs10.db","P=morel:")
dbLoadRecords("$(CALC)/calcApp/Db/userCalcOuts10.db","P=morel:")
dbLoadRecords("$(CALC)/calcApp/Db/userStringCalcs10.db","P=morel:")
aCalcArraySize=2000
dbLoadRecords("$(CALC)/calcApp/Db/userArrayCalcs10.db","P=morel:,N=2000")
dbLoadRecords("$(CALC)/calcApp/Db/userTransforms10.db","P=morel:")
# extra userCalcs (must also load userCalcs10.db for the enable switch)
dbLoadRecords("$(CALC)/calcApp/Db/userCalcN.db","P=morel:,N=I_Detector")
dbLoadRecords("$(CALC)/calcApp/Db/userAve10.db","P=morel:")
# string sequence (sseq) record
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=morel:,S=Sseq1")
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=morel:,S=Sseq2")
dbLoadRecords("$(STD)/stdApp/Db/yySseq.db","P=morel:,S=Sseq3")
# 4-step measurement
dbLoadRecords("$(STD)/stdApp/Db/4step.db", "P=morel:")
# interpolation
dbLoadRecords("$(CALC)/calcApp/Db/interp.db", "P=morel:,N=2000")
# array test
dbLoadRecords("$(CALC)/calcApp/Db/arrayTest.db", "P=morel:,N=2000")

