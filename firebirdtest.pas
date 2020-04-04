unit firebirdtest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, IBConnection, Forms, Controls, Graphics,
  Dialogs, DBGrids;

type

  { TFrmDB }

  TFrmDB = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    IBConnection1: TIBConnection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
  private

  public

  end;

var
  FrmDB: TFrmDB;

implementation

{$R *.lfm}

end.

