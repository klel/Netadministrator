object Aboutfrm: TAboutfrm
  Left = 530
  Top = 326
  BorderIcons = []
  Caption = 'About'
  ClientHeight = 300
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 363
    Height = 26
    Caption = 'Register Network Connections'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Belukha'
    Font.Style = []
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 16
    Top = 40
    Width = 363
    Height = 213
    BevelOuter = bvSpace
    BorderStyle = bsNone
    Color = clBtnFace
    Lines.Strings = (
      'StudDevelopment'#174' for Microsoft'#174' Windows'#8482' Version 10.0.2288.'
      'All Rights Reserved.'
      'programmer- Klimov Elmar Nikolaevich (mvadmin@kismet-nbr.ru) '
      ''
      ''
      ''
      ''
      #1055#1088#1086#1076#1091#1082#1090' '#1074#1099#1087#1086#1083#1085#1077#1085' '#1074' '#1085#1077#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1080#1093' '#1094#1077#1083#1103#1093'. '
      #1055#1086' '#1074#1086#1087#1088#1086#1089#1091' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1080#1089#1093#1086#1076#1085#1099#1093' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086#1073' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1080' '#1074#1077#1088#1089#1080#1080' '
      #1080#1083#1080
      #1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1080#1089#1093#1086#1076#1085#1099#1093' '#1082#1086#1076#1086#1074', '#1086#1073#1088#1072#1097#1072#1081#1090#1077#1089#1100' '#1082' '#1072#1074#1090#1086#1088#1091' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      '(mvadmin@kismet-nbr.ru)'
      ''
      ''
      ''
      '                                                      2009')
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 152
    Top = 267
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
end
