unit Swich;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, ExtCtrls, Menus, Buttons ,WinSock, jpeg;

type
  TSwichForm = class(TForm)
    PortPop: TPopupMenu;
    N1: TMenuItem;
    discon: TMenuItem;
    SpeedButton1: TSpeedButton;
    PingH: TMenuItem;
    Image1: TImage;
    procedure CreateSw(Sender: TObject);
    procedure DestroyOb(Sender: TObject; var Action: TCloseAction);
    procedure OnMouseDownPort (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure disconClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MouseUnderport(Sender: TObject);
    procedure MouseLeavePort (Sender: TObject);
    procedure InfoPort(Sender: TObject);
  private
   const
      maxcolPort=32;
  public
    GenerMessSw:byte;
    ini:TIniFile;
    ColPort:byte;
    PortArray:array [1..maxcolPort] of TImage;
    swX,swY:integer;         ////coords of swich
  end;

function HostToIP(name: string; var Ip: string): Boolean;
function SearchPC (name:string):string;

const
  INI_NAME='Data.ini';
  WINSOCK_VERSION=$0101;
var
  SwichForm: TSwichForm;
  GenerMessPort: byte;

implementation

uses PortEnter, UPing, Functions, WrkTbl;

{$R *.dfm}
function SearchPC (name:string):string;
var
  nmpc:string;
  colPc,i:integer;
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  colPc:=ini.ReadInteger('ColPc','Col',0);

  for i := 1 to colPc do
    begin
      if ini.ValueExists ('PC'+IntToStr(i),'DataExist') then
        begin
          nmpc:=ini.ReadString('PC'+intToStr (i),'DNS','');
          if name=nmpc then
           begin
            result:=ini.ReadString('PC'+intToStr (i),'Name','');
            exit;
           end;
        end
        else
          Continue;
    end;
ini.Free;
end;

function HostToIP(name: string; var Ip: string): Boolean;
var
  wsdata : TWSAData;
  hostName : array [0..255] of char;
  hostEnt : PHostEnt;
  addr : PChar;
begin
  WSAStartup (WINSOCK_VERSION, wsdata);
  try
    gethostname (hostName, sizeof (hostName));
    StrPCopy(hostName, name);
    hostEnt := gethostbyname (hostName);
    if Assigned (hostEnt) then
      if Assigned (hostEnt^.h_addr_list) then begin
        addr := hostEnt^.h_addr_list^;
        if Assigned (addr) then begin
          IP := Format ('%d.%d.%d.%d', [byte (addr [0]),
          byte (addr [1]), byte (addr [2]), byte (addr [3])]);
          Result := True;
        end
        else
          Result := False;
      end
      else
        Result := False
    else begin
      Result := False;
    end;
  finally
    WSACleanup;
  end
end;

procedure TSwichForm.MouseLeavePort (Sender: TObject);
var
  sw:string;
begin
Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
sw:=ini.ReadString ('Swich'+IntToStr (GenerMessSw),'Port'+intToStr (portArray[TImage(Sender).Tag].Tag),'');
    if sw>'' then
      begin
        if ((sw[1]='s') or (sw[1]='S'))and (sw[2]='w')and (sw[3]='i') then
          portArray[Timage(Sender).Tag].Picture.LoadFromFile('.\pic\connectedsw.bmp')
        else
          portArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\connected.bmp');
      end
    else
        //  ShoWMessage ('Discon');
         portArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\disconnected.bmp');
ini.Free;
end;

procedure TSwichForm.OnMouseDownPort (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
var
  sw:string;

begin
Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
sw:=ini.ReadString ('Swich'+IntToStr (GenerMessSw),'Port'+intToStr (portArray[TImage(Sender).Tag].Tag),'');
    if sw>'' then
      begin
        if ((sw[1]='s') or (sw[1]='S'))and (sw[2]='w')and (sw[3]='i') then
           PingH.Visible:=false
        else
           PingH.Visible:=true;
      end;

if ssRight in Shift then
   begin
      PortForm.PortGen:=TImage(Sender).Tag;
      GenerMessPort:= TImage(Sender).Tag;
   end
else if ssLeft in Shift then
   begin
      PortForm.PortGen:=TImage(Sender).Tag;
      GenerMessPort:= TImage(Sender).Tag;
   end;

end;


procedure TSwichForm.SpeedButton1Click(Sender: TObject);
begin
//Destroy;
Close;
end;

procedure TSwichForm.disconClick(Sender: TObject);
var
  Str:string;
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  str:=ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(PortForm.PortGen),'');
  if str>''then
    begin
      ini.WriteString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(Portform.PortGen),'');
      portArray[PortForm.PortGen].Picture.LoadFromFile('.\pic\disconnected.bmp');
    end
  else ShowMessage ('Вы пытаетесь отсоедеинить не присоединенный кабель!');
  ini.Free;
end;

procedure TSwichForm.InfoPort(Sender: TObject);
var
  dns:string;
  i,pcX,pcY:integer;
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  dns:=ini.ReadString ('Swich'+IntToStr(GenerMessSw),'Port'+IntToStr(GenerMessPort),'');
  if (ini.ReadString ('Swich'+IntToStr(GenerMessSw),'Port'+IntToStr(GenerMessPort),'')>'') and (SearchPc (dns)>'') then
     begin
       frmPing.Left:=  Screen.WorkAreaHeight div 2-frmPing.Height;
       pcX:=Main.pcArray [ini.ReadInteger(SearchPc(dns),'Tag',0)].Left;
      pcY:=Main.pcArray [ini.ReadInteger(SearchPc(dns),'Tag',0)].Top;
      Main.Image1.Canvas.Pen.Width:=1;
      Main.Image1.Canvas.Pen.Style:=psDot;
      Main.Image1.Canvas.Pen.Color:=clBlue;
      Main.Image1.Canvas.MoveTo(swX,swY);
      Main.Image1.Canvas.LineTo(pcX,pcY);
      frmPing.BitBtn1.Enabled:=False;
      frmPing.BitBtn2.Enabled:=False;
      frmPing.Edit1.Enabled:=False;
      frmPing.Show;
      frmPing.memo1.Lines.Clear;
      frmPing.progressbar1.Position:=0;
      Functions.Ping (dns,frmPing.Memo1);
     for i := 0 to frmPing.progressbar1.max  do  frmPing.progressbar1.Position:=i;
  end
  else
   ShowMessage ('Port Error!!!');
   //ShowMessage (SearchPc(dns));
  // ShowMessage (intTostr(ini.ReadInteger(SearchPc(dns),'Tag',0)));

 ini.Free;
end;

procedure TSwichForm.MouseUnderport(Sender: TObject);
var
  ip:string;
  str,strnm,sw:string;
begin
Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
portArray[TImage(Sender).Tag].ShowHint:=True;
str:= ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(portArray[TImage(Sender).Tag].Tag),'');
 strnm:=ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(TImage(Sender).Tag),'');
 portArray[TImage(Sender).Tag].ShowHint:=True;
 if HostToIP (str,ip) then
   begin
     if str>'' then
       portArray[TImage(Sender).Tag].Hint:='number of port- '+intToStr(portArray[TImage(Sender).Tag].Tag)+#13+
                                         'ip address - '+ip+#13+
                                         'DNS/NETBIOS- '+strnm
        else
           portArray[TImage(Sender).Tag].Hint:='number of port- '+intToStr(portArray[TImage(Sender).Tag].Tag);



   {except
  ini.WriteString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(portArray[TImage(Sender).Tag].Tag),'');
  //PortForm.PortGen:=TImage(Sender).Tag;
  ShowMessage ('На порту '+inttostr(TImage(Sender).Tag)+' сработало исключение!Он будет отключен!');
  portArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\disconnected.bmp');
end;  }
 {  if ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(portArray[TImage(Sender).Tag].Tag),'')>'' then
        portArray[TImage(Sender).Tag].Hint:='number of port- '+intToStr(portArray[TImage(Sender).Tag].Tag)+#13+
                                            'ip address - '+NameToIpExt (ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(portArray[TImage(Sender).Tag].Tag),''))
   else
      portArray[TImage(Sender).Tag].Hint:='number of port- '+intToStr(portArray[TImage(Sender).Tag].Tag); }
end
else
  portArray[TImage(Sender).Tag].Hint:='number of port- '+intToStr(portArray[TImage(Sender).Tag].Tag)+#13+
                                       'Ошибка WinSock!!!'+#13+
                                       'DNS/NETBIOS(maybe not true)- '+strnm;
sw:=ini.ReadString ('Swich'+IntToStr (GenerMessSw),'Port'+intToStr (Timage(Sender).Tag),'');
if sw>'' then
 begin
    if ((sw[1]='s') or (sw[1]='S'))and (sw[2]='w')and (sw[3]='i') then
          portArray[Timage(Sender).Tag].Picture.LoadFromFile('.\pic\chooseconnectedsw.bmp')
    else
       portArray[Timage(Sender).Tag].Picture.LoadFromFile('.\pic\connected_choosen.bmp')
 end

else
    portArray[Timage(Sender).Tag].Picture.LoadFromFile('.\pic\disconnected_choosen.bmp');
ini.Free;
end;

procedure TSwichForm.CreateSw(Sender: TObject);
var
  i,isw:byte;
  sw:string;
begin
SwichForm.Color:=RGB ($A2,$A2,$A2);
if ColPort<maxcolPort then
begin
SwichForm.Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  For i:=1 to ColPort do
     begin
        portArray[i]:= TImage.Create(Self);
        portArray[i].Parent:= Self;
        //portArray[i].Height:=ini.ReadInteger('Swich'+IntToStr(j),'Height',100);
        //swArray[j].Width:=ini.ReadInteger('Swich'+IntToStr(j),'Width',100);
        {portArray[i].ShowHint:=True;
        if ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(portArray[TImage(Sender).Tag].Tag),'')>'' then
           portArray[].Hint:='number of port- '+intToStr(portArray[TImage(Sender).Tag].Tag)+#13+
                                              'ip address - '+NameToIpExt (ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(portArray[TImage(Sender).Tag].Tag),''))
        else
           portArray[TImage(Sender).Tag].Hint:='number of port- '+intToStr(portArray[TImage(Sender).Tag].Tag);
          }
        portArray[i].Left:=15+i*35;
        portArray[i].Top:=20;
        portArray[i].Name:='Port'+InttoStr (i);
        PortArray[i].Tag:=i;
        //showmessage (inttostr(swArray[j].Tag));
        portArray[i].Autosize:=True;
        portArray[i].PopupMenu:=PortPop;
        portArray[i].OnMouseDown:=OnMouseDownPort;
        portArray[i].OnMouseEnter:=MouseUnderPort;
        portArray[i].OnMouseLeave:=MouseLeavePort;
        {swArray[j].OnMouseMove:=OnMove;
        swArray[j].OnMouseUp:=MouseUpToSw;}
        sw:=ini.ReadString ('Swich'+IntToStr (GenerMessSw),'Port'+intToStr (i),'');
        if sw>'' then
          begin
            if ((sw[1]='s') or (sw[1]='S'))and (sw[2]='w')and (sw[3]='i') then
          portArray[i].Picture.LoadFromFile('.\pic\connectedsw.bmp')
            else portArray[i].Picture.LoadFromFile('.\pic\connected.bmp');
          end
        else
          portArray[i].Picture.LoadFromFile('.\pic\disconnected.bmp');


     end;
SwichForm.Width:=(PortArray[1].Width+25)*colPort;
end
else ShowMessage ('Вы ввели недопустимое число портов!Максимальное количество- 32');
isw:= ini.ReadInteger('Swich'+intTostr (GenerMessSw),'ColPort',0);
case isw of
 12..18:begin
          Image1.Picture.LoadFromFile('.\pic\1\label.jpg');
          Image1.Align:=alRight;
        end;
  19..25:begin
          Image1.Picture.LoadFromFile('.\pic\2\выход_1.jpg');
          Image1.Align:=alRight;
        end;
  26..32:begin
          Image1.Picture.LoadFromFile('.\pic\2\киско_3.jpg');
          Image1.Align:=alRight;
        end
  else  Image1.Picture.LoadFromFile('.\pic\1\label.jpg');

end;

ini.Free;
end;

procedure TSwichForm.DestroyOb(Sender: TObject; var Action: TCloseAction);
var
  i,j:byte;
  x,y:integer;
begin
SwichForm.Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  For i:=1 to ColPort do
    portArray[i].Free;
  frmPing.Close;
  Main.Image1.Picture.LoadFromFile(ini.ReadString ('Map','Picture','.\pic\testmap.bmp'));
  main.image1.Canvas.Font.Color:=clGreen;
  for j := 1 to ColText do
     begin
        x:=ini.ReadInteger ('Text'+IntToStr(j),'X',0);
        y:=ini.ReadInteger ('Text'+IntToStr(j),'Y',0);
        text:=ini.ReadString ('Text'+IntToStr(j),'Text','default text');
        Main.image1.Canvas.TextOut(X,Y,text);
     end;
ini.Free;
end;

procedure TSwichForm.N1Click(Sender: TObject);
var
  str: string;
begin
 Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
 str:=ini.ReadString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(PortForm.PortGen),'');
 if str>'' then
  begin
   if Application.MessageBox(PChar('Вы пытаетесь изменить имя подключения!Для продолжения жмите Ок'),'Warning!!!',MB_OKCANCEL)=id_OK then
     begin
       ini.WriteString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(PortForm.PortGen),'');
       portArray[PortForm.PortGen].Picture.LoadFromFile('.\pic\disconnected.bmp');
       Portform.Show;
     end
   else
     Exit;
  end
  else Portform.Show;
PortForm.Edit1.Text:='';
end;

end.
