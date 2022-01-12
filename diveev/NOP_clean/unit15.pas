UNIT Unit15;

{$mode objfpc}{$H+}
//*************************************************************
                     INTERFACE
//*************************************************************
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;
type

  { TForm15 }

  TForm15 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form15: TForm15;
//*************************************************************
                           IMPLEMENTATION
//*************************************************************
Uses Unit1;
{$R *.lfm}
{ TForm15 }
//*************************************************************
Procedure TForm15.Button1Click(Sender: TObject);
Begin
  if Savedialog1.Execute then
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
End;
//*************************************************************
Procedure TForm15.FormCreate(Sender: TObject);
var
  i:integer;
Begin
  Memo1.Width:=Clientwidth;
  Memo1.clear;
  ASNEE.NOP.PsitoPasStr;
  for i:= 0 to ASNEE.NOP.L-1 do
    Memo1.Lines.Add(ASNEE.NOP.zs[i]);
End;
//*************************************************************
END.

