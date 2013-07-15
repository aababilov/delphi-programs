//------------------------------------------------------------------------------
TFMain FMain;

#pragma resource "*.dfm"/* *.dfm*/

int mx, my, h, w;
Tbitmap HelpBM;
//------------------------------------------------------------------------------
void TFMain::ClformClick(TObject Sender)
{
  FMain.Close();
}
//------------------------------------------------------------------------------
void TFMain::FormCreate(TObject Sender)
{
  w = FMain.Width - 40;
  h = FMain.Height - 60;
  mx = Pic.Width / 2;
  my = Pic.Height / 2;
  HelpBM = TBitmap.Create;
  HelpBM.Width = Pic.Width;
  HelpBM.Height = Pic.Height;
}
//------------------------------------------------------------------------------
void TFMain::NMandClick(TObject Sender)
{
  const int MaxIter = 30;
  const int BailOut = 16;
  complex Wor, Wor2, BackUp;
  int x, y, count;
int f1(int a)
{
  int Result;
  Result = 255 - count % 254 - 2;
  return Result;
}
//------------------------------------------------------------------------------
  for (y = -my; y <= 0; y++)
    {
      int Verounit__1 = mx;
      for (x = -mx; x <= Verounit__1; x++)
      {
        count = 0;
        ToComplex(x / 250, y / 300, BackUp);
        ToComplex(0, 0, Wor);
        while ((((Sqr(Wor.r) + Sqr(Wor.i)) < BailOut) && (Count < MaxIter)))
        {
          Wor2 = Wor;
          CSqr(Wor2, Wor);
          CAdd(Wor, BackUp, Wor2);
          Wor = Wor2;
          Inc(Count);
        }
        if (count != MaxIter)
        {
          Pic.Canvas.Pixels[mx + x][my - y] = clWhite - count * 0x3FFF;
          Pic.Canvas.Pixels[mx + x][my - Abs(y)] = clWhite - count * 0x3FFF;
        }
        else
        {
          Pic.Canvas.Pixels[mx + x][my - y] = 0;
          Pic.Canvas.Pixels[mx + x][my - Abs(y)] = 0;
        }
      }
    }
  return Result;
}
//------------------------------------------------------------------------------
void TFMain::NWindClick(TObject Sender)
{
  const int max = 12;
  float x, y, p, c0, s0;
  typedef float Verounit__2[max - 1 - 0 + 1];
  Verounit__2 c, s;
  int radius, color, k, q;
void a(WORD k, float &x, float &y)
{
  const double r = 0.75;
  float t;
  t = x;
  x = r * (c0 * x + s0 * y);
  y = r * (-s0 * t + c0 * y);
  color = clYellow;
}
//------------------------------------------------------------------------------
void b(WORD k, float &x, float &y)
{
  const double r = 0.14;
  x = r * x + c[k];
  y = r * y + s[k];
  color = clBlue;
}
//------------------------------------------------------------------------------
  radius = trunc(1.2 * my);
  c0 = cos(-0.05 * pi);
  s0 = sin(-0.05 * pi);
  {
    int Verounit__4 = max - 1;
    for (k = 0; k <= Verounit__4; k++)
    {
      c[k] = Cos(2 * k * pi / max);
      s[k] = Sin(2 * k * pi / max);
    }
  }
  x = 1;
  y = 0.5;
  for (k = 1; k <= 500000; k++)
  {
    p = random;
    q = Random(max);
    if (p < 0.25)
      b(q, x, y);
    else
      a(q, x, y);
    Pic.Canvas.Pixels[mx + round(radius * x)][my + round(radius * y)] = 200 * random(50000);
  }
}
//------------------------------------------------------------------------------
void TFMain::NArchClick(TObject Sender)
{
  float f;
  Pic.Canvas.Rectangle(0, 0, FMain.Width, FMain.Height);
  f = 0;
  while (f < 8 * pi)
  {
    Pic.Canvas.Pixels[mx + round(9 * f * cos(f))][my - round(9 * f * sin(f))] = clRed;
    f = f + 0.0001;
  }
}
//------------------------------------------------------------------------------
void TFMain::NCornuClick(TObject Sender)
{
  int x, y;
  float f;
  Pic.Canvas.Rectangle(0, 0, FMain.Width, FMain.Height);
  f = 0.0001;
  while (f < 11 * pi)
  {
    y = my - round(260 / f * cos(f));
    x = mx + round(270 / f * sin(f));
    Canvas.Pixels[x][y] = clYellow;
    f = f + 0.0001;
  }
}
//------------------------------------------------------------------------------
void TFMain::NAnimClick(TObject Sender)
{
  Parametres = TParametres.Create(Application);
  Parametres.ShowModal();
  Parametres.Free();
}
//------------------------------------------------------------------------------
void TFMain::NSaveClick(TObject Sender)
{
  if (SavePictureDialog1.Execute)
    Pic.Picture.SaveToFile(SavePictureDialog1.FileName);
}
//------------------------------------------------------------------------------
void TFMain::FormClose(TObject Sender, TCloseAction &Action)
{
  HelpBM.Free();
}
//------------------------------------------------------------------------------
void TFMain::NFernClick(TObject Sender)
{
  float t, x, y, p;
  int R, xx, yy, k;
  r = trunc(0.3 * my);
  x = 1;
  y = 0;
  for (k = 1; k <= 500000; k++)
  {
    p = Random;
    t = x;
    if (p <= 0.85)
    {
      x = 0.85 * x + 0.04 * y;
      y = -0.04 * t + 0.85 * y + 1.6;
    }
    else
      if (p <= 0.92)
      {
        x = 0.2 * x - 0.26 * y;
        y = 0.23 * t + 0.22 * y + 1.6;
      }
      else
        if (p <= 0.99)
        {
          x = -0.15 * x + 0.28 * y;
          y = 0.26 * t + 0.24 * y + 0.44;
        }
        else
        {
          x = 0.0;
          y = 0.16 * y;
        }
    xx = round(r * x);
    yy = round(r * y / 1.6);
    Pic.Canvas.Pixels[mx + xx][round(1.875 * my) - yy] = clGreen;
  }
}
//------------------------------------------------------------------------------
void TFMain::NArchimedClick(TObject Sender)
{
  int x, y;
  float a;
  a = 0.0001;
  while (a < 11 * pi)
  {
    y = 5 * my - round(260 / a * cos(a));
    if (y > my * 3)
    {
      x = mx + round(270 / a * sin(a));
      Pic.Canvas.Pixels[x + 35][y] = clYellow;
      Pic.Canvas.Pixels[Pic.Width - x - 34][Pic.Height - y] = clYellow;
    }
    a = a + 0.0001;
  }
}
//------------------------------------------------------------------------------
//