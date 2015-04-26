object frmChangeSwitch: TfrmChangeSwitch
  Left = 321
  Top = 173
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1074#1080#1090#1095
  ClientHeight = 282
  ClientWidth = 222
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 222
    Height = 65
    Align = alTop
    Caption = #1052#1086#1076#1077#1083#1100
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 4
    object ModelComboBox: TComboBox
      Left = 8
      Top = 24
      Width = 205
      Height = 21
      Style = csDropDownList
      Color = clBlack
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 51
    Width = 222
    Height = 65
    Align = alCustom
    Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object SerNumLabel: TEdit
      Left = 3
      Top = 20
      Width = 205
      Height = 21
      Color = clBlack
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 112
    Width = 222
    Height = 65
    Caption = #1048#1085#1074#1077#1085#1090#1072#1088#1085#1099#1081' '#1085#1086#1084#1077#1088
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object InvNumLabel: TEdit
      Left = 8
      Top = 24
      Width = 205
      Height = 21
      Color = clBlack
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 168
    Width = 222
    Height = 65
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1088#1090#1086#1074' ('#1086#1090' 2 '#1076#1086' 24)'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object QuanPortLabel: TEdit
      Left = 8
      Top = 24
      Width = 205
      Height = 21
      Color = clBlack
      Enabled = False
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 232
    Width = 222
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 97
      Height = 33
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 120
      Top = 8
      Width = 97
      Height = 33
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Table1: TTable
    DatabaseName = 'myDB'
    TableName = 'tblSwitches'
    Left = 16
    Top = 160
  end
  object TblModels: TTable
    DatabaseName = 'myDB'
    TableName = 'tblModels'
    Left = 160
    Top = 24
  end
end
