object PCDataEnter: TPCDataEnter
  Left = 827
  Top = 108
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093' '#1086' '#1082#1083#1080#1077#1085#1090#1077
  ClientHeight = 220
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = ShowData
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 232
    Height = 19
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1085#1085#1099#1077' '#1086' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 51
    Width = 82
    Height = 13
    Caption = '1. DNS/NetBIOS:'
  end
  object Label4: TLabel
    Left = 24
    Top = 78
    Width = 104
    Height = 13
    Caption = '3. '#1052#1077#1089#1090#1086#1087#1086#1083#1086#1078#1077#1085#1080#1077':'
  end
  object Label5: TLabel
    Left = 24
    Top = 105
    Width = 78
    Height = 13
    Caption = '4. '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
  end
  object GroupBox1: TGroupBox
    Left = 168
    Top = 33
    Width = 153
    Height = 104
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 184
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit3: TEdit
    Left = 184
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edit4: TEdit
    Left = 184
    Top = 102
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 230
    Top = 176
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 144
    Top = 176
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = Button2Click
  end
end
