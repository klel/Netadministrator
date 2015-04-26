object frmIP: TfrmIP
  Left = 409
  Top = 155
  Caption = 'IP '#1072#1076#1088#1077#1089#1072
  ClientHeight = 362
  ClientWidth = 211
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clLime
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 210
    Height = 361
    Caption = 'IP '#1072#1076#1088#1077#1089#1072
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object IPListBox: TListBox
      Left = 8
      Top = 24
      Width = 193
      Height = 233
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = IPListBoxClick
    end
    object Edit1: TEdit
      Left = 8
      Top = 264
      Width = 193
      Height = 21
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object AddIPButton: TButton
      Left = 8
      Top = 296
      Width = 89
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = AddIPButtonClick
    end
    object DelIPButton: TButton
      Left = 112
      Top = 296
      Width = 89
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = DelIPButtonClick
    end
    object ChangeIPButton: TButton
      Left = 8
      Top = 328
      Width = 89
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ChangeIPButtonClick
    end
    object ExitButton: TButton
      Left = 112
      Top = 328
      Width = 89
      Height = 25
      Caption = #1042#1099#1081#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = ExitButtonClick
    end
  end
  object TblIP: TTable
    DatabaseName = 'myDB'
    TableName = 'tblIP'
    Left = 128
    Top = 80
  end
  object TblConnections: TTable
    DatabaseName = 'myDB'
    TableName = 'tblConnections'
    Left = 56
    Top = 168
  end
end
