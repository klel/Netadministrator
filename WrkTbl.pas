unit WrkTbl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IniFiles, DB, DBClient, Menus, StdCtrls, Buttons, jpeg;
const
  maxcolSw=30;
  maxcolPc=150;
  INI_NAME='Data.ini';

type
  TMain = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    SwMenu1: TPopupMenu;
    PCMenu2: TPopupMenu;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Ping1: TMenuItem;
    N1: TMenuItem;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox1: TGroupBox;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn7: TBitBtn;
    BitBtn3: TBitBtn;
    procedure CreateFrm(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure OnMouseDownSw (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
    procedure OnMouseDownPc (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
    procedure MouseUnderSw (Sender: TObject);
    procedure MouseLeaveSw (Sender: TObject);
    procedure MouseUnderPc (Sender: TObject);
    procedure MouseLeavePc (Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure MouseSwCl(Sender: TObject);
    procedure MousePcCl(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Ping1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
  swArray: array [1..maxcolSw] of TImage;
  pcArray: array [1..maxcolPc] of TImage;
  end;

  //procedure VisualPing ;

var
  Main: TMain;
  ini:TIniFile;
  colSw,colPc,colText:integer;
  swArray: array [1..maxcolSw] of TImage;
  pcArray: array [1..maxcolPc] of TImage;
  swtag:byte;
  pctag:integer;
implementation

uses DataAcc, SWEnter, PCEnter, Swich, UPing, Netres, Pfield, Functions, Ptool,
  UExec, About;

{$R *.dfm}
{procedure VisualPing;
var
  pcX
begin
     ShowMessage (intTostr(ini.ReadInteger('SearchPc(dns)','Tag',0)));
   pcX:=Main.pcArray [ini.ReadInteger('SearchPc(dns)','Tag',0)].Left;
   pcY:=Main.pcArray [ini.ReadInteger('SearchPc(dns)','Tag',0)].Top;
   Main.Image1.Canvas.Pen.Color:=clRed;
   Main.Image1.Canvas.MoveTo(swX,swY);
   Main.Image1.Canvas.LineTo(pcX,pcY);
 ini.Free;
end;   }

procedure TMain.MousePcCl(Sender: TObject);
begin
  N4Click(Sender);
end;

procedure TMain.MouseSwCl(Sender: TObject);
begin
   if N2.Default then N2Click(Sender)
   else
      N5Click(Sender);

end;

procedure TMain.MouseUnderSw (Sender: TObject);
begin
  swArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\swch.bmp');
  swArray[TImage(Sender).Tag].BringToFront;
end;

procedure TMain.MouseLeavePc (Sender: TObject);
begin
    if pcArray[TImage(Sender).Tag].Name='Note'+IntToStr(TImage(Sender).Tag) then
      pcArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\ltop2.bmp')
   else if pcArray[TImage(Sender).Tag].Name='PC'+IntToStr(TImage(Sender).Tag) then
      pcArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\pc2.bmp')
end;

procedure TMain.MouseUnderPc (Sender: TObject);
begin
   if pcArray[TImage(Sender).Tag].Name='Note'+IntToStr(TImage(Sender).Tag) then
      pcArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\ltop.bmp')
   else if pcArray[TImage(Sender).Tag].Name='PC'+IntToStr(TImage(Sender).Tag) then
      pcArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\pc.bmp');
   pcArray[TImage(Sender).Tag].BringToFront;
end;

procedure TMain.MouseLeaveSw (Sender: TObject);
begin
  swArray[TImage(Sender).Tag].Picture.LoadFromFile('.\pic\swch2.bmp');
end;

procedure TMain.OnMouseDownSw (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);

begin
 Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
 if ini.ValueExists('Swich'+IntToStr (TImage(Sender).Tag),'DataExist') then
           N5.Default:=True
        else
           N2.Default:=True;
ini.Free;
if ssRight in Shift then
   begin
    SwichForm.GenerMessSw:=TImage(Sender).Tag;
    SwDataEnter.swGener:=TImage(Sender).Tag;
    SwichForm.swX:=TImage(Sender).Left;
    SwichForm.swY:=TImage(Sender).Top;
   end
else if ssLeft in Shift then
   begin
    SwichForm.GenerMessSw:=TImage(Sender).Tag;
    SwDataEnter.swGener:=TImage(Sender).Tag;
    SwichForm.swX:=TImage(Sender).Left;
    SwichForm.swY:=TImage(Sender).Top;
   end;


end;

procedure TMain.Ping1Click(Sender: TObject);
var
  dns:string;
  i:integer;
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  if ini.ValueExists ('PC'+IntToStr (pctag),'DataExist') then
    begin
      dns:=Ini.ReadString('PC'+IntToStr (pctag),'DNS','');
      frmPing.Left:=  Screen.WorkAreaHeight div 2-frmPing.Height;
      frmPing.BitBtn1.Enabled:=False;
      frmPing.BitBtn2.Enabled:=False;
      frmPing.Edit1.Enabled:=False;
      frmPing.Show;
      frmPing.memo1.Lines.Clear;
      frmPing.progressbar1.Position:=0;
      Functions.Ping (dns,frmPing.Memo1);
     for i := 0 to frmPing.progressbar1.max  do  frmPing.progressbar1.Position:=i;
    end
  else
    begin
     ShowMessage ('Имя компьютера не задано! Введите данные о хосте');
     exit;
    end;
end;


procedure TMain.OnMouseDownPc (Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin

N4.Default:=True;
if ssRight in Shift then
  begin
    PcDataEnter.pcGener:=TImage(Sender).Tag;
    pctag:= TImage(Sender).Tag;
  end
else if ssLeft in Shift then
  begin
    PcDataEnter.pcGener:=TImage(Sender).Tag;
    pctag:= TImage(Sender).Tag;
  end;
end;

procedure TMain.BitBtn1Click(Sender: TObject);
begin
  frmPing.Memo1.Lines.Clear;
  frmPing.Edit1.Text:='';
  frmPing.Edit1.Enabled:=True;
  frmPing.BitBtn1.Enabled:=True;
  frmPing.BitBtn2.Enabled:=True;
  frmPing.ProgressBar1.Position:=0;
  frmPing.ShowModal;
end;

procedure TMain.BitBtn2Click(Sender: TObject);
begin
  NetResForm.Button1.Caption:='Показать';
  NetResform.NetTree.Items.Clear;
  NetResform.ShowModal;
end;

procedure TMain.BitBtn3Click(Sender: TObject);
begin
  Aboutfrm.Show;
end;

procedure TMain.BitBtn4Click(Sender: TObject);
begin
 Close;
end;

procedure TMain.BitBtn5Click(Sender: TObject);
begin
nwMap.Show;
nwTools.Show;
ShowWindow (handle,SW_HIDE);
end;

procedure TMain.BitBtn6Click(Sender: TObject);
begin
  WinExec(pchar('notepad '+INI_NAME), sw_show)
end;

procedure TMain.BitBtn7Click(Sender: TObject);
begin
  FExec.Edit1.Text:='\\';
  FExec.Edit2.Text:='';
  FExec.Show;

end;

procedure TMain.CreateFrm(Sender: TObject);
var
  x,y:integer;
  j:integer;
begin
//////////////Load Settings////////////////

   Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
   colSw:=ini.ReadInteger('ColSwiches','Col',0);
   colPc:= ini.ReadInteger('ColPc','Col',0);
   colText:=ini.ReadInteger('ColText','Col',0);
   Image1.Picture.LoadFromFile(ini.ReadString('Map','Picture','./pic/testmap.bmp'));
   Image1.Left:=ini.ReadInteger('Map','Left',0);
   Image1.Top:=ini.ReadInteger('Map','Top',0);
   for j := 1 to colSw do
     begin
        swArray[j]:= TImage.Create(Self);
        swArray[j].Parent:= Self;
        swArray[j].Height:=ini.ReadInteger('Swich'+IntToStr(j),'Height',100);
        swArray[j].Width:=ini.ReadInteger('Swich'+IntToStr(j),'Width',100);
        swArray[j].Left:=ini.ReadInteger('Swich'+IntToStr(j),'Left',50+random(50));
        swArray[j].Top:=ini.ReadInteger('Swich'+IntToStr(j),'Top',50+random(50));
        swArray[j].Name:=ini.ReadString('Swich'+IntToStr(j),'Name','Swich'+inttostr(j));
        swArray[j].Tag:=ini.ReadInteger('Swich'+IntToStr(j),'Tag',j);
        //showmessage (inttostr(swArray[j].Tag));
        swArray[j].ShowHint:=True;
        swArray[j].Hint:='name of swich is- '+swArray[j].Name;
        swArray[j].Autosize:=True;
        swArray[j].PopupMenu:=SwMenu1;
        swArray[j].OnMouseDown:=OnMouseDownSw;
        swArray[j].OnMouseEnter:=MouseUnderSw;
        swArray[j].OnMouseLeave:=MouseLeaveSw;
        swArray[j].OnDblClick:=MouseSwCl;
        //swArray[j].OnMouseMove:=OnMove;
        //swArray[j].OnMouseUp:=MouseUpToSw;
        swArray[j].Picture.LoadFromFile('.\pic\swch2.bmp');
     end;
   for j := 1 to colPc do
     begin
        pcArray[j]:= TImage.Create(Self);
        pcArray[j].Parent:= Self;
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
        pcArray[j].OnMouseEnter:=MouseUnderPc;
        pcArray[j].OnMouseLeave:=MouseLeavePc;
        pcArray[j].OnDblClick:=MousePcCl;
        //pcArray[j].OnMouseMove:=OnMove;
        //pcArray[j].OnMouseUp:=MouseUpToPc;
        if pcArray[j].Name='Note'+IntToStr(j) then
              pcArray[j].Picture.LoadFromFile('.\pic\ltop2.bmp')
              else if pcArray[j].Name='PC'+IntToStr(j) then
                pcArray[j].Picture.LoadFromFile('.\pic\pc2.bmp')

     end;
image1.Canvas.Font.Color:=clGreen;
   for j := 1 to ColText do
     begin
        x:=ini.ReadInteger ('Text'+IntToStr(j),'X',0);
        y:=ini.ReadInteger ('Text'+IntToStr(j),'Y',0);
        text:=ini.ReadString ('Text'+IntToStr(j),'Text','default text');
        image1.Canvas.TextOut(X,Y,text);
     end;
     ini.Free;
Main.Caption:='Карта сети';
Image1.Canvas.Pen.Width:=2;
Image1.Canvas.Pen.Color:=clBlue;
Image1.Canvas.MoveTo(Main.Width-Main.Panel1.Width-8,1);
Image1.Canvas.LineTo(Main.Width-Main.Panel1.Width-8,Main.Height);
end;

procedure TMain.FormCreate(Sender: TObject);
begin
if GetSystemMetrics(SM_NETWORK) and $01 = $01 then
    Main.Caption:='Карта сети_Machine is attached to network'
  else
    begin
    ShowMessage('Machine is not attached to network');
    end;
  Main.Caption:='Карта сети_Machine is not attached to network';
end;

procedure TMain.N1Click(Sender: TObject);
var
str:string;
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  str:=ini.ReadString('PC'+IntToStr (pctag),'DNS','');
  FExec.Edit1.Text:='\\'+str;
  FExec.Edit2.Text:='';
  FExec.Show;
  ini.Free;
end;

procedure TMain.N2Click(Sender: TObject);
begin
SwDataEnter.Show;
end;

procedure TMain.N4Click(Sender: TObject);
begin
PcDataEnter.Show;
end;

procedure TMain.N5Click(Sender: TObject);
begin
   SwichForm.Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
   SwichForm.ColPort:= SwichForm.Ini.ReadInteger('Swich'+IntToStr(SwichForm.GenerMessSw),'ColPort',8);
   SwichForm.Ini.Free;
   SwichForm.Left:=0;
   SwichForm.Top:= Screen.WorkAreaHeight div 6-SwichForm.Height;
   SwichForm.Show;
end;

end.
