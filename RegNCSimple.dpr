program RegNCSimple;

uses
  Forms,
  Registry,
  Windows,
  Dialogs,
  Ptool in 'Ptool.pas' {nwTools},
  Pfield in 'Pfield.pas' {nwMap},
  WrkTbl in 'WrkTbl.pas' {Main},
  SWEnter in 'SWEnter.pas' {SwDataEnter},
  PCEnter in 'PCEnter.pas' {PCDataEnter},
  Swich in 'Swich.pas' {SwichForm},
  PortEnter in 'PortEnter.pas' {portform},
  Functions in 'Functions.pas',
  UPing in 'UPing.pas' {frmPING},
  Netres in 'Netres.pas' {NetResForm},
  UExec in 'UExec.pas' {FExec},
  About in 'About.pas' {Aboutfrm};

{$R *.res}
var
  reg:TRegistry;

begin
  Application.Initialize;
  try
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey('software\diploma\',true);


  if reg.ReadBool('execflag')=false  then
     begin
     ShowMessage ('Приложение запущено впервые. Будет запущен конструктор сети');
       Application.CreateForm(TnwTools, nwTools);
  Application.CreateForm(TnwMap, nwMap);
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TSwDataEnter, SwDataEnter);
  Application.CreateForm(TPCDataEnter, PCDataEnter);
  Application.CreateForm(TSwichForm, SwichForm);
  Application.CreateForm(Tportform, portform);
  Application.CreateForm(TfrmPING, frmPING);
  Application.CreateForm(TNetResForm, NetResForm);
  Application.CreateForm(TFExec, FExec);
  Application.CreateForm(TAboutfrm, Aboutfrm);
  reg.WriteBool('execflag',true);
  reg.Free;
  end

  else
    begin
       Application.CreateForm(TMain, Main);
       Application.CreateForm(TnwTools, nwTools);
       Application.CreateForm(TnwMap, nwMap);
       Application.CreateForm(TSwDataEnter, SwDataEnter);
       Application.CreateForm(TPCDataEnter, PCDataEnter);
       Application.CreateForm(TSwichForm, SwichForm);
       Application.CreateForm(Tportform, portform);
       Application.CreateForm(TfrmPING, frmPING);
       Application.CreateForm(TNetResForm, NetResForm);
       Application.CreateForm(TFExec, FExec);
       Application.CreateForm(TAboutfrm, Aboutfrm);
       reg.Free;
    end;
  except
  ShowMessage ('Ошибка доступа к реестру');
  end;
       Application.Run;

end.
