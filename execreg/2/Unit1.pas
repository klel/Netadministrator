unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Registry;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  reg:TRegistry;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
ShowMessage (handle,0);
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
 end;
Close;

end;

end.
