unit Ptool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtDlgs, StdCtrls,IniFiles, XPMan, ExtCtrls;

type
  TnwTools = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    SpeedButton5: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Edit1: TEdit;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    XPManifest1: TXPManifest;
    procedure SwichCreate(Sender: TObject);
    procedure ShowForm(Sender: TObject);
    procedure CompCreate(Sender: TObject);
    procedure refresh(Sender: TObject);
    procedure NoteCreate(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure CreateFrm(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  INI_NAME= 'Data.ini';

var
  nwTools: TnwTools;
  flag:boolean;
  ini:TIniFile;

implementation

uses Pfield, WrkTbl;

{$R *.dfm}

procedure TnwTools.refresh(Sender: TObject);
var
  j,x,y:integer;
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  nwMap.Image1.Picture.LoadFromFile(ini.ReadString ('Map','Picture','.\pic\testmap.bmp'));
    nwMap.image1.Canvas.Font.Color:=clGreen;
  for j := 1 to ColText do
     begin
        x:=ini.ReadInteger ('Text'+IntToStr(j),'X',0);
        y:=ini.ReadInteger ('Text'+IntToStr(j),'Y',0);
        text:=ini.ReadString ('Text'+IntToStr(j),'Text','default text');
        nwMap.image1.Canvas.TextOut(X,Y,text);
     end;
  nwMap.Image1.Canvas.Refresh;
  nwTools.Caption:='Инструменты построения';
  ini.Free;
end;

procedure TnwTools.CreateFrm(Sender: TObject);
var
  hwndHandle: THANDLE;
  hMenuHandle: HMENU;
  iPos: integer;
begin
flag:=false;
 hwndHandle:=FindWindow(nil,PChar(Caption));
  if hwndHandle<>0 then
     begin
       hMenuHandle:=GetSystemMenu(hwndHandle,false);
       if hMenuHandle<>0 then
         begin
           DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
           iPos:=GetMenuItemCount(hMenuHandle);
           dec(iPos);
           if iPos > -1 then // Проверяем, что нет ошибки
           DeleteMenu(hMenuHandle, iPos, MF_BYPOSITION);
         end
     end
end;



procedure TnwTools.NoteCreate(Sender: TObject);
begin
  nwMap.Show;
  nwMap.CreateImg (30,'.\pic\ltop2.bmp','Note');
end;

procedure TnwTools.ShowForm(Sender: TObject);
begin
  nwMap.Show;
end;

procedure TnwTools.SpeedButton4Click(Sender: TObject);
begin
 SpeedButton6.Down:=false;
 Edit1.Visible:=False;
end;

procedure TnwTools.SpeedButton6Click(Sender: TObject);
begin
SpeedButton4.Down:=false;
if flag=false then
begin
  ShowMessage ('Внимание!!!Текстовые заметки можно удалить'+#13+
           'путем редактирования файла Settings.ini');
  Edit1.Visible:=True;
  flag:=true;
end
else
   if nwTools.SpeedButton6.Down then
        Edit1.Visible:=True
      else
        Edit1.Visible:=False;
end;

procedure TnwTools.SpeedButton7Click(Sender: TObject);
begin
if Application.MessageBox(pchar('Чтобы изменения вступили в силу необходимо перезагрузить приложение'),'Внимание!',MB_OKCANCEL)=idOk then
Main.Close
else
begin
Main.Show;
nwMap.Close;
Close;
ShowWindow (Main.Handle,SW_NORMAL);
SpeedButton7.Down:=False;
end;
end;

procedure TnwTools.SpeedButton8Click(Sender: TObject);
begin
  Edit1.Visible:=False;
  try
    if nwMap.OpenPic.Execute then
    nwMap.Image1.Picture.LoadFromFile(nwMap.OpenPic.Filename);
  except
    ShowMessage ('Error!!!');
  end;
  SpeedButton8.Down:=false;
  //ShowMessage (nwMap.OpenPic.FileName);
  {nwMap.OpenPic.InitialDir:= GetCurrentDir;
  nwMap.OpenPic.Execute;}
end;

procedure TnwTools.CompCreate(Sender: TObject);
begin
  nwMap.Show;
  nwMap.CreateImg (20,'.\pic\pc2.bmp','PC');
end;

procedure TnwTools.SwichCreate(Sender: TObject);
begin
  nwMap.Show;
  nwMap.CreateImg (10,'.\pic\swch2.bmp','Swich');
end;

end.
