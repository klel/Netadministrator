object nwMap: TnwMap
  Left = 147
  Top = 189
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = #1050#1086#1085#1089#1090#1088#1091#1082#1090#1086#1088' '#1082#1072#1088#1090#1099' '#1089#1077#1090#1080
  ClientHeight = 552
  ClientWidth = 1011
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = CloseForm
  OnCreate = CreateForm
  OnDestroy = SaveSatt
  OnMouseMove = designact
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = -9
    Width = 1011
    Height = 553
    OnMouseDown = UtpPaintDwn
    OnMouseMove = UtpPaintMv
    OnMouseUp = UtpPaintUp
  end
  object SwMenu1: TPopupMenu
    Left = 432
    Top = 16
    object N1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1084#1084#1091#1090#1072#1090#1086#1088
      OnClick = DeleteSw
    end
  end
  object PCMenu2: TPopupMenu
    Left = 480
    Top = 16
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1084#1087#1100#1102#1090#1077#1088
      OnClick = DeletePc
    end
  end
  object OpenPic: TOpenPictureDialog
    Left = 16
    Top = 512
  end
end
