program Dialog;

uses
  Forms,
  enddialog in 'enddialog.pas' {enddlg},
  dialog1 in 'dialog1.pas' {dlgform1},
  first in 'first.pas' {Ffrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFfrm, Ffrm);
  Application.CreateForm(Tenddlg, enddlg);
  Application.CreateForm(Tdlgform1, dlgform1);
  Application.Run;
end.
