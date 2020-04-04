program LCL_Test;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, GridTest, firebirdtest, main, DbFormTest, printtest
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmPrint, FrmPrint);
  //Application.CreateForm(TFrmDbForm, FrmDbForm);
  //Application.CreateForm(TFrmDB, FrmDB);
  //Application.CreateForm(TFrmGrid, FrmGrid);
  Application.Run;
end.

