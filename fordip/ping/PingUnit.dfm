object PingForm: TPingForm
  Left = 267
  Top = 234
  Width = 493
  Height = 330
  BorderWidth = 1
  Caption = #1055#1080#1085#1075#1077#1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 121
    Width = 483
    Height = 180
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 483
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 52
      Width = 102
      Height = 13
      Caption = #1056#1072#1079#1084#1077#1088' '#1087#1072#1082#1077#1090#1086#1074':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 103
      Height = 13
      Caption = #1048#1084#1103' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 264
      Top = 48
      Width = 48
      Height = 13
      Caption = 'TimeOut'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 88
      Top = 88
      Width = 24
      Height = 13
      Caption = 'TTL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 368
      Top = 88
      Width = 65
      Height = 25
      Caption = 'Ping'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 120
      Top = 8
      Width = 353
      Height = 21
      TabOrder = 1
      Text = '127.0.0.1'
    end
    object Edit2: TEdit
      Left = 120
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '56'
    end
    object Edit3: TEdit
      Left = 320
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '4000'
    end
    object Edit4: TEdit
      Left = 120
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 4
      Text = '64'
    end
  end
  object Ping1: TPing
    Size = 56
    Timeout = 4000
    TTL = 64
    Flags = 0
    OnEchoRequest = Ping1EchoRequest
    OnEchoReply = Ping1EchoReply
    OnDnsLookupDone = Ping1DnsLookupDone
    Left = 8
    Top = 136
  end
end
