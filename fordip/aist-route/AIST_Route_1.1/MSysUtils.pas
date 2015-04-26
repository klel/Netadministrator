unit MSysUtils;

interface

uses
  Windows, Messages, MCommCtrl;

function StringReplace(S, Old, New : String; ReplaceAll : Bool) : String;
function LoadStr(I : Integer) : String;
function IntToStr(I : Integer) : String;
function StrToInt(S : String) : Integer;
function FileExists(FileName : String) : Boolean;
function ExtractFilePath(FileName : String) : String;
function Format(FmtStr : String; Params : Array of const) : String;
function CenterWindow(hWindow : THandle) : Boolean;
function StrAlloc(Size : Cardinal) : PChar;
function StrLCopy(Dest, Source : PChar; MaxLen : Cardinal) : PChar; assembler;
function IntToHex(ACard : Cardinal; ADigits : Byte) : String;
function StrDispose(Str : PChar) : Integer;
function Edit_GetText(hEdit : THandle) : String;
function ListBox_GetText(hBox : THandle) : String;
function SysIP32_GetBlank(hSysIP : THandle) : Boolean;
function SysIP32_GetText(hSysIP : THandle) : String;
function SysIP32_SetText(hSysIP : THandle; Value : String) : Boolean;
function FormatTime(st : TSystemTime) : String;
function FormatDate : String;
function AllocMem(Size : Integer) : Pointer;
function ProcessMessages(hWnd : DWORD) : Boolean;
function HideTaskBarButton(hWnd : HWND) : Boolean;
function SysErrorMessage(ErrorCode : Integer) : String;
function Cmbx_GetText(hCmbx : THandle) : String;

implementation

function StringReplace(S, Old, New : String; ReplaceAll : Bool) : String;
var
  Position : Integer;
  Len      : Integer;
begin
  Len := Length(Old);
  while TRUE do
  begin
    Position := Pos(Old, S);
    if Position <> 0 then
      begin
        Delete(S, Position, Len);
        Insert(New, S, Position);
      end
    else
      Break;
    if ReplaceAll = FALSE then
      Break;
  end;
  Result := S;
end;

function LoadStr(I : Integer) : String;
var
  Buffer : Array [0..255] of Char;
begin
  LoadString(hInstance, I, Buffer, SizeOf(Buffer));
  Result := String(Buffer);
end;

function IntToStr(I : Integer) : String;
begin
  Str(I, Result);
end;

function StrToInt(S : String) : Integer;
var
  I : Integer;
begin
  Val(S, Result, I);
end;

function FileExists(FileName : String) : Boolean;
var
  Attributes : Cardinal;
begin
  Attributes := GetFileAttributes(Pointer(Filename));
  Result := (Attributes <> $FFFFFFFF) and (Attributes and FILE_ATTRIBUTE_DIRECTORY = 0);
end;

function ExtractFilePath(FileName : String) : String;
var
  I : Integer;
begin
  Result := '';
  I := Length(FileName);
  while(i > 0) do
  begin
    if(FileName[I] = ':') or (FileName[I] = '\') then
      begin
        Result := Copy(FileName, 1, I);
        Break;
      end;
    Dec(I);
  end;
end;

function Format(FmtStr : String; Params : Array of const) : String;
var
  PDW1 : PDWORD;
  PDW2 : PDWORD;
  I    : Integer;
  PC   : PChar;
begin
  PDW1 := nil;
  if Length(Params) > 0 then
    GetMem(PDW1, Length(Params) * SizeOf(Pointer));
  PDW2 := PDW1;
  for I := 0 to High(Params) do
    begin
      PDW2^ := DWORD(PDWORD(@Params[I])^);
      Inc(PDW2);
    end;
  GetMem(PC, 1024 - 1);
  try
    SetString(Result, PC, wvsprintf(PC, PChar(FmtStr), PChar(PDW1)));
  except
    Result := '';
  end;
  if (PDW1 <> nil) then
    FreeMem(PDW1);
  if (PC <> nil) then
    FreeMem(PC);
end;

function CenterWindow(hWindow : THandle) : Boolean;
var
  WndRect : TRect;
  iWidth  : Integer;
  iHeight : Integer;
begin
  GetWindowRect(hWindow, WndRect);
  iWidth := WndRect.Right - WndRect.Left;
  iHeight := WndRect.Bottom - WndRect.Top;
  WndRect.Left := (GetSystemMetrics(SM_CXSCREEN) - iWidth) div 2;
  WndRect.Top := (GetSystemMetrics(SM_CYSCREEN) - iHeight) div 2;
  MoveWindow(hWindow, WndRect.Left, WndRect.Top, iWidth, iHeight, FALSE);
  Result := TRUE;
end;

function StrAlloc(Size : Cardinal) : PChar;
begin
  Inc(Size, SizeOf(Cardinal));
  GetMem(Result, Size);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result, SizeOf(Cardinal));
end;

function StrLCopy(Dest, Source : PChar; MaxLen : Cardinal) : PChar; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EBX,ECX
        XOR     AL,AL
        TEST    ECX,ECX
        JZ      @@1
        REPNE   SCASB
        JNE     @@1
        INC     ECX
@@1:    SUB     EBX,ECX
        MOV     EDI,ESI
        MOV     ESI,EDX
        MOV     EDX,EDI
        MOV     ECX,EBX
        SHR     ECX,2
        REP     MOVSD
        MOV     ECX,EBX
        AND     ECX,3
        REP     MOVSB
        STOSB
        MOV     EAX,EDX
        POP     EBX
        POP     ESI
        POP     EDI
end;

function IntToHex(ACard : Cardinal; ADigits : Byte) : String;
const
  HexArray : array[0..15] of Char =
  ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' );
var
  LHex  : String;
  LInt  : DWORD;
  LHInt : DWORD;
begin
  LHex := StringOfChar('0', ADigits);
  LInt := ADigits;
  LHInt := 16;
  while ACard > 0 do
    begin
      LHex[LInt] := HexArray[(ACard mod LHint) mod 16];
      ACard := ACard div 16;
      LHInt := LHInt * 16;
      if LHInt = 0 then
        LHInt := $FFFFFFFF;
      Dec(LInt);
    end;
  Result := LHex;
end;

function StrDispose(Str : PChar) : Integer;
begin
 if Str <> nil then
  begin
   Dec(Str, SizeOf(Cardinal));
   FreeMem(Str, Cardinal(Pointer(Str)^));
 end;
end;

function Edit_GetText(hEdit : THandle) : String;
var
  Buffer : Array [0..255] of Char;
begin
  ZeroMemory(@Buffer, Length(Buffer));
  SendMessage(hEdit, WM_GETTEXT, SizeOf(Buffer), Integer(@Buffer));
  Result := String(Buffer);
end;

function ListBox_GetText(hBox : THandle) : String;
var
  I : Integer;
  L : Integer;
  S : String;
  P : PChar;
begin
  I := SendMessage(hBox, LB_GETCURSEL, 0, 0);
  L := SendMessage(hBox, LB_GETTEXTLEN, wParam(I), 0);
  GetMem(P, L + 1);
  SendMessage(hBox, LB_GETTEXT, wParam(I), lParam(P));
  SetString(S, P, L);
  FreeMem(P);
  Result := S;
end;

function SysIP32_GetBlank(hSysIP : THandle) : Boolean;
begin
  Result := Bool(SendMessage(hSysIP, IPM_ISBLANK, 0, 0));
end;

function SysIP32_GetText(hSysIP : THandle) : String;
var
  D : DWORD;
  S : String;
begin
  SendMessage(hSysIP, IPM_GETADDRESS, 0, Integer(@D));
  S := Format('%d.%d.%d.%d', [FIRST_IPADDRESS(D),
                              SECOND_IPADDRESS(D),
                              THIRD_IPADDRESS(D),
                              FOURTH_IPADDRESS(D)]);
  Result := S;
end;

function SysIP32_SetText(hSysIP : THandle; Value : String) : Boolean;
var
  I  : Integer;
  D  : Integer;
  IP : DWORD;
  P  : DWORD;
begin
  IP := 0;
  try
    I := 0;
    repeat
      D := Pos('.', Value);
      if D <= 1 then
        if I < 3 then
          Break
        else
          P := StrToInt(Value)
      else
        P := StrToInt(Copy(Value, 1, D - 1));
      if P > 255 then
        Break;
      Delete(Value, 1, D);
      IP := (IP shl 8) or P;
      Inc(I);
    until
      I > 3;
  except
  end;
  SendMessage(hSysIP, IPM_SETADDRESS, 0, IP);
  Result := TRUE;
end;

function FormatTime(st : TSystemTime) : String;
var
  lpBuf : Array [0..MAX_PATH] of Char;
begin
  ZeroMemory(@lpBuf, SizeOf(lpBuf));
  if (GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, @st, nil, lpBuf, SizeOf(lpBuf)) = 0) then
  lstrcpy(lpBuf, PChar(Format('%.2d:%.2d:%.2d', [st.wHour, st.wMinute, st.wSecond])));
  Result := lpBuf;
end;

function FormatDate : String;
var
  st    : TSystemTime;
  lpBuf : Array [0..MAX_PATH] of Char;
begin
  ZeroMemory(@lpBuf, SizeOf(lpBuf));
  if (GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, nil, nil, lpBuf, SizeOf(lpBuf)) = 0) then
  begin
    GetLocalTime(st);
    lstrcpy(lpBuf, PChar(Format('%.4d-%.2d-%.2d', [st.wYear, st.wMonth, st.wDay])));
  end;
  Result := lpBuf;
end;

function AllocMem(Size : Integer) : Pointer;
asm
  TEST     EAX, EAX
  JZ       @@exit
  PUSH     EAX
  CALL     System.@GetMem
  POP      EDX
  PUSH     EAX
  MOV      CL, 0
  CALL     System.@FillChar
  POP      EAX
  @@exit :
end;

function ProcessMessages(hWnd : DWORD) : Boolean;
var
  Msg : TMsg;
begin
  while PeekMessage(Msg, hWnd, 0, 0, PM_REMOVE) do
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  Result := TRUE;
end;

function HideTaskBarButton(hWnd : HWND) : Boolean;
var
  Wnd : THandle;
begin
  Wnd := CreateWindow('STATIC', #0, WS_POPUP, 0, 0, 0, 0, 0, 0, 0, nil);
  ShowWindow(hWnd, SW_HIDE);
  SetWindowLong(hWnd, GWL_HWNDPARENT, Wnd);
  ShowWindow(hWnd, SW_SHOW);
  Result := TRUE;
end;

function SysErrorMessage(ErrorCode : Integer) : String;
var
  LenMsg : Integer;
  Buffer : Array [0..255] of Char;
begin
  LenMsg := FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ARGUMENT_ARRAY, nil, ErrorCode, 0, Buffer, SizeOf(Buffer), nil);
  while (LenMsg > 0) and (Buffer[LenMsg - 1] in [#0..#32, '.']) do
    Dec(LenMsg);
  SetString(Result, Buffer, LenMsg);
end;

function Cmbx_GetText(hCmbx : THandle) : String;
var
  Idx    : Integer;
  Len    : Integer;
  S      : string;
  Buffer : PChar;
begin
  Idx := SendMessage(hCmbx, CB_GETCURSEL, 0, 0);
  Len := SendMessage(hCmbx, CB_GETLBTEXTLEN, wParam(Idx), 0);
  GetMem(Buffer, Len + 1);
  SendMessage(hCmbx, CB_GETLBTEXT, wParam(Idx), lParam(Buffer));
  SetString(S, Buffer, Len);
  FreeMem(Buffer);
  Result := S;
end;

end.