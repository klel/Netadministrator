object SwichForm: TSwichForm
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 230
  BorderStyle = bsNone
  ClientHeight = 79
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = DestroyOb
  OnShow = CreateSw
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 8
    Top = 8
    Width = 33
    Height = 58
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      080000000000000100000000000000000000000100000001000000000000FFFF
      FF001989FF00067DFF00047CFF00057DFF00097FFF00208CFF002190FF000480
      FF003A99FF0083BEFF00A6D2FF00A7D2FF0087C1FF00419CFF000A82FF00198A
      FF00178BFF002793FF00ABD4FF00FEFEFF00B4D9FF002F96FF002490FF0047A3
      FF003A9CFF00D3E9FF00F3F9FF00C5E2FF00C0DFFF00E9F4FF00DEEFFF0043A1
      FF00399CFF00379AFF00C3E1FF00B8DCFF0059ABFF0059ACFF005CAEFF0052A8
      FF009FD0FF00FAFDFF00D2E8FF003C9EFF003F9FFF0082C0FF00B4DAFF00B3D9
      FF00F0F7FF00CDE6FF0066B2FF00A5D1FF0090C6FF0045A2FF0054A9FF00C6E3
      FF00E1F0FF007DBEFF00E8F4FF0058ABFF0063B1FF00DAEDFD00FFFDFB00F8F8
      F800F4F5F500F3F3F400F2F2F200F1F1F200F4F2F200F6F5F20064ABF400A4CD
      F600FFFFF900E5F2FD007DBFFE00248BF100B2CDE900F5EEE800E6E7E700F1EC
      E600F0EBE600ECE9E600E9E7E500E5E5E500E7E6E600F1ECE500509BE6008EBA
      E600FEF4E700C1D5E8004098F000228AF20095BFE900FCF3EB00E9EAEB00AFCE
      EB00BBD3EB00D0DEEB00DBE4EB00EEEDEB00FFF6EB00D6E1EB00298AEB00C1D6
      EB00FFF7EB00A8C9E9001884EF003396F800519FEE00FBF5EF00FBF6EF006FAF
      EF000D7DEF001A85EF008DBEEF00FCF9EF00D3E1EF003491EF0064AAEF00FAF4
      EF00FFF7EF0065A9EE002A91F7001281F300BAD7F200FFFFF200CFE0F2001583
      F2000E80F2003694F2003F97F2001A86F20064ABF200F0F1F200FFFCF200CDE1
      F2001483F1003798FA00268BF500DEEEF500FFFFF50073B2F500ADD2F500A4CE
      F50092C5F500C9E0F500FFFCF500FFFEF500E8F2F5003493F5001B8AF9001185
      FA00268EF900C0DDF900FBFCF900CBE3F9003194F9001D8AFA001889FD00097E
      FC0057A6FC00A1CEFC00C0DEFC00C2DFFC00A5D1FC005EAAFC00097FFC00067F
      FD001183FF00037CFF000B80FF000A80FF000E82FF00FEFAF400FEF2E600FEAA
      5400FECA9600FEE4C800FEAC5800FECC9A00FCF6EC00FAFCFE00F8F6F600F2F2
      F200EEEEEE00ECEEEE00ECF2F400EEDCC800F08C2A00F2B27600F8FAFC00FCF8
      F600FED8B000FEBA7400F48A2000EA9C4E00EAE2DA00E6E6E600E6E4E400E4EA
      F000E6D8CA00E6882E00E6A86C00E6ECF000E6EAEC00E8E6E600EAAC6E00F29C
      4600F28C2400E6903A00E8DED400E8EEF200E8F0F600E8EEF400E8EAEC00E8CC
      AE00E8821C00E6984C00F0861E00F8963600EA862000ECF2F800ECECEA00ECC2
      9800ECBC8E00ECCCAA00ECD4BE00ECDACA00ECE2D800ECEAEA00ECF0F600ECDE
      D000EA8E3200FAA45000EE7C0C00EEBA8800EEF6FC00EEF4FA00EEB88400EE86
      1E00EE882200EE8A2A00EECAA400EEFAFE00EEF6FE00EEF0F200EEB88200EE7A
      0600EEAE6E00EEF2F600EEEEF000EEC6A200EE801200FA9A3A000000000000AA
      ABACAD04AE0000000000000000A0A1A2A3A4A5A6A7A8A90000000000999A9B9C
      4A4A4A4A4A9D9E9F0000008B8C8D8E8F90919293949596979800007D7E7F8081
      82838485868788898A006D6E6F707172737475767778797A7B7C5D5E5F606162
      636465666768696A6B6C4D4E4F505152535455565758595A5B5C3E3F40414243
      444544464748494A4B4C383901010101010101013A3B3C012C3D2E2F01010130
      31321C33343501013637002324010125262728292A2B012C2D0000191A1B0101
      1C1D1E1F0101202122000000121314150101010101161718000000000008090A
      0B0C0D0E0F101100000000000000000203040506070000000000}
    OnClick = SpeedButton1Click
  end
  object Image1: TImage
    Left = 310
    Top = 12
    Width = 105
    Height = 59
    AutoSize = True
  end
  object PortPop: TPopupMenu
    Left = 368
    Top = 16
    object N1: TMenuItem
      Caption = 'Connect'
      OnClick = N1Click
    end
    object discon: TMenuItem
      Caption = 'Disconnect'
      OnClick = disconClick
    end
    object PingH: TMenuItem
      Caption = 'Ping'
      OnClick = InfoPort
    end
  end
end
