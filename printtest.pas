unit printtest;
(*
資料: https://wiki.lazarus.freepascal.org/fpvectorial#Rendering_the_image_into_a_TCanvas

プロジェクトオプションのコンパイルオプション-パス-その他に、

$(LazarusDir)\components\fpvectorial

を設定する


*)


{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFrmPrint }

  TFrmPrint = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  FrmPrint: TFrmPrint;

implementation

uses
  fpvectorial, svgvectorialwriter,{ pdfvectorialreader,} wmfvectorialwriter ;


{$R *.lfm}

{ TFrmPrint }

procedure TFrmPrint.Button1Click(Sender: TObject);
const
  //cFormat = vfSVG;
  //cExtension = '.svg';
  //cFormat = vfPDF;
  //cExtension = '.pdf';
  cFormat = vfWindowsMetafileWMF;
  cExtension = '.wmf';
var
  VecDoc: TvVectorialDocument;
  Vec: TvVectorialPage;
  TextStyle: TvStyle;
begin
  VecDoc := TvVectorialDocument.Create;

  // Add our own Style for bolded text elements
  TextStyle := VecDoc.AddStyle();
  TextStyle.Kind := vskTextSpan; // This style will only be applied to selected Text Spans
  TextStyle.Name := 'Bold';
  TextStyle.Font.Bold := True;
  TextStyle.Font.Name := 'ＭＳ ゴシック';
  TextStyle.Font.Size := 14;
  //TextStyle.SetElements := BoldTextStyle.SetElements + [spbfFontBold];

  try
    Vec := VecDoc.AddPage();
    // All documents are 10cm x 10cm
    Vec.Width := 100;
    Vec.Height := 100;

    // ...

    // multi_test_1     Combines various elements
    Vec.Clear;
    Vec.StartPath(0, 20);
    Vec.AddLineToPath(30, 30);
    Vec.EndPath();
    Vec.StartPath(0, 0);
    Vec.AddLineToPath(100, 0);
    Vec.AddLineToPath(100, 100);
    Vec.AddLineToPath(0, 100);
    Vec.AddLineToPath(0, 0);
    Vec.EndPath();
    Vec.StartPath(0, 0);
    Vec.AddLineToPath(10, 10);
    Vec.AddBezierToPath(10, 20, 20, 20, 20, 10);
    Vec.AddLineToPath(30, 0);
    Vec.EndPath();
    (*
    (WMF)日本語の表示が文字化けする
        UTF8がISO_8859_1に変換されている UTF8ToISO_8859_1
        　　　UTF8ToISO_8859_1変換を無効にしても変化なし
        　　　                変換を Utf8Decodeにしても変化なし

    (SVG)日本語の表示が文字化けする
        fpvectorialの関数をutf8string から stringへ変更  文字化けは治ったが、日本語の文字の大きさが小さい
    *)

    Vec.AddText(10, 10, 0, 'ＭＳ ゴシック',10,'10,10 Some text in english.');
    Vec.AddText(20, 20, 0, 'ＭＳ ゴシック',12,'20, 20 富士山麓にオオムなく');
    Vec.AddText(30, 30, 0, 'ＭＳ ゴシック',14,'30, 30 人世ひとよに');
    //Vec.AddText(20, 20, 0, 'ＭＳ ゴシック',12,'20, 20 Mówić, cześć, Włosku, Parabéns.');
    //Vec.AddText(30, 30, 0, 'ＭＳ ゴシック',14,'30, 30 森林，是一个高密');
    VecDoc.WriteToFile('multi_test_1' + cExtension, cFormat);
  finally
    VecDoc.Free;
  end;
end;

end.

