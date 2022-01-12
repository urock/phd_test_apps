unit Unit9;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TALegendPanel, TAMultiSeries,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm9 }

  TForm9 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    ChartLegendPanel1: TChartLegendPanel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form9: TForm9;
  kol:integer;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm9 }
//*************************************************************
Procedure TForm9.FormCreate(Sender: TObject);
var
  i,j,k:integer;
Begin
  kol:=high(ASNEE.Pareto)+1;
  StringGrid1.ColCount:=nfu1+2;
  StringGrid1.RowCount:=kol+1;
  StringGrid1.Colwidths[0]:=32;
  StringGrid1.Colwidths[1]:=32;
  for i:=0 to nfu1-1 do
    StringGrid1.Colwidths[i+2]:=96;
  for i:=0 to kol-2 do
    for j:=i+1 to kol-1 do
      if ASNEE.Fuh[ASNEE.Pareto[i],0]>ASNEE.Fuh[ASNEE.Pareto[j],0]  then
      begin
        k:=ASNEE.Pareto[i];
        ASNEE.Pareto[i]:=ASNEE.Pareto[j];
        ASNEE.Pareto[j]:=k;
      end;
  for i:=0 to nfu1-1 do
    StringGrid1.Cells[2+i,0]:='F_'+inttostr(i);
  for i:=0 to kol-1 do
  begin
    StringGrid1.Cells[0,i+1]:=inttostr(i);
    StringGrid1.Cells[1,i+1]:=inttostr(ASNEE.Pareto[i]);
  end;
  for i:=0 to kol-1 do
    for j:=0 to nfu1-1 do
      StringGrid1.Cells[j+2,i+1]:=floattostrf(ASNEE.Fuh[ASNEE.Pareto[i],j],
                                  ffGeneral,8,4);
  ComboBox1.Clear;
  ComboBox2.Clear;
  Chart1LineSeries1.Clear;
  for i:=0 to nfu1-1 do
  begin
    ComboBox1.Items.Add(inttostr(i));
    ComboBox2.Items.Add(inttostr(i));
  end;
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=1;
  Button1.Click;
End;
//*************************************************************
Procedure TForm9.Button1Click(Sender: TObject);
var
  i:integer;
Begin
  Chart1LineSeries1.Clear;
  for i:=0 to kol-1 do
  Chart1LineSeries1.AddXY(ASNEE.Fuh[ASNEE.Pareto[i],ComboBox1.ItemIndex],
                ASNEE.Fuh[ASNEE.Pareto[i],ComboBox2.ItemIndex]);

End;
//*************************************************************
Procedure TForm9.Button2Click(Sender: TObject);
Begin
  if StringGrid1.Row>=1 then
    kChoose:=strtoint(StringGrid1.Cells[1,StringGrid1.Row])
  else
    kchoose:=ASNEE.Pareto[0];
  ASNEE.ReadChromosome(kchoose,q1,Psi1);
End;
//*************************************************************
Procedure TForm9.Button3Click(Sender: TObject);
  var
  i,j:integer;
  s:string;
Begin
  for i:=0 to StringGrid1.RowCount-1 do
  begin
    s:='';
    for j:=0 to StringGrid1.ColCount-1 do
      s:=s+StringGrid1.Cells[j,i]+' ';
    memo1.Lines.Add(s);
  end;
  savedialog1.FileName:='Pareto';
  if SaveDialog1.Execute then
  begin
    Chart1.SaveToBitmapFile(Savedialog1.FileName+'.bmp');
    Memo1.Lines.SaveToFile(Savedialog1.FileName+'.txt');
  end;
End;
//*************************************************************
END.

