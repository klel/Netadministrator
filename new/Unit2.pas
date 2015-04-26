unit Unit2;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TComp = class(TDataModule)
    ADOTable1: TADOTable;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    SourceFIO: TDataSource;
    ADOFIO: TADOTable;
    SourcePost: TDataSource;
    ADOPost: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Comp: TComp;

implementation

{$R *.dfm}

end.
