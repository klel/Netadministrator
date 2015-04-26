program RegNCCisco;

uses
  Forms,
  mainform in 'mainform.pas' {FrmMain},
  formDelSwitchConfirm in 'formDelSwitchConfirm.pas' {frmDelSwitchConfirm},
  formAddSwitch in 'formAddSwitch.pas' {FrmAddSwitch},
  formChangeSwitch in 'formChangeSwitch.pas' {frmChangeSwitch},
  formRooms in 'formRooms.pas' {frmRooms},
  formStaff in 'formStaff.pas' {frmStaff},
  formSockets in 'formSockets.pas' {frmSockets},
  formFind in 'formFind.pas' {frmFind},
  formModels in 'formModels.pas' {frmModels},
  formIP in 'formIP.pas' {frmIP},
  UPing in 'UPing.pas' {frmPING},
  Functions in 'Functions.pas',
  uTracert in 'uTracert.pas' {frmTracert};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmDelSwitchConfirm, frmDelSwitchConfirm);
  Application.CreateForm(TFrmAddSwitch, FrmAddSwitch);
  Application.CreateForm(TfrmChangeSwitch, frmChangeSwitch);
  Application.CreateForm(TfrmRooms, frmRooms);
  Application.CreateForm(TfrmStaff, frmStaff);
  Application.CreateForm(TfrmSockets, frmSockets);
  Application.CreateForm(TfrmFind, frmFind);
  Application.CreateForm(TfrmModels, frmModels);
  Application.CreateForm(TfrmIP, frmIP);
  Application.CreateForm(TfrmPING, frmPING);
  Application.CreateForm(TfrmTracert, frmTracert);
  Application.Run;
end.
