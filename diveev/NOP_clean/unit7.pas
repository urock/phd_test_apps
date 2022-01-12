UNIT Unit7;
{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm7 }

  TForm7 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form7: TForm7;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
Uses Unit1;
{$R *.lfm}

{ TForm7 }
//*************************************************************
Procedure TForm7.FormCreate(Sender: TObject);
Begin
  Edit1.Text:=InttoStr(PP1);
  Edit2.Text:=InttoStr(RR1);
  Edit3.Text:=InttoStr(Epo1);
  Edit4.Text:=InttoStr(kel1);
  Edit5.Text:=FloattoStrf(alfa1,ffFixed,6,4);
  Edit6.Text:=FloattoStrf(pmut1,ffFixed,6,4);
  Edit7.Text:=FloattoStrf(Shtraf1,ffFixed,6,4);
  Edit8.Text:=FloattoStrf(weight,ffFixed,6,4);
End;
//*************************************************************
Procedure TForm7.Button1Click(Sender: TObject);
Begin
  PP1:=StrtoInt(Edit1.Text);
  RR1:=StrtoInt(Edit2.Text);
  Epo1:=StrtoInt(Edit3.Text);
  Kel1:=StrtoInt(Edit4.Text);
  alfa1:=StrtoFloat(Edit5.Text);
  pmut1:=StrtoFloat(Edit6.Text);
  Shtraf1:=StrtoFloat(Edit7.Text);
  weight:=StrtoFloat(Edit8.Text);

  Close;
End;
//*************************************************************
END.

