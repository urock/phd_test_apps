UNIT NOPSimpleUnitTestHeader;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses crt, StdCtrls, Calc3, Classes, SysUtils, FileUtil, ComCtrls, Interfaces;

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
  Pnumc:array [0..1] of integer=(0,1);     //в каких узлах лежат переменные,
                                           //так же это номер позиции в векторе вычислений z
  Rnumc:array [0..2] of integer=(2,3,4);   //номера узлов для констант
  Dnumc:array [0..1] of integer=(13,13);   //номера выходов (результирующих узлов)
  q1_c:array [0..2]of real=(0.1,0.1,0.1);  //параметры функции
  PsiBasc:array [0..13,0..13] of integer=  //сама функция
  ((0,0,0,0,  0,1,1,1,  0,2,0,0, 0,0),
   (0,0,0,0,  0,0,1,0,  2,0,0,0, 0,0),
   (0,0,0,0,  0,1,0,0,  0,0,0,0, 0,0),
   (0,0,0,0,  0,0,0,0,  0,0,1,0, 0,0),

   (0,0,0,0,  0,0,0,3,  0,0,0,0, 0,0),
   (0,0,0,0,  0,2,0,0,  0,0,1,0, 0,0),
   (0,0,0,0,  0,0,2,0,  0,0,0,1, 0,0),
   (0,0,0,0,  0,0,0,2,  0,0,0,6, 0,0),

   (0,0,0,0,  0,0,0,0,  1,3,0,0, 0,0),
   (0,0,0,0,  0,0,0,0,  0,1,0,0, 1,0),
   (0,0,0,0,  0,0,0,0,  0,0,1,0, 11,0),
   (0,0,0,0,  0,0,0,0,  0,0,0,2, 0,1),

   (0,0,0,0,  0,0,0,0,  0,0,0,0, 2,1),
   (0,0,0,0,  0,0,0,0,  0,0,0,0, 0,1));

  infinity=1e10;

var
  L: integer = 14;   // размерность матрицы сетевого оператора
  kP:integer=2;      //количество переменных в выражении
  kR:integer=3;      //количество параметров
  z:TArrReal;        //вектор промежуточных вычислений
  Vs:TArrReal;       //вектор переменных
  Cs:TArrReal;       //вектор параметров
  y1: array [0..1] of real;
  x1: array [0..1] of real = (0.1,0.1);
  Procedure InitTest;
  Procedure RPControl;
  Procedure Run;
  function func_et1(x, q: TArrReal): real;

//*************************************************************
                        IMPLEMENTATION
//*************************************************************


Procedure InitTest;
Begin

  SetLength(Vs,kP);
  SetLength(Cs,kR);
  Setlength(z,L);
End;
//*************************************************************
Procedure RPControl;
var
   i,j:integer;
   zz:real;
Begin
    //заполняем вектор вычислений z единичными элементами бинарных операций
     for i:=0 to L-1 do
       case PsiBasc[i,i] of
         1,5..8: z[i]:=0;
         2: z[i]:=1;
         3: z[i]:=-infinity;
         4: z[i]:=infinity;
       end;
     //в начало вектора z записываем паременные и параметры
     for i:=0 to kP-1 do
       z[Pnumc[i]]:=Vs[i];
     for i:=0 to kR-1 do
       z[Rnumc[i]]:=Cs[i];
     for i:=0 to L-2 do
       for j:=i+1 to L-1 do
         if PsiBasc[i,j]<>0 then
         begin
           case PsiBasc[i,j] of
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
           end;
           case PsiBasc[j,j] of
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
End;
//*************************************************************

function func_et1(x, q: TArrReal): real;
begin
  // Result = 4.9406564584124654e-324
  result:=(sqr(x[0])-sqr(x[1]))*cos(q[0]*x[0]+q[1])+x[0]*x[1]*exp(-q[2]*x[0]);
end;


procedure Run;
var
  i: integer;
begin
  InitTest;
  y1[0]:=func_et1(x1,q1_c);
  // y1[1]:=func_et2(x1,q1_c);

  for i:=0 to kR-1 do
    Cs[i]:=q1_c[i];
  
  for i:=0 to kP-1 do
    Vs[i]:=x1[i];
  
  RPcontrol;

 // 9.9004983374916828E-003
 // 9.9004983374916828E-003

  writeln(y1[0]);
  writeln(z[Dnumc[0]]);

end;

end.
