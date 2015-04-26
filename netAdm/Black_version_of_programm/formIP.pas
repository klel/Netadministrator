unit formIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls;

type
  TfrmIP = class(TForm)
    GroupBox1: TGroupBox;
    IPListBox: TListBox;
    Edit1: TEdit;
    AddIPButton: TButton;
    DelIPButton: TButton;
    ChangeIPButton: TButton;
    ExitButton: TButton;
    TblIP: TTable;
    TblConnections: TTable;
    procedure ExitButtonClick(Sender: TObject);
    procedure ChangeIPButtonClick(Sender: TObject);
    procedure AddIPButtonClick(Sender: TObject);
    procedure DelIPButtonClick(Sender: TObject);
    procedure showIP;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IPListBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIP: TfrmIP;
  flag1: boolean;
  IPID: integer;

implementation

uses mainform;

{$R *.dfm}

procedure TfrmIP.FormCreate(Sender: TObject);
begin

  IPListBox.MultiSelect:=False;
  frmIP.Left:=round(Screen.Width/2)
  -round(frmIP.Width/2);
  frmIP.top:=round(Screen.Height/2)-
  round(frmIP.Height/2);
 

end;


procedure TfrmIP.showIP;
var i: integer;

begin
  IPListBox.Clear;
  TblIP.Open;
  TblIP.First;
  for i:=1 to TblIP.RecordCount do
   begin
    IPListBox.Items.Add(TblIP.fieldByName('IP').Value);
    TblIP.Next;
   end;
   TblIP.Close;
   IPListBox.Sorted:=true;

end;

procedure TfrmIP.ExitButtonClick(Sender: TObject);
begin
 Close;
end;


procedure TfrmIP.AddIPButtonClick(Sender: TObject);
var i: integer;
begin
if length(Edit1.Text)=0 then exit;
  TblIP.Open;
  TblIP.First;
  for i:=1 to TblIP.RecordCount do
    if Edit1.Text=TblIP.FieldByName('IP').Value then
     begin
      ShowMessage('Такой IP адрес уже есть');
      exit;
     end
     else TblIP.Next;
  TblIP.Append;
  TblIP.FieldByName('IP').Value:=Edit1.Text;
  TblIP.Post;
  TblIP.Close;
  IPListBox.Clear;
  showIP;
  Edit1.Text:='';
end;

procedure TfrmIP.DelIPButtonClick(Sender: TObject);
var i: integer;
begin
  if Length(Edit1.Text)=0 then exit;
  if MessageDlg('Вы уверены что хотите удалить IP адрес '+Edit1.Text,
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  TblIP.Open;
  TblIP.First;
  for i:=1 to TblIP.RecordCount do
    if TblIP.FieldByName('IP').Value=Edit1.Text then
      TblIP.Delete
    else TblIP.Next;
  TblIP.Close;
  IPListBox.Clear;
  showIP;
  Edit1.Text:='';
end;

procedure TfrmIP.FormShow(Sender: TObject);
begin
  showIP;
  flag1:=false;
end;           

procedure TfrmIP.ChangeIPButtonClick(Sender: TObject);
var i: integer;
begin
flag1:= not flag1;
  if flag1 then
   begin
    IPListBox.Enabled:=false;
    AddIPButton.Enabled:=false;
    DelIPButton.Enabled:=false;
    ExitButton.Enabled:=false;
    IPID:=FrmMain.getIPID(Edit1.Text);
    ChangeIPButton.Caption:='Принять';
   end
   else begin
    AddIPButton.Enabled:=true;
    DelIPButton.Enabled:=true;
    ExitButton.Enabled:=true;
    IPListBox.Enabled:=true;
    TblIP.Open;
    TblIP.First;
    for i:=1 to TblIP.RecordCount do              //////////////////////////
      if TblIP.FieldByName('ID IP').Value=IPID then ////////////////////////
       begin
        TblIP.Edit;
        TblIP.FieldByName('IP').value:=Edit1.Text;
        TblIP.Post;
        break;
       end
       else TblIP.Next;
    ChangeIPButton.Caption:='Изменить';
    TblIP.Close;
    IPListBox.Clear;
    showIP;
   end;
end;


procedure TfrmIP.IPListBoxClick(Sender: TObject);
begin
if IPListBox.ItemIndex>-1 then
  Edit1.Text:=IPListBox.Items.Strings[IPListBox.ItemIndex];
end;

end.
