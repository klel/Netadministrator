// ���������������� ��������� ��������� ���������� � ����������
// �� ������ IP ������
// �����: ��������� (Rouse_) ������
// 30 ������� 2004
// =============================================================

unit uMain;

{$DEFINE RUS}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, CommCtrl, Winsock;

const
  {$IFDEF RUS}
    RES_UNKNOWN = '����������';
    RES_IP      = 'IP �����: ';
    RES_CMP     = '��� ����������: ';
    RES_USR     = '��� ������������: ';
    RES_DOM     = '�����: ';
    RES_SER     = '������ ������: ';
    RES_COM     = '����������: ';
    RES_PROV    = '���������: ';
    RES_GRP     = '������: ';
    RES_MAC     = 'MAC ������: ';
    RES_SHARES  = '��������� �������: ';
    RES_TIME    = '������� ���������: ';
    RES_COM_NO  = '�����������';
  {$ELSE}
    RES_UNKNOWN = 'Unknown';
    RES_IP      = 'IP adress: ';
    RES_CMP     = 'Computer name: ';
    RES_USR     = 'User name: ';
    RES_DOM     = 'Domen: ';
    RES_SER     = 'Domen server: ';
    RES_COM     = 'Comment: ';
    RES_PROV    = 'Provider: ';
    RES_GRP     = 'Groups: ';
    RES_MAC     = 'MAC adress: ';
    RES_SHARES  = 'Available shares: ';
    RES_TIME    = 'Expended time: ';
    RES_COM_NO  = 'Absent';
  {$ENDIF}

  WSA_TYPE = $101; //$202;

  // ��� ������ � ARP (Address Resolution Protocol) ��������
  IPHLPAPI = 'IPHLPAPI.DLL';
  MAX_ADAPTER_ADDRESS_LENGTH = 7;

type

  LMSTR = LPWSTR;
  NET_API_STATUS = DWORD;

  // ��������� ��� ���� ������������ ��� ������ � Iphlpapi.dll
  // ������ �� Iphlpapi.h

  // ��� ����� ��������� ���
  TMacAddress = array[0..MAX_ADAPTER_ADDRESS_LENGTH] of byte;

  // ��� ��������� ��� ���������� �������
  TMibIPNetRow = packed record
    dwIndex         : DWORD;
    dwPhysAddrLen   : DWORD;
    bPhysAddr       : TMACAddress;  // ��� ����� � ����� ���!!!
    dwAddr          : DWORD;
    dwType          : DWORD;
  end;
  
  // ��� � � ������ �� ����� �������� ������ �����������,
  // � ����� �������� ������... (����, ����� ������, ��� �� ���������,
  // �� � ��� ������� ����� :)
  TMibIPNetRowArray = array [0..512] of TMibIPNetRow;

  // � ���, ��� � �� ���� ����������, ����� ���...
  // ������������� ��������� (� ���� ������ ��� ����� ������...)
  PTMibIPNetTable = ^TMibIPNetTable;
  TMibIPNetTable = packed record
    dwNumEntries    : DWORD;
    Table: TMibIPNetRowArray;
  end;

  // ��������� ��� ������������ ������������ �������������
  _WKSTA_USER_INFO_1 = record
    wkui1_username: LPWSTR;
    wkui1_logon_domain: LPWSTR;
    wkui1_oth_domains: LPWSTR;
    wkui1_logon_server: LPWSTR;
  end;
  WKSTA_USER_INFO_1 = _WKSTA_USER_INFO_1;
  PWKSTA_USER_INFO_1 = ^_WKSTA_USER_INFO_1;
  LPWKSTA_USER_INFO_1 = ^_WKSTA_USER_INFO_1;

  // ��������� ��� ����������� �������������� ������������ � �������
  PGroupUsersInfo0 = ^_GROUP_USERS_INFO_0;
  _GROUP_USERS_INFO_0 = packed record
    grui0_name: LPWSTR;
  end;
  TGroupUsersInfo0 = _GROUP_USERS_INFO_0;
  GROUP_USERS_INFO_0 = _GROUP_USERS_INFO_0;

  // ��������� ��� ����������� ��������� ������� ��������
  PSHARE_INFO_1 = ^SHARE_INFO_1;
  _SHARE_INFO_1 = record
    shi1_netname: LMSTR;
    shi1_type: DWORD;
    shi1_remark: LMSTR;
  end;
  SHARE_INFO_1 = _SHARE_INFO_1;
  TShareInfo1 = SHARE_INFO_1;
  PShareInfo1 = PSHARE_INFO_1;

  TMainForm = class(TForm)
    btnGetInfo: TButton;
    memInfo: TMemo;
    Label1: TLabel;
    procedure btnGetInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    IP, Font: Integer;  // ��� ���������� ��� ������ �
    edIP: HWND;         // WC_IPADDRESS �������
    function GetNameFromIP(const IP: String): String;
    function GetUsers(const CompName: String): String;
    function GetDomain(const CompName, Provider: String): String;
    function GetComment(CompName, Provider: String): String;
    function GetProvider(const CompName: String): String;
    function GetMacFromIP(const IP: String): String;
    function GetDomainServer(const DomainName: String): String;
    function GetGroups(DomainServer: String; UserName: String): String;
    function GetShares(const CompName: String): String;
  end;

  // ������� �������, ��� ��� �� ���������� ��� � ������.
  // ����� ���� ����������� �������� ���������, ������ ������,
  // ��� ������ ������� ���� �� ���� ��������, ������� � W95...

  {$EXTERNALSYM WNetGetResourceInformation}
  function WNetGetResourceInformation(lpNetResource: PNetResource;
    lpBuffer: Pointer; var lpcbBuffer: DWORD; lplpSystem: Pointer): DWORD; stdcall;
  {$EXTERNALSYM GetIpNetTable}
  function GetIpNetTable(pIpNetTable: PTMibIPNetTable;
    pdwSize: PULONG; bOrder: Boolean): DWORD; stdcall;

  function WNetGetResourceInformation; external mpr name 'WNetGetResourceInformationA';
  function GetIpNetTable; external IPHLPAPI name 'GetIpNetTable';

  function NetGetAnyDCName(servername: LPCWSTR;  domainname: LPCWSTR;
    bufptr: Pointer): Cardinal;
    stdcall; external 'netapi32.dll';

  function NetShareEnum(servername: LMSTR; level: DWORD; var bufptr: Pointer;
    prefmaxlen: DWORD; entriesread, totalentries,
    resume_handle: LPDWORD): NET_API_STATUS; stdcall; external 'Netapi32.dll';

  function NetApiBufferFree(buffer: Pointer): Cardinal;
    stdcall; external 'netapi32.dll';

  function NetWkstaUserEnum(ServerName: LPCWSTR;
                          Level: DWORD;
                          BufPtr: Pointer;
                          PrefMaxLen: DWORD;
                          EntriesRead: LPDWORD;
                          TotalEntries: LPDWORD;
                          ResumeHandle: LPDWORD): LongInt; stdcall; external 'netapi32.dll';

  function NetUserGetGroups(ServerName: LPCWSTR;
                          UserName: LPCWSTR;
                          level: DWORD;
                          bufptr: Pointer;
                          prefmaxlen: DWORD;
                          var entriesread: DWORD;
                          var totalentries: DWORD): LongInt; stdcall; external 'netapi32.dll';

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// ��� ����� IP ������ ����� ������������ ����� WC_IPADDRESS
// ������ ��� ����� � ��������������...
procedure TMainForm.FormCreate(Sender: TObject);
begin
  // ������� �������������� IP ����� (��� ����� ���� ������)
  IP := MAKEIPADDRESS(192, 168, 2, 108);
  // �������������� �������������� ������ ���������� ComCtl32.dll.
  InitCommonControl(ICC_INTERNET_CLASSES);
  // �������� ���� ������ (������� ��� ����� gbIP)
  edIP:= CreateWindow(WC_IPADDRESS, nil, WS_CHILD or WS_VISIBLE,
    6, 16, MainForm.Width-22, 21, MainForm.Handle, 0, hInstance, nil);
  // ������ ��� ����� IP ����������
  SendMessage(edIP, IPM_SETADDRESS, 0, IP);
  // �������� ������ ������� ��� ����...
  Font := CreateFont(-11, 0, 0, 0, 400, 0, 0, 0, DEFAULT_CHARSET,
    OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
    DEFAULT_PITCH or FF_DONTCARE, 'MS Sans Serif');
  // � ������, ���� �� ��� � ���� ������� (� �� ������ �� ����������...)
  SendMessage(edIP, WM_SETFONT, Font, 0);
end;

// �� ��� ������ �������...
procedure TMainForm.btnGetInfoClick(Sender: TObject);
var
  TmpCompName, TmpProvider, TmpGroup, TmpUser, TmpServer: String;
  Time: Cardinal;
  IPStr: String;
begin
  Time := GetTickCount;  // ������� �����...

  // ������, ��� �� ����� ������... (�� �������� � IP)
  SendMessage(edIP, IPM_GETADDRESS, 0, Longint(PDWORD(@IP)));
  
  // ����������� ��� ����������� � ���������� "Dotted IP"
  IPStr := IntToStr(FIRST_IPADDRESS(IP));
  IPStr := IPStr + '.' + IntToStr(SECOND_IPADDRESS(IP));
  IPStr := IPStr + '.' + IntToStr(THIRD_IPADDRESS(IP));
  IPStr := IPStr + '.' + IntToStr(FOURTH_IPADDRESS(IP));

  // �� � ������ ��������...
  with memInfo, memInfo.Lines do                        // ����� ����������
  begin
    Clear;                                              // ������� �����
    Refresh;                                            // �� � ���������...
                                                        // (��� ������ ������ ������� ����� �� ����������)

    Add(RES_IP + IPStr);                                // ������� IP �����
    TmpCompName := GetNameFromIP(IPStr);
    if TmpCompName = RES_UNKNOWN then Exit;
    Add(RES_CMP + TmpCompName);                         // ������� ��� ����������
    TmpUser := GetUsers(IPStr);
    Add(RES_USR + TmpUser);                             // ������� ��� ������������
    TmpProvider := GetProvider(TmpCompName);
    Add(RES_PROV + TmpProvider);                        // ������� ����������
    Add(RES_COM + GetComment(TmpCompName,
      TmpProvider));                                    // ������� ����������� � �������
    TmpGroup := GetDomain(TmpCompName, TmpProvider);
    Add(RES_DOM + TmpGroup);                            // ������� ������
    TmpServer := GetDomainServer(TmpGroup);
    if TmpServer <> '' then
    begin
      Add(RES_SER + TmpServer);                         // ������� ��� �������
      Add(RES_GRP + GetGroups(TmpServer, TmpUser));     // ������� ������ ������ � ������� ������ ������������
    end;
    Add(RES_SHARES + GetShares(TmpCompName));           // ������� ������ ��������� ��������
    Add(RES_MAC + GetMacFromIP(IPStr));                 // ������� ��� �����
    Add(RES_TIME + IntToStr(GetTickCount - Time));      // ������� ������� ���������
  end;
end;

// �������� ���������� ��������� ������ ������� ��������� �������.
// ������: ��� ���������� ���������� � �������� IP ��������� �����
// ������� ���������� gethostbyaddr � �� ��� ����� ���������.
function TMainForm.GetNameFromIP(const IP: String): String;
var
  WSA: TWSAData;
  Host: PHostEnt;
  Addr: Integer;
  Err: Integer;
begin
  Result := RES_UNKNOWN;
  Err := WSAStartup(WSA_TYPE, WSA);
  if Err <> 0 then  // ����� ������������ ����� ������������,
  begin             // ����� � ������ ������ ����� ���� ������� �� ���.
    ShowMessage(SysErrorMessage(GetLastError));
    Exit;
  end;
  try
    Addr := inet_addr(PChar(IP));
    if Addr = INADDR_NONE then
    begin
      ShowMessage(SysErrorMessage(GetLastError));
      WSACleanup;
      Exit;
    end;
    Host := gethostbyaddr(@Addr, SizeOf(Addr), PF_INET);
    if Assigned(Host) then  // ������������ ��������, � ��������� ������, ���
      Result := Host.h_name // ���������� ���������� � ������� IP, ������� AV
    else
      ShowMessage(SysErrorMessage(GetLastError));
  finally
    WSACleanup;
  end;
end;

// ����������� ���� ������������ �� ������ �������������
// �������� ������������ �� ������� ������������, ��������
// ������ ����� "��� ����������"$
function TMainForm.GetUsers(const CompName: String): String;
var
  Buffer, tmpBuffer: Pointer;
  PrefMaxLen       : DWORD;
  Resume_Handle    : DWORD;
  EntriesRead      : DWORD;
  TotalEntries     : DWORD;
  I, Size          : Integer;
  PSrvr            : PWideChar;
begin
  PSrvr := nil;
  try
    // ��������� ��� ���������� ���� PWideChar
    Size := Length(CompName);
    GetMem(PSrvr, Size * SizeOf(WideChar) + 1);
    StringToWideChar(CompName, PSrvr, Size + 1);

    PrefMaxLen := DWORD(-1);
    EntriesRead := 0;
    TotalEntries := 0;
    Resume_Handle := 0;
    Buffer := nil;

    // �������� ������ ������������� �� ���������� �� PSrvr
    if NetWkstaUserEnum( PSrvr, 1, @Buffer, PrefMaxLen, @EntriesRead,
      @TotalEntries, @Resume_Handle) = S_OK then
    begin
      tmpBuffer := Pointer(DWORD(Buffer) + SizeOf(WKSTA_USER_INFO_1));
      for I := 1 to TotalEntries - 1 do
      begin
        Result := Result + WKSTA_USER_INFO_1(tmpBuffer^).wkui1_username + ', ';
        tmpBuffer := Pointer(DWORD(tmpBuffer) + SizeOf(WKSTA_USER_INFO_1));
      end;
      Result := Copy(Result, 1, Length(Result) - 2);
  end
  else
    ShowMessage(SysErrorMessage(GetLastError));
  finally
    NetApiBufferFree(Buffer);
    FreeMem(PSrvr);
  end;
end;

// ���-���� ����� ����������� ����, ��!!!
// �� �� ����� ����������� ����������� ������������ �������� �
// dwDisplayType ������ RESOURCEDISPLAYTYPE_SERVER!!!
// � �������� ��� ���������� ����������� ������ �����,
// ��� ��� ��� ������� �������� ��� ����������� ���������
// ��� �����������. ���� ��������� �������� ��� ��� ����� �����������
// � ���� � ��� ������� ������������ ������� �������� ��� �������.
// � ��������, � ���� ��� ������� �������� �������� ���������� �� ��������...
// (����� 31 �� - �������� � ������������ �� memInfo, ���� 100��, 28 ������)

function TMainForm.GetComment(CompName, Provider: String): String;
var
  StopScan: Boolean;
  TmpRes: TNetResource;

  // ���� ������������
  procedure Scan(Res: TNetResource; Root: boolean);
  var
    Enum, I: Cardinal;
    ScanRes: array [0..512] of TNetResource; // ����� ������� � ������� ������ �������
    Size, Entries, Err: DWORD;               // ��, ��� ���������� ��������, ������ ����������
  begin
  
    if StopScan then Exit; // ���������� ���� ��� ������ �� ��������

    // �� ��� ����� ��� �������... ������ ��� ���� ������ ������������
    if Root = True then
      Err := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_DISK,
        0, nil, Enum) // ��������...
    else
      Err := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_DISK,
        0, @Res, Enum); // � ������������ ��� ������ ��������...

    if Err = NO_ERROR then
    begin
      Size := SizeOf(ScanRes);
      Entries := DWORD(-1);
      Err := WNetEnumResource(Enum, Entries, @ScanRes, Size);
      if Err = NO_ERROR then
      try
        for I := 0 to Entries - 1 do
        begin
          if StopScan then Exit; // ��� ���� ����, ��� ��� ����� �� ������� �����
          with ScanRes[i] do     // ����� ������������� �� �����
          begin
            if dwDisplayType = RESOURCEDISPLAYTYPE_SERVER then
              if lpRemoteName = CompName then // ���� ����� ��� ���������...
              begin
                Result :=  lpComment;     // ����������� �����������
                StopScan := True;         // � ���������� ���� ��� ������ �� ��������
                Exit;
              end;
            if dwDisplayType <> RESOURCEDISPLAYTYPE_SERVER then  // �� ����� ����������� ���� � ������...
              Scan(ScanRes[i], False);
          end;
        end;
      finally
        WNetCloseEnum(Enum);
      end
      else
        if Err <> ERROR_NO_MORE_ITEMS then  // ��� ��������� ��� �����������...
          MessageDlg(SysErrorMessage(GetLastError), mtError, [mbOK], 0);
    end
    else
      ShowMessage(SysErrorMessage(GetLastError));
  end;

// �������� ���������
begin

  // ���������������� ��������...
  Result := RES_UNKNOWN;

  if CompName = RES_UNKNOWN then Exit;    // ���� ��� ����� �� �������,
                                          // ������� � ����������.

  CompName := '\\' + CompName;            // ��������� ���,
                                          // ���� �� ������ ��� ����� � �����...

  StopScan := False;    // ������ ���� ������ �� ��������.
                        // ����� ����������� ����������������� ����������
                        // ���� Boolean, ��� ��� ���� ��������, ���
                        // ��������� ������ ������ ����� ��������������
                        // �������� �� ���������, ����� ���� ����������
                        // ��������� ���� AND - OR - NOT ��������� ��������.
                        // ��������: �� ��������� ���������� StopScan ����� False
                        // ��� �������������, ����� StopScan := not StopScan;
                        // ���������� StopScan �� ������ ������ True!!!

  // ��������� ������������...
  // (����� � � ������, �� � ���� ����� �� ������������ ������ 8 ��.)
  Scan(TmpRes, True);

  // � ������� ����������...
  if Result = '' then Result := RES_COM_NO;
end;

// ������ ���� ������� ��������� ������:
// ��� ��������� ����� ���������� �� ����� ��������� ���������
// � �������� �� ������� WNetGetResourceParent ������� � ������
// ��� ������, � ���� ������ ������.
// ��, ���� �� �����, ���� ��� ���������� ���� � ����, � ���
// ��������� ��������, �� � �������� ���������� ����� ����
// ������ ������ ���� '��� ������'...
// ������� ����� �������� �����������, ���� ������� �� ��������...
function TMainForm.GetDomain(const CompName, Provider: String): String;
var
  CurrRes: TNetResource;
  ParentName: array [0..1] of TNetResource;
  Enum: DWORD;
  Err: Integer;
begin
  with CurrRes do
  begin
    dwScope := RESOURCE_GLOBALNET;
    dwType := RESOURCETYPE_DISK;
    dwDisplayType := RESOURCEDISPLAYTYPE_SERVER;
    dwUsage := RESOURCEUSAGE_CONTAINER;
    lpLocalName := '';
    lpRemoteName := PChar('\\' + CompName);
    lpComment := '';
    lpProvider := PChar(Provider);
  end;
  Enum := SizeOf(ParentName);
  Err := WNetGetResourceParent(@CurrRes, @ParentName, Enum);
  if Err = NO_ERROR then
  begin
    Result := ParentName[0].lpRemoteName;
    if Result = '' then Result := RES_COM_NO;
  end
  else
    ShowMessage(SysErrorMessage(GetLastError));
end;

// � ���� �������� �� ����� ������ ����������
// (� �������� ��� Microsoft Network).
function TMainForm.GetProvider(const CompName: String): String;
var
  Buffer: array [0..255] of Char;
  Size: DWORD;
begin
  Size := SizeOf(Buffer);
  if WNetGetProviderName(WNNC_NET_LANMAN, @Buffer, Size) <> NO_ERROR then
    Result := RES_COM_NO
  else
    Result := String(Buffer);
end;

// �� ���� ����������� ������� ��� ����� ����������.
// � ����� ��� ������� � ������������� ���������� �������������
// � IPHLPAPI.DLL. ������ ������ ������������ ���. �� ���� �������
// ����� �������� � ��������� ��� ������ ����������� ������� IPX ������
// � ������� ��������� ������ �� ���������� ����������
// (��� ���� �� ���� �������, ���� �� ��������� �� ��������,
// ��� IPX ��� ����������� �����, � ��� ���� ��� ���������).
// ����� �� �������� ������ ARP �������, �� ��������� ������� ��
// ����� �������� ���������� ������� �� ������� IP ������,
// � ��� ��� ��� ������� �� ����, �� �� ������ ������ ��� ������
// ���� ����������� �����������... 
// ������������ �����: � ������� (�� ������) ���������� ����������
// �� ���������� ����������, �.�. ����� ������� ����� ��������
// ��� ��� ������ �� ����������� ������,
// �� ��� ����� ���� ��� ������ �������...

// ������� �������� �� MSDN:
// You can use IP Helper to perform Address Resolution Protocol (ARP) operations for the local computer. 
// Use the following functions to retrieve and modify the ARP table.
// The GetIpNetTable retrieves the ARP table. 
// The ARP table contains the mapping of IP addresses to physical addresses. 
// Physical addresses are sometimes referred to as Media Access Controller (MAC) addresses. 

// ���� �������� ��� ��� NT ���� ����� ���������� ������� SendARP - �����������
// �������� �������� ��������� ��� ��� ���������� �������, ������� �������
// �������������� ��� ��������� ��� ����� ������������ ���������� �������� ���� 
// ��� ���������� ���������.

function TMainForm.GetMacFromIP(const IP: String): String;

  // (����� ������������ ������� ���������� �� ������)
  // � �������� ������� �������� ������, ������ ��������,
  // ������ ������ � �������
  function GetMAC(Value: TMacAddress; Length: DWORD): String;
  var
    I: Integer;
  begin
    if Length = 0 then Result := '00-00-00-00-00-00' else
    begin
      Result := '';
      for i:= 0 to Length -2 do
        Result := Result + IntToHex(Value[i], 2) + '-';
      Result := Result + IntToHex(Value[Length-1], 2);
    end;
  end;

  // �������� IP �����, ������ � ������� �� ������ � ������� WC_IPADDRESS
  // ����� �������������� ���� � �������� �������!
  function GetDottedIPFromInAddr(const InAddr: Integer): String;
  begin
    Result := '';
    Result := IntToStr(FOURTH_IPADDRESS(InAddr));
    Result := Result + '.' + IntToStr(THIRD_IPADDRESS(InAddr));
    Result := Result + '.' + IntToStr(SECOND_IPADDRESS(InAddr));
    Result := Result + '.' + IntToStr(FIRST_IPADDRESS(InAddr));
  end;

  // �������� �������
var
  Table: TMibIPNetTable;
  Size: Integer;
  CatchIP: String;
  Err, I: Integer;
begin
  Result := RES_UNKNOWN;
  Size := SizeOf(Table);                      // �� ��� ��� ������...
  Err := GetIpNetTable(@Table, @Size, False); // ���������...
  if Err <> NO_ERROR then                     // �������� �� ������...
  begin
    ShowMessage(SysErrorMessage(GetLastError));
    Exit;
  end;
  // ������ �� ����� ������� �� IP ������� � �������������� �� MAC �������
  for I := 0 to Table.dwNumEntries - 1 do     // ���� ������ IP ...
  begin
    CatchIP := GetDottedIPFromInAddr(Table.Table[I].dwAddr);
    if CatchIP = IP then                      // � ������� ��� ��� ...
    begin
      Result := GetMAC(Table.Table[I].bPhysAddr, Table.Table[I].dwPhysAddrLen);
      Break;
    end;
  end;
end;

// ��������� ��������� ������� �������� �� ��������� ����������
function TMainForm.GetShares(const CompName: String): String;
type TShareInfo1Array = array of TShareInfo1;
var
  entriesread, totalentries: DWORD;
  Info: Pointer;
  I: Integer;
  CN: PWideChar;
begin
  CN := StringToOleStr(CompName);
  // ��� ��� ��� ����� ������ ����� ��������, ������������� ��������� TShareInfo1
  // �����, �� ����� ����� �������� ���������� �������������� �� ��������� ������ :)
  if NetShareEnum(CN, 1, Info, DWORD(-1), @entriesread,
    @totalentries, nil) = 0 then
    try // ������ �������� ������� �����
      if entriesread > 0 then
        for I := 0 to entriesread - 1 do
          Result := Result + TShareInfo1Array(@(Info^))[I].shi1_netname + ' ';
    finally
      NetApiBufferFree(Info);
    end;
end;

// ��� ����� ������� ����� ����� �������� ��� ������� ������
function TMainForm.GetDomainServer(const DomainName: String): String;
var
  Domain: PWideChar;
  Server: PWideChar;
begin
  GetMem(Domain, MAX_PATH);
  try
    StringToWideChar(DomainName, Domain, MAX_PATH);
    if NetGetAnyDCName(nil, Domain, @Server)= NO_ERROR then
    try
      Result := WideCharToString(Server);
	  finally
      NetApiBufferFree(Server);
  	end;
  finally
    FreeMem(Domain, MAX_PATH);
  end;
end;

// ������������ �������� ����� � ������� ������ ������������
function TMainForm.GetGroups(DomainServer: String; UserName: String): String;
type
  TGroupUsersInfoArray = array of TGroupUsersInfo0;
var
  Info: PGroupUsersInfo0;
  Sn, Un: PWideChar;
  entriesread, totalentries: DWORD;
  I, A, B, Size: Integer;
  P: Pointer;
begin
  // ��� ����� ������ ��� ������� ������
  Sn := StringToOLEStr(DomainServer);
  // � ��� ������������
  Un := StringToOleStr(UserName);
  // ������ ������
  if NetUserGetGroups(Sn, Un, 0, @Info, DWORD(-1), entriesread, totalentries) = NO_ERROR  then
  try // � �������, ��� ��� � ��� ����������
    if entriesread > 0 then
      for I := 0 to entriesread - 1 do
        Result := Result + TGroupUsersInfoArray(@(Info^))[I].grui0_name + ' ';
  finally
    NetApiBufferFree(Info);
  end;
end;

end.

