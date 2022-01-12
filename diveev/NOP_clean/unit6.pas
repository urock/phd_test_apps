UNIT Unit6;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids;
type
  { TForm6 }
  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form6: TForm6;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
Uses Unit1;
{$R *.lfm}

{ TForm6 }
//*************************************************************
Procedure TForm6.FormCreate(Sender: TObject);
var
  i,j:integer;
  Str:String;
Begin
  StringGrid1.RowCount:=kR1;
  StringGrid1.ColWidths[1]:=84;
  StringGrid2.RowCount:=L1+1;
  StringGrid2.ColCount:=L1+1;
  for i:=0 to p1-1 do
  begin
    StringGrid1.Cells[0,i]:='q['+InttoStr(i)+']';
    StringGrid1.Cells[1,i]:=FloattoStrf(q1[i],ffFixed,8,5);
  end;
  for i:=1 to L1 do
  begin
    StringGrid2.Cells[i,0]:=InttoStr(i);
    StringGrid2.Cells[0,i]:=InttoStr(i);
  end;
  for i:=0 to L1-1 do
    for j:=0 to L1-1 do
      StringGrid2.Cells[j+1,i+1]:=InttoStr(psi1[i,j]);
End;
//*************************************************************
Procedure TForm6.Button2Click(Sender: TObject);
Begin
  SaveDialog1.FileName:='NOP_'+InttoStr(kChoose)+'.txt';
  if SaveDialog1.Execute then
    StringGrid2.SaveToFile(SaveDialog1.FileName);
  SaveDialog1.FileName:='q_'+InttoStr(kChoose)+'.txt';
  if SaveDialog1.Execute then StringGrid1.SaveToFile(SaveDialog1.FileName);
End;
//*************************************************************
Procedure TForm6.Button1Click(Sender: TObject);
var
  i,j,k:integer;
  Str,Str1:string;
Begin
  for i:=0 to p1-1 do
    q1[i]:=StrtoFloat(StringGrid1.Cells[1,i]);
  for i:=0 to L1-1 do
    for j:=0 to L1-1 do
      psi1[i,j]:=StrtoInt(StringGrid2.Cells[j+1,i+1]);
End;
//*************************************************************
Procedure TForm6.Button3Click(Sender: TObject);
Begin
  if OpenDialog1.Execute then
    StringGrid2.LoadFromFile(OpenDialog1.FileName);
  if OpenDialog1.execute then
    StringGrid1.LoadFromFile(OpenDialog1.FileName);
End;
//*************************************************************
Procedure TForm6.Button4Click(Sender: TObject);
Begin
  Close;
End;
//*************************************************************
END.

