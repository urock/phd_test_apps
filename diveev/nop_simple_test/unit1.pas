UNIT Unit1;

{$mode objfpc}{$H+}
//*************************************************************
                            INTERFACE
//*************************************************************

uses
  Classes, SysUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls,
  Buttons, Unit2, Unit3,Calc3;

type
  TArrInt=Array of integer;
  TArrArrInt=Array of TArrInt;
  TArrArrArrInt=Array of TArrArrInt;
  TArrReal=Array of real;
  TArrArrReal=Array of TArrreal;

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Procedure BitBtn1Click(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
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
  Form1: TForm1;
  L: integer = 14;   // размерность матрицы сетевого оператора
  kP:integer=2;      //количество переменных в выражении
  kR:integer=3;      //количество параметров
  z:TArrReal;        //вектор промежуточных вычислений
  Vs:TArrReal;       //вектор переменных
  Cs:TArrReal;       //вектор параметров
  Mout:integer=2;    //количество выходов
  Rnum,Pnum,Dnum:TArrInt;
  Psi: TArrArrInt;
  y1: array [0..1] of real;
  x1: array [0..1] of real = (0.1,0.1);
  q1: TArrReal;
  Procedure RPControl;
  function func_et1(x1,q1: TArrReal): real;
  function func_et2(x1,q1: TArrReal): real;
//*************************************************************
                       IMPLEMENTATION
//*************************************************************


{$R *.lfm}

{ TForm1 }

Procedure TForm1.FormCreate(Sender: TObject);
Begin
  //Color:=RGB(220,40,170);
  Edit2.Text:=InttoStr(L);
  Edit3.Text:=InttoStr(kP);
  Edit4.Text:=InttoStr(Mout);
  Edit5.Text:=InttoStr(kR);

End;

Procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i,j: integer;
Begin
  L:= StrtoInt(Edit2.Text);
  kP:= StrtoInt(Edit3.Text);
  Mout:= StrtoInt(Edit4.Text);
  kR:= StrtoInt(Edit5.Text);
  if length(Psi)<>length(PsiBasc) then
  begin
    Setlength(Psi,L,L);
    for i:=0 to L-1 do
      for j:=0 to L-1 do
        Psi[i,j]:=PsiBasc[i,j];
  end;
  if length(q1)<>length(q1_c) then
  begin
    Setlength(q1,kR);
    for i:=0 to kR-1 do
      q1[i]:=q1_c[i];
  end;
  Setlength(Pnum,kP);
    for i:=0 to kP-1 do
      Pnum[i]:=Pnumc[i];
  Setlength(Rnum,kR);
  for i:=0 to kR-1 do
    Rnum[i]:=Rnumc[i];
  Setlength(Dnum,Mout);
  for i:=0 to Mout-1 do
    Dnum[i]:=Dnumc[i];
  SetLength(Vs,kP);
  SetLength(Cs,kR);
  Setlength(z,L);
  Form2:=TForm2.Create(Self);
  Form2.ShowModal;
End;
//*****************************************************************
Procedure RPControl;
var
   i,j:integer;
   zz:real;
Begin
    //заполняем вектор вычислений z единичными элементами бинарных операций
     for i:=0 to L-1 do
       case psi[i,i] of
         1,5..8: z[i]:=0;
         2: z[i]:=1;
         3: z[i]:=-infinity;
         4: z[i]:=infinity;
       end;
     //в начало вектора z записываем паременные и параметры
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
End;
//*****************************************************************

function func_et1(x1,q1: TArrReal): real;
begin
     result:=(sqr(x1[0])-sqr(x1[1]))*cos(q1[0]*x1[0]+q1[1])+x1[0]*x1[1]*exp(-q1[2]*x1[0]);
end;

function func_et2(x1,q1: TArrReal): real;
begin
     result:=exp(-q1[0]*x1[0]+q1[1])*cos(sqr(x1[0])-sqr(x1[1]));
end;
END.

