unit BitBtnVCL;

interface

uses
  Windows, Messages, CommCtrl;

function  Button_SetImageEx(hBtn : HWND; Image : HGDIOBJ; ImageType, Width, Height : Integer) : Integer;

implementation

function  Button_SetImageEx(hBtn : HWND; Image : HGDIOBJ; ImageType, Width, Height : Integer) : Integer;
const
  BCM_FIRST                     = $1600;
  BCM_SETIMAGELIST              = $0002;

  BUTTON_IMAGELIST_ALIGN_LEFT   = 0;
  BUTTON_IMAGELIST_ALIGN_RIGHT  = 1;
  BUTTON_IMAGELIST_ALIGN_TOP    = 2;
  BUTTON_IMAGELIST_ALIGN_BOTTOM = 3;
  BUTTON_IMAGELIST_ALIGN_CENTER = 4;

type
 TButtonImageList = record
   ImgLst : HIMAGELIST;    // Нормальное, Наведенное, Нажатое, Отключенное, Сфокусированное
   margin : TRect;         // Отступы
   uAlign : DWORD;         // Выравнивание
 end;

var
   hIconBlend:HICON;
   bi : TButtonImageList;

begin
  Result := 0;
  if not (ImageType in [IMAGE_BITMAP, IMAGE_ICON]) then Exit;

  ZeroMemory(@bi, SizeOf(bi));

  bi.ImgLst := ImageList_Create(Width, Height, ILC_COLOR32 or ILC_MASK, 4, 0);
  bi.margin.Left := 1;
  bi.uAlign := BUTTON_IMAGELIST_ALIGN_LEFT;

  if (ImageType = IMAGE_BITMAP) then
    begin
     ImageList_Add(bi.ImgLst, Image, 0);   // Normal
     ImageList_Add(bi.ImgLst, Image, 0);   // hot
     ImageList_Add(bi.ImgLst, Image, 0);   // pushed
    end
  else
    begin
     ImageList_AddIcon(bi.ImgLst, Image);   // Normal
     ImageList_AddIcon(bi.ImgLst, Image);   // hot
     ImageList_AddIcon(bi.ImgLst, Image);   // pushed
    end;

  // Отключенное
  hIconBlend := ImageList_GetIcon(bi.ImgLst, 0, ILD_BLEND50 or ILD_TRANSPARENT);
  ImageList_AddIcon(bi.ImgLst, hIconBlend);
  DestroyIcon(hIconBlend);

  // Сфокусированное
  if (ImageType = IMAGE_BITMAP) then
    ImageList_Add(bi.ImgLst, Image, 0)
  else
    ImageList_AddIcon(bi.ImgLst, Image);

  Result := SendMessage(hBtn, BCM_FIRST + BCM_SETIMAGELIST, 0, lParam(@bi));
  if (Result = 0) then
    begin
      ImageList_Destroy(bi.ImgLst);
      Result := SendMessage(hBtn, BM_SETIMAGE, ImageType, Image)
    end;
end;

end.