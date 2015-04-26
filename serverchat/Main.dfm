object ChatForm: TChatForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075' '#1089' '#1089#1080#1089#1090#1077#1084#1085#1099#1084' '#1080#1085#1078#1077#1085#1077#1088#1086#1084
  ClientHeight = 490
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 386
    Width = 500
    Height = 96
    Caption = #1042#1072#1096' '#1086#1090#1074#1077#1090':'
    TabOrder = 3
    object BitBtn2: TBitBtn
      Left = 408
      Top = 50
      Width = 75
      Height = 31
      Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
      TabOrder = 0
      OnClick = BitBtn2Click
    end
  end
  object RichEdit1: TRichEdit
    Left = 8
    Top = 8
    Width = 500
    Height = 361
    Cursor = crArrow
    BevelKind = bkFlat
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 16
    Top = 409
    Width = 369
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 416
    Top = 398
    Width = 75
    Height = 32
    Caption = #1054#1090#1074#1077#1090#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object Server: TServerSocket
    Active = False
    Port = 20009
    ServerType = stNonBlocking
    OnClientRead = ServerClientRead
    OnClientError = ServerClientError
    Left = 464
    Top = 64
  end
  object Client: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    Left = 456
    Top = 144
  end
end
