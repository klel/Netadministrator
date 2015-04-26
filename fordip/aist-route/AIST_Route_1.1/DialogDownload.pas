{ Загрузка и подсчет количества строчек в скачанном файле }
function GetCountRoutesServer : Integer;
var
  S : String;
  F : TextFile;
  P : String;
  I : Integer;
begin
  I := 0;
  if FileExists(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME) = TRUE then
  begin
    AssignFile(F, ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME);
    Reset(F);
    while not EOF(F) do
    begin
      ReadLn(F, S);
      P := PChar(@S[1]);
      if not((P = '')) then
        Inc(I);
    end;
    CloseFile(F);
  end;
  Result := I;
end;

{ Загрузка и обработка текстовых данных из скачанного файла с сервера }
function LoadRoutesServer(hPgs, hLV : THandle) : Boolean;
var
  S : String;
  F : TextFile;
  P : String;
  I : Integer;
begin
  I := 0;
  if FileExists(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME) = TRUE then
  begin
    SendMessage(hPgs, PBM_SETRANGE, 0, MAKELONG(0, GetCountRoutesServer));
    EnableWindow(hLV, FALSE);
    Sleep(5);
    SendMessage(hLV, LVM_DELETEALLITEMS, 0, 0);
    AssignFile(F, ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME);
    Reset(F);
    lvi.mask := LVIF_TEXT;
    while not EOF(F) do
    begin
      ReadLn(F, S);
      lvi.iSubItem := 0;
      P := PChar(@S[1]);
      if not((P = '')) then
        begin
          Inc(I);
          SendMessage(hPgs, PBM_SETPOS, I, 0);
          lvi.pszText := PChar(ParserServerFileRead(P));
          SendMessage(hLV, LVM_INSERTITEM, 0, Integer(@lvi));
          // Отмечаем чекбоксы строк, читая параметр из строки
          if ParserServerFileCheck(PChar(@S[1])) = TRUE then
            ListView_SetCheckState(hLV, lvi.iItem - 1, TRUE);
          GetClientRect(hLV, rc);
          SendMessage(hLV, LVM_SETCOLUMNWIDTH, 0, MAKELONG(((rc.Right - rc.Left) - 5), 0));
          SendMessage(hLV, LVM_SCROLL, 0, 35);
        end;
      // Усыпляем программу для наглядности добавления маршрутов в список
      Sleep(5);
    end;
    CloseFile(F);
    Sleep(5);
    EnableWindow(hLV, TRUE);
  end;
  Result := TRUE;
end;

function DownloadThread : Integer;
var
  S : String;
  F : TextFile;
begin
  Result := 0;
  // Удаляем за собой загруженный файл
  if FileExists(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME) = TRUE
    then DeleteFile(PChar(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME));
  // Начинаем загрузку файла с маршрутами
  S := GetInetFile('http://aisty.net.ru/AIST_ROUTE/routes.conf');
  // Проверяем длинну символов в файле
  if Length(S) < 3 then
    begin
      Sleep(50);
      // Удаляем за собой загруженный файл
      if FileExists(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME) = TRUE
        then DeleteFile(PChar(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME));
      SendMessage(hDwn, WM_CLOSE, 0, 0);
      MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_NOSRV)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
    end
  else
    begin
      Sleep(50);
      // Если все успешно, то записываем полученные данные в файл
      AssignFile(F, ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME);
      {$I-}
      Rewrite(F);
      {$I+}
      WriteLn(F, S);
      CloseFile(F);
      Sleep(50);
      // Считываем значения маршрутов из файла
      LoadRoutesServer(GetDlgItem(hDwn, IDC_PBR_INFO), GetDlgItem(hApp, IDC_LVIEW_IP));
      Sleep(50);
      // Удаляем за собой загруженный файл
      if FileExists(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME) = TRUE
        then DeleteFile(PChar(ExtractFilePath(ParamStr(0)) + DOWNLOADFILENAME));
      SendMessage(hDwn, WM_CLOSE, 0, 0);
      MbIserIcon_Ok(hApp, PChar(LoadStr(STR_MSGBX_ROUTE)), PChar(LoadStr(STR_MSGBX_INFOR)), RES_ICONMSIF);
    end;
  ExitThread(0);  
  CurThread := 0;
end;

{ Функция для обработки диалогового окна загрузки файла }
function DownDlgProc(hWnd : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : BOOL; stdcall;
var
  WinDC       : hDC;
  PaintDC     : TPaintStruct;
  RndBrushNew : hBrush;
  RndBrushOld : hBrush;
  RndPenNew   : hPen;
  RndPenOld   : hPen;
  WinRegion   : hRgn;
  WinDCIcon   : hIcon;
  WinDCFont   : hFont;
begin
  Result := TRUE;
    case uMsg of

      WM_INITDIALOG :
        begin
          hDwn := hWnd;
          // Создаем округлые края у диалогового окна путем применения региона
          GetWindowRect(hDwn, rc);
          WinRegion := CreateRoundRectRgn(0, 0, rc.Right - rc.Left + 1, rc.Bottom - rc.Top + 1, 4, 4);
          SetWindowRgn(hDwn, WinRegion, TRUE);
          SetWindowLong(GetDlgItem(hDwn, IDC_PBR_INFO), GWL_STYLE, GetWindowLong(GetDlgItem(hDwn, IDC_PBR_INFO), GWL_STYLE));
          // Запускаем функцию загрузки файла в отдельном потоке
          if CurThread <> 0 then
            CloseHandle(CurThread);
          CurThread := BeginThread(nil, 0, @DownloadThread, nil, 0, ThreadIdDwn);
        end;

    WM_PAINT :
      begin
        GetClientRect(hDwn, rc);
        WinDC := BeginPaint(hDwn, PaintDC);
        RndBrushNew := CreateHatchBrush(HS_BDIAGONAL, RGB(0, 255, 255));
        RndBrushOld := SelectObject(WinDC, RndBrushNew);
        RndPenNew := CreatePen(PS_SOLID, 1, RGB(0, 0, 255));
        RndPenOld := SelectObject(WinDC, RndPenNew);
        RoundRect(WinDC, 0, 0, rc.Right - rc.Left, rc.Bottom - rc.Top, 6, 6);
        SelectObject(WinDC, RndBrushOld);
        DeleteObject(RndBrushNew);
        SelectObject(WinDC, RndPenOld);
        DeleteObject(RndPenNew);
        WinDCIcon := LoadImage(hInstance, MAKEINTRESOURCE(RES_ICONDOWN), IMAGE_ICON, 32, 32, LR_DEFAULTSIZE);
        DrawIconEx(WinDC, rc.Left + 12, rc.Top + 12, WinDCIcon, 32, 32, 0, 0, DI_NORMAL);
        rc.Left := rc.Left + 45;
        rc.Right := rc.Right - 10;
        rc.Top := rc.Top + 8;
        rc.Bottom := rc.Bottom - 10;
        SetBkMode(WinDC, TRANSPARENT);
        SetTextColor(WinDC, RGB(255, 0, 0));
        WinDCFont := CreateFont(13, 0, 0, 0, 600, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        SelectObject(WinDC, WinDCFont);
        DrawText(WinDC, PChar(LoadStr(STR_UPDATE_WAIT)), -1, rc, DT_CENTER or DT_WORDBREAK or DT_VCENTER);
        DeleteObject(WinDCIcon);
        DeleteObject(WinDCFont);
        EndPaint(hDwn, PaintDC);
    end;

      WM_DESTROY, WM_CLOSE :
        begin
          if CurThread <> 0 then
            CloseHandle(CurThread);
          if hIconDlg <> 0 then
            DeleteObject(hIconDlg);
          DeleteObject(WinRegion);
          EndDialog(hDwn, 0);
      end;

  else
    Result := FALSE;
  end;
end;