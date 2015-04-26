unit GetVerFile;

interface

uses
  Windows, MSysUtils;

const
  sfiCompanyName       = 'CompanyName';
  sfiFileDescription   = 'FileDescription';
  sfiFileVersion       = 'FileVersion';
  sfiInternalName      = 'InternalName';
  sfiLegalCopyright    = 'LegalCopyright';
  sfiLegalTrademark    = 'LegalTrademark';
  sfiOriginalFileName  = 'OriginalFilename';
  sfiProductName       = 'ProductName';
  sfiProductVersion    = 'ProductVersion';
  sfiComments          = 'Comments';
  sfiPrivateBuild      = 'PrivateBuild';
  sfiSpecialBuild      = 'SpecialBuild';
  sfiLanguageName      = 'Language';
  sfiLanguageID        = 'LanguageID';

function GetVersionInfo(NameApp, VerOpt : String) : String;

implementation

function GetVersionInfo(NameApp, VerOpt : String) : String;
var
  dump            : DWORD;
  size            : Integer;
  Temp            : Integer;
  buffer          : PChar;
  VersionPointer  : PChar;
  TransBuffer     : PChar;
  CalcLangCharSet : String;
begin
  size := GetFileVersionInfoSize(PChar(NameApp), dump);
  buffer := StrAlloc(size + 1);
    try
      GetFileVersionInfo(PChar(NameApp), 0, size, buffer);
      VerQueryValue(buffer, 'VarFileInfo\Translation', pointer(TransBuffer), dump);
      if dump >= 4 then
        begin
          temp := 0;
          StrLCopy(@temp, TransBuffer, 2);
          CalcLangCharSet := IntToHex(temp, 4);
          StrLCopy(@temp, TransBuffer + 2, 2);
          CalcLangCharSet := CalcLangCharSet+IntToHex(temp, 4);
        end;
      VerQueryValue(buffer, pchar('StringFileInfo\' + CalcLangCharSet + '\' + VerOpt), Pointer(VersionPointer), dump);
      if (dump > 1) then
        begin
          SetLength(Result, dump);
          StrLCopy(Pchar(Result), VersionPointer, dump);
          end
      else
        Result := '';
    finally
      StrDispose(Buffer);
    end;
end;

end.