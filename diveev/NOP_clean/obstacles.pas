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
Constructor TNetOper.Create(x_top, y_top, x_low, y_low:real)
Begin
	x_top_left:=x_top;
	y_top_left:=y_top;
	x_lower_right:=x_low;
	y_lower_right:=y_low;
End;

// Функция проверяет попадает ли точки внутрь препятсвия
//*************************************************************
procedure TNetOper.CheckCollision(x, y:real);
var
  i:integer;
Begin
	if ((x>=x_top_left) and (y<=y_top_left) and (x<=x_lower_right) and (y<=y_lower_right) then
		return true;

	return false;
End;
//*************************************************************