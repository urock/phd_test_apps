UNIT Unit14;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls;

type

  { TForm14 }

  TForm14 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1LineSeries5: TLineSeries;
    Chart1LineSeries6: TLineSeries;
    Chart1LineSeries7: TLineSeries;
    Chart1LineSeries8: TLineSeries;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form14: TForm14;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm14 }
//*************************************************************
Procedure TForm14.Button1Click(Sender: TObject);
var
  i,kol:integer;
  dxx,xx,yy:real;
Begin
  Chart1LineSeries1.Clear;
  Chart1LineSeries2.Clear;
  Chart1LineSeries3.Clear;
  Chart1LineSeries4.Clear;
  Chart1LineSeries5.Clear;
  Chart1LineSeries6.Clear;
  Chart1LineSeries7.Clear;
  Chart1LineSeries8.Clear;
  for i:=0 to kolpoint_mult[0]-1 do
    Chart1LineSeries1.AddXY(xmm[0,0,i],xmm[0,1,i]);
  for i:=0 to kolpoint_mult[1]-1 do
    Chart1LineSeries2.AddXY(xmm[1,0,i],xmm[1,1,i]);
  for i:=0 to kolpoint_mult[2]-1 do
    Chart1LineSeries3.AddXY(xmm[2,0,i],xmm[2,1,i]);
  for i:=0 to kolpoint_mult[3]-1 do
    Chart1LineSeries4.AddXY(xmm[3,0,i],xmm[3,1,i]);
  for i:=0 to kolpoint_mult[4]-1 do
    Chart1LineSeries5.AddXY(xmm[4,0,i],xmm[4,1,i]);
  for i:=0 to kolpoint_mult[5]-1 do
    Chart1LineSeries6.AddXY(xmm[5,0,i],xmm[5,1,i]);
  for i:=0 to kolpoint_mult[6]-1 do
    Chart1LineSeries7.AddXY(xmm[6,0,i],xmm[6,1,i]);
  for i:=0 to kolpoint_mult[7]-1 do
    Chart1LineSeries8.AddXY(xmm[7,0,i],xmm[7,1,i]);
End;
//*************************************************************
Procedure TForm14.Button2Click(Sender: TObject);
Begin
  SaveDialog1.FileName:='MultGraph_'+InttoStr(kChoose)+'.bmp';
  if SaveDialog1.Execute then
    Chart1.SaveToBitmapFile(SaveDialog1.FileName);
End;
//*************************************************************
END.

