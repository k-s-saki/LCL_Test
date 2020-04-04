unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    BtnDbForm: TButton;
    BtnPrint: TButton;
    BtnGrid: TButton;
    BtnDB1: TButton;
    procedure BtnDB1Click(Sender: TObject);
    procedure BtnDbFormClick(Sender: TObject);
    procedure BtnGridClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
  private

  public

  end;

var
  FrmMain: TFrmMain;

implementation

uses GridTest, DbFormTest, FirebirdTest,PrintTest;

{$R *.lfm}

{ TFrmMain }

procedure TFrmMain.BtnDbFormClick(Sender: TObject);
begin
  FrmDbForm:=TFrmDbForm.Create(Nil);
  FrmDbForm.ShowModal;
  FreeAndNil(FrmDbForm);
end;

procedure TFrmMain.BtnDB1Click(Sender: TObject);
begin
  FrmDB:=TFrmDB.Create(nil);
  FrmDB.ShowModal;
  FreeAndNil(FrmDB);
end;

procedure TFrmMain.BtnGridClick(Sender: TObject);
begin
  FrmGrid:=TFrmGrid.Create(nil);
  FrmGrid.ShowModal;
  FreeAndNil(FrmGrid);
end;

procedure TFrmMain.BtnPrintClick(Sender: TObject);
begin
  FrmPrint:=TFrmPrint.Create(nil);
  FrmPrint.ShowModal;
  FreeAndNil(FrmPrint);
end;

end.

