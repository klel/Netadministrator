var
  PropPage   : TPropSheetPage;
  APropPage  : Array [0..2] of HPROPSHEETPAGE;
  PropHeader : TPropSheetHeader;
  HeadFont   : hFont;

{ Функция для обработки диалога приветствия мастера }
function IntrDlgProc(hMst : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : BOOL; stdcall;
begin
  Result := TRUE;
  case uMsg of

    WM_INITDIALOG :
      begin
        hMst := hMst;
        //Установка диалога по центру
        CenterWindow(GetParent(hMst));
        // Создаем размер шрифта для элемента
        SendMessage(GetDlgItem(hMst, IDC_STAT_INT), WM_SETFONT, Integer(HeadFont), Integer(TRUE));
      end;

    WM_NOTIFY :
      case PNMHdr(lParam)^.code of

        // Действия при закрытии текущей вкладки
        PSN_KILLACTIVE :
          begin
            // Проверяем отмечены ли чекбоксы для перехода на вкладку
            if (SendMessage(GetDlgItem(hMst, IDC_CHX_MSSR), BM_GETCHECK, 0, 0) = BST_UNCHECKED) and
              (SendMessage(GetDlgItem(hMst, IDC_CHX_MSLR), BM_GETCHECK, 0, 0) = BST_UNCHECKED) then
              begin
                MbIserIcon_Ok(hMst, PChar(LoadStr(STR_MSGBX_ERNXT)), PChar(LoadStr(STR_MSGBX_INFOR)), RES_ICONMSIF);
                SetWindowLong(hMst, DWL_MSGRESULT, Integer(TRUE));
                Result := TRUE;
              end;
          end;

        // Действия при нажатии на кнопку отмены
        PSN_QUERYCANCEL :
          begin
            // Проверяем отмечены ли чекбоксы для перехода на вкладку
            if MbIserIcon_YesNo(hMst, PChar(LoadStr(STR_MSGBX_ENDTL)), PChar(LoadStr(STR_MSGBX_INFOR)), RES_ICONMSYN) = IDNO then
              begin
                SetWindowLong(hMst, DWL_MSGRESULT, Integer(TRUE));
                Result := TRUE;
              end;
          end;

        // Действия при перемещении на следующую страницу
        PSN_WIZNEXT :
          begin
            if SendMessage(GetDlgItem(hMst, IDC_CHX_MSSR), BM_GETCHECK, 0, 0) = BST_CHECKED then
              SendMessage(GetParent(hMst), PSM_SETCURSEL, GetParent(hMst), Integer(APropPage[0]));
            if SendMessage(GetDlgItem(hMst, IDC_CHX_MSLR), BM_GETCHECK, 0, 0) = BST_CHECKED then
              SendMessage(GetParent(hMst), PSM_SETCURSEL, GetParent(hMst), Integer(APropPage[1]));
          end;

        // Действия при инициализации вкладки
        PSN_SETACTIVE :
          begin
            // Активизировать кнопку далее
            SendMessage(GetParent(hMst), PSM_SETWIZBUTTONS, 0, Integer(PSWIZB_NEXT));
          end;

      end;

  else
    Result := FALSE;
  end;
end;

{ Функция для создания столбцов списка граббера маршрутов }
function CreateGrabberListview(hLV : THandle) : Boolean;
begin
  lvc.mask    := LVCF_TEXT or LVCF_WIDTH or LVCF_FMT;
  lvc.fmt     := LVCFMT_CENTER;
  lvc.pszText := '#';
  lvc.cx      := 27;
  SendMessage(hLV, LVM_INSERTCOLUMN, 0, Integer(@lvc));
  lvc.mask    := LVCF_TEXT or LVCF_WIDTH or LVCF_FMT;
  lvc.fmt     := LVCFMT_RIGHT;
  lvc.pszText := PChar(LoadStr(STR_MLIST_ADDRR));
  lvc.cx      := 125;
  SendMessage(hLV, LVM_INSERTCOLUMN, 1, Integer(@lvc));
  lvc.mask    := LVCF_TEXT or LVCF_WIDTH or LVCF_FMT;
  lvc.fmt     := LVCFMT_RIGHT;
  lvc.pszText := PChar(LoadStr(STR_MLIST_MASKR));
  lvc.cx      := 125;
  SendMessage(hLV, LVM_INSERTCOLUMN, 2, Integer(@lvc));
  SendMessage(hLV, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT or LVS_EX_CHECKBOXES or LVS_EX_BORDERSELECT);
  FillChar(BitmapImage, SizeOf(BitmapImage), 0);
  BitmapImage.ulFlags := LVBKIF_SOURCE_HBITMAP or LVBKIF_STYLE_TILE;
  BitmapImage.hbm := LoadImage(hInstance, MAKEINTRESOURCE(IDB_BTMPLIST), IMAGE_BITMAP, 0, 0, LR_DEFAULTSIZE);
  ListView_SetBkImage(hLV, @BitmapImage);
  Result := TRUE;
end;

{ Функция для преобразования IP адреса в строку }
function IpAddrToString(Addr : DWORD) : String;
var
  inad : in_addr;
begin
  inad.s_addr := Addr;
  Result := inet_ntoa(inad);
end;

{ Функция для отображения полученных маршрутов в списке }
function DisplayRoutingTable(hLV : THandle) : Boolean;
var
  ForwardTable : PMibIpForwardTable;
  ForwardRow   : TMibIpForwardRow;
  Dest         : string;
  Size         : ULONG;
  I            : Integer;
  lvi          : TLVItem;
  Destination  : string;
  GateWay      : string;
begin
  LockWindowUpdate(hLV);
  ZeroMemory(@lvi, SizeOf(lvi));
  lvi.mask := LVIF_TEXT;
  SendMessage(hLV, LVM_DELETEALLITEMS, 0, 0);
  Size := 0;
  if not GetIpForwardTable(nil, Size, TRUE) = ERROR_BUFFER_OVERFLOW then
    Exit;
  ForwardTable := AllocMem(Size);
  try
    if GetIpForwardTable(ForwardTable, Size, TRUE) = ERROR_SUCCESS then
    begin
      for I := 0 to ForwardTable^.dwNumEntries - 1 do
      begin
        ForwardRow := ForwardTable^.Table[I];
        Dest := IpAddrToString(ForwardRow.dwForwardDest);
        if ((Destination = '') or (Pos(Destination, Dest) > 0)) and
          ((GateWay = '') or (Pos(GateWay, Dest) > 0)) then
        begin
          lvi.mask     := LVIF_TEXT;
          lvi.iItem    := I;
          lvi.iSubItem := 0;
          lvi.pszText  := '';
          SendMessage(hLV, LVM_INSERTITEM, 0, Integer(@lvi));
          lvi.iSubItem := 1;
          lvi.pszText  := PChar(Format('%17s', [Dest]));
          SendMessage(hLV, LVM_SETITEM, 0, Integer(@lvi));
          lvi.iSubItem := 2;
          lvi.pszText  := PChar(Format('%17s', [IpAddrToString(ForwardRow.dwForwardMask)]));
          SendMessage(hLV, LVM_SETITEM, 0, Integer(@lvi));
        end;
      end;
    end;
  finally
    FreeMem(ForwardTable);
  end;
  LockWindowUpdate(0);
  MessageBeep(MB_ICONASTERISK);
  Result := TRUE;
end;

{ Получение списка системной маршрутизации для сохранения в файл }
function GetSaveFileListRoute(hLV : THandle) : String;
var
  Cnt : Integer;
  Idx : Integer;
  Buf : PChar;
  S   : String;
  P   : String;
begin
  Cnt := SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0);
  GetMem(Buf, 255);
  try
    for Idx := 0 to Cnt - 1 do
      begin
        if ListView_GetCheckState(hLV, Idx) <> 0 then
          begin
            FillChar(lvi, SizeOf(lvi), #0);
            lvi.iItem := Idx;
            lvi.Mask := LVIF_TEXT or LVIF_STATE;
            lvi.iSubItem := 0;
            lvi.pszText := Buf;
            lvi.cchTextMax := 256;
            SendMessage(hLV, LVM_GETITEM, 0, Integer(@lvi));
            S := '';
            lvi.iSubItem := 1;
            SendMessage(hLV, LVM_GETITEM, 0, Integer(@lvi));
            S := S + Buf + '/';
            lvi.iSubItem := 2;
            SendMessage(hLV, LVM_GETITEM, 0, Integer(@lvi));
            S := S + Buf;
            P := StringReplace(S, ' ', '', TRUE);
            Result := Result + P + #13#10;
          end;
      end;
  finally
    FreeMem(Buf, 255);
  end;
end;

{ Сохранение в текстовый конфигурационный файл системной маршрутизации }
function SetSaveFileListRoute(hWnd, hEdt, hLV : Thandle) : Boolean;
var
  F : TextFile;
begin
  AssignFile(F, Edit_GetText(hEdt));
{$I-}
  Rewrite(F);
  if IOResult <> 0 then
    begin
      CloseFile(F);
      MbIserIcon_Error(hWnd, PChar(SysErrorMessage(GetLastError)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
{$I+}
      Result := FALSE;
      Exit;
    end;
  WriteLn(F, GetSaveFileListRoute(hLV));
  try
  finally
    CloseFile(F);
    Result := TRUE;
    MbIserIcon_Ok(hWnd, PChar(LoadStr(STR_MSGBX_SYSRT)), PChar(LoadStr(STR_MSGBX_INFOR)), RES_ICONMSIF);
  end;
end;

{ Функция обработки диалога сохранения маршрутов мастера }
function FrstDlgProc(hMst : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : BOOL; stdcall;
var
  I : Integer;
begin
  Result := FALSE;
  case uMsg of

    WM_INITDIALOG :
      begin
        hMst := hMst;
      end;

    WM_COMMAND :
      begin
        if HiWord(wParam) = EN_CHANGE then
          begin
            if (Edit_GetText(GetDlgItem(hMst, IDC_EDT_MPFS)) = '') then
              EnableWindow(GetDlgItem(hMst, IDC_BTN_MSFR), FALSE)
            else
              EnableWindow(GetDlgItem(hMst, IDC_BTN_MSFR), TRUE);
          end;
        if HiWord(wParam) = BN_CLICKED then
          begin
            case LoWord(wParam) of
              // Отображаем путь сохранения файла
              IDC_BTN_MOFS :
                begin
                  FillChar(FileName, SizeOf(FileName), 0);
                  FillChar(ofn, SizeOf(ofn), 0);
                  ofn.lStructSize := SizeOf(TOpenFileName);
                  ofn.hWndOwner := hMst;
                  ofn.hInstance := hInstance;
                  lstrcpy (FileName, 'MyRoutes.conf') ;
                  ofn.lpstrFilter := PChar(PChar(LoadStr(STR_FILOPEN_CNF)) + #0 + '*.conf' + #0 + PChar(LoadStr(STR_FILOPEN_ALL)) + #0 + '*.*' + #0#0);
                  ofn.lpstrFile := FileName;
                  ofn.lpstrDefExt := PChar('conf');
                  ofn.nMaxFile := MAX_PATH;
                  ofn.lpstrInitialDir := PChar(ExtractFilePath(ParamStr(0)));
                  ofn.lpfnHook := SaveDlgHook;
                  ofn.Flags := OFN_DONTADDTORECENT or OFN_ENABLESIZING or OFN_PATHMUSTEXIST or OFN_LONGNAMES or OFN_EXPLORER or OFN_HIDEREADONLY or OFN_ENABLEHOOK;
                  if GetSaveFileName(ofn) then
                    SendMessage(GetDlgItem(hMst, IDC_EDT_MPFS), WM_SETTEXT, 0, Integer(PChar(ofn.lpstrFile)));
                end;
              // Отображаем список системных маршрутов в списке
              IDC_BTN_MSLR : DisplayRoutingTable(GetdlgItem(hMst, IDC_LVIEW_MS));
              // Выделяем все записи в списке
              IDC_BTN_MSLS : ListView_SetCheck(GetdlgItem(hMst, IDC_LVIEW_MS), TRUE);
              // Не выделяем все записи в списке
              IDC_BTN_MUNS : ListView_SetCheck(GetdlgItem(hMst, IDC_LVIEW_MS), FALSE);
              // Сохраняем в файл записи из списка
              IDC_BTN_MSFR :
                begin
                  if (CheckListEnableButtons(GetdlgItem(hMst, IDC_LVIEW_MS)) = '') then
                    MbIserIcon_Error(hMst, PChar(LoadStr(STR_MSGBX_MSSRT)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER)
                  else
                    SetSaveFileListRoute(hMst, GetDlgItem(hMst, IDC_EDT_MPFS), GetdlgItem(hMst, IDC_LVIEW_MS));
                end;
            end;
          end;
      end;

    WM_NOTIFY :
      case PNMHdr(lParam)^.code of

        // Действия при инициализации вкладки
        PSN_SETACTIVE :
          begin
            // Активизировать кнопки назад и готово
            SendMessage(GetParent(hMst), PSM_SETWIZBUTTONS, 0, Integer(PSWIZB_BACK or PSWIZB_FINISH));
            // Удаляем все строки из списка
            SendMessage(GetdlgItem(hMst, IDC_LVIEW_MS), LVM_DELETEALLITEMS, 0, 0);
            // Создаем колонки для списка маршрутов
            for I := 1 to 3 do
              SendMessage(GetdlgItem(hMst, IDC_LVIEW_MS), LVM_DELETECOLUMN, Integer(0), 0);
            CreateGrabberListview(GetdlgItem(hMst, IDC_LVIEW_MS));
            // Отображаем примерный путь к файлу в контроле
            SendMessage(GetDlgItem(hMst, IDC_EDT_MPFS), WM_SETTEXT, 0, Integer(PChar(ExtractFilePath(ParamStr(0)) + 'MyRoutes.conf')));
          end;

        // Действия при нажатии на кнопку отмены
        PSN_QUERYCANCEL :
          begin
            // Проверяем отмечены ли чекбоксы для перехода на вкладку
            if MbIserIcon_YesNo(hMst, PChar(LoadStr(STR_MSGBX_ENDTL)), PChar(LoadStr(STR_MSGBX_INFOR)), RES_ICONMSYN) = IDNO then
              begin
                SetWindowLong(hMst, DWL_MSGRESULT, Integer(TRUE));
                Result := TRUE;
              end;
          end;

        // Действия при перемещении на предыдущую страницу
        PSN_WIZBACK :
          begin
            SendMessage(GetParent(hMst), PSM_SETCURSEL, GetParent(hMst), Integer(APropPage[0]));
          end;

      end;

  end;
end;

{ Функция для сканирования сохраненных маршрутов в файле }
function GetLoadFileListRoute(hWnd, hEdt, hLV : THandle) : Boolean;
var
  S : String;
  F : TextFile;
  Mask : String;
  Route : String;
  I     : Integer;
  P     : Integer;
begin
  if FileExists(Edit_GetText(hEdt)) = TRUE then
  begin
  LockWindowUpdate(hLV);
  ZeroMemory(@lvi, SizeOf(lvi));
  lvi.mask := LVIF_TEXT;
  SendMessage(hLV, LVM_DELETEALLITEMS, 0, 0);
    AssignFile(F, Edit_GetText(hEdt));
    Reset(F);
    while not EOF(F) do
    begin
      ReadLn(F, S);

      if not(S = '') then
        begin

          P := -1;
          for I := Length(S) downto 1 do
            begin
              if S[I] = '/' then
                begin
                  P := I;
                  Break;
                end;
            end;
          if P <> -1 then
            Mask := Copy(S, P + 1, Length(S));
          Route := S;
          Delete(Route, Length(S) - Length(Mask) , Length(Mask) + 1);

          lvi.mask     := LVIF_TEXT;
        //  lvi.iItem    := I;
          lvi.iSubItem := 0;
          lvi.pszText  := '';
          SendMessage(hLV, LVM_INSERTITEM, 0, Integer(@lvi));
          lvi.iSubItem := 1;
          lvi.pszText  := PChar(Route);
          SendMessage(hLV, LVM_SETITEM, 0, Integer(@lvi));
          lvi.iSubItem := 2;
          lvi.pszText  := PChar(Mask);
          SendMessage(hLV, LVM_SETITEM, 0, Integer(@lvi));
        end;
    end;
    CloseFile(F);
    LockWindowUpdate(0);
    MessageBeep(MB_ICONASTERISK);
    Result := TRUE;
  end
  else
    begin
      Result := TRUE;
      MbIserIcon_Error(hWnd, PChar(LoadStr(STR_MSGBX_ERRDR)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
    end;
end;

{ Получение списка системной маршрутизации для повторного сохранения в файл }
function GetLoadFileListBatRoute(hChx, hCmx, hLV : THandle) : String;
var
  Cnt      : Integer;
  Idx      : Integer;
  Buf      : PChar;
  S        : String;
  FileCrt  : String;
  DateCrt  : String;
  IPStr    : String;
  lSysTime : TSystemTime;
begin
  GetLocalTime(lSysTime);
  FileCrt := Format('This file created by AIST ROUTE %s', [GetVersionInfo(ParamStr(0), sfiFileVersion)]);
  DateCrt := Format('Date of creation : %s / %s', [FormatTime(lSysTime), FormatDate]);
  Result := Result + Format('rem %s', [FileCrt]) + sLineBreak;
  Result := Result + Format('rem %s', [DateCrt]) + sLineBreak;
  IPStr := Cmbx_GetText(hCmx);
  Result := Result + Format('set MyRouter=%s', [IPStr]) + sLineBreak;
  if SendMessage(hChx, BM_GETCHECK, 0, 0) = BST_CHECKED then
    Result := Result + 'route -f print' + sLineBreak;
  Result := Result + 'ipconfig /renew' + sLineBreak;
  Cnt := SendMessage(hLV, LVM_GETITEMCOUNT, 0, 0);
  GetMem(Buf, 255);
  try
    for Idx := 0 to Cnt - 1 do
      begin

        if ListView_GetCheckState(hLV, Idx) <> 0 then
          begin
            FillChar(lvi, SizeOf(lvi), #0);
            lvi.iItem := Idx;
            lvi.Mask := LVIF_TEXT or LVIF_STATE;
            lvi.iSubItem := 0;
            lvi.pszText := Buf;
            lvi.cchTextMax := 256;
            SendMessage(hLV, LVM_GETITEM, 0, Integer(@lvi));
            S := '';
            lvi.iSubItem := 1;
            SendMessage(hLV, LVM_GETITEM, 0, Integer(@lvi));
            S := S + Buf + ' mask ';
            lvi.iSubItem := 2;
            SendMessage(hLV, LVM_GETITEM, 0, Integer(@lvi));
            S := 'route -p add ' + S + Buf + ' %MyRouter%';
            Result := Result + S + #13#10;
          end;
      end;
  finally
    FreeMem(Buf, 255);
  end;
  Result := Result + 'route print' + sLineBreak;
  Result := Result + Format('rem %s', ['Thank you for using this software :)']) + sLineBreak;
  Result := Result + 'pause';
end;

{ Сохранение в пакетный файл список системной маршрутизации }
function SetLoadFileListRoute(hWnd, hChx, hCmx, hLV : Thandle) : Boolean;
var
  F : TextFile;
begin
  if FileExists(ExtractFilePath(ParamStr(0)) + 'MyTempRoutes.bat') = TRUE
    then DeleteFile(PChar(ExtractFilePath(ParamStr(0)) + 'MyTempRoutes.bat'));
  AssignFile(F, PChar(ExtractFilePath(ParamStr(0)) + 'MyTempRoutes.bat'));
{$I-}
  Rewrite(F);
  if IOResult <> 0 then
    begin
      CloseFile(F);
      MbIserIcon_Error(hWnd, PChar(SysErrorMessage(GetLastError)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
{$I+}
      Result := FALSE;
      Exit;
    end;
  WriteLn(F, GetLoadFileListBatRoute(hChx, hCmx, hLV));
  try
  finally
    CloseFile(F);
    Result := TRUE;
    MessageBeep(MB_ICONASTERISK);
  end;
end;

{ Функция обработки диалога загрузки маршрутов мастера }
function ScndDlgProc(hMst : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : BOOL; stdcall;
var
  hCbxWnd  : THandle;
  hCbxIcon : Integer;
  hCbxDC   : HDC;
  CbxRect  : TRect;
  CbxPC    : Array [0..$400] of Char;
  I        : Integer;
begin
  Result := FALSE;
  case uMsg of

    WM_INITDIALOG :
      begin
        hMst := hMst;
        SendMessage(GetDlgItem(hMst, IDC_CHX_MSRF), BM_SETCHECK, BST_CHECKED, 0);
      end;

    WM_MEASUREITEM :
      begin
        case wParam of
          IDC_CMBX_IPR :
            begin
              with PMEASUREITEMSTRUCT(lParam)^ do
                begin
                  itemHeight := 18;
                end;
              end;
            end;
      end;

    WM_DRAWITEM :
      begin
        case wParam of
          IDC_CMBX_IPR :
            begin
              hCbxWnd := PDRAWITEMSTRUCT(lParam).hwndItem;
              CbxRect := PDRAWITEMSTRUCT(lParam).rcItem;
              hCbxDC := PDRAWITEMSTRUCT(lParam).hDC;
              if (Integer(PDRAWITEMSTRUCT(lParam).ItemID) > - 1) then
                begin
                  hCbxIcon := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONCMBX), IMAGE_ICON, 16, 16, 0);
                  if ((PDRAWITEMSTRUCT(lParam).itemState and ODS_SELECTED) <> 0) then
                    begin
                      FillRect(hCbxDC, CbxRect, GetSysColorBrush(COLOR_HIGHLIGHT));
                      SetBkColor(hCbxDC, GetSysColor(COLOR_HIGHLIGHT));
                      SetTextColor(hCbxDC, GetSysColor(COLOR_HIGHLIGHTTEXT));
                    end
                  else
                    begin
                      FillRect(hCbxDC, CbxRect, GetSysColorBrush(COLOR_WINDOW));
                      SetBkColor(hCbxDC, GetSysColor(COLOR_WINDOW));
                      SetTextColor(hCbxDC, GetSysColor(COLOR_WINDOWTEXT));
                    end;
                  DrawIconEx(hCbxDC, CbxRect.Left + 2, CbxRect.Top + 1, hCbxIcon, 16, 16, 0, 0, DI_NORMAL);
                  CbxRect.Left := CbxRect.Left + 22;
                  SendMessage(hCbxWnd, CB_GETLBTEXT, PDRAWITEMSTRUCT(lParam).ItemID, LongInt(@CbxPC[0]));
                  DrawText(hCbxDC, @CbxPC[0], - 1, CbxRect, DT_SINGLELINE or DT_VCENTER);
                  DeleteObject(hCbxIcon);
                end;
              ReleaseDC(hCbxWnd, hCbxDC);
            end;
        end;
      end;

    WM_COMMAND :
      begin
        if HiWord(wParam) = EN_CHANGE then
          begin
            if (Edit_GetText(GetDlgItem(hMst, IDC_EDT_MPFL)) = '') then
              begin
                EnableWindow(GetDlgItem(hMst, IDC_BTN_MLLR), FALSE);
                EnableWindow(GetDlgItem(hMst, IDC_BTN_MLFR), FALSE);
              end
            else
              begin
                EnableWindow(GetDlgItem(hMst, IDC_BTN_MLLR), TRUE);
                EnableWindow(GetDlgItem(hMst, IDC_BTN_MLFR), TRUE);
              end;
          end;
        if HiWord(wParam) = BN_CLICKED then
          begin
            case LoWord(wParam) of
              // Отображаем путь сохранения файла
              IDC_BTN_MOFL :
                begin
                  FillChar(FileName, SizeOf(FileName), 0);
                  FillChar(ofn, SizeOf(ofn), 0);
                  ofn.lStructSize := SizeOf(TOpenFileName);
                  ofn.hWndOwner := hMst;
                  ofn.hInstance := hInstance;
                  lstrcpy (FileName, 'MyRoutes.conf') ;
                  ofn.lpstrFilter := PChar(PChar(LoadStr(STR_FILOPEN_CNF)) + #0 + '*.conf' + #0 + PChar(LoadStr(STR_FILOPEN_ALL)) + #0 + '*.*' + #0#0);
                  ofn.lpstrFile := FileName;
                  ofn.lpstrDefExt := PChar('conf');
                  ofn.lpstrInitialDir := PChar(ExtractFilePath(ParamStr(0)));
                  ofn.nMaxFile := MAX_PATH;
                  ofn.lpfnHook := OpenDlgHook;
                  ofn.Flags := OFN_DONTADDTORECENT or OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST or OFN_LONGNAMES or OFN_EXPLORER or OFN_HIDEREADONLY or OFN_ENABLEHOOK or OFN_ENABLESIZING;
                  if GetOpenFileName(ofn) then
                    SendMessage(GetDlgItem(hMst, IDC_EDT_MPFL), WM_SETTEXT, 0, Integer(PChar(ofn.lpstrFile)));
                end;
              // Отображаем список системных маршрутов в списке
              IDC_BTN_MLLR : GetLoadFileListRoute(hMst, GetDlgItem(hMst, IDC_EDT_MPFL), GetdlgItem(hMst, IDC_LVIEW_ML));
              // Выделяем все записи в списке
              IDC_BTN_MSLL : ListView_SetCheck(GetdlgItem(hMst, IDC_LVIEW_ML), TRUE);
              // Не выделяем все записи в списке
              IDC_BTN_MUNL : ListView_SetCheck(GetdlgItem(hMst, IDC_LVIEW_ML), FALSE);
              // Сохраняем в файл записи из списка
              IDC_BTN_MLFR :
                begin
                  if (CheckListEnableButtons(GetDlgItem(hMst, IDC_LVIEW_ML)) = '') or (FileExists(Edit_GetText(GetDlgItem(hMst, IDC_EDT_MPFL))) = FALSE) then
                    MbIserIcon_Error(hMst, PChar(LoadStr(STR_MSGBX_MSSRT)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER)
                  else
                    begin
                      // Сохраняем пакетный файл
                      SetLoadFileListRoute(hMst, GetDlgItem(hMst, IDC_CHX_MSRF), GetDlgItem(hMst, IDC_CMBX_IPR), GetDlgItem(hMst, IDC_LVIEW_ML));
                      // Запускаем пакетный файл
                    if ShellExecute(hMst, 'Open', PChar(ExtractFilePath(ParamStr(0)) + 'MyTempRoutes.bat'), nil, nil, SW_SHOWNORMAL) < 32 then
                      Exit
                    else
                      MbIserIcon_Ok(hMst, PChar(LoadStr(STR_MSGBX_SAVEF)), PChar(LoadStr(STR_MSGBX_INFOR)), RES_ICONMSIF);
                      // Удаляем пакетный файл
                      if FileExists(ExtractFilePath(ParamStr(0)) + 'MyTempRoutes.bat') = TRUE then
                        DeleteFile(PChar(ExtractFilePath(ParamStr(0)) + 'MyTempRoutes.bat'));
                    end;
                end;
            end;
          end;
      end;

    WM_NOTIFY :
      case PNMHdr(lParam)^.code of

        // Действия при инициализации вкладки
        PSN_SETACTIVE :
          begin
            // Активизировать кнопки назад и готово
            SendMessage(GetParent(hMst), PSM_SETWIZBUTTONS, 0, Integer(PSWIZB_BACK or PSWIZB_FINISH));
            // Удаляем все строки из списка
            SendMessage(GetdlgItem(hMst, IDC_LVIEW_ML), LVM_DELETEALLITEMS, 0, 0);
            // Создаем колонки для списка маршрутов
            for I := 1 to 3 do
              SendMessage(GetdlgItem(hMst, IDC_LVIEW_ML), LVM_DELETECOLUMN, Integer(0), 0);
            CreateGrabberListview(GetdlgItem(hMst, IDC_LVIEW_ML));
            // Очистить содержимое комбобокса
            SendMessage(GetDlgItem(hMst, IDC_CMBX_IPR), CB_RESETCONTENT, 0, 0);
            // Добавление списка шлюзов
            GetIpAddressRoute(GetDlgItem(hApp, IDC_LBOX_IPR), GetDlgItem(hApp, IDC_TBR_BTNS), GetDlgItem(hMst, IDC_CMBX_IPR));
            // Установка положения в комбобоксе на первую позицию
            SendMessage(GetDlgItem(hMst, IDC_CMBX_IPR), CB_SETCURSEL, 0, 0);
            // Отображаем примерный путь к файлу в контроле
            SendMessage(GetDlgItem(hMst, IDC_EDT_MPFL), WM_SETTEXT, 0, Integer(PChar(ExtractFilePath(ParamStr(0)) + 'MyRoutes.conf')));
          end;

        // Действия при нажатии на кнопку отмены
        PSN_QUERYCANCEL :
          begin
            // Проверяем отмечены ли чекбоксы для перехода на вкладку
            if MbIserIcon_YesNo(hMst, PChar(LoadStr(STR_MSGBX_ENDTL)), PChar(LoadStr(STR_MSGBX_INFOR)), RES_ICONMSYN) = IDNO then
              begin
                SetWindowLong(hMst, DWL_MSGRESULT, Integer(TRUE));
                Result := TRUE;
              end;
          end;

        // Действия при перемещении на предыдущую страницу
        PSN_WIZBACK :
          begin
            SendMessage(GetParent(hMst), PSM_SETCURSEL, GetParent(hMst), Integer(APropPage[0]));
          end;

      end;

  end;
end;

{ Функция обработки инициализации диалогов мастера }
function InitPropertySheetPage(hWnd : HWND) : Boolean;
begin
  // Создаем страницы для блокнота
  PropPage.dwSize            := SizeOf(PropPage);
  PropPage.dwFlags           := PSP_USETITLE or PSP_HIDEHEADER;
  PropPage.pszTitle          := PChar(Format(LoadStr(STR_MASTER_CAPT), [GetVersionInfo(ParamStr(0), sfiProductName)]));
  PropPage.hInstance         := hInstance;
  PropPage.pfnDlgProc        := @IntrDlgProc;
  PropPage.pszTemplate       := MAKEINTRESOURCE(RES_DIALOGIN);
  APropPage[0]               := CreatePropertySheetPage(PropPage);
  // Инициализация первой страницы
  PropPage.dwFlags           := PSP_USETITLE or PSP_USEHEADERTITLE or PSP_USEHEADERSUBTITLE;
  PropPage.pszTitle          := PChar(Format(LoadStr(STR_MASTER_CAPT), [GetVersionInfo(ParamStr(0), sfiProductName)]));
  PropPage.pszHeaderTitle    := PChar(LoadStr(STR_MASTER_HDFT));
  PropPage.pszHeaderSubTitle := PChar(LoadStr(STR_MASTER_STFT));
  PropPage.pszTemplate       := MAKEINTRESOURCE(RES_DIALOGFT);
  PropPage.pfnDlgProc        := @FrstDlgProc;
  APropPage[1]               := CreatePropertySheetPage(PropPage);
  // Инициализация второй страницы
  PropPage.dwFlags           := PSP_USETITLE or PSP_USEHEADERTITLE or PSP_USEHEADERSUBTITLE;
  PropPage.pszTitle          := PChar(Format(LoadStr(STR_MASTER_CAPT), [GetVersionInfo(ParamStr(0), sfiProductName)]));
  PropPage.pszHeaderTitle    := PChar(LoadStr(STR_MASTER_HDSD));
  PropPage.pszHeaderSubTitle := PChar(LoadStr(STR_MASTER_STSD));
  PropPage.pszTemplate       := MAKEINTRESOURCE(RES_DIALOGSD);
  PropPage.pfnDlgProc        := @ScndDlgProc;
  APropPage[2]               := CreatePropertySheetPage(PropPage);
  // Создаем заготовку для стиля
  HeadFont                  := CreateFont(18, 0, 0, 0, 800, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
  ZeroMemory(@PropHeader, SizeOf(PropHeader));
  PropHeader.dwSize          := SizeOf(PropHeader);
  PropHeader.hInstance       := hInstance;
  PropHeader.hwndParent      := hWnd;
  PropHeader.phpage          := @APropPage[0];
  PropHeader.nStartPage      := 0;
  PropHeader.nPages          := Length(APropPage);
  PropHeader.pszbmWatermark  := MAKEINTRESOURCE(IDB_WTMKHEAD);
  PropHeader.pszbmHeader     := MAKEINTRESOURCE(IDB_BTMPHEAD);
  PropHeader.dwFlags         := PSH_WIZARD97 or PSH_WATERMARK or PSH_HEADER or PSH_USEICONID;
  PropHeader.pszIcon         := MAKEINTRESOURCE(RES_ICONTOOL);
  // Отображаем страницу
  PropertySheet(PropHeader);
  // Удаляем все созданные объекты
  if HeadFont <> 0
    then DeleteObject(HeadFont);
  Result := TRUE;
end;
