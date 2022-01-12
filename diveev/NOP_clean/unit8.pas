UNIT Unit8;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls;

type

  { TForm8 }

  TForm8 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form8: TForm8;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm8 }
//*************************************************************
Procedure TForm8.FormCreate(Sender: TObject);
var
  i:integer;
Begin
  StringGrid1.ColWidths[1]:=96;
  StringGrid2.ColWidths[1]:=96;
  StringGrid2.ColWidths[2]:=96;
  StringGrid1.RowCount:=n1;
  StringGrid2.RowCount:=m1+1;
  for i:=0 to n1-1 do
  begin
    StringGrid1.Cells[0,i]:=InttoStr(i);
    StringGrid1.Cells[1,i]:=FloattoStrf(x01[i],ffFixed,8,5);
  end;
  StringGrid2.Cells[1,0]:='umin';
  StringGrid2.Cells[2,0]:='umax';
  for i:=0 to m1-1 do
  begin
    StringGrid2.Cells[0,i+1]:=InttoStr(i);
    StringGrid2.Cells[1,i+1]:=FloattoStrf(umin1[i],ffFixed,8,5);
    StringGrid2.Cells[2,i+1]:=FloattoStrf(umax1[i],ffFixed,8,5);
  end;
  Edit1.Text:=FloattoStrf(dt1,ffFixed,8,6);
  Edit2.Text:=FloattoStrf(tf1,ffFixed,8,2);
End;
//*************************************************************
Procedure TForm8.Button1Click(Sender: TObject);
var
  i:integer;
Begin
  dt1:=StrtoFloat(Edit1.text);
  tf1:=StrtoFloat(Edit2.text);
  for i:=0 to n1-1 do
    x01[i]:=StrtoFloat(StringGrid1.Cells[1,i]);
  for i:=0 to m1-1 do
  begin
    umin1[i]:=StrtoFloat(StringGrid2.Cells[1,i+1]);
    umax1[i]:=StrtoFloat(StringGrid2.Cells[2,i+1]);
  end;
  Close;
End;
//*************************************************************
END.

