object Comp: TComp
  OldCreateOrder = False
  Left = 645
  Top = 418
  Height = 217
  Width = 302
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblrequest'
    Left = 80
    Top = 8
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=\\Ser' +
      'ver\db\dbrequest.mdb;Mode=Share Deny None;Extended Properties=""' +
      ';Persist Security Info=False;Jet OLEDB:System database="";Jet OL' +
      'EDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:En' +
      'gine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global P' +
      'artial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB' +
      ':New Database Password="";Jet OLEDB:Create System Database=False' +
      ';Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on' +
      ' Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Je' +
      't OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 232
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 16
    Top = 8
  end
  object SourceFIO: TDataSource
    DataSet = ADOFIO
    Left = 16
    Top = 72
  end
  object ADOFIO: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblfio'
    Left = 88
    Top = 72
  end
  object SourcePost: TDataSource
    DataSet = ADOPost
    Left = 24
    Top = 128
  end
  object ADOPost: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblpost'
    Left = 88
    Top = 128
  end
end
