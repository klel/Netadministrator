unit enddialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, registry,ShlObj,ActiveX, ComObj;
Const N = 100;

type
  Tenddlg = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
type 
  ShortcutType = (_DESKTOP, _QUICKLAUNCH, _SENDTO, _STARTMENU, _OTHERFOLDER); 
var
  enddlg: Tenddlg;
implementation

uses first;

{$R *.dfm}

function CreateShortcut(SourceFileName: string; // the file the shortcut points to 
                        Location: ShortcutType; // shortcut location 
                        SubFolder,  // subfolder of location 
                        WorkingDir, // working directory property of the shortcut 
                        Parameters, 
                        Description: string): //  description property of the shortcut 
                        string; 
const 
  SHELL_FOLDERS_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\Explorer'; 
  QUICK_LAUNCH_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\GrpConv'; 
var 
  MyObject: IUnknown; 
  MySLink: IShellLink; 
  MyPFile: IPersistFile; 
  Directory, LinkName: string; 
  WFileName: WideString; 
  Reg: TRegIniFile; 
begin 

  MyObject := CreateComObject(CLSID_ShellLink); 
  MySLink := MyObject as IShellLink; 
  MyPFile := MyObject as IPersistFile; 

  MySLink.SetPath(PChar(SourceFileName)); 
  MySLink.SetArguments(PChar(Parameters)); 
  MySLink.SetDescription(PChar(Description)); 

  LinkName := ChangeFileExt(SourceFileName, '.lnk'); 
  LinkName := ExtractFileName(LinkName); 

  // Quicklauch 
  if Location = _QUICKLAUNCH then 
  begin 
    Reg := TRegIniFile.Create(QUICK_LAUNCH_ROOT); 
    try 
      Directory := Reg.ReadString('MapGroups', 'Quick Launch', ''); 
    finally 
      Reg.Free; 
    end; 
  end 
  else 
  // Other locations 
  begin 
    Reg := TRegIniFile.Create(SHELL_FOLDERS_ROOT); 
    try 
    case Location of 
      _OTHERFOLDER : Directory := SubFolder; 
      _DESKTOP     : Directory := Reg.ReadString('Shell Folders', 'Desktop', ''); 
      _STARTMENU   : Directory := Reg.ReadString('Shell Folders', 'Start Menu', ''); 
      _SENDTO      : Directory := Reg.ReadString('Shell Folders', 'SendTo', ''); 
    end; 
    finally 
      Reg.Free; 
    end; 
  end; 

  if Directory <> '' then 
  begin 
    if (SubFolder <> '') and (Location <> _OTHERFOLDER) then 
      WFileName := Directory + '\' + SubFolder + '\' + LinkName 
    else 
      WFileName := Directory + '\' + LinkName; 


    if WorkingDir = '' then 
      MySLink.SetWorkingDirectory(PChar(ExtractFilePath(SourceFileName))) 
    else 
      MySLink.SetWorkingDirectory(PChar(WorkingDir)); 

    MyPFile.Save(PWChar(WFileName), False); 
    Result := WFileName; 
  end; 
end;

function GetProgramDir: string; 
var 
  reg: TRegistry; 
begin 
  reg := TRegistry.Create; 
  try 
    reg.RootKey := HKEY_CURRENT_USER; 
    reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False); 
    Result := reg.ReadString('Programs'); 
    reg.CloseKey; 
  finally 
    reg.Free; 
  end; 
end;


procedure Tenddlg.Button1Click(Sender: TObject);
var 
WorkTable:String;
Find:_WIN32_FIND_DATAA; 
P:PItemIDList;
C:array [0..1000] of char;
begin
ffrm.Close;
end;

procedure Tenddlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ffrm.Close;
end;

end.
