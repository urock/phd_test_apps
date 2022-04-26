unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button3: TButton;
    Button4: TButton;
    Button2: TButton;
    Button1: TButton;
    Label2: TLabel;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Procedure Button1Click(Sender: TObject);
    Procedure Button2Click(Sender: TObject);
    Procedure Button3Click(Sender: TObject);
    Procedure Button4Click(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

Uses Unit1,Unit3;

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
var
  i,j:integer;
Begin
  StringGrid2.RowCount:=kR;
  StringGrid2.ColWidths[1]:=96;
  StringGrid1.RowCount:=L+1;
  StringGrid1.ColCount:=L+1;
  for i:=0 to kR-1 do
  begin
    StringGrid2.Cells[0,i]:='q['+InttoStr(i)+']';
    StringGrid2.Cells[1,i]:=FloattoStrf(q1[i],ffFixed,8,5);
  end;
  for i:=1 to L do
  begin
    StringGrid1.Cells[i,0]:=InttoStr(i);
    StringGrid1.Cells[0,i]:=InttoStr(i);
  end;
  for i:=0 to L-1 do
    for j:=0 to L-1 do
      StringGrid1.Cells[j+1,i+1]:=InttoStr(Psi[i,j]);
End;
//*************************************************************
Procedure TForm2.Button1Click(Sender: TObject);
Begin
  SaveDialog1.FileName:='NOP.txt';
  if SaveDialog1.Execute then
    StringGrid1.SaveToFile(SaveDialog1.FileName);
  SaveDialog1.FileName:='q.txt';
  if SaveDialog1.Execute then StringGrid2.SaveToFile(SaveDialog1.FileName);
End;
//*************************************************************
Procedure TForm2.Button2Click(Sender: TObject);
Begin
  if OpenDialog1.Execute then
    StringGrid1.LoadFromFile(OpenDialog1.FileName);
  if OpenDialog1.execute then
    StringGrid2.LoadFromFile(OpenDialog1.FileName);
End;
//*************************************************************
Procedure TForm2.Button3Click(Sender: TObject);
var
  i,j:integer;
Begin
  for i:=0 to kR-1 do
    q1[i]:=StrtoFloat(StringGrid2.Cells[1,i]);
  for i:=0 to L-1 do
    for j:=0 to L-1 do
      Psi[i,j]:=StrtoInt(StringGrid1.Cells[j+1,i+1]);
End;
//*************************************************************
Procedure TForm2.Button4Click(Sender: TObject);
Begin
  close;
  Form3:=TForm3.Create(Self);
  Form3.ShowModal;
End;
//*************************************************************
END.

