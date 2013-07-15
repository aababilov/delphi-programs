object Parametres: TParametres
  Left = 595
  Top = 597
  Width = 420
  Height = 137
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1074#1088#1072#1097#1077#1085#1080#1103' '#1083#1086#1075#1072#1088#1080#1092#1084#1080#1095#1077#1089#1082#1086#1081' '#1089#1087#1080#1088#1072#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 127
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1074#1088#1077#1084#1103' '#1086#1073#1086#1088#1086#1090#1086#1074
  end
  object Label2: TLabel
    Left = 296
    Top = 8
    Width = 35
    Height = 13
    Caption = #1089#1077#1082#1091#1085#1076
  end
  object TimeRot: TComboBox
    Left = 144
    Top = 8
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = '5'
  end
  object ShVint: TButton
    Left = 232
    Top = 48
    Width = 75
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100
    TabOrder = 2
    OnClick = ShVintClick
  end
  object Button1: TButton
    Left = 232
    Top = 72
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 1
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 185
    Height = 57
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1074#1088#1072#1097#1077#1085#1080#1103
    TabOrder = 1
    object PoStr: TRadioButton
      Left = 8
      Top = 16
      Width = 121
      Height = 17
      Caption = #1055#1086' '#1095#1072#1089#1086#1074#1086#1081' '#1089#1090#1088#1077#1083#1082#1077
      TabOrder = 0
    end
    object ProtStr: TRadioButton
      Left = 8
      Top = 32
      Width = 145
      Height = 17
      Caption = #1055#1088#1086#1090#1080#1074' '#1095#1072#1089#1086#1074#1086#1081' '#1089#1090#1088#1077#1083#1082#1080
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
end
