UNIT TNetOperTestHeader;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses TNetOperClass;

type
  TArrInt=array of integer;
  TArrArrInt=array of TArrInt;
  TArr4Int=array [0..3]of integer;
  TArrArr4Int=array of TArr4Int;
  TArrArrArr4int=array of TArrArr4Int;
  TArrReal=array of real;
  TArrArrReal=array of TArrReal;
  TArrString=array of string;

//*************************************************************
                        IMPLEMENTATION
//*************************************************************

end.