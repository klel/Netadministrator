{ Проверяем содержится ли в строке адрес с маской подсети }
function CheckGetListRoute(StrPrs : String) : Boolean;
var
  I     : Integer;
  P     : Integer;
  Domen : String;
  Route : String;
begin
  Result := FALSE;
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
  // Приравниваем полученный результат как бы к начальной строке
  // Теперь проходимся по всей строке и если длина адреса больше 13 символов, значит результат true
  if Length(Route) > 13 then Result := TRUE;
end;

{ Обрабатываем строку для отображения только адреса и названия }
function ParserStringGetListRoute1(StrPrs : String; hSys, hEdt : THandle) : Boolean;
var
  Domen : String;
  Route : String;
  I     : Integer;
  P     : Integer;
  Temp  : String;
begin
  Result := FALSE;

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

  // Приравниваем начальную строку в строке маршрута
  Route := StrPrs;

  // Удаляем название из строки, включая 2 последних символа (две скобки из маршрута)
  Delete(Route, Length(StrPrs) - Length(Domen) - 1, Length(Domen) + 2);

  // Выводим полученные результаты в элементы управления
  SysIP32_SetText(hSys, PChar(Route));

  // Получаем точный адрес первого адреса для дальнейшего подсчета его длины
  Temp := SysIP32_GetText(hSys);

  // Выводим в первый контрол точный адрес
  SysIP32_SetText(hSys, PChar(Temp));

  // Выводим в третий контрол точное название
  SendMessage(hEdt, WM_SETTEXT, 0, Integer(PChar(Domen)));

  Result := TRUE;
end;

{ Обрабатываем строку для отображения адреса, маски и названия }
function ParserStringGetListRoute2(StrPrs : String; hSys1, hSys2, hEdt : THandle) : Boolean;
var
  Domen  : String;
  Route1 : String;
  Route2 : String;
  I      : Integer;
  P      : Integer;
  Temp   : String;
begin
  Result := FALSE;

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

  // Приравниваем начальную строку в строке маршрута
  Route1 := StrPrs;

  // Удаляем название из строки, включая 2 последних символа (две скобки из маршрута)
  Delete(Route1, Length(StrPrs) - Length(Domen) - 1, Length(Domen) + 2);

  // Выводим полученные результаты в элементы управления
  SysIP32_SetText(hSys1, PChar(Route1));

  // Получаем точный адрес первого адреса для дальнейшего подсчета его длины
  Temp := SysIP32_GetText(hSys1);
  // Копируем с заданной позиции (число символов адреса + 1 для смещения + 6 для длины слова " mask ")
  Route2 := Copy(Route1, (Length(Temp) + 1) + 6, Length(Route1));

  // Выводим в первый контрол точный адрес
  SysIP32_SetText(hSys1, PChar(Temp));
  // Выводим во второй контрол точный адрес
  SysIP32_SetText(hSys2, PChar(Route2));
  // Выводим в третий контрол точное название
  SendMessage(hEdt, WM_SETTEXT, 0, Integer(PChar(Domen)));

  Result := TRUE;
end;

{ Функция для удаления текущей строки в списке }
function DeleteStringList(hLst : HWND) : Boolean;
var
  idx : Integer;
  row : Integer;
begin
  idx := SendMessage(hLst, LVM_GETSELECTIONMARK, 0, 0);
  if idx > -1 then
    begin
      FillChar(lvi, sizeof(lvi), #0);
      lvi.iItem := SendMessage(hLst, LVM_GETNEXTITEM, -1, LVNI_FOCUSED);
    end;
  row := SendMessage(hLst, LVM_GETNEXTITEM, -1, LVNI_SELECTED);
  SendMessage(hLst, LVM_DELETEITEM, lvi.iItem, 0);
  Result := TRUE;
end;

{ Функция для обработки диалогового окна изменения маршрута }
function EdtDlgProc(hWnd : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : BOOL; stdcall;
var
  idx : Integer;
begin
  Result := TRUE;
    case uMsg of

      WM_INITDIALOG :
        begin
          hEdt := hWnd;
          if hIconApp <> 0 then
            SendMessage(hEdt, WM_SETICON, ICON_SMALL, hIconApp);
          SendMessage(hEdt, WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_CPTNDLG_EDT))));
          idx := SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_GETNEXTITEM, -1, LVNI_FOCUSED);
          if idx = -1 then
            begin
              SendMessage(hEdt, WM_CLOSE, 0, 0);
              MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_EDTRW)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
            end
          else
            begin
            // Если строка выделена в списке, проверяем маршрут на наличие адреса с маской
            // Если маршрут без маски, то отмечаем нужный чекбокс и запрещаем элемент
            // Если маршрут с маской, то отмечаем нужный чекбокс
              if CheckGetListRoute(ListView_GetItemText(GetDlgItem(hApp, IDC_LVIEW_IP), idx)) = FALSE then
                begin
                  // Если адрес без маски - отмечаем первый чекбокс, запрещаем контролы и выводим данные
                  ParserStringGetListRoute1(ListView_GetItemText(GetDlgItem(hApp, IDC_LVIEW_IP), idx), GetDlgItem(hEdt, IDC_SIP_YMK1), GetDlgItem(hEdt, IDC_EDT_NMRT));
                  SendMessage(GetDlgItem(hEdt, IDC_CHX_NTMK), BM_SETCHECK, BST_CHECKED, 0);
                  EnableWindow(GetDlgItem(hEdt, IDC_STAT_YSK), FALSE);
                  EnableWindow(GetDlgItem(hEdt, IDC_SIP_YMK2), FALSE);
                end
              else
                begin
                  // Если адрес без маски - отмечаем первый чекбокс, запрещаем контролы и выводим данные
                  ParserStringGetListRoute2(ListView_GetItemText(GetDlgItem(hApp, IDC_LVIEW_IP), idx), GetDlgItem(hEdt, IDC_SIP_YMK1), GetDlgItem(hEdt, IDC_SIP_YMK2), GetDlgItem(hEdt, IDC_EDT_NMRT));
                  SendMessage(GetDlgItem(hEdt, IDC_CHX_YSMK), BM_SETCHECK, BST_CHECKED, 0);
                end;
            end;
        end;

    WM_COMMAND :
      begin
        if HiWord(wParam) = BN_CLICKED then
          begin
            case LoWord(wParam) of
              IDC_CHX_NTMK :
                begin
                  if SendMessage(GetDlgItem(hEdt, IDC_CHX_NTMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      EnableWindow(GetDlgItem(hEdt, IDC_STAT_YSK), FALSE);
                      EnableWindow(GetDlgItem(hEdt, IDC_SIP_YMK2), FALSE);
                    end
                end;
              IDC_CHX_YSMK :
                begin
                  if SendMessage(GetDlgItem(hEdt, IDC_CHX_YSMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      EnableWindow(GetDlgItem(hEdt, IDC_STAT_YSK), TRUE);
                      EnableWindow(GetDlgItem(hEdt, IDC_SIP_YMK2), TRUE);
                    end;
                end;
              IDC_BTN_ADDM :
                begin
                  if SendMessage(GetDlgItem(hEdt, IDC_CHX_NTMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      if (SysIP32_GetBlank(GetDlgItem(hEdt, IDC_SIP_YMK1)) = TRUE) or
                         (Edit_GetText(GetDlgItem(hEdt, IDC_EDT_NMRT)) = '') then
                        begin
                          MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_NOADD)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
                          Exit;
                        end;
                      DeleteStringList(GetDlgItem(hApp, IDC_LVIEW_IP));
                      lvi.mask := LVIF_TEXT;
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(FALSE), 0);
                      lvi.mask := LVIF_TEXT;
                      lvi.iSubItem := 0;
                      lvi.pszText := PChar( SysIP32_GetText(GetDlgItem(hEdt, IDC_SIP_YMK1)) + Format(' (%s)', [Edit_GetText(GetDlgItem(hEdt, IDC_EDT_NMRT))]) );
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_INSERTITEM, 0, Integer(@lvi));
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(TRUE), 0);
                      GetClientRect(GetDlgItem(hApp, IDC_LVIEW_IP), rc);
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_SETCOLUMNWIDTH, 0, MAKELONG(((rc.Right - rc.Left) - 5), 0));
                    end;
                  if SendMessage(GetDlgItem(hEdt, IDC_CHX_YSMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      if (SysIP32_GetBlank(GetDlgItem(hEdt, IDC_SIP_YMK1)) = TRUE) or
                         (SysIP32_GetBlank(GetDlgItem(hEdt, IDC_SIP_YMK2)) = TRUE) or
                         (Edit_GetText(GetDlgItem(hEdt, IDC_EDT_NMRT)) = '') then
                        begin
                          MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_NOADD)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
                          Exit;
                        end;
                      DeleteStringList(GetDlgItem(hApp, IDC_LVIEW_IP));  
                      lvi.mask := LVIF_TEXT;
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(FALSE), 0);
                      lvi.mask := LVIF_TEXT;
                      lvi.iSubItem := 0;
                      lvi.pszText := PChar( Format('%s mask %s', [SysIP32_GetText(GetDlgItem(hEdt, IDC_SIP_YMK1)), SysIP32_GetText(GetDlgItem(hEdt, IDC_SIP_YMK2))]) + Format(' (%s)', [Edit_GetText(GetDlgItem(hEdt, IDC_EDT_NMRT))]) );
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_INSERTITEM, 0, Integer(@lvi));
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(TRUE), 0);
                      GetClientRect(GetDlgItem(hApp, IDC_LVIEW_IP), rc);
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_SETCOLUMNWIDTH, 0, MAKELONG(((rc.Right - rc.Left) - 5), 0));
                    end;
                  SendMessage(hEdt, WM_CLOSE, 0, 0);
                end;
              IDC_BTN_CNSL : SendMessage(hEdt, WM_CLOSE, 0, 0);
            end;
          end;
      end;

      WM_DESTROY, WM_CLOSE : EndDialog(hEdt, 0);

  else
    Result := FALSE;
  end;
end;