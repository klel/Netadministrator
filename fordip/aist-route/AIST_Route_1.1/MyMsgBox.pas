unit MyMsgBox;

interface

uses
  Windows;

function MbIserIcon_Ok(hWnd : HWND; Text, Caption : String; IDIcon : DWORD) : BOOL;
function MbIserIcon_YesNo(hWnd : HWND; Text, Caption : String; IDIcon : DWORD) : Integer;
function MbIserIcon_Error(hWnd : HWND; Text, Caption : String; IDIcon : DWORD) : BOOL;

implementation

function MbIserIcon_Ok(hWnd : HWND; Text, Caption : String; IDIcon : DWORD) : BOOL;
var
  MsgInfo : TMsgBoxParams;
begin
  with MsgInfo do
    begin
      lpfnMsgBoxCallback := nil;
      cbSize := SizeOf(TMsgBoxParams);
      hwndOwner := hWnd;
      hInstance := GetWindowLong(hWnd, GWL_HINSTANCE);
      lpszText := @Text[1];
      lpszCaption := @Caption[1];
      dwStyle := MB_USERICON or MB_OK;
      lpszIcon := MAKEINTRESOURCE(IDICON);
      dwLanguageId := GetSystemDefaultLangID;
      MessageBeep(MB_ICONASTERISK);
    end;
  Result := MessageBoxIndirect(MsgInfo);
end;

function MbIserIcon_YesNo(hWnd : HWND; Text, Caption : String; IDIcon : DWORD) : Integer;
var
  MsgInfo : TMsgBoxParams;
begin
  with MsgInfo do
    begin
      lpfnMsgBoxCallback := nil;
      cbSize := SizeOf(TMsgBoxParams);
      hwndOwner := hWnd;
      hInstance := GetWindowLong(hWnd, GWL_HINSTANCE);
      lpszText := @Text[1];
      lpszCaption := @Caption[1];
      dwStyle := MB_USERICON or MB_YESNO;
      lpszIcon := MAKEINTRESOURCE(IDICON);
      dwLanguageId := GetSystemDefaultLangID;
      MessageBeep(MB_ICONEXCLAMATION);
    end;
  Result := Integer(MessageBoxIndirect(MsgInfo));
end;

function MbIserIcon_Error(hWnd : HWND; Text, Caption : String; IDIcon : DWORD) : BOOL;
var
  MsgInfo : TMsgBoxParams;
begin
  with MsgInfo do
    begin
      lpfnMsgBoxCallback := nil;
      cbSize := SizeOf(TMsgBoxParams);
      hwndOwner := hWnd;
      hInstance := GetWindowLong(hWnd, GWL_HINSTANCE);
      lpszText := @Text[1];
      lpszCaption := @Caption[1];
      dwStyle := MB_USERICON or MB_OK;
      lpszIcon := MAKEINTRESOURCE(IDICON);
      dwLanguageId := GetSystemDefaultLangID;
      MessageBeep(MB_ICONHAND);
    end;
  Result := MessageBoxIndirect(MsgInfo);
end;

end.