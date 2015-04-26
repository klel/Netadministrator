unit formStaff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables;

type
  TfrmStaff = class(TForm)
    GroupBox1: TGroupBox;
    StaffListBox: TListBox;
    ExitButton: TButton;
    Edit1: TEdit;
    AddStaffButton: TButton;
    DelStaffButton: TButton;
    TblStaff: TTable;
    ChangeStaffButton: TButton;
    procedure showStaff;
    procedure FormCreate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure StaffListBoxClick(Sender: TObject);
    procedure AddStaffButtonClick(Sender: TObject);
    procedure DelStaffButtonClick(Sender: TObject);
    procedure ChangeStaffButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStaff: TfrmStaff;
  flag1: boolean;
  staffID: integer;

implementation

uses mainform;

{$R *.dfm}

procedure TfrmStaff.FormCreate(Sender: TObject);
begin

  StaffListBox.MultiSelect:=False;
  frmStaff.Left:=round(Screen.Width/2)
  -round(frmStaff.Width/2);
  frmStaff.top:=round(Screen.Height/2)-
  round(frmStaff.Height/2);

end;


procedure TfrmStaff.showStaff;
var i: integer;

begin
  StaffListBox.Clear;
  TblStaff.Open;
  TblStaff.First;
  for i:=1 to TblStaff.RecordCount do
   begin
    StaffListBox.Items.Add(TblStaff.fieldByName('ФИО сотрудника').Value);
    TblStaff.Next;
   end;
  TblStaff.Close;
  StaffListBox.Sorted:=true;

end;


procedure TfrmStaff.ExitButtonClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmStaff.StaffListBoxClick(Sender: TObject);
begin
  if StaffListBox.ItemIndex>-1 then
  Edit1.Text:=StaffListBox.Items.Strings[StaffListBox.ItemIndex];
end;


procedure TfrmStaff.AddStaffButtonClick(Sender: TObject);
var i: integer;
begin

  if length(Edit1.Text)=0 then exit;
  TblStaff.Open;
  TblStaff.First;
  for i:=1 to TblStaff.RecordCount do
    if Edit1.Text=TblStaff.FieldByName('ФИО сотрудника').Value then
     begin
      ShowMessage('Такой сотрудник уже есть');
      exit;
     end
     else TblStaff.Next;
  TblStaff.Append;
  TblStaff.FieldByName('ФИО сотрудника').Value:=Edit1.Text;
  TblStaff.Post;
  TblStaff.Close;
  StaffListBox.Clear;
  showStaff;
  Edit1.Text:='';

end;


procedure TfrmStaff.DelStaffButtonClick(Sender: TObject);
var i: integer;
begin

  if Length(Edit1.Text)=0 then exit;
  if MessageDlg('Вы уверены что хотите удалить сотрудника '+Edit1.Text,
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  TblStaff.Open;
  TblStaff.First;
  for i:=1 to TblStaff.RecordCount do
    if TblStaff.FieldByName('ФИО сотрудника').Value=Edit1.Text then
      TblStaff.Delete
    else TblStaff.Next;
  TblStaff.Close;
  StaffListBox.Clear;
  showStaff;
  Edit1.Text:='';
  
end;


procedure TfrmStaff.ChangeStaffButtonClick(Sender: TObject);
var i: integer;

begin

  flag1:= not flag1;
  if flag1 then
   begin
    StaffListBox.Enabled:=false;
    AddStaffButton.Enabled:=false;
    DelStaffButton.Enabled:=false;
    ExitButton.Enabled:=false;
    staffID:=FrmMain.getStaffID(Edit1.Text);
    ChangeStaffButton.Caption:='Принять';
   end
   else begin
    AddStaffButton.Enabled:=true;
    DelStaffButton.Enabled:=true;
    ExitButton.Enabled:=true;
    StaffListBox.Enabled:=true;
    TblStaff.Open;
    TblStaff.First;
    for i:=1 to TblStaff.RecordCount do
      if TblStaff.FieldByName('ID сотрудника').Value=staffID then
       begin
        TblStaff.Edit;
        TblStaff.FieldByName('ФИО сотрудника').value:=Edit1.Text;
        TblStaff.Post;
        break;
       end
       else TblStaff.Next;
    ChangeStaffButton.Caption:='Изменить';
    TblStaff.Close;
    StaffListBox.Clear;
    showStaff;
   end;

end;


procedure TfrmStaff.FormShow(Sender: TObject);
begin
  showStaff;
  flag1:=false;
end;

end.
