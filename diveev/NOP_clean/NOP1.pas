Program NOP1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, Unit2, UnitBVGPobject, Calc3, Unit3, Unit4, Unit5, Unit6, Unit7,
  Unit8, Unit9, tachartlazaruspkg, Unit10, Unit11, Unit12, Unit13, Unit14,
  UnitAdaptObject, Unit15, Grids, Classes, SysUtils, FileUtil, Controls,
  Graphics, Dialogs, StdCtrls;

{$R *.res}

var
  StringGrid2: TStringGrid;
  i,j:integer;

begin

  writeln ('Hello, world22 L1 = ', L1);

  //StringGrid2.RowCount:=L1+1;
  //StringGrid2.ColCount:=L1+1;
  //
  //for i:=1 to L1 do
  //begin
  //  StringGrid2.Cells[i,0]:=InttoStr(i);
  //  StringGrid2.Cells[0,i]:=InttoStr(i);
  //end;
  //
  //writeln ('1');
  //
  //StringGrid2.LoadFromFile('/home/urock/phd/24_NOP_461');
  //
  //writeln ('2');

  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

