
# BEGIN seq.cmd ------------------------------------------------------------

### startup State Notation Language programs
#seq &kohzuCtl, "P=rgt:, M_THETA=m9, M_Y=m10, M_Z=m11, GEOM=1, logfile=kohzuCtl.log"
#seq &hrCtl, "P=rgt:, N=1, M_PHI1=m9, M_PHI2=m10, logfile=hrCtl1.log"

# Keithley 2000 series DMM
# channels: 10, 20, or 22;  model: 2000 or 2700
#seq &Keithley2kDMM,("P=rgt:, Dmm=D1, channels=22, model=2700")

# X-ray Instrumentation Associates Huber Slit Controller
# supported by a SNL program written by Pete Jemian and modified (TMM) for use with the
# sscan record
#seq  &xia_slit, "name=hsc1, P=rgt:, HSC=hsc1:, S=rgt:seriala[6]"

# Orientation-matrix
#seq &orient, "P=rgt:orient1:,PM=rgt:,mTTH=m9,mTH=m10,mCHI=m11,mPHI=m12"

# Start PF4 filter sequence program
#seq pf4,"name=pf1,P=rgt:,H=pf4:,B=A,M=rgt:BraggEAO,B1=rgt:Unidig1Bo3,B2=rgt:Unidig1Bo4,B3=rgt:Unidig1Bo5,B4=rgt:Unidig1Bo6"
#seq pf4,"name=pf2,P=rgt:,H=pf4:,B=B,M=rgt:BraggEAO,B1=rgt:Unidig1Bo7,B2=rgt:Unidig1Bo8,B3=rgt:Unidig1Bo9,B4=rgt:Unidig1Bo10"

# Start Femto amplifier sequence programs
#seq femto,"name=fem1,P=rgt:,H=fem01:,F=seq01:,G1=rgt:Unidig1Bo6,G2=rgt:Unidig1Bo7,G3=rgt:Unidig1Bo8,NO=rgt:Unidig1Bo10"

# END seq.cmd --------------------------------------------------------------
