program LCL_Test;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, printer4lazarus, GridTest, firebirdtest, main, DbFormTest,
  printtest, PrintTest2
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmPrint, FrmPrint);
  Application.CreateForm(TFrmPrint2, FrmPrint2);
  //Application.CreateForm(TFrmDbForm, FrmDbForm);
  //Application.CreateForm(TFrmDB, FrmDB);
  //Application.CreateForm(TFrmGrid, FrmGrid);
  Application.Run;
end.

