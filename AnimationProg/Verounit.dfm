object FMain: TFMain
  Left = 270
  Top = 115
  Width = 730
  Height = 403
  Caption = #1060#1088#1072#1082#1090#1072#1083#1099' '#1080' '#1089#1087#1080#1088#1072#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pic: TImage
    Left = 0
    Top = 0
    Width = 722
    Height = 357
    Align = alClient
  end
  object MainMenu1: TMainMenu
    Left = 680
    Top = 8
    object NSpiral: TMenuItem
      Caption = '&'#1057#1087#1080#1088#1072#1083#1080
      object NCornu: TMenuItem
        Caption = '&'#1050#1086#1088#1085#1102
        OnClick = NCornuClick
      end
      object NArchimed: TMenuItem
        Caption = '&'#1040#1088#1093#1080#1084#1077#1076#1086#1074#1091
        OnClick = NArchimedClick
      end
    end
    object NAnim: TMenuItem
      Caption = '&'#1040#1085#1080#1084#1072#1094#1080#1103
      OnClick = NAnimClick
    end
    object NDraw: TMenuItem
      Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
      object NFern: TMenuItem
        Caption = '&'#1055#1072#1087#1086#1088#1086#1090#1085#1080#1082
        OnClick = NFernClick
      end
      object NMand: TMenuItem
        Caption = '&'#1052#1085'.'#1052#1072#1085#1076#1077#1083#1100#1073#1088#1086#1090#1072
        OnClick = NMandClick
      end
      object NWind: TMenuItem
        Caption = '&'#1042#1080#1093#1088#1080
        OnClick = NWindClick
      end
      object NArch: TMenuItem
        Caption = '&'#1040#1088#1093#1080#1084#1077#1076#1072
        OnClick = NArchClick
      end
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 400
    Top = 64
  end
end
