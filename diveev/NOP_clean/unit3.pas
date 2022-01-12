UNIT Unit3;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;
type
  { TForm3 }
  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form3: TForm3;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
Uses Unit1;
{$R *.lfm}

{ TForm3 }
//*************************************************************
Procedure TForm3.FormCreate(Sender: TObject);
Begin
  Edit1.Text:=InttoStr(HH1);
  Edit2.Text:=InttoStr(PP1);
  Edit3.Text:=InttoStr(RR1);
  Edit4.Text:=InttoStr(nfu1);
  Edit5.Text:=InttoStr(lchr1);
  Edit6.Text:=InttoStr(p1);
  Edit7.Text:=InttoStr(c1);
  Edit8.Text:=InttoStr(d1);
  Edit9.Text:=InttoStr(Epo1);
  Edit10.Text:=InttoStr(kel1);
  Edit11.Text:=FloattoStr(alfa1);
  Edit12.Text:=FloattoStr(pmut1);
  Edit13.Text:=FloattoStr(Shtraf1);
  Edit14.Text:=FloattoStr(weight);
End;
//*************************************************************
Procedure TForm3.Button1Click(Sender: TObject);
Begin
  HH1:=StrtoInt(Edit1.Text);
  PP1:=StrtoInt(Edit2.Text);
  RR1:=StrtoInt(Edit3.Text);
  nfu1:=StrtoInt(Edit4.Text);
  lchr1:=StrtoInt(Edit5.Text);
  p1:=StrtoInt(Edit6.Text);
  c1:=StrtoInt(Edit7.Text);
  d1:=StrtoInt(Edit8.Text);
  Epo1:=StrtoInt(Edit9.Text);
  kel1:=StrtoInt(Edit10.Text);
  alfa1:=StrtoFloat(Edit11.Text);
  pmut1:=StrtoFloat(Edit12.Text);
  Shtraf1:=StrtoFloat(Edit13.Text);
  weight:=StrtoFloat(Edit14.Text);
  Close;
End;
//*************************************************************

//*************************************************************
END.

