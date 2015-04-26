program Project10;

uses
  Forms,
  NetWorkUnit in 'NetWorkUnit.pas' {Form9};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
