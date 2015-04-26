object Form1: TForm1
  Left = 225
  Top = 126
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Domain name, IP, Traffic'
  ClientHeight = 737
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCC0
    000CCCC0000000000CCCC7777CCCCCCC0000CCCC00000000CCCC7777CCCCCCCC
    C0000CCCCCCCCCCCCCC7777CCCCC0CCCCC0000CCCCCCCCCCCC7777CCCCC700CC
    C00CCCC0000000000CCCC77CCC77000C0000CCCC00000000CCCC7777C7770000
    00000CCCC000000CCCC777777777C000C00000CCCC0000CCCC77777C777CCC00
    CC00000CCCCCCCCCC77777CC77CCCCC0CCC000CCCCC00CCCCC777CCC7CCCCCCC
    CCCC0CCCCCCCCCCCCCC7CCCCCCCCCCCC0CCCCCCCCCCCCCCCCCCCCCC7CCC70CCC
    00CCCCCCCC0CC0CCCCCCCC77CC7700CC000CCCCCC000000CCCCCC777CC7700CC
    0000CCCC00000000CCCC7777CC7700CC0000C0CCC000000CCC7C7777CC7700CC
    0000C0CCC000000CCC7C7777CC7700CC0000CCCC00000000CCCC7777CC7700CC
    000CCCCCC000000CCCCCC777CC7700CC00CCCCCCCC0CC0CCCCCCCC77CC770CCC
    0CCCCCCCCCCCCCCCCCCCCCC7CCC7CCCCCCCC0CCCCCCCCCCCCCC7CCCCCCCCCCC0
    CCC000CCCCC00CCCCC777CCC7CCCCC00CC00000CCCCCCCCCC77777CC77CCC000
    C00000CCCC0000CCCC77777C777C000000000CCCC000000CCCC777777777000C
    0000CCCC00000000CCCC7777C77700CCC00CCCC0000000000CCCC77CCC770CCC
    CC0000CCCCCCCCCCCC7777CCCCC7CCCCC0000CCCCCCCCCCCCCC7777CCCCCCCCC
    0000CCCC00000000CCCC7777CCCCCCC0000CCCC0000000000CCCC7777CCC0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 192
    Top = 41
    Width = 40
    Height = 16
    Caption = 'Name:'
    OnDblClick = Label1DblClick
  end
  object Label2: TLabel
    Left = 192
    Top = 16
    Width = 15
    Height = 16
    Caption = 'IP:'
  end
  object Bevel1: TBevel
    Left = 9
    Top = 64
    Width = 376
    Height = 9
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 192
    Top = 89
    Width = 15
    Height = 16
    Caption = 'IP:'
  end
  object Label4: TLabel
    Left = 192
    Top = 112
    Width = 51
    Height = 16
    Caption = 'Number:'
    OnDblClick = Label4DblClick
  end
  object Bevel2: TBevel
    Left = 9
    Top = 136
    Width = 376
    Height = 8
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 192
    Top = 160
    Width = 40
    Height = 16
    Caption = 'Name:'
  end
  object Label6: TLabel
    Left = 192
    Top = 185
    Width = 15
    Height = 16
    Caption = 'IP:'
    OnDblClick = Label6DblClick
  end
  object Bevel3: TBevel
    Left = 7
    Top = 280
    Width = 377
    Height = 9
    Shape = bsTopLine
  end
  object Label7: TLabel
    Left = 9
    Top = 293
    Width = 51
    Height = 16
    Caption = 'Local IP:'
  end
  object Bevel4: TBevel
    Left = 7
    Top = 319
    Width = 377
    Height = 8
    Shape = bsTopLine
  end
  object Label8: TLabel
    Left = 192
    Top = 341
    Width = 40
    Height = 16
    Caption = 'Name:'
  end
  object Label9: TLabel
    Left = 192
    Top = 366
    Width = 15
    Height = 16
    Caption = 'IP:'
    OnDblClick = Label9DblClick
  end
  object Label10: TLabel
    Left = 192
    Top = 224
    Width = 15
    Height = 16
    Caption = 'IP:'
  end
  object Label11: TLabel
    Left = 192
    Top = 252
    Width = 40
    Height = 16
    Caption = 'Name:'
    OnDblClick = Label11DblClick
  end
  object Bevel5: TBevel
    Left = 7
    Top = 391
    Width = 377
    Height = 8
    Shape = bsTopLine
  end
  object Label12: TLabel
    Left = 8
    Top = 408
    Width = 287
    Height = 16
    Caption = #1055#1086#1076#1089#1095#1077#1090' '#1074#1093#1086#1076#1103#1097#1077#1075#1086'/'#1080#1089#1093#1086#1076#1103#1097#1077#1075#1086' '#1090#1088#1072#1092#1080#1082#1072
  end
  object Label13: TLabel
    Left = 8
    Top = 424
    Width = 325
    Height = 16
    Caption = #1095#1077#1088#1077#1079' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1099' ('#1091#1095#1080#1090#1099#1074#1072#1077#1090#1089#1103' '#1074#1077#1089#1100' '#1090#1088#1072#1092#1080#1082')'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 25
    Caption = 'Domain name from IP'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 216
    Top = 8
    Width = 169
    Height = 24
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 80
    Width = 169
    Height = 25
    Caption = 'IP to Number format'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 216
    Top = 80
    Width = 169
    Height = 24
    TabOrder = 3
  end
  object Button3: TButton
    Left = 8
    Top = 152
    Width = 169
    Height = 25
    Caption = 'IP computer by his Name'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Edit3: TEdit
    Left = 240
    Top = 152
    Width = 145
    Height = 24
    TabOrder = 5
  end
  object Button4: TButton
    Left = 8
    Top = 336
    Width = 169
    Height = 25
    Caption = 'IP from Domain name'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Edit4: TEdit
    Left = 240
    Top = 336
    Width = 145
    Height = 24
    TabOrder = 7
  end
  object Button5: TButton
    Left = 8
    Top = 216
    Width = 169
    Height = 25
    Caption = 'Name computer by his IP'
    TabOrder = 8
    OnClick = Button5Click
  end
  object Edit5: TEdit
    Left = 216
    Top = 216
    Width = 169
    Height = 24
    TabOrder = 9
  end
  object ListBox1: TListBox
    Left = 8
    Top = 488
    Width = 377
    Height = 241
    ItemHeight = 16
    TabOrder = 10
  end
  object Button6: TButton
    Left = 8
    Top = 456
    Width = 377
    Height = 25
    Caption = 'Reset'
    TabOrder = 11
    OnClick = Button6Click
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 344
    Top = 440
  end
end
