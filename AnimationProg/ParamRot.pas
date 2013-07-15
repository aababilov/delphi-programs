unit ParamRot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TParametres = class(TForm)
    Label1: TLabel;
    TimeRot: TComboBox;
    Label2: TLabel;
    ShVint: TButton;
    Button1: TButton;
    GroupBox1: TGroupBox;
    PoStr: TRadioButton;
    ProtStr: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure ShVintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Parametres: TParametres;

implementation

uses Verounit;

{$R *.dfm}

procedure TParametres.FormCreate(Sender: TObject);
var i:integer;
begin
     TimeRot.Clear;
     for i:=1 to 10 do  TimeRot.Items.Add(IntToStr(5*i))
end;

procedure TParametres.ShVintClick(Sender: TObject);
var i,dx,dy:integer;
    r,a,j,step:real;
    pole:TBitmap;
    StTime:TDateTime;
begin
     Pole:=TBitmap.Create;
     pole.Height:=500;
     pole.Width:=800;
     dx:=FMain.Width div 2;
     dy:=FMain.Height div 2;
     StTime:=Now;
     j:=0;
     if Postr.Checked Then step:=-0.01 else step:=0.01;
     while (Now-StTime)<(StrToInt(TimeRot.Text)*0.00001) do begin
        Pole.Canvas.Rectangle(0,0,pole.Width,pole.Height);
        a:=0;
        while a<5.5*pi do begin
                for i:=0 to 2 do begin
                  r:=exp(2.094395*i+a)/100;
                  Pole.Canvas.Pixels[dx+round(r*cos(a+j)),
                        dy-round(r*sin(a+j))]:=clGreen;
                end;
                a:=a+0.005;
        end;
        FMain.Canvas.CopyRect(Rect(0,0,800,700),Pole.Canvas,
                Rect(0,0,800,700));
        j:=j+step;
     end;
     Pole.Free;
     FMain.Canvas.Rectangle(0,0,FMain.Width,FMain.Height);end;

end.
