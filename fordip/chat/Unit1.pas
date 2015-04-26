unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, WinSock;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    ServerSocket1: TServerSocket;
    port: TEdit;
    Host: TEdit;
    send: TEdit;
    Memo1: TMemo;
    ServerOff: TButton;
    ServerOn: TButton;
    Client: TButton;
    SendText: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    title: TEdit;
    Label4: TLabel;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ServerOnClick(Sender: TObject);
    procedure ClientClick(Sender: TObject);
    procedure ServerOffClick(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SendTextClick(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetLocalIP: String;
const
    WSVer = $101;
var
 wsaData: TWSAData;
 P: PHostEnt;
 Buf: array [0..127] of Char;
begin
 Result := '';
 if WSAStartup(WSVer, wsaData) = 0 then begin
   if GetHostName(@Buf, 128) = 0 then begin
     P := GetHostByName(@Buf);
     if P <> nil then Result := iNet_ntoa(PInAddr(p^.h_addr_list^)^);
   end;
   WSACleanup;
 end;
end;


procedure TForm1.ClientClick(Sender: TObject);
begin
If Client.Tag=0 then
Begin
// клавишу ServerOn, ServerOff и пол€ Host, Port заблокируем
ServerOff.Enabled:=False;
ServerOn.Enabled:=False;
Host.Enabled:=False;
Port.Enabled:=False;
// запишем указанный порт в ClientSocket
ClientSocket1.Port:=StrToInt(Port.Text);
// запишем хост и адрес
ClientSocket1.Host:=Host.Text;
ClientSocket1.Address:=Host.Text;
// запускаем клиента
ClientSocket1.Active:=True;
// измен€ем тэг
Client.Tag:=1;
// мен€ем надпись клавиши
Client.Caption:='ќтключитьс€';
end
else
Begin
// клавишу ServerOn и пол€ Host, Port разблокируем
ServerOn.Enabled:=True;
ServerOff.Enabled:=False;
Host.Enabled:=True;
Port.Enabled:=True;
// закрываем клиента
ClientSocket1.Active:=False;
// выводим сообщение в Memo
Memo1.Lines.Add('['+TimeToStr(Time)+'] —есси€ закрыта.');
// возвращаем тэгу исходное значение
Client.Tag:=0;
// возвращаем исходную надпись клавиши
Client.Caption:='ѕодключитьс€';
end;
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 // добавим в Memo сообщение о соединении с сервером
Memo1.Lines.Add('['+TimeToStr(Time)+'] ѕодключение к серваку.');
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
// добавим в Memo сообщение о потере св€зи
Memo1.Lines.Add('['+TimeToStr(Time)+'] —ервер не был найден.');
end;

procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
  // добавим в Memo пришедшее сообщение
Memo1.Lines.Add(Socket.ReceiveText());
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Port.Text:='7777';
// при проверке программы на одном ѕ 
Host.Text:='127.0.0.1';
Send.Clear;
Memo1.Lines.Clear;
Edit1.Text:='ip'+GetLocalIP
//ServerOff.Enabled:=False;
end;

procedure TForm1.SendTextClick(Sender: TObject);
begin
// проверка, в каком режиме находитс€ программа
If ServerSocket1.Active=True then
begin
// отправл€ем сообщение с сервера
ServerSocket1.Socket.Connections[0].SendText('['+TimeToStr(Time)+'] '+Edit1.Text);
ServerSocket1.Socket.Connections[0].SendText('['+TimeToStr(Time)+'] '+Send.Text)
end
else
// отправл€ем сообщение с клиента
ClientSocket1.Socket.SendText('['+TimeToStr(Time)+'] '+Send.Text);
// отобразим сообщение в Memo
Memo1.Lines.Add('['+TimeToStr(Time)+'] '+Send.Text);
end;

procedure TForm1.ServerOffClick(Sender: TObject);
begin
// клавишу Client, ServerOn и пол€ Host, Port разблокируем, ServerOff заблокируем
Client.Enabled:=True;
Host.Enabled:=True;
Port.Enabled:=True;
ServerOff.Enabled:=False;
ServerOn.Enabled:=True;
// закрываем сервер
ServerSocket1.Active:=False;
// выводим сообщение в Memo
Memo1.Lines.Add('['+TimeToStr(Time)+'] —ервер закрыт!');
end;

procedure TForm1.ServerOnClick(Sender: TObject);
begin
// клавишу Client, ServerOn и пол€ Host, Port надо заблокировать,
// а ServerOff разблокировать соответственно
ServerOn.Enabled:=False;
Client.Enabled:=False;
Host.Enabled:=False;
Port.Enabled:=False;
ServerOff.Enabled:=True;
// запишем указанный порт в ServerSocket
ServerSocket1.Port:=StrToInt(Port.Text);
// создание сервер
ServerSocket1.Active:=True;
// добавим в Memo сообщение с временем создани€
Memo1.Lines.Add('['+TimeToStr(Time)+'] —ервер создан :)');
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
// добавим в Memo сообщение с временем подключени€ пользовател€
Memo1.Lines.Add('['+TimeToStr(Time)+'] ѕодключилс€ пользователь.');
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Memo1.Lines.Add('['+TimeToStr(Time)+'] ѕользователь отключилс€.');
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Memo1.Lines.Add(Socket.ReceiveText());
end;

end.
