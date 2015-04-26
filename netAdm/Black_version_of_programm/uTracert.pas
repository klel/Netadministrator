
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
  STR_TRACE = '����������� �������� � ';
  STR_JUMP = '� ������������ ������ ������� ';
  STR_DONE = '����������� ���������.' + #13#10;
  HOST_NOT_REPLY = '�������� �������� �������� ��� �������.';
  
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

// ������� ���������� ��� ����� �� ��� IP ������
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

// ������� ����������� IP ����� � ��� ��������� ����������
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
  // ����� ��������� �� ���������
  // ��������� ����������� � ��������� ������
  with TTraceThread.Create(False) do
  begin
    FreeOnTerminate := True;
    // �������� ��� �����
    DestinationAddress := edAddr.Text;
    // � ������������ ����� �������
    str:=sedCount.Text;
    IterationCount :=StrToInt(str);
    Resume;
  end;
end;

{ TTraceThread }

procedure TTraceThread.Execute;
var
  WSAData: TWSAData;   // ���������
  Host: PHostEnt;      // ����������
  Error,               // ��� ��������� ����� ������
  TickStart: DWORD;    // ��� �������� ������� ������ �� ����
  Result: Longint;     // �������� ��������� ���������� Trace
  I,                   // ��� �����
  Iteration: Byte;     // ������������ ��� ���������� TTL
  HostName: String;    // �������� ��� �����
  HostReply: Boolean;  // ���� False ���� ���� �� ������� 3 ���� �� ����
  HostIP: LongInt;     // ��� ������ ����� ���� ��������� ��� IP (�� ��������� �����)
begin
  // �������������� Winsock
  Error := WSAStartup(WSA_TYPE, WSAData);
  if Error <> 0 then
  begin
    ReportString := SysErrorMessage(WSAGetLastError);
    Synchronize(Log);
    Exit;
  end;

  try
    // �������� �������� IP �����
    // �� �������� ����� ��������� �����������
    Host := gethostbyname(PChar(DestinationAddress));
    if not Assigned(Host) then
    begin
      ReportString := SysErrorMessage(WSAGetLastError);
      Synchronize(Log);
      Exit;
    end;

    // ���������� ��������� �����
    DestAddr := PInAddr(Host.h_addr_list^)^;

    // ���������������� � �������� ����������� (�����)
    TraceHandle := IcmpCreateFile;
    if TraceHandle = INVALID_HANDLE_VALUE then
    begin
      ReportString := SysErrorMessage(GetLastError);
      Synchronize(Log);
      Exit;
    end;

    try
      // ������� �������������� ������ ����:
      // ����������� �������� � www.delphimaster.ru [62.118.251.90]
      // � ������������ ������ ������� 30:
      ReportString := STR_TRACE + DestinationAddress
        + ' [' + GetDottetIP(DestAddr.S_addr)+ ']' + #13#10;
      Synchronize(Log);
      ReportString := STR_JUMP + IntToStr(IterationCount) + ':' + #13#10;
      Synchronize(Log);

      // �������������� ����������
      Result := 0;
      Iteration := 0;

      // �������� ����������� �� ��� ���
      while (Result <> DestAddr.S_addr) and // ���� IP ������ �� ��������
            (Iteration < IterationCount) do // ��� ���-�� ������� ��������� �������������
      begin
        Inc(Iteration); // ����������� ����� ����� ������ (TTL)

        HostReply := False; // ���������� ����, "���� ���� �� �������"

        // ��������� ����� �� 3 �����������
        for I := 0 to 2 do
        begin
          TickStart := GetTickCount;  // ��� ������� �������� �����
          Result := Trace(Iteration); // ������ ����

          if Result = -1 then // ���� ��� ������ ������� ������
            ReportString := '    *    '
          else
          begin  // ���� ���� ����� - ������� ������ (����������� ����� IP �����������)
            ReportString := Format('%6d ms', [GetTickCount - TickStart]);
            HostReply := True;  // � �� �������� ��������� ����, ��� ���� �������
            HostIP := Result;   // � ����� �������� ��� IP
          end;

          // ������������ ������...
          if I = 0 then
            ReportString := Format('%3d: %s', [Iteration, ReportString]);
            
          Synchronize(Log);
        end;

        if HostReply then // ���� ���� ������� ������ �� 1 ����
        begin
          // �������� ��������������� � ��������� ��� IP
          ReportString := GetDottetIP(HostIP);
          // �������� ��� �����
          HostName := GetNameFromIP(ReportString);
          // ����� ������ � ����������� �� ���� - �������� �� ��� �����
          if HostName <> RES_UNKNOWN then
            ReportString := HostName + '[' + ReportString + ']';
          ReportString := ReportString + #13#10;
        end
        else // ��� ������� "�������� �������� �������� ��� �������."
          ReportString := HOST_NOT_REPLY + #13#10;

        // ��������� �������� ��� �����������...
        ReportString := '  ' + ReportString;
        Synchronize(Log);
      end;

    finally
      IcmpCloseHandle(TraceHandle);
    end;

    // ��� � ���...
    // ������� �������������� ������ "����������� ���������."
    ReportString := STR_DONE;
    Synchronize(Log);
  finally
    WSACleanup;
  end;
end;

// ��������� �������� �� ����� ���������� � memShowTracert
procedure TTraceThread.Log;
begin
  frmTracert.memShowTracert.Text :=
    frmTracert.memShowTracert.Text + ReportString;
  SendMessage(frmTracert.memShowTracert.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

// ����������� ������� ����������
function TTraceThread.Trace(const Iteration: Byte): Longint;
var
  IP: IP_INFO;
  ECHO: ^ICMP_ECHO;
  Error: Integer;
begin
  GetMem(ECHO, SizeOf(ICMP_ECHO));
  try
    with IP do // ���������� ���������
    begin
      Ttl := Iteration; // ����� ������ ������ � ����������� -  ����������� ���������� TTL
      Tos := 0;
      IPFlags := 0;
      OptSize := 0;
      Options := nil;
    end;

    // ��������������� ������� ����������
    Error := IcmpSendEcho(TraceHandle,
                          DestAddr.S_addr,
                          nil,
                          0,
                          @IP,
                          ECHO,
                          SizeOf(ICMP_ECHO),
                          5000);
    // �������� �� ������
    if Error = 0 then
    begin
      Result := -1;
      Exit;
    end;

    // ���� ������ �� ���������� ����������� ����� IP ����� ����������� �����
    Result := ECHO.Source;

  finally
    FreeMem(ECHO);
  end;

end;

end.

