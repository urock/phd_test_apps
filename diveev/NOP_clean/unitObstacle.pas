UNIT unitObstacle;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, ComCtrls, StdCtrls, Calc3;

type

	// (x_top_left, y_top_left) ------------------------------------
	// |								 						    													 |
	// |														    													 |
	// |									       Obstacle													 |
	// |																													 |
	// |																													 |
	// ---------------------------------(x_lower_right, y_lower_right)

	{ Obstacle }

	Obstacle=class(TObject)
		x_top_left:real;
		x_lower_right:real;
		y_top_left:real;
		y_lower_right:real;

		Constructor Create(x_top, y_top, x_low, y_low:real);
		Function CheckCollision(x, y:real): boolean;


	end;
	// ArrObstacles=array of Obstacle; //

var
	
	NumOfObstacles:integer=3; 
	Obstacles:array of Obstacle;         

//*************************************************************
                        IMPLEMENTATION
//*************************************************************
                      { Obstacle }
//*************************************************************
Constructor Obstacle.Create(x_top, y_top, x_low, y_low:real);
Begin
	x_top_left:=x_top;
	y_top_left:=y_top;
	x_lower_right:=x_low;
	y_lower_right:=y_low;
End;

// Функция проверяет попадает ли точки внутрь препятсвия
//*************************************************************
Function Obstacle.CheckCollision(x, y:real): boolean;
var
  i:integer;
Begin
        result:=False;
	if ((x>=x_top_left) and (x<=x_lower_right) and (y<=y_top_left) and (y>=y_lower_right)) then
		result:=True;
End;
//*************************************************************

End.
