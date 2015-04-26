unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ScktComp;

type
  TChatForm = class(TForm)
    RichEdit1: TRichEdit;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    BitBtn2: TBitBtn;
    Server: TServerSocket;
    Client: TClientSocket;
    procedure FormCreate(Sender: TObject);
    procedure ServerClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ServerClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChatForm: TChatForm;
  status:boolean;
implementation

{$R *.dfm}

procedure TChatForm.BitBtn1Click(Sender: TObject);
begin
Client.Socket.SendText(Edit1.text);
end;

procedure TChatForm.BitBtn2Click(Sender: TObject);
begin
Client.Socket.SendText('Отказ!!!');
Close;
end;

procedure TChatForm.FormCreate(Sender: TObject);
var
  hWndHandle:THANDLE;  
  hMenuHandle : HMENU;
begin
  Server.Active:=True;
 hwndHandle := FindWindow(nil, 'Диалог с системным инженером');
               if (hwndHandle <> 0) then begin
                 hMenuHandle := GetSystemMenu(hwndHandle, FALSE);
                 if (hMenuHandle <> 0) then  
                   DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);  
               end;
end;



procedure TChatForm.ServerClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
showmessage ('Ошибка работы с сокетами');
end;

procedure TChatForm.ServerClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  str:string;
begin

  str:=Server.Socket.ReceiveText;
  RichEdit1.Lines.Add(str);

end;

end.
