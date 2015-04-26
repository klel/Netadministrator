unit DataAcc;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TData = class(TDataModule)
    DataSwich: TDataSource;
    ADOConnection: TADOConnection;
    ADOSwich: TADOTable;
    DataModel: TDataSource;
    ADOModel: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Data: TData;

implementation

{$R *.dfm}

end.
