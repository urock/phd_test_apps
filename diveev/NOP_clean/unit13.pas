unit Unit13;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls;

type

  { TForm13 }

  TForm13 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form13: TForm13;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;

{ TForm13 }
//*************************************************************
Procedure TForm13.Button1Click(Sender: TObject);
var
  i,j:integer;
Begin
  for i:=0 to nGraphc-1 do
    for j:=0 to ny1-1 do
      qyGraph[j,i]:=StrtoFloat(StringGrid1.Cells[j+1,i+1]);
  Close;
End;
//*************************************************************
Procedure TForm13.FormCreate(Sender: TObject);
var
  i:integer;
Begin
  StringGrid1.RowCount:=nGraphc+1;
  StringGrid1.ColWidths[0]:=32;
  for i:=0 to ny1-1 do
    StringGRid1.Colwidths[i+1]:=84;
  for i:=0 to ny1-1 do
  begin
    qy1[i]:=qymin1[i];
    StringGrid1.Cells[i+1,0]:='qy['+Inttostr(i)+']';
  end;
  for i:=0 to nGraphc-1 do
    StringGrid1.Cells[0,i+1]:=InttoStr(i);
  StringGrid1.Cells[1,1]:=FloattoStrf(qymin1[0],ffFixed,6,2);
  StringGrid1.Cells[2,1]:=FloattoStrf(qymin1[1],ffFixed,6,2);
  StringGrid1.Cells[3,1]:=FloattoStrf(qymin1[2],ffFixed,6,2);
  StringGrid1.Cells[1,2]:=FloattoStrf(qymin1[0],ffFixed,6,2);
  StringGrid1.Cells[2,2]:=FloattoStrf(qymin1[1],ffFixed,6,2);
  StringGrid1.Cells[3,2]:=FloattoStrf(qymax1[2],ffFixed,6,2);
  StringGrid1.Cells[1,3]:=FloattoStrf(qymin1[0],ffFixed,6,2);
  StringGrid1.Cells[2,3]:=FloattoStrf(qymax1[1],ffFixed,6,2);
  StringGrid1.Cells[3,3]:=FloattoStrf(qymin1[2],ffFixed,6,2);
  StringGrid1.Cells[1,4]:=FloattoStrf(qymin1[0],ffFixed,6,2);
  StringGrid1.Cells[2,4]:=FloattoStrf(qymax1[1],ffFixed,6,2);
  StringGrid1.Cells[3,4]:=FloattoStrf(qymax1[2],ffFixed,6,2);
  StringGrid1.Cells[1,5]:=FloattoStrf(qymax1[0],ffFixed,6,2);
  StringGrid1.Cells[2,5]:=FloattoStrf(qymin1[1],ffFixed,6,2);
  StringGrid1.Cells[3,5]:=FloattoStrf(qymin1[2],ffFixed,6,2);
  StringGrid1.Cells[1,6]:=FloattoStrf(qymax1[0],ffFixed,6,2);
  StringGrid1.Cells[2,6]:=FloattoStrf(qymin1[1],ffFixed,6,2);
  StringGrid1.Cells[3,6]:=FloattoStrf(qymax1[2],ffFixed,6,2);
  StringGrid1.Cells[1,7]:=FloattoStrf(qymax1[0],ffFixed,6,2);
  StringGrid1.Cells[2,7]:=FloattoStrf(qymax1[1],ffFixed,6,2);
  StringGrid1.Cells[3,7]:=FloattoStrf(qymin1[2],ffFixed,6,2);
  StringGrid1.Cells[1,8]:=FloattoStrf(qymax1[0],ffFixed,6,2);
  StringGrid1.Cells[2,8]:=FloattoStrf(qymax1[1],ffFixed,6,2);
  StringGrid1.Cells[3,8]:=FloattoStrf(qymax1[2],ffFixed,6,2);
End;

//*************************************************************
END.

