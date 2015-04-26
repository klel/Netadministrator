program ChatClient;

uses
  Forms,
  Main in 'Main.pas' {ChatForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TChatForm, ChatForm);
  Application.Run;
end.
