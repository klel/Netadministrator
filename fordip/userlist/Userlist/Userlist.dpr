program Userlist;

uses
  Forms,
  Netres in 'Netres.pas' {NetResForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TNetResForm, NetResForm);
  Application.Run;
end.
