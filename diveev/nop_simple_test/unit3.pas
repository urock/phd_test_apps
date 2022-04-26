unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
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

implementation

Uses Unit1, Unit2;
{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin
    Edit1.Text:=FloattoStr(x1[0]);
    Edit2.Text:=FloattoStr(x1[1]);
    Edit3.Text:=FloattoStrf(q1[0],ffFixed,8,5);
    Edit4.Text:=FloattoStrf(q1[1],ffFixed,8,5);
    Edit9.Text:=FloattoStrf(q1[2],ffFixed,8,5);
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  i: integer;
begin
  x1[0]:= StrtoFloat(Edit1.Text);
  x1[1]:= StrtoFloat(Edit2.Text);
  q1[0]:= StrtoFloat(Edit3.Text);
  q1[1]:= StrtoFloat(Edit4.Text);
  q1[2]:= StrtoFloat(Edit9.Text);
  y1[0]:=func_et1(x1,q1);
  y1[1]:=func_et2(x1,q1);
  for i:=0 to kR-1 do
    Cs[i]:=q1[i];
  for i:=0 to kP-1 do
    Vs[i]:=x1[i];
  RPcontrol;
  Edit5.Text:=FloattoStrf(y1[0],ffFixed,6,4);
  Edit6.Text:='';
  Edit7.Text:=FloattoStrf(z[Dnum[0]],ffFixed,6,4);
  Edit8.Text:='';
end;

end.

