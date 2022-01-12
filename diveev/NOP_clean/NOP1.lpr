Program NOP1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, Unit2, UnitBVGPobject, Calc3, Unit3, Unit4, Unit5, Unit6, Unit7,
  Unit8, Unit9, tachartlazaruspkg, Unit10, Unit11, Unit12, Unit13, Unit14,
  UnitAdaptObject;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

