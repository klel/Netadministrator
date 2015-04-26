{ Функция для обработки диалогового окна добавления маршрута }
function AddDlgProc(hWnd : HWND; uMsg : UINT; wParam : wParam; lParam : lParam) : BOOL; stdcall;
begin
  Result := TRUE;
    case uMsg of

      WM_INITDIALOG :
        begin
          hAdd := hWnd;
          if hIconApp <> 0 then
            SendMessage(hAdd, WM_SETICON, ICON_SMALL, hIconApp);
          SendMessage(hAdd, WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_CPTNDLG_CRT))));
          SendMessage(GetDlgItem(hAdd, IDC_CHX_NTMK), BM_SETCHECK, BST_CHECKED, 0);
          EnableWindow(GetDlgItem(hAdd, IDC_STAT_YSK), FALSE);
          EnableWindow(GetDlgItem(hAdd, IDC_SIP_YMK2), FALSE);
        end;

    WM_COMMAND :
      begin
        if HiWord(wParam) = BN_CLICKED then
          begin
            case LoWord(wParam) of
              IDC_CHX_NTMK :
                begin
                  if SendMessage(GetDlgItem(hAdd, IDC_CHX_NTMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      EnableWindow(GetDlgItem(hAdd, IDC_STAT_YSK), FALSE);
                      EnableWindow(GetDlgItem(hAdd, IDC_SIP_YMK2), FALSE);
                    end
                end;
              IDC_CHX_YSMK :
                begin
                  if SendMessage(GetDlgItem(hAdd, IDC_CHX_YSMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      EnableWindow(GetDlgItem(hAdd, IDC_STAT_YSK), TRUE);
                      EnableWindow(GetDlgItem(hAdd, IDC_SIP_YMK2), TRUE);
                    end;
                end;
              IDC_BTN_ADDM :
                begin
                  if SendMessage(GetDlgItem(hAdd, IDC_CHX_NTMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      if (SysIP32_GetBlank(GetDlgItem(hAdd, IDC_SIP_YMK1)) = TRUE) or
                         (Edit_GetText(GetDlgItem(hAdd, IDC_EDT_NMRT)) = '') then
                        begin
                          MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_NOADD)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
                          Exit;
                        end;
                      lvi.mask := LVIF_TEXT;
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(FALSE), 0);
                      lvi.mask := LVIF_TEXT;
                      lvi.iSubItem := 0;
                      lvi.pszText := PChar( SysIP32_GetText(GetDlgItem(hAdd, IDC_SIP_YMK1)) + Format(' (%s)', [Edit_GetText(GetDlgItem(hAdd, IDC_EDT_NMRT))]) );
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_INSERTITEM, 0, Integer(@lvi));
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(TRUE), 0);
                      GetClientRect(GetDlgItem(hApp, IDC_LVIEW_IP), rc);
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_SETCOLUMNWIDTH, 0, MAKELONG(((rc.Right - rc.Left) - 5), 0));
                    end;
                  if SendMessage(GetDlgItem(hAdd, IDC_CHX_YSMK), BM_GETCHECK, 0, 0) = BST_CHECKED then
                    begin
                      if (SysIP32_GetBlank(GetDlgItem(hAdd, IDC_SIP_YMK1)) = TRUE) or
                         (SysIP32_GetBlank(GetDlgItem(hAdd, IDC_SIP_YMK2)) = TRUE) or
                         (Edit_GetText(GetDlgItem(hAdd, IDC_EDT_NMRT)) = '') then
                        begin
                          MbIserIcon_Error(hApp, PChar(LoadStr(STR_MSGBX_NOADD)), PChar(LoadStr(STR_MSGBX_ERROR)), RES_ICONMSER);
                          Exit;
                        end;
                      lvi.mask := LVIF_TEXT;
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(FALSE), 0);
                      lvi.mask := LVIF_TEXT;
                      lvi.iSubItem := 0;
                      lvi.pszText := PChar( Format('%s mask %s', [SysIP32_GetText(GetDlgItem(hAdd, IDC_SIP_YMK1)), SysIP32_GetText(GetDlgItem(hAdd, IDC_SIP_YMK2))]) + Format(' (%s)', [Edit_GetText(GetDlgItem(hAdd, IDC_EDT_NMRT))]) );
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_INSERTITEM, 0, Integer(@lvi));
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), WM_SETREDRAW, Integer(TRUE), 0);
                      GetClientRect(GetDlgItem(hApp, IDC_LVIEW_IP), rc);
                      SendMessage(GetDlgItem(hApp, IDC_LVIEW_IP), LVM_SETCOLUMNWIDTH, 0, MAKELONG(((rc.Right - rc.Left) - 5), 0));
                    end;
                  SendMessage(hAdd, WM_CLOSE, 0, 0);
                end;
              IDC_BTN_CNSL : SendMessage(hAdd, WM_CLOSE, 0, 0);
            end;
          end;
      end;

      WM_DESTROY, WM_CLOSE : EndDialog(hAdd, 0);

  else
    Result := FALSE;
  end;
end;