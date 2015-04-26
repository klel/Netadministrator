unit MCommCtrl;

interface

uses
 Messages, Windows;

type
  PInitCommonControlsEx = ^TInitCommonControlsEx;
  TInitCommonControlsEx = packed record
    dwSize : DWORD;
    dwICC  : DWORD;
  end;
  
  PLVItemA = ^TLVItemA;
  PLVItemW = ^TLVItemW;
  PLVItem = PLVItemA;
  TLVItemA = packed record
    mask       : UINT;
    iItem      : Integer;
    iSubItem   : Integer;
    state      : UINT;
    stateMask  : UINT;
    pszText    : PAnsiChar;
    cchTextMax : Integer;
    iImage     : Integer;
    lParam     : lParam;
  end;
  TLVItemW = packed record
    mask       : UINT;
    iItem      : Integer;
    iSubItem   : Integer;
    state      : UINT;
    stateMask  : UINT;
    pszText    : PWideChar;
    cchTextMax : Integer;
    iImage     : Integer;
    lParam     : lParam;
  end;
  TLVItem = TLVItemA;

const
  ODM_VIEW_ICONS      = $7029;
  ODM_VIEW_LIST       = $702B;
  ODM_VIEW_DETAIL     = $702C;
  ODM_VIEW_THUMBS     = $702D;
  ODM_VIEW_TILES      = $702E;

  PSH_WIZARD97        = $01000000;

  LVS_EX_BORDERSELECT = $00008000;
  LVIF_TEXT           = $0001;
  LVM_FIRST           = $1000;
  LVM_GETITEM         = LVM_FIRST + 5;
  LVM_GETNEXTITEM     = LVM_FIRST + 12;
  LVNI_FOCUSED        = $0001;
  LVIS_STATEIMAGEMASK = $F000;
  LVM_SETITEMSTATE    = LVM_FIRST + 43;
  LVM_GETITEMSTATE    = LVM_FIRST + 44;
  LVM_GETITEMCOUNT    = LVM_FIRST + 4;

  IPM_ISBLANK         = WM_USER + 105;
  IPM_SETADDRESS      = WM_USER + 101;
  IPM_GETADDRESS      = WM_USER + 102;

function FIRST_IPADDRESS(x : DWORD) : DWORD;
function SECOND_IPADDRESS(x : DWORD) : DWORD;
function THIRD_IPADDRESS(x : DWORD) : DWORD;
function FOURTH_IPADDRESS(x : DWORD) : DWORD;

function InitCommonControlsEx(var ICC : TInitCommonControlsEx) : Bool;

function ListView_GetItemText(hLV : HWND; I : Integer) : String;
function ListView_GetCheckState(hLV : HWND; I : Integer) : UINT;
function ListView_SetCheck(hLV : HWND; fFlag : Boolean) : Boolean;
function ListView_GetItemCount(hLV : HWND) : Integer;
function ListView_InvertSelect(hLV : HWND) : Boolean;

implementation

var
  ComCtl32DLL : THandle;
  _InitCommonControlsEx : function(var ICC : TInitCommonControlsEx) : Bool; stdcall;

procedure InitCommonControls; external 'comctl32.dll' name 'InitCommonControls';

procedure InitComCtl;
begin
  if ComCtl32DLL = 0 then
    begin
      ComCtl32DLL := GetModuleHandle('comctl32.dll');
      if (ComCtl32DLL >= 0) and (ComCtl32DLL < 32) then
        ComCtl32DLL := 0
      else
        @_InitCommonControlsEx := GetProcAddress(ComCtl32DLL, 'InitCommonControlsEx');
    end;
end;

function InitCommonControlsEx(var ICC : TInitCommonControlsEx) : Bool;
begin
  if ComCtl32DLL = 0 then
    InitComCtl;
  Result := Assigned(_InitCommonControlsEx) and _InitCommonControlsEx(ICC);
end;

function FIRST_IPADDRESS(x : DWORD) : DWORD;
begin
  Result := (x shr 24) and $FF;
end;

function SECOND_IPADDRESS(x : DWORD) : DWORD;
begin
  Result := (x shr 16) and $FF;
end;

function THIRD_IPADDRESS(x : DWORD) : DWORD;
begin
  Result := (x shr 8) and $FF;
end;

function FOURTH_IPADDRESS(x : DWORD) : DWORD;
begin
  Result := x and $FF;
end;

function ListView_GetItemText(hLV : HWND; I : Integer) : String;
var
  LVI : TLVItem;
  Buf : Array [0..255] of Char;
begin
  ZeroMemory(@LVI, SizeOf(LVI));
  LVI.iItem := I;
  LVI.iSubItem := 0;
  LVI.mask := LVIF_TEXT;
  LVI.pszText := Buf;
  LVI.cchTextMax := 256;
  SendMessage(hLV, LVM_GETITEM, 0, Integer(@LVI));
  Result := String(Buf);
end;

function ListView_SetCheckState(hLV : HWND; I : Integer; fFlag : Boolean) : Boolean;
var
  LVI : TLVItem;
begin
  LVI.statemask := LVIS_STATEIMAGEMASK;
  LVI.State := ((Integer(fFlag) and 1) + 1) shl 12;
  SendMessage(hLV, LVM_SETITEMSTATE, I, Integer(@LVI));
  Result := TRUE;
end;

function ListView_InvertSelect(hLV : HWND) : Boolean;
var
  I : Integer;
begin
  I := SendMessage(hLV, LVM_GETNEXTITEM, -1 , LVNI_FOCUSED);
  if I = -1 then
    begin
      Result := FALSE;
      Exit;
    end
  else
    begin
      if ListView_GetCheckState(hLV, I) <> 0 then
        ListView_SetCheckState(hLV, I, FALSE)
      else
        ListView_SetCheckState(hLV, I, TRUE);
    end;
  Result := TRUE;
end;

function ListView_GetCheckState(hLV : HWND; I : Integer) : UINT;
begin
  Result := (SendMessage(hLV, LVM_GETITEMSTATE, I, LVIS_STATEIMAGEMASK) shr 12) - 1;
end;

function ListView_SetCheck(hLV : HWND; fFlag : Boolean) : Boolean;
var
  I : Integer;
begin
  if (fFlag = TRUE) then
    begin
      for I := 0 to SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0) - 1 do
        ListView_SetCheckState(hLV, I, TRUE);
    end
  else
    begin
      for I := 0 to SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0) - 1 do
        ListView_SetCheckState(hLV, I, FALSE);
    end;
  Result := TRUE;
end;

function ListView_GetItemCount(hLV : HWND) : Integer;
begin
  Result := SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0);
end;

initialization
  InitCommonControls;

end.