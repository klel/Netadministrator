var
  hApp          : THandle;
  hAdd          : THandle;
  hEdt          : THandle;
  hDwn          : THandle;
  hMst          : THandle;
  hFontYes      : hFont;
  hFontNot      : hFont;
  LinkHover     : Boolean = FALSE;
  StcWndProc    : Pointer;
  Brush         : hBrush;
  TME           : TTrackMouseEvent;
  hFontDlg      : hFont;
  hIconApp      : hIcon;
  hIconDlg      : hIcon;
  hHeadFont     : hFont;
  lvc           : TLVColumn;
  rc            : Trect;
  lvi           : TLVItem;
  ofn           : TOpenFilename;
  FileName      : Array [0..MAX_PATH - 1] of Char;
  ArrayRoute    : Array [1..6] of PChar = ( '172.16.0.0 mask 255.240.0.0 (Ёлит 2.0)',
                                         '10.0.0.0 mask 255.0.0.0 (Ethernet дл€ дома)',
                                         '192.168.0.0 mask 255.255.255.0 (Wi-Fi)',
                                         '81.28.160.111 (irc.avtograd.ru)',
                                         '81.28.160.25 (aist2.mytlt.ru)',
                                         '195.144.200.10 (radio.avtograd.ru)' );
  tbButtons  : Array [0..6] of TTBButton =
  (
  (iBitmap : 0; idCommand : 0; fsState : TBSTATE_ENABLED; fsStyle : BTNS_SEP; iString : -1;),
  (iBitmap : 1; idCommand : IDC_TBR_LOAD; fsState : TBSTATE_ENABLED; fsStyle : BTNS_BUTTON or BTNS_SHOWTEXT or BTNS_AUTOSIZE; iString : 0),
  (iBitmap : 0; idCommand : 0; fsState : TBSTATE_ENABLED; fsStyle : BTNS_SEP; iString : -1;),
  (iBitmap : 2; idCommand : IDC_TBR_EDIT; fsState : TBSTATE_ENABLED; fsStyle : BTNS_BUTTON or BTNS_SHOWTEXT or BTNS_AUTOSIZE or TBSTYLE_DROPDOWN or TBSTYLE_EX_DOUBLEBUFFER; iString : 1),
  (iBitmap : 0; idCommand : 0; fsState : TBSTATE_ENABLED; fsStyle : BTNS_SEP; iString : -1;),
  (iBitmap : 3; idCommand : IDC_TBR_TOOL; fsState : TBSTATE_ENABLED; fsStyle : BTNS_BUTTON or BTNS_SHOWTEXT or BTNS_AUTOSIZE; iString : 2),
  (iBitmap : 0; idCommand : 0; fsState : TBSTATE_ENABLED; fsStyle : BTNS_SEP; iString : -1;)
  );
  DlgStyles     : Array [0..4] of Integer = ( ODM_VIEW_ICONS,
                                              ODM_VIEW_LIST,
                                              ODM_VIEW_DETAIL,
                                              ODM_VIEW_THUMBS,
                                              ODM_VIEW_TILES );
  hImgList      : hImageList;
  MenuItems     : Array [1..3] of TMenuItem;
  hSubMenu      : hMenu;
  ThreadIdDwn   : Cardinal;
  CurThread     : DWORD = 0;
  ThreadIcon    : THandle;
  ThreadIdIco   : Cardinal;
  BitmapImage   : TLVBKIMAGE;
