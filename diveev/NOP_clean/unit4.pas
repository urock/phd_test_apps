UNIT Unit4;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  Private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form4: TForm4;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm4 }
//*************************************************************
  Procedure TForm4.FormCreate(Sender: TObject);
  var i:integer;
  Begin
    StringGrid1.RowCount:=ny1+1;
    StringGrid1.Colwidths[1]:=96;
    StringGrid1.Colwidths[2]:=96;
    for i:=0 to ny1-1 do
      StringGrid1.Cells[0,i+1]:='y['+inttostr(i)+']';
    StringGrid1.Cells[1,0]:='ymin';
    StringGrid1.Cells[2,0]:='ymax';
    StringGrid1.Cells[3,0]:='delty';
    for i:=0 to ny1-1 do
    begin
      StringGrid1.Cells[1,i+1]:=floattostrf(qyminc[i],ffFixed,8,5);
      StringGrid1.Cells[2,i+1]:=floattostrf(qymaxc[i],ffFixed,8,5);
      StringGrid1.Cells[3,i+1]:=floattostrf(stepsqyc[i],ffFixed,8,5);
    end;
  End;
//*************************************************************
Procedure TForm4.Button1Click(Sender: TObject);
var
    i:integer;
Begin
  for i:=0 to ny1-1 do
  begin
    qymin1[i]:=StrtoFloat(StringGrid1.Cells[1,i+1]);
    qymax1[i]:=StrtoFloat(StringGrid1.Cells[2,i+1]);
    stepsqy1[i]:=StrtoFloat(StringGrid1.Cells[3,i+1]);
  end;
  close;
End;
//*************************************************************
END.

