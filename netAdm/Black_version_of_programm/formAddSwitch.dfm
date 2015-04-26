object FrmAddSwitch: TFrmAddSwitch
  Left = 406
  Top = 148
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1089#1074#1080#1090#1095#1072
  ClientHeight = 357
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clLime
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 225
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
    TabOrder = 0
    object ModelComboBox: TComboBox
      Left = 8
      Top = 24
      Width = 209
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
    Width = 225
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
    TabOrder = 1
    object SerNumLabel: TEdit
      Left = 8
      Top = 24
      Width = 209
      Height = 24
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 112
    Width = 225
    Height = 65
    Align = alCustom
    Caption = #1048#1085#1074#1077#1085#1090#1072#1088#1085#1099#1081' '#1085#1086#1084#1077#1088
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object InvNumLabel: TEdit
      Left = 8
      Top = 24
      Width = 209
      Height = 24
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 168
    Width = 225
    Height = 65
    Align = alCustom
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1088#1090#1086#1074' ('#1086#1090' 2 '#1076#1086' 48)'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    object QuantPortLabel: TEdit
      Left = 8
      Top = 24
      Width = 209
      Height = 24
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 307
    Width = 225
    Height = 50
    Align = alBottom
    TabOrder = 5
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
  object GroupBox5: TGroupBox
    Left = 0
    Top = 224
    Width = 225
    Height = 65
    Align = alCustom
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1075#1080#1075#1072#1073#1080#1090#1085#1099#1093' '#1087#1086#1088#1090#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object QuantPortLabel2: TEdit
      Left = 8
      Top = 24
      Width = 209
      Height = 21
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object TableSwitches: TTable
    Left = 16
    Top = 168
  end
  object TablePorts: TTable
    DatabaseName = 'myDB'
    TableName = 'tblPorts'
    Left = 56
    Top = 168
  end
  object TableConnections: TTable
    DatabaseName = 'myDB'
    TableName = 'tblConnections'
    Left = 96
    Top = 168
  end
  object TblModels: TTable
    DatabaseName = 'myDB'
    TableName = 'tblModels'
    Left = 144
    Top = 24
  end
  object TablePorts2: TTable
    DatabaseName = 'myDB'
    TableName = 'tblPorts2'
    Left = 136
    Top = 168
  end
end
