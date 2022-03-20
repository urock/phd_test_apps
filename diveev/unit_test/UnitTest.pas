program UnitTest;
uses crt, Classes, SysUtils, FileUtil, ComCtrls, StdCtrls, UnitBVGPobject, UnitAdaptObject, Calc3, Interfaces;

(* Here the main program block starts *)
type
  { TUser }
  TUser=class(TModel)
    Constructor Create(hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,
                   Epo1,kel1:integer;alfa1,pmut1:real;
                   Lay1,Mout1,kp1,kr1,kw1,kv1,n1,m1,ll1,ny1:integer);
    Procedure Func(var Fu:TArrReal); override;
    Procedure RP(t1:real;x1:TArrReal;var f1:TArrReal); override;
    Procedure Initial;override;
    Procedure Viewer;override;
end;

const

O1sc:array [0..19] of integer=(1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16, 17,18,19,23);
O2sc:array [0..1] of integer=(1,2);
Pnumc:array [0..2] of integer=(0,1,2);
Rnumc:array [0..2] of integer=(3,4,5);
Dnumc:array [0..1] of integer=(22,23);
qc:array [0..2]of real=(12.86841, 3.82666, 6.94312); // parameters from file q_461.txt
x0c:array [0..2] of real=(0,0,0);
xfc:array[0..2] of real=(0,0,0);
uminc:array[0..1] of double=(-10,-10);
umaxc:array[0..1] of double=(10,10);
qyminc:array [0..2]of real =(-2.5,-2.5,-5*pi/12);
qymaxc:array [0..2]of real =(2.5,2.5,5*pi/12);
stepsqyc:array[0..2]of real=(1.25,2.5,5*pi/12);
epsterm=0.1;
infinity=1e10;
// parameters from file 24_NOP_461
PsiBasc:array [0..23,0..23] of integer=
  ((0,0,0,0,  0,0,1,10,	0,0,12,1,  0,0,0,0,  0,0,0,0,   0,0,0,10),
   (0,0,0,0,  0,0,0,1,  0,0,0,0,   0,0,0,0,  0,0,0,12,  0,0,0,0),
   (0,0,0,0,  0,0,0,0,  1,0,0,0,   0,0,2,9,  0,0,0,0,   10,0,0,0),
   (0,0,0,0,  0,0,1,0,  0,0,0,0,   0,0,0,13, 0,0,0,0,   0,0,0,0),

   (0,0,0,0,  0,0,0,1,  0,0,0,0,   0,0,0,0,   0,0,1,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  1,0,0,0,   0,0,0,0,   0,0,0,0,   0,0,0,19),
   (0,0,0,0,  0,0,2,0,  0,8,0,5,   0,4,13,10, 0,0,0,14,  15,0,0,0),
   (0,0,0,0,  0,0,0,2,  0,1,10,9,  0,0,0,0,  0,0,0,0,   0,0,0,0),

   (0,0,0,0,  0,0,0,0,  2,1,0,0,   8,0,0,0,  12,0,0,0,  19,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,1,1,8,   0,0,0,1,  8,0,0,0,   14,12,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,1,1,   0,5,4,23, 1,0,0,0,   15,0,0,23),
   (0,0,0,0,  0,0,0,0,  0,0,0,1,   17,10,10,0,  0,0,0,16,   0,16,0,16),

   (0,0,0,0,  0,0,0,0,  0,0,0,0,   1,0,15,0, 14,0,0,0,  0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,1,9,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,1,1,  10,0,0,0,  0,12,0,13),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,1,  8,0,0,16,   0,0,0,0),

   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  1,1,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,2,1,0,   15,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,2,0,   17,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,1,   5,0,0,17),

   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   1,1,0,13),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,1,1,17),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,1,4),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,1));

  nGraphc=8; // num of graphs

var

ASNEE:TUser;

n1:integer=3;     //dimention of system;
m1:integer=2;     //dimention of control;
ll1:integer=3;    //dimention of viewing;
dt1:real=0.01;    //step of integration;
tf1:real=1.5;     //terminal time;
dtp:real=0.1;     //step of print;
HH1:integer=512;  //number of chromosomes in an initial population
PP1:integer=128;  // number of generations
RR1:integer=128;  // number of couples in one generation
nfu1:integer=2;   // number of functionals
lchr1:integer=8;  //number of variations in one chromosome
p1:integer=3;     //number of serching parameters
c1:integer=4;     //number of bits for integer part
d1:integer=12;    //number of bits for fractional part
Epo1:integer=10;  // number of ganerations between exchange of basic NOM
kel1:integer=10;  // number of elitaring chromosomes
alfa1:real=0.4;   // parameter for crossover
pmut1:real=0.7;   // probability of mutation
L1:integer=24;    // dimension of network operator matrix
kp1:integer=3;    //cardinal of set of variables
kr1:integer=3;    //cardinal of set of parameters
kw1:integer=20;   //cardinal of set of unary operations
kv1:integer=2;    //cardinal of set of binary operations
Mout1:integer=2;  // number of outputs
ny1:integer=3;    // dimension of vector of undefine parameters
ndu1:integer=2;// dimension of unstable points

qymax1,qymin1,stepsqy1:TArrReal;
qyGraph:TArrArrReal;
umin1:TArrReal;
umax1:TarrReal;
q1:TArrReal;
qy1:TArrReal;
xm:TArrArrReal;
ym:TArrArrReal;
um:TArrArrReal;
Psi1:TArrArrInt;

O1s1,
O2s1,
Pnum1,
Rnum1,
Dnum1:TArrInt;
Shtraf1:real=2;
ksearch1:integer=8;

xmm:array[0..nGraphc-1] of TArrArrReal;
kolpoint_mult:array[0..nGraphc-1] of integer;
kolpoint:integer;
f0,f1:real;

// TUser param:
x01:TArrReal;
xf1:TArrReal;
xf2:TArrReal;
goalrun:integer=0;

j,i,k,kol,iGraph:integer;
tp,sumdelt,sumt,dxx,xx,yy:real;

// TODO EXTRACT "TUser" CLASS TO SEPARTE FILE

//*********************************************************
function Normdist(x1: TArrReal; xf1: TArrReal): real;  
var
  sum, aa:real;
  i:integer;
Begin
  sum:=0;
  for i:=0 to high(xf1) do
  begin
    aa:=abs(xf1[i]-x1[i]);
    if aa> sum then
      sum:=aa;
  end;
  result:=sum;
End;

//*************************************************************


//*********************************************************
Constructor TUser.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, Epo1,
  kel1: integer; alfa1, pmut1: real; Lay1, Mout1, kp1, kr1, kw1, kv1, n1, m1,
  ll1, ny1: integer);
Begin
  Inherited Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, epo1,
                   kel1, alfa1, pmut1, Lay1,Mout1, kp1, kr1, kw1,
                   kv1,n1,m1,ll1,ny1);
End;
//*********************************************************

Procedure TUser.Func(var Fu: TArrReal);
var
  promah:real;
  i:integer;
Begin
  Initial;
  goalrun:=goalrun+1;
  for i:=0 to NOP.kR-1 do
    NOP.Cs[i]:=q[i];
  repeat
    Viewer;
    Euler2;
  until (t>tf1)or (Normdist(x,xf1)<epsterm);
  promah:=0;
  for i := 0 to high(xf1) do
    promah:=promah+sqr(x[i]-xf1[i]);
  promah:=sqrt(promah);
  fu[0]:=t+Shtraf1*promah;
  fu[1]:=promah;
End;

//*********************************************************

Procedure TUser.Initial;
Begin
  x[0]:=x0[0]+qy[0];
  x[1]:=x0[1]+qy[1];
  x[2]:=x0[2]+qy[2];
  u[0]:=0;
  u[1]:=0;
  t:=0;
End;

//*********************************************************

Procedure TUser.RP(t1: real; x1: TArrReal; var f1: TArrReal);
var
  i:integer;
Begin
  NOP.Vs[0]:=(xf1[0]-x1[0]);    //*cos(alf)+(xf1[1]-x1[1])*sin(alf);
  NOP.Vs[1]:=(xf1[1]-x1[1]);    //*cos(alf)-(xf1[0]-x1[0])*sin(alf);
  NOP.Vs[2]:=(xf1[2]-x1[2]);
  NOP.RPControl;
  if Normdist(x1,xf1)<epsterm then
  begin
    u[0]:=0;
    u[1]:=0;
  end
  else
  begin
    u[0]:=NOP.z[NOP.Dnum[0]];   //*cos(alf)-NOP.z[NOP.Dnum[1]]*sin(alf);
    u[1]:=NOP.z[NOP.Dnum[1]];   //*cos(alf)+NOP.z[NOP.Dnum[0]]*sin(alf);
  end;
  OgrUpr;
  f1[0]:=0.5*(u[0]+u[1])*cos(x1[2]);
  f1[1]:=0.5*(u[0]+u[1])*sin(x1[2]);
  f1[2]:=0.5*(u[0]-u[1]);
  for i := 0 to n-1 do
    if abs(f1[i])>infinity then
      f1[i]:=Ro_10(f1[i])*infinity;
End;

//*********************************************************

Procedure TUser.Viewer;
Begin
  y[0]:=x[0];
  y[1]:=x[1];
  y[2]:=x[2];
End;

//*********************************************************

// MAIN //
begin
   writeln('Hello, Unit test!');

   // Pipeline
   // 0. TForm1 create
   // 1. (MenuItem5Click)
   // 2. (MenuItem8Click)
   // 3. (MenuItem9Click)
   // 4. (MenuItem10Click)
   // 5. (MenuItem11Click)
   // 6. (MenuItem6Click)

   //******* STEP 0 *******//
   randomize;
   Setlength(O1s1,kW1);
   Setlength(O2s1,kV1);
   Setlength(Pnum1,kP1);
   Setlength(Rnum1,kR1);
   Setlength(Dnum1,Mout1);
   SetLength(Psi1,L1,L1);
   Setlength(x01,n1);
   Setlength(umin1,m1);
   Setlength(umax1,m1);
   Setlength(q1,p1);
   Setlength(qy1,ny1);
   Setlength(ym,ll1);
   Setlength(um,m1);
   Setlength(xf1,n1);
   SetLength(xf2,ndu1);

   for i:=0 to L1-1 do
    for j:=0 to L1-1 do
      Psi1[i,j]:=PsiBasc[i,j];
   for i:=0 to nGraphc-1 do
   begin
    SetLength(xmm[i],ll1);
   end;
   Setlength(qymax1,ny1);
   Setlength(qymin1,ny1);
   Setlength(stepsqy1,ny1);
   SetLength(qyGraph,ny1,nGraphc);
   for i:=0 to kW1-1 do
    O1s1[i]:=O1sc[i];
   for i:=0 to kV1-1 do
    O2s1[i]:=O2sc[i];
   for i:=0 to kP1-1 do
    Pnum1[i]:=Pnumc[i];
   for i:=0 to kR1-1 do
    Rnum1[i]:=Rnumc[i];
   for i:=0 to Mout1-1 do
    Dnum1[i]:=Dnumc[i];
   for i:=0 to p1-1 do
    q1[i]:=qc[i];
   for i:=0 to n1-1 do
    x01[i]:=x0c[i];
   for i:=0 to n1-1 do
    xf1[i]:=xfc[i];
   for i:=0 to m1-1 do
    umin1[i]:=uminc[i];
   for i:=0 to m1-1 do
    umax1[i]:=umaxc[i];
   for i:= 0 to ny1-1 do
   begin
    qymin1[i]:=qyminc[i];
    qymax1[i]:=qymaxc[i];
    stepsqy1[i]:=stepsqyc[i];
    qy1[i]:=qymin1[i];
   end;


   //******* STEP 1 *******//
   // set parameters from first window () {button: Create object for NOP}
   ASNEE:=TUser.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, epo1,
                       kel1, alfa1, pmut1, L1, Mout1, kp1,
                       kr1, kw1, kv1,n1,m1,ll1,ny1);
    ASNEE.Setqymax(qymax1);
    ASNEE.Setqymin(qymin1);
    ASNEE.Setstepsqy(stepsqy1);
    ASNEE.NOP.SetO1s(o1s1);
    ASNEE.NOP.SetO2s(o2s1);
    ASNEE.SetShtraf(Shtraf1);
    ASNEE.ksearch:=ksearch1;            

   //******* STEP 2 *******//
   // set another parameters {button: Undefinaed parameters}
   ASNEE.Setqymin(qymin1);
   ASNEE.Setqymax(qymax1);
   ASNEE.Setstepsqy(stepsqy1);
   for i:=0 to ny1-1 do
      ASNEE.ix[i]:=trunc((qymax1[i]-qymin1[i])/stepsqy1[i]);
   ASNEE.Setixmax(ASNEE.ix); 

   //******* STEP 3 *******//
   // set another parameters {button: parameters for NOP} 
   ASNEE.Setq(q1);
   ASNEE.NOP.SetRnum(rnum1);
   ASNEE.NOP.SetPnum(pnum1);
   ASNEE.NOP.SetDnum(dnum1);
   ASNEE.NOP.SetPsi(Psi1);    

   //******* STEP 4 *******//
   // set another parameters {button: parameters of GA for NOP}
   ASNEE.RR:=RR1;
   ASNEE.kel:=kel1;
   ASNEE.Epo:=Epo1;
   ASNEE.alfa:=alfa1;
   ASNEE.pmut:=pmut1;
   ASNEE.SetPP(PP1);
   ASNEE.SetShtraf(Shtraf1); 

   //******* STEP 5 *******//
   // set another parameters {button: parameters for model}
   ASNEE.Setdt(dt1);
   ASNEE.Settf(tf1);
   ASNEE.Setx0(x01);
   ASNEE.Setuogr(umin1,umax1); 

   //******* STEP 6 *******//

   
   ASNEE.NOP.SetPsi(Psi1);
   sumt:=0;
   sumdelt:=0;
   for iGraph := 0 to nGraphc-1 do
   begin
      for i:= 0 to ny1-1 do
         ASNEE.qy[i]:=qyGraph[i,iGraph];
      ASNEE.Initial;
      tp:=0;
      kolpoint_mult[iGraph]:=0;
      ASNEE.NOP.SetCs(q1);
      f0:=0;
      repeat
         if abs(ASNEE.t-tp)<ASNEE.dt/2 then
         begin
            ASNEE.Viewer;
            kolpoint_mult[iGraph]:=kolpoint_mult[iGraph]+1;
            for i:=0 to n1-1 do
            begin
               Setlength(xmm[iGraph,i],kolpoint_mult[iGraph]);
               xmm[iGraph,i,kolpoint_mult[iGraph]-1]:=ASNEE.x[i];
            end;
            tp:=tp+dtp;
         end;
         ASNEE.Euler2;
      until (ASNEE.t>tf1)or (Normdist(ASNEE.x,xf1)<epsterm);
      sumt:=sumt+ASNEE.t;
      sumdelt:=sumdelt+Normdist(ASNEE.x,xf1);
   end;
   f0:=sumdelt;
   f1:=sumt;

   // kolpoint_mult = (8, 6, 15, 9, 6, 8, 8, 6)
   for i:=0 to Length(kolpoint_mult)-1 do
      writeln(kolpoint_mult[i]);

   

      //// MAIN END /////            

//******* STEP 7 *******//

   readkey;
end.


