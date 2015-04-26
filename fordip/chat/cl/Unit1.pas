unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp;

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


procedure TForm1.ClientClick(Sender: TObject);
begin
If Client.Tag=0 then
Begin
// ������� ServerOn, ServerOff � ���� Host, Port �����������
ServerOff.Enabled:=False;
ServerOn.Enabled:=False;
Host.Enabled:=False;
Port.Enabled:=False;
// ������� ��������� ���� � ClientSocket
ClientSocket1.Port:=StrToInt(Port.Text);
// ������� ���� � �����
ClientSocket1.Host:=Host.Text;
ClientSocket1.Address:=Host.Text;
// ��������� �������
ClientSocket1.Active:=True;
// �������� ���
Client.Tag:=1;
// ������ ������� �������
Client.Caption:='�����������';
end
else
Begin
// ������� ServerOn � ���� Host, Port ������������
ServerOn.Enabled:=True;
ServerOff.Enabled:=False;
Host.Enabled:=True;
Port.Enabled:=True;
// ��������� �������
ClientSocket1.Active:=False;
// ������� ��������� � Memo
Memo1.Lines.Add('['+TimeToStr(Time)+'] ������ �������.');
// ���������� ���� �������� ��������
Client.Tag:=0;
// ���������� �������� ������� �������
Client.Caption:='������������';
end;
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 // ������� � Memo ��������� � ���������� � ��������
Memo1.Lines.Add('['+TimeToStr(Time)+'] ����������� � �������.');
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
// ������� � Memo ��������� � ������ �����
Memo1.Lines.Add('['+TimeToStr(Time)+'] ������ �� ��� ������.');
end;

procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
  // ������� � Memo ��������� ���������
Memo1.Lines.Add(Socket.ReceiveText());
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Port.Text:='777';
// ��� �������� ��������� �� ����� ��
Host.Text:='127.0.0.1';
Send.Clear;
Memo1.Lines.Clear;
ServerOff.Enabled:=False;
end;

procedure TForm1.SendTextClick(Sender: TObject);
begin
// ��������, � ����� ������ ��������� ���������
If ServerSocket1.Active=True then
// ���������� ��������� � �������
ServerSocket1.Socket.Connections[0].SendText('['+TimeToStr(Time)+'] '+Send.Text)
else
// ���������� ��������� � �������
ClientSocket1.Socket.SendText('['+TimeToStr(Time)+'] '+Send.Text);
// ��������� ��������� � Memo
Memo1.Lines.Add('['+TimeToStr(Time)+'] '+Send.Text);
end;

procedure TForm1.ServerOffClick(Sender: TObject);
begin
// ������� Client, ServerOn � ���� Host, Port ������������, ServerOff �����������
Client.Enabled:=True;
Host.Enabled:=True;
Port.Enabled:=True;
ServerOff.Enabled:=False;
ServerOn.Enabled:=True;
// ��������� ������
ServerSocket1.Active:=False;
// ������� ��������� � Memo
Memo1.Lines.Add('['+TimeToStr(Time)+'] ������ ������!');
end;

procedure TForm1.ServerOnClick(Sender: TObject);
begin
// ������� Client, ServerOn � ���� Host, Port ���� �������������,
// � ServerOff �������������� ��������������
ServerOn.Enabled:=False;
Client.Enabled:=False;
Host.Enabled:=False;
Port.Enabled:=False;
ServerOff.Enabled:=True;
// ������� ��������� ���� � ServerSocket
ServerSocket1.Port:=StrToInt(Port.Text);
// �������� ������
ServerSocket1.Active:=True;
// ������� � Memo ��������� � �������� ��������
Memo1.Lines.Add('['+TimeToStr(Time)+'] ������ ������ :)');
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
// ������� � Memo ��������� � �������� ����������� ������������
Memo1.Lines.Add('['+TimeToStr(Time)+'] ����������� ������������.');
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Memo1.Lines.Add('['+TimeToStr(Time)+'] ������������ ����������.');
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Memo1.Lines.Add(Socket.ReceiveText());
end;

end.
