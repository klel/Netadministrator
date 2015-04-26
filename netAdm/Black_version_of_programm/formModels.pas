unit formModels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables;

type
  TfrmModels = class(TForm)
    GroupBox1: TGroupBox;
    ModelsListBox: TListBox;
    Edit1: TEdit;
    AddButton: TButton;
    DelButton: TButton;
    ChangeButton: TButton;
    ExitButton: TButton;
    tblModels: TTable;
    procedure showModels;
    procedure FormCreate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure ModelsListBoxClick(Sender: TObject);
    procedure ChangeButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModels: TfrmModels;
  flag2: boolean;
  modelID: integer;

implementation

uses mainform, Math;

{$R *.dfm}

procedure TfrmModels.FormCreate(Sender: TObject);
begin
  ModelsListBox.MultiSelect:=false;
  frmModels.Left:=round(Screen.Width/2)
  -round(frmModels.Width/2);
  frmModels.top:=round(Screen.Height/2)-
  round(frmModels.Height/2);
end;

procedure TfrmModels.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmModels.FormShow(Sender: TObject);
begin
  showModels;
end;

procedure TfrmModels.AddButtonClick(Sender: TObject);
var i: integer;
begin

  if length(Edit1.Text)=0 then exit;
  tblModels.Open;
  TblModels.First;
  for i:=1 to TblModels.RecordCount do
    if Edit1.Text=TblModels.FieldByName('Модель').Value then
     begin
      ShowMessage('Такая модель уже занесена');
      exit;
     end
     else TblModels.Next;
  TblModels.Append;
  TblModels.FieldByName('Модель').Value:=Edit1.Text;
  TblModels.Post;
  TblModels.Close;
  ModelsListBox.Clear;
  showModels;
  Edit1.Text:='';

end;


procedure TfrmModels.showModels;
var i: integer;
begin
  ModelsListBox.Clear;
  tblModels.Open;
  tblModels.First;
  for i:=1 to tblModels.RecordCount do
   begin
    ModelsListBox.Items.Add(tblModels.fieldByName('Модель').Value);
    tblModels.Next;
   end;
  tblModels.Close;
  flag2:=false;
end;


procedure TfrmModels.DelButtonClick(Sender: TObject);
var i: integer;
begin

  if Length(Edit1.Text)=0 then exit;
  if MessageDlg('Вы уверены что хотите удалить модель '+Edit1.Text,
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  TblModels.Open;
  TblModels.First;
  for i:=1 to TblModels.RecordCount do
    if TblModels.FieldByName('Модель').Value=Edit1.Text then
      TblModels.Delete
    else TblModels.Next;
  TblModels.Close;
  ModelsListBox.Clear;
  showModels;
  Edit1.Text:='';

end;

procedure TfrmModels.ModelsListBoxClick(Sender: TObject);
begin
  if ModelsListBox.ItemIndex>-1 then
  Edit1.Text:=ModelsListBox.Items.Strings[ModelsListBox.ItemIndex];
end;

procedure TfrmModels.ChangeButtonClick(Sender: TObject);
var i: integer;

begin

  flag2:= not flag2;
  if flag2 then
   begin
    ModelsListBox.Enabled:=false;
    AddButton.Enabled:=false;
    DelButton.Enabled:=false;
    ExitButton.Enabled:=false;
    modelID:=FrmMain.getModelID(Edit1.Text);
    ChangeButton.Caption:='Принять';
    If modelID=0 then ChangeButton.Click; 
   end
   else begin
    AddButton.Enabled:=true;
    DelButton.Enabled:=true;
    ExitButton.Enabled:=true;
    ModelsListBox.Enabled:=true;
    tblModels.Open;
    tblModels.First;
    for i:=1 to tblModels.RecordCount do
      if tblModels.FieldByName('ID модели').Value=modelID then
       begin
        tblModels.Edit;
        tblModels.FieldByName('Модель').value:=Edit1.Text;
        tblModels.Post;
        break;
       end
       else tblModels.Next;
    ChangeButton.Caption:='Изменить';
    tblModels.Close;
    ModelsListBox.Clear;
    showModels;
   end;

end;

end.
