UNIT Unit1;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, StdCtrls, Unit2, Unit3, Unit4, Unit6, Unit7,
  Unit8, Unit9, Unit10, Unit11, Unit12, Unit13, Unit14, Unit15,
  UnitAdaptObject, Calc3, unitObstacle;
type
  { TForm1 }
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    ProgressBar1: TProgressBar;
    Procedure FormCreate(Sender: TObject);
    Procedure MenuItem10Click(Sender: TObject);
    Procedure MenuItem11Click(Sender: TObject);
    Procedure MenuItem12Click(Sender: TObject);
    Procedure MenuItem2Click(Sender: TObject);
    Procedure MenuItem3Click(Sender: TObject);
    Procedure MenuItem4Click(Sender: TObject);
    Procedure MenuItem5Click(Sender: TObject);
    Procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    Procedure MenuItem8Click(Sender: TObject);
    Procedure MenuItem9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
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
  x0c:array [0..2] of real=(0,0,0);
  xfc:array[0..2] of real=(0,0,0);
  uminc:array[0..1] of double=(-10,-10);
  umaxc:array[0..1] of double=(10,10);
  O1sc:array [0..19] of integer=(1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16, 17,18,19,23);
  O2sc:array [0..1] of integer=(1,2);
  E2sc:array [0..1] of real =(0,1);
  //qc:array[0..2] of real=(0.44385, 4.43408, 15.94507);//(1,1,1);//(5.46558,15.82227,15.196191);
  qc:array [0..2]of real=(1,1,1);
  //(14.72876, 2.02710, 4.02222);
  qyminc:array [0..2]of real =(-2.5,-2.5,-5*pi/12);
  qymaxc:array [0..2]of real =(2.5,2.5,5*pi/12);

  // TODO проверить что начальные точки не попадают

  stepsqyc:array[0..2]of real=(1.25,2.5,5*pi/12);
  Pnumc:array [0..2] of integer=(0,1,2);
  Rnumc:array [0..2] of integer=(3,4,5);
  Dnumc:array [0..1] of integer=(22,23);
  xmaxc:array [0..2] of real=(7,7,pi/2);
  xminc:array [0..2] of real=(-7,-7,-pi/2);
  tfc:real=1.5;// время окончания
  dtc:real=0.01;//шаг интегрирования
  nGraphc=8;// число графиков
//  eps=1e-7;
  epsterm=0.1;
  infinity=1e10;
  PsiBasc:array [0..23,0..23] of integer=
  ((0,0,0,0,  0,0,1,0,	0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0),
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
   (0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,1));


var
  Form1: TForm1;
  ASNEE:TUser;
  n1:integer=3;//dimention of system;
  m1:integer=2;//dimention of control;
  ll1:integer=3;//dimention of viewing;
  dt1:real=0.01; //step of integration;
  tf1:real=1.5;//terminal time;
  dtp:real=0.1;//step of print;
  x01:TArrReal;
  xf1:TArrReal;
  UpProg:TProc;
  umin1:TArrReal;
  umax1:TarrReal;
  qymax1,qymin1,stepsqy1:TArrReal;
  qyGraph:TArrArrReal;
  HH1:integer=512; //number of chromosomes in an initial population
  PP1:integer=128;  // number of generations
  RR1:integer=128; // number of couples in one generation
  nfu1:integer=2;  // number of functionals
  lchr1:integer=8; //number of variations in one chromosome
  p1:integer=3;    //number of serching parameters
  c1:integer=4;    //number of bits for integer part
  d1:integer=12;   //number of bits for fractional part
  Epo1:integer=10;  // number of ganerations between exchange of basic NOM
  kel1:integer=10;  // number of elitaring chromosomes
  alfa1:real=0.4;  // parameter for crossover
  pmut1:real=0.7;  // probability of mutation
  L1:integer=24;   // dimension of network operator matrix
  kp1:integer=3;   //cardinal of set of variables
  kr1:integer=3;   //cardinal of set of parameters
  kw1:integer=20;   //cardinal of set of unary operations
  kv1:integer=2;   //cardinal of set of binary operations
  Mout1:integer=2; // number of outputs
  ny1:integer=3;// dimension of vector of undefine parameters
  ndu1:integer=2;// dimension of unstable points
  nsymStr:integer=64;//
  Shtraf1:real=2;
  weight:real=2.5;
  ksearch1:integer=8;
  O1s1,
  O2s1,
  Pnum1,
  Rnum1,
  Dnum1:TArrInt;
  q1:TArrReal;
  qy1:TArrReal;
  Psi1:TArrArrInt;
  kChoose:integer;// number of the choosed chromosome
  xm:TArrArrReal;
  ym:TArrArrReal;
  tm:TArrReal;
  um:TArrArrReal;
  xf2:TArrReal;
  FlagStop:boolean;
  xmm:array[0..nGraphc-1] of TArrArrReal;
  kolpoint_mult:array[0..nGraphc-1] of integer;
  kolpoint:integer;
  f0,f1:real;
  goalrun:integer=0;

  Function Normdist(x1,xf1:TArrReal):real;
  Function Power2(l:integer):real;
  Procedure UpProgressBar;
//*************************************************************
                        IMPLEMENTATION
//*************************************************************
{$R *.lfm}
{ TForm1 }
//*************************************************************
Procedure TForm1.MenuItem5Click(Sender: TObject);
Begin
  Application.CreateForm(TForm2,Form2);
  Form2.ShowModal;
  Application.CreateForm(TForm3,Form3);
  Form3.ShowModal;
  if Application.MessageBox('FOR YOUR INFORMATION:   '
                            +'When the object for GA with NOP is created then '
                            +'you will not be able to change some paprameters.  ',
                            'Creation of object',1)=1 then
  begin
    ASNEE:=TUser.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, epo1,
                       kel1, alfa1, pmut1, L1, Mout1, kp1,
                       kr1, kw1, kv1,n1,m1,ll1,ny1);
    ASNEE.Setqymax(qymax1);
    ASNEE.Setqymin(qymin1);
    ASNEE.Setstepsqy(stepsqy1);
    ASNEE.NOP.SetO1s(o1s1);
    ASNEE.NOP.SetO2s(o2s1);
    ASNEE.SetShtraf(Shtraf1);
//    ASNEE.NOP.SetE2s(o2s1);
    MenuItem5.Enabled:=false;
    MenuItem2.Enabled:=true;
    //ParametersofGA1.Enabled:=true;
    ASNEE.EndGeneration:=@UpProgressBar;
    ASNEE.ksearch:=ksearch1;
  end
  else
    exit;
End;
//*************************************************************
Procedure TForm1.MenuItem6Click(Sender: TObject);
var
  i,iGraph:integer;
  tp,sumdelt,sumt:real;
Begin
  Application.CreateForm(TForm13,Form13);
  Form13.ShowModal;
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
  Application.CreateForm(TForm14,Form14);
  Form14.ShowModal;
End;
//*************************************************************
Procedure TForm1.MenuItem7Click(Sender: TObject);
Begin
  Application.CreateForm(TForm15,Form15);
  Form15.ShowModal;
End;
//*************************************************************
Procedure TForm1.FormCreate(Sender: TObject);
var
  i,j:integer;
Begin
  randomize;
  ProgressBar1.top:=212;
  ProgressBar1.left:=0;
  ProgressBar1.width:=ClientWidth;
  Memo1.Top:=0;
  Memo1.Left:=0;
  Memo1.Height:=progressbar1.top;
  Memo1.Width:=ClientWidth;
  Memo1.ReadOnly:=true;
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
  //SetLength(qyGraph,nGraphc,2);

  // Set phase constrains
  Setlength(Obstacles, NumOfObstacles);
  // x_top_left, y_top_left, x_botton_right, y_bottom_right
  Obstacles[0] := Obstacle.Create(-0.45, 0.6, 0.6, 0.15);
  Obstacles[1] := Obstacle.Create(-0.45, -0.15, 0.6, -0.6);
  Obstacles[2] := Obstacle.Create(0.6, 0.6, 0.9, -0.6);; 

End;
//*********************************************************
Procedure TForm1.MenuItem10Click(Sender: TObject);
Begin
  Application.CreateForm(TForm7,Form7);
  Form7.ShowModal;
  ASNEE.RR:=RR1;
  ASNEE.kel:=kel1;
  ASNEE.Epo:=Epo1;
  ASNEE.alfa:=alfa1;
  ASNEE.pmut:=pmut1;
  ASNEE.SetPP(PP1);
  ASNEE.SetShtraf(Shtraf1);
End;
//*********************************************************
Procedure TForm1.MenuItem11Click(Sender: TObject);
Begin
  Application.CreateForm(TForm8,Form8);
  Form8.ShowModal;
  ASNEE.Setdt(dt1);
  ASNEE.Settf(tf1);
  ASNEE.Setx0(x01);
  ASNEE.Setuogr(umin1,umax1);
End;
//*********************************************************
Procedure TForm1.MenuItem12Click(Sender: TObject);
Begin
  Application.CreateForm(TForm12,Form12);
  Form12.ShowModal;
End;
//*********************************************************
Procedure TForm1.MenuItem2Click(Sender: TObject);
Begin
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=PP1;
  ASNEE.NOP.SetPsiBas(Psi1);
  ASNEE.Setq(q1);

  writeln('TForm1.MenuItem2Click');
  ASNEE.GenAlgorithm;
End;
//*********************************************************
Procedure TForm1.MenuItem3Click(Sender: TObject);
Begin
  Application.CreateForm(TForm9,Form9);
  Form9.ShowModal;
  label1.Caption:=inttostr(kchoose);
  ASNEE.ReadChromosome(kchoose,q1,Psi1);
End;
//*********************************************************
Procedure TForm1.MenuItem4Click(Sender: TObject);
var
  k,i:integer;
  tp:real;
Begin
  Application.CreateForm(TForm10,Form10);
  Form10.ShowModal;
  ASNEE.NOP.SetPsi(Psi1);
  ASNEE.Initial;
  tp:=0;
  kolpoint:=0;
  ASNEE.NOP.SetCs(q1);
  repeat
    if abs(ASNEE.t-tp)<ASNEE.dt/2 then
    begin
      ASNEE.Viewer;
      kolpoint:=kolpoint+1;
      for i:=0 to ll1-1 do
      begin
        Setlength(ym[i],kolpoint);
        ym[i,kolpoint-1]:=ASNEE.y[i];
      end;
      for i:=0 to m1-1 do
      begin
        Setlength(um[i],kolpoint);
        um[i,kolpoint-1]:=ASNEE.u[i];
      end;
      Setlength(tm,kolpoint);
      tm[kolpoint-1]:=ASNEE.t;
      tp:=tp+dtp;
    end;
    ASNEE.Euler2;
  until (ASNEE.t>tf1)or(Normdist(ASNEE.x,xf1)<epsterm);
  f1:=ASNEE.t;
  f0:=Normdist(ASNEE.x,xf1);
  Application.CreateForm(TForm11,Form11);
  Form11.ShowModal;
End;
//*********************************************************
Procedure TForm1.MenuItem8Click(Sender: TObject);
var
  i:integer;
Begin
  Application.CreateForm(TForm4,Form4);
  Form4.ShowModal;
  ASNEE.Setqymin(qymin1);
  ASNEE.Setqymax(qymax1);
  ASNEE.Setstepsqy(stepsqy1);
  for i:=0 to ny1-1 do
    ASNEE.ix[i]:=trunc((qymax1[i]-qymin1[i])/stepsqy1[i]);
  ASNEE.Setixmax(ASNEE.ix);
End;
//*********************************************************
Procedure TForm1.MenuItem9Click(Sender: TObject);
Begin
  Application.CreateForm(TForm6,Form6);
  Form6.ShowModal;
  //ASNEE.NOP.SetBTreeBas(BTree1);
  ASNEE.Setq(q1);
  ASNEE.NOP.SetRnum(rnum1);
  ASNEE.NOP.SetPnum(pnum1);
  ASNEE.NOP.SetDnum(dnum1);
  ASNEE.NOP.SetPsi(Psi1);
End;
//*********************************************************
Procedure UpProgressBar;
Begin
  Form1.ProgressBar1.StepIt;
  Form1.Label2.Caption:=FloattoStrf(ASNEE.Fuh[ASNEE.Pareto[0],0],ffFixed,8,3)+'  '+
                        Floattostrf(ASNEE.Fuh[ASNEE.Pareto[0],1],ffFixed,8,3) + ' / '+
                        InttoStr(goalrun);
  Form1.Refresh;
End;
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
  sumpen,dr,promah,obstacleCost:real;
  i, j:integer;
Begin
  obstacleCost:=0;
  Initial;
  goalrun:=goalrun+1;
  sumpen:=0;
  for i:=0 to NOP.kR-1 do
    NOP.Cs[i]:=q[i];
  repeat
    Viewer;
    Euler2;

    for j := 0 to NumOfObstacles-1 do
    begin
      if (Obstacles[j].CheckCollision(x[0], x[1])) then
      begin
        obstacleCost:=20;
        break;        
      end;
    end;
    
  until (t>tf1)or (Normdist(x,xf1)<epsterm);

  promah:=0;
  for i := 0 to high(xf1) do
    promah:=promah+sqr(x[i]-xf1[i]);  
  promah:=sqrt(promah);

  fu[0]:=t+Shtraf1*promah ; // тут длина траектории  
  fu[1]:=promah + obstacleCost; // тут препятствие 
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
  {if (x1[0]>0) and (x1[1]>0) then alf:=0
    else
      if (x1[0]<0)and(x1[1]>0) then alf:=pi/2
      else
        if (x1[0]>0)and(x1[1]<0) then alf:=-pi/2
        else  alf:=pi; }
  alf:=0;
  NOP.Vs[0]:=(xf1[0]-x1[0]);//*cos(alf)+(xf1[1]-x1[1])*sin(alf);
  NOP.Vs[1]:=(xf1[1]-x1[1]);//*cos(alf)-(xf1[0]-x1[0])*sin(alf);
  NOP.Vs[2]:=(xf1[2]-x1[2]);
  NOP.RPControl;
  if Normdist(x1,xf1)<epsterm then
  begin
    u[0]:=0;
    u[1]:=0;
  end
  else
  begin
    u[0]:=NOP.z[NOP.Dnum[0]];//*cos(alf)-NOP.z[NOP.Dnum[1]]*sin(alf);
    u[1]:=NOP.z[NOP.Dnum[1]];//*cos(alf)+NOP.z[NOP.Dnum[0]]*sin(alf);
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
Function TermStop:boolean;
var
  i:integer;
  sum:real;
Begin
  sum:=0;
  for i:=0 to high(xf1) do
    sum:=sum+sqr(ASNEE.x[i]-xf1[i]);
  if sqrt(sum)<epsterm then
    result:=true
  else
    result:=false;
End;
//*********************************************************
Function Normdist(x1,xf1:TArrReal):real;
var
  sum,aa:real;
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
Function Power2(l:integer):real;
var
  i:integer;
  d,delt:real;
Begin
  d:=1;
  if l<0 then delt:=0.5
  else delt:=2;
  for i:=1 to trunc(l) do
    d:=d*delt;
  Result:=d;
End;
//*************************************************************
END.

