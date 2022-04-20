program TNetOperTest;

uses crt, TUserClass, UnitTestHeader;

// MAIN //
begin
  writeln('Hello, Unit test!');

  // Pipeline
  // 0. TForm1 create
  // 1. (MenuItem5Click)
  // 2. (MenuItem8Click)
  // 3. (MenuItem9Click)
  // 4. (MenuItem10Click)
  // 5. (MenuItem11Click)
  // 6. (MenuItem6Click)

  //******* STEP 0 *******//
  // randomize;

  SetParameters();

  //******* STEP 1 MenuItem5Click *******//
  // set parameters from first window () {button: Create object for NOP}
  ASNEE:=TUser.Create(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, epo1,
                     kel1, alfa1, pmut1, L1, Mout1, kp1,
                     kr1, kw1, kv1, n1, m1, ll1, ny1);
  ASNEE.Setqymax(qymax1);      // 2.5, 2.5, 1.31
  ASNEE.Setqymin(qymin1);      // -2.5, -2.5, -1.31
  ASNEE.Setstepsqy(stepsqy1);  // 1.25 2.5 1.31
  ASNEE.NOP.SetO1s(o1s1);      // (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 23)
  ASNEE.NOP.SetO2s(o2s1);      // (1, 2)
  ASNEE.SetShtraf(Shtraf1);    // 2
  ASNEE.ksearch:=ksearch1;     // 8

  //******* STEP 2 MenuItem8Click *******//
  // set another parameters {button: Undefinaed parameters}
  for i:=0 to ny1-1 do
    ASNEE.ix[i]:=trunc((qymax1[i]-qymin1[i])/stepsqy1[i]);
  ASNEE.Setixmax(ASNEE.ix);     // (4 2 2)

  //******* STEP 3 MenuItem9Click *******//
  // set another parameters {button: parameters for NOP} 
  ASNEE.Setq(q1);               // (12,86841, 3,82666, 6,94312)
  ASNEE.NOP.SetRnum(rnum1);     // (3, 4, 5)
  ASNEE.NOP.SetPnum(pnum1);     // (0, 1, 2)
  ASNEE.NOP.SetDnum(dnum1);     // (22, 23)
  ASNEE.NOP.SetPsi(Psi1);    

  //******* STEP 4 MenuItem10Click *******//
  // set another parameters {button: parameters of GA for NOP}
  ASNEE.RR:=RR1;
  ASNEE.kel:=kel1;
  ASNEE.Epo:=Epo1;
  ASNEE.alfa:=alfa1;
  ASNEE.pmut:=pmut1;
  ASNEE.SetPP(PP1);
  ASNEE.SetShtraf(Shtraf1); 

  //******* STEP 5 MenuItem11Click *******//
  // set another parameters {button: parameters for model}
  ASNEE.Setdt(dt1);             // 0.01
  ASNEE.Settf(tf1);             // 1.5
  ASNEE.Setx0(x01);             // (0 0 0)
  ASNEE.Setuogr(umin1,umax1);   // (-10,-10) (10,10)

  //******* STEP 6 MenuItem6Click *******//

  for i:=0 to nGraphc-1 do
  for j:=0 to ny1-1 do
    qyGraph[j,i]:= StringGrid1[j+1,i+1]; 

  sumt:=0;
  sumdelt:=0;
  for iGraph := 0 to nGraphc-1 do
  begin
    for i:= 0 to ny1-1 do
       ASNEE.qy[i]:=qyGraph[i,iGraph]; 
    ASNEE.Initial;
    tp:=0;
    ASNEE.NOP.SetCs(q1);     
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
  end;

  writeln(sumdelt);
  writeln(sumt);

  if (abs(sumdelt_golden - sumdelt) < 0.001) and (abs(sumt_golden - sumt) < 0.001) then
    writeln('Test OK')
  else
    writeln('Error');

  readkey;
end.


