unit UGota;

interface

uses
  System.Types, FMX.Objects, FMX.Graphics;

type
  TGota = class(TObject)
    vlienzo: TRectangle;
    Canvas: TCanvas;
    alfa: single;
    dir, gravedad: TPointf;
  private
    InicioenY: Shortint;
    procedure InicializaGota;
    procedure ChecarPorReinicio;
  public
    Centro: TPointf;
    constructor Create(fLienzo: TRectangle);
    function randomDir: TPointf;
    procedure Update;
    procedure Draw;
  end;

implementation

{ TGota }

uses
  System.UiTypes;

constructor TGota.Create(fLienzo: TRectangle);
begin
  InicioenY := 10;
  vlienzo := fLienzo;
  Canvas := vlienzo.Canvas;
  InicializaGota;
end;

procedure TGota.Draw;
var
  R: Trect;
begin
  R := Trect.Empty;
  R.Location := Centro.Round;
  R.Inflate(2, 2);
  Canvas.Fill.Color := TAlphaColors.Aqua;
  Canvas.Stroke.Color := TAlphaColors.Aqua;
  Canvas.FillEllipse(R, alfa);
end;

procedure TGota.ChecarPorReinicio;
begin

  if (Centro.Y > Round(vlienzo.Height - InicioenY)) or (alfa <= 0) then
  begin
    InicializaGota;
  end;
end;

procedure TGota.InicializaGota;
begin
  Centro.Y := Round(vlienzo.Height - InicioenY);
  Centro.x := Round(vlienzo.Width / 2);
  dir := randomDir;
  alfa := 1;
  gravedad.Y := 1;
  gravedad.x := 0;
end;

function TGota.randomDir: TPointf;
var
  tdir: TPointf;
begin
  tdir.x := random(4);

  if tdir.x = 0 then
    if random(100) > 10 then
      tdir.x := 0.3;

  if random(100) > 50 then
  begin
    tdir.x := tdir.x * -1;
  end;

  tdir.Y := -random(35);
  if tdir.Y > -30 then
    if random(100) > 10 then
      tdir.Y := tdir.Y - (20);

  tdir := tdir * random();
  result := tdir;
end;

procedure TGota.Update;
begin
  ChecarPorReinicio;
  Centro.Offset(dir);
  dir.Offset(gravedad);
  alfa := alfa - 0.013;
end;

end.
