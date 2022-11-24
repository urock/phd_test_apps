UNIT UnitBVGPobject;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, Calc3;
type
  TArrInt=array of integer;
  TArrArrInt=array of TArrInt;
  TArr2Int=array [0..1]of integer;
  TArrArr2Int=array of TArr2Int;
  TArrArrArr2Int=array of TArrArr2Int;
  TArrReal=array of real;
  TArrArrReal=array of TArrReal;
  TArrString=array of string;
  TProc=Procedure;

  { TBVGP }

  TBVGP=class(TObject)
    Lay:integer; //depth of binary tree
    kol:integer;// number of elements of Btree
    Mout:integer;//number of outputs
    Vs:TArrReal;//set of variables
    Cs:TArrReal;//set of parameters
    E2s:TArrReal;// Unit elements for binary operations
    O1s:TArrInt;//set of unary operations
    O2s:TArrInt;//set of binary operations
    kP:integer;//cardinal of the set of variables
    kR:integer;//cardinal of the set of parameters
    kW:integer;//cardinal of the set of unary operations
    kV:integer;//cardinal of the set of binary operations
    kE:integer;// number of unit elements for binary operations
    Pnum:TArrInt;//vector of number nodes for variables
    Rnum:TArrInt;//vector of number nodes for parameters
    Enum:TArrInt;// number of unit elements for binary functions
    Dnum:TArrInt;//vector of number nodes for outputs
    ys:TArrReal;//vector of count
    yout:TarrReal;// output vector;
    ystr:TArrString;//string for mathematical expression
    BTree,BTree0:TArrInt;//Binary trees
    BTreeR:TArrReal;// results of calculations on Binary tree
    Constructor Create(Lay1,Mout1,kp1,kr1,kw1,kv1:integer);//create of BVGP
    Procedure SetVs(vs1:TArrReal);
    Procedure SetCs(cs1:TArrReal);
    Procedure SetO1s(o1s1:TArrInt);
    Procedure SetO2s(o2s1:TArrInt);
    Procedure SetE2s(o2s1:TArrInt);
    Procedure SetPnum(pnum1:TArrInt);
    Procedure SetRnum(rnum1:TArrInt);
    Procedure SetDnum(dnum1:TArrInt);
    Procedure SetBTreeBas(BTreeBas1:TArrInt);
    Procedure SetBtree(BTree2:TArrInt);
    Procedure GenVar(var w:TArr2Int);
    Procedure Variations(w:TArr2Int);
    Procedure BVGPControl;
    Procedure BtreetoPas;
    Procedure BtreetoTex;
    Procedure BtreetoPasStr;
    Procedure BtreetoTexStr;
    Procedure ReadBtree(var Btree2:TArrInt);
    Procedure ReadBtree0(var Btree2:TArrInt);
    Function F0(k:integer):real;
    Function F1(k:integer;z:real):real;
    Function F2(k:integer;z1,z2:real):real;
  end;

  { TGABVGP }

  TGABVGP=class(TObject)
    PopChrStr:TArrArrArr2Int;//array for structural parts of chromosomes
    PopChrPar:TArrArrInt;//array for perametrical parts of chromosomes
    HH:integer;// number of cromosomes in initial population
    RR:integer;// number of couples in one generation
    PP:integer;// number of generations
    nfu:integer;//number of functionals
    lchr:integer;//length of structural part of chromosome
    Epo:integer;//number of generations between epochs
    kel:integer;//number of elitared chromosomes
    Fuh:TArrArrReal;// values of functionals for each chromosome
    FuhNorm:TArrArrReal;
    Lh:TArrInt;// values distance to Pareto set
    Pareto:TArrInt;// Pareto set
    Fuhminm:TArrArrReal;//minimai values on generation
    Son1s,Son2s,Son3s,Son4s:TArrArr2Int;//structural part of sons
    Son1p,Son2p,Son3p,Son4p:TArrInt;//parametrical part of sons
    L1,L2,L3,L4:integer;//values distance to Pareto set for sons
    Fu1,Fu2,Fu3,Fu4:TArrReal;// values of functionals for sons
    alfa:real;//parameter for select of parents
    pmut:real;//probability of mutation
    BVGP:TBVGP;// Network operator
    p:integer;// number of parameters
    c:integer;// number of bit for integer part
    d:integer;// number of bit for fractional part
    q:TArrReal;//vector of parameters
    zb:TArrInt;//additional vector
    EndGeneration:TProc;
    Constructor Create(hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,
                       Epo1,kel1:integer;alfa1,pmut1:real;
                       Lay1,Mout1,kp1,kr1,kw1,kv1:integer);
    Procedure GenAlgorithm;// genetic algorithm for structural-parametrical optimization
    Procedure GenAlgorithm1;// genetic algorithm for parametrical optimization
    Function Rast(Fu:TArrReal):integer;//distance to Pareto set
    Procedure GreytoVector(y:TArrInt);
    Procedure VectortoGrey(var y: TArrInt);
    Procedure ChoosePareto;
    Procedure ImproveChrom(q1:TArrReal;var StrChrom: TArrArr2Int);
    Procedure Setq(q1:TArrReal);
    Procedure SetPP(pp2:integer);
    Procedure ReadFunc(k:integer;var Fuh1:TArrReal);
    Procedure Readq(var q1:TArrReal);
    Procedure ReadChromosome(k:integer;var q1:TArrReal;var BTree1:TArrInt);
    Procedure Func0(var Fu:TArrReal); virtual;//Values of functionals
  end;

  { TModel }

  TModel=class(TGABVGP)
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
    sumixmax:real;
    Constructor Create(hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,
                       Epo1,kel1:integer;alfa1,pmut1:real;
                       Lay1,Mout1,kp1,kr1,kw1,kv1,n1,m1,ll1,ny1:integer);
    Procedure Euler2;
    Procedure Func(var Fu:TArrReal); virtual;
    Procedure Func0(var Fu:TArrReal); override;
    Procedure Initial;virtual;
    Procedure Viewer;virtual;
    Procedure Integr;
    Procedure Probab;
    Procedure LexPM(var ix1:tArrInt;var flag:boolean);
    Procedure OgrUpr;
    Procedure RP(t1:real;x1:TArrReal;var f1:TArrReal);virtual;//Right parts
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
    Function  OgrPhase: boolean;virtual;
  end;

//*************************************************************
                        IMPLEMENTATION
//*************************************************************
{ TModel }
//*************************************************************
Constructor TModel.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, Epo1,
  kel1: integer; alfa1, pmut1: real; Lay1, Mout1, kp1, kr1, kw1, kv1, n1, m1,
  ll1, ny1: integer);
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
  RP(t,x,fa);
  for i:=0 to n-1 do
    xs[i]:=x[i]+dt*fa[i];
  RP(t+dt,xs,fb);
  for i:=0 to n-1 do
    x[i]:=x[i]+dt*(fa[i]+fb[i])/2;
  t:=t+dt;
End;
//*********************************************************
Procedure TModel.Func(var Fu: TArrReal);
var
  i:integer;
Begin
  for i:=0 to nfu-1 do
    fu[i]:=0;
End;
//*********************************************************
Procedure TModel.Func0(var Fu: TArrReal);
var
  i:integer;
Begin
  //Probab;
  Integr;
  for i:=0 to nfu-1 do
    Fu[i]:=su[i];
End;
//*********************************************************
Procedure TModel.Initial;
var
  i:integer;
Begin
  for i:=0 to n-1 do
    x[i]:=x0[i];
  t:=0;
End;
//*********************************************************
Procedure TModel.Viewer;
Begin

End;
//*********************************************************
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
//*********************************************************
Procedure TModel.Probab;
var
  i,j:integer;
  flag:boolean;
  prob:real;
  sp:real;
Begin
  for i:=0 to ny-1 do
    ix[i]:=0;
  for i:=0 to nfu-1 do
    su[i]:=0;
  repeat
    sp:=1;
    for i:=0 to ny-1 do
      sp:=sp+ix[i];
    prob:=sp/sumixmax;
    for i:=0 to ny-1 do
      qy[i]:=qymin[i]+stepsqy[i]*ix[i];
    Func(su1);
    for i:=0 to nfu-1 do
      su[i]:=su[i]+prob*su1[i];
    LexPM(ix,flag);
  until not flag;
End;
//*********************************************************
Procedure TModel.LexPM(var ix1: tArrInt; var flag: boolean);
var
  i,j:integer;
Begin
  i:=ny-1;
  while (i>=0)and(ix[i]=ixmax[i]) do i:=i-1;
  if i>=0 then
  begin
    ix[i]:=ix[i]+1;
    for j:=i+1 to ny-1 do
      ix[j]:=0;
    flag:=true;
  end
  else
    flag:=false;
End;
//*********************************************************
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
//*********************************************************
Procedure TModel.RP(t1: real; x1: TArrReal; var f1: TArrReal);
const
  TT=0.5;
  ksi=0.09;
  ko=1;
var
  i:integer;
Begin
  Upr;
  f1[0]:=x[1];
  f1[1]:=-2*ksi*(x[1])/TT+(ko*u[0]-x[0])/sqr(TT);
  for i:=0 to n-1 do
    if abs(f1[i])>infinity then
      f1[i]:=Ro_10(f1[i])*infinity;
End;
//*********************************************************
Procedure TModel.Setdt(dt1: real);
Begin
  dt:=dt1;
End;
//*********************************************************
Procedure TModel.Setixmax(ix1: TArrInt);
var
  i:integer;
  flag:boolean;
Begin
  sumixmax:=0;
  for i:=0 to ny-1 do
    ixmax[i]:=ix1[i];
  for i:= 0 to ny-1 do
    ix[i]:=0;
  repeat
    sumixmax:=sumixmax+1;
    for i:= 0 to ny-1 do
      sumixmax:=sumixmax+ix[i];
    LexPM(ix,flag);
  until not flag;
End;
//*********************************************************
Procedure TModel.Setqymax(qymax1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to ny-1 do
    qymax[i]:=qymax1[i];
End;
//*********************************************************
Procedure TModel.Setqymin(qymin1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to ny-1 do
  begin
    qymin[i]:=qymin1[i];
    qy[i]:=qymin[i];
  end;
End;
//*********************************************************
Procedure TModel.Setstepsqy(stepsqy1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to ny-1 do
    stepsqy[i]:=stepsqy1[i];
End;
//*********************************************************
Procedure TModel.Settf(tf1: real);
Begin
  tf:=tf1;
End;
//*********************************************************
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
//*********************************************************
Procedure TModel.Setx0(x01: TArrReal);
var
  i:integer;
Begin
  for i:=0 to n-1 do
    x0[i]:=x01[i];
End;
//*********************************************************
Procedure TModel.Setshtraf(s1: real);
Begin

End;
//*********************************************************
Procedure TModel.Upr;
Begin
  u[0]:=1;
End;
//*********************************************************
Function TModel.OgrPhase: boolean;
Begin

End;
//*************************************************************

{ TGABVGP }
//*************************************************************
constructor TGABVGP.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, Epo1,
  kel1: integer; alfa1, pmut1: real; Lay1, Mout1, kp1, kr1, kw1, kv1: integer);
Begin
  HH:=hh1;      //number of chromosomes in an initial population
  PP:=pp1;      // number of generations
  RR:=rr1;      // number of couples in one generation
  nfu:=nfu1;    // number of functionals
  lchr:=lchr1;  //number of variations in one chromosome
  p:=p1;        //number of serching parameters
  c:=c1;        //number of bits for integer part
  d:=d1;        //number of bits for fractional part
  Epo:=Epo1;    // number of ganerations between exchange of basic NOM
  kel:=kel1;    // number of elitaring chromosomes
  alfa:=alfa1;  // parameter for crossover
  pmut:=pmut1;  // probability of mutation
  BVGP:=TBVGP.Create(Lay1,Mout1,kp1,kr1,kw1,kv1);
  // PopChrStr:TArrArrArr2Int;//array for structural parts of chromosomes
  // PopChrPar:TArrArrInt;//array for perametrical parts of chromosomes
  Setlength(PopChrStr,HH,lchr); 
  Setlength(PopChrPar,HH,p*(c+d));
  Setlength(Fuh,HH,nfu);
  SetLength(FuhNorm,HH,nfu);
  Setlength(Lh,HH);
  Setlength(Fu1,nfu);
  Setlength(Fu2,nfu);
  Setlength(Fu3,nfu);
  Setlength(Fu4,nfu);
  Setlength(Son1s,lchr);
  Setlength(Son2s,lchr);
  Setlength(Son3s,lchr);
  Setlength(Son4s,lchr);
  Setlength(Son1p,p*(c+d));
  Setlength(Son2p,p*(c+d));
  Setlength(Son3p,p*(c+d));
  Setlength(Son4p,p*(c+d));
  SetLength(q,p);
  SetLength(zb,p*(c+d));
End;
//*************************************************************
Procedure TGABVGP.GenAlgorithm;
// Генетический алгоритм
var
  i,j,k,pt,rt,k1,k2,lmax,imax,ks1,ks2:integer;
  ksi,su,su1,Fumax,Fumin:real;
Begin
  //генерация популяции
  VectortoGrey(PopChrPar[0]);
  for i:=0 to lchr-1 do
    for j:=0 to 1 do
      PopChrStr[0,i,j]:=0;
  for i:=1 to HH-1 do
  begin
    for j:=0 to lchr-1 do
      BVGP.GenVar(PopChrStr[i,j]);
    for j:=0 to p*(c+d)-1 do
      PopChrPar[i,j]:=random(2);
  end;
  //вычисление значений функционалов для каждой хромосомы
  for i:=0 to HH-1 do
  begin
    BVGP.SetBTree(BVGP.BTree0);
    for j:=0 to lchr-1 do
      BVGP.Variations(PopChrStr[i,j]);
    GreytoVector(PopChrPar[i]);
    Func0(Fuh[i]);
  end;
  //вычисление расстояний до множества Парето
  for i:=0 to HH-1 do
    Lh[i]:=Rast(Fuh[i]);
  //начало цикла поколений
  pt:=1;  // первое текущее поколение
  repeat
    //начало цикла скрещивания
    rt:=1;//первая пара скрещивания
    repeat
      //отбор двух родителей
      k1:=random(HH);
      k2:=random(HH);
      ksi:=random;
      if (ksi<(1+alfa*Lh[k1])/(1+Lh[k1])) or
         (ksi<(1+alfa*Lh[k2])/(1+Lh[k2])) then
      begin
        //если условие скрещивания выполнено
        ks1:=random(lchr);
        ks2:=random(p*(c+d));
        //скрещивание, получение 4 потомков
        for i:=0 to lchr-1 do
        begin
          Son1s[i]:=PopChrStr[k1,i];
          Son2s[i]:=PopChrStr[k2,i];
        end;
        for i:=0 to ks2-1 do
        begin
          Son1p[i]:=PopChrPar[k1,i];
          Son2p[i]:=PopChrPar[k2,i];
          Son3p[i]:=PopChrPar[k1,i];
          Son4p[i]:=PopChrPar[k2,i];

        end;
        for i:=ks2 to p*(c+d)-1 do
        begin
          Son1p[i]:=PopChrPar[k2,i];
          Son2p[i]:=PopChrPar[k1,i];
          Son3p[i]:=PopChrPar[k2,i];
          Son4p[i]:=PopChrPar[k1,i];
        end;
        for i:=0 to ks1-1 do
        begin
          Son3s[i]:=PopChrStr[k1,i];
          Son4s[i]:=PopChrStr[k2,i];
        end;
        for i:=ks1 to lchr-1 do
        begin
          Son3s[i]:=PopChrStr[k2,i];
          Son4s[i]:=PopChrStr[k1,i];
        end;
        //мутация для 1го потомка
        if random<pmut then
        begin
          son1p[random(p*(c+d))]:=random(2);
          BVGP.GenVar(son1s[random(lchr)]);
        end;
        //вычисление функционалов для 1го потомка
        BVGP.SetBTree(BVGP.BTree0);;
        for j:=0 to lchr-1 do
          BVGP.Variations(son1s[j]);
        GreytoVector(son1p);
        Func0(Fu1);
        //вычисление расстояния для 1го потомка
        L1:=Rast(Fu1);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if L1<Lmax then
        //если расстояние у 1го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son1s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son1p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fu1[i];
        end;
        //вычисляем все расстояния для популяции
        for i:=0 to HH-1 do
          Lh[i]:=Rast(Fuh[i]);
        //мутация для 2го потомка
        if random<pmut then
        begin
          son2p[random(p*(c+d))]:=random(2);
          BVGP.GenVar(son2s[random(lchr)]);
        end;
        //вычисление функционалов для 2го потомка
        BVGP.SetBTree(BVGP.BTree0);
        for j:=0 to lchr-1 do
          BVGP.Variations(son2s[j]);
        GreytoVector(son2p);
        Func0(Fu2);
        //вычисление расстояния для 2го потомка
        L2:=Rast(Fu2);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if L1<Lmax then
        //если расстояние у 2го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son2s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son2p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fu2[i];
        end;
        //вычисляем все расстояния для популяции
        for i:=0 to HH-1 do
          Lh[i]:=Rast(Fuh[i]);
        //мутация для 3го потомка
        if random<pmut then
        begin
          son3p[random(p*(c+d))]:=random(2);
          BVGP.GenVar(son3s[random(lchr)]);
        end;
        //вычисление функционалов для 3го потомка
        BVGP.SetBTree(BVGP.BTree0);
        for j:=0 to lchr-1 do
          BVGP.Variations(son1s[j]);
        GreytoVector(son1p);
        Func0(Fu3);
        //вычисление расстояния для 3го потомка
        L3:=Rast(Fu3);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if L3<Lmax then
        //если расстояние у 3го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son3s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son3p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fu3[i];
        end;
        //вычисляем все расстояния для популяции
        for i:=0 to HH-1 do
          Lh[i]:=Rast(Fuh[i]);
        //мутация для 4го потомка
        if random<pmut then
        begin
          son4p[random(p*(c+d))]:=random(2);
          BVGP.GenVar(son4s[random(lchr)]);
        end;
        //вычисление функционалов для 4го потомка
        BVGP.SetBTree(BVGP.BTree0);
        for j:=0 to lchr-1 do
          BVGP.Variations(son4s[j]);
        GreytoVector(son4p);
        Func0(Fu4);
        //вычисление расстояния для 4го потомка
        L4:=Rast(Fu4);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if L4<Lmax then
        //если расстояние у 4го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son4s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son4p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fu4[i];
        end;
        //вычисляем все расстояния для популяции
        for i:=0 to HH-1 do
          Lh[i]:=Rast(Fuh[i]);
      end;
      rt:=rt+1;
      //конец цикла скрещивания
    until rt>RR;
    // генерируем новые хромосомы
    //проверка конца эпохи
    for i:=0 to nfu-1 do
    begin
      su:=Fuh[0,i];
      for j:= 1 to HH-1 do
        if Fuh[j,i]<su then
          su:=Fuh[j,i];
      Fuhminm[i,pt-1]:=su;
    end;
    pt:=pt+1;
    //если эпоха закончилась, то необходимо сменить базис
    if pt mod Epo=0 then
    begin
      //...на наиболее близкую хромосому к утопической
      // хромосоме в пространстве нормированных криетриев
      for i:=0 to nfu-1 do
      begin
        Fumax:=Fuh[0,i];
        Fumin:=Fuh[0,i];
        // ищем максимальное и минимальное значения по каждому функционалу
        for k:=0 to HH-1 do
          if Fuh[k,i]>Fumax then
            Fumax:=Fuh[k,i]
          else
            if Fuh[k,i]< Fumin then
              Fumin:=Fuh[k,i];
        // нормируем критерии, поделив каждое значение на разность между
        // максимумом и минимумом
        if Fumax<>Fumin then
          for k:=0 to HH-1 do
            FuhNorm[k,i]:=Fuh[k,i]/(Fumax-Fumin);
      end;
      // находим хромосому с наименьшей величиной нормы нормированных критериев
      k:=0;
      su:=0;
      for i:=0 to nfu-1 do
        su:=su+sqr(FuhNorm[0,i]);
      su:=sqrt(su);
      for i:=1 to HH-1 do
      begin
        su1:=0;
        for j:=0 to nfu-1 do
          su1:=su1+sqr(FuhNorm[i,j]);
        su1:=sqrt(su1);
        if su1<su then
        begin
          su:=su1;
          k:=i;
        end;
      end;
      // заменяем базис
      // строим матрицу для найденной хромосомы
      BVGP.SetBTree(BVGP.BTree0);
      for j:=0 to lchr-1 do
        BVGP.Variations(PopChrStr[k,j]);
      // меняем базисную матрицу на новую
      BVGP.SetBTreeBas(BVGP.BTree);
      //генерируем тождественную хромосому
      for i:=0 to lchr-1 do
        for j:=0 to 1 do
          PopChrStr[0,i,j]:=0;
      for i:=0 to p*(c+d)-1 do
        PopChrPar[0,i]:=PopChrPar[k,i];
      //вычисляем все фунционалы для всей популяции
      for i:=0 to HH-1 do
      begin
        BVGP.SetBTree(BVGP.BTree0);
        for j:=0 to lchr-1 do
          BVGP.Variations(PopChrStr[i,j]);
        GreytoVector(PopChrPar[i]);
        Func0(Fuh[i]);
      end;
      // формируем элиту
      for i:=0 to kel-1 do
      begin
        j:=random(HH-1)+1;
        GreytoVector(PopChrPar[j]);
        ImproveChrom(q,PopChrStr[j]);
      end;
      //вычисляем новые расстояния
      for i:=0 to HH-1 do
        Lh[i]:=Rast(Fuh[i]);
    end;
    //конец цикла поколений
    EndGeneration;
//    form1.ProgressBar1.StepIt;
//    Form1.Refresh;
  until pt>PP;
  ChoosePareto;
 //строим множество Парето
End;
//*************************************************************
procedure TGABVGP.GenAlgorithm1;
// Генетический алгоритм для поиска оптимальных значений параметров
var
  i,j,pt,rt,k1,k2,lmax,imax,ks2:integer;
  ksi:real;
Begin
  //генерация популяции
  BVGP.SetBTreeBas(BVGP.BTree);
  VectortoGrey(PopChrPar[0]);
  for i:=1 to HH-1 do
  begin
    for j:=0 to p*(c+d)-1 do
      PopChrPar[i,j]:=random(2);
  end;
  //вычисление значений функционалов для каждой хромосомы
  for i:=0 to HH-1 do
  begin
    GreytoVector(PopChrPar[i]);
    Func0(Fuh[i]);
  end;
  //вычисление расстояний до множества Парето
  for i:=0 to HH-1 do
    Lh[i]:=Rast(Fuh[i]);
  //начало цикла поколений
  pt:=1;  // первое текущее поколение
  repeat
    //начало цикла скрещивания
    rt:=1;//первая пара скрещивания
    repeat
      //отбор двух родителей
      k1:=random(HH);
      k2:=random(HH);
      ksi:=random;
      if (ksi<(1+alfa*Lh[k1])/(1+Lh[k1])) or
         (ksi<(1+alfa*Lh[k2])/(1+Lh[k2])) then
      begin
        //если условие скрещивания выполнено
        ks2:=random(p*(c+d));
        //скрещивание, получение 2-х потомков
        for i:=0 to ks2-1 do
        begin
          Son1p[i]:=PopChrPar[k1,i];
          Son2p[i]:=PopChrPar[k2,i];
        end;
        for i:=ks2 to p*(c+d)-1 do
        begin
          Son1p[i]:=PopChrPar[k2,i];
          Son2p[i]:=PopChrPar[k1,i];
        end;
        //мутация для 1го потомка
        if random<pmut then
          son1p[random(p*(c+d))]:=random(2);
        //вычисление функционалов для 1го потомка
        GreytoVector(son1p);
        Func0(Fu1);
        //вычисление расстояния для 1го потомка
        L1:=Rast(Fu1);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if L1<Lmax then
        //если расстояние у 1го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son1p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fu1[i];
        end;
        //вычисляем все расстояния для популяции
        for i:=0 to HH-1 do
          Lh[i]:=Rast(Fuh[i]);
        //мутация для 2го потомка
        if random<pmut then
          son2p[random(p*(c+d))]:=random(2);
        //вычисление функционалов для 2го потомка
        GreytoVector(son2p);
        Func0(Fu2);
        //вычисление расстояния для 2го потомка
        L2:=Rast(Fu2);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if L1<Lmax then
        //если расстояние у 2го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son2p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fu2[i];
        end;
        //вычисляем все расстояния для популяции
        for i:=0 to HH-1 do
          Lh[i]:=Rast(Fuh[i]);
      end;
      rt:=rt+1;
      //конец цикла скрещивания
    until rt>RR;
    // генерируем новые хромосомы
    //проверка конца эпохи
    pt:=pt+1;
    //конец цикла поколений
    EndGeneration;
  until pt>PP;
  ChoosePareto;
 //строим множество Парето
End;
//*************************************************************
function TGABVGP.Rast(Fu: TArrReal): integer;
var i,j,k,count:integer;
Begin
  count:=0;
  for i:=0 to HH-1 do
  begin
    j:=0;
    while (j<nfu) and (Fu[j]>=Fuh[i,j]) do j:=j+1;
    if j>=nfu then
    begin
      k:=0;
      while (k<nfu) and (Fu[k]=Fuh[i,k]) do k:=k+1;
      if k<nfu then count:=count+1;
    end;
  end;
  result:=count;
End;
//*************************************************************
procedure TGABVGP.GreytoVector(y: TArrInt);
var
  i,j,l_1,l:integer;
  g,g1:real;
Begin
  l:=c+d;
  l_1:=high(y)+1;
  for i:=0 to l_1-1 do
    if i mod l=0 then
      zb[i]:=y[i]
    else
      zb[i]:=zb[i-1] xor y[i];
  j:=-1;
  g1:=1;
  g:=1;
  for i:=0 to c-2 do
    g1:=g1*2;
  for i:=0 to l_1-1 do
  begin
    if i mod l=0 then
    begin
      j:=j+1;
      q[j]:=0;
      g:=g1;
    end;
    q[j]:=q[j]+g*zb[i];
    g:=g/2;
  end;
End;
//*************************************************************
procedure TGABVGP.VectortoGrey(var y: TArrInt);
var
  x,i,j,k:integer;
  r:real;
Begin
  for i:=0 to p*(c+d)-1 do
    zb[i]:=0;
  for j:=0 to p-1 do
  begin
    x:=trunc(q[j]);
    r:=q[j]-x;
    k:=c+j*(c+d)-1;
    while k>=j*(c+d) do
    begin
      zb[k]:=x mod 2;
      x:=x div 2;
      k:=k-1;
    end;
    k:=c+j*(c+d);
    while k<(c+d)*(j+1) do
    begin
      r:=2*r;
      x:=trunc(r);
      zb[k]:=x;
      r:=r-x;
      k:=k+1;
    end;
    y[j*(c+d)]:=zb[j*(c+d)];
    for i:=j*(c+d)+1 to (j+1)*(c+d)-1 do
      y[i]:=zb[i] xor zb[i-1];
  end;
End;
//*************************************************************
procedure TGABVGP.ChoosePareto;
var
  i,j:integer;
Begin
  j:=0;
  for i:=0 to HH-1 do
    if Lh[i]=0 then
    begin
      j:=j+1;
      setlength(Pareto,j);
      Pareto[j-1]:=i;
    end;
End;
//*************************************************************
procedure TGABVGP.ImproveChrom(q1: TArrReal; var StrChrom: TArrArr2Int);
var
  i,j,k:integer;
  flag:boolean;
Begin
  BVGP.SetBTree(BVGP.BTree0);
  Func0(Fu1);
  k:=-1;
  for i:=0 to lchr-1 do
  begin
    BVGP.Variations(StrChrom[i]);
    Func0(Fu2);
    flag:=true;
    for j:=0 to nfu-1 do
      if Fu2[j]>Fu1[j] then flag:=false;
    if flag then
    begin
      for j:=0 to nfu-1 do
        Fu1[j]:=Fu2[j];
      k:=i;
    end;
  end;
  for i:=k+1 to lchr-1 do
    for j:=0 to 3 do
      StrChrom[i,j]:=0;
End;
//*************************************************************
Procedure TGABVGP.Setq(q1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to p-1 do
    q[i]:=q1[i];
End;
//*************************************************************
Procedure TGABVGP.SetPP(pp2: integer);
Begin
  PP:=pp2;
  SetLength(Fuhminm,nfu,PP);
End;

//*************************************************************
procedure TGABVGP.ReadFunc(k: integer; var Fuh1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to nfu-1 do
    Fu1[i]:=Fuh[k,i];
End;
//*************************************************************
procedure TGABVGP.Readq(var q1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to p-1 do
    q1[i]:=q[i];
End;
//*************************************************************
procedure TGABVGP.ReadChromosome(k: integer; var q1: TArrReal;
  var BTree1: TArrInt);
var
  i:integer;
Begin
  BVGP.SetBTree(BVGP.BTree0);
  for i:=0 to lchr-1 do
    BVGP.Variations(PopChrStr[k,i]);
  GreytoVector(PopChrPar[k]);
  Readq(q1);
  BVGP.ReadBTree(BTree1);
End;
//*************************************************************
procedure TGABVGP.Func0(var Fu: TArrReal);
var
  i:integer;
Begin
  i:=0;
End;

//*************************************************************
                        { TBVGP }
//*************************************************************
constructor TBVGP.Create(Lay1, Mout1, kp1, kr1, kw1, kv1: integer);
var
  knode,i,j:integer;
Begin
  Lay:=Lay1;
  Mout:=Mout1;
  kP:=kp1;
  kR:=kr1;
  kW:=kw1;
  kV:=kv1;
  kE:=kV1;
  kol:=1;
  knode:=1;
  for i:=0 to Lay -1 do
  begin
    knode:=2*knode;
    kol:=kol+2*knode;
  end;
  Setlength(Btree0,kol);
  Setlength(Btree,kol);
  Setlength(BtreeR,kol);
  SetLength(O1s,kW);
  SetLength(O2s,kV);
  Setlength(E2s,kV);
  Setlength(Vs,kP);
  Setlength(Cs,kR);
  SetLength(Dnum,mout);
  SetLength(Pnum,kP);
  SetLength(Rnum,kR);
  SetLength(yout,mout);
End;
//*************************************************************
Procedure TBVGP.SetVs(vs1: TArrReal);
var i:integer;
Begin
  for i:=0 to high(vs1) do
    vs[i]:=vs1[i];
End;
//*************************************************************
Procedure TBVGP.SetCs(cs1: TArrReal);
var i:integer;
Begin
  for i:=0 to high(Cs1) do
    Cs[i]:=Cs1[i];
End;
//*************************************************************
Procedure TBVGP.SetO1s(o1s1: TArrInt);
var i:integer;
Begin
  for i:=0 to high(O1s1) do
    O1s[i]:=O1s1[i];
End;
//*************************************************************
Procedure TBVGP.SetO2s(o2s1: TArrInt);
var i:integer;
Begin
  for i:=0 to high(o2s1) do
  begin
    O2s[i]:=o2s1[i];
//    E2s[i]:=E2c[o2s1[i]];
  end;
End;
//*************************************************************
Procedure TBVGP.SetE2s(o2s1: TArrInt);
var
  i:integer;
Begin
  for i:=0 to kv-1 do
  case o2s1[i] of
    1,5,6,7:E2s[i]:=0;
    2,8:E2s[i]:=1;
    3:E2s[i]:=infinity;
    4:E2s[i]:=-infinity;
  end;
End;

//*************************************************************
procedure TBVGP.SetPnum(pnum1: TArrInt);
var i:integer;
Begin
  for i:=0 to high(pnum1) do
   Pnum[i]:=Pnum1[i];
End;
//*************************************************************
procedure TBVGP.SetRnum(rnum1: TArrInt);
var i:integer;
Begin
  for i:=0 to high(rnum1) do
   Rnum[i]:=Rnum1[i];
End;
//*************************************************************
procedure TBVGP.SetDnum(dnum1: TArrInt);
var i:integer;
Begin
  for i:=0 to high(dnum1) do
   Dnum[i]:=dnum1[i];
End;
//*************************************************************
procedure TBVGP.SetBTreeBas(BTreeBas1: TArrInt);
var i:integer;
Begin
  for i:=0 to high(BTreeBas1) do
    BTree0[i]:=BTreeBas1[i];
End;
//*************************************************************
procedure TBVGP.SetBtree(BTree2: TArrInt);
var i:integer;
Begin
  for i:=0 to high(BTree2) do
    BTree[i]:=BTree2[i];
End;
//*************************************************************
procedure TBVGP.GenVar(var w: TArr2Int);
var
  k,kNode,i,j,k0,k1:integer;
  flag:boolean;
Begin
  k:=random(kol);
  w[0]:=k;
  kNode:=1;
  for i:=0 to Lay-1 do
    kNode:=kNode*2;
  k0:=kol-kNode;
  if k0<=k then
    w[1]:=random(kP+kR+kV+1)
  else
  begin
    flag:=false;
    repeat
      k1:=k0;
      k0:=k1-kNode;
      if (k0<=k)and (k<k1) then
      begin
        w[1]:=O1s[random(kW)];
        flag:=true;
      end
      else
      begin
        kNode:=kNode div 2;
        k1:=k0;
        k0:=k1-kNode;
        if (k0<=k)and (k<k1) then
        begin
          w[1]:=O2s[random(kV)];
          flag:=true;
        end;
      end;
    until flag;
  end;
End;
//*************************************************************
procedure TBVGP.Variations(w: TArr2Int);
Begin
  if (w[0]<>0)or(w[1]<>0) then
    Btree[w[0]]:=w[1];
End;
//*************************************************************
procedure TBVGP.BVGPControl;
var kNode,i,j,kStart:integer;
Begin
  kNode:=1;
  for i:=0 to Lay-1 do
    kNode:=kNode*2;
  kStart:=Kol-kNode;
  for i:=0 to kNode-1 do
    BTreeR[kStart+i]:=F0(BTree[kStart+i]);
  for j:=0 to Lay-1 do
  begin
    kStart:=kStart-kNode;
    for i:=0 to kNode-1 do
      BTreeR[kStart+i]:=F1(BTree[kStart+i],BTreeR[kStart+kNode+i]);
    kNode:=kNode div 2;
    kStart:=kStart-kNode;
    for i:=0 to kNode-1 do
      BTreeR[kStart+i]:=F2(BTree[kStart+i],BTreeR[kStart+kNode+2*i],
                          BTreeR[kStart+kNode+2*i+1]);
  end;
  for i:=0 to Mout-1 do
    yout[i]:=BtreeR[dnum[i]];
End;
//*************************************************************
procedure TBVGP.BtreetoPas;
var
    i:integer;
Begin

End;
//*************************************************************
procedure TBVGP.BtreetoTex;
Begin

End;
//*************************************************************
procedure TBVGP.BtreetoPasStr;
Begin

End;
//*************************************************************
procedure TBVGP.BtreetoTexStr;
Begin

End;
//*************************************************************
procedure TBVGP.ReadBtree(var Btree2: TArrInt);
var
  i:integer;
Begin
  for i:=0 to high(BTree) do
    Btree2[i]:=Btree[i];
End;
//*************************************************************
procedure TBVGP.ReadBtree0(var Btree2: TArrInt);
var
  i:integer;
Begin
  for i:=0 to high(BTree0) do
    Btree2[i]:=Btree0[i];
End;
//*************************************************************
Function TBVGP.F0(k: integer): real;
var
  kl:integer;
Begin
  kl:=k mod (kP+kR+kV);
  if kl<kP then
    Result:=Vs[k]
  else
    if kl<kP+kR then
      Result:=Cs[k-kP]
    else
      Result:=E2s[kl-kP-kR];
End;
//*************************************************************
function TBVGP.F1(k: integer; z: real): real;
Begin
  case k of
    1: Result:=Ro_1(z);
    2: Result:=Ro_2(z);
    3: Result:=Ro_3(z);
    4: Result:=Ro_4(z);
    5: Result:=Ro_5(z);
    6: Result:=Ro_6(z);
    7: Result:=Ro_7(z);
    8: Result:=Ro_8(z);
    9: Result:=Ro_9(z);
    10: Result:=Ro_10(z);
    11: Result:=Ro_11(z);
    12: Result:=Ro_12(z);
    13: Result:=Ro_13(z);
    14: Result:=Ro_14(z);
    15: Result:=Ro_15(z);
    16: Result:=Ro_16(z);
    17: Result:=Ro_17(z);
    18: Result:=Ro_18(z);
    19: Result:=Ro_19(z);
    20: Result:=Ro_20(z);
    21: Result:=Ro_21(z);
    22: Result:=Ro_22(z);
    23: Result:=Ro_23(z);
    24: Result:=Ro_24(z);
    25: Result:=Ro_25(z);
    26: Result:=Ro_26(z);
    27: Result:=Ro_27(z);
    28: Result:=Ro_28(z);
  end;
End;
//*************************************************************
function TBVGP.F2(k: integer; z1, z2: real): real;
Begin
  case k of
    1: Result:=Xi_1(z1,z2);
    2: Result:=Xi_2(z1,z2);
    3: Result:=Xi_3(z1,z2);
    4: Result:=Xi_4(z1,z2);
    5: Result:=Xi_5(z1,z2);
    6: Result:=Xi_6(z1,z2);
    7: Result:=Xi_7(z1,z2);
    8: Result:=Xi_8(z1,z2);
  end;
End;
//*************************************************************
END.

