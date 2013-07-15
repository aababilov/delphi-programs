unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, ExtCtrls;

const
 MAXSZ = 100;
 MAXBLOCKS = 40;

type
  TLineDescript = record
   N: byte;
   bl_len: array [1..MAXBLOCKS] of byte;
  end;
  PAByte = ^AByte;
  AByte = array [1..MAXSZ + MAXSZ] of byte;

  TJapaneseForm = class(TForm)
    btnLoad: TButton;
    Results: TPageControl;
    OpenDialog1: TOpenDialog;
    procedure btnLoadClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    pict: array [1..MAXSZ, 1..MAXSZ] of byte;
    Lines: array [boolean, 1..MAXSZ] of TLineDescript;
    need_refresh: array [boolean, -1..MAXSZ] of boolean;
    cells: array [-1..MAXSZ] of byte;
    can_one, can_zero: array [-1..MAXSZ] of boolean;
    maxy, maxx: byte;
    tb_res: array [1..MAXBLOCKS, 1..MAXSZ] of shortint;
    XSZ, YSz, ErrorLevel, solcount: byte;
    sol_found: boolean;

    procedure AnalyseLine(kind: boolean; number: byte);
    procedure IterateLineLook;
    procedure OutputSolution;
    procedure TryFind(y, x: byte); 
  public
  end;

var
  JapaneseForm: TJapaneseForm;

implementation

{$R *.dfm}

procedure TJapaneseForm.btnLoadClick(Sender: TObject);
var
 f : TextFile;
 i, j: byte;
begin
 OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
 if not OpenDialog1.Execute then exit;
 solcount := 1;
 maxx := 0;
 maxy := 0;
 AssignFile(f, OpenDialog1.FileName);
 Reset(f);
 Read(f, YSz);
 for i := 1 to YSz do
 begin
  Read(f, Lines[true, i].N);
  if maxy < Lines[true, i].N then maxy := Lines[true, i].N;
  for j := 1 to Lines[true, i].N do
   Read(f, Lines[true, i].bl_len[j]);
  need_refresh[true, i] := true;
 end;
 Read(f, XSz);
 for i := 1 to XSz do
 begin
  Read(f, Lines[false, i].N);
  if maxx < Lines[false, i].N then maxx := Lines[false, i].N;
  for j := 1 to Lines[false, i].N do
   Read(f, Lines[false, i].bl_len[j]);
  need_refresh[false, i] := true;
 end;
 CloseFile(f);
 FillChar(pict, SizeOf(pict), 2);
 sol_found := false;
 TryFind(1, 1);
 if not sol_found then ShowMessage('no solution');
end;

procedure TJapaneseForm.AnalyseLine(kind: boolean; number: byte);
var
 bl_len: array[0..MAXSZ] of byte;
 N, L, i: byte;

 function TryBlock(theblock, thestart: shortint): boolean;
 var
   i, startnext: shortint;
 begin
  if (theblock > 0) and (tb_res[theblock, thestart] <> -1) then
  begin
   Result := tb_res[theblock, thestart] = 1;
   exit;
  end;
  for i := thestart to thestart + bl_len[theblock] - 1 do
   if cells[i] = 0 then
   begin
    tb_res[theblock, thestart] := 0;
    Result := false;
    exit;
   end;
  if theblock < N then
  begin
   Result := false;
   for startnext := thestart+bl_len[theblock]+1 to L-bl_len[theblock+1]+1 do
   begin
    if cells[startnext-1] = 1 then break;
    if TryBlock(theblock+1, startnext) then
    begin
     Result := true;
     for i := thestart to thestart + bl_len[theblock] - 1 do
      can_one[i] := true;
     for i := thestart + bl_len[theblock] to startnext - 1 do
      can_zero[i] := true;
    end;
   end;
  end
  else //theblock = N
  begin
   for i := thestart + bl_len[theblock] to L do
    if cells[i] = 1 then
    begin
     Result := false;
     exit;
    end;
   for i := thestart to thestart + bl_len[theblock] - 1 do
    can_one[i] := true;
   for i := thestart + bl_len[theblock] to L do
    can_zero[i] := true;
   Result := true;
  end;
 end;

begin
 need_refresh[kind, number] := false;
 if kind then L := XSz else L := YSz;
 cells[-1] := 1;
 cells[0] := 0;
 if kind then
  for i := 1 to L do
   cells[i] := pict[number, i]
 else
  for i := 1 to L do
   cells[i] := pict[i, number];
 FillChar(can_one, SizeOf(can_one), false);
 FillChar(can_zero, SizeOf(can_zero), false);
 N := Lines[kind, number].N;
 bl_len[0] := 1;
 for i := 1 to N do bl_len[i] := Lines[kind, number].bl_len[i];
 FillChar(tb_res, SizeOf(tb_res), -1);
 if TryBlock(0, -1) then
 begin
  for i := 1 to L do
   if (cells[i]=2)and(can_one[i] xor can_zero[i]) then
   begin
    need_refresh[not kind, i] := true;
    if can_one[i] then cells[i] := 1 else cells[i] := 0;
    if kind then pict[number, i] := cells[i]
    else pict[i, number] := cells[i];
   end;
 end
 else ErrorLevel := 1;
end;

procedure TJapaneseForm.IterateLineLook;
var
 i: byte;
 sl: boolean;
begin
  repeat
    sl := false;
    for i := 1 to YSz do
      if need_refresh[true, i] then
      begin
        AnalyseLine(true, i);
        sl := true;
      end;
    for i := 1 to XSz do
      if need_refresh[false, i] then
      begin
        AnalyseLine(false, i);
        sl := true;
      end;
  until not sl;
end;

procedure TJapaneseForm.OutputSolution;
var
 i, j : byte;
 TabSheet: TTabSheet;
 Grid: TStringGrid;
begin
 sol_found := true;
 TabSheet := TTabSheet.Create(Results);
 TabSheet.Caption := ExtractFileName(OpenDialog1.FileName) +
  ' - '+ IntToStr(solcount);
 TabSheet.PageControl := Results;
 Results.ActivePage := TabSheet;
 Grid := TStringGrid.Create(TabSheet);
 Grid.FixedCols := 0;
 Grid.FixedRows := 0;
 Grid.DefaultColWidth := 15;
 Grid.DefaultRowHeight := 15;
 Grid.ColCount := XSz;
 Grid.RowCount := YSz;
 Grid.Align := alClient;
 Grid.DefaultDrawing := false;
 Grid.OnDrawCell := GridDrawCell;
 Grid.Parent := TabSheet;
 for j := 1 to YSz do
  for i := 1 to XSz do
   Grid.Cells[i-1, j-1] := IntToStr(pict[j, i]);
 inc(solcount);
end;

procedure TJapaneseForm.TryFind(y, x: byte);
var
 i, j, i_, j_: byte;
 p: array of array of byte;
begin
  ErrorLevel := 0;
  IterateLineLook;
  if ErrorLevel<>0 then exit;
  j := y;
  i := x;
  while (j<=YSz) and (pict[j,i] <> 2) do
    if i = XSz then
    begin
      i := 1;
      inc(j);
    end
    else inc(i);
  if j > YSz then //we have found a solution
    OutputSolution
  else
  begin
    SetLength(p, YSz + 1, XSz + 1);
    for j_ := 1 to YSz do
      for i_ := 1 to XSz do
        p[j_, i_] := pict[j_, i_];
    pict[j, i] := 0;
    need_refresh[true, j] := true;
    need_refresh[false, i] := true;
    TryFind(j, i);
    for j_ := 1 to YSz do
      for i_ := 1 to XSz do
        pict[j_, i_] := p[j_, i_];
    pict[j, i] := 1;
    need_refresh[true, j] := true;
    need_refresh[false, i] := true;
    TryFind(j, i);
  end;
end;

procedure TJapaneseForm.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
 aGrid: TStringGrid;
begin
 aGrid := TStringGrid(Sender);
 with aGrid.Canvas.Brush do
  case aGrid.Cells[ACol, ARow][1] of
   '1' : Color := clBlack;
   '0' : Color := clWhite;
  end;
 aGrid.Canvas.Rectangle(Rect);
end;

end.
