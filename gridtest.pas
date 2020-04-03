unit GridTest;
(*
  Lazarus 2.0.4

*)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls,
  ExtCtrls, LCLType;

type

  { TFrmGrid }

  TFrmGrid = class(TForm)
    goFixedVertLine: TCheckBox;
    mmDebug: TMemo;
    Panel1: TPanel;
    pnlOption: TPanel;
    SG: TStringGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxOptionChange(Sender: TObject);
    procedure SGPickListSelect(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure SGSelectEditor(Sender: TObject; aCol, aRow: Integer;
      var Editor: TWinControl);
    procedure SGSelection(Sender: TObject; aCol, aRow: Integer);
    procedure SGSetCheckboxState(Sender: TObject; ACol, ARow: Integer;
      const Value: TCheckboxState);
    procedure SGSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure SGTopLeftChanged(Sender: TObject);
    procedure SGUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
  private
    cbxOption: array[0..31] of TCheckBox;
  public
    procedure Debug(s:string);
  end;

var
  FrmGrid: TFrmGrid;

implementation

{$R *.lfm}

{ TFrmGrid }

uses typinfo;

function GridOptionsToString(go: TGridOption): string;
begin
  Result := GetEnumName(typeInfo(TGridOption), Ord(go));
end;

procedure TFrmGrid.FormShow(Sender: TObject);
var
  i:integer;
  c:TCheckBox;
  go:TGridOption;
begin
  mmDebug.Align:= alClient;
  for i := Ord(Low(TGridOption)) to Ord(High(TGridOption)) do
  begin
    c:=TCheckBox.Create(Self);
    cbxOption[i]:=c;
    c.Parent:=Panel1;
    go:=TGridOption(i);
    c.Caption:=GridOptionsToString( go );
    c.OnChange:= @cbxOptionChange;
    c.Left:=24;
    c.Top:=5+i*18;
  end;
  SG.Options:=[];
end;

procedure TFrmGrid.FormCreate(Sender: TObject);
begin

end;




procedure TFrmGrid.cbxOptionChange(Sender: TObject);
var
  go:TGridOption;
  go_set:TGridOptions;
  i:integer;
  s:string;
  cb:TCheckBox;
begin
  cb:= Sender as TCheckBox;
  go_set:= SG.Options;

  for i := Ord(Low(TGridOption)) to Ord(High(TGridOption)) do
  begin
    go:=TGridOption(i);
    s:= GridOptionsToString(go);
    if CompareText(s,cb.Caption)=0 then
    begin
      if cb.Checked then
        go_set:= go_set + [go]
      else
        go_set:= go_set - [go];
      break;
    end;
  end;

  SG.Options:= go_set;
end;

procedure TFrmGrid.SGPickListSelect(Sender: TObject);
begin
  Debug('SGPickListSelect');
end;

procedure TFrmGrid.SGSelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  Debug('SGSelectCell');
end;

procedure TFrmGrid.SGSelectEditor(Sender: TObject; aCol, aRow: Integer;
  var Editor: TWinControl);
begin
  Debug('SGSelectEditor');
end;

procedure TFrmGrid.SGSelection(Sender: TObject; aCol, aRow: Integer);
begin
  Debug('OnSelection');
end;

procedure TFrmGrid.SGSetCheckboxState(Sender: TObject; ACol, ARow: Integer;
  const Value: TCheckboxState);
begin
  Debug('OnSetCheckboxState');
end;

procedure TFrmGrid.SGSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  Debug('OnSetEditText');

end;

procedure TFrmGrid.SGTopLeftChanged(Sender: TObject);
begin
  Debug('OnTopLeftChanged');
end;

procedure TFrmGrid.SGUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char
  );
begin
  Debug('OnUTF8KeyPress: Key='+UTF8Key);
end;

procedure TFrmGrid.Debug(s: string);
begin
  mmDebug.Lines.Add(s);
end;

end.

