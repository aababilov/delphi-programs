unit Verounit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, Menus, ExtCtrls in 'Dlgs.pas', StdCtrls in 'df', Menus, jpeg, ExtCtrls,ParamRot,Complexial, ComCtrls,
  ExtDlgs;

type
  TFMain = class(TForm)
    MainMenu1: TMainMenu;
    NSpiral: TMenuItem;
    NCornu: TMenuItem;
    NAnim: TMenuItem;
    NDraw: TMenuItem;
    NFern: TMenuItem;
    NMand: TMenuItem;
    NWind: TMenuItem;
    NArch: TMenuItem;
    Pic: TImage;
    NArchimed: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    procedure ClformClick(Sender: TObject);
    procedure NMandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NWindClick(Sender: TObject);
    procedure NArchClick(Sender: TObject);
    procedure NCornuClick(Sender: TObject);
    procedure NAnimClick(Sender: TObject);
    procedure NSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NFernClick(Sender: TObject);
    procedure NArchimedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;
 
implementation

{$R *.dfm}

var mx,my,h,w:integer;
    HelpBM:Tbitmap;

procedure TFMain.ClformClick(Sender: TObject);
begin
     FMain.Close;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
      w:=FMain.Width-40;
      h:=FMain.Height-60;
      mx:=Pic.Width div 2;
      my:=Pic.Height div 2;
      HelpBM:=TBitmap.Create;
      HelpBM.Width:=Pic.Width;
      HelpBM.Height:=Pic.Height;
end;

procedure TFMain.NMandClick(Sender: TObject);
const MaxIter=30;
      BailOut=16;

var Wor, Wor2,BackUp:complex;
    x,y,count: integer;

function f1(a:integer):integer;         begin
     f1:=255-count mod 254-2;
end;

begin
     for y:=-my to 0 do
                for x:=-mx to mx do
                begin
                        count:=0;
                        ToComplex(x/250,y/300,BackUp);
                        ToComplex(0,0,Wor);
                while ((Sqr(Wor.r)+Sqr(Wor.i))<BailOut)
                        and (Count<MaxIter) do
                begin
                  Wor2:=Wor;  CSqr(Wor2,Wor);
                  CAdd(Wor,BackUp,Wor2);
                  Wor:=Wor2;  Inc(Count);
                end;
                if count<>MaxIter then
                begin
                  Pic.Canvas.Pixels[mx+x,my-y]
                        :=clWhite - count*$3FFF;
                  Pic.Canvas.Pixels[mx+x,my-Abs(y)]
                        :=clWhite - count*$3FFF;
                end
                else
                begin
                        Pic.Canvas.Pixels[mx+x,my-y]
                                :=0;
                        Pic.Canvas.Pixels[mx+x,my-Abs(y)]
                                :=0;
                end;
       end;

end;

procedure TFMain.NWindClick(Sender: TObject);
const max=12;
var x,y,p,c0,s0:real;
   c,s:array[0..max-1] of real;
   radius,color,k,q:integer;

procedure a(k:word; var x,y:real);
const r=0.75;
var t:real;
begin  t:=x;x:=r*(c0*x+s0*y);y:=r*(-s0*t+c0*y); color:=clYellow
end;

procedure b(k:word; var x,y:real);
const r=0.14;
begin
     x:=r*x+c[k]; y:=r*y+s[k]; color:=clBlue;
end;

begin
      radius:=trunc(1.2*my);c0:=cos(-0.05*pi);s0:=sin(-0.05*pi);
      for k:=0 to max-1 do
      begin
           c[k]:=Cos(2*k*pi/max); s[k]:=Sin(2*k*pi/max);
      end;
      x:=1;  y:=0.5;
      for k:=1 to 500000 do
      begin
        p:=random;  q:=Random(max);
        if p<0.25 then b(q,x,y) else a(q,x,y);
        Pic.Canvas.Pixels[mx+round(radius*x),
                      my+round(radius*y)]:=200*random(50000);
      end;
end;


procedure TFMain.NArchClick(Sender: TObject);
var  f:real;
begin
     Pic.Canvas.Rectangle(0,0,FMain.Width,FMain.Height);
     f:=0;
     while f<8*pi do begin
        Pic.Canvas.Pixels[mx+round(9*f*cos(f)),
                my-round(9*f*sin(f))]:=clRed;
                f:=f+0.0001;
     end;
end;

procedure TFMain.NCornuClick(Sender: TObject);
var x,y:integer;
    f:real;
begin
     Pic.Canvas.Rectangle(0,0,FMain.Width,FMain.Height);
     f:=0.0001;
     while f<11*pi do begin
          y:=my-round(260/f*cos(f));
          x:=mx+round(270/f*sin(f));
          Canvas.Pixels[x,y]:=clYellow;
          f:=f+0.0001;
          end;

end;

procedure TFMain.NAnimClick(Sender: TObject);
begin
     Parametres:=TParametres.Create(Application);
     Parametres.ShowModal;
     Parametres.Free;
end;

procedure TFMain.NSaveClick(Sender: TObject);
begin
   if SavePictureDialog1.Execute then
      Pic.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     HelpBM.Free;
end;

procedure TFMain.NFernClick(Sender: TObject);
var t,x,y,p:real;  R,xx,yy,k:Integer;
begin
     r:=trunc(0.3*my);x:=1; y:=0;
     for k:=1 to 500000 do
     begin
          p:=Random;
          t:=x;
          if p<=0.85 then
          begin
                x:=0.85*x+0.04*y;
                y:=-0.04*t+0.85*y+1.6;
          end
          else
              if p<=0.92 then
              begin
                   x:=0.2*x-0.26*y;
                   y:=0.23*t+0.22*y+1.6;
              end
              else
                  if p<=0.99 then
                  begin
                       x:=-0.15*x+0.28*y;
                       y:=0.26*t+0.24*y+0.44;
                  end
                  else
                  begin
                        x:=0.0;
                        y:=0.16*y;
                  end;
          xx:=round(r*x);
          yy:=round(r*y/1.6);
          Pic.Canvas.Pixels[mx+xx,round(1.875*my)-yy]:=clGreen;
          end;
end;



procedure TFMain.NArchimedClick(Sender: TObject);
var
    x,y:integer;
    a:real;
begin
     a:=0.0001;
     while a<11*pi do begin
          y:=5*my-round(260/a*cos(a));
          if y>my*3 then begin
          x:=mx+round(270/a*sin(a));
          Pic.Canvas.Pixels[x+35,y]:=clYellow;
          Pic.Canvas.Pixels[Pic.Width-x-34,
                Pic.Height-y]:=clYellow;
          end;
          a:=a+0.0001;
     end;
end;

end.
