object frmRooms: TfrmRooms
  Left = 529
  Top = 125
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 347
  ClientWidth = 192
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
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
    Width = 192
    Height = 347
    Align = alClient
    Caption = #1050#1072#1073#1080#1085#1077#1090#1099
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object RoomListBox: TListBox
      Left = 8
      Top = 24
      Width = 177
      Height = 217
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      OnClick = RoomListBoxClick
    end
    object ExitButton: TButton
      Left = 104
      Top = 312
      Width = 81
      Height = 25
      Caption = #1042#1099#1081#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ExitButtonClick
    end
    object Edit1: TEdit
      Left = 8
      Top = 248
      Width = 177
      Height = 21
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object DelRoomButton: TButton
      Left = 104
      Top = 280
      Width = 81
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = DelRoomButtonClick
    end
    object ChangeRoomButton: TButton
      Left = 8
      Top = 312
      Width = 81
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ChangeRoomButtonClick
    end
  end
  object AddRoomButton: TButton
    Left = 8
    Top = 280
    Width = 81
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = AddRoomButtonClick
  end
  object tblRooms: TTable
    DatabaseName = 'myDB'
    TableName = 'tblRooms'
    Left = 152
    Top = 32
  end
end
