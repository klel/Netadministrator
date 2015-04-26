unit Pfield;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Registry, IniFiles, Designer, Menus, ExtDlgs;

type
  TnwMap = class(TForm)
    Image1: TImage;
    SwMenu1: TPopupMenu;
    N1: TMenuItem;
    PCMenu2: TPopupMenu;
    N2: TMenuItem;
    OpenPic: TOpenPictureDialog;
    procedure CreateImg (dev:byte;str:string;name:string);
    procedure CreateForm(Sender: TObject);
    procedure OnMouseDownSw(Sender: TObject; Button: TMouseButton;
       Shift: TShiftState; X, Y: Integer);
    procedure OnMouseDownPc(Sender: TObject; Button: TMouseButton;
       Shift: TShiftState; X, Y: Integer);
    procedure OnMove (Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure MouseUpToSw(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    //procedure CloseForm(Sender: TObject; var Action: TCloseAction);
    procedure MouseUpToPc(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure designact(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SaveSatt(Sender: TObject);
    procedure CloseForm (Sender: TObject; var Action: TCloseAction);
    procedure DeleteSw(Sender: TObject);
    procedure DeletePc(Sender: TObject);
    procedure UtpPaintDwn(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UtpPaintMv(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure UtpPaintUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    i: integer;       // counter for swiches
  end;
type
  lapPC= (lap,comp);


const
  maxcolSw=50;
  maxcolPc=150;
  INI_NAME= 'Data.ini';
var
  nwMap: TnwMap;
  swArray:array [1..maxcolSw] of TImage;
  pcArray:array [1..maxcolPc] of TImage;
  colSw,colPc,colText:integer;
  Ini:TiniFile;
  x0,y0,fx,fy,stx,sty: integer;
  pnt:TPoint;
  move:boolean;
  but:TShiftState;
  textcount:integer;
  rec:TRect;
  laptop:lapPC;
  pc:integer;       // counter for pc's
  Design:TDesigner;
  swtag:byte;         //////for deleting
  pctag:byte;         ///////swiches and pc's - contain tags of sender objects
implementation

uses Ptool;
{$R *.dfm}

procedure line(x1,y1,x2,y2:integer);
begin
with nwMap.Image1.Canvas do
 begin
  Pen.Color:=clRed;
  Pen.Width:=2;
  moveto(x1,y1);
  lineto(x2,y2);
 end;
end;

function  LtopOrPc:string;
begin

end;

procedure TnwMap.OnMouseDownSw (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);

begin

  if nwTools.CheckBox1.Checked then
        Design.Active:=True
      else
      Design.Active:=False;
      if button<>mbLeft then
       begin
         move:=false;
         SwMenu1.Popup(nwMap.Left+x,nwMap.Top+y);
         swtag:=swArray[TImage(Sender).Tag].Tag;

       end
        else begin
           move:=true;
           x0:=x;
           y0:=y;
           case TImage(Sender).Tag of
           1..maxcolSw: begin
                    rec:=swArray[TImage(Sender).Tag].BoundsRect;
                    Canvas.Pen.Color:=clRed;
                    if nwTools.CheckBox2.Checked then
                        Canvas.Brush.Style:=bsClear
                    else Canvas.Brush.Style:=bsSolid;
                      Canvas.Rectangle(rec);
                      NwMap.Canvas.DrawFocusRect(rec);
                  end;
           end;
//ShowMessage (IntToStr(TImage(Sender).Tag));
     end;
end;


procedure TnwMap.OnMouseDownPc (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);

begin

  if nwTools.CheckBox1.Checked then
        Design.Active:=True
      else
      Design.Active:=False;
      if button<>mbLeft then
        begin
          move:=false;
          PCMenu2.Popup(nwMap.Left+x,nwMap.Top+y);
          pctag:=pcArray[TImage(Sender).Tag].Tag;
        end
        else begin
           move:=true;
           x0:=x;
           y0:=y;
           case TImage(Sender).Tag of
           1..maxcolPc: begin
                    rec:=pcArray[TImage(Sender).Tag].BoundsRect;
                    Canvas.Pen.Color:=clRed;
                    if nwTools.CheckBox2.Checked then
                        Canvas.Brush.Style:=bsClear
                    else Canvas.Brush.Style:=bsSolid;
                    Canvas.Rectangle(rec);
                    NwMap.Canvas.DrawFocusRect(rec);
                  end;
           end;
//ShowMessage (IntToStr(TImage(Sender).Tag));
     end;
end;

procedure TnwMap.OnMove (Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
   if nwTools.CheckBox1.Checked then
        Design.Active:=True
      else
      Design.Active:=False;
if move then
    begin
      NwMap.Canvas.DrawFocusRect(rec); //рисуем рамку
      with rec do
        begin
          left:=Left+x-x0;
          top:=Top+y-y0;
          right:=right+x-x0;
          bottom:=bottom+y-y0;
          x0:=x;
          y0:=y; // изменяем координаты
        end;
      NwMap.Canvas.DrawFocusRect(rec); // рисуем рамку на новом месте
    end;
end;

procedure TnwMap.MouseUpToSw(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
    if nwTools.CheckBox1.Checked then
        Design.Active:=True
      else
      Design.Active:=False;
  NwMap.Canvas.DrawFocusRect(rec);
  with swArray[TImage(Sender).Tag] do
    begin
       setbounds(rec.left+x-x0,rec.top+y-y0,width,height); //перемещаем картинку
       move:=false;

    end;
end;

procedure TnwMap.MouseUpToPc(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
    if nwTools.CheckBox1.Checked then
        Design.Active:=True
      else
      Design.Active:=False;
  Canvas.DrawFocusRect(rec);
  with pcArray[TImage(Sender).Tag] do
    begin
       setbounds(rec.left+x-x0,rec.top+y-y0,width,height); //перемещаем картинку
       move:=false;
    end;
end;

procedure TnwMap.CloseForm(Sender: TObject; var Action: TCloseAction);
begin
    nwTools.Close;
end;

procedure TnwMap.SaveSatt(Sender: TObject);
var j:integer;
begin
//////////////Save Settings///////////////////////////
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  colSw:=ini.ReadInteger('ColSwiches','Col',0);
  colPc:= ini.ReadInteger('ColPc','Col',0);
  for j := 1 to colSw do
    begin
       ini.WriteInteger('Swich'+IntToStr(j),'Height',swArray[j].Height);
       ini.WriteInteger('Swich'+IntToStr(j),'Width',swArray[j].Width);
       ini.WriteInteger('Swich'+IntToStr(j),'Left',swArray[j].Left);
       ini.WriteInteger('Swich'+IntToStr(j),'Top',swArray[j].Top);
       ini.WriteString('Swich'+IntToStr(j),'Name',swArray[j].Name);
       ini.WriteInteger('Swich'+IntToStr(j),'Tag',swArray[j].Tag);
       SwArray[j].Free;
    end;
  for j := 1 to colPc do
    begin
       ini.WriteInteger('PC'+IntToStr(j),'Height',pcArray[j].Height);
       ini.WriteInteger('PC'+IntToStr(j),'Width',pcArray[j].Width);
       ini.WriteInteger('PC'+IntToStr(j),'Left',pcArray[j].Left);
       ini.WriteInteger('PC'+IntToStr(j),'Top',pcArray[j].Top);
       ini.WriteString('PC'+IntToStr(j),'Name',pcArray[j].Name);
       ini.WriteInteger('PC'+IntToStr(j),'Tag',pcArray[j].Tag);
       pcArray[j].Free;
    end;
  if OpenPic.FileName>'' then
  ini.WriteString ('Map','Picture',OpenPic.FileName);
  ini.WriteInteger('Map','Left',Image1.Left);
  ini.WriteInteger('Map','Top',Image1.top);
  ini.Free;
  nwTools.Close;
end;



procedure TnwMap.UtpPaintDwn(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
colText:=ini.ReadInteger('ColText','Col',0);
if nwTools.SpeedButton4.Down then
   begin
     if ssLeft in shift then
        begin
          nwMap.image1.Canvas.Pen.Mode:= pmnotXOR;
          fx:=x;
          fy:=y;
          stx:=x;sty:=y;
          but:=[ssleft];
        end;
   end
   else if nwTools.SpeedButton6.Down then
      begin
        colText:=colText+1;
        nwMap.image1.Canvas.Font.Color:=clGreen;
        nwMap.image1.Canvas.TextOut(X,Y,nwTools.Edit1.Text);
        ini.WriteInteger ('ColText','Col',colText);
        ini.WriteString ('Text'+IntToStr(colText),'Text',nwTools.Edit1.Text);
        ini.WriteInteger ('Text'+IntToStr(colText),'X',X);
        ini.WriteInteger ('Text'+IntToStr(colText),'Y',Y);
      end;
ini.Free;
end;

procedure TnwMap.UtpPaintMv(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if nwTools.SpeedButton4.Down then
   begin
      if ssLeft in shift then
       begin
         line(fx,fy,stx,sty);
         line(fx,fy,x,y);
         stx:=x;sty:=y;
       end;
      Image1.Canvas.MoveTo(x,y);
   end;
end;

procedure TnwMap.UtpPaintUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if nwTools.SpeedButton4.Down then
   begin
    image1.Canvas.Pen.Mode:= pmcopy;
    if ssleft in but then
      line(fx,fy,stx,sty);
   end;
end;

procedure TnwMap.CreateForm(Sender: TObject);
var
  j:integer;
  x,y:integer;
  text:string;
begin
  {try
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_LOCAL_MACHINE;
    reg.OpenKey('software\diploma\',false);
    colSw:=reg.ReadInteger('ColSwiches')
  except
    ShowMessage ('Ошибка доступа к реестру');
    reg.Free;
  end;
   //ShowMessage (IntToStr (colSw));
   reg.CloseKey;
   reg.Free;}
   randomize;
   //////////////Load Settings////////////////
   ///
   try
     try
   Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
   colSw:=ini.ReadInteger('ColSwiches','Col',0);
   colPc:= ini.ReadInteger('ColPc','Col',0);
   colText:=ini.ReadInteger('ColText','Col',0);
   Image1.Picture.LoadFromFile(ini.ReadString('Map','Picture','./pic/testmap.bmp'));
   Image1.Left:=ini.ReadInteger('Map','Left',0);
   Image1.Top:=ini.ReadInteger('Map','Top',0);
   finally
   for j := 1 to colSw do
     begin
        swArray[j]:= TImage.Create(nwMap);
        swArray[j].Parent:= nwMap;
        swArray[j].Height:=ini.ReadInteger('Swich'+IntToStr(j),'Height',100);
        swArray[j].Width:=ini.ReadInteger('Swich'+IntToStr(j),'Width',100);
        swArray[j].Left:=ini.ReadInteger('Swich'+IntToStr(j),'Left',50+random(50));
        swArray[j].Top:=ini.ReadInteger('Swich'+IntToStr(j),'Top',50+random(50));
        swArray[j].Name:=ini.ReadString('Swich'+IntToStr(j),'Name','Swich'+inttostr(j));
        swArray[j].Tag:=ini.ReadInteger('Swich'+IntToStr(j),'Tag',j);
        swArray[j].ShowHint:=True;
        swArray[j].Hint:='name of swich is- '+swArray[j].Name;
        swArray[j].Autosize:=True;
        swArray[j].PopupMenu:=SwMenu1;
        swArray[j].OnMouseDown:=OnMouseDownSw;
        swArray[j].OnMouseMove:=OnMove;
        swArray[j].OnMouseUp:=MouseUpToSw;
        swArray[j].Picture.LoadFromFile('.\pic\swch2.bmp');
     end;
   for j := 1 to colPc do
     begin
        pcArray[j]:= TImage.Create(nwMap);
        pcArray[j].Parent:= nwMap;
        pcArray[j].Height:=ini.ReadInteger('PC'+IntToStr(j),'Height',100);
        pcArray[j].Width:=ini.ReadInteger('PC'+IntToStr(j),'Width',100);
        pcArray[j].Left:=ini.ReadInteger('PC'+IntToStr(j),'Left',50+random(50));
        pcArray[j].Top:=ini.ReadInteger('PC'+IntToStr(j),'Top',50+random(50));
        pcArray[j].Name:=ini.ReadString('PC'+IntToStr(j),'Name','PC'+inttostr(j));
        pcArray[j].Tag:=ini.ReadInteger('PC'+IntToStr(j),'Tag',j);
        pcArray[j].ShowHint:=True;
        pcArray[j].Hint:='name of pc is- '+pcArray[j].Name;
        pcArray[j].Autosize:=True;
        pcArray[j].PopupMenu:=PCMenu2;
        pcArray[j].OnMouseDown:=OnMouseDownPc;
        pcArray[j].OnMouseMove:=OnMove;
        pcArray[j].OnMouseUp:=MouseUpToPc;
        if pcArray[j].Name='Note'+IntToStr(j) then
              pcArray[j].Picture.LoadFromFile('.\pic\ltop2.bmp')
              else if pcArray[j].Name='PC'+IntToStr(j) then
                pcArray[j].Picture.LoadFromFile('.\pic\pc2.bmp')

     end;
nwMap.image1.Canvas.Font.Color:=clGreen;
   for j := 1 to ColText do
     begin
        x:=ini.ReadInteger ('Text'+IntToStr(j),'X',0);
        y:=ini.ReadInteger ('Text'+IntToStr(j),'Y',0);
        text:=ini.ReadString ('Text'+IntToStr(j),'Text','default text');
        nwMap.image1.Canvas.TextOut(X,Y,text);
     end;
     ini.Free;
     Design:=TDesigner.Create(Self);
     DoubleBuffered:=True;
   end;
   except
     ShowMessage ('Ошибка работы с ini- файлом.Проверьте пути.');
   end;
end;

procedure TnwMap.CreateImg (dev:byte;str:string;name:string);   //dev 10- swich; 20- comp; 30- note
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  colSw:=ini.ReadInteger('ColSwiches','Col',0);
  colPc:=ini.ReadInteger('ColPc','Col',0);
  case dev of
  10: begin
        if (ColSw<maxColSw) and (colPc<maxcolPc) then
          begin
             i:= colSw+1;
             swArray[i]:= TImage.Create(self);
             swArray[i].Parent:= self;
             swArray[i].Height:=100;
             swArray[i].Width:=100;
             swArray[i].Left:=50+random(50);
             swArray[i].Top:=50+random(50);
             swArray[i].Name:=name+intToStr(i);
             swArray[i].Tag:=i;
             swArray[i].ShowHint:=True;
             swArray[i].Hint:='name of swich is-'+swArray[i].Name;
             swArray[i].Autosize:=True;
             swArray[i].PopupMenu:=SwMenu1;
             swArray[i].OnMouseDown:=OnMouseDownSw;
             swArray[i].OnMouseMove:=OnMove;
             swArray[i].OnMouseUp:=MouseUpToSw;
             //ShowMessage(inttostr(i));
             swArray[i].Picture.LoadFromFile(str);
             ini.WriteInteger('ColSwiches','Col',i);
             ini.Free;
          end
            else
               ShowMessage('Слишком много устройств в сети!Проверьте количество устройств! ');
        end;

  20: begin
        if (ColSw<maxColSw) and (colPc<maxcolPc) then
          begin
             laptop:=comp;
             //ShowMessage(laptop);
             pc:= colPc+1;
             pcArray[pc]:= TImage.Create(self);
             pcArray[pc].Parent:= self;
             pcArray[pc].Height:=100;
             pcArray[pc].Width:=100;
             pcArray[pc].Left:=50+random(50);
             pcArray[pc].Top:=50+random(50);
             pcArray[pc].Name:=name+intToStr(pc);
             pcArray[pc].Tag:=pc;
             pcArray[pc].ShowHint:=True;
             pcArray[pc].Hint:='name of PC is-'+pcArray[pc].Name;
             pcArray[pc].Autosize:=True;
             pcArray[pc].PopupMenu:=PCMenu2;
             pcArray[pc].OnMouseDown:=OnMouseDownPc;
             pcArray[pc].OnMouseMove:=OnMove;
             pcArray[pc].OnMouseUp:=MouseUpToPc;
             //ShowMessage(inttostr(i));
             pcArray[pc].Picture.LoadFromFile(str);
             ini.WriteInteger('ColPc','Col',pc);
             ini.Free;
          end
            else
              ShowMessage('Слишком много устройств в сети!Проверьте количество устройств! ');
     end;
  30: begin
        if (ColSw<maxColSw) and (colPc<maxcolPc) then
          begin
             pc:= colPc+1;
             pcArray[pc]:= TImage.Create(self);
             pcArray[pc].Parent:= self;
             pcArray[pc].Height:=100;
             pcArray[pc].Width:=100;
             pcArray[pc].Left:=50+random(50);
             pcArray[pc].Top:=50+random(50);
             pcArray[pc].Name:=name+intToStr(pc);
             pcArray[pc].Tag:=pc;
             pcArray[pc].ShowHint:=True;
             pcArray[pc].Hint:='name of PC is-'+pcArray[pc].Name;
             pcArray[pc].Autosize:=True;
             pcArray[pc].PopupMenu:=PCMenu2;
             pcArray[pc].OnMouseDown:=OnMouseDownPc;
             pcArray[pc].OnMouseMove:=OnMove;
             pcArray[pc].OnMouseUp:=MouseUpToPc;
            // ShowMessage(BooltoStr(laptop));
             pcArray[pc].Picture.LoadFromFile(str);
             ini.WriteInteger('ColPc','Col',pc);
             ini.Free;
          end
            else
              ShowMessage('Слишком много устройств в сети!Проверьте количество устройств! ');
  end;
 end;
end;

procedure TnwMap.DeletePc(Sender: TObject);
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  colPc:=ini.ReadInteger('ColPc','Col',0);
  pcArray[pcTag].Visible:=false;
  colPc:=colPc-1;
  //ShowMessage (swArray[swTag].Name);
  ini.EraseSection ('PC'+intToStr (pcTag));
  ini.WriteInteger('ColPc','Col',colPc);
 // ShowMessage ('Erased');
  ini.Free;
end;

procedure TnwMap.DeleteSw(Sender: TObject);
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  colSw:=ini.ReadInteger('ColSwiches','Col',0);
  swArray[swTag].Visible:=false;
  colSw:=colSw-1;
  //ShowMessage (swArray[swTag].Name);
  ini.EraseSection ('Swich'+intToStr (swTag));
  ini.WriteInteger('ColSwiches','Col',colSw);
 // ShowMessage ('Erased');
  ini.Free;
end;

procedure TnwMap.designact(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  j:integer;
  r:integer;
begin
   if nwTools.CheckBox1.Checked then
      begin
        for j:=1 to colSw do
          begin
            swArray[j].OnMouseMove:=nil;
            swArray[j].OnMouseUp:=nil;
            swArray[j].OnMouseDown:=nil;
        end;
        Design.Active:=True;
      end
      else
        begin
          Design.Active:=False;
          for j:=1 to colSw do
           begin
            swArray[j].OnMouseMove:=OnMove;
            swArray[j].OnMouseUp:=MouseUpToSw;
            swArray[j].OnMouseDown:=OnMouseDownSw;
           end;
         end;
   if nwTools.CheckBox1.Checked then
      begin
        for r:=1 to colPc do
          begin
            pcArray[r].OnMouseMove:=nil;
            pcArray[r].OnMouseUp:=nil;
            pcArray[r].OnMouseDown:=nil;
        end;
        Design.Active:=True;
      end
      else
        begin
          Design.Active:=False;
            for r:=1 to colPc do
             begin
               pcArray[r].OnMouseMove:=OnMove;
               pcArray[r].OnMouseUp:=MouseUpToPc;
               pcArray[r].OnMouseDown:=OnMouseDownPc;
           end;
         end;
end;

procedure TnwMap.FormShow(Sender: TObject);
var
    hwndHandle: THANDLE;
  hMenuHandle: HMENU;
  iPos: integer;
  //reg:TRegistry;
begin

 hwndHandle:=FindWindow(nil,PChar(''));
  if hwndHandle<>0 then
     begin
       hMenuHandle:=GetSystemMenu(hwndHandle,false);
       if hMenuHandle<>0 then
         begin
           DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
           iPos:=GetMenuItemCount(hMenuHandle);
           dec(iPos);
           if iPos > -1 then // Проверяем, что нет ошибки
           DeleteMenu(hMenuHandle, iPos, MF_BYPOSITION);
         end
     end;
end;

end.


