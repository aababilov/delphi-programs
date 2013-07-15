object JapaneseForm: TJapaneseForm
  Left = 192
  Top = 107
  Width = 539
  Height = 397
  Caption = 'JapaneseForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    531
    370)
  PixelsPerInch = 96
  TextHeight = 13
  object btnLoad: TButton
    Left = 443
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Load'
    TabOrder = 0
    OnClick = btnLoadClick
  end
  object Results: TPageControl
    Left = 0
    Top = 0
    Width = 428
    Height = 370
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Japanese files (*.jpn)|*.jpn|All file (*.*)|*.*'
    Left = 8
    Top = 8
  end
end
