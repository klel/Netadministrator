const
  { Идентификаторы диалогов для программы }
  RES_DIALOGEX                   = 101;
  RES_DIALOGDW                   = 102;
  RES_DIALOGRT                   = 103;
  RES_DIALOGIN                   = 104;
  RES_DIALOGFT                   = 105;
  RES_DIALOGSD                   = 106;

  { Идентификаторы значков для программы }
  RES_ICONGREX                   = 101;
  RES_ICONOPEN                   = 102;
  RES_ICONSAVE                   = 103;
  RES_ICONDOWN                   = 104;
  RES_ICONHELP                   = 105;
  RES_ICONALRT                   = 106;
  RES_ICONSLCT                   = 107;
  RES_ICONDWLD                   = 108;
  RES_ICONEDTR                   = 109;
  RES_ICONTOOL                   = 110;
  RES_ICONLOAD                   = 111;
  RES_ICONEDIT                   = 112;
  RES_ICONRMVE                   = 113;
  RES_ICONCMBX                   = 114;
  RES_ICONMSYN                   = 115;
  RES_ICONMSIF                   = 116;
  RES_ICONMSER                   = 117;

  { Идентификаторы картинок для программы }
  IDB_WTMKHEAD                   = 101;
  IDB_BTMPHEAD                   = 102;
  IDB_BTMPLIST                   = 103;

  { Идентификаторы главного диалогового окна программы }
  IDC_LBOX_IPR                   = 101;
  IDC_STAT_RLD                   = 102;
  IDC_CHX_CLRT                   = 103;
  IDC_BTN_AUTO                   = 104;
  IDC_BTN_MODE                   = 105;
  IDC_TBR_BTNS                   = 106;
  IDC_LVIEW_IP                   = 107;
  IDC_BTN_SELT                   = 108;
  IDC_BTN_UNST                   = 109;
  IDC_EDT_PATH                   = 110;
  IDC_BTN_OPEN                   = 111;
  IDC_BTN_SAVE                   = 112;
  IDC_STB_INFO                   = 113;

  { Идентификаторы диалогового окна загрузки маршрутов }
  IDC_PBR_INFO                   = 121;

  { Идентификаторы диалогового окна добавления/изменения }
  IDC_CHX_NTMK                   = 131;
  IDC_CHX_YSMK                   = 132;
  IDC_SIP_YMK1                   = 133;
  IDC_STAT_YSK                   = 134;
  IDC_SIP_YMK2                   = 135;
  IDC_EDT_NMRT                   = 136;
  IDC_BTN_ADDM                   = 137;
  IDC_BTN_CNSL                   = 138;

  { Идентификаторы диалоговых окон помощника }
  IDC_STAT_INT                   = 141;
  IDC_CHX_MSSR                   = 142;
  IDC_CHX_MSLR                   = 143;

  IDC_EDT_MPFS                   = 151; // Поле для ввода пути к файлу
  IDC_BTN_MOFS                   = 152; // Кнопка для выбора пути к файлу
  IDC_LVIEW_MS                   = 153; // Идентификатор списка маршрутов
  IDC_BTN_MSLR                   = 154; // Кнопка для сканирования маршрутов
  IDC_BTN_MSLS                   = 155; // Кнопка для выделения всех записей
  IDC_BTN_MUNS                   = 156; // Кнопка для невыделения всех записей
  IDC_BTN_MSFR                   = 157; // Кнопка для сохранения файла с записями

  IDC_EDT_MPFL                   = 161; // Поле для ввода пути к файлу
  IDC_BTN_MOFL                   = 162; // Кнопка для выбора пути к файлу
  IDC_LVIEW_ML                   = 163; // Идентификатор списка маршрутов
  IDC_BTN_MLLR                   = 164; // Кнопка для сканирования маршрутов
  IDC_BTN_MSLL                   = 165; // Кнопка для выделения всех записей
  IDC_BTN_MUNL                   = 166; // Кнопка для невыделения всех записей
  IDC_CHX_MSRF                   = 167; // Чекбокс очистки маршрутов
  IDC_CMBX_IPR                   = 168; // Комбобокс со списком адресов шлюзов
  IDC_BTN_MLFR                   = 169; // Кнопка для загрузки записей из файла

  { Идентификаторы кнопок панели инструментов }
  IDC_TBR_LOAD                   = 201; // Загрузка маршрутов
  IDC_TBR_EDIT                   = 202; // Появление всплывающего меню
  IDC_TBR_TOOL                   = 203; // Открытие помощника

  { Идентификаторы пунктов меню }
  IDC_PMN_CRTE                   = 191; // Добавление нового маршрута
  IDC_PMN_EDIT                   = 192; // Изменение текущего маршрута
  IDC_PMN_RMVE                   = 193; // Удаление текущего маршрута

  MAX_ADAPTER_NAME_LENGTH        = 256;
  MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
  MAX_ADAPTER_ADDRESS_LENGTH     = 8;
  PROP_BRUSH                     = 'Brush';
  PROP_NONHOVER                  = 'NonHover';
  PROP_YESHOVER                  = 'YesHover';

  DOWNLOADFILENAME               = 'Routes.txt';
  RELEASEAPPVERSION              = 'RC4';

  STR_MSGBX_ABOUT = 1600;
  STR_MSGBX_NMAPP = 1601;
  STR_MSGBX_VERSN = 1602;
  STR_MSGBX_WARNG = 1603;
  STR_MSGBX_COPRT = 1604;
  STR_MSGBX_BUILD = 1605;
  STR_NAME_APPLIC = 1606;
  STR_MODE_SIMPLE = 1607;
  STR_MODE_EXTEND = 1608;
  STR_MSGBX_ERROR = 1609;
  STR_MSGBX_NOADD = 1610;
  STR_MSGBX_INFOR = 1611;
  STR_MSGBX_SAVEF = 1612;
  STR_FILOPEN_BAT = 1613;
  STR_MSGBX_NOSRV = 1614;
  STR_MSGBX_ROUTE = 1615;
  STR_LOAD_NUMRTE = 1616;
  STR_LOAD_SELRTE = 1617;
  STR_ROUTE_FALSE = 1618;
  STR_MSGBX_FREEW = 1619;
  STR_UPDATE_WAIT = 1620;
  STR_TOLBAR_LOAD = 1621;
  STR_TOLBAR_EDIT = 1622;
  STR_TOLBAR_HELP = 1623;
  STR_FILOPEN_ALL = 1624;
  STR_MSGBX_DELRW = 1625;
  STR_CPTNDLG_CRT = 1626;
  STR_CPTNDLG_EDT = 1627;
  STR_MSGBX_EDTRW = 1628;
  STR_MSGBX_ERNXT = 1629;
  STR_MSGBX_ENDTL = 1630;
  STR_MASTER_CAPT = 1631;
  STR_MASTER_HDFT = 1632;
  STR_MASTER_STFT = 1633;
  STR_MASTER_HDSD = 1634;
  STR_MASTER_STSD = 1635;
  STR_MENU_CREATE = 1636;
  STR_MENU_CHANGE = 1637;
  STR_MENU_DELETE = 1638;
  STR_MLIST_ADDRR = 1639;
  STR_MLIST_MASKR = 1640;
  STR_FILOPEN_CNF = 1641;
  STR_MSGBX_MSSRT = 1642;
  STR_MSGBX_SYSRT = 1643;
  STR_MSGBX_ERRDR = 1644;
