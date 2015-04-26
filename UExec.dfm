object FExec: TFExec
  Left = 547
  Top = 94
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1091#1089#1082' '#1092#1072#1081#1083#1072' '#1085#1072' '#1091#1076#1072#1083#1077#1085#1085#1086#1081' '#1084#1072#1096#1080#1085#1077
  ClientHeight = 77
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = -1
    Width = 353
    Height = 68
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 14
      Width = 58
      Height = 13
      Caption = #1048#1084#1103' '#1093#1086#1089#1090#1072': '
    end
    object Label2: TLabel
      Left = 127
      Top = 14
      Width = 51
      Height = 13
      Caption = #1050#1086#1084#1072#1085#1076#1072': '
    end
    object Label3: TLabel
      Left = 254
      Top = 14
      Width = 53
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
    end
  end
  object Edit1: TEdit
    Left = 24
    Top = 32
    Width = 105
    Height = 21
    TabOrder = 0
    Text = '\\'
  end
  object Edit2: TEdit
    Left = 135
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 262
    Top = 32
    Width = 65
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      '-i')
  end
  object Button1: TButton
    Left = 377
    Top = 8
    Width = 75
    Height = 59
    Caption = 'RUN'
    TabOrder = 4
    OnClick = Button1Click
  end
end
