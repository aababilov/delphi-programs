unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ToolWin, ComCtrls, ImgList, StdCtrls;

type
  TLifeForm = class(TForm)
    OpenSource: TOpenDialog;
    LargeField: TScrollBox;
    ToolsImages: TImageList;
    EvolveTimer: TTimer;
    ToolBar: TToolBar;
    btnLoadFile: TToolButton;
    btnPlay: TToolButton;
    btnPause: TToolButton;
    btnChPeriod: TToolButton;
    SmallField: TScrollBox;
    LargeView: TPaintBox;
    SmallView: TPaintBox;
    FieldSplitter: TSplitter;
    procedure LoadFile(Sender: TObject);
    procedure PlayPause(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChPeriod(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Evolve(Sender: TObject);
    procedure FieldPaint(Sender: TObject);
  private
    sz: Integer;
    TempPic, CellPic, FreePic: TBitmap;
  public
    { Public declarations }
  end;

var
  LifeForm: TLifeForm;

implementation

{$R *.dfm}

{$R Pics.res}


const
  MAXDIM  = 60;
  CELL    = $80;       //1000 0000
  NOTCELL = not CELL;  //0111 1111
  TWO     = CELL or 3; //1000 0011
  THREE   = CELL or 4; //1000 0100

type
  Dimension = -1..MAXDIM;

var
  field: array [Dimension, Dimension] of byte;

procedure TLifeForm.Evolve(Sender: TObject);
var
  i, j, a, b: Integer;
  ch: Boolean;
begin
  for i := 0 to MAXDIM - 1 do
    for j := 0 to MAXDIM - 1 do
      if field[i, j] and CELL = CELL then
        for a := i - 1 to i + 1 do       //  1 1 1
          for b := j - 1 to j + 1 do     //  1 0 1
            inc(field[a, b]);            //  1 1 1
  ch := false;
  for i := 0 to MAXDIM - 1 do
    for j := 0 to MAXDIM - 1 do
      case field[i, j] and CELL of
        CELL :
          if (field[i, j] = TWO) or (field[i, j] = THREE) then
            field[i, j] := CELL
          else
          begin
            LargeView.Canvas.CopyRect(Rect(j * sz, i * sz,
              (j + 1) * sz, (i + 1) * sz), FreePic.Canvas,
              FreePic.Canvas.ClipRect);
            SmallView.Canvas.CopyRect(Rect(j * 2, i * 2, (j + 1) * 2,
              (i + 1) * 2), FreePic.Canvas, FreePic.Canvas.ClipRect);
            ch := true;
            field[i, j] := 0;
          end;
        0    :
          if field[i, j] = 3 then
          begin
            LargeView.Canvas.CopyRect(Rect(j * sz, i * sz,
              (j + 1) * sz, (i + 1) * sz), CellPic.Canvas,
              CellPic.Canvas.ClipRect);
            SmallView.Canvas.CopyRect(Rect(j * 2, i * 2, (j + 1) * 2,
              (i + 1) * 2), CellPic.Canvas, CellPic.Canvas.ClipRect);
            ch := true;
            field[i, j] := CELL;
          end
          else field[i, j] := 0;
      end;
  if not ch then PlayPause(btnPause);
end;

procedure TLifeForm.LoadFile(Sender: TObject);
var
  i, j, ox, oy, maxLength: Integer;
  Data: TStringList;
begin
  if OpenSource.Execute then
  begin
    FillChar(field, SizeOf(field), 0);
    Data := TStringList.Create;
    Data.LoadFromFile(OpenSource.FileName);
    if Data.Count = 1 then exit;
    maxLength := Length(Data[0]);
    for i := 1 to Data.Count - 1 do
      if maxLength < Length(Data[i]) then maxLength := Length(Data[i]);
    ox := (MAXDIM - maxLength) div 2;
    oy := (MAXDIM - Data.Count) div 2;
    for i := 0 to Data.Count - 1 do
      for j := 1 to Length(Data[i]) do
        if Data[i][j] = '1' then
          field[oy + i, ox + j] := CELL;
    FieldPaint(LargeView);
    FieldPaint(SmallView);
    PlayPause(btnPlay);
  end;
end;

procedure TLifeForm.PlayPause(Sender: TObject);
begin
  EvolveTimer.Enabled := Sender = btnPlay;
  btnPause.Enabled := Sender = btnPlay;
  btnPlay.Enabled := Sender = btnPause;
end;

procedure TLifeForm.FormCreate(Sender: TObject);
begin
  CellPic := TBitmap.Create;
  CellPic.LoadFromResourceName(HInstance, 'CELLPIC');
  FreePic := TBitmap.Create;
  FreePic.LoadFromResourceName(HInstance, 'FREEPIC');
  TempPic := TBitmap.Create;
  TempPic.Width := MAXDIM * 2;
  TempPic.Height := MAXDIM * 2;
  sz := CellPic.Width;
  LargeView.SetBounds(0, 0, MAXDIM * sz, MAXDIM * sz);
  SmallView.SetBounds(0, 0, MAXDIM * 2, MAXDIM * 2);
end;

procedure TLifeForm.FormDestroy(Sender: TObject);
begin
  CellPic.Free;
  FreePic.Free;
  TempPic.Free;
end;

procedure TLifeForm.ChPeriod(Sender: TObject);
var
  ans: string;
begin
  ans := IntToStr(EvolveTimer.Interval);
  if InputQuery('Changing period', 'New period:', ans) then
    EvolveTimer.Interval := StrToInt(ans);
end;
      
procedure TLifeForm.FieldPaint(Sender: TObject);
var
  i, j: Integer;
  mul: Integer;
begin
  if Sender = SmallView then mul := 2 else mul := sz;
  with TPaintBox(Sender).Canvas do
  begin
    for i := 0 to MAXDIM - 1 do
      for j := 0 to MAXDIM - 1 do
        if field[i, j] = CELL then
         CopyRect(Rect(j * mul, i * mul, (j + 1) * mul, (i + 1) * mul),
           CellPic.Canvas, CellPic.Canvas.ClipRect)
        else
         CopyRect(Rect(j * mul, i * mul, (j + 1) * mul, (i + 1) * mul),
         FreePic.Canvas, FreePic.Canvas.ClipRect);
    Brush.Style := bsClear;
    Rectangle(TPaintBox(Sender).ClientRect);
  end;
end;

end.
