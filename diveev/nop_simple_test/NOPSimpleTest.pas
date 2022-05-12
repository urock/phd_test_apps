program NOPSimpleUnitTest;

uses NOPSimpleTestHeader, SysUtils;
var
  new_X1, new_X2: real;

begin
   new_X1:=0.1;
   new_X2:=0.1;

   if ParamStr(1) <> '' then  
      new_X1:=StrtoFloat(ParamStr(1));

   if ParamStr(2) <> '' then
      new_X2:=StrtoFloat(ParamStr(2));

   writeln('X1 = ', new_X1);
   writeln('X2 = ', new_X2);

   Run(new_X1, new_X2);


end.


