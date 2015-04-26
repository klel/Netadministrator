object frmSockets: TfrmSockets
  Left = 554
  Top = 161
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 329
  ClientWidth = 209
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clLime
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 209
    Height = 329
    Align = alClient
    Caption = #1056#1086#1079#1077#1090#1082#1080
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 26
      Width = 42
      Height = 13
      Caption = #1050#1072#1073#1080#1085#1077#1090
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object RoomsComboBox: TComboBox
      Left = 64
      Top = 24
      Width = 137
      Height = 21
      Style = csDropDownList
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnChange = RoomsComboBoxChange
    end
    object SocketListBox: TListBox
      Left = 8
      Top = 56
      Width = 193
      Height = 169
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
      OnClick = SocketListBoxClick
    end
    object AddSocketButton: TButton
      Left = 8
      Top = 264
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
      OnClick = AddSocketButtonClick
    end
    object DelSocketButton: TButton
      Left = 112
      Top = 264
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
      OnClick = DelSocketButtonClick
    end
    object ChangeSocketButton: TButton
      Left = 8
      Top = 296
      Width = 89
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object ExitButton: TButton
      Left = 112
      Top = 296
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
    object Edit1: TEdit
      Left = 8
      Top = 232
      Width = 193
      Height = 21
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object tblSockets: TTable
    DatabaseName = 'myDB'
    TableName = 'tblSockets'
    Left = 40
    Top = 120
  end
  object tblRooms: TTable
    DatabaseName = 'myDB'
    TableName = 'tblRooms'
    Left = 136
    Top = 24
  end
end
