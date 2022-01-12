UNIT Unit2;

{$mode objfpc}{$H+}
//*************************************************************
                           INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
//*************************************************************
                          IMPLEMENTATION
//*************************************************************
{$R *.lfm}
Uses Unit1;
{ TForm2 }
//*************************************************************
Procedure TForm2.FormCreate(Sender: TObject);
Begin
  Edit1.Text:=InttoStr(L1);
  Edit2.Text:=InttoStr(kR1);
  Edit3.Text:=InttoStr(kP1);
  Edit4.Text:=InttoStr(kW1);
  Edit5.Text:=InttoStr(kV1);
  Edit6.Text:=InttoStr(Mout1);
  Edit7.Text:=InttoStr(nfu1);
End;
//*************************************************************
Procedure TForm2.Button1Click(Sender: TObject);
Begin
    L1:=StrtoInt(Edit1.Text);
    kR1:=StrtoInt(Edit2.Text);
    kP1:=StrtoInt(Edit3.Text);
    kW1:=StrtoInt(Edit4.Text);
    kV1:=StrtoInt(Edit5.Text);
    Mout1:=StrtoInt(Edit6.Text);
    nfu1:=StrtoInt(Edit7.Text);
    Close;
End;
//*************************************************************

END.

