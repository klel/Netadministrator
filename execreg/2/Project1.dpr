program Project1;

uses
  Forms,
  registry,Windows;
var
 reg:TRegistry;
{$R *.res}

begin
  Application.Initialize;
   try
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey('software\diploma\',true);
  if reg.ReadBool('simple')=true  then
       WinExec(pchar('RegNCSimple.exe '), sw_show)
  else
     if reg.ReadBool('cisco')=true then
        WinExec(pchar('RegNCCisco.exe '), sw_show);

 finally
    reg.Free;
  Application.Run;
   end;
end.
