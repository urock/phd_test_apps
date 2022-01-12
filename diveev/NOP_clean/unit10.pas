Unit Unit10;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls;
type
  { TForm10 }
  TForm10 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form10: TForm10;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm10 }
//*************************************************************
Procedure TForm10.FormCreate(Sender: TObject);
var
  i:integer;
Begin
  StringGrid1.RowCount:=ny1;
  StringGrid1.ColWidths[1]:=84;
  for i:=0 to ny1-1 do
  begin
    StringGrid1.Cells[0,i]:=InttoStr(i);
    StringGrid1.Cells[1,i]:=FloattoStrf(qy1[i],ffFixed,8,5);
  end;
  Edit1.Text:=FloattoStrf(dt1,ffFixed,8,6);
  Edit2.Text:=FloattoStrf(dtp,ffFixed,8,6);
  Edit3.Text:=FloattoStrf(tf1,ffFixed,6,2);
End;
//*************************************************************
Procedure TForm10.Button1Click(Sender: TObject);
var
  i:integer;
Begin
  for i:= 0 to ny1-1 do
    qy1[i]:=StrtoFloat(StringGrid1.Cells[1,i]);
  dt1:=strtofloat(Edit1.text);
  dtp:=strtofloat(Edit2.text);
  tf1:=strtofloat(Edit3.text);
  Close;
End;

//*************************************************************
END.

