UNIT Unit12;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, TASources, TAGraph, TASeries, Forms, Controls,
  Graphics, Dialogs, StdCtrls;

type

  { TForm12 }

  TForm12 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    ComboBox1: TComboBox;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form12: TForm12;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm12 }
//*************************************************************
Procedure TForm12.FormCreate(Sender: TObject);
var
  i:integer;
Begin
  for i:= 0 to nfu1 -1 do
    ComboBox1.Items.Add(InttoStr(i));
  ComboBox1.ItemIndex:=0;
End;
//*************************************************************
Procedure TForm12.Button1Click(Sender: TObject);
var
  i:integer;
Begin
  Chart1LineSeries1.Clear;
  for i:= 0 to pp1 -1 do
    Chart1LineSeries1.AddXY(i,ASNEE.Fuhminm[ComboBox1.ItemIndex,i]);
End;
//*************************************************************
Procedure TForm12.Button2Click(Sender: TObject);
Begin
  SaveDialog1.FileName:='j'+InttoStr(ComboBox1.ItemIndex)+'_'+InttoStr(kChoose)+'.bmp';
  if Savedialog1.Execute then
    Chart1.SaveToBitmapFile(saveDialog1.FileName);
End;
//*************************************************************
END.

