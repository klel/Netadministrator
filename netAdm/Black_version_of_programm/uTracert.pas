
unit uTracert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock, Spin;

{$DEFINE NO_MESSAGE}

const
  ICMP = 'ICMP.DLL';
  RES_UNKNOWN   = 'Unknown';
  WSA_TYPE = $101;
  STR_TRACE = 'Трассировка маршрута к ';
  STR_JUMP = 'с максимальным числом прыжков ';
  STR_DONE = 'Трассировка завершена.' + #13#10;
  HOST_NOT_REPLY = 'Превышен интервал ожидания для запроса.';
  
type
  IP_INFO = packed record
    Ttl: Byte;
    Tos: Byte;
    IPFlags: Byte;
    OptSize: Byte;
    Options: Pointer;
  end;
  PIP_INFO = ^IP_INFO;

  ICMP_ECHO = packed record
    Source: Longint;
    Status: Longint;
    RTTime: Longint;
    DataSize: Word;
    Reserved: Word;
    pData: Pointer;
    i_ipinfo: IP_INFO;
  end;

  TfrmTracert = class(TForm)
    edAddr: TEdit;
    btnStart: TButton;
    memShowTracert: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sedCount: TEdit;
    procedure btnStartClick(Sender: TObject);
  end;

  TTraceThread = class(TThread)
  private
    DestAddr: in_addr;
    TraceHandle: THandle;
    DestinationAddress,
    ReportString: String;
    IterationCount: Byte;
  public
    procedure Execute; override;
    procedure Log;
    function Trace(const Iteration: Byte): Longint;
  end;

var
  frmTracert: TfrmTracert;

implementation

{$R *.dfm}

  function IcmpCreateFile: THandle; stdcall; external ICMP name 'IcmpCreateFile';
  function IcmpCloseHandle(IcmpHandle: THandle): BOOL; stdcall;
    external ICMP name 'IcmpCloseHandle';
  function IcmpSendEcho(IcmpHandle : THandle; DestAddress: Longint;
    RequestData: Pointer; RequestSize: Word; RequestOptns: PIP_INFO;
    ReplyBuffer: Pointer; ReplySize, Timeout: DWORD): DWORD; stdcall;
    external ICMP name 'IcmpSendEcho';

{ Other functions }

// Функция возвращает имя хоста по его IP адресу
function GetNameFromIP(const IP: String): String;
const
  ERR_INADDR    = 'Can not convert IP to in_addr.';
  ERR_HOST      = 'Can not get host information.';
  ERR_WSA       = 'Can not initialize WSA.';
var
  WSA   : TWSAData;
  Host  : PHostEnt;
  Addr  : u_long;
  Err   : Integer;
begin
  Result := RES_UNKNOWN;
  Err := WSAStartup(WSA_TYPE, WSA);
  if Err <> 0 then
  begin
    {$IFNDEF NO_MESSAGE}
      MessageDlg(ERR_WSA, mtError, [mbOK], 0);
    {$ENDIF}
    Exit;
  end;
  try
    Addr := inet_addr(PChar(IP));
    if Addr = u_long(INADDR_NONE) then
    begin
      {$IFNDEF NO_MESSAGE}
        MessageDlg(ERR_INADDR, mtError, [mbOK], 0);
      {$ENDIF}
      Exit;
    end;
    Host := gethostbyaddr(@Addr, SizeOf(Addr), PF_INET);
    if Assigned(Host) then
      Result := Host.h_name
    {$IFNDEF NO_MESSAGE}
      else
        MessageDlg(ERR_HOST, mtError, [mbOK], 0)
    {$ENDIF}
    ;
  finally
    WSACleanup;
  end;
end;

// Функция преобразует IP адрес в его строковый эквивалент
function GetDottetIP(const IP: Longint): String;
begin
  Result := Format('%d.%d.%d.%d', [IP and $FF,
    (IP shr 8) and $FF, (IP shr 16) and $FF, (IP shr 24) and $FF]);
end;

{ TfrmMain }

procedure TfrmTracert.btnStartClick(Sender: TObject);
var
  str:string;
begin
  // Чтобы программа не подвисала
  // запускаем трассировку в отдельном потоке
  with TTraceThread.Create(False) do
  begin
    FreeOnTerminate := True;
    // Передаем имя хоста
    DestinationAddress := edAddr.Text;
    // и максимальное число прыжков
    str:=sedCount.Text;
    IterationCount :=StrToInt(str);
    Resume;
  end;
end;

{ TTraceThread }

procedure TTraceThread.Execute;
var
  WSAData: TWSAData;   // Служебные
  Host: PHostEnt;      // переменные
  Error,               // для просмотра кодов ошибок
  TickStart: DWORD;    // для подсчета времени ответа на пинг
  Result: Longint;     // содержит результат выполнения Trace
  I,                   // для цикла
  Iteration: Byte;     // используется для увеличения TTL
  HostName: String;    // содержит имя хоста
  HostReply: Boolean;  // флаг False если хост не ответил 3 раза на пинг
  HostIP: LongInt;     // при ответе хоста сюда заносится его IP (во избежания глюка)
begin
  // Инициализируем Winsock
  Error := WSAStartup(WSA_TYPE, WSAData);
  if Error <> 0 then
  begin
    ReportString := SysErrorMessage(WSAGetLastError);
    Synchronize(Log);
    Exit;
  end;

  try
    // Пытаемся получить IP адрес
    // до которого будем проводить трассировку
    Host := gethostbyname(PChar(DestinationAddress));
    if not Assigned(Host) then
    begin
      ReportString := SysErrorMessage(WSAGetLastError);
      Synchronize(Log);
      Exit;
    end;

    // Запоминаем полученый адрес
    DestAddr := PInAddr(Host.h_addr_list^)^;

    // Подготавливаемся к отправке эхозапросов (пинга)
    TraceHandle := IcmpCreateFile;
    if TraceHandle = INVALID_HANDLE_VALUE then
    begin
      ReportString := SysErrorMessage(GetLastError);
      Synchronize(Log);
      Exit;
    end;

    try
      // Выводим информационные строки вида:
      // Трассировка маршрута к www.delphimaster.ru [62.118.251.90]
      // с максимальным числом прыжков 30:
      ReportString := STR_TRACE + DestinationAddress
        + ' [' + GetDottetIP(DestAddr.S_addr)+ ']' + #13#10;
      Synchronize(Log);
      ReportString := STR_JUMP + IntToStr(IterationCount) + ':' + #13#10;
      Synchronize(Log);

      // Инициализируем переменные
      Result := 0;
      Iteration := 0;

      // Начинаем трассировку до тех пор
      while (Result <> DestAddr.S_addr) and // пока IP адреса не совпадут
            (Iteration < IterationCount) do // или кол-во прыжков достигнет максимального
      begin
        Inc(Iteration); // Увеличиваем время жизни пакета (TTL)

        HostReply := False; // Выставляем флаг, "хост пока не ответил"

        // Запускаем серию из 3 эхозапросов
        for I := 0 to 2 do
        begin
          TickStart := GetTickCount;  // Для каждого засекаем время
          Result := Trace(Iteration); // Делаем пинг

          if Result = -1 then // Если нет ответа выводим звезду
            ReportString := '    *    '
          else
          begin  // Если есть ответ - выводим данные (результатом будет IP ответившего)
            ReportString := Format('%6d ms', [GetTickCount - TickStart]);
            HostReply := True;  // и не забываем выставить флаг, что хост ответил
            HostIP := Result;   // а также запомним его IP
          end;

          // Выравнивание текста...
          if I = 0 then
            ReportString := Format('%3d: %s', [Iteration, ReportString]);
            
          Synchronize(Log);
        end;

        if HostReply then // Если хост ответил хотябы на 1 пинг
        begin
          // Получаем преобразованный в строковый вид IP
          ReportString := GetDottetIP(HostIP);
          // Получаем имя хоста
          HostName := GetNameFromIP(ReportString);
          // Вывод данных в зависимости от того - получено ли имя хоста
          if HostName <> RES_UNKNOWN then
            ReportString := HostName + '[' + ReportString + ']';
          ReportString := ReportString + #13#10;
        end
        else // или выводим "Превышен интервал ожидания для запроса."
          ReportString := HOST_NOT_REPLY + #13#10;

        // Небольшая поправка для нагрядности...
        ReportString := '  ' + ReportString;
        Synchronize(Log);
      end;

    finally
      IcmpCloseHandle(TraceHandle);
    end;

    // Вот и все...
    // Выводим информационную строку "Трассировка завершена."
    ReportString := STR_DONE;
    Synchronize(Log);
  finally
    WSACleanup;
  end;
end;

// Процедура отвечает за вывод информации в memShowTracert
procedure TTraceThread.Log;
begin
  frmTracert.memShowTracert.Text :=
    frmTracert.memShowTracert.Text + ReportString;
  SendMessage(frmTracert.memShowTracert.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

// Однократная посылка эхозапроса
function TTraceThread.Trace(const Iteration: Byte): Longint;
var
  IP: IP_INFO;
  ECHO: ^ICMP_ECHO;
  Error: Integer;
begin
  GetMem(ECHO, SizeOf(ICMP_ECHO));
  try
    with IP do // Заполнение заголовка
    begin
      Ttl := Iteration; // Самый важный момент в трассировке -  постепенное увеличение TTL
      Tos := 0;
      IPFlags := 0;
      OptSize := 0;
      Options := nil;
    end;

    // Непосредственно посылка эхозапроса
    Error := IcmpSendEcho(TraceHandle,
                          DestAddr.S_addr,
                          nil,
                          0,
                          @IP,
                          ECHO,
                          SizeOf(ICMP_ECHO),
                          5000);
    // Проверка на ошибки
    if Error = 0 then
    begin
      Result := -1;
      Exit;
    end;

    // Если ошибок не обнаружено результатом будет IP адрес ответившего хоста
    Result := ECHO.Source;

  finally
    FreeMem(ECHO);
  end;

end;

end.

