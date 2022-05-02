UNIT TNetOperClass;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
Uses Classes, Calc3, SysUtils;
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

  { TNetOper }

  TNetOper=class(TObject)
    L:integer; //dimention of network operator matrix
    Mout:integer;//number of outputs
    Vs:TArrReal;//set of variables
    Cs:TArrReal;//set of parameters
    O1s:TArrInt;//set of unary operations
    O2s:TArrInt;//set of binary operations
    kP:integer;//cardinal of the set of variables
    kR:integer;//cardinal of the set of parameters
    kW:integer;//cardinal of the set of unary operations
    kV:integer;//cardinal of the set of binary operations
    Pnum:TArrInt;//vector of number nodes for variables
    Rnum:TArrInt;//vector of number nodes for parameters
    Dnum:TArrInt;//vector of number nodes for outputs
    z:TArrReal;//vector of nodes
    zs:TArrString;//string for mathematical expression
    Psi,Psi0:TArrArrInt;//Network  operator matrices

    Constructor Create(Lay1,Mout1,kp1,kr1,kw1,kv1:integer;
                        rnum1, pnum1, dnum1: TArrInt);
    Procedure SetVs(vs1:TArrReal);
    Procedure SetCs(cs1:TArrReal);
    Procedure SetO1s(o1s1:TArrInt);
    Procedure SetO2s(o2s1:TArrInt);
    // Procedure SetPnum(pnum1:TArrInt);
    // Procedure SetRnum(rnum1:TArrInt);
    // Procedure SetDnum(dnum1:TArrInt);
    Procedure SetPsiBas(Psi1:TArrArrInt);
    Procedure SetPsi(Psi1:TArrArrInt);
    Procedure GenVar(var w:TArr4Int);
    Procedure Variations(w:TArr4Int);
    Procedure RPControl(delta_state_goal: TArrReal; var currentControl: TArrReal);
    Procedure PsitoPas;
    Procedure PsitoTex;
    Procedure PsitoPasStr;
    Procedure PsitoTexStr;
    Procedure ReadPsi(var Psi1:TArrArrInt);
    Procedure ReadPsi0(var Psi1:TArrArrInt);
  end;
//*************************************************************
                        IMPLEMENTATION
//*************************************************************
{$R+}
                      { TNetOper }
//*************************************************************
Constructor TNetOper.Create(Lay1, Mout1, kp1, kr1, kw1, kv1: integer;
                            rnum1, pnum1, dnum1: TArrInt);
var
  i:integer;
Begin
  L:=Lay1;
  kP:=kp1;
  kR:=kr1;
  kW:=kw1;
  kV:=kv1;
  Mout:=Mout1;
  Setlength(Psi,L,L);
  Setlength(Psi0,L,L);
  Setlength(z,L);
  Setlength(zs,L);
  Setlength(Vs,kP);
  Setlength(Cs,kR);
  Setlength(O1s,kW);
  Setlength(O2s,kV);
  Setlength(Pnum,kP);
  Setlength(Rnum,kR);
  Setlength(Dnum,Mout);
  for i:=0 to kR-1 do
    Rnum[i]:=rnum1[i];  
  for i:=0 to kP-1 do
    Pnum[i]:=pnum1[i];
  for i:=0 to Mout-1 do
    Dnum[i]:=dnum1[i];        
End;


//*************************************************************
procedure TNetOper.SetCs(cs1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to kR-1 do
    Cs[i]:=cs1[i];
End;

//*************************************************************
Procedure TNetOper.SetO1s(o1s1: TArrInt);
var
  i:integer;
Begin
  for i:=0 to kW-1 do
    O1s[i]:=o1s1[i];
End;
//*************************************************************
Procedure TNetOper.SetO2s(o2s1: TArrInt);
var
  i:integer;
Begin
  for i:=0 to kV-1 do
    O2s[i]:=o2s1[i];
End;

//*************************************************************
Procedure TNetOper.SetPsi(Psi1: TArrArrInt);
var
  i,j:integer;
Begin
  for i:=0 to L-1 do
    for j:= 0 to L-1 do
      Psi[i,j]:=Psi1[i,j];
End;
//*************************************************************
Procedure TNetOper.SetPsiBas(Psi1: TArrArrInt);
var
  i,j:integer;
Begin
  for i:=0 to L-1 do
    for j:= 0 to L-1 do
      Psi0[i,j]:=Psi1[i,j];
End;

//*************************************************************
Procedure TNetOper.SetVs(vs1: TArrReal);
var
  i:integer;
Begin
  for i:=0 to high(Vs1) do
    Vs[i]:=vs1[i];
End;
//*************************************************************
Procedure TNetOper.ReadPsi(var Psi1: TArrArrInt);
var
  i,j:integer;
Begin
  for i:=0 to L-1 do
    for j:=0 to L-1 do
      Psi1[i,j]:=Psi[i,j];
End;
//*************************************************************
Procedure TNetOper.ReadPsi0(var Psi1: TArrArrInt);
var
  i,j:integer;
Begin
  for i:=0 to L-1 do
    for j:=0 to L-1 do
      Psi1[i,j]:=Psi0[i,j];
End;
//*************************************************************
Procedure TNetOper.RPControl(delta_state_goal: TArrReal; var currentControl: TArrReal);
var
  i,j:integer;
  zz:real;
Begin
  SetVs(delta_state_goal);
  for i:=0 to L-1 do
    case psi[i,i] of
      1,5..8: z[i]:=0;
      2: z[i]:=1;
      3: z[i]:=-infinity;
      4: z[i]:=infinity;
    end;
  for i:=0 to kP-1 do
    z[Pnum[i]]:=Vs[i];
  for i:=0 to kR-1 do
    z[Rnum[i]]:=Cs[i];
  for i:=0 to L-2 do
    for j:=i+1 to L-1 do
      if Psi[i,j]<>0 then
      begin
        case Psi[i,j] of
          1: zz:=Ro_1(z[i]);
          2: zz:=Ro_2(z[i]);
          3: zz:=Ro_3(z[i]);
          4: zz:=Ro_4(z[i]);
          5: zz:=Ro_5(z[i]);
          6: zz:=Ro_6(z[i]);
          7: zz:=Ro_7(z[i]);
          8: zz:=Ro_8(z[i]);
          9: zz:=Ro_9(z[i]);
          10: zz:=Ro_10(z[i]);
          11: zz:=Ro_11(z[i]);
          12: zz:=Ro_12(z[i]);
          13: zz:=Ro_13(z[i]);
          14: zz:=Ro_14(z[i]);
          15: zz:=Ro_15(z[i]);
          16: zz:=Ro_16(z[i]);
          17: zz:=Ro_17(z[i]);
          18: zz:=Ro_18(z[i]);
          19: zz:=Ro_19(z[i]);
          20: zz:=Ro_20(z[i]);
          21: zz:=Ro_21(z[i]);
          22: zz:=Ro_22(z[i]);
          23: zz:=Ro_23(z[i]);
          24: zz:=Ro_24(z[i]);
          25: zz:=Ro_25(z[i]);
          26: zz:=Ro_26(z[i]);
          27: zz:=Ro_27(z[i]);
          28: zz:=Ro_28(z[i]);
        end;
        case Psi[j,j] of
          1: z[j]:=Xi_1(z[j],zz);
          2: z[j]:=Xi_2(z[j],zz);
          3: z[j]:=Xi_3(z[j],zz);
          4: z[j]:=Xi_4(z[j],zz);
          5: z[j]:=Xi_5(z[j],zz);
          6: z[j]:=Xi_6(z[j],zz);
          7: z[j]:=Xi_7(z[j],zz);
          8: z[j]:=Xi_8(z[j],zz);
        end;
      end;
  currentControl[0] := z[Dnum[0]]; 
  currentControl[1] := z[Dnum[1]];      
End;
//*************************************************************
Procedure TNetOper.Variations(w: TArr4Int);
// Элементарные операции
// 0 - замена недиагонального элемента
// 1 - замена диагонального элемента
// 2 - добавление дуги
// 3 - удаление дуги
var
  i,j,s1,s2:integer;
Begin
  if (w[0]<>0)or(w[1]<>0)or(w[2]<>0) then
    case w[0] of
      0: if Psi[w[1],w[2]]<>0 then Psi[w[1],w[2]]:=w[3];
      1: if Psi[w[1],w[1]]<>0 then Psi[w[1],w[1]]:=w[3];
      2: if Psi[w[1],w[2]]=0 then
           if Psi[w[2],w[2]]<>0 then Psi[w[1],w[2]]:=w[3];
      3:
      begin
        s1:=0;
        for i:=0 to w[2]-1 do
          if Psi[i,w[2]]<>0 then s1:=s1+1;
        s2:=0;
        for j:=w[1]+1 to L-1 do
          if (Psi[w[1],j]<>0)then s2:=s2+1;
        if s1>1 then
          if s2>1 then
            Psi[w[1],w[2]]:=0;
      end;
    end;
End;
//*************************************************************
Procedure TNetOper.GenVar(var w: TArr4Int);
// Генерация элементарной операции
  Function TestSource(j:integer):boolean;
  // если j-номер узла источника, то возвращает false
  var
    i:integer;
    flag:boolean;
  Begin
    flag:=true;
    i:=0;
    while(i<=high(Pnum)) and (j<>Pnum[i]) do i:=i+1;
    if i<=high(Pnum) then flag:=false
    else
    begin
      i:=0;
      while(i<=high(Rnum)) and (j<>Rnum[i]) do i:=i+1;
      if i<=high(Rnum) then flag:=false;
    end;
    result:=flag;
  End;
Begin
  w[0]:=random(4);
  case w[0] of
    0,2,3: // замена недиагонального элемента, добавление и удаление дуги
    begin
     w[1]:=random(L-1);
     w[2]:=random(L-w[1]-1)+w[1]+1;
//     while not TestSource(w[2]) do w[2]:=w[2]+1;
     w[3]:=O1s[random(kW)];
    end;
    1: // замена диагонального элемента
    begin
      w[1]:=random(L);
      while not TestSource(w[1]) do w[1]:=w[1]+1;
      w[2]:=w[1];
      w[3]:=O2s[random(kV)];
    end;
  end;
End;
//*************************************************************
Procedure TNetOper.PsitoPas;
 // It tranforms from Psi to Pascal
 // формирование выражения вложенных функций 
var
  i,j:integer;
  zz:string;
Begin
  for i:=0 to L-1 do
    case Psi[i,i] of
      0,4: zs[i]:='0';
      1: zs[i]:='1';
      2: zs[i]:='-inf';
      3: zs[i]:='inf';
    end;
  for i:=0 to kP-1 do
    zs[Pnum[i]]:='x['+inttostr(i)+']';
  for i:=0 to kR-1 do
    zs[Rnum[i]]:='q['+inttostr(i)+']';
  for i:=0 to L-2 do
  begin
    for j:=i+1 to L-1 do
      if Psi[i,j]<>0 then
      begin
        if Psi[i,j]=1 then
          zz:=zs[i]
        else
          zz:='Ro_'+inttostr(Psi[i,j])+'('+zs[i]+')';
        if((Psi[j,j]=0)and(zs[j]='0'))or
          ((Psi[j,j]=1)and(zs[j]='1'))or
          ((Psi[j,j]=2)and(zs[j]='-inf'))or
          ((Psi[j,j]=3)and(zs[j]='inf'))or
          ((Psi[j,j]=4)and(zs[j]='0')) then
          zs[j]:=zz
        else
          zs[j]:='Xi_'+inttostr(Psi[j,j])+'('+zs[j]+','+zz+')';
      end;
  end;
End;
//*************************************************************
Procedure TNetOper.PsitoPasStr;
var
  i,j:integer;
Begin
  for j:=L-1 downto 0 do
  begin
    zs[j]:='z'+inttostr(j)+'=';
    case Psi[j,j] of
      1: zs[j]:=zs[j]+'Sum(';
      2: zs[j]:=zs[j]+'Prod(';
      3: zs[j]:=zs[j]+'Min(';
      4: zs[j]:=zs[j]+'Max(';
      5: zs[j]:=zs[j]+'Pol(';
      6: zs[j]:=zs[j]+'Norm2(';
      7: zs[j]:=zs[j]+'NormMax(';
      8: zs[j]:=zs[j]+'NormProd(';
    end;
    for i:=j-1 downto 0 do
      if Psi[i,j]<>0 then
        if Psi[i,j]<>1 then
          zs[j]:=zs[j]+'Ro_'+inttostr(Psi[i,j])+'(z_'+inttostr(i)+'),'
        else
          zs[j]:=zs[j]+'z_'+inttostr(i)+',';
    if zs[j,length(zs[j])]=',' then
      zs[j,length(zs[j])]:=')'
    else
      zs[j]:=zs[j]+')';
  end;
  for i:=0 to kP-1 do
    zs[Pnum[i]]:='z_'+inttostr(Pnum[i])+'=x_'+inttostr(i);
  for i:=0 to kR-1 do
    zs[Rnum[i]]:='z_'+inttostr(Rnum[i])+'=q_'+inttostr(i);
End;
//*************************************************************
Procedure TNetOper.PsitoTex;
 // It tranforms from Psi to LaTeX
var
  i,j:integer;
  zz:string;
Begin
  for i:=0 to L-1 do
    case Psi[i,i] of
      0,4: zs[i]:='0';
      1: zs[i]:='1';
      2: zs[i]:='-\infinity';
      3: zs[i]:='\infinity';
    end;
  for i:=0 to kP-1 do
    zs[Pnum[i]]:='x_{'+inttostr(i)+'}';
  for i:=0 to kR-1 do
    zs[Rnum[i]]:='q_{'+inttostr(i)+'}';
  for i:=0 to L-2 do
  begin
    for j:=i+1 to L-1 do
      if Psi[i,j]<>0 then
      begin
        if Psi[i,j]=1 then
          zz:=zs[i]
        else
          zz:='\rho_{'+inttostr(Psi[i,j])+'}('+zs[i]+')';
        if((Psi[j,j]=0)and(zs[j]='0'))or
          ((Psi[j,j]=1)and(zs[j]='1'))or
          ((Psi[j,j]=2)and(zs[j]='-\infinity'))or
          ((Psi[j,j]=3)and(zs[j]='\infinity'))or
          ((Psi[j,j]=4)and(zs[j]='0')) then
          zs[j]:=zz
        else
          zs[j]:='\chi_{'+inttostr(Psi[j,j])+'}('+zs[j]+','+zz+')';
      end;
  end;
End;
//*************************************************************
procedure TNetOper.PsitoTexStr;
var
  i,j:integer;
Begin
  for j:=L-1 downto 0 do
  begin
    zs[j]:='$z_{'+inttostr(j)+'}=';
    case Psi[j,j] of
      2: zs[j]:=zs[j]+'\text{Min}(';
      3: zs[j]:=zs[j]+'\text{Max}(';
      4: zs[j]:=zs[j]+'\text{Pol}(';
    end;
    for i:=j-1 downto 0 do
      if Psi[i,j]<>0 then
      begin
        if Psi[i,j]<>1 then
          zs[j]:=zs[j]+'\rho_{'+inttostr(Psi[i,j])+'}(z_{'+inttostr(i)+'})'
        else
          zs[j]:=zs[j]+'z_{'+inttostr(i)+'}';
        case Psi[j,j] of
          0:zs[j]:=zs[j]+'+';
          1:zs[j]:=zs[j]+'*';
        end;
      end;
    if (zs[j,length(zs[j])]='+')or(zs[j,length(zs[j])]='*') then
      zs[j,length(zs[j])]:=')'
    else
      zs[j]:=zs[j]+')';
    zs[j]:=zs[j]+'$\\';
  end;
  for i:=0 to kP-1 do
    zs[Pnum[i]]:='z_{'+inttostr(Pnum[i])+'}=x_{'+inttostr(i)+'}';
  for i:=0 to kR-1 do
    zs[Rnum[i]]:='z_{'+inttostr(Rnum[i])+'}=q_{'+inttostr(i)+'}';
End;
END.