unit Calc3;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
const
  infinity=1e8;
  eps=1e-8;
  eps1=1e-2;
  pokmax=8;
  E2c:array [0..7] of real=(0,1,-infinity,infinity,0,0,0,0);
Function Ro_1(z:real):real;
Function Ro_2(z:real):real;
Function Ro_3(z:real):real;
Function Ro_4(z:real):real;
Function Ro_5(z:real):real;
Function Ro_6(z:real):real;
Function Ro_7(z:real):real;
Function Ro_8(z:real):real;
Function Ro_9(z:real):real;
Function Ro_10(z:real):real;
Function Ro_11(z:real):real;
Function Ro_12(z:real):real;
Function Ro_13(z:real):real;
Function Ro_14(z:real):real;
Function Ro_15(z:real):real;
Function Ro_16(z:real):real;
Function Ro_17(z:real):real;
Function Ro_18(z:real):real;
Function Ro_19(z:real):real;
Function Ro_20(z:real):real;
Function Ro_21(z:real):real;
Function Ro_22(z:real):real;
Function Ro_23(z:real):real;
Function Ro_24(z:real):real;
Function Ro_25(z:real):real;
Function Ro_26(z:real):real;
Function Ro_27(z:real):real;
Function Ro_28(z:real):real;

Function Xi_1(z1,z2:real):real;
Function Xi_2(z1,z2:real):real;
Function Xi_3(z1,z2:real):real;
Function Xi_4(z1,z2:real):real;
Function Xi_5(z1,z2:real):real;
Function Xi_6(z1,z2:real):real;
Function Xi_7(z1,z2:real):real;
Function Xi_8(z1,z2:real):real;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
Function Ro_1(z:real):real;
Begin
  result:=z;
End;
//*************************************************************
Function Ro_2(z:real):real;
Begin
  if abs(z)>sqrt(infinity) then result:=infinity
  else result:=sqr(z);
End;
//*************************************************************
Function Ro_3(z:real):real;
Begin
  result:=-z;
End;
//*************************************************************
Function Ro_4(z:real):real;
Begin
  result:=Ro_10(z)*sqrt(abs(z));
End;
//*************************************************************
Function Ro_5(z:real):real;
Begin
  if abs(z)>eps then result:=1/z
    else result:=Ro_10(z)/eps;
End;
//*************************************************************
Function Ro_6(z:real):real;
Begin
  if z>-ln(eps) then result:=exp(-ln(eps))
  else
    result:=exp(z);
End;
//*************************************************************
Function Ro_7(z:real):real;
Begin
  if abs(z)<exp(-pokmax) then result:=ln(eps)
    else result:=ln(abs(z));
End;
//*************************************************************
Function Ro_8(z:real):real;
Begin
  if abs(z)>-ln(eps) then
    result:=Ro_10(z)
  else
    result:=(1-exp(-z))/(1+exp(-z));
End;
//*************************************************************
Function Ro_9(z:real):real;
Begin
  if z>=0 then result:=1
    else result:=0;
End;
//*************************************************************
Function Ro_10(z:real):real;
Begin
   if z>=0 then result:=1
   else
      result:=-1;
End;
//*************************************************************
Function Ro_11(z:real):real;
Begin
  result:=cos(z);
End;
//*************************************************************
Function Ro_12(z:real):real;
Begin
  result:=sin(z);
End;
//*************************************************************
Function Ro_13(z:real):real;
Begin
  result:=arctan(z);
End;
//*************************************************************
Function Ro_14(z:real):real;
Begin
  if abs(z)>Ro_15(infinity) then result:=Ro_10(z)*infinity
  else result:=sqr(z)*z;
End;
//*************************************************************
Function Ro_15(z:real):real;
Begin
  if abs(z)<eps then result:=Ro_10(z)*eps
  else
    result:=Ro_10(z)*exp(ln(abs(z))/3);
End;
//*************************************************************
Function Ro_16(z:real):real;
Begin
  if abs(z)<1 then result:=z
  else result:=Ro_10(z);
End;
//*************************************************************
Function Ro_17(z:real):real;
Begin
  result:=Ro_10(z)*ln(abs(z)+1);
End;
//*************************************************************
Function Ro_18(z:real):real;
Begin
  if abs(z)>-ln(eps) then
    result:=Ro_10(z)*infinity
  else
    result:=Ro_10(z)*(exp(abs(z))-1);
End;
//*************************************************************
Function Ro_19(z:real):real;
Begin
  if abs(z)>1/eps then result:=Ro_10(z)*eps
  else result:=Ro_10(z)*exp(-abs(z));
End;
//*************************************************************
Function Ro_20(z:real):real;
Begin
  Result:=z/2;
End;
//*************************************************************
Function Ro_21(z:real):real;
Begin
  Result:=2*z;
End;
//*************************************************************
Function Ro_22(z:real):real;
Begin
  if z<0 then
    Result:=exp(z)-1
  else 
    Result:=1-exp(-abs(z));
End;
//*************************************************************
Function Ro_23(z:real):real;
Begin
  if abs(z)>1/eps then result:=-Ro_10(z)/eps
  else  result:=z-z*sqr(z);
End;
//*************************************************************
Function Ro_24(z:real):real;
Begin
  if z>infinity then result:=1
    else
      if exp(-z)>infinity then result:=0
      else
        result:=1/(1+exp(-z));
End;
//*************************************************************
Function Ro_25(z:real):real;
Begin
  if z>0 then result:=1
    else result:=0;
End;
//*************************************************************
Function Ro_26(z:real):real;
Begin
  if abs(z)<eps1 then
    result:=0
  else
    result:=Ro_10(z);
End;
//*************************************************************
Function Ro_27(z:real):real;
Begin
  if abs(z)>1 then
    result:=Ro_10(z)
  else
    result:=Ro_10(z)*(1-sqrt(1-sqr(z)));
End;
//*************************************************************
Function Ro_28(z:real):real;
Begin
  if z*z>ln(infinity) then
    result:=z*(1-eps)
  else
    result:=z*(1-exp(-sqr(z)));
End;
//*************************************************************
Function Xi_1(z1,z2:real):real;
Begin
  result:=z1+z2;
End;
//*************************************************************
Function Xi_2(z1,z2:real):real;
Begin
  if abs(z1*z2)>infinity then
    result:=Ro_10(z1*z2)*infinity
  else
    result:=z1*z2;
End;
//*************************************************************
Function Xi_3(z1,z2:real):real;
Begin
  if z1>=z2 then result:=z1
  else result:=z2;
End;
//*************************************************************
Function Xi_4(z1,z2:real):real;
Begin
  if z1<z2 then result:=z1
  else result:=z2;
End;
//*************************************************************
Function Xi_5(z1,z2:real):real;
Begin
  result:=z1+z2-z1*z2;
End;
//*************************************************************
Function Xi_6(z1,z2:real):real;
Begin
  result:=Ro_10(z1+z2)*sqrt(sqr(z1)+sqr(z2));
End;
//*************************************************************
Function Xi_7(z1,z2:real):real;
Begin
  result:=Ro_10(z1+z2)*(abs(z1)+abs(z2));
End;
//*************************************************************
Function Xi_8(z1,z2:real):real;
Begin
  result:=Ro_10(z1+z2)*Xi_2(abs(z1),abs(z2));
End;
//*************************************************************
END.

