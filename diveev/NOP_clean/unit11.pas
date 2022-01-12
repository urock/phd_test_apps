UNIT Unit11;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Menus;

type

  { TForm11 }

  TForm11 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
  TArrReal=array of real;
var
  Form11: TForm11;
  funm,argm:TArrReal;
//*************************************************************
                            IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm11 }
//*************************************************************
Procedure TForm11.Button2Click(Sender: TObject);
Begin
  SaveDialog1.FileName:='Plot_'+InttoStr(ComboBox1.ItemIndex)+'_'+
  InttoStr(ComboBox2.ItemIndex)+'.bmp';
  if SaveDialog1.Execute then
    Chart1.SaveToBitmapFile(SaveDialog1.FileName);
End;
//*************************************************************
Procedure TForm11.FormCreate(Sender: TObject);
var
  i:integer;
Begin
  ComboBox1.Clear;
  ComboBox2.Clear;
  ComboBox1.Items.Add('t');
  ComboBox2.Items.Add('t');
  SetLength(funm,high(tm)+1);
  SetLength(argm,high(tm)+1);
  Label3.Caption:='J1='+FloattoStrf(f0,ffFixed,8,4);
  Label4.Caption:='J2='+FloattoStrf(f1,ffFixed,8,4);
  for i:=0 to ll1-1 do
  begin
    ComboBox1.Items.Add('y['+inttostr(i)+']');
    ComboBox2.Items.Add('y['+inttostr(i)+']');
  end;
  for i:=0 to m1-1 do
  begin
    ComboBox1.Items.Add('u['+inttostr(i)+']');
    ComboBox2.Items.Add('u['+inttostr(i)+']');
  end;
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=1;
End;

//*************************************************************
Procedure TForm11.Button1Click(Sender: TObject);
var
  i:integer;
Begin
  if ComboBox1.ItemIndex=0 then
    for i:=0 to kolpoint-1 do
      argm[i]:=tm[i]
  else
    if ComboBox1.ItemIndex<=n1 then
      for i:=0 to kolpoint-1 do
        argm[i]:=ym[ComboBox1.ItemIndex-1,i]
    else
      for i:=0 to kolpoint-1 do
        argm[i]:=um[ComboBox1.ItemIndex-n1-1,i];
  if ComboBox2.ItemIndex=0 then
    for i:=0 to high(tm) do
      funm[i]:=tm[i]
  else
    if ComboBox2.ItemIndex<=n1 then
      for i:=0 to kolpoint-1 do
        funm[i]:=ym[ComboBox2.ItemIndex-1,i]
    else
      for i:=0 to kolpoint-1 do
        funm[i]:=um[ComboBox2.ItemIndex-n1-1,i];
  Chart1LineSeries1.Clear;
  for i:=0 to kolpoint-1 do
    Chart1LineSeries1.AddXY(argm[i],funm[i]);
End;
//*************************************************************
END.

