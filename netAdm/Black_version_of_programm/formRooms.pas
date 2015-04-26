unit formRooms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls;

type
  TfrmRooms = class(TForm)
    tblRooms: TTable;
    GroupBox1: TGroupBox;
    RoomListBox: TListBox;
    AddRoomButton: TButton;
    ExitButton: TButton;
    Edit1: TEdit;
    DelRoomButton: TButton;
    ChangeRoomButton: TButton;
    procedure showRooms;
    procedure FormCreate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure AddRoomButtonClick(Sender: TObject);
    procedure RoomListBoxClick(Sender: TObject);
    procedure DelRoomButtonClick(Sender: TObject);
    procedure ChangeRoomButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRooms: TfrmRooms;
  roomID: integer;
  flag1: boolean;

implementation

uses mainform;

{$R *.dfm}


procedure TfrmRooms.FormCreate(Sender: TObject);
begin
  RoomListBox.MultiSelect:=False;
  frmRooms.Left:=round(Screen.Width/2)
  -round(frmRooms.Width/2);
  frmRooms.top:=round(Screen.Height/2)-
  round(frmRooms.Height/2);

end;


procedure TfrmRooms.showRooms;
var i: integer;
begin
  RoomListBox.Clear;
  tblRooms.Open;
  tblRooms.First;
  for i:=1 to tblRooms.RecordCount do
   begin
    RoomListBox.Items.Add(tblRooms.fieldByName('Номер кабинета').Value);
    tblRooms.Next;
   end;
  tblRooms.Close;
  RoomListBox.Sorted:=true;
end;


procedure TfrmRooms.ExitButtonClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmRooms.AddRoomButtonClick(Sender: TObject);
var i: integer;
begin

  if length(Edit1.Text)=0 then exit;
  tblRooms.Open;
  tblRooms.First;
  for i:=1 to tblRooms.RecordCount do
    if Edit1.Text=tblRooms.FieldByName('Номер кабинета').Value then
     begin
      ShowMessage('Такой кабинет уже есть');
      exit;
     end
     else tblRooms.Next;
  tblRooms.Append;
  tblRooms.FieldByName('Номер кабинета').Value:=Edit1.Text;
  tblRooms.Post;
  tblRooms.Close;
  RoomListBox.Clear;
  showRooms;
  Edit1.Text:='';

end;


procedure TfrmRooms.RoomListBoxClick(Sender: TObject);
begin
  if RoomListBox.ItemIndex>-1 then
  Edit1.Text:=RoomListBox.Items.Strings[RoomListBox.ItemIndex];
end;


procedure TfrmRooms.DelRoomButtonClick(Sender: TObject);
var i: integer;
begin

  if Length(Edit1.Text)=0 then exit;
  if MessageDlg('Вы уверены что хотите удалить кабинет '+Edit1.Text,
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  tblRooms.Open;
  tblRooms.First;
  for i:=1 to tblRooms.RecordCount do
    if tblRooms.FieldByName('Номер кабинета').Value=Edit1.Text then
      tblRooms.Delete
    else tblRooms.Next;
  tblRooms.Close;
  RoomListBox.Clear;
  showRooms;
  Edit1.Text:='';

end;


procedure TfrmRooms.ChangeRoomButtonClick(Sender: TObject);
var i: integer;
begin

  flag1:= not flag1;
  if flag1 then
   begin
    RoomListBox.Enabled:=false;
    AddRoomButton.Enabled:=false;
    DelRoomButton.Enabled:=false;
    ExitButton.Enabled:=false;
    roomID:=frmmain.getRoomID(Edit1.Text);
    ChangeRoomButton.Caption:='Принять';
   end
   else begin
    RoomListBox.Enabled:=true;
    AddRoomButton.Enabled:=true;
    DelRoomButton.Enabled:=true;
    ExitButton.Enabled:=true;
    TblRooms.Open;
    TblRooms.First;
    for i:=1 to TblRooms.RecordCount do
      if TblRooms.FieldByName('ID кабинета').Value=roomID then
       begin
        TblRooms.Edit;
        TblRooms.FieldByName('Номер кабинета').value:=Edit1.Text;
        TblRooms.Post;
        break;
       end
       else TblRooms.Next;
    ChangeRoomButton.Caption:='Изменить';
    TblRooms.Close;
    RoomListBox.Clear;
    showRooms;
   end;

end;


procedure TfrmRooms.FormShow(Sender: TObject);
begin
  showRooms;
end;

end.
