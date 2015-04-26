unit formAddSwitch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBTables;

type
  TFrmAddSwitch = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    SerNumLabel: TEdit;
    InvNumLabel: TEdit;
    QuantPortLabel: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    TableSwitches: TTable;
    TablePorts: TTable;
    TableConnections: TTable;
    GroupBox4: TGroupBox;
    ModelComboBox: TComboBox;
    TblModels: TTable;
    QuantPortLabel2: TEdit;
    function findID(text: string): integer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddSwitch: TFrmAddSwitch;
  added: Boolean;

implementation

uses mainform;

{$R *.dfm}

procedure TFrmAddSwitch.FormCreate(Sender: TObject);
begin
  FrmAddSwitch.Left:=round(Screen.Width/2)
  -round(FrmAddSwitch.Width/2);
  FrmAddSwitch.top:=round(Screen.Height/2)-
  round(FrmAddSwitch.Height/2);
  TableSwitches.DatabaseName:='myDB';
  TableSwitches.TableName:='tblSwitches';
end;

function TFrmAddSwitch.findID(text: string): integer;
var i: integer;
begin
  TableSwitches.Open;
  TableSwitches.First;
  for i:=1 to TableSwitches.RecordCount do
   begin
    if text=TableSwitches.FieldByName('инвентарный номер').Value then
     begin
      findID:=TableSwitches.fieldByName('ID свитча').value;
      Exit;
     end;
    TableSwitches.Next;
   end;
  findID:=0;
end;

procedure TFrmAddSwitch.Button1Click(Sender: TObject);
var checking, checking2: Boolean;
    i: integer;
    str, str2: string;
    tempID,tempCount: integer;
begin
//проверки===========================
  added:=false;
  if (Length(SerNumLabel.Text)<1) or
      (Length(InvNumLabel.Text)<1) or
      (Length(QuantPortLabel.Text)<1) then
   begin
    MessageDlg('Заполните поля ''Серийный номер'', '+
    '''Инвентарный номер'' и ''Количество портов''',
    mtWarning,[mbOK],0);
    exit;
   end;
  if ModelComboBox.ItemIndex<0 then
   begin
    ShowMessage('Выберите модель');
    exit;
   end;

  str:=QuantPortLabel.Text;
   str2:=QuantPortLabel2.Text;
  checking:=false;
  if Length(str)>0 then
    for i:=1 to length(str) do
     begin
      case str[i] of
       '0','1','2','3','4','5','6','7',
       '8','9': checking:=true;
       else
        begin
         checking:=false;
         break;
        end;
      end;
     end;
  if checking=true then
  if (strtoint(str)<0)or(strtoint(str)>48) then checking:=false;

  if not checking then
   begin
    MessageDlg('Количество портов должно быть целым числом'+
    ' от 0 до 48',
    mtWarning,[mbOK],0);
    exit;
   end;
   //******************************************
   checking2:=false;
   if Length(str2)>0 then
    for i:=1 to length(str2) do
     begin
      case str2[i] of
       '0','1','2','3','4','5','6','7',
       '8','9': checking2:=true;
       else
        begin
         checking2:=false;
         break;
        end;
      end;
     end;
  if checking2=true then
  if (strtoint(str2)<0)or(strtoint(str2)>12) then checking2:=false;

  if not checking2 then
   begin
    MessageDlg('Количество гигабитных портов должно быть целым числом'+
    ' от 0 до 12',
    mtWarning,[mbOK],0);
    exit;
   end;
//===========================

//==adding to table tblSwitches============
  TableSwitches.Open;
  TableSwitches.Append;
  TableSwitches.FieldByName('серийный номер').value:=
  SerNumLabel.Text;
  TableSwitches.FieldByName('инвентарный номер').value:=
  InvNumLabel.Text;
  TableSwitches.FieldByName('количество портов').value:=
  strtoint(QuantPortLabel.Text)+strtoint(QuantPortLabel2.Text);
  TableSwitches.FieldByName('количество гиг портов').value:=
  strtoint(QuantPortLabel2.Text);
  TableSwitches.FieldByName('ID модели').Value:=
  FrmMain.getModelID(ModelComboBox.Items.Strings[ModelComboBox.ItemIndex]);
  TableSwitches.Post;
  TableSwitches.Close;

  tempID:=findID(InvNumLabel.Text);
  tempCount:=strtoint(QuantPortLabel.Text)+strtoint(QuantPortLabel2.Text);
  //TableSwitches.fieldByName('количество портов').AsInteger;
  TableSwitches.Close;
//====adding to table tblPorts=================
  TablePorts.Open;
  for i:=1 to tempCount do
   begin
    TablePorts.Append;
    TablePorts.FieldByName('номер порта').Value:=i;
    TablePorts.FieldByName('ID свитча').value:=tempID;
    TablePorts.Post;
   end;
  TablePorts.Close;
//====adding to table tblConnections==================
  TableConnections.Open;
  for i:=1 to tempCount do
   begin
    TableConnections.Append;
    TableConnections.FieldByName('ID порта').value:= FrmMain.getPortID(i,InvNumLabel.Text);
    TableConnections.FieldByName('ID сотрудника').value:=0;
    TableConnections.FieldByName('ID кабинета').value:=0;
    TableConnections.FieldByName('ID розетки').value:=0;
    TableConnections.FieldByName('ID IP').value:=0;
    TableConnections.Post;
   end;
  TableConnections.Close;

//=============================================
  added:=true;
  FrmAddSwitch.Close;

end;

procedure TFrmAddSwitch.Button2Click(Sender: TObject);
begin
  FrmAddSwitch.Close;
end;

procedure TFrmAddSwitch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SerNumLabel.Text:='';
  InvNumLabel.Text:='';
  QuantPortLabel.Text:='';
  QuantPortLabel2.Text:='';
end;

procedure TFrmAddSwitch.FormShow(Sender: TObject);
var i: integer;
begin
  TblModels.Open;
  TblModels.First;
  ModelComboBox.Clear;
  for i:=1 to TblModels.RecordCount do
   begin
    ModelComboBox.Items.Add(TblModels.fieldByName('Модель').Value);
    TblModels.Next;
   end;
  TblModels.Close;
end;



end.
