unit PrintTest2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  PrintersDlgs;

type

  { TFrmPrint2 }

  TFrmPrint2 = class(TForm)
    BtnFpPDF: TButton;
    BtnCanvasPreview: TButton;
    BtnCanvasPrint: TButton;
    PbxPage: TPaintBox;
    PrintDialog1: TPrintDialog;
    procedure BtnCanvasPreviewClick(Sender: TObject);
    procedure BtnFpPDFClick(Sender: TObject);
    procedure BtnCanvasPrintClick(Sender: TObject);
  private

  public
    procedure DrawToCanvas(C:TCanvas);
  end;

var
  FrmPrint2: TFrmPrint2;

implementation

uses
  fpPDF,Printers;

{$R *.lfm}

{ TFrmPrint2 }

procedure TFrmPrint2.BtnFpPDFClick(Sender: TObject);
var
  D:TpdfDocument;
  S:TPdfSection;
  P:TPdfPage;
begin
  D:=TpdfDocument.Create(nil);
  try
    D.Infos.Title := 'あいうえお"';
    D.Infos.Author := 'ABCD';
    D.Infos.Producer := 'fcl-pdf';
    D.Infos.ApplicationName := 'TEST';
    D.Infos.CreationDate := Now;
    //D.Infos.KeyWords:='fcl-pdf report';

    D.Options := [poPageOriginAtTop,poSubsetFont,poCompressFonts,
                 poCompressImages{,poUseImageTransparency, poUTF16Info}];

    D.StartDocument;
    //D.AddFont('fonts/FreeSans.ttf','FreeSans');
    D.AddFont('msgothic.ttc','ＭＳ ゴシック');
    //D.AddFont('gothic');

    S:=D.Sections.AddSection;

    P:=D.Pages.AddPage;
    P.PaperType := ptA4;
    P.UnitOfMeasure := uomPixels;
    P.Orientation:=ppoPortrait;
    S.AddPage(P);

    P.SetFont(0,10);

    {
    P.WriteText(100,100,'Мой родны кут,');
    P.WriteText(100,150,'Як ты мне мілы');
    P.WriteText(100,200,'Забыць цябе');
    P.WriteText(100,250,'Не маю сілы');
    }
    P.WriteText(100,100,'英語');
    P.WriteText(100,150,'国語');
    P.WriteText(100,200,'算数');
    P.WriteText(100,250,'理科');

  finally
    D.SaveToFile('test.pdf');
    D.Free;
  end;
end;

procedure TFrmPrint2.BtnCanvasPreviewClick(Sender: TObject);
begin
  DrawToCanvas(PbxPage.Canvas);
end;

procedure TFrmPrint2.BtnCanvasPrintClick(Sender: TObject);
var
  MyPrinter : TPrinter;
  SrcCv : TCanvas;
begin

  if PrintDialog1.Execute= false then
    exit;

  SrcCv:= PbxPage.Canvas;

  MyPrinter := Printer;
  MyPrinter.BeginDoc;
    myPrinter.Canvas.CopyRect(Classes.Rect(0, 0, myPrinter.PaperSize.Width, myPrinter.PaperSize.Height),
       SrcCv, Classes.Rect(0, 0, SrcCv.Width, SrcCv.Height));
  MyPrinter.EndDoc;
  //myBitMap.Free;
end;

procedure TFrmPrint2.DrawToCanvas(C: TCanvas);
const
  LEFTMARGIN = 100;
  HEADLINE = '初めてのテキスト';
var
  YPos, LineHeight, VerticalMargin: Integer;
  str: String;
begin
  C.Font.Name := 'ＭＳ ゴシック';
  C.Font.Size := 10;
  C.Font.Color := clBlack;
  LineHeight := Round(1.2 * Abs(Canvas.TextHeight('I')));
  VerticalMargin := 4 * LineHeight;
  YPos := VerticalMargin;
  str := HEADLINE + DateTimeToStr(Now);
  C.TextOut(LEFTMARGIN, YPos, str);
end;


end.

