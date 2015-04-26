program Project1;

uses
  Forms,
  PingUnit in 'PingUnit.pas' {PingForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPingForm, PingForm);
  Application.Run;
end.
