**TSV

.GLOBAL vdd!

**.include "/home/mdl/jzx105/hspice/TSV/model/45nm_HP.pm"  
**power = 1
**.include "/home/mdl/jzx105/hspice/TSV/model/45nm_LP.pm"  
**power = 1.1
**.include "/home/mdl/jzx105/hspice/TSV/model/32nm_HP.pm"  
**power = 0.9 
**.include "/home/mdl/jzx105/hspice/TSV/model/32nm_LP.pm"  
**power = 1
**.include "/home/mdl/jzx105/hspice/TSV/model/22nm_HP.pm"  
**power = 0.8
**.include "/home/mdl/jzx105/hspice/TSV/model/22nm_LP.pm"  
**power = 0.95
**.include "/home/mdl/jzx105/hspice/TSV/model/16nm_HP.pm"  
**power = 0.7
.include "/home/mdl/jzx105/hspice/TSV/model/16nm_LP.pm"  
**power = 0.9


.TEMP 25
.OPTION
+    ARTIST=2
+    INGOLD=2
+    MEASOUT=1
+    PSF=2
+    method=gear
+    autostop=0
+    runlvl=2
**+    PROBE POST
+    POST

.param period=1n rise=10p
**.param vhigh = 1.5
**.param vhigh = 1.1
**.param vhigh = 1
.param vhigh = 0.9
**.param vhigh = 0.8
**.param vhigh = 0.95
**.param vhigh = 0.7
.param inv_w_n = 150n
**.param lt=130n
**.param lt=45n
**.param lt=32n
**.param lt=22n
.param lt=16n
Vd vdd! 0 vhigh
Vin in 0 PULSE vhigh 0 0 'rise' 'rise' 'period/2' 'period'
C out 0 5f

.subckt TSV in out
r0 in net1 0.17
l0 net1 out 4p
x0 in 0 sidewall_cap
x1 out 0 sidewall_cap
.ends

.subckt sidewall_cap tsv_node vss
cox tsv_node net2 38f
cdep net2 net3 30f
csi net3 vss 5f
rg net3 vss 1/4e-4
.ends

.subckt inv g1 input output v1 lt=130n wt=150n
mn0 output input g1 g1 nmos l=lt w=wt
mp0 output input v1 v1 pmos l=lt w=wt
.ends inv

X1 0 in net01 vdd! inv wt=inv_w_n
X2 net01 out TSV

.meas tran delay
+trig v(in) val='0.5*vhigh' rise=last
+targ v(out) val='0.5*vhigh' cross=last
.meas delay_out param='delay*1e12'

.trans 1p 10n
+sweep inv_w_n
**+150n 3000n 150n
**+50n 1000n 50n
**+40n 800n 40n
**+30n 600n 30n
+20n 400n 20n

.end
