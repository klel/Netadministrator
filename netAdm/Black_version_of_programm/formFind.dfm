object frmFind: TfrmFind
  Left = 288
  Top = 315
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 227
  ClientWidth = 837
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clLime
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 837
    Height = 227
    Align = alClient
    Caption = #1055#1086#1080#1089#1082
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 26
      Width = 63
      Height = 13
      Caption = #1055#1086' '#1092#1072#1084#1080#1083#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 40
      Top = 58
      Width = 63
      Height = 13
      Caption = #1055#1086' '#1082#1072#1073#1080#1085#1077#1090#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 40
      Top = 90
      Width = 58
      Height = 13
      Caption = #1055#1086' '#1088#1086#1079#1077#1090#1082#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 40
      Top = 122
      Width = 65
      Height = 13
      Caption = #1055#1086' IP '#1072#1076#1088#1077#1089#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object StaffCheckBox: TCheckBox
      Left = 16
      Top = 24
      Width = 17
      Height = 17
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 0
    end
    object RoomCheckBox: TCheckBox
      Left = 16
      Top = 56
      Width = 17
      Height = 17
      Color = clBlack
      ParentColor = False
      TabOrder = 1
    end
    object SocketCheckBox: TCheckBox
      Left = 16
      Top = 88
      Width = 17
      Height = 17
      Color = clBlack
      ParentColor = False
      TabOrder = 2
    end
    object FindButton: TButton
      Left = 16
      Top = 176
      Width = 105
      Height = 33
      Caption = #1053#1072#1081#1090#1080
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = FindButtonClick
    end
    object ExitButton: TButton
      Left = 160
      Top = 176
      Width = 99
      Height = 33
      Caption = #1042#1099#1081#1090#1080
      TabOrder = 4
      OnClick = ExitButtonClick
    end
    object StaffComboBox: TComboBox
      Left = 120
      Top = 24
      Width = 145
      Height = 21
      Color = clGray
      ItemHeight = 13
      TabOrder = 5
    end
    object RoomComboBox: TComboBox
      Left = 120
      Top = 56
      Width = 145
      Height = 21
      Color = clGray
      ItemHeight = 13
      TabOrder = 6
    end
    object SocketComboBox: TComboBox
      Left = 120
      Top = 88
      Width = 145
      Height = 21
      Color = clGray
      ItemHeight = 13
      TabOrder = 7
    end
    object Grid1: TStringGrid
      Left = 272
      Top = 24
      Width = 561
      Height = 129
      Color = clGray
      ColCount = 6
      DefaultRowHeight = 16
      FixedColor = clMaroon
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      ColWidths = (
        70
        64
        54
        90
        87
        86)
    end
    object IPCheckBox: TCheckBox
      Left = 16
      Top = 120
      Width = 17
      Height = 17
      Color = clBlack
      ParentColor = False
      TabOrder = 9
    end
    object IPComboBox: TComboBox
      Left = 120
      Top = 120
      Width = 145
      Height = 21
      Color = clGray
      ItemHeight = 13
      TabOrder = 10
    end
  end
  object TblStaff: TTable
    DatabaseName = 'myDB'
    TableName = 'tblStaff'
    Left = 80
  end
  object TblRooms: TTable
    DatabaseName = 'myDB'
    TableName = 'tblRooms'
    Left = 120
  end
  object TblSockets: TTable
    DatabaseName = 'myDB'
    TableName = 'tblSockets'
    Left = 160
  end
  object TblConnections: TTable
    DatabaseName = 'myDB'
    TableName = 'tblConnections'
    Left = 200
  end
  object TblPorts: TTable
    DatabaseName = 'myDB'
    TableName = 'tblPorts'
    Left = 240
  end
  object tblIP: TTable
    DatabaseName = 'myDB'
    TableName = 'tblIP'
    Left = 280
  end
end
