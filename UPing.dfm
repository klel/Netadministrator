object frmPING: TfrmPING
  Left = 440
  Top = 40
  BorderStyle = bsDialog
  Caption = 'frmPING'
  ClientHeight = 253
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 128
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 217
    Height = 57
    TabOrder = 7
  end
  object ButtonGroup1: TButtonGroup
    Left = 8
    Top = 8
    Width = 217
    Height = 42
    Items = <>
    TabOrder = 5
  end
  object Memo1: TMemo
    Left = 248
    Top = 8
    Width = 353
    Height = 207
    Cursor = crIBeam
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImeMode = imHira
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 16
    Top = 16
    Width = 201
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 72
    Width = 75
    Height = 26
    Hint = #1055#1080#1085#1075' '#1093#1086#1089#1090#1072'.'#1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1089#1084#1086#1090#1088#1080' '#1074' '#1052#1045#1052#1054' '#1087#1086#1083#1077
    Caption = 'Go!Thise'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 142
    Top = 72
    Width = 75
    Height = 25
    Hint = #1055#1080#1085#1075' '#1089' '#1087#1086#1084#1086#1097#1100#1102' '#1082#1086#1084#1072#1085#1076#1085#1086#1081' '#1089#1090#1088#1086#1082#1080' '#1089' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1084'  -t'
    Caption = 'Go WinPing'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 228
    Width = 611
    Height = 25
    AutoHint = True
    Panels = <
      item
        Width = 300
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object ProgressBar1: TProgressBar
    Left = 304
    Top = 233
    Width = 145
    Height = 17
    TabOrder = 4
  end
end
