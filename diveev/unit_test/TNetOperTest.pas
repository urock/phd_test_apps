program TNetOperTest;

uses crt, UnitTestHeader, TNetOperClass, Math, Calc3;

type 
// struct for robot state 
RobotState = Record
   x: Real;
   y: Real;
   yaw: Real;

end;

// struct for robot control
Control = Record
   u1: Real;
   u2: Real;
end;

var
   NOP:TNetOper;                 // Network operator      
   initialState:RobotState;      // (0.0,0.0,0.0);
   Goal:RobotState;              // (0.0,0.0,0.0);
   MovedState:RobotState;        // xs - what is it
   undefinedParameters:TArrReal; // (dx, dy, dz)
   dt:real=0.01;                 //step of integration;
   timeLimit:real=1.5;           //terminal time;
   currState:RobotState;   
   currControl:Control;
   currTime:real;

//*************************************************************
Procedure resetCondition;
Begin
   // initial condition + offset
   currState.x := initialState.x + undefinedParameters[0];
   currState.y := initialState.y + undefinedParameters[1];
   currState.yaw := initialState.yaw + undefinedParameters[2];
   currControl.u1 := 0;
   currControl.u2 := 0;
   currTime := 0;
End;
//*************************************************************
Procedure TrimCurrentControl;
Begin
currControl.u1 := Max(currControl.u1, -10);
currControl.u1 := Min(currControl.u1, 10);

currControl.u2 := Max(currControl.u2, -10);
currControl.u2 := Min(currControl.u2, 10);

End;
//*************************************************************
function NormdistBetweenStateAndGoal(state: RobotState): real;  
var
  sum, dx, dy, dyaw:real;
Begin
   sum:=0;
   
   dx := abs(Goal.x - state.x);
   if dx > sum then
      sum := dx;
   
   dy := abs(Goal.y - state.y);
   if dy > sum then
      sum := dy;
   
   dyaw := abs(Goal.yaw - state.yaw);
   if dyaw > sum then
      sum := dyaw;


   result:=sum;
End;
//*********************************************************
// Right part
Procedure RP(state: RobotState; var f1: TArrReal);
var
   i:integer;
   k:real;
Begin
   k:=0.5;
   // diff of robot state and goal   
   NOP.Vs[0] := (Goal.x - state.x);    // Vs - set of variables
   NOP.Vs[1] := (Goal.y - state.y);
   NOP.Vs[2] := (Goal.yaw - state.yaw);
   NOP.RPControl;
   if NormdistBetweenStateAndGoal(state) < epsterm then
   begin
      currControl.u1 := 0;
      currControl.u2 := 0;
   end
   else
   begin
      // NOP.z - vector of nodes
      currControl.u1 := NOP.z[NOP.Dnum[0]]; 
      currControl.u2 := NOP.z[NOP.Dnum[1]];
   end;
   TrimCurrentControl;            
   f1[0] := k * (currControl.u1 + currControl.u2) * cos(state.yaw);
   f1[1] := k * (currControl.u1 + currControl.u2) * sin(state.yaw);
   f1[2] := k * (currControl.u1 - currControl.u2);

   // ??? 
   for i := 0 to ny1-1 do
      if abs(f1[i])>infinity then
         f1[i]:=Ro_10(f1[i])*infinity;
End;
//*************************************************************
Procedure Euler2;  
var
   fa:TArrReal;
   fb:TArrReal;        
Begin
   SetLength(fa, 3);
   SetLength(fb, 3);

   RP(currState, fa);

   // todo
   MovedState.x := currState.x + dt * fa[0];
   MovedState.y := currState.y + dt * fa[1];
   MovedState.yaw := currState.yaw + dt * fa[2];

   RP(MovedState, fb);  

   // todo
   currState.x := currState.x + dt * (fa[0]+fb[0]) / 2;
   currState.y := currState.y + dt * (fa[1]+fb[1]) / 2;
   currState.yaw := currState.yaw + dt * (fa[2]+fb[2]) / 2;

   currTime := currTime + dt;
End;
//*********************************************************

begin
   writeln('Hello, TNetOper unit test!');

   SetParameters();  // from UnitTest
   // ny1 = dimension = 3
   SetLength(undefinedParameters, ny1);
   
   // set initial state
   initialState.x := 0.0;
   initialState.y := 0.0;
   initialState.yaw := 0.0;

   // set Goal
   Goal.x := 0.0;
   Goal.y := 0.0;
   Goal.yaw := 0.0;

   // set current state
   currState.x := 0.0;
   currState.y := 0.0;
   currState.yaw := 0.0;

   // creating NOP
   NOP:=TNetOper.Create(L1, Mout1, kp1, kr1, kw1, kv1, rnum1, pnum1, dnum1);

   // urock. seems that o1s1, o2s1 are not needed for nop calculation
   //NOP.SetO1s(o1s1);    // set of unary operations
   //NOP.SetO2s(o2s1);    // set of binary operations
   // NOP.SetRnum(rnum1);  // vector of number nodes for parameters
   // NOP.SetPnum(pnum1);  // vector of number nodes for variables
   // NOP.SetDnum(dnum1);  // vector of number nodes for outputs
   NOP.SetPsi(Psi1);    // Network  operator matrix
   NOP.SetCs(q1);       // set of parameters

   // todo fix it
   for i:=0 to nGraphc-1 do
      for j:=0 to ny1-1 do
         qyGraph[j,i]:= StringGrid1[j+1,i+1]; 

   sumt:=0;
   sumdelt:=0;
   for iGraph := 0 to nGraphc-1 do
   begin
      for i:= 0 to ny1-1 do
         undefinedParameters[i] := qyGraph[i,iGraph];

      resetCondition();
      tp:=0;  
      repeat
         Euler2;
      until (currTime > timeLimit) or (NormdistBetweenStateAndGoal(currState) < epsterm);
      sumt := sumt + currTime;
      sumdelt := sumdelt + NormdistBetweenStateAndGoal(currState);
   end;

   writeln(sumt);
   writeln(sumdelt);

  if (abs(sumdelt_golden - sumdelt) < 0.001) and (abs(sumt_golden - sumt) < 0.001) then
    writeln('Test OK')
  else
    writeln('Error');

   // readkey;
end.


