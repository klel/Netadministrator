{**************************************************************
* Исходный код программы АИСТ ROUTE (NonVCL)                  *
*                                                             *
* Автор программы: Explorer (Maksim V.)                       *
*                                                             *
* Текущая версия приложения: 1.1.0.0 Релиз кандидат 4         *
* Дата последнего изменения: 6 Августа 2008 года              *
*                                                             *
* Отдельная благодарность: Rouse_, GlooMen, Terror            *
*                                                             *
**************************************************************}

program AISTRoute;

uses
  Windows, Messages, CommDlg, CommCtrl, ShellApi, MCommCtrl,
  MSysUtils, GetVerFile, BitBtnVCL, GetWebFile, MyMsgBox,
  IpExport, IpHlpApi, IpTypes, IpIfConst, IpRtrMib, Winsock;

{$I Const.pas}

{$I Type.pas}

{$I Var.pas}

{$R AISTRoute.res}

{ Внедряемая функция для изменения размеров значков в списке }
function ListOpenProc(Wnd : HWND; uMsg : Cardinal; wParam : wParam; lParam : lParam) : UINT; stdcall;
var
  ShellHandle : THandle;
begin
  case uMsg of
    WM_SHOWWINDOW :
      begin
        ShellHandle := FindWindowEx(Wnd, 0, 'SHELLDLL_DefView', nil);
        SendMessage(ShellHandle, WM_COMMAND, DLGStyles[0], 0);
      end;
    end;
  Result := CallWindowProc(Pointer(GetWindowLong(Wnd, GWL_USERDATA)), Wnd, uMsg, wParam, lParam);
end;

{ Внедряемая функция в диалог сохранения файлов }
function SaveDlgHook(Wnd : HWND; uMsg : Cardinal; wParam : wParam; lParam : lParam) : UINT; stdcall;
begin
  Result := 0;
  case uMsg of
    WM_INITDIALOG :
      begin
        SetWindowLong(GetParent(Wnd), GWL_USERDATA, SetWindowLong(GetParent(Wnd), DWL_DLGPROC, DWORD(@ListOpenProc)));
        if hIconApp <> 0 then
          SendMessage(GetParent(Wnd), WM_SETICON, ICON_SMALL, hIconApp);
        CenterWindow(GetParent(Wnd));
      end;
  end;
end;

{ Внедряемая функция в диалог открытия файлов }
function OpenDlgHook(Wnd : HWND; uMsg : Cardinal; wParam : wParam; lParam : lParam) : UINT; stdcall;
begin
  Result := 0;
  case uMsg of
    WM_INITDIALOG :
      begin
        SetWindowLong(GetParent(Wnd), GWL_USERDATA, SetWindowLong(GetParent(Wnd), DWL_DLGPROC, DWORD(@ListOpenProc)));
        if hIconApp <> 0 then
          SendMessage(GetParent(Wnd), WM_SETICON, ICON_SMALL, hIconApp);
        CenterWindow(GetParent(Wnd));
      end;
  end;
end;

{ Функция для отключения/включения элементов интерфейса }
function EnableDisableControls(fFlag : Boolean) : Integer;
begin
  Result := 0;
  EnableWindow(GetDlgItem(hApp, IDC_LBOX_IPR), fFlag);
  EnableWindow(GetDlgItem(hApp, IDC_CHX_CLRT), fFlag);
  EnableWindow(GetDlgItem(hApp, IDC_BTN_AUTO), fFlag);
  EnableWindow(GetDlgItem(hApp, IDC_BTN_SAVE), fFlag);
end;

{ Получаем со всех интерфейсов маршруты по умолчанию }
function GetIpAddressRoute(hLbx, hTbr, hCmb : THandle) : Boolean;
var
  IntInfo  : PIP_ADAPTER_INFO;
  TmpPoint : PIP_ADAPTER_INFO;
  BufLen   : ULONG;
  Address  : String;
  I        : Integer;
  Index    : Integer;
begin
  Index := 0;
  // Включаем элементы интерфейса на всякий случай
  EnableDisableControls(TRUE);
  SendMessage(hTbr, TB_ENABLEBUTTON, IDC_TBR_LOAD, lParam(TRUE));
  SendMessage(hTbr, TB_ENABLEBUTTON, IDC_TBR_TOOL, lParam(TRUE));
  // Удаляем все строки из списка сетевых интерфейсов
  SendMessage(hLbx, LB_RESETCONTENT, 0, 0);
  if GetAdaptersInfo(nil, BufLen) = ERROR_BUFFER_OVERFLOW then
  begin
    GetMem(IntInfo, BufLen);
    Index := 0;
    try
      if GetAdaptersInfo(IntInfo, BufLen) = ERROR_SUCCESS then
      begin
        TmpPoint := IntInfo;
        repeat
          Address := TmpPoint^.GatewayList.IpAddress.S;
          if not (Address = '') then
            begin
              SendMessage(hLbx, LB_ADDSTRING, 0, Integer(PChar(Address)));
              SendMessage(hCmb, CB_ADDSTRING, 0, Integer(PChar(Address)));
              Inc(Index);
            end;
          TmpPoint := TmpPoint.Next;
        until
          TmpPoint = nil;
      end;
    finally
      FreeMem(IntInfo);
    end;
  end;
  I := SendMessage(hLbx, LB_GETCURSEL, 0, 0);
  SendMessage(hLbx, LB_SETCURSEL, I + 1, 0);
  // Проверяем наличие IP адресов сетевых интерфейсов в системе
  // Если их нет, то удаляем все содержимое из списка, делаем некативными элементы
  // Отображаем в списке что адреса отсутствуют
  if Index = 0 then
    begin
      SendMessage(hLbx, LB_RESETCONTENT, 0, 0);
      EnableDisableControls(FALSE);
      SendMessage(hLbx, LB_ADDSTRING, 0, Integer(PChar(LoadStr(STR_ROUTE_FALSE))));
      I := SendMessage(hLbx, LB_GETCURSEL, 0, 0);
      SendMessage(hLbx, LB_SETCURSEL, I + 1, 0);
      SendMessage(hTbr, TB_ENABLEBUTTON, IDC_TBR_LOAD, lParam(FALSE));
      SendMessage(hTbr, TB_ENABLEBUTTON, IDC_TBR_TOOL, lParam(FALSE));
      Result := FALSE;
      Exit;
    end;
  Result := TRUE;
end;

{ Создаем список и применяем к нему расширенные стили }
function CreateColumnsListview(hLV : THandle) : Boolean;
begin
  GetClientRect(hLV, rc);
  lvc.mask := LVCF_TEXT or LVCF_WIDTH or LVCF_FMT;
  lvc.cx := (rc.Right - rc.Left) - 5;
  SendMessage(hLV, LVM_INSERTCOLUMN, 0, Integer(@lvc));
  SendMessage(hLV, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT or LVS_EX_CHECKBOXES or LVS_EX_BORDERSELECT);
  FillChar(BitmapImage, SizeOf(BitmapImage), 0);
  BitmapImage.ulFlags := LVBKIF_SOURCE_HBITMAP or LVBKIF_STYLE_TILE;
  BitmapImage.hbm := LoadImage(hInstance, MAKEINTRESOURCE(IDB_BTMPLIST), IMAGE_BITMAP, 0, 0, LR_DEFAULTSIZE);
  ListView_SetBkImage(hLV, @BitmapImage);
  Result := TRUE;
end;

{ Загрузка списка маршрутов из массива строк при инициализации программы }
function LoadArrayRoute(hLV : THandle) : Boolean;
var
  I : Integer;
begin
  lvi.mask := LVIF_TEXT;
  for I := 1 to 6 do
    begin
      lvi.iSubItem := 0;
      lvi.pszText := PChar(ArrayRoute[I]);
      SendMessage(hLV, LVM_INSERTITEM, 0, Integer(@lvi));
    end;
  Result := TRUE;
end;

{ Сабклассинг Static для создания гиперссылки }
function StcWndFunc(hStc : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : lResult; stdcall;
var
  FuncMouseEvent : function(var TME : TTrackMouseEvent) : BOOL; stdcall;
begin
  Result := 0;
  case uMsg of
    WM_MOUSELEAVE :
      if LinkHover then
      begin
        LinkHover := FALSE;
        hFontYes := GetProp(hStc, PROP_NONHOVER);
        if hFontYes = 0 then
        begin
          hFontYes := CreateFont(-MulDiv(-10, GetDeviceCaps(GetDC(hStc), LOGPIXELSY), 72), 0, 0, 0, 400, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, 'Tahoma');
          if hFontYes <> 0 then
            SetProp(hStc, PROP_NONHOVER, hFontYes);
        end;
        SendMessage(hStc, WM_SETFONT, Integer(hFontYes), Integer(TRUE));
      end;
    WM_MOUSEMOVE :
      if not LinkHover then
      begin
        LinkHover := TRUE;
        hFontNot := GetProp(hStc, PROP_YESHOVER);
        if hFontNot = 0 then
        begin
          hFontNot := CreateFont(-MulDiv(-10, GetDeviceCaps(GetDC(hStc), LOGPIXELSY), 72), 0, 0, 0, 400, 0, 1, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, 'Tahoma');
          if hFontNot <> 0 then
            SetProp(hStc, PROP_YESHOVER, hFontNot);
        end;
        SendMessage(hStc, WM_SETFONT, Integer(hFontNot), Integer(TRUE));
        TME.cbSize := SizeOf(TME);
        TME.dwFlags := TME_LEAVE;
        TME.hwndTrack := hStc;
        TME.dwHoverTime := HOVER_DEFAULT;
        @FuncMouseEvent := @TrackMouseEvent;
        FuncMouseEvent(TME);
      end;
    WM_DESTROY :
      begin
        DeleteObject(GetProp(hStc, PROP_NONHOVER));
        RemoveProp(hStc, PROP_NONHOVER);
        DeleteObject(GetProp(hStc, PROP_YESHOVER));
        RemoveProp(hStc, PROP_YESHOVER);
      end;
  else
    Result := CallWindowProc(StcWndProc, hStc, uMsg, wParam, lParam);
  end;
end;

{ Обрабатываем строку для получения адреса и типа маршрута из файла }
function ParserServerFileRead(StrPrs : String) : String;
var
  Route : String;
  Domen : String;
  I     : Integer;
  P     : Integer;
  D     : Integer;
  K     : String;
begin
  Result := '';
  // Удаляем с первого символа строки 2 последующих символа - "/0" или "/1"
  // Требуется для получения маршрута без маркеров пометки для списка
  Delete(StrPrs, 1, 2);
  // Получаем длину строки вместе с кареткой для последующего подсчета символов
  // Затем удаляем последний символ каретки из получившейся строки
  for D := Length(StrPrs) downto 1 do
    if (StrPrs[D] = '/') or (StrPrs[D] = '\') then
      begin
        Route := Copy(StrPrs, 0, D);
        Break;
      end;
  // Удаляем последний символ каретки из полученной строки
  Delete(Route, Length(Route), 1);
  // Получаем тип маршрута, извлекая последние символы, из первоначальной строки
  P := -1;
  if StrPrs <> '' then
    begin
      for I := Length(StrPrs) downto 1 do
        begin
          if StrPrs[I] = '/' then
            begin
              P := I;
              Break;
            end;
        end;
      if P <> -1 then
        K := Copy(StrPrs, P + 1, Length(StrPrs));
      Domen := StringReplace(K, ' ', '', TRUE);
    end;
  // Выводим конечный результат
  Result := Route + Format(' (%s)', [Domen]);
end;

{ Проверяем условие для отметки строки в списке маршрутов }
function ParserServerFileCheck(StrPrs : String) : Boolean;
begin
  if (Pos('1/', StrPrs) <> 0) then
    Result := TRUE
  else
    Result := FALSE;
end;

{ Обрабатываем строку для получения маршрута в пакетный файл }
function ParserStringWriteRoute(StrPrs : String) : String;
var
  Domen : String;
  Route : String;
  I     : Integer;
  P     : Integer;
begin
  Result := '';
  // Удаляем из начальной строки последний символ (скобка после названия)
  Delete(StrPrs, Length(StrPrs), 1);
  // Проходимся по всей строке и ищем начальную скобку перед названием
  P := -1;
  for I := Length(StrPrs) downto 1 do
    begin
      if StrPrs[I] = '(' then
        begin
          P := I;
          Break;
        end;
    end;
  // Если скобку нашли - получаем название из начальной строки
  if P <> -1 then
    Domen := Copy(StrPrs, P + 1, Length(StrPrs));
  // Приравниваем начальную строку к строке маршрута
  Route := StrPrs;
  // Удаляем название из строки, включая 2 последних символа (две скобки из маршрута)
  Delete(Route, Length(StrPrs) - Length(Domen) - 1, Length(Domen) + 2);
  Result := Route;
end;

{ Обрабатываем строку для сохранения названия в пакетный файл }
function ParserStringWriteDomen(StrPrs : String) : String;
var
  Domen : String;
  I     : Integer;
  P     : Integer;
begin
  Result := '';
  // Удаляем из начальной строки последний символ (скобка после названия)
  Delete(StrPrs, Length(StrPrs), 1);
  // Проходимся по все строке и ищем начальную скобку перед названием
  P := -1;
  for I := Length(StrPrs) downto 1 do
    begin
      if StrPrs[I] = '(' then
        begin
          P := I;
          Break;
        end;
    end;
  // Если скобку нашли - получаем название из начальной строки
  if P <> -1 then
    Domen := Copy(StrPrs, P + 1, Length(StrPrs));
  Result := Domen;
end;

{$I DialogDownload.pas}

{ Получение списка всех маршрутов с добвалением данных для последующего сохранения }
function GetRoutersList(hLV : THandle) : String;
var
  I     : Integer;
  Route : String;
  Domen : String;
begin
  for I := 0 to SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0) - 1 do
    begin
      lvi.iItem := I;
      if ListView_GetCheckState(hLV, I) <> 0 then
        begin
          Route := ParserStringWriteRoute( ListView_GetItemText(hLV, I) );
          Domen := ParserStringWriteDomen( ListView_GetItemText(hLV, I) );
          Result := Result + Format('route -p add %s %%MyRouter%%', [Route]) + sLineBreak + Format('rem %s', [Domen]) + sLineBreak;
        end;
    end;
end;

{ Создание строкового массива с сохранением в него всей полученной информации }
function MakeBatFile(hChbx, hLBox, hView : THandle) : String;
var
  FileCrt  : String;
  DateCrt  : String;
  lSysTime : TSystemTime;
begin
  GetLocalTime(lSysTime);
  FileCrt := Format('This file created by AIST ROUTE %s', [GetVersionInfo(ParamStr(0), sfiFileVersion)]);
  DateCrt := Format('Date of creation : %s / %s', [FormatTime(lSysTime), FormatDate]);
  Result := Result + Format('rem %s', [FileCrt]) + sLineBreak;
  Result := Result + Format('rem %s', [DateCrt]) + sLineBreak;
  Result := Result + Format('set MyRouter=%s', [ListBox_GetText(GetDlgItem(hApp, IDC_LBOX_IPR))]) + sLineBreak;
  if SendMessage(hChbx, BM_GETCHECK, 0, 0) = BST_CHECKED then
    Result := Result + 'route -f print' + sLineBreak;
  Result := Result + 'ipconfig /renew' + sLineBreak;
  Result := Result + GetRoutersList(hView);
  Result := Result + 'route print' + sLineBreak;
  Result := Result + Format('rem %s', ['Thank you for using this software :)']) + sLineBreak;
  Result := Result + 'pause';
end;

{ Сохранение в текстовый пакетный файл всех собранных данных }
function SaveDataToBatFile : Boolean;
var
  F : TextFile;
begin
  AssignFile(F, Edit_GetText(GetDlgItem(hApp, IDC_EDT_PATH)));
{$I-}
  Rewrite(F);
  if IOResult <> 0 then
    begin
      CloseFile(F);
      MbIserIcon_Error(hApp, PChar(SysErrorMessage(GetLastError)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
{$I+}
      Result := FALSE;
      Exit;
    end;
  WriteLn(F, MakeBatFile(GetDlgItem(hApp, IDC_CHX_CLRT), GetDlgItem(hApp, IDC_LBOX_IPR), GetDlgItem(hApp, IDC_LVIEW_IP)));
  try
  finally
    CloseFile(F);
    Result := TRUE;
  end;
end;

{$I DialogCreate.pas}
{$I DialogChange.pas}

{ Проверка на отмеченность/неотмеченность всех элементов в списке }
function CheckListEnableButtons(hLV : HWND) : String;
var
  I : Integer;
begin
  for I := 0 to SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0) - 1 do
    begin
      lvi.iItem := I;
      if ListView_GetCheckState(hLV, I) <> 0 then
        Result := Result + ListView_GetItemText(hLV, I) + sLineBreak;
    end;
end;

{ Подсчет количества отмеченных элемнтов в списке}
function GetCheckListButtons(hLV : HWND) : Integer;
var
  I : Integer;
  P : Integer;
begin
  P := 0;
  for I := 0 to SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0) - 1 do
    begin
      lvi.iItem := I;
      if ListView_GetCheckState(hLV, I) <> 0 then
        Inc(P);
    end;
  Result := P;
end;

{ Создание панели инструментов с кнопками }
function BuildMainToolbar(hTbr : HWND) : Boolean;
begin
  hImgList := ImageList_Create(16, 16, ILC_COLOR32, 3, 1);
  ImageList_AddIcon(hImgList, LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONDWLD), IMAGE_ICON, 16, 16, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONEDTR), IMAGE_ICON, 16, 16, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONTOOL), IMAGE_ICON, 16, 16, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  tbButtons[1].iBitmap := 0;
  tbButtons[3].iBitmap := 1;
  tbButtons[5].iBitmap := 2;
  SendMessage(hTbr, TB_BUTTONSTRUCTSIZE, SizeOf(TTBBUTTON), 0);
  SendMessage(hTbr, TB_BUTTONCOUNT, 0, 0);
  SendMessage(hTbr, TB_ADDBUTTONS, Length(tbButtons), lParam(@tbButtons));
  SendMessage(hTbr, TB_SETIMAGELIST, 0, hImgList);
  SendMessage(hTbr, TB_AUTOSIZE, 0, 0);
  SendMessage(hTbr, TB_SETEXTENDEDSTYLE, 0, TBSTYLE_EX_DRAWDDARROWS or TBSTYLE_EX_MIXEDBUTTONS);
  SendMessage(hTbr, TB_ADDSTRING, 0, lParam(PChar(LoadStr(STR_TOLBAR_LOAD) + #0 + LoadStr(STR_TOLBAR_EDIT) + #0 + LoadStr(STR_TOLBAR_HELP) + #0#0)));
  Result := TRUE;
end;

{ Создание меню с изображениями для панели инструментов с кнопками }
function BuildMenuToolbar(hTbr : HWND) : Boolean;
var
  I : Integer;
begin
  MenuItems[1].icon := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONLOAD), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[2].icon := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONEDIT), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[3].icon := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONRMVE), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[1].text := PChar(LoadStr(STR_MENU_CREATE));
  MenuItems[2].text := PChar(LoadStr(STR_MENU_CHANGE));
  MenuItems[3].text := PChar(LoadStr(STR_MENU_DELETE));
  hSubMenu := CreatePopupMenu;
  AppendMenu(hSubMenu, MF_OWNERDRAW, IDC_PMN_CRTE, @MenuItems[1]);
  AppendMenu(hSubMenu, MF_SEPARATOR, 0, nil);
  AppendMenu(hSubMenu, MF_OWNERDRAW, IDC_PMN_EDIT, @MenuItems[2]);
  AppendMenu(hSubMenu, MF_SEPARATOR, 0, nil);
  AppendMenu(hSubMenu, MF_OWNERDRAW, IDC_PMN_RMVE, @MenuItems[3]);
  for I := 1 to 3 do if MenuItems[I].icon <> 0 then
    DeleteObject(MenuItems[I].icon);
  Result := TRUE;
end;

{ Установка активности элементов при проверке }
function SetActiveControls : Boolean;
begin
if (GetIpAddressRoute(GetDlgItem(hApp, IDC_LBOX_IPR), GetDlgItem(hApp, IDC_TBR_BTNS), GetDlgItem(hMst, IDC_CMBX_IPR)) = FALSE) or
  (CheckListEnableButtons(GetDlgItem(hApp, IDC_LVIEW_IP)) = '') or
  (Edit_GetText(GetDlgItem(hApp, IDC_EDT_PATH)) = '') then
    EnableDisableControls(FALSE);
  Result:= TRUE;
end;

{ Функция для подсчета списка загруженных записей и выделенных }
function StartCountStatusValues(hBar, hLst : HWND) : Boolean;
begin
  SendMessage(hBar, SB_SETTEXT, 0, Integer(PChar(Format(PChar(LoadStr(STR_LOAD_NUMRTE)), [IntToStr(ListView_GetItemCount(hLst))]))));
  SendMessage(hBar, SB_SETTEXT, 1, Integer(PChar(Format(PChar(LoadStr(STR_LOAD_SELRTE)), [IntToStr(GetCheckListButtons(hLst)), IntToStr(ListView_GetItemCount(hLst))]))));
  Result := TRUE;
end;

{ Функция для удаления выделенных элементов из списка }
function DelCheckListButton(hBar, hLst : HWND) : Boolean;
var
  idx : Integer;
  row : Integer;
begin
  idx := SendMessage(hLst, LVM_GETSELECTIONMARK, 0, 0);
  if idx > -1 then
    begin
      FillChar(lvi, sizeof(lvi), #0);
      lvi.iItem := SendMessage(hLst, LVM_GETNEXTITEM, -1, LVNI_FOCUSED);
    end
  else
    MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_DELRW)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
  if ListView_GetCheckState(hLst, lvi.iItem) <> 0 then
    begin
      row := SendMessage(hLst, LVM_GETNEXTITEM, -1, LVNI_SELECTED);
      SendMessage(hLst, LVM_DELETEITEM, lvi.iItem, 0);
    end
  else
    MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_DELRW)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
  // Проверяем активность элементов после внесенных изменений
  SetActiveControls;
  StartCountStatusValues(hBar, hLst);
  // Выделяем тот пункт в меню, который был до удаления
  lvi.stateMask := LVNI_SELECTED;
  lvi.state := LVNI_SELECTED;
  SendMessage(hLst, LVM_SETITEMSTATE, row, Integer(@lvi));
  Result := TRUE;
end;

{$I DialogProperty.pas}

{ Поток для вставки значков в информационные сообщения программы }
function SetIconThread : Integer;
var
  Wnd : Integer;
  Buf : Array [0..MAX_PATH - 1] of Char;
begin
  // Устанавливаем минимальный приоритет нашему потоку
  SetThreadPriority(ThreadIcon, THREAD_PRIORITY_BELOW_NORMAL);
  while TRUE do
    begin
      // Ищем окно по его заголовку
      Wnd := FindWindow(nil, PChar(Format(LoadStr(STR_MSGBX_ABOUT), [GetVersionInfo(ParamStr(0), sfiProductName)]))) or FindWindow(nil, PChar(LoadStr(STR_MSGBX_ERROR))) or FindWindow(nil, PChar(LoadStr(STR_MSGBX_INFOR)));
      if Wnd <> 0 then
        begin
          // Очищаем буфер под текст из заголовка
          ZeroMemory(@Buf, SizeOf(Buf));
          // Помещаем значок программы на окно
          SendMessage(Wnd, WM_SETICON, ICON_SMALL, hIconApp);
          // Сохраняем текст из окна в буфер
          SendMessage(Wnd, WM_GETTEXT, SizeOf(Buf), Integer(@Buf));
          // Помещаем текст из буфера в окно
          SendMessage(Wnd, WM_SETTEXT, 0, Integer(PChar(@Buf)));
        end;
      // Приостанавливаем выполнение потока  
      Sleep(45);
    end;
end;

{ Функция для обработки диалогового окна приложения }
function MainDlgProc(hWnd : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : BOOL; stdcall;
var
  Rect    : TRect;
  I       : Integer;
  ListWnd : THandle;
  ListDC  : hDC;
  RectLB  : TRect;
  TextLB  : Array [0..$400] of Char;
  Panels  : Array [0..1] of Integer;
  size    : TSize;
  MenuDC  : hDC;
  lpmis   : ^TMeasureItemStruct;
  lpdis   : ^TDrawItemStruct;
  item    : ^TMenuItem;
  pt      : TPoint;
begin
  Result := TRUE;
  case uMsg of

    WM_SYSCOMMAND :
      begin
        if wParam = SC_CONTEXTHELP then
        begin
          MbIserIcon_Ok(hApp,
          PChar(
          PChar(Format(LoadStr(STR_MSGBX_NMAPP), [GetVersionInfo(ParamStr(0), sfiProductName)])) + sLineBreak +
          PChar(Format(LoadStr(STR_MSGBX_VERSN), [GetVersionInfo(ParamStr(0), sfiFileVersion), RELEASEAPPVERSION])) + sLineBreak +
          PChar(Format(LoadStr(STR_MSGBX_BUILD), ['6 Августа 2008 года'])) + sLineBreak + sLineBreak +
          PChar(GetVersionInfo(ParamStr(0), sfiLegalCopyright)) + sLineBreak +
          PChar(LoadStr(STR_MSGBX_COPRT) + sLineBreak + sLineBreak +
          PChar(LoadStr(STR_MSGBX_WARNG) + sLineBreak + sLineBreak +
          PChar(LoadStr(STR_MSGBX_FREEW))))
          ),
          PChar(Format(LoadStr(STR_MSGBX_ABOUT), [GetVersionInfo(ParamStr(0), sfiProductName)])), RES_ICONHELP);
        end
        else
          Result := FALSE;
      end;

    WM_MEASUREITEM :
      begin
        case wParam of
          IDC_LBOX_IPR :
            begin
              with PMEASUREITEMSTRUCT(lParam)^ do
                begin
                  itemHeight := 18;
                end;
            end;
        end;
        case PDRAWITEMSTRUCT(lParam).CtlType of
          ODT_MENU :
            begin
              MenuDC := GetDC(hApp);
              lpmis := Pointer(lParam);
              item := Pointer(lpmis.ItemData);
              GetTextExtentPoint32(MenuDC, PChar(item.text), Length(item.text), size);
              lpmis.itemWidth := size.cx - 10;
              lpmis.itemHeight := 20;
              ReleaseDC(hApp, MenuDC);
            end;
        end;
      end;

    WM_DRAWITEM :
      begin
        case wParam of
          IDC_LBOX_IPR :
            begin
              ListWnd := PDRAWITEMSTRUCT(lParam).hwndItem;
              RectLB := PDRAWITEMSTRUCT(lParam).rcItem;
              ListDC := PDRAWITEMSTRUCT(lParam).hDC;
              if (Integer(PDRAWITEMSTRUCT(lParam).ItemID) > -1) then
                begin
                  if ((PDRAWITEMSTRUCT(lParam).itemState and ODS_SELECTED) <> 0) then
                    begin
                      FillRect(ListDC, RectLB, GetSysColorBrush(COLOR_HIGHLIGHT));
                      SetBkMode(ListDC, GetSysColor(COLOR_HIGHLIGHT));
                      SetTextColor(ListDC, GetSysColor(COLOR_HIGHLIGHTTEXT));
                    end
                  else
                    begin
                      FillRect(ListDC, RectLB, GetSysColorBrush(COLOR_WINDOW));
                      SetBkColor(ListDC, GetSysColor(COLOR_WINDOW));
                      SetTextColor(ListDC, GetSysColor(COLOR_WINDOWTEXT));
                    end;
                  RectLB.Left := RectLB.Left + 5;
                  SendMessage(ListWnd, LB_GETTEXT, PDRAWITEMSTRUCT(lParam).ItemID, LongInt(@TextLB[0]));
                  DrawText(ListDC, @TextLB[0], - 1, RectLB, DT_SINGLELINE or DT_VCENTER);
                end;
              if ((PDRAWITEMSTRUCT(lParam).itemState and ODS_FOCUS) <> 0) then
                DrawFocusRect(ListDC, PDRAWITEMSTRUCT(lParam).rcItem);
            end;
        end;
        case PDRAWITEMSTRUCT(lParam).CtlType of
          ODT_MENU :
            begin
              lpdis := Pointer(LParam);
              item := Pointer(lpdis.ItemData);
              if (lpdis.itemState and ODS_SELECTED = ODS_SELECTED) then
              begin
                FillRect(lpdis.hDC, lpdis.rcItem, GetSysColorBrush(COLOR_HIGHLIGHT));
                SetBkMode(lpdis.hDC, TRANSPARENT);
                SetBkColor(lpdis.hDC, GetSysColor(COLOR_HIGHLIGHT));
                SetTextColor(lpdis.hDC, GetSysColor(COLOR_HIGHLIGHTTEXT));
                DrawIconEx(lpdis.hDC, lpdis.rcItem.Left + 2, (lpdis.rcItem.Top + lpdis.rcItem.Bottom - 16) div 2, item.icon, 0, 0, 0, 0, DI_NORMAL);
              end
              else
              begin
                FillRect(lpdis.hDC, lpdis.rcItem, GetSysColorBrush(COLOR_MENU));
                SetBkMode(lpdis.hDC, TRANSPARENT);
                SetBkColor(lpdis.hDC, GetSysColor(COLOR_HIGHLIGHT));
                SetTextColor(lpdis.hDC, GetSysColor(COLOR_MENUTEXT));
                DrawIconEx(lpdis.hDC, lpdis.rcItem.Left + 2, (lpdis.rcItem.Top + lpdis.rcItem.Bottom - 16) div 2, item.icon, 0, 0, 0, 0, DI_NORMAL);
              end;
              if (lpdis.itemState and ODS_GRAYED) <> 0 then
                begin
                  SetBkMode(lpdis.hDC, TRANSPARENT);
                  SetBkColor(lpdis.hDC, GetSysColor(COLOR_GRAYTEXT));
                  SetTextColor(lpdis.hDC, GetSysColor(COLOR_GRAYTEXT));
                end;
              lpdis.rcItem.left := lpdis.rcItem.left + 24;
              DrawText(lpdis.hDC, @item.text[1], - 1, lpdis.rcItem, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
            end;
        end;
      end;

    WM_INITDIALOG :
      begin
        hApp := hWnd;
        ThreadIcon := CreateThread(nil, 0, @SetIconThread, nil, 0, ThreadIdIco);
        // Создаем панель инструментов
        BuildMainToolbar(GetDlgItem(hApp, IDC_TBR_BTNS));
        // Создаем меню для панели инструментов
        BuildMenuToolbar(GetDlgItem(hApp, IDC_TBR_BTNS));
        // Создаем строку состояния и делим ее на 2 части
        GetClientRect(hApp, rc);
        Panels[0] := rc.Right - 145;
        Panels[1] := -1;
        SendMessage(GetDlgItem(hApp, IDC_STB_INFO), SB_SETPARTS, 2, Integer(@Panels));
        MoveWindow(GetDlgItem(hApp, IDC_STB_INFO), 0, 0, rc.Right - rc.Left, 55, TRUE);
        MoveWindow(GetDlgItem(hApp, IDC_STB_INFO), 0, 0, rc.Right - rc.Left, HiWord(lParam), TRUE);
        // Загружаем значок и отображаем его в заголовке диалога
        hIconApp := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONGREX), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        if hIconApp <> 0 then
          SendMessage(hApp, WM_SETICON, ICON_SMALL, hIconApp);
        // Отображаем название приложения в заголовке
        SendMessage(hApp, WM_SETTEXT, 0, Integer(PChar(Format(LoadStr(STR_NAME_APPLIC), [GetVersionInfo(ParamStr(0), sfiFileVersion), RELEASEAPPVERSION]))));
        // Загружаем значки и отображаем их на кнопках
        hIconDlg := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONOPEN), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        SetWindowLong(GetDlgItem(hApp, IDC_BTN_OPEN), GWL_STYLE, GetWindowLong(GetDlgItem(hApp, IDC_BTN_OPEN), GWL_STYLE) or BS_ICON);
        if hIconDlg <> 0 then
          Button_SetImageEx(GetDlgItem(hApp, IDC_BTN_OPEN), hIconDlg, IMAGE_ICON, 16, 16);
        hIconDlg := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONSAVE), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        SetWindowLong(GetDlgItem(hApp, IDC_BTN_SAVE), GWL_STYLE, GetWindowLong(GetDlgItem(hApp, IDC_BTN_SAVE), GWL_STYLE) or BS_ICON);
        if hIconDlg <> 0 then
          Button_SetImageEx(GetDlgItem(hApp, IDC_BTN_SAVE), hIconDlg, IMAGE_ICON, 16, 16);
        // Создаем список адресов шлюзов
        CreateColumnsListview(GetDlgItem(hApp, IDC_LVIEW_IP));
        LoadArrayRoute(GetDlgItem(hApp, IDC_LVIEW_IP));
        // Создаем и применяем шрифты к элементам диалога
        hFontDlg := CreateFont(13, 0, 0, 0, 600, 0, 1, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFontDlg <> 0 then
          SendMessage(GetDlgItem(hApp, IDC_BTN_AUTO), WM_SETFONT, hFontDlg, 0);
        hFontDlg := CreateFont(13, 0, 0, 0, 400, 5, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFontDlg <> 0 then
          SendMessage(GetDlgItem(hApp, IDC_BTN_MODE), WM_SETFONT, hFontDlg, 0);
        // Получаем области координат окна и применяем к диалогу
        GetWindowRect(hApp, Rect);
        SetWindowPos(hApp, 0, 0, 0, Rect.Right - Rect.Left, 230, SWP_NOMOVE);
        // Отображаем сообщение на кнопке
        SendMessage(GetDlgItem(hApp, IDC_BTN_MODE), WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_MODE_EXTEND))));
        // Фокусируем выделение главной кнопки на всякий случай
        SetFocus(GetDlgItem(hApp, IDC_BTN_AUTO));
        // Создаем гиперссылку для обновления списка шлюзов
        hFontNot := CreateFont(-MulDiv(-10, GetDeviceCaps(GetDC(hWnd), LOGPIXELSY), 72), 0, 0, 0, 400, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFontNot <> 0 then
          SetProp(hApp, PROP_NONHOVER, hFontNot);
        SetClassLong(GetDlgItem(hApp, IDC_STAT_RLD), GCL_HCURSOR, LoadCursor(0, IDC_HAND));
        SendMessage(GetDlgItem(hApp, IDC_STAT_RLD), WM_SETFONT, Integer(hFontNot), Integer(TRUE));
        StcWndProc := Pointer(SetWindowLong(GetDlgItem(hApp, IDC_STAT_RLD), GWL_WNDPROC, Integer(@StcWndFunc)));
        // Отображаем путь к сохраняемому файлу в элементе
        SendMessage(GetDlgItem(hApp, IDC_EDT_PATH), WM_SETTEXT, 0, Integer(PChar(ExtractFilePath(ParamStr(0)) + 'MyRoutes.bat')));
        SendMessage(GetDlgItem(hApp, IDC_CHX_CLRT), BM_SETCHECK, BST_CHECKED, 0);
        // Отмечаем самые основные маршруты шлюзов в списке
        for I := 0 to 5 do ListView_SetCheckState(GetDlgItem(hApp, IDC_LVIEW_IP), I, TRUE);
        hFontDlg := CreateFont(12, 0, 0, 0, 400, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFontDlg <> 0 then
          SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETFONT, hFontDlg, 0);
        // Подготавливаем и загружаем значки в строку состояния
        hIconDlg := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONALRT), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        if hIconDlg <> 0 then
          SendMessage(GetDlgItem(hApp, IDC_STB_INFO), SB_SETICON, 0, hIconDlg);
        hIconDlg := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONSLCT), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        if hIconDlg <> 0 then
          SendMessage(GetDlgItem(hApp, IDC_STB_INFO), SB_SETICON, 1, hIconDlg);
        StartCountStatusValues(GetDlgItem(hApp, IDC_STB_INFO), GetDlgItem(hApp, IDC_LVIEW_IP));
        // Перебираем все роутеры и получаем с них IP адреса шлюзов
        GetIpAddressRoute(GetDlgItem(hApp, IDC_LBOX_IPR), GetDlgItem(hApp, IDC_TBR_BTNS), GetDlgItem(hMst, IDC_CMBX_IPR));
        SetForegroundWindow(hApp);
     end;

    WM_CTLCOLORSTATIC :
      begin
        case GetDlgCtrlId(lParam) of
          IDC_STAT_RLD :
            begin
              SetTextColor(DWORD(wParam), RGB(0, 0, 255));
              SetBkColor(DWORD(wParam), GetSysColor(COLOR_BTNFACE));
              Brush := GetSysColorBrush(COLOR_BTNFACE);
              SetProp(hWnd, PROP_BRUSH, Brush);
              Result := BOOL(Brush);
            end
            else
              Result := BOOL(DefWindowProc(hWnd, uMsg, wParam, lParam));
            end;
      end;

    WM_CONTEXTMENU :
      begin
        GetCursorPos(pt);
        GetWindowRect(GetDlgItem(hApp, IDC_LVIEW_IP), Rect);
        if PtInRect(Rect, pt) then
          begin
            SetForegroundWindow(hApp);
            TrackPopupMenu(hSubMenu, TPM_LEFTALIGN or TPM_LEFTBUTTON, pt.X, pt.Y, 0, hApp, nil);
            PostMessage(hApp, WM_NULL, 0, 0);
          end;
      end;
      
    WM_NOTIFY :
      begin
        case PNMToolBar(lParam)^.hdr.code of
          TBN_DROPDOWN :
            begin
              GetWindowRect(GetDlgItem(hApp, IDC_TBR_BTNS), Rect);
              pt.X := Rect.Left + 100;
              pt.Y := Rect.Bottom;
              SetForegroundWindow(hApp);
              TrackPopupMenu(hSubMenu, TPM_LEFTALIGN or TPM_LEFTBUTTON, pt.X, pt.Y, 0, hApp, nil);
              PostMessage(hApp, WM_NULL, 0, 0);
            end;
        end;

        if (PNMHdr(lParam).idFrom = IDC_LVIEW_IP) then
        begin
          case PNMHDR(lParam)^.code of
            LVN_COLUMNCLICK, LVN_ITEMCHANGED :
              begin
                SetActiveControls;
                StartCountStatusValues(GetDlgItem(hApp, IDC_STB_INFO), GetDlgItem(hApp, IDC_LVIEW_IP));
              end;
            NM_DBLCLK : ListView_InvertSelect(GetDlgItem(hApp, IDC_LVIEW_IP));
          end; 
        end; 
      end;

    WM_COMMAND :
      begin
        if HiWord(wParam) = EN_CHANGE then
          SetActiveControls;
        if HiWord(wParam) = BN_CLICKED then
          begin
            case LoWord(wParam) of
              IDC_BTN_SAVE :
                begin
                  if SaveDataToBatFile = TRUE then
                    MessageBox(hApp, PChar(LoadStr(STR_MSGBX_SAVEF)), PChar(LoadStr(STR_MSGBX_INFOR)), MB_ICONINFORMATION);
                end;
              IDC_BTN_AUTO :
                begin
                  SaveDataToBatFile;
                  if ShellExecute(hApp, 'Open', PChar(Edit_GetText(GetDlgItem(hApp, IDC_EDT_PATH))), nil, nil, SW_SHOWNORMAL) < 32 then
                    Exit
                  else
                    MessageBox(hApp, PChar(LoadStr(STR_MSGBX_SAVEF)), PChar(LoadStr(STR_MSGBX_INFOR)), MB_ICONINFORMATION);
                end;
              IDC_TBR_LOAD : DialogBox(hInstance, MAKEINTRESOURCE(RES_DIALOGDW), hApp, @DownDlgProc);
              IDC_TBR_EDIT : ;
              IDC_TBR_TOOL : InitPropertySheetPage(hApp);
              IDC_PMN_CRTE : DialogBox(hInstance, MAKEINTRESOURCE(RES_DIALOGRT), hApp, @AddDlgProc);
              IDC_PMN_EDIT : DialogBox(hInstance, MAKEINTRESOURCE(RES_DIALOGRT), hApp, @EdtDlgProc);
              IDC_PMN_RMVE : DelCheckListButton(GetDlgItem(hApp, IDC_STB_INFO), GetDlgItem(hApp, IDC_LVIEW_IP));
              IDC_BTN_SELT : ListView_SetCheck(GetDlgItem(hApp, IDC_LVIEW_IP), TRUE);
              IDC_BTN_UNST : ListView_SetCheck(GetDlgItem(hApp, IDC_LVIEW_IP), FALSE);
              IDC_BTN_MODE :
                begin
                  GetWindowRect(hApp, Rect);
                  GetWindowRect(GetDlgItem(hApp, IDC_STB_INFO), rc);
                  if SendMessage(GetDlgItem(hApp, IDC_BTN_MODE), BM_GETCHECK, 0, 0) = BST_UNCHECKED then
                    begin
                      SetWindowPos(hApp, 0, 0, 0, Rect.Right - Rect.Left, 230, SWP_NOMOVE);
                      SendMessage(GetDlgItem(hApp, IDC_BTN_MODE), WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_MODE_EXTEND))));
                    end
                  else
                    begin
                      SetWindowPos(hApp, 0, 0, 0, Rect.Right - Rect.Left, rc.Bottom - Rect.Top + 3, SWP_NOMOVE);
                      SendMessage(GetDlgItem(hApp, IDC_BTN_MODE), WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_MODE_SIMPLE))));
                    end;
                end;
              IDC_STAT_RLD : if LinkHover then
                SetActiveControls;
              IDC_BTN_OPEN :
                begin
                  FillChar(FileName, SizeOf(FileName), 0);
                  FillChar(ofn, SizeOf(ofn), 0);
                  ofn.lStructSize := SizeOf(TOpenFileName);
                  ofn.hWndOwner := hApp;
                  ofn.hInstance := hInstance;
                  lstrcpy (FileName, 'MyRoutes.bat') ;
                  ofn.lpstrFilter := PChar(PChar(LoadStr(STR_FILOPEN_BAT)) + #0 + '*.bat' + #0 + PChar(LoadStr(STR_FILOPEN_ALL)) + #0 + '*.*' + #0#0);
                  ofn.lpstrFile := FileName;
                  ofn.lpstrDefExt := PChar('bat');
                  ofn.lpstrInitialDir := PChar(ExtractFilePath(ParamStr(0)));
                  ofn.nMaxFile := MAX_PATH;
                  ofn.lpfnHook := SaveDlgHook;
                  ofn.Flags := OFN_DONTADDTORECENT or OFN_ENABLESIZING or OFN_PATHMUSTEXIST or OFN_LONGNAMES or OFN_EXPLORER or OFN_HIDEREADONLY or OFN_ENABLEHOOK;
                  if GetSaveFileName(ofn) then
                    SendMessage(GetDlgItem(hApp, IDC_EDT_PATH), WM_SETTEXT, 0, Integer(PChar(ofn.lpstrFile)));
                end;
            end;
          end;
      end;

    WM_LBUTTONDOWN :
      begin
        SetCursor(LoadCursor(0, IDC_SIZEALL));
        SendMessage(hApp, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
      end;

    WM_DESTROY, WM_CLOSE :
      begin
        if ThreadIcon <> 0 then
          TerminateThread(ThreadIcon, 0);
        if ThreadIcon <> 0 then
          CloseHandle(ThreadIcon);
        if hIconApp <> 0 then
          DeleteObject(hIconApp);
        if hIconDlg <> 0 then
          DeleteObject(hIconDlg);
        if hFontDlg <> 0 then
          DeleteObject(hFontDlg);
        if hImgList <> 0 then
          DeleteObject(hImgList);
        DeleteObject(GetProp(hApp, PROP_BRUSH));
        RemoveProp(hApp, PROP_BRUSH);
        DeleteObject(GetProp(hApp, PROP_NONHOVER));
        RemoveProp(hApp, PROP_NONHOVER);
        for I := 1 to 3 do if MenuItems[I].icon <> 0 then
          DeleteObject(MenuItems[I].icon);
        if hSubMenu <> 0 then
          DeleteObject(hSubMenu);
        PostQuitMessage(0);
      end;

  else
    Result := FALSE;
  end;
end;

begin
  InitCommonControls;
  DialogBox(hInstance, MakeIntResource(RES_DIALOGEX), 0, @MainDlgProc);
end.
