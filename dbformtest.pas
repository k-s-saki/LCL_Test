unit DbFormTest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, PairSplitter,
  ExtCtrls, Buttons, ExtendedNotebook, SynHighlighterSQL, SynEdit, DB, sqldb,
  IBConnection;

type

  { TFrmDbForm }

  TFrmDbForm = class(TForm)
    BitBtn1: TBitBtn;
    EdtResult: TSynEdit;
    Panel1: TPanel;
    Split: TPairSplitter;
    SPnl1: TPairSplitterSide;
    SPnl2: TPairSplitterSide;
    EdtSQL: TSynEdit;
    SynSQL: TSynSQLSyn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    IB:TIBConnection;
    Tr:TSQLTransaction;
    Qry:TSQLQuery;

    procedure InitDB();
    procedure Debug(s:string);
  end;

var
  FrmDbForm: TFrmDbForm;

implementation

{$R *.lfm}

{ TFrmDbForm }

procedure TFrmDbForm.FormCreate(Sender: TObject);
begin
  Split.Align:=alClient;
  Split.Position:=Split.Height div 2;
  EdtSQL.Align:=alClient;
  EdtResult.Align:= alClient;

  IB:=TIBConnection.Create(Self);
  Tr:=TSQLTransaction.Create(Self);
  Qry:=TSQLQuery.Create(Self);

  InitDb();

end;

procedure TFrmDbForm.InitDB();
begin
  IB.UserName:='sysdba';
  IB.Password:='masterkey';
  IB.DatabaseName:='P:\Current\FDB\TEST\TEST.FB25.UTF8.FDB';
  IB.HostName:='172.17.5.100';
  IB.Transaction:=Tr;

  Qry.DataBase:= IB;
  Qry.Transaction:= Tr;


  IB.Connected:=true;
end;

procedure TFrmDbForm.Debug(s: string);
begin
  EdtResult.Lines.Add(s);
end;

procedure TFrmDbForm.BitBtn1Click(Sender: TObject);
var i:integer;
begin
  //
  Qry.SQL.Text:= EdtSQL.Lines.Text;
  Qry.Open;
  i:=0;
  while not Qry.Eof do
  begin
    inc(i);
    Debug('Find record '+IntToStr(i));
    Qry.Next;
  end;
end;

end.

