UNIT NOPSimpleTestHeader;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses crt, Interfaces, TNetOperClass;

type
  TArrInt=array of integer;
  TArrArrInt=array of TArrInt;
  TArrReal=array of real;

const
  Pnumc:array [0..1] of integer=(0,1);      //в каких узлах лежат переменные,
                                            //так же это номер позиции в векторе вычислений z
  Rnumc:array [0..2] of integer=(2,3,4);    //номера узлов для констант
  Dnumc:array [0..1] of integer=(13,13);    //номера выходов (результирующих узлов)
  q1_c:array [0..2]of real=(0.1,0.1,0.1);   //параметры функции
  PsiBasc:array [0..13,0..13] of integer=   //сама функция
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

var
  L: integer = 14;    // размерность матрицы сетевого оператора
  kP:integer=2;       // количество переменных в выражении
  kR:integer=3;       // количество параметров
  Mout:integer=2;     // number of outputs
  kw:integer=20;      // cardinal of set of unary operations
  kv:integer=2;       // cardinal of set of binary operations
  x1: array [0..1] of real = (0.1, 0.1);
  Procedure Run(new_X1, new_X2:real);
  function func_et1(x, q: TArrReal): real;

//*************************************************************
                        IMPLEMENTATION
//*************************************************************

function func_et1(x, q: TArrReal): real;
begin
  result:=(sqr(x[0])-sqr(x[1]))*cos(q[0]*x[0]+q[1])+x[0]*x[1]*exp(-q[2]*x[0]);
end;

//*************************************************************
Procedure Run(new_X1, new_X2:real);
var
  i, j: integer;
  NOP:TNetOper;                 
  NOP_output: TArrReal;
  Psi: TArrArrInt;
  expectedResult: real;

begin
  x1[0] := new_X1;
  x1[1] := new_X2;

  SetLength(NOP_output,2);
  SetLength(Psi,L,L);

  for i:=0 to L-1 do
    for j:=0 to L-1 do
      Psi[i,j]:=PsiBasc[i,j];

  NOP:=TNetOper.Create(L, Mout, kP, kR, kw, kv, Rnumc, Pnumc, Dnumc);
  NOP.SetPsi(Psi);          
  NOP.SetCs(q1_c);                
  
  expectedResult := func_et1(x1,q1_c);
  NOP.RPControl(x1, NOP_output);
  
  writeln('Expected result = ', expectedResult);
  writeln('TNetOper result = ', NOP_output[0]);

  if abs(NOP_output[0] - expectedResult) < 0.001 then
    writeln('TEST OK!')
  else
    writeln('TEST FAILED')
end;

end.
