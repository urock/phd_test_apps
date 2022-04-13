UNIT TModelClass;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
Uses Classes, Calc3, SysUtils, TGANOPClass;

type
	TArrInt=array of integer;
	TArrArrInt=array of TArrInt;
	TArr4Int=array [0..3]of integer;
	TArrArr4Int=array of TArr4Int;
	TArrArrArr4int=array of TArrArr4Int;
	TArrReal=array of real;
	TArrArrReal=array of TArrReal;
	TArrString=array of string;
	TProc=Procedure;
	
	TModel=class(TGANOP)
    x:TArrReal;// vector of condition
    qy:TArrReal;//vextor of undefined parameters
    x0:TArrReal;// vector of initial condition
    xs:TArrReal;//
    fb:TArrReal;
    fa:TArrReal;
    su:TArrReal;
    su1:TArrReal;
    u:TArrReal;// vector of control
    umin:TArrReal;// vector of control
    umax:TArrReal;// vector of control
    y:TArrReal;// vector of vewing
    n:integer;
    ny:integer;//dimention of undefined parameters
    qymax,qymin:TArrReal;
    ix,ixmax:TArrInt;
    stepsqy:TArrReal;//vector of steps of undefine parameters
    m:integer;
    lv:integer;
    dt:real;
    t:real;
    tf:real;
    shtraf:real;
    Constructor Create(hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,
                       Epo1,kel1:integer;alfa1,pmut1:real;
                       Lay1,Mout1,kp1,kr1,kw1,kv1,n1,m1,ll1,ny1:integer);
    Procedure Euler2;
    Procedure Func(var Fu:TArrReal); virtual;
    Procedure Func0(var Fu:TArrReal); override;
    Procedure Initial;virtual;
    Function OgrPhase:boolean;virtual;
    Procedure Viewer;virtual;
    Procedure Integr;
    Procedure LexPM(var ix1:tArrInt;var flag:boolean);
    Procedure OgrUpr;
    Procedure RP(t1:real;x1:TArrReal;var f1:TArrReal);virtual;//Правые части
    Procedure Setdt(dt1:real);
    Procedure Setixmax(ix1:TArrInt);
    Procedure Setqymax(qymax1:TArrReal);
    Procedure Setqymin(qymin1:TArrReal);
    Procedure Setstepsqy(stepsqy1:TArrReal);
    Procedure Settf(tf1:real);
    Procedure Setuogr(umin1,umax1:TArrReal);
    Procedure Setx0(x01:TArrReal);
    Procedure Setshtraf(s1:real);
    Procedure Upr;
  end;
  const EpsFunc=0.001;

//*************************************************************
                        IMPLEMENTATION
//*************************************************************
{$R+}

//*************************************************************
                      { TModel }
//*************************************************************
Constructor TModel.Create(hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,
                       Epo1,kel1:integer;alfa1,pmut1:real;
                       Lay1,Mout1,kp1,kr1,kw1,kv1,n1,m1,ll1,ny1:integer);
Begin
  inherited Create(hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,
                       Epo1,kel1,alfa1,pmut1,
                       Lay1,Mout1,kp1,kr1,kw1,kv1);
  n:=n1;
  m:=m1;
  lv:=ll1;
  ny:=ny1;
  SetLength(x,n);
  SetLength(x0,n);
  SetLength(xs,n);
  SetLength(fa,n);
  SetLength(fb,n);
  SetLength(u,m);
  SetLength(umax,m);
  SetLength(umin,m);
  SetLength(qymin,ny);
  SetLength(qymax,ny);
  SetLength(qy,ny);
  SetLength(ixmax,ny);
  SetLength(ix,ny);
  SetLength(stepsqy,ny);
  SetLength(y,lv);
  SetLength(su,nfu);
  SetLength(su1,nfu);
End;
//*************************************************************
Procedure TModel.Euler2;
var
  i:integer;
Begin
  RP(t,x,fa);     // right part
  for i:=0 to n-1 do
    xs[i]:=x[i]+dt*fa[i];
  RP(t+dt,xs,fb); // right part
  for i:=0 to n-1 do
    x[i]:=x[i]+dt*(fa[i]+fb[i])/2;
  t:=t+dt;
End;
//*************************************************************
Procedure TModel.Func(var Fu: TArrReal);
var
  i:integer;
Begin
  for i:=0 to nfu-1 do
    fu[i]:=0;
End;
//*************************************************************
Procedure TModel.Func0(var Fu: TArrReal);
var
  i:integer;
Begin
  Integr;
  for i:=0 to nfu-1 do
    Fu[i]:=su[i];
End;
//*************************************************************
Procedure TModel.Initial;
var
  i:integer;
Begin
  for i:=0 to n-1 do
    x[i]:=x0[i];
  t:=0;
End;
//*************************************************************
Procedure TModel.Integr;
var
  i,j:integer;
  flag:boolean;
Begin
  for i:=0 to ny-1 do
    ix[i]:=0;
  for i:=0 to nfu-1 do
    su[i]:=0;
  repeat
    for i:=0 to ny-1 do
      qy[i]:=qymin[i]+stepsqy[i]*ix[i];
    Func(su1);
    for i:=0 to nfu-1 do
      su[i]:=su[i]+su1[i];
    LexPM(ix,flag);
  until not flag;
End;
//*************************************************************
Procedure TModel.LexPM(var ix1: tArrInt; var flag: boolean);
var
  i,j:integer;
Begin
  i:=ny-1;
  while (i>=0)and(ix1[i]=ixmax[i]) do i:=i-1;
  if i>=0 then
  begin
    ix1[i]:=ix1[i]+1;
    for j:=i+1 to ny-1 do
      ix1[j]:=0;
    flag:=true;
  end
  else
    flag:=false;
End;
//*************************************************************
Function TModel.OgrPhase: boolean;
begin
  result:=true;
end;
//*************************************************************
Procedure TModel.OgrUpr;
var
  i:integer;
Begin
  for i:=0 to m-1 do
    if u[i]>umax[i] then
      u[i]:=umax[i]
    else
      if u[i]<umin[i] then
        u[i]:=umin[i];
End;
//*************************************************************
Procedure TModel.RP(t1:real;x1:TArrReal;var f1:TArrReal);
const
  TT=0.5;
  ksi=0.09;
  ko=1;
var
  i:integer;
Begin
  Upr;
  f1[0]:=x[1];
  f1[1]:=-2*ksi*x[1]/TT+(ko*u[0]-x[0])/sqr(TT);
  for i:=0 to n-1 do
    if abs(f1[i])>infinity then
      f1[i]:=Ro_10(f1[i])*infinity;
End;
//*************************************************************
Procedure TModel.Setdt(dt1: real);
Begin
  dt:=dt1;
End;
//*************************************************************
Procedure TModel.Setixmax(ix1: TArrInt);
var
  i:integer;
Begin
  for i:=0 to ny-1 do
    ixmax[i]:=ix1[i];
End;
//*************************************************************
Procedure TModel.Setqymax(qymax1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to ny-1 do
    qymax[i]:=qymax1[i];
End;
//*************************************************************
Procedure TModel.Setqymin(qymin1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to ny-1 do
    qymin[i]:=qymin1[i];
End;
//*************************************************************
Procedure TModel.Setshtraf(s1: real);
Begin
  shtraf:=s1;
End;
//*************************************************************
Procedure TModel.Setstepsqy(stepsqy1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to ny-1 do
    stepsqy[i]:=stepsqy1[i];
End;
//*************************************************************
Procedure TModel.Settf(tf1: real);
Begin
  tf:=tf1;
End;
//*************************************************************
Procedure TModel.Setuogr(umin1, umax1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to m-1 do
  begin
    umin[i]:=umin1[i];
    umax[i]:=umax1[i];
  end;
End;
//*************************************************************
Procedure TModel.Setx0(x01: TArrReal);
var
  i:integer;
Begin
  for i:=0 to n-1 do
    x0[i]:=x01[i];
End;
//*************************************************************
Procedure TModel.Upr;
Begin
  u[0]:=1;
End;
//*************************************************************
Procedure TModel.Viewer;
var
  i:integer;
Begin
  for i:=0 to n-1 do
    y[i]:=x[i];
End;
//*************************************************************
END.