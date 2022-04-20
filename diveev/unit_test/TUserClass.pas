UNIT TUserClass;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses TModelClass, Calc3;

type
  TArrInt=array of integer;
  TArrArrInt=array of TArrInt;
  TArr4Int=array [0..3]of integer;
  TArrArr4Int=array of TArr4Int;
  TArrArrArr4int=array of TArrArr4Int;
  TArrReal=array of real;
  TArrArrReal=array of TArrReal;
  TArrString=array of string;
  // TProc=Procedure;
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
//*************************************************************
                        IMPLEMENTATION
//*************************************************************
uses UnitTestHeader;

//*************************************************************
Constructor TUser.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, Epo1,
  kel1: integer; alfa1, pmut1: real; Lay1, Mout1, kp1, kr1, kw1, kv1, n1, m1,
  ll1, ny1: integer);
Begin
  Inherited Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, Epo1,
                   kel1, alfa1, pmut1, Lay1, Mout1, kp1, kr1, kw1,
                   kv1, n1, m1, ll1,ny1);
End;
//*********************************************************
Procedure TUser.Func(var Fu: TArrReal);
var
  sumpen,dr,promah:real;
  i:integer;
Begin
  Initial;
  goalrun:=goalrun+1;
  sumpen:=0;
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
  alf:real;
Begin
  alf:=0;
  // diff of robot state and goal   
  NOP.Vs[0]:=(xf1[0]-x1[0]);
  NOP.Vs[1]:=(xf1[1]-x1[1]);
  NOP.Vs[2]:=(xf1[2]-x1[2]);
  NOP.RPControl;
  if Normdist(x1,xf1)<epsterm then
  begin
    u[0]:=0;
    u[1]:=0;
  end
  else
  begin
    // control vector
    u[0]:=NOP.z[NOP.Dnum[0]]; 
    u[1]:=NOP.z[NOP.Dnum[1]];
  end;
  OgrUpr; // TModel.OgrUpr            
  f1[0]:=0.5*(u[0]+u[1])*cos(x1[2]);
  f1[1]:=0.5*(u[0]+u[1])*sin(x1[2]);
  f1[2]:=0.5*(u[0]-u[1]);

  // ??? 
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

begin
end.