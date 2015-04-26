object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 508
  ClientWidth = 453
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
  object Label3: TLabel
    Left = 20
    Top = 399
    Width = 68
    Height = 13
    Caption = #1058#1077#1082#1089#1090' '#1102#1079#1077#1088#1091':'
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 328
    Width = 437
    Height = 65
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 9
    object Label1: TLabel
      Left = 14
      Top = 24
      Width = 31
      Height = 13
      Caption = 'PORT:'
    end
    object Label2: TLabel
      Left = 125
      Top = 24
      Width = 31
      Height = 13
      Caption = 'HOST:'
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 437
    Height = 314
    Caption = #1054#1090#1074#1077#1090' '#1102#1079#1077#1088#1072':'
    TabOrder = 8
  end
  object port: TEdit
    Left = 59
    Top = 349
    Width = 40
    Height = 21
    TabOrder = 0
  end
  object Host: TEdit
    Left = 170
    Top = 349
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object send: TEdit
    Left = 8
    Top = 421
    Width = 437
    Height = 21
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 20
    Top = 24
    Width = 413
    Height = 281
    ReadOnly = True
    TabOrder = 3
  end
  object ServerOff: TButton
    Left = 8
    Top = 456
    Width = 75
    Height = 25
    Caption = 'ServOff'
    TabOrder = 4
    OnClick = ServerOffClick
  end
  object ServerOn: TButton
    Left = 89
    Top = 456
    Width = 75
    Height = 25
    Caption = 'ServerOn'
    TabOrder = 5
    OnClick = ServerOnClick
  end
  object Client: TButton
    Left = 195
    Top = 456
    Width = 75
    Height = 25
    Caption = 'Client'
    TabOrder = 6
    OnClick = ClientClick
  end
  object SendText: TButton
    Left = 344
    Top = 456
    Width = 75
    Height = 25
    Caption = 'SendText'
    TabOrder = 7
    OnClick = SendTextClick
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocket1Connect
    OnDisconnect = ClientSocket1Disconnect
    OnRead = ClientSocket1Read
    Left = 352
    Top = 8
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    Left = 392
    Top = 8
  end
end
