unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, uGota;

type
  TForm2 = class(TForm)
    Lienzo: TRectangle;
    FloatAnimation1: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimation1Process(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LienzoPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Gotas: TObjectList<TGota>;
  CuantasGotas: integer = 500;

implementation

{$R *.fmx}

procedure TForm2.FloatAnimation1Process(Sender: TObject);
begin
  Lienzo.Repaint;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  I: integer;
  g: TGota;
begin
  Gotas := TObjectList<TGota>.Create(True);
  for I := 1 to CuantasGotas do
  begin
    g := TGota.Create(Lienzo);
    Gotas.Add(g);
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  Gotas.Destroy;
end;

procedure TForm2.LienzoPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  I: integer;
begin
  Canvas.BeginScene();
  for I := 0 to Gotas.Count - 1 do
  begin
    Gotas[I].Update;
    Gotas[I].Draw;
  end;
  Canvas.EndScene;
end;

end.