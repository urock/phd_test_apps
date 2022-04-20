UNIT UnitTestHeader;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses Classes, SysUtils, FileUtil, ComCtrls,
Interfaces, TUserClass;

const
nGraphc=8; // num of graphs
epsterm=0.1;
infinity=1e10;

O1sc:array     [0..19]of integer=(1,2,3,4,5, 6,7,8,9,10, 
                                  11,12,13,14,15, 16,17,18,19,23);
O2sc:array     [0..1] of integer=(1,2);
Pnumc:array    [0..2] of integer=(0,1,2);
Rnumc:array    [0..2] of integer=(3,4,5);
Dnumc:array    [0..1] of integer=(22,23);
uminc:array    [0..1] of double=(-10,-10);
umaxc:array    [0..1] of double=(10,10);
x0c:array      [0..2] of real=(0,0,0);
xfc:array      [0..2] of real=(0,0,0);
qyminc:array   [0..2] of real=(-2.5,-2.5,-1.31);
qymaxc:array   [0..2] of real=(2.5,2.5,1.31);
stepsqyc:array [0..2] of real=(1.25,2.5,1.31);
{ qyminc:array   [0..2] of real=(-2.5,-2.5,-5*pi/12);
qymaxc:array   [0..2] of real=(2.5,2.5,5*pi/12);
stepsqyc:array [0..2] of real=(1.25,2.5,5*pi/12); }

{  qc:array [0..2]of real=(1,1,1);
   PsiBasc:array [0..23,0..23] of integer=
  ((0,0,0,0,  0,0,1,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,1,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  1,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,1,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),

   (0,0,0,0,  0,0,0,1,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  1,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,2,0,  0,1,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,2,  0,0,1,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),

   (0,0,0,0,  0,0,0,0,  2,0,0,1,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,1,1,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,1,1,   0,0,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,1,   1,0,0,0,  0,0,0,0,   0,0,0,0),

   (0,0,0,0,  0,0,0,0,  0,0,0,0,   1,1,0,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,1,1,0,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,1,1,  0,0,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,1,  1,0,0,0,   0,0,0,0),

   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  1,1,0,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,1,1,0,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,1,1,   0,0,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,1,   1,0,0,0),

   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   1,1,0,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,1,1,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,1,1),
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,1)); }

qc:array [0..2] of real=(12.86841, 3.82666, 6.94312); // from q_461.txt
// from 24_NOP_461
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

// test
StringGrid1:array [0..3,0..nGraphc+1] of real;
// 

// TUser param:
x01:TArrReal;
xf1:TArrReal;
xf2:TArrReal;
goalrun:integer=0;

j,i,k,kol,iGraph:integer;
tp,sumdelt,sumt,dxx,xx,yy:real;

sumdelt_golden: real=0.870068;
sumt_golden: real = 6.3;

function Normdist(x1: TArrReal; xf1: TArrReal): real;
//*************************************************************
                        IMPLEMENTATION
//*************************************************************
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

begin
end.
