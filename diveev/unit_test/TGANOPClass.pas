UNIT TGANOPClass;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
Uses Classes, Calc3, SysUtils, TNetOperClass;

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

	TGANOP=class(TObject)
	PopChrStr:TArrArrArr4Int;//array for structural parts of chromosomes
	PopChrPar:TArrArrInt;//array for perametrical parts of chromosomes
	HH:integer;// number of cromosomes in initial population
	RR:integer;// number of couples in one generation
	PP:integer;// number of generations
	nfu:integer;//number of functionals
	lchr:integer;//length of structural part of chromosome
	Epo:integer;//number of generations between epochs
	kel:integer;//number of elitared chromosomes
	Fuh:TArrArrReal;// values of functionals for each chromosome
	Fuhminm:TArrArrReal;//minimai values on generation
	Lh:TArrInt;// values distance to Pareto set
	Pareto:TArrInt;// Pareto set
	Son1s,Son2s,Son3s,Son4s:TArrArr4Int;//structural part of sons
	Son1p,Son2p,Son3p,Son4p:TArrInt;//parametrical part of sons
	Lh1,Lh2,Lh3,Lh4:integer;//values distance to Pareto set for sons
	Fuh1,Fuh2,Fuh3,Fuh4:TArrReal;// values of functionals for sons
	FuhNorm:TArrArrReal;// values of normalized functionals for each chromosome
	alfa:real;//parameter for select of parents
	pmut:real;//probability of mutation
	NOP:TNetOper;// Network operator
	p:integer;//number of parameters
	c:integer;// number of bit for integer part
	d:integer;// number of bit for fractional part
	q:TArrReal;//vector of parameters
	zb:TArrInt;//additional vector
	ksearch:integer;// number of variants for parents
	flag_change:boolean;
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
	Procedure ImproveChrom(qq:TArrReal;var StrChrom: TArrArr4Int);
	Procedure Setq(q1:TArrReal);
	Procedure SetPP(pp2:integer);
	Procedure ReadFunc(k:integer;var fFu1:TArrReal);
	Procedure Readq(var q1:TArrReal);
	Procedure ReadChromosome(k:integer;var q1:TArrReal;var Psi1:TArrArrInt);
	Procedure Func0(var Fu:TArrReal); virtual;//Values of functionals
	end;
	const EpsFunc=0.001;

//*************************************************************
                        IMPLEMENTATION
//*************************************************************
{$R+}

//*************************************************************
Procedure TGANOP.ChoosePareto;
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
Constructor TGANOP.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, Epo1,
  kel1: integer; alfa1, pmut1: real; Lay1, Mout1, kp1, kr1, kw1, kv1: integer);
Begin
  Inherited Create;
  HH:=hh1;
  PP:=pp1;
  RR:=rr1;
  nfu:=nfu1;
  lchr:=lchr1;
  p:=p1;
  c:=c1;
  d:=d1;
  Epo:=epo1;
  kel:=kel1;
  alfa:=alfa1;
  pmut:=pmut1;
  NOP:=TNetOper.Create(Lay1, Mout1, kp1, kr1, kw1, kv1);
  Setlength(PopChrStr,HH,lchr);
  Setlength(PopChrPar,HH,p*(c+d));
  Setlength(Fuh,HH,nfu);
  Setlength(FuhNorm,HH,nfu);
  Setlength(Lh,HH);
  Setlength(Fuh1,nfu);
  Setlength(Fuh2,nfu);
  Setlength(Fuh3,nfu);
  Setlength(Fuh4,nfu);
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
procedure TGANOP.Func0(var Fu: TArrReal);
var
  i:integer;
Begin
  NOP.RPControl;
  for i:=0 to nfu-1 do
    Fu[i]:=NOP.z[NOP.Dnum[i]];
End;
//*************************************************************
Procedure TGANOP.GenAlgorithm;
// Генетический алгоритм
var
  i,j,k,pt,rt,k1,k2,lmax,imax,ks1,ks2,lhmin:integer;
  ksi,su,su1,Fumax,Fumin:real;
Begin
  //generating population
  NOP.SetPsiBas(NOP.Psi);
  VectortoGrey(PopChrPar[0]);
  for i:=0 to lchr-1 do
    for j:=0 to 3 do
      PopChrStr[0,i,j]:=0;
  for i:=1 to HH-1 do
  begin
    for j:=0 to lchr-1 do
      NOP.GenVar(PopChrStr[i,j]);
    for j:=0 to p*(c+d)-1 do
      PopChrPar[i,j]:=random(2);
  end;
  // calculating values of functionals
  for i:=0 to HH-1 do
  begin
    NOP.SetPsi(NOP.Psi0);
    for j:=0 to lchr-1 do
      NOP.Variations(PopChrStr[i,j]);
    GreytoVector(PopChrPar[i]);
    Func0(Fuh[i]);
  end;
  //calculating of distances to Pareto set
  for i:=0 to HH-1 do
    Lh[i]:=Rast(Fuh[i]);
  //Start of cycle for generations
  pt:=1;  // first current generation
  repeat
    //start of cycle for crossovering
    rt:=1;//first couple for crossoving
    repeat
      //select of two parents
      k1:=random(HH);
      lhmin:=Lh[k1];
      for i:=0 to ksearch-1 do
      begin
        ks1:=random(HH);
        if Lh[ks1]<lhmin then
        begin
          k1:=ks1;
          lhmin:=Lh[ks1];
        end;
      end;
      k2:=random(HH);
      ksi:=random;
      if (ksi<(1+alfa*Lh[k1])/(1+Lh[k1])) or
         (ksi<(1+alfa*Lh[k2])/(1+Lh[k2])) then
      begin
        //if it is true
        ks1:=random(lchr);
        ks2:=random(p*(c+d));
        //crossoving, creating four sons
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
        //mutation for 1st son
        if random<pmut then
        begin
          son1p[random(p*(c+d))]:=random(2);
          NOP.GenVar(son1s[random(lchr)]);
        end;
        //functional for 1st son
        NOP.SetPsi(NOP.Psi0);;
        for j:=0 to lchr-1 do
          NOP.Variations(son1s[j]);
        GreytoVector(son1p);
        Func0(Fuh1);
        //Distance for 1st son
        Lh1:=Rast(Fuh1);
        //Chromosome with biggest distance to Pareto set
        Lmax:=Lh[1];
        imax:=1;
        for i:=2 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if Lh1<Lmax then
        //if distance to Pareto set 1st son is less than biggest distance
        //...in population then make substitution
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son1s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son1p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fuh1[i];
          //calculating all distances for population
          for i:=0 to HH-1 do
            Lh[i]:=Rast(Fuh[i]);
        end;
        //mutation for 2nd son
        if random<pmut then
        begin
          son2p[random(p*(c+d))]:=random(2);
          NOP.GenVar(son2s[random(lchr)]);
        end;
        //functional for 2nd son
        NOP.SetPsi(NOP.Psi0);
        for j:=0 to lchr-1 do
          NOP.Variations(son2s[j]);
        GreytoVector(son2p);
        Func0(Fuh2);
        //Distance for 2nd son
        Lh2:=Rast(Fuh2);
        //Chromosome with biggest distance to Pareto set
        Lmax:=Lh[1];
        imax:=1;
        for i:=2 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if Lh2<Lmax then
        //if distance to Pareto set 2nd son is less than biggest distance
        //...in population then make substitution
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son2s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son2p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fuh2[i];
          //calculating all distances for population
          for i:=0 to HH-1 do
            Lh[i]:=Rast(Fuh[i]);
        end;
        //mutation for 3rd son
        if random<pmut then
        begin
          son3p[random(p*(c+d))]:=random(2);
          NOP.GenVar(son3s[random(lchr)]);
        end;
        //functional for 3rd son
        NOP.SetPsi(NOP.Psi0);
        for j:=0 to lchr-1 do
          NOP.Variations(son3s[j]);
        GreytoVector(son3p);
        Func0(Fuh3);
        //Distance for 3rd son
        Lh3:=Rast(Fuh3);
        //Chromosome with biggest distance to Pareto set
        Lmax:=Lh[1];
        imax:=1;
        for i:=2 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if Lh3<Lmax then
        //if distance to Pareto set 3rd son is less than biggest distance
        //...in population then make substitution
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son3s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son3p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fuh3[i];
          //calculating all distances for population
          for i:=0 to HH-1 do
            Lh[i]:=Rast(Fuh[i]);
        end;
        //mutation for 4th son
        if random<pmut then
        begin
          son4p[random(p*(c+d))]:=random(2);
          NOP.GenVar(son4s[random(lchr)]);
        end;
        //functional for 4th son
        NOP.SetPsi(NOP.Psi0);
        for j:=0 to lchr-1 do
          NOP.Variations(son4s[j]);
        GreytoVector(son4p);
        Func0(Fuh4);
        //Distance for 4th son
        Lh4:=Rast(Fuh4);
        //Chromosome with biggest distance to Pareto set
        Lmax:=Lh[1];
        imax:=1;
        for i:=2 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if Lh4<Lmax then
        //if distance to Pareto set 4th son is less than biggest distance
        //...in population then make substitution
        begin
          for i:=0 to lchr-1 do
            PopChrStr[imax,i]:=son4s[i];
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son4p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fuh4[i];
          //calculating all distances for population
          for i:=0 to HH-1 do
            Lh[i]:=Rast(Fuh[i]);
        end;
      end;
      rt:=rt+1;
      //End of cycle for crossoving
    until rt>RR;
    // generating new chromosomes
    // Checking Epoch
   { for i:=0 to nfu-1 do
    begin
      su:=Fuh[0,i];
      for j:= 1 to HH-1 do
        if Fuh[j,i]<su then
          su:=Fuh[j,i];
      Fuhminm[i,pt-1]:=su;
    end; }
    pt:=pt+1;
    //if epoch is over then changing basic
    for i:=0 to HH-1 do
      Lh[i]:=Rast(Fuh[i]);
    ChoosePareto;
    if pt mod Epo=0 then
    begin
      //... на наиболее близкую хромосому к утопической
      // хромосоме в пространстве нормированных криетриев
      flag_change:=true;
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
        if abs(Fumax-Fumin)>1/infinity then
          for k:=0 to HH-1 do
            FuhNorm[k,i]:=(Fuh[k,i]-Fumin)/(Fumax-Fumin)
        else
          Flag_change:=false;
      end;
      if flag_change then
      begin
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
        NOP.SetPsi(NOP.Psi0);
        for j:=0 to lchr-1 do
          NOP.Variations(PopChrStr[k,j]);
        // меняем базисную матрицу на новую
        NOP.SetPsiBas(NOP.Psi);
        //генерируем тождественную хромосому
        for i:=0 to lchr-1 do
          for j:=0 to 3 do
            PopChrStr[0,i,j]:=0;
        for i:=0 to p*(c+d)-1 do
          PopChrPar[0,i]:=PopChrPar[k,i];
      end
      else
      begin
        //Если не меняем базис, то генерируем новую популяцию
        for i:=1 to HH-1 do
        begin
          if Lh[i]<>0 then
          begin
            for j:=0 to lchr-1 do
              NOP.GenVar(PopChrStr[i,j]);
            for j:=0 to p*(c+d)-1 do
              PopChrPar[i,j]:=random(2);
          end
          else
          begin
            k1:=0;
            for j:=0 to i-1 do
              if Lh[j]=0 then
              begin
                su:=0;
                for k:=0 to nfu-1 do
                  su:=su+abs(Fuh[i,k]-Fuh[j,k]);
                if su<epsFunc then
                begin
                  for k:=0 to lchr-1 do
                    NOP.GenVar(PopChrStr[i,k]);
                  for k:=0 to p*(c+d)-1 do
                    PopChrPar[i,k]:=random(2);
                  continue;
                end;
              end;
          end;
        end;
      end;
      //вычисляем все фунционалы для всей популяции
      for i:=0 to HH-1 do
      begin
        NOP.SetPsi(NOP.Psi0);
        for j:=0 to lchr-1 do
          NOP.Variations(PopChrStr[i,j]);
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
Procedure TGANOP.GenAlgorithm1;
// Генетический алгоритм для поиска оптимальных значений параметров
var
  i,j,pt,rt,k1,k2,lmax,imax,ks2,lhmin:integer;
  ksi:real;
Begin
  //генерация популяции
  NOP.SetPsiBas(NOP.Psi);
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
      lhmin:=Lh[k1];
      for i:=0 to ksearch-1 do
      begin
        ks2:=random(HH);
        if Lh[ks2]<lhmin then
        begin
          k1:=ks2;
          lhmin:=Lh[ks2];
        end;
      end;
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
        Func0(Fuh1);
        //вычисление расстояния для 1го потомка
        Lh1:=Rast(Fuh1);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if Lh1<Lmax then
        //если расстояние у 1го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son1p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fuh1[i];
        end;
        //вычисляем все расстояния для популяции
        for i:=0 to HH-1 do
          Lh[i]:=Rast(Fuh[i]);
        //мутация для 2го потомка
        if random<pmut then
          son2p[random(p*(c+d))]:=random(2);
        //вычисление функционалов для 2го потомка
        GreytoVector(son2p);
        Func0(Fuh2);
        //вычисление расстояния для 2го потомка
        Lh2:=Rast(Fuh2);
        //нахождение хромосомы с наибольшим расстоянием
        Lmax:=Lh[0];
        imax:=0;
        for i:=1 to HH-1 do
          if Lh[i]>Lmax then
          begin
            Lmax:=Lh[i];
            imax:=i;
          end;
        if Lh2<Lmax then
        //если расстояние у 2го потомка меньше, чем наибольшее, то
        //...осуществляем замену
        begin
          for i:=0 to p*(c+d)-1 do
            PopChrPar[imax,i]:=son2p[i];
          for i:=0 to nfu-1 do
            Fuh[imax,i]:=Fuh2[i];
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
Procedure TGANOP.GreytoVector(y: TArrInt);
var
  i,j,lf1,l:integer;
  g,g1:real;
Begin
  l:=c+d;
  lf1:=high(y)+1;
  for i:=0 to lf1-1 do
    if i mod l=0 then
      zb[i]:=y[i]
    else
      zb[i]:=zb[i-1] xor y[i];
  j:=-1;
  g1:=1;
  g:=1;
  for i:=0 to c-2 do
    g1:=g1*2;
  for i:=0 to lf1-1 do
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
procedure TGANOP.ImproveChrom(qq: TArrReal; var StrChrom: TArrArr4Int);
var
  i,j,k:integer;
  flag:boolean;
Begin
  NOP.SetPsi(NOP.Psi0);
  Func0(Fuh1);
  k:=-1;
  for i:=0 to lchr-1 do
  begin
    NOP.Variations(StrChrom[i]);
    Func0(Fuh2);
    flag:=true;
    for j:=0 to nfu-1 do
      if Fuh2[j]>Fuh1[j] then flag:=false;
    if flag then
    begin
      for j:=0 to nfu-1 do
        Fuh1[j]:=Fuh2[j];
      k:=i;
    end;
  end;
  for i:=k+1 to lchr-1 do
    for j:=0 to 3 do
      StrChrom[i,j]:=0;
End;
//*************************************************************
function TGANOP.Rast(Fu: TArrReal): integer;
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
procedure TGANOP.ReadChromosome(k: integer; var q1: TArrReal;
  var Psi1: TArrArrInt);
var
  i:integer;
Begin
  NOP.SetPsi(NOP.Psi0);
  for i:=0 to lchr-1 do
    NOP.Variations(PopChrStr[k,i]);
  GreytoVector(PopChrPar[k]);
  Readq(q1);
  NOP.ReadPsi(Psi1);
End;
//*************************************************************
procedure TGANOP.ReadFunc(k: integer; var fFu1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to nfu-1 do
    fFu1[i]:=Fuh[k,i];
End;
//*************************************************************
procedure TGANOP.Readq(var q1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to p-1 do
    q1[i]:=q[i];
End;
//*************************************************************
procedure TGANOP.Setq(q1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to high(q1) do
    q[i]:=q1[i];
End;
//*************************************************************
procedure TGANOP.SetPP(pp2: integer);
Begin
  PP:=pp2;
  SetLength(Fuhminm,nfu,PP);
End;
//*************************************************************
Procedure TGANOP.VectortoGrey(var y: TArrInt);
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
END.