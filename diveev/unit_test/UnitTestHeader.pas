UNIT UnitTestHeader;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses Classes, SysUtils, FileUtil, ComCtrls, Interfaces;


type
  TArrInt=array of integer;
  TArrArrInt=array of TArrInt;
  TArr4Int=array [0..3]of integer;
  TArrArr4Int=array of TArr4Int;
  TArrArrArr4int=array of TArrArr4Int;
  TArrReal=array of real;
  TArrArrReal=array of TArrReal;
  TArrString=array of string;

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
procedure SetParameters();
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

procedure SetParameters();
begin
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
  Setlength(ym,ll1);
  Setlength(um,m1);
  Setlength(xf1,n1);
  SetLength(xf2,ndu1);
  Setlength(qymax1,ny1);
  Setlength(qymin1,ny1);
  Setlength(stepsqy1,ny1);
  SetLength(qyGraph,ny1,nGraphc);
  Setlength(qy1,ny1);

  for i:=0 to L1-1 do
  for j:=0 to L1-1 do
  Psi1[i,j]:=PsiBasc[i,j];

  for i:=0 to nGraphc-1 do
  SetLength(xmm[i],ll1);
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
  begin
  x01[i]:=x0c[i];
  xf1[i]:=xfc[i];
  end;
  for i:=0 to m1-1 do
  begin
  umin1[i]:=uminc[i];
  umax1[i]:=umaxc[i];
  end;
  for i:= 0 to ny1-1 do
  begin
  qymin1[i]:=qyminc[i];
  qymax1[i]:=qymaxc[i];
  stepsqy1[i]:=stepsqyc[i];
  qy1[i]:=qymin1[i];
  end;

  StringGrid1[1,1]:=qymin1[0];
  StringGrid1[2,1]:=qymin1[1];
  StringGrid1[3,1]:=qymin1[2];
  StringGrid1[1,2]:=qymin1[0];
  StringGrid1[2,2]:=qymin1[1];
  StringGrid1[3,2]:=qymax1[2];
  StringGrid1[1,3]:=qymin1[0];
  StringGrid1[2,3]:=qymax1[1];
  StringGrid1[3,3]:=qymin1[2];
  StringGrid1[1,4]:=qymin1[0];
  StringGrid1[2,4]:=qymax1[1];
  StringGrid1[3,4]:=qymax1[2];
  StringGrid1[1,5]:=qymax1[0];
  StringGrid1[2,5]:=qymin1[1];
  StringGrid1[3,5]:=qymin1[2];
  StringGrid1[1,6]:=qymax1[0];
  StringGrid1[2,6]:=qymin1[1];
  StringGrid1[3,6]:=qymax1[2];
  StringGrid1[1,7]:=qymax1[0];
  StringGrid1[2,7]:=qymax1[1];
  StringGrid1[3,7]:=qymin1[2];
  StringGrid1[1,8]:=qymax1[0];
  StringGrid1[2,8]:=qymax1[1];
  StringGrid1[3,8]:=qymax1[2];

end;

begin
end.
