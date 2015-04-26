unit formFind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, Grids, DB, DBTables;

type
  TfrmFind = class(TForm)
    GroupBox1: TGroupBox;      
    StaffCheckBox: TCheckBox;
    RoomCheckBox: TCheckBox;
    SocketCheckBox: TCheckBox;
    FindButton: TButton;
    ExitButton: TButton;
    StaffComboBox: TComboBox;
    RoomComboBox: TComboBox;
    SocketComboBox: TComboBox;
    Grid1: TStringGrid;
    TblStaff: TTable;
    TblRooms: TTable;
    TblSockets: TTable;
    TblConnections: TTable;
    TblPorts: TTable;
    tblIP: TTable;
    IPCheckBox: TCheckBox;
    IPComboBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure fillSockets;
    procedure fillStaff;
    procedure fillRooms;
    procedure fillIP;
    procedure ExitButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFind: TfrmFind;
  findStaff, findSocket, findRoom, findIP: Boolean;
  equal: Boolean;
  sockets,rooms,staff,IP: array of array[1..2] of string[30];

implementation

uses Math, mainform;

{$R *.dfm}

procedure TfrmFind.ExitButtonClick(Sender: TObject);
begin
  Close;        
end;


procedure TfrmFind.fillStaff;
var i: integer;
begin
  StaffComboBox.Clear;
  TblStaff.Open;
  TblStaff.First;
  SetLength(staff,TblStaff.RecordCount);
  for i:=1 to TblStaff.RecordCount do
   begin
    staff[i-1,2]:=TblStaff.fieldByName('ФИО сотрудника').AsString;
    staff[i-1,1]:=TblStaff.fieldByName('ID сотрудника').AsString;
    TblStaff.Next;
   end;
  for i:=1 to Length(staff) do
    StaffComboBox.Items.Add(staff[i-1,2]);
  StaffComboBox.Sorted:=true;
  TblStaff.Close;
end;


procedure TfrmFind.fillRooms;
var i: integer;
begin
  RoomComboBox.Clear;
  TblRooms.Open;
  TblRooms.First;
  SetLength(rooms,TblRooms.RecordCount);
  for i:=1 to TblRooms.RecordCount do
   begin
    rooms[i-1,2]:=TblRooms.fieldByName('Номер кабинета').AsString;
    rooms[i-1,1]:=TblRooms.fieldByName('ID кабинета').AsString;
    TblRooms.Next;
   end;
  for i:=1 to Length(rooms) do
    RoomComboBox.Items.Add(rooms[i-1,2]);
  RoomComboBox.Sorted:=true;
  TblRooms.Close;
end;


procedure TfrmFind.fillSockets;
var i: integer;
begin
  SocketComboBox.Clear;
  TblSockets.Open;
  TblSockets.First;
  SetLength(sockets,TblSockets.RecordCount);
  for i:=1 to TblSockets.RecordCount do
   begin
    sockets[i-1,2]:=TblSockets.fieldByName('Имя розетки').AsString;
    sockets[i-1,1]:=TblSockets.fieldByName('ID розетки').AsString;
    TblSockets.Next;
   end;
  for i:=1 to Length(sockets) do
    SocketComboBox.Items.Add(sockets[i-1,2]);
  SocketComboBox.Sorted:=true;
  TblSockets.Close;
end;

procedure TfrmFind.fillIP;
var i: integer;
begin
  IPComboBox.Clear;
  TblIP.Open;
  TblIP.First;
  SetLength(IP,TblIP.RecordCount);
  for i:=1 to TblIP.RecordCount do
   begin
    IP[i-1,2]:=TblIP.fieldByName('IP').AsString;
    IP[i-1,1]:=TblIP.fieldByName('ID IP').AsString;
    TblIP.Next;
   end;
  for i:=1 to Length(IP) do
    IPComboBox.Items.Add(IP[i-1,2]);
  IPComboBox.Sorted:=true;
  TblIP.Close;
end;

procedure TfrmFind.FindButtonClick(Sender: TObject);
var i: integer;
    passed: boolean;
    st,rm,sck,pt,ipp: integer;
    count: integer;
begin
  Grid1.Show;
  for i:=1 to Grid1.RowCount do Grid1.Rows[i].Clear;
  count:=1;
  Grid1.RowCount:=2;
  Grid1.FixedRows:=1;

  st:=frmMain.getStaffID(StaffComboBox.Items.Strings[StaffComboBox.ItemIndex]);
  rm:=FrmMain.getRoomID(RoomComboBox.Items.Strings[RoomComboBox.ItemIndex]);
  sck:=FrmMain.getSocketID(SocketComboBox.Items.Strings[SocketComboBox.ItemIndex]);
  ipp:=FrmMain.getIPID(IPComboBox.Items.Strings[IPComboBox.ItemIndex]);

  TblConnections.Open;
  TblConnections.First;

  for i:=1 to TblConnections.RecordCount do
   begin

    passed:=true;

    if not StaffCheckBox.Checked and not RoomCheckBox.Checked and
      not SocketCheckBox.Checked and not IPCheckBox.Checked then passed:=false;

    if StaffCheckBox.Checked then
      if (TblConnections.FieldByName('ID сотрудника').Value<>st)or(st=0) then passed:=False;
    if RoomCheckBox.Checked then
      if (TblConnections.FieldByName('ID кабинета').Value<>rm)or(rm=0) then passed:=False;
    if SocketCheckBox.Checked then
      if (TblConnections.FieldByName('ID розетки').Value<>sck)or(sck=0) then passed:=false;
    if IPCheckBox.Checked then
      if (TblConnections.FieldByName('ID IP').Value<>ipp)or(ipp=0) then passed:=false;

    if passed then
     begin
      pt:=TblConnections.fieldByName('ID порта').Value;

      Grid1.RowCount:=Grid1.RowCount+1;
      Grid1.Cells[0,count]:=FrmMain.getStaff(TblConnections.fieldByName('ID сотрудника').Value);
      Grid1.Cells[1,count]:=FrmMain.getRoom(TblConnections.fieldByName('ID кабинета').Value);
      Grid1.Cells[2,count]:=FrmMain.getSocket(TblConnections.fieldByName('ID розетки').Value);
      Grid1.Cells[4,count]:=inttostr(FrmMain.getPortNumInSwitch(pt));
      Grid1.Cells[3,count]:=FrmMain.getSwitchNameOfPort(pt);
      Grid1.Cells[5,count]:=FrmMain.getIP(TblConnections.fieldByName('ID IP').Value);
      inc(count);
     end;

    TblConnections.Next;

   end;
  Grid1.RowCount:=Grid1.RowCount-1;

end;

procedure TfrmFind.FormShow(Sender: TObject);
begin
  fillStaff;
  fillRooms;
  fillSockets;
  fillIP;
//  Grid1.Hide;
  StaffCheckBox.Font.Color:=clLime;
  RoomCheckBox.Font.Color:=clLime;
  SocketCheckBox.Font.Color:=clLime;
  IPCheckBox.Font.Color:=clLime;

  SetLength(staff,0);
  SetLength(rooms,0);
  SetLength(sockets,0);
  SetLength(IP,0);
  Grid1.Cells[0,0]:='Сотрудник';
  Grid1.Cells[1,0]:='Кабинет';
  Grid1.Cells[2,0]:='Розетка';
  Grid1.Cells[3,0]:='Свитч';
  Grid1.Cells[4,0]:='Номер порта';
  Grid1.Cells[5,0]:='IP адрес';

  Grid1.ColWidths[0]:=120;
  Grid1.ColWidths[1]:=120;
  Grid1.ColWidths[2]:=50;
  Grid1.ColWidths[3]:=90;
  Grid1.ColWidths[4]:=70;
  Grid1.ColWidths[5]:=70;
end;



end.
