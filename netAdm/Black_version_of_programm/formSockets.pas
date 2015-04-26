unit formSockets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, CheckLst, ExtCtrls, DB, DBTables;

type
  TfrmSockets = class(TForm)
    GroupBox1: TGroupBox;
    RoomsComboBox: TComboBox;
    Label1: TLabel;
    SocketListBox: TListBox;
    AddSocketButton: TButton;
    DelSocketButton: TButton;
    ChangeSocketButton: TButton;
    ExitButton: TButton;
    Edit1: TEdit;
    tblSockets: TTable;
    tblRooms: TTable;
    procedure showSockets;
    procedure showRooms;
    procedure FormCreate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure RoomsComboBoxChange(Sender: TObject);
    procedure SocketListBoxClick(Sender: TObject);
    procedure AddSocketButtonClick(Sender: TObject);
    procedure DelSocketButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSockets: TfrmSockets;

implementation

uses mainform;

{$R *.dfm}


procedure TfrmSockets.FormCreate(Sender: TObject);
begin
  frmSockets.Left:=round(Screen.Width/2)
  -round(frmSockets.Width/2);
  frmSockets.top:=round(Screen.Height/2)-
  round(frmSockets.Height/2);
end;


procedure TfrmSockets.showRooms;
var i: integer;
begin
  RoomsComboBox.Clear;
  RoomsComboBox.Items.Add('Все');
  tblRooms.Open;
  tblRooms.First;
  for i:=1 to tblRooms.RecordCount do
   begin
    RoomsComboBox.Items.Add(tblRooms.fieldByName('Номер кабинета').Value);
    tblRooms.Next;
   end;
//  RoomsComboBox.ItemIndex:=RoomsComboBox.Items.Count-1;
  tblRooms.Close;

end;


procedure TfrmSockets.showSockets;
var i: integer;
    roomID: integer;
begin
  SocketListBox.Clear;
  tblSockets.Open;
  tblSockets.First;
  if RoomsComboBox.Items.Strings[RoomsComboBox.ItemIndex]='Все' then
    for i:=1 to tblSockets.RecordCount do
     begin
      SocketListBox.Items.Add(tblSockets.fieldByName('Имя розетки').Value);
      tblSockets.Next;
     end
  else
   begin
    roomID:= frmMain.getRoomID(RoomsComboBox.Items.Strings[RoomsComboBox.ItemIndex]);
    for i:=1 to tblSockets.RecordCount do
     begin
      if roomID=tblSockets.FieldByName('ID кабинета').Value then
        SocketListBox.Items.Add(tblSockets.fieldByName('Имя розетки').Value);
      tblSockets.Next;
     end;
   end;
  SocketListBox.Sorted:=true;

end;


procedure TfrmSockets.ExitButtonClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmSockets.RoomsComboBoxChange(Sender: TObject);
begin

  SocketListBox.Clear;
  Edit1.Text:='';
  if RoomsComboBox.ItemIndex=0 then AddSocketButton.Enabled:=False
  else AddSocketButton.Enabled:=true;
  showSockets;
  
end;


procedure TfrmSockets.SocketListBoxClick(Sender: TObject);
begin
  if SocketListBox.ItemIndex>-1 then
    Edit1.Text:=SocketListBox.Items.Strings[SocketListBox.ItemIndex];
end;


procedure TfrmSockets.AddSocketButtonClick(Sender: TObject);
var i: integer;
    roomID: integer;
begin

  if length(Edit1.Text)=0 then exit;
  for i:=0 to SocketListBox.Items.Count-1 do
    if Edit1.Text=SocketListBox.Items.Strings[i] then
     begin
      ShowMessage('Розетка с таким именем уже существует');
      exit;
     end;

  tblSockets.Open;
  roomID:=FrmMain.getRoomID(RoomsComboBox.Items.Strings[RoomsComboBox.ItemIndex]);
  tblSockets.Append;
  tblSockets.FieldByName('Имя розетки').value:=Edit1.Text;
  tblSockets.FieldByName('ID кабинета').Value:=roomID;
  tblSockets.Post;
  tblSockets.Close;
  SocketListBox.Clear;
  showSockets;

end;

procedure TfrmSockets.DelSocketButtonClick(Sender: TObject);
var i: integer;
begin

  if Length(Edit1.Text)=0 then exit;
  if MessageDlg('Вы уверены что хотите удалить розетку '+Edit1.Text,
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  TblSockets.Open;
  TblSockets.First;
  for i:=1 to TblSockets.RecordCount do
    if TblSockets.FieldByName('Имя розетки').Value=Edit1.Text then
      TblSockets.Delete
    else TblSockets.Next;
  TblSockets.Close;
  SocketListBox.Clear;
  showSockets;
  Edit1.Text:='';

end;

procedure TfrmSockets.FormShow(Sender: TObject);
begin
  showRooms;
  showSockets;
  AddSocketButton.Enabled:=false;
end;

end.
