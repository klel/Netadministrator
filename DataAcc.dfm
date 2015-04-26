object Data: TData
  OldCreateOrder = False
  Height = 510
  Width = 644
  object DataSwich: TDataSource
    DataSet = ADOSwich
    Left = 512
    Top = 8
  end
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Documents and Se' +
      'ttings\klimov.en\'#1056#1072#1073#1086#1095#1080#1081' '#1089#1090#1086#1083'\diplom_23.09_wrkretail\db.mdb;Pers' +
      'ist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object ADOSwich: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'tblSwiches'
    Left = 568
    Top = 8
  end
  object DataModel: TDataSource
    DataSet = ADOModel
    Left = 512
    Top = 72
  end
  object ADOModel: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'tblModels'
    Left = 576
    Top = 72
  end
end
