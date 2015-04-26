unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, Menus,
  XPMan, ComCtrls, ImgList, DBCtrls, jpeg;

type
  TFrmMain = class(TForm)
    TreeView1: TTreeView;
    TblSwitches: TTable;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Table2: TTable;
    BttnDelSwitch: TButton;
    BttnAddSwitch: TButton;
    BttnChangeSwitch: TButton;
    ExitButton: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    SocketEdit: TEdit;
    RoomEdit: TEdit;
    StaffEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    port1: TMenuItem;
    port2: TMenuItem;
    port3: TMenuItem;
    port4: TMenuItem;
    port5: TMenuItem;
    port6: TMenuItem;
    port7: TMenuItem;
    port8: TMenuItem;
    port9: TMenuItem;
    port10: TMenuItem;
    port11: TMenuItem;
    port12: TMenuItem;
    port13: TMenuItem;
    port14: TMenuItem;
    port15: TMenuItem;
    port16: TMenuItem;
    port17: TMenuItem;
    port18: TMenuItem;
    port19: TMenuItem;
    port20: TMenuItem;
    port21: TMenuItem;
    port22: TMenuItem;
    port23: TMenuItem;
    port24: TMenuItem;
    port25: TMenuItem;
    port26: TMenuItem;
    port27: TMenuItem;
    port28: TMenuItem;
    port29: TMenuItem;
    port30: TMenuItem;
    port31: TMenuItem;
    port32: TMenuItem;
    port33: TMenuItem;
    port34: TMenuItem;
    port35: TMenuItem;
    port36: TMenuItem;
    port37: TMenuItem;
    port38: TMenuItem;
    port39: TMenuItem;
    port40: TMenuItem;
    port41: TMenuItem;
    port42: TMenuItem;
    port43: TMenuItem;
    port44: TMenuItem;
    port45: TMenuItem;
    port46: TMenuItem;
    port47: TMenuItem;
    port48: TMenuItem;
    TblConnections: TTable;
    TblSockets: TTable;
    TblRooms: TTable;
    TblStaff: TTable;
    RoomComboBox: TComboBox;
    SocketComboBox: TComboBox;
    GroupBox4: TGroupBox;
    RoomsButton: TButton;
    SocketsButton: TButton;
    StaffButton: TButton;
    StaffComboBox: TComboBox;
    FindButton: TButton;
    ModelsButton: TButton;
    TblModels: TTable;
    port49: TMenuItem;
    port50: TMenuItem;
    IPEdit: TEdit;
    TblIP: TTable;
    IPButton: TButton;
    Label5: TLabel;
    IPComboBox: TComboBox;
    Label4: TLabel;
    PopupMenu2: TPopupMenu;
    Ping1: TMenuItem;
    racert1: TMenuItem;
    XPManifest1: TXPManifest;
    Image1: TImage;

    function getModel(modelID: integer): string;
    function getModelID(model: string): integer;
    function checkSocketConnect(socketID: integer): boolean;
    function getSwitchNameOfPort(portID: integer): string;
    function getPortNumInSwitch(portID: integer): integer;
    procedure choosen;
    procedure fillRoomComboBox;
    procedure fillSocketComboBox;
    procedure fillStaffComboBox;
    procedure fillIPComboBox;
    function isConnected(portID: integer): Boolean;
    function applyChanges(): boolean;
    function getRoomID(text: string): integer;
    function getIPID(text: string): integer;
    function getStaffID(text: string): integer;
    function getSocketID(text: string): integer;
    function getRoom(ID: integer): string;
    function getStaff(ID: integer): string;
    function getSocket(ID: integer): string;
    function getIP(ID: integer): string;
    function getPortID(port: integer; switchName: string): integer;
    procedure viewPortInfo(port: integer);
    procedure makePorts(switchNum: string);
    procedure fillTreeview();
    procedure FormCreate(Sender: TObject);
    function getPortsCount(switchNum: string): integer;
    function getPortsCount2(switchNum: string): integer;
    function findID(text: string): integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BttnDelSwitchClick(Sender: TObject);
    procedure BttnAddSwitchClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure BttnChangeSwitchClick(Sender: TObject);
    procedure deletePorts(name: string);
    procedure port1Click(Sender: TObject);
    procedure port2Click(Sender: TObject);
    procedure port3Click(Sender: TObject);
    procedure port4Click(Sender: TObject);
    procedure port5Click(Sender: TObject);
    procedure port6Click(Sender: TObject);
    procedure port7Click(Sender: TObject);
    procedure port8Click(Sender: TObject);
    procedure port9Click(Sender: TObject);
    procedure port10Click(Sender: TObject);
    procedure port11Click(Sender: TObject);
    procedure port12Click(Sender: TObject);
    procedure port13Click(Sender: TObject);
    procedure port14Click(Sender: TObject);
    procedure port15Click(Sender: TObject);
    procedure port16Click(Sender: TObject);
    procedure port17Click(Sender: TObject);
    procedure port18Click(Sender: TObject);
    procedure port19Click(Sender: TObject);
    procedure port20Click(Sender: TObject);
    procedure port21Click(Sender: TObject);
    procedure port22Click(Sender: TObject);
    procedure port23Click(Sender: TObject);
    procedure port24Click(Sender: TObject);
    procedure port25Click(Sender: TObject);
    procedure port26Click(Sender: TObject);
    procedure port27Click(Sender: TObject);
    procedure port28Click(Sender: TObject);
    procedure port29Click(Sender: TObject);
    procedure port30Click(Sender: TObject);
    procedure port31Click(Sender: TObject);
    procedure port32Click(Sender: TObject);
    procedure port33Click(Sender: TObject);
    procedure port34Click(Sender: TObject);
    procedure port35Click(Sender: TObject);
    procedure port36Click(Sender: TObject);
    procedure port37Click(Sender: TObject);
    procedure port38Click(Sender: TObject);
    procedure port39Click(Sender: TObject);
    procedure port40Click(Sender: TObject);
    procedure port41Click(Sender: TObject);
    procedure port42Click(Sender: TObject);
    procedure port43Click(Sender: TObject);
    procedure port44Click(Sender: TObject);
    procedure port45Click(Sender: TObject);
    procedure port46Click(Sender: TObject);
    procedure port47Click(Sender: TObject);
    procedure port48Click(Sender: TObject);
    procedure port49Click(Sender: TObject);
    procedure port50Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RoomComboBoxChange(Sender: TObject);
    procedure SocketComboBoxChange(Sender: TObject);
    procedure StaffComboBoxChange(Sender: TObject);
    procedure RoomsButtonClick(Sender: TObject);
    procedure StaffButtonClick(Sender: TObject);
    procedure SocketsButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure ModelsButtonClick(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure IPButtonClick(Sender: TObject);
    procedure IPComboBoxChange(Sender: TObject);
    procedure Ping1Click(Sender: TObject);
    procedure racert1Click(Sender: TObject);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  images: array[1..50] of TImage;

  maxports, maxports2, mp: integer;
  nameSwitchForChange: string;
  switchNumForChange: integer;
  selPort, prevPort: integer;
  flag,inChanging: boolean;
  portID: integer;

implementation

uses Math, formDelSwitchConfirm, formAddSwitch, formChangeSwitch, formRooms,
  formStaff, formSockets, formFind, formModels, formIP, UPing, Functions,
  uTracert;

{$R *.dfm}


procedure TFrmMain.fillTreeview();
var i,j: integer;
    rootTreeNode, modelTreeNode, switchTreeNode: TTreeNode;
    modelID: integer;
begin
  TreeView1.Items.Clear;
  try
  TblSwitches.Open;
  except
    on EDBEngineError do
     begin
     FrmMain.Close;
      ShowMessage('no access');
     end;

  end;
  TblSwitches.First;
  TblModels.Open;
  TblModels.First;
  with TreeView1.Items do
   begin
    Clear;
    rootTreeNode:=Add(nil,'Коммутаторы (Switches)');
    rootTreeNode.ImageIndex:=0;
    for i:=1 to TblModels.RecordCount do
     begin
      modelTreeNode:=AddChild(rootTreeNode,TblModels.fieldByName('Модель').Value);
      modelTreeNode.ImageIndex:=0;
      modelID:=TblModels.FieldByName('ID модели').Value;
      TblSwitches.First;
      for j:=1 to TblSwitches.RecordCount do
       begin
        if TblSwitches.FieldByName('ID модели').value=modelID then
         begin
          switchTreeNode:=AddChild(modelTreeNode,TblSwitches.FieldByName('инвентарный номер').Value);
          switchTreeNode.ImageIndex:=0;
         end;
        TblSwitches.Next;
       end;
      TblModels.Next;
     end;


   end;
  TblSwitches.close;

end;


function TFrmMain.getPortNumInSwitch(portID: integer): integer;
var i: integer;
begin
  Table2.Open;
  Table2.First;
  for i:=1 to Table2.RecordCount do
    if portID=Table2.FieldByName('ID порта').Value then
     begin
      Result:=Table2.fieldByName('номер порта').Value;
      Table2.Close;
      exit;
     end
    else Table2.Next;
  Table2.Close;
  Result:=0;
end;


function TFrmMain.getSwitchNameOfPort(portID: integer): string;
var i: integer;
    swID: integer;
begin

  swID:=0;
  Table2.Open;
  Table2.First;
  for i:=1 to Table2.RecordCount do
    if portID=Table2.FieldByName('ID порта').Value then
     begin
      swID:=Table2.fieldByName('ID свитча').Value;
      Table2.Close;
      break;
     end
    else Table2.Next;
  Table2.Close;

  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
    if swID=TblSwitches.FieldByName('ID свитча').Value then
     begin
      Result:=TblSwitches.fieldByName('инвентарный номер').Value;
      TblSwitches.Close;
      exit;
     end
    else TblSwitches.Next;
  TblSwitches.Close;

  Result:='';

end;


function TFrmMain.getPortsCount(switchNum: string): integer;
var i: integer;
begin

  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
   begin
    if TblSwitches.FieldByName('инвентарный номер').value=switchNum then
     begin
      Result:=TblSwitches.fieldbyname('количество портов').value;
      exit;
     end;
    TblSwitches.Next;
   end;
  Result:=0;
  TblSwitches.Close;

end;

function TFrmMain.getPortsCount2(switchNum: string): integer;
var i: integer;
begin

  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
   begin
    if TblSwitches.FieldByName('инвентарный номер').value=switchNum then
     begin
      Result:=TblSwitches.fieldbyname('количество гиг портов').value;
      exit;
     end;
    TblSwitches.Next;
   end;
  Result:=0;
  TblSwitches.Close;

end;


procedure TFrmMain.makePorts(switchNum: string);
var  i,tempWidth, otstup, j: integer;
begin
    j:=0;
    if maxports>0 then
    for i:=1 to maxports do images[i].Free;
  GroupBox1.Caption:='Свитч '+switchNum;
  maxports:=getPortsCount(switchNum);
  maxports2:=getPortsCount2(switchNum);
  mp:=maxports-maxports2;
  if maxports=0 then exit;
  tempWidth:=round(GroupBox1.Width/27);
  otstup:=round(tempWidth/2);

  for i:=1 to maxports do
    begin
    images[i]:=TImage.Create(self);
    images[i].Height:=25;
      if i<=mp then
         images[i].Width:=25
    else images[i].Width:=47;

    //  ****************  VV Dlya 48 portov + 2 gigabit ports VV   ****************************//
if mp=48 then begin

    if i<round(mp/2+1) then

       begin

     if (i>0) and (i<9) then   begin images[i].Left:=i*tempWidth-otstup;
                             images[i].Top:=30; end;
     if (i>8) and (i<17)then   begin  images[i].Left:=i*tempWidth+7-otstup;
                             images[i].Top:=30; end;
     if i>16            then   begin  images[i].Left:=i*tempWidth+14-otstup;
                             images[i].Top:=30; end;
       end
       else begin
     if (i>24) and (i<33) then   begin  images[i].Left:=i*tempWidth-otstup-round(mp/2)*tempWidth;
                             images[i].Top:=30+35; end;
     if (i>32) and (i<41) then   begin  images[i].Left:=i*tempWidth+7-otstup-round(mp/2)*tempWidth;
                             images[i].Top:=30+35; end;
     if (i>40) and (i<mp+1)then   begin  images[i].Left:=i*tempWidth+14-otstup-round(mp/2)*tempWidth;
                             images[i].Top:=30+35; end;

            end;
   if (i>mp) and (i<mp+maxports2/2+1) then begin
                    images[i].Left:=i*tempWidth+21-otstup-round(mp/2)*tempWidth;
                    images[i].Top:=30; end;
    if (i>mp+maxports2/2) then begin
                    images[i].Left:=i*tempWidth+21-otstup-(round(maxports/2)*tempWidth);
                    images[i].Top:=30+35; end;


            end;
       //  **************** ^^ Konec Dlya 48 portov + gigabit ports ^^  ****************************//

       //  **************** VV  Dlya 24 portov  VV     ****************************//
 if mp=24 then begin

    if (i<round(mp/2)+1) then

       begin

     if (i>0) and (i<7) then   begin images[i].Left:=i*tempWidth-otstup;
                             images[i].Top:=30; end;
     if (i>6)           then   begin  images[i].Left:=i*tempWidth+80-otstup;
                             images[i].Top:=30; end;
       end
       else begin
     if (i>12) and (i<19)    then   begin  images[i].Left:=i*tempWidth-otstup-round(mp/2)*tempWidth;
                             images[i].Top:=30+35; end;
     if (i>18)  and (i<mp+1) then   begin  images[i].Left:=i*tempWidth+80-otstup-round(mp/2)*tempWidth;
                             images[i].Top:=30+35; end;
                end;
    if (i>mp) {and  (i<mp+maxports2/2+1) then begin
                    images[i].Left:=i*(tempWidth+12)+120+7-otstup-round((mp/2)*(tempWidth+20));
                    images[i].Top:=30; end;
    if (i>mp+maxports2/2)} then begin
                    images[i].Left:=i*(tempWidth+12)+136-otstup-(round(maxports/2)*(tempWidth+20));
                    images[i].Top:=30+35;
                    tempWidth:=tempWidth+2; end;


                 end;


       //  **************** ^^ Konec Dlya 24 portov  ^^ ****************************//


       //  **************** VV  Dlya 12 portov  VV     ****************************//
  if maxports2=12 then begin

     images[i].Left:=i*tempWidth-otstup+j;
     images[i].Top:=30;
     j:=j+33; end;
       //  **************** ^^ Konec Dlya 12 portov  ^^ ****************************//


       //  **************** VV  Dlya Vseh ostalnih  VV     ****************************//
 if (mp<>24) and (mp<>48) and (maxports2<>12) then begin

    if (i<round(mp/2)+1) then

       begin
       images[i].Left:=i*tempWidth-otstup;
       images[i].Top:=30; end
       else begin
       images[i].Left:=i*tempWidth-otstup-round(mp/2)*tempWidth;
       images[i].Top:=30+35; end;

       if (i>mp) and (i<mp+maxports2/2+1) then begin
                    images[i].Left:=i*tempWidth+21-otstup-round(mp/2)*tempWidth;
                    images[i].Top:=30; end;
    if (i>mp+maxports2/2) then begin
                    images[i].Left:=i*tempWidth+21-otstup-(round(maxports/2)*tempWidth);
                    images[i].Top:=30+35; end;

         end;           
       //  **************** ^^  Konec Dlya Vseh ostalnih  ^^     ****************************//





    if isConnected(getPortID(i,nameSwitchForChange)) then
      images[i].Picture.LoadFromFile('images/connected.bmp')
     else images[i].Picture.LoadFromFile('images/disconnected.bmp');
     if (isConnected(getPortID(i,nameSwitchForChange))) and (i>mp) then
      images[i].Picture.LoadFromFile('images/gigport_connected.bmp');
     if not  (isConnected(getPortID(i,nameSwitchForChange))) and (i>mp) then
     images[i].Picture.LoadFromFile('images/gigport_disconnected.bmp');

    images[i].Parent:=GroupBox1;
    images[i].Cursor:=crHandPoint;
    images[i].PopupMenu:=PopupMenu2;
    case i of
      1: images[i].OnClick:=port1.OnClick;
      2: images[i].OnClick:=port2.OnClick;
      3: images[i].OnClick:=port3.OnClick;
      4: images[i].OnClick:=port4.OnClick;
      5: images[i].OnClick:=port5.OnClick;
      6: images[i].OnClick:=port6.OnClick;
      7: images[i].OnClick:=port7.OnClick;
      8: images[i].OnClick:=port8.OnClick;
      9: images[i].OnClick:=port9.OnClick;
      10: images[i].OnClick:=port10.OnClick;
      11: images[i].OnClick:=port11.OnClick;
      12: images[i].OnClick:=port12.OnClick;
      13: images[i].OnClick:=port13.OnClick;
      14: images[i].OnClick:=port14.OnClick;
      15: images[i].OnClick:=port15.OnClick;
      16: images[i].OnClick:=port16.OnClick;
      17: images[i].OnClick:=port17.OnClick;
      18: images[i].OnClick:=port18.OnClick;
      19: images[i].OnClick:=port19.OnClick;
      20: images[i].OnClick:=port20.OnClick;
      21: images[i].OnClick:=port21.OnClick;
      22: images[i].OnClick:=port22.OnClick;
      23: images[i].OnClick:=port23.OnClick;
      24: images[i].OnClick:=port24.OnClick;
      25: images[i].OnClick:=port25.OnClick;
      26: images[i].OnClick:=port26.OnClick;
      27: images[i].OnClick:=port27.OnClick;
      28: images[i].OnClick:=port28.OnClick;
      29: images[i].OnClick:=port29.OnClick;
      30: images[i].OnClick:=port30.OnClick;
      31: images[i].OnClick:=port31.OnClick;
      32: images[i].OnClick:=port32.OnClick;
      33: images[i].OnClick:=port33.OnClick;
      34: images[i].OnClick:=port34.OnClick;
      35: images[i].OnClick:=port35.OnClick;
      36: images[i].OnClick:=port36.OnClick;
      37: images[i].OnClick:=port37.OnClick;
      38: images[i].OnClick:=port38.OnClick;
      39: images[i].OnClick:=port39.OnClick;
      40: images[i].OnClick:=port40.OnClick;
      41: images[i].OnClick:=port41.OnClick;
      42: images[i].OnClick:=port42.OnClick;
      43: images[i].OnClick:=port43.OnClick;
      44: images[i].OnClick:=port44.OnClick;
      45: images[i].OnClick:=port45.OnClick;
      46: images[i].OnClick:=port46.OnClick;
      47: images[i].OnClick:=port47.OnClick;
      48: images[i].OnClick:=port48.OnClick;
      49: images[i].OnClick:=port49.OnClick;
      50: images[i].OnClick:=port50.OnClick;
     end;
   end;
  prevPort:=0;

end;


function TFrmMain.isConnected(portID: integer): Boolean;
var i: integer;
begin

  TblConnections.Open;
  TblConnections.First;
  for i:=1 to TblConnections.RecordCount do
    if TblConnections.FieldByName('ID порта').Value=portID then
      if TblConnections.FieldByName('ID розетки').Value<>0 then
       begin
        Result:=true;
        TblConnections.Close;
        Exit;
       end
       else begin
        Result:=false;
        TblConnections.Close;
        Exit;
       end
    else TblConnections.Next;
  Result:=false;
  TblConnections.Close;

end;


procedure TFrmMain.FormCreate(Sender: TObject);
begin
//========================
  if GetSystemMetrics(SM_NETWORK) and $01 = $01 then
        frmMain.Caption:='Карта сети_Machine is attached to network'
  else
    begin
    ShowMessage('Machine is not attached to network');
    frmMain.Caption:='Карта сети_Machine is attached to network';
    end;
  try    
    TblSockets.DatabaseName:='myDB';
    TblConnections.DatabaseName:='myDB';
    TblSwitches.DatabaseName:='myDB';
    TblSwitches.TableName:='tblSwitches';
    TblSwitches.Open;
    TblRooms.DatabaseName:='myDB';
    TblStaff.DatabaseName:='myDB';
    TblModels.DatabaseName:='myDB';
    Table2.DatabaseName:='myDB';
    TblSockets.TableName:='tblSockets';
    TblConnections.TableName:='tblConnections';
    TblStaff.TableName:='tblStaff';
    TblRooms.TableName:='tblRooms';
    Table2.TableName:='tblPorts';
    TblModels.TableName:='tblModels';
    TblIP.DatabaseName:='myDB';
    TblIP.TableName:='tblIP';
  except
    on EDBEngineError do
     case MessageDlg('Настройте в ODBC драйвер ''Driver do Microsoft Access'''+ #13#10+
     ' с инеменм ''myDB'' для БД netdata.mdb',mtCustom,[mbOK],0) of
     mrok: begin
               Application.Terminate;
               exit;
              end;
     end;
  end;
  //========================
  inChanging:=false;
  fillTreeview;
  maxports:=0;
  nameSwitchForChange:='';
  RoomEdit.ReadOnly:=true;
  StaffEdit.ReadOnly:=true;
  SocketEdit.ReadOnly:=true;
  IPEdit.ReadOnly:=true;
  flag:=false;
  prevPort:=0;
end;


procedure TFrmMain.deletePorts(name: string);
var tempID,i,j: integer;
    portCount: integer;
    portID: integer;
begin

  tempID:=findID(name);
  portCount:=0;
  if tempID=0 then exit;

  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
    if TblSwitches.FieldByName('ID свитча').Value=tempID then
      portCount:=TblSwitches.fieldByName('количество портов').Value
     else TblSwitches.Next;
  TblSwitches.Close;

  TblConnections.Open;
  for j:=1 to portCount do
   begin
    TblConnections.First;
    portID:=getPortID(j,name);
    for i:=1 to TblConnections.RecordCount do
      if TblConnections.FieldByName('ID порта').Value=portID then
        TblConnections.Delete
      else TblConnections.Next;
   end;
  TblConnections.Close;
  
  Table2.Open;
  Table2.First;
  for i:=1 to Table2.RecordCount do
    if table2.FieldByName('ID свитча').Value=tempID then
     Table2.Delete
    else
     Table2.Next;
  Table2.Close;

  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
    if TblSwitches.FieldByName('инвентарный номер').Value=name then
     begin
      TblSwitches.Delete;
      TblSwitches.Close;
      Exit;
     end
     else TblSwitches.Next;
  TblSwitches.Close;


end;


function TFrmMain.findID(text: string): integer;
var i: integer;
begin

  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
   begin
    if text=TblSwitches.FieldByName('инвентарный номер').Value then
     begin
      findID:=TblSwitches.fieldByName('ID свитча').AsInteger;
      TblSwitches.Close;
      Exit;
     end;
    TblSwitches.Next;
   end;
  findID:=0;
  TblSwitches.Close;

end;


procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var i: integer;
begin
  for i:=1 to maxports do
   begin
    images[i].Free;
   end;
end;


procedure TFrmMain.BttnDelSwitchClick(Sender: TObject);
var i,j: integer;
begin

  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
   begin
    if TblSwitches.FieldByName('инвентарный номер').value=
      TreeView1.Selected.Text then
       begin
        frmDelSwitchConfirm.ShowModal;
        if res=1 then
         begin
          deletePorts(TblSwitches.FieldByName('инвентарный номер').Value);
          TreeView1.Selected.Delete;
          for j:=1 to maxports do images[j].Free;
          maxports:=0;
          res:=0;
          Exit;
         end
         else exit;
       end
      else TblSwitches.Next;
   end;
  TblSwitches.Close;
  GroupBox1.Caption:='Свитч';

end;


procedure TFrmMain.BttnAddSwitchClick(Sender: TObject);
begin

  frmAddSwitch.showmodal;
  if added then
   begin
    TreeView1.Items.Clear;
    fillTreeview;
   end;

end;


procedure TFrmMain.ExitButtonClick(Sender: TObject);
begin
  FrmMain.Close;
end;


procedure TFrmMain.BttnChangeSwitchClick(Sender: TObject);
var flag: Boolean;
    i: integer;        
begin

  flag:=false;
  if nameSwitchForChange='' then exit;
  TblSwitches.Open;
  TblSwitches.First;
  for i:=1 to TblSwitches.RecordCount do
    if TblSwitches.FieldByName('инвентарный номер').value=
        nameSwitchForChange then
         begin
          flag:=true;
          switchNumForChange:=i;
          break;
         end
      else
        TblSwitches.Next;
  TblSwitches.Close;
  if flag then
   begin
    frmChangeSwitch.fillEdits;
    frmChangeSwitch.showmodal;
    if ischange then
     begin
      TreeView1.Items.Clear;
      fillTreeview;
     end;
   end;
   
end;


function TFrmMain.getPortID(port: integer; switchName: string): integer;
var i: integer;
    switchID: integer;
begin

  switchID:=findID(switchName);
  Table2.Open;
  Table2.First;
  for i:=1 to Table2.RecordCount do
   begin
    if (Table2.FieldByName('номер порта').value=port)and
       (Table2.FieldByName('ID свитча').value=switchID) then
        begin
         Result:=Table2.fieldByName('ID порта').AsInteger;
         Table2.Close;
         exit;
        end
    else Table2.Next;
   end;
  Result:=0;
  Table2.Close;

end;


procedure TFrmMain.viewPortInfo(port: integer);
var //portID: integer;
    room,staff,socket,IP: string;
    roomID,staffID,socketID,IPID: integer;
    i: integer;
begin
   /////////***************************************************************************
   /////////***************************************************************************
   /////////***************************************************************************
  portID:=getPortID(port,nameSwitchForChange);
  if port>mp then begin
  GroupBox2.Caption:='Гигабитный порт '+inttostr(port-mp);
  end
   else GroupBox2.Caption:='Порт '+inttostr(port);

  staffID:=0;
  roomID:=0;
  socketID:=0;
  IPID:=0;
  TblConnections.Open;
  TblConnections.First;
  for i:=1 to TblConnections.RecordCount do
   begin
    if TblConnections.FieldByName('ID порта').value=portID then
     begin
      staffID:=TblConnections.fieldByName('ID сотрудника').value;
      roomID:=TblConnections.fieldByName('ID кабинета').value;
      socketID:=TblConnections.fieldByName('ID розетки').value;
      IPID:=TblConnections.fieldByName('ID IP').value;
      break;
     end
    else TblConnections.Next;
   end;
  TblConnections.Close;
  room:=getRoom(roomID);
  staff:=getStaff(staffID);
  socket:=getSocket(socketID);
  IP:=getIP(IPID);
  RoomEdit.Text:=room;
  StaffEdit.Text:=staff;
  SocketEdit.Text:=socket;
  IPEdit.Text:=IP;

end;


function TFrmMain.getRoom(ID: integer): string;
var i: integer;
begin
//получить номер кабинета по ID===================
  TblRooms.Open;
  TblRooms.First;
  for i:=1 to TblRooms.RecordCount do
    if TblRooms.FieldByName('ID кабинета').Value=ID then
     begin
      Result:=TblRooms.fieldByName('номер кабинета').Value;
      TblRooms.Close;
      Exit;
     end
     else TblRooms.Next;
  Result:='';
  TblRooms.Close;
end;


function TFrmMain.getRoomID(text: string): integer;
var i: integer;
begin
  TblRooms.Open;
  TblRooms.First;
  for i:=1 to TblRooms.RecordCount do
    if TblRooms.FieldByName('номер кабинета').Value=text then
     begin
      Result:=TblRooms.fieldByName('ID кабинета').Value;
      TblRooms.Close;
      Exit;
     end
     else TblRooms.Next;
  Result:=0;
  TblRooms.Close;

end;

function TFrmMain.getIP(ID: integer): string;
var i: integer;
begin
//получить номер IP по ID===================
  TblIP.Open;
  TblIP.First;
  for i:=1 to TblIP.RecordCount do
    if TblIP.FieldByName('ID IP').Value=ID then
     begin
      Result:=TblIP.fieldByName('IP').Value;
      TblIP.Close;
      Exit;
     end
     else TblIP.Next;
  Result:='';
  TblIP.Close;
end;

function TFrmMain.getIPID(text: string): integer;
var i: integer;
begin
  TblIP.Open;
  TblIP.First;
  for i:=1 to TblIP.RecordCount do
    if TblIP.FieldByName('IP').Value=text then
     begin
      Result:=TblIP.fieldByName('ID IP').Value;
      TblIP.Close;
      Exit;
     end
     else TblIP.Next;
  Result:=0;
  TblIP.Close;

end;


function TFrmMain.getStaff(ID: integer): string;
var i: integer;
begin
//получить имя сотрудника по ID===================
  TblStaff.Open;
  TblStaff.First;
  for i:=1 to TblStaff.RecordCount do
    if TblStaff.FieldByName('ID сотрудника').Value=ID then
     begin
      Result:=TblStaff.fieldByName('ФИО сотрудника').Value;
      TblStaff.Close;
      Exit;
     end
     else TblStaff.Next;
  Result:='';
  TblStaff.Close;

end;


function TFrmMain.getStaffID(text: string): integer;
var i: integer;
begin
  TblStaff.Open;
  TblStaff.First;
  for i:=1 to TblStaff.RecordCount do
    if TblStaff.FieldByName('ФИО сотрудника').Value=text then
     begin
      Result:=TblStaff.fieldByName('ID сотрудника').Value;
      TblStaff.Close;
      Exit;
     end
     else TblStaff.Next;
  Result:=0;
  TblStaff.Close;

end;


function TFrmMain.getSocket(ID: integer): string;
var i: integer;
begin
//получить название розетки по ID===================
  TblSockets.Open;
  TblSockets.First;
  for i:=1 to TblSockets.RecordCount do
    if TblSockets.FieldByName('ID розетки').Value=ID then
     begin
      Result:=TblSockets.fieldByName('Имя розетки').Value;
      TblSockets.Close;
      Exit;
     end
     else TblSockets.Next;
  Result:='';
  TblSockets.Close;

end;


function TFrmMain.getSocketID(text: string): integer;
var i: integer;
begin

  TblSockets.Open;
  TblSockets.First;
  for i:=1 to TblSockets.RecordCount do
    if TblSockets.FieldByName('Имя розетки').Value=text then
     begin
      Result:=TblSockets.fieldByName('ID розетки').Value;
      TblSockets.Close;
      Exit;
     end
     else TblSockets.Next;
  Result:=0;
  TblSockets.Close;

end;


procedure TFrmMain.port1Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=1;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port2Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=2;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port3Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=3;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port4Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=4;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port5Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=5;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port6Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=6;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port7Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=7;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port8Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=8;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port9Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=9;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.racert1Click(Sender: TObject);
begin
if IPEdit.Text>'' then
  begin
frmTracert.Show;
frmTracert.sedCount.Text:='32';
frmTracert.edAddr.Text:=IPEdit.Text;
  end;
end;

procedure TFrmMain.port10Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=10;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port11Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=11;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port12Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=12;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port13Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=13;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port14Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=14;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port15Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=15;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port16Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=16;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port17Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=17;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port18Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=18;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port19Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=19;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port20Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=20;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port21Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=21;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port22Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=22;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port23Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=23;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port24Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=24;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port25Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=25;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port26Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=26;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port27Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=27;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port28Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=28;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port29Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=29;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port30Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=30;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port31Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=31;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port32Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=32;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port33Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=33;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port34Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=34;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port35Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=35;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port36Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=36;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port37Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=37;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port38Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=38;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port39Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=39;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port40Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=40;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port41Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=41;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port42Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=42;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port43Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=43;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port44Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=44;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port45Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=45;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port46Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=46;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port47Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=47;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port48Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=48;
  choosen;
  viewPortInfo(selPort);
end;


procedure TFrmMain.port49Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=49;
  choosen;
  viewPortInfo(selPort);
end;

procedure TFrmMain.port50Click(Sender: TObject);
begin
  if ischange then exit;
  selPort:=50;
  choosen;
  viewPortInfo(selPort);
end;
procedure TFrmMain.choosen;
begin

  if prevPort<>0 then
    if isConnected(getPortID(prevPort,nameSwitchForChange)) then
      images[prevPort].Picture.LoadFromFile('images/connected.bmp')
      else images[prevPort].Picture.LoadFromFile('images/disconnected.bmp');
  if isConnected(getPortID(selPort,nameSwitchForChange)) then
    images[selPort].Picture.LoadFromFile('images/connected_choosen.bmp')
    else images[selPort].Picture.LoadFromFile('images/disconnected_choosen.bmp');

  if (isConnected(getPortID(prevPort,nameSwitchForChange))) and (prevPort>mp) then
      images[prevPort].Picture.LoadFromFile('images/gigport_connected.bmp');
  if not (isConnected(getPortID(prevPort,nameSwitchForChange))) and (prevPort>mp) then
      images[prevPort].Picture.LoadFromFile('images/gigport_disconnected.bmp');
  if (isConnected(getPortID(selPort,nameSwitchForChange))) and (selPort>mp) then
    images[selPort].Picture.LoadFromFile('images/gigport_connected_choosen.bmp');
  if not (isConnected(getPortID(selPort,nameSwitchForChange))) and (selPort>mp) then
    images[selPort].Picture.LoadFromFile('images/gigport_disconnected_choosen.bmp');


  prevPort:=selPort;
 end;

function TFrmMain.checkSocketConnect(socketID: integer): boolean;
var i: integer;
begin
  if socketID=0 then
   begin
    Result:=false;
    exit;
   end;
  TblConnections.Open;
  TblConnections.First;
  for i:=1 to TblConnections.RecordCount do
    if (TblConnections.FieldByName('ID розетки').Value=socketID)and
       (TblConnections.FieldByName('ID порта').Value<>portID)
     then begin
      Result:=true;
      TblConnections.Close;
      exit
     end
     else TblConnections.Next;
  TblConnections.Close;
  Result:=false;
end;


function TFrmMain.applyChanges(): boolean;
var i: integer;
    sck: integer;
//    portID: integer;
begin
  sck:=getSocketID(SocketEdit.Text);
  if checkSocketConnect(sck) then
   begin
    ShowMessage('Данная розетка уже подключена');
    result:=false;
    exit;
   end;
//  portID:=getPortID(selPort,nameSwitchForChange);
  TblConnections.Open;
  TblConnections.First;
  for i:=1 to TblConnections.RecordCount do
   begin
    if TblConnections.FieldByName('ID порта').Value=portID then
     begin
      TblConnections.Edit;
      TblConnections.FieldByName('ID сотрудника').Value:=getStaffID(StaffEdit.Text);
      TblConnections.FieldByName('ID кабинета').Value:=getRoomID(RoomEdit.Text);
      TblConnections.FieldByName('ID IP').Value:=getIPID(IPEdit.Text);
      TblConnections.FieldByName('ID розетки').Value:=sck;
      TblConnections.Post;
      TblConnections.Close;
      Result:=true;
      exit;

     end
     else TblConnections.Next;
   end;
  TblConnections.Close;
  Result:=true;

end;


procedure TFrmMain.fillRoomComboBox;
var i: integer;
begin

  RoomComboBox.Clear;
  TblRooms.Open;
  TblRooms.First;
  for i:=1 to TblRooms.RecordCount do
   begin
    RoomComboBox.Items.Add(TblRooms.fieldByName('номер кабинета').Value);
    TblRooms.Next;
   end;
  TblRooms.Close;
  for i:=0 to RoomComboBox.Items.Count-1 do
    if RoomEdit.Text=RoomComboBox.Items.Strings[i] then
      RoomComboBox.ItemIndex:=i;

end;


procedure TFrmMain.fillSocketComboBox;
var i: integer;
    roomID: integer;
begin

  SocketComboBox.Clear;
  TblSockets.Open;
  TblSockets.First;
  roomID:=getRoomID(RoomEdit.Text);

  for i:=1 to TblSockets.RecordCount do
   begin
    if TblSockets.FieldByName('ID кабинета').Value=roomID then
      SocketComboBox.Items.Add(TblSockets.fieldByName('имя розетки').Value);
    TblSockets.Next;
   end;
  TblSockets.Close;

  for i:=0 to SocketComboBox.Items.Count-1 do
    if SocketEdit.Text=SocketComboBox.Items.Strings[i] then
      SocketComboBox.ItemIndex:=i;

end;


procedure TFrmMain.fillStaffComboBox;
var i: integer;
begin

  StaffComboBox.Clear;
  TblStaff.Open;
  TblStaff.First;
  for i:=1 to TblStaff.RecordCount do
   begin
    StaffComboBox.Items.Add(TblStaff.fieldByName('ФИО сотрудника').Value);
    TblStaff.Next;
   end;
  TblStaff.Close;
  for i:=0 to StaffComboBox.Items.Count-1 do
    if StaffEdit.Text=StaffComboBox.Items.Strings[i] then
      StaffComboBox.ItemIndex:=i;

end;

procedure TFrmMain.fillIPComboBox;
var i: integer;
begin

  IPComboBox.Clear;
  TblIP.Open;
  TblIP.First;
  for i:=1 to TblIP.RecordCount do
   begin
    IPComboBox.Items.Add(TblIP.fieldByName('IP').Value);
    TblIP.Next;
   end;
  TblIP.Close;
  for i:=0 to IPComboBox.Items.Count-1 do
    if IPEdit.Text=IPComboBox.Items.Strings[i] then
      IPComboBox.ItemIndex:=i;

end;


procedure TFrmMain.Button1Click(Sender: TObject);
begin

  flag:= not flag;
  if flag then
   begin

    ischange:=true;

    RoomEdit.ReadOnly:=false;
    RoomEdit.Hide;
    fillRoomComboBox;
    RoomComboBox.Show;

    StaffEdit.ReadOnly:=false;
    StaffEdit.Hide;
    fillStaffComboBox;
    StaffComboBox.Show;

    SocketEdit.ReadOnly:=false;
    SocketEdit.Hide;
    fillSocketComboBox;
    SocketComboBox.Show;

    IPEdit.ReadOnly:=false;
    IPEdit.Hide;
    fillIPComboBox;
    IPComboBox.Show;

    Label1.Caption:='Розетка - изменить';
    Label2.Caption:='Кабинет - изменить';
    Label3.Caption:='Сотрудник - изменить';
    Label5.Caption:='IP адрес - изменить';
    Button1.Caption:='Подтвердить';
   end
   else begin
    ischange:=false;

    RoomEdit.ReadOnly:=True;
    RoomEdit.Show;
    RoomComboBox.Hide;

    StaffEdit.ReadOnly:=true;
    StaffComboBox.Hide;
    StaffEdit.Show;

    SocketEdit.ReadOnly:=true;
    SocketComboBox.Hide;
    SocketEdit.Show;

    IPEdit.ReadOnly:=true;
    IPComboBox.Hide;
    IPEdit.Show;

    Label1.Caption:='Розетка';
    Label2.Caption:='Кабинет';
    Label3.Caption:='Сотрудник';
    Label5.Caption:='IP адрес';
    Button1.Caption:='Изменить';
    if applyChanges then makePorts(nameSwitchForChange)
      else Button1.Click;
   end;

end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
{  RoomEdit.Text:=inttostr(getRoomID(RoomEdit.Text));
  StaffEdit.Text:=inttostr(getStaffID(StaffEdit.Text));
  SocketEdit.Text:=inttostr(getSocketID(SocketEdit.Text));}
  if MessageDlg('Вы уверены что хотите очистить запись',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  RoomEdit.Text:='';
  StaffEdit.Text:='';
  SocketEdit.Text:='';
  IPEdit.Text:='';
  Button1.Click;
  Button1.Click;
end;                                                              

procedure TFrmMain.RoomComboBoxChange(Sender: TObject);
begin
  RoomEdit.Text:=RoomComboBox.Items.Strings[RoomComboBox.ItemIndex];
  fillSocketComboBox;
end;

procedure TFrmMain.SocketComboBoxChange(Sender: TObject);
begin
  SocketEdit.Text:=SocketComboBox.Items.Strings[SocketComboBox.ItemIndex];
end;

procedure TFrmMain.StaffComboBoxChange(Sender: TObject);
begin
  StaffEdit.Text:=StaffComboBox.Items.Strings[StaffComboBox.ItemIndex];
end;



procedure TFrmMain.RoomsButtonClick(Sender: TObject);
begin
  frmRooms.ShowModal;
end;

procedure TFrmMain.StaffButtonClick(Sender: TObject);
begin
  frmStaff.showmodal;
end;

procedure TFrmMain.SocketsButtonClick(Sender: TObject);
begin
  frmSockets.ShowModal;
end;

procedure TFrmMain.IPButtonClick(Sender: TObject);
begin
frmIP.showmodal;
end;

procedure TFrmMain.FindButtonClick(Sender: TObject);
begin
  frmFind.ShowModal;
end;

procedure TFrmMain.TreeView1Click(Sender: TObject);
begin

  if TreeView1.Selected.Selected then
   begin
    nameSwitchForChange:=TreeView1.Selected.Text;
    makePorts(TreeView1.Selected.Text);
   end;
  RoomEdit.Text:='';
  StaffEdit.Text:='';
  SocketEdit.Text:='';
  IPEdit.Text:='';
  GroupBox2.Caption:='Порт';
  
end;

procedure TFrmMain.ModelsButtonClick(Sender: TObject);
begin
  frmModels.ShowModal;
  fillTreeview;
  RoomEdit.Text:='';
  StaffEdit.Text:='';
  SocketEdit.Text:='';
  IPEdit.Text:='';
end;


procedure TFrmMain.Ping1Click(Sender: TObject);
var
  i:integer;
begin
if IPEdit.Text>'' then
  begin
      frmPing.Left:=  Screen.WorkAreaHeight div 2-frmPing.Height;
      frmPing.BitBtn1.Enabled:=False;
      frmPing.BitBtn2.Enabled:=False;
      frmPing.Edit1.Enabled:=False;
      frmPing.Show;
      frmPing.memo1.Lines.Clear;
      frmPing.progressbar1.Position:=0;
      Functions.Ping (IPEdit.Text,frmPing.Memo1);
     for i := 0 to frmPing.progressbar1.max  do  frmPing.progressbar1.Position:=i;
  end
else
ShowMessage ('Выделите порт!');
end;

function TFrmMain.getModelID(model: string): integer;
var i: integer;
begin
  TblModels.Open;
  TblModels.First;
  for i:=1 to TblModels.RecordCount do
    if TblModels.FieldByName('Модель').Value=model then
     begin
      Result:=TblModels.fieldByName('ID модели').Value;
      TblModels.Close;
      Exit;
     end
     else TblModels.Next;
  Result:=0;
  TblModels.Close;
end;


function TFrmMain.getModel(modelID: integer): string;
var i: integer;
begin
  TblModels.Open;
  TblModels.First;
  for i:=1 to TblModels.RecordCount do
    if TblModels.FieldByName('ID модели').Value=modelID then
     begin
      Result:=TblModels.fieldByName('Модель').Value;
      TblModels.Close;
      Exit;
     end
     else TblModels.Next;
  Result:='';
  TblModels.Close;
end;


procedure TFrmMain.Label4MouseEnter(Sender: TObject);
begin
  Label4.Caption:='Created by Klimov Elmar';
  Label4.Font.Color:=clPurple;
  Label4.Font.Size:=10;
  Label4.Font.Name:='Times New Roman';
end;

procedure TFrmMain.Label4MouseLeave(Sender: TObject);
begin
  Label4.Font.Name:='Verdana';
  Label4.Font.Size:=16;
  Label4.Caption:='?';
  Label4.Font.Color:=clRed;

end;






procedure TFrmMain.IPComboBoxChange(Sender: TObject);
begin
IPEdit.Text:=IPComboBox.Items.Strings[IPComboBox.ItemIndex];
end;

end.
