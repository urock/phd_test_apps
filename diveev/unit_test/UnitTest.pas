program UnitTest;

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

   Setlength(O1s1,kW1);
   Setlength(O2s1,kV1);
   Setlength(Pnum1,kP1);
   Setlength(Rnum1,kR1);
   Setlength(Dnum1,Mout1);
   SetLength(Psi1,L1,L1);
   Setlength(x01,n1);
   Setlength(umin1,m1);
   Setlength(umax1,m1);
   Setlength(q1,p1);
   Setlength(ym,ll1);
   Setlength(um,m1);
   Setlength(xf1,n1);
   SetLength(xf2,ndu1);
   Setlength(qymax1,ny1);
   Setlength(qymin1,ny1);
   Setlength(stepsqy1,ny1);
   SetLength(qyGraph,ny1,nGraphc);
   Setlength(qy1,ny1);

   for i:=0 to L1-1 do
    for j:=0 to L1-1 do
      Psi1[i,j]:=PsiBasc[i,j];

   for i:=0 to nGraphc-1 do
      SetLength(xmm[i],ll1);
   for i:=0 to kW1-1 do
      O1s1[i]:=O1sc[i];
   for i:=0 to kV1-1 do
      O2s1[i]:=O2sc[i];
   for i:=0 to kP1-1 do
      Pnum1[i]:=Pnumc[i];
   for i:=0 to kR1-1 do
      Rnum1[i]:=Rnumc[i];
   for i:=0 to Mout1-1 do
      Dnum1[i]:=Dnumc[i];
   for i:=0 to p1-1 do
      q1[i]:=qc[i];
   for i:=0 to n1-1 do
   begin
      x01[i]:=x0c[i];
      xf1[i]:=xfc[i];
   end;
   for i:=0 to m1-1 do
   begin
      umin1[i]:=uminc[i];
      umax1[i]:=umaxc[i];
   end;
   for i:= 0 to ny1-1 do
   begin
      qymin1[i]:=qyminc[i];
      qymax1[i]:=qymaxc[i];
      stepsqy1[i]:=stepsqyc[i];
      qy1[i]:=qymin1[i];
   end;

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

   StringGrid1[1,1]:=qymin1[0];
   StringGrid1[2,1]:=qymin1[1];
   StringGrid1[3,1]:=qymin1[2];
   StringGrid1[1,2]:=qymin1[0];
   StringGrid1[2,2]:=qymin1[1];
   StringGrid1[3,2]:=qymax1[2];
   StringGrid1[1,3]:=qymin1[0];
   StringGrid1[2,3]:=qymax1[1];
   StringGrid1[3,3]:=qymin1[2];
   StringGrid1[1,4]:=qymin1[0];
   StringGrid1[2,4]:=qymax1[1];
   StringGrid1[3,4]:=qymax1[2];
   StringGrid1[1,5]:=qymax1[0];
   StringGrid1[2,5]:=qymin1[1];
   StringGrid1[3,5]:=qymin1[2];
   StringGrid1[1,6]:=qymax1[0];
   StringGrid1[2,6]:=qymin1[1];
   StringGrid1[3,6]:=qymax1[2];
   StringGrid1[1,7]:=qymax1[0];
   StringGrid1[2,7]:=qymax1[1];
   StringGrid1[3,7]:=qymin1[2];
   StringGrid1[1,8]:=qymax1[0];
   StringGrid1[2,8]:=qymax1[1];
   StringGrid1[3,8]:=qymax1[2];

  for i:=0 to nGraphc-1 do
    for j:=0 to ny1-1 do
      qyGraph[j,i]:= StringGrid1[j+1,i+1]; 
  // qyGraph - ok
   ASNEE.NOP.SetPsi(Psi1);
   sumt:=0;
   sumdelt:=0;
   for iGraph := 0 to nGraphc-1 do
   begin
      for i:= 0 to ny1-1 do
         ASNEE.qy[i]:=qyGraph[i,iGraph]; //   it's OK
      ASNEE.Initial;
      tp:=0;
      kolpoint_mult[iGraph]:=0;
      ASNEE.NOP.SetCs(q1);     // it's OK (12,86841, 3,82666, 6,94312) == qc
      f0:=0;
      repeat
         if abs(ASNEE.t-tp)<ASNEE.dt/2 then
         begin
            ASNEE.Viewer;
            kolpoint_mult[iGraph]:=kolpoint_mult[iGraph]+1;
            for i:=0 to n1-1 do
            begin
               Setlength(xmm[iGraph,i],kolpoint_mult[iGraph]);
               // unit test ASNEE.x = (0,00896497069884294, -0,0244317368711905, 0,0903986549528864)
               // Diveev ASNEE.x = (0,0156847190752594, -0,0228745203577209, 0,092137971388368);
               xmm[iGraph,i,kolpoint_mult[iGraph]-1]:=ASNEE.x[i];
            end;
            tp:=tp+dtp;
         end;
         ASNEE.Euler2;
      until (ASNEE.t>tf1)or (Normdist(ASNEE.x,xf1)<epsterm);
      sumt:=sumt+ASNEE.t;
      sumdelt:=sumdelt+Normdist(ASNEE.x,xf1);
   end;
   f0:=sumdelt; // Diveev sumdelt = 0,870068437487367
   f1:=sumt; // Diveev sumt = 6,3

   // Diveev kolpoint_mult = (8, 6, 15, 9, 6, 8, 8, 6) - with 461 data
   // Len=8: { 15,  15,  15,  15,  15,  15,  15,  15} - with default values
   for i:=0 to Length(kolpoint_mult)-1 do
      writeln(kolpoint_mult[i]);

   readkey;
end.


