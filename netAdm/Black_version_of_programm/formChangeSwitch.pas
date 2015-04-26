unit formChangeSwitch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBTables;

type
  TfrmChangeSwitch = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    SerNumLabel: TEdit;
    InvNumLabel: TEdit;
    QuanPortLabel: TEdit;
    Table1: TTable;
    GroupBox4: TGroupBox;
    ModelComboBox: TComboBox;
    TblModels: TTable;
    procedure fillModels;
    procedure FormCreate(Sender: TObject);
    procedure fillEdits();
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
//    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChangeSwitch: TfrmChangeSwitch;
  ports: integer;
  ischange: Boolean;
  oldSer,oldInv,oldModel: string;
  oldModelID: integer;


implementation

uses mainform;

{$R *.dfm}

procedure TfrmChangeSwitch.FormCreate(Sender: TObject);
begin
  FrmChangeSwitch.Left:=round(Screen.Width/2)
  -round(FrmChangeSwitch.Width/2);
  FrmChangeSwitch.top:=round(Screen.Height/2)-
  round(FrmChangeSwitch.Height/2);


end;


procedure TfrmChangeSwitch.fillModels;
var i: integer;
begin
  TblModels.Open;
  TblModels.First;
  ModelComboBox.Clear;
  for i:=1 to TblModels.RecordCount do
   begin
    ModelComboBox.Items.Add(TblModels.fieldByName('ћодель').Value);
    TblModels.Next;
   end;
  TblModels.Close;
end;


procedure TfrmChangeSwitch.fillEdits();
var i: integer;
begin
  if switchNumForChange>0 then
   begin
    fillModels;
    oldModelID:=0;
    Table1.Open;
    Table1.First;
    for i:=1 to switchNumForChange-1 do
      Table1.Next;
    SerNumLabel.Text:=Table1.fieldbyname('серийный номер').value;
    InvNumLabel.Text:=Table1.fieldbyname('инвентарный номер').value;
    QuanPortLabel.Text:=
    IntToStr(Table1.fieldbyname('количество портов').value);
    if (Table1.fieldByName('ID модели').AsString<>'') then
      oldModelID:=Table1.fieldByName('ID модели').Value;
    oldModel:=FrmMain.getModel(oldModelID);
    for i:=0 to ModelComboBox.Items.Count-1 do
      if ModelComboBox.Items.Strings[i]=oldModel then
        ModelComboBox.ItemIndex:=i;

    Table1.Close;
    ports:=strtoint(QuanPortLabel.Text);
    oldSer:=SerNumLabel.Text;
    oldInv:=InvNumLabel.Text;
   end;
end;

procedure TfrmChangeSwitch.Button2Click(Sender: TObject);
begin
//отмена изменений=======================
  SerNumLabel.Text:='';
  InvNumLabel.Text:='';
  QuanPortLabel.Text:='';
  ischange:=False;
  frmChangeSwitch.Close;
end;

procedure TfrmChangeSwitch.Button1Click(Sender: TObject);
var i: integer;
//    str: string;
begin
  ischange:=false;
  if (oldSer=SerNumLabel.Text)and(oldInv=InvNumLabel.Text)
  and(oldModel=ModelComboBox.Items.Strings[ModelComboBox.ItemIndex]) then
   begin
    frmChangeSwitch.Close;
    Exit;
   end;
//проверка на заполненность полей ввода=============================
  if (length(SerNumLabel.Text)<1)or
      (Length(InvNumLabel.Text)<1)or
      (Length(QuanPortLabel.Text)<1) then
   begin
    MessageDlg('«аполните все пол€',mtWarning,[mbOK],0);
    exit;
   end;
//проверка на целочисленность и количество введенного количества портов======
{  str:=QuanPortLabel.Text;
  for i:=1 to Length(str) do
   begin
    case str[i] of
    '0','1','2','3','4','5','6','7','8','9': ;
    else
     begin
      MessageDlg(' оличество портов должно быть целым числом от 2 до 24',
      mtWarning,[mbOK],0);
      exit;
     end;
    end;
   end;
  if (strtoint(str)<2)or(strtoint(str)>24)then
   begin
    MessageDlg(' оличество портов должно быть целым числом от 2 до 24',
    mtWarning,[mbOK],0);
    exit;
   end;     }
//внесение измененных данных=========================================
  Table1.Open;
  Table1.First;
  for i:=1 to Table1.RecordCount do
    if Table1.FieldByName('инвентарный номер').value=nameSwitchForChange
     then begin
      Table1.Edit;
      Table1.FieldByName('серийный номер').value:=
      SerNumLabel.Text;
      Table1.FieldByName('инвентарный номер').value:=
      InvNumLabel.Text;
      Table1.FieldByName('количество портов').value:=
      strtoint(QuanPortLabel.Text);
      Table1.FieldByName('ID модели').value:=
      FrmMain.getModelID(ModelComboBox.Items.Strings[ModelComboBox.ItemIndex]);
      Table1.Post;
      Table1.Close;
      ischange:=true;
      frmChangeSwitch.Close;
      break;
     end
     else Table1.Next;

end;

{procedure TfrmChangeSwitch.FormShow(Sender: TObject);
var i: integer;
begin
  TblModels.Open;
  TblModels.First;
  ModelComboBox.Clear;
  for i:=1 to TblModels.RecordCount do
   begin
    ModelComboBox.Items.Add(TblModels.fieldByName('ћодель').Value);
    TblModels.Next;
   end;
  TblModels.Close;

end;}

end.
