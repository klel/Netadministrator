type
  // Структуры для выполнения функции GetAdaptersInfo
  time_t = Longint;
  IP_ADDRESS_STRING = record
    S : Array [0..15] of Char;
  end;
  IP_MASK_STRING  = IP_ADDRESS_STRING;
  PIP_MASK_STRING = ^IP_MASK_STRING;
  PIP_ADDR_STRING = ^IP_ADDR_STRING;
  IP_ADDR_STRING = record
    Next      : PIP_ADDR_STRING;
    IpAddress : IP_ADDRESS_STRING;
    IpMask    : IP_MASK_STRING;
    Context   : DWORD;
  end;
  PIP_ADAPTER_INFO = ^IP_ADAPTER_INFO;
  IP_ADAPTER_INFO = record
    Next                : PIP_ADAPTER_INFO;
    ComboIndex          : DWORD;
    AdapterName         : Array [0..MAX_ADAPTER_NAME_LENGTH + 3] of Char;
    Description         : Array [0..MAX_ADAPTER_DESCRIPTION_LENGTH + 3] of Char;
    AddressLength       : UINT;
    Address             : Array [0..MAX_ADAPTER_ADDRESS_LENGTH - 1] of Byte;
    Index               : DWORD;
    Type_               : UINT;
    DhcpEnabled         : UINT;
    CurrentIpAddress    : PIP_ADDR_STRING;
    IpAddressList       : IP_ADDR_STRING;
    GatewayList         : IP_ADDR_STRING;
    DhcpServer          : IP_ADDR_STRING;
    HaveWins            : BOOL;
    PrimaryWinsServer   : IP_ADDR_STRING;
    SecondaryWinsServer : IP_ADDR_STRING;
    LeaseObtained       : time_t;
    LeaseExpires        : time_t;
  end;

// Функция необходима для получения информации со всех сетевых интерфейсов
function GetAdaptersInfo(const pAdapterInfo : PIP_ADAPTER_INFO; var pOutBufLen : ULONG) : DWORD; stdcall; external 'iphlpapi.dll';

// Структуры для создания меню со значками
type
  TMenuItem = record
    text : String;
    icon : hIcon;
  end;