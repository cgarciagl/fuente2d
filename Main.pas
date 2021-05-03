unit Main;

interface

uses
  System.SysUtils, System.Types, System.Classes, System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Objects, FMX.Ani, uGota;

type
  TForm2 = class(TForm)
    Lienzo: TRectangle;
    FloatAnimation1: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimation1Process(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LienzoPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure LienzoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Gotas: TObjectList<TGota>;
  CuantasGotas: integer = 1000;

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
  GlobalUseDX10Software := True;
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

procedure TForm2.LienzoClick(Sender: TObject);
var
  I: integer;
begin
  for I := 0 to Gotas.Count - 1 do
  begin
    Gotas[I].InicializaGota;
  end;
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
