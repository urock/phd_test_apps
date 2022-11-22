UNIT UnitObstacles;
{$mode objfpc}{$H+} {$R+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, ComCtrls, StdCtrls, Calc3;

Uses Classes, Calc3,SysUtils;
type
	TArrInt=array of integer;
	TArrArrInt=array of TArrInt;
	TArr4Int=array [0..3]of integer;
	TArrArr4Int=array of TArr4Int;
	TArrArrArr4int=array of TArrArr4Int;
	TArrReal=array of real;
	TArrArrReal=array of TArrReal;
	TArrString=array of string;
	TProc=Procedure;

	{ Obstacle }

	Obstacle=class(TObject)

	// (x_top_left, y_top_left) ------------------------------------ 
	// |								 						    |
	// |														    |
	// |															|
	// |															|
	// |															|
	// ---------------------------------(x_lower_right, y_lower_right) 				

	x_top_left:real;
	x_lower_right:real;

	y_top_left:real;
	y_lower_right:real;

	Constructor Create(x_top, y_top, x_low, y_low:real);

	Procedure CheckCollision(x, y:real);

//*************************************************************
                        IMPLEMENTATION
//*************************************************************
{$R+}

                      { TNetOper }
//*************************************************************
Constructor TNetOper.Create(Lay1, Mout1, kp1, kr1, kw1, kv1: integer);
Begin
  L:=Lay1;
  kP:=kp1;
  kR:=kr1;
  kW:=kw1;
  kV:=kv1;
  Mout:=Mout1;
  Setlength(Psi,L,L);
  Setlength(Psi0,L,L);
  Setlength(z,L);
  Setlength(zs,L);
  Setlength(Vs,kP);
  Setlength(Cs,kR);
  Setlength(O1s,kW);
  Setlength(O2s,kV);
  Setlength(Pnum,kP);
  Setlength(Rnum,kR);
  Setlength(Dnum,Mout);
End;
//*************************************************************