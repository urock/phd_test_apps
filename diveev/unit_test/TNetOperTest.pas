program TNetOperTest;

uses crt, TUserClass, UnitTestHeader, TNetOperTestHeader, TNetOperClass;
var
  NOP:TNetOper; // Network operator

// MAIN //
begin
   writeln('Hello, TNetOper unit test!');

   {
      1. create TNetOper
      2. set parameters 
      3. 

      Notes::
         L1 = Lay1

   }
   SetParameters();  // ??

   NOP:=TNetOper.Create(L1, Mout1, kp1, kr1, kw1, kv1);
   NOP.SetO1s(o1s1);      // (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 23)
   NOP.SetO2s(o2s1);      // (1, 2)
    
   NOP.SetRnum(rnum1);     // (3, 4, 5)
   NOP.SetPnum(pnum1);     // (0, 1, 2)
   NOP.SetDnum(dnum1);     // (22, 23)
   NOP.SetPsi(Psi1);
   NOP.SetCs(q1); 

   for i:=0 to nGraphc-1 do
   for j:=0 to ny1-1 do
      qyGraph[j,i]:= StringGrid1[j+1,i+1]; 

   sumt:=0;
   sumdelt:=0;
{   for iGraph := 0 to nGraphc-1 do
  begin
    for i:= 0 to ny1-1 do
       ASNEE.qy[i]:=qyGraph[i,iGraph]; 
    ASNEE.Initial;
    tp:=0;  
    repeat
       if abs(ASNEE.t-tp)<ASNEE.dt/2 then
       begin
          // ASNEE.Viewer;
          tp:=tp+dtp;
       end;
       ASNEE.Euler2;
    until (ASNEE.t>tf1) or (Normdist(ASNEE.x,xf1)<epsterm);
    sumt:=sumt+ASNEE.t;
    sumdelt:=sumdelt+Normdist(ASNEE.x,xf1);
  end; }

   writeln(sumdelt);
   writeln(sumt);

{   if (abs(sumdelt_golden - sumdelt) < 0.001) and (abs(sumt_golden - sumt) < 0.001) then
    writeln('Test OK')
  else
    writeln('Error'); }

   readkey;
end.


