unit dnip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Winsock, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Bevel1: TBevel;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    Button3: TButton;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    Label7: TLabel;
    Bevel4: TBevel;
    Button4: TButton;
    Edit4: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Button5: TButton;
    Edit5: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Bevel5: TBevel;
    Timer1: TTimer;
    ListBox1: TListBox;
    Button6: TButton;
    Label12: TLabel;
    Label13: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label4DblClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Label6DblClick(Sender: TObject);
    procedure Label9DblClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Label11DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  stop_traf: boolean;
  count,trafbitin,trafbitout,trafbitold: integer;

implementation

{$R *.dfm}


function IPAddrToName(IPAddr: string): string;
var
 SockAddrIn: TSockAddrIn;
 HostEnt: PHostEnt;
 WSAData: TWSAData;
begin
 WSAStartup($101, WSAData);
 SockAddrIn.sin_addr.s_addr:=inet_addr(PChar(IPAddr));
 HostEnt:=GetHostByAddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
 if HostEnt<>nil
 then Result:=StrPas(Hostent^.h_name)
 else Result:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Label1.Caption:='Name: '+IPAddrToName(Edit1.Text);
end;


procedure TForm1.Button2Click(Sender: TObject);
var
 // Сохраняем оригинальное значение IP адреса
 OrgVal: string;
 // части оригинального IP
 O1,O2,O3,O4: string;
 // шестнадцатиричные части
 H1,H2,H3,H4: string;
 // Здесь будут собраны все шестнадцатиричные части
 HexIP: string;
 XN: array[1..8] of Extended;
 Flt1: Extended;
 Xc: Integer;
begin
 // Сохраняем в обратном порядке для простого случая
 Xn[8]:=IntPower(16,0);Xn[7]:=IntPower(16,1); Xn[6]:=IntPower(16,2);Xn[5]:=IntPower(16,3);
 Xn[4]:=IntPower(16,4);Xn[3]:=IntPower(16,5); Xn[2]:=IntPower(16,6);Xn[1]:=IntPower(16,7);
 // Сохраняем оригинальный IP адрес
 OrgVal:=Edit2.Text;
 O1:=Copy(OrgVal,1,Pos('.',OrgVal)-1);Delete(OrgVal,1,Pos('.',OrgVal));
 O2:=Copy(OrgVal,1,Pos('.',OrgVal)-1);Delete(OrgVal,1,Pos('.',OrgVal));
 O3:=Copy(OrgVal,1,Pos('.',OrgVal)-1);Delete(OrgVal,1,Pos('.',OrgVal));
 O4:=OrgVal;
 H1:=IntToHex(StrToInt(O1),2);H2:=IntToHex(StrToInt(O2),2);
 H3:=IntToHex(StrToInt(O3),2);H4:=IntToHex(StrToInt(O4),2);
 // Получаем шестнадцатиричное значение IP адреса
 HexIP:=H1+H2+H3+H4;
 // Преобразуем это большое шестнадцатиричное значение в переменную Float
 Flt1:=0;
 for Xc:=1 to 8 do
  begin
    case HexIP[Xc] of
     '0'..'9': Flt1:=Flt1+(StrToInt(HexIP[XC])*Xn[Xc]);
     'A': Flt1:=Flt1+(10*Xn[Xc]);
     'B': Flt1:=Flt1+(11*Xn[Xc]);
     'C': Flt1:=Flt1+(12*Xn[Xc]);
     'D': Flt1:=Flt1+(13*Xn[Xc]);
     'E': Flt1:=Flt1+(14*Xn[Xc]);
     'F': Flt1:=Flt1+(15*Xn[Xc]);
    end;
  end;
 Label4.Caption:='Number: '+FloatToStr(Flt1);
end;


procedure TForm1.Label4DblClick(Sender: TObject);
begin
 Edit2.Text:=Label4.Caption;
end;

procedure TForm1.Label1DblClick(Sender: TObject);
begin
 Edit1.Text:=Label1.Caption;
end;

const
  WINSOCK_VERSION=$0101;

procedure TForm1.Button3Click(Sender: TObject);
var
 WSAData: TWSAData;
 p: PHostEnt;
begin
 WSAStartup(WINSOCK_VERSION, WSAData);
 p:=GetHostByName(PChar(Edit3.Text));
 Label6.Caption:='IP: '+inet_ntoa(PInAddr(p.h_addr_list^)^);
 WSACleanup;
end;

// возвращает IP адрес
function LocalIP: string;
type
 TaPInAddr=array [0..10] of PInAddr;
 PaPInAddr=^TaPInAddr;
var
 phe:PHostEnt;
 pptr:PaPInAddr;
 Buffer:array [0..63] of char;
 i:Integer;
 GInitData:TWSADATA;
begin
 WSAStartup($101, GInitData);
 Result:='';
 GetHostName(Buffer, SizeOf(Buffer));
 phe:=GetHostByName(buffer);
 if phe=nil then Exit;
 pptr:=PaPInAddr(Phe^.h_addr_list);
 i:=0;
 while pptr^[i]<>nil do
  begin
   result:=StrPas(inet_ntoa(pptr^[i]^));
   Inc(i);
  end;
 WSACleanup;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Label7.Caption:='Local IP: '+LocalIP;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
 wsdata: TWSAData;
 hostName: array [0..255] of char;
 hostEnt: PHostEnt;
 addr: PChar;
begin
 WSAStartup ($0101, wsdata);
  try
   GetHostName(hostName, sizeof (hostName));
   StrPCopy(hostName,Edit4.Text);
   hostEnt:=GetHostByName(hostName);
   if Assigned(hostEnt)
   then
    if Assigned(hostEnt^.h_addr_list)
    then
     begin
      addr:=hostEnt^.h_addr_list^;
      if Assigned(addr)
      then
       begin
        Label9.Caption:=Format('%d.%d.%d.%d',[byte(addr[0]),
        byte(addr[1]),byte(addr[2]),byte(addr[3])]);
       end;
     end;
  finally
   WSACleanup;
  end;
end;

procedure TForm1.Label6DblClick(Sender: TObject);
begin
 Edit3.Text:=Label6.Caption;
end;

procedure TForm1.Label9DblClick(Sender: TObject);
begin
 Edit4.Text:=Label9.Caption;
end;

function IPAddrToCompName(IPAddr: string): string;
var
 SockAddrIn: TSockAddrIn;
 HostEnt: PHostEnt;
 WSAData: TWSAData;
begin
 WSAStartup($101, WSAData);
 SockAddrIn.sin_addr.s_addr:=inet_addr(PChar(IPAddr));
 HostEnt:=gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
 if HostEnt<>nil
 then Result:=StrPas(Hostent^.h_name)
 else Result:='';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 Label11.Caption:='Name: '+IPAddrToCompName(Edit5.Text);
end;

procedure TForm1.Label11DblClick(Sender: TObject);
begin
 Edit5.Text:=Label11.Caption;
end;

//////////////////////////////////// Трафик

type
 TMibIfRow = packed record
  wszName          : array[0..255] of WideChar;
  dwIndex          : DWORD;
  dwType           : DWORD;
  dwMtu            : DWORD;
  dwSpeed          : DWORD; // определяет текущую скорость передачи в битах в секунду
  dwPhysAddrLen    : DWORD;
  bPhysAddr        : array[0..7] of Byte; // содержит физический адрес интерфейса (если проще то его, немного видоизмененный, МАС адрес)
  dwAdminStatus    : DWORD;
  dwOperStatus     : DWORD;
  dwLastChange     : DWORD;
  dwInOctets       : DWORD; // содержит количество байт принятых через интерфейс
  dwInUcastPkts    : DWORD;
  dwInNUCastPkts   : DWORD;
  dwInDiscards     : DWORD;
  dwInErrors       : DWORD;
  dwInUnknownProtos: DWORD;
  dwOutOctets      : DWORD; // содержит количество байт отправленных интерфейсом
  dwOutUCastPkts   : DWORD;
  dwOutNUCastPkts  : DWORD;
  dwOutDiscards    : DWORD;
  dwOutErrors      : DWORD;
  dwOutQLen        : DWORD;
  dwDescrLen       : DWORD;
  bDescr           : array[0..255] of Char; // cодержит описание интерфейса
 end;
 TMibIfArray = array [0..512] of TMibIfRow;
 PMibIfRow = ^TMibIfRow;
 PMibIfArray = ^TMibIfArray;

type
 TMibIfTable = packed record
   dwNumEntries: DWORD;
   Table       : TMibIfArray;
 end;
 PMibIfTable = ^TMibIfTable;

var
 GetIfTable:function(pIfTable: PMibIfTable; pdwSize: PULONG;
                              bOrder: Boolean): DWORD; stdcall;

//////////////////////////////////// Интерфейсы

function WSAIoctl(s: TSocket; cmd: DWORD; lpInBuffer: PCHAR; dwInBufferLen:
 DWORD;
 lpOutBuffer: PCHAR; dwOutBufferLen: DWORD;
 lpdwOutBytesReturned: LPDWORD;
 lpOverLapped: POINTER;
 lpOverLappedRoutine: POINTER): integer; stdcall; external 'WS2_32.DLL';

const
 SIO_GET_INTERFACE_LIST = $4004747F;
 IFF_UP = $00000001;
 IFF_BROADCAST = $00000002;
 IFF_LOOPBACK = $00000004;
 IFF_POINTTOPOINT = $00000008;
 IFF_MULTICAST = $00000010;

type
 sockaddr_gen = packed record
  AddressIn: sockaddr_in;
  filler: packed array [0..7] of char;
end;

type
 INTERFACE_INFO = packed record
  iiFlags: u_long; // Флаги интерфейса
  iiAddress: sockaddr_gen; // Адрес интерфейса
  iiBroadcastAddress: sockaddr_gen; // Broadcast адрес
  iiNetmask: sockaddr_gen; // Маска подсети
end;

function EnumInterfaces(var sInt: string): Boolean;
var
 s: TSocket;
 wsaD: WSADATA;
 NumInterfaces: Integer;
 BytesReturned: u_long;
 pAddrInet: SOCKADDR_IN;
 pAddrString: PChar;
 PtrA: pointer;
 Buffer: array[0..20] of INTERFACE_INFO;
 i: integer;
begin
 result:=true; // инициализируем переменную
 sInt:='';
 WSAStartup($0101, wsaD); // запускаем WinSock
 // здесь можно дабавить различные обработчики ошибки
 s:=Socket(AF_INET, SOCK_STREAM, 0); // открываем сокет
 if (s=INVALID_SOCKET)
 then Exit;
 try // вызываем WSAIoCtl
  PtrA:=@bytesReturned;
  if (WSAIoCtl(s, SIO_GET_INTERFACE_LIST, nil, 0, @Buffer,
                          1024, PtrA, nil, nil)<>SOCKET_ERROR)
  then
   begin // если OK, то определяем количество существующих интерфейсов
     NumInterfaces:=BytesReturned div SizeOf(INTERFACE_INFO);
     for i:=0 to NumInterfaces-1 do // для каждого интерфейса
      begin
       pAddrInet:=Buffer[i].iiAddress.AddressIn; // IP адрес
       pAddrString:=inet_ntoa(pAddrInet.sin_addr);
       if pAddrString<>'127.0.0.1'
       then
        begin
         sInt:=sInt+'IP = '+pAddrString+', '+#10#13;
         // pAddrInet:=Buffer[i].iiNetMask.AddressIn; // маска подсети
         // pAddrString:=inet_ntoa(pAddrInet.sin_addr);
         // sInt:=sInt+' Mask='+pAddrString+',';
        end
       else sInt:='IP = "localhost"';
      end;
  end;
 except
  //
 end;
 // закрываем сокеты
 CloseSocket(s);
 WSACleanUp;
 result:=false;
end;

function BytesToString(Value: integer): string;
const
 OneKB=1024;
 OneMB=OneKB*1024;
 OneGB=OneMB*1024;
begin
 if Value<OneKB
 then Result:=FormatFloat('#,##0.00 B',Value)
 else
  if Value<OneMB
  then Result:=FormatFloat('#,##0.00 KB', Value/OneKB)
  else
   if Value<OneGB
   then Result:=FormatFloat('#,##0.00 MB', Value/OneMB)
end;

procedure TForm1.Timer1Timer(Sender: TObject);
 // вспомогательная функция, преобразующая МАС адрес к
 // "нормальному" виду определяем специальный тип, чтобы
 // можно было передать в функцию массив
type
 TMAC=array [0..7] of Byte;
 // в качестве первого значения массив, второе значение,
 // размер данных в массиве
function GetMAC(Value: TMAC; Length: DWORD): string;
var
 i: integer;
begin
 if Length=0
 then Result:='00-00-00-00-00-00'
 else
  begin
   Result:='';
   for i:=0 to Length-2 do
    Result:=Result+IntToHex(Value[i],2)+'-';
    Result:=Result+IntToHex(Value[Length-1],2);
   end;
end;

var
 FLibHandle: THandle;
 Table: TMibIfTable;
 i, Size: integer;
 s,trafnormin,trafnormout: string;
begin
 Timer1.Enabled:=false; // приостанавливаем на всякий случай таймер
 ListBox1.Items.BeginUpdate;
 ListBox1.Items.Clear; // очищаем список
 FLibHandle:=LoadLibrary('IPHLPAPI.DLL'); // загружаем библиотеку
 if FLibHandle=0
 then Exit;
 @GetIfTable:=GetProcAddress(FLibHandle, 'GetIfTable');
 if not Assigned(GetIfTable)
 then
  begin
   FreeLibrary(FLibHandle);
   Close;
  end;
 //
 Size:=SizeOf(Table);
 if GetIfTable(@Table,@Size,false)=0
 then // выполняем функцию
  for i:=0 to Table.dwNumEntries-1 do // кол-во сетевых карт
   begin
    with ListBox1.Items do
     begin // выводим результаты
      // if string(GetMAC(TMAC(Table.Table[i].bPhysAddr),Table.Table[i].dwPhysAddrLen))<>'00-00-00-00-00-00' // сравнение MAC адресов
      // then
       begin
        Add('Description: '+string(Table.Table[i].bDescr)); // наименование интерфейса
        Add('MAC-adress: '+string(GetMAC(TMAC(Table.Table[i].bPhysAddr),Table.Table[i].dwPhysAddrLen))); // МАС адрес
        // перевод к нормальным единицам "Входящего" трафика
        trafbitin:=Table.Table[i].dwInOctets; // всего принято байт
        trafnormin:=BytesToString(trafbitin);
        // перевод к нормальным единицам "Исходящего" трафика
        trafbitout:=Table.Table[i].dwOutOctets; // всего отправлено байт
        trafnormout:=BytesToString(trafbitout);
        ////////////////////////////////////// сброс трафика
        if stop_traf=true
        then
         begin
          trafbitold:=trafbitin;
          trafnormin:='0,00 B';
          trafnormout:='0,00 B';
         end;
        //
        if trafbitin>=trafbitold // новый трафик больше старого
        then
         begin
          trafbitin:=trafbitin-trafbitold;
          trafnormin:=BytesToString(trafbitin);
         end
        else  // новый трафик меньше старого
         begin
          trafbitin:=trafbitold;
          trafnormin:=BytesToString(trafbitin);
         end;
        /////////////////////////////////////
        Add('In (Byte): '+trafnormin); // всего принято байт
        Add('Out (Byte): '+trafnormout); // всего отправлено байт
        Add('-------------------------------------------------'); //
       end;
     end;
   end;
 //
 EnumInterfaces(s);
 ListBox1.Items.Add(s);
 //
 ListBox1.Items.EndUpdate;
 FreeLibrary(FLibHandle);
 Timer1.Enabled:=true; // не забываем активировать таймер
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 if stop_traf=false then stop_traf:=true
 else stop_traf:=false;
end;

end.
