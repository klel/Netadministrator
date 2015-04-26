unit GetWebFile;

interface

uses
  Windows, WinInet;

function GetInetFile(FileURL : String) : String;

implementation

function GetInetFile(FileURL : String) : String;
const
  BufferSize = 1024;
var
  hSession : hInternet;
  hURL     : hInternet;
  BufLen   : DWORD;
  Buffer   : Array [0..1023] of Char;
begin
   Result := '';
   hSession := InternetOpen(PChar('Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)'), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
   try
     hURL := InternetOpenURL(hSession,
     PChar(FileURL),nil,0,0,0);
     try
       FillChar(Buffer, SizeOf(Buffer), 0);
       repeat
         Result := Result + Buffer;
         FillChar(Buffer, SizeOf(Buffer), 0);
         InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufLen);
       until
         BufLen = 0;
     finally
       InternetCloseHandle(hURL)
     end
   finally
     InternetCloseHandle(hSession)
   end;
end;

end.