unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Edit1: TEdit;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Nick : string;
implementation

{$R *.dfm}

uses
 l_net;

// ИНИЦИАЛИЗАЦИЯ //
procedure TForm1.FormCreate(Sender: TObject);
begin

randomize;
Nick := 'User_' + IntToStr(random(1000));

if not NET_Init then // Инициализация сетевого модуля
 begin
 MessageBox(Handle, 'Невозможно инициализировать сетевой протокол', 'Ошибка', MB_ICONHAND);
 Halt;
 end;
NET_InitSocket(21666); // Инициализируем сокет на 21666 порту
end;

// ВЫСВОБОЖДЕНИЕ //
procedure TForm1.FormDestroy(Sender: TObject);
begin
NET_Free; // Высвобождение ресурсов
end;

// ОБРАБОТКА ВВОДА //
procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 str : string;
begin
if Key = VK_RETURN then // Если пользователь нажал Enter
 begin
 str := '<' + Nick + '>: ' + Edit1.Text; // составляем сообщение
 Edit1.Text := '';

 NET_Clear;                        // чистим сетевой буфер
 NET_Write(@str[1], Length(Str));  // пишем данные
 NET_Send(nil, 21666, false);      // посылаем их широковещательным пакетом
 end;
end;

// ОБРАБОТКА ВХОДЯЩИХ СООБЩЕНИЙ //
procedure TForm1.Timer1Timer(Sender: TObject);
var
 buf  : array [0..255] of Char;
 recv : integer;
 IP   : PChar;
 Port : integer;
begin
//NET_Update не вызывается, т.к. APL пакеты не посылаем...
// Цикл до тех пор, пока в очереди входящих есть пакеты
while NET_Recv(@buf, 255, IP, Port, recv) > 0 do
 Memo1.Lines.Add(Copy(buf, 1, recv));
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 Edit1.Width:=Panel1.Width-20;
end;

end.
