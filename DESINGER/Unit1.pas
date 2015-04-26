unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,{-->}Designer{<--}, Menus, ComCtrls, jpeg, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Active1: TMenuItem;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    RadioGroup1: TRadioGroup;
    Image1: TImage;
    TrackBar1: TTrackBar;
    Savepositions1: TMenuItem;
    Loadpositions1: TMenuItem;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure Active1Click(Sender: TObject);
    procedure Savepositions1Click(Sender: TObject);
    procedure Loadpositions1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  d:TDesigner;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
d:=TDesigner.Create(Form1);
d.IniFile:=application.ExeName+'.ini';
end;

procedure TForm1.Active1Click(Sender: TObject);
begin
self.Active1.Checked:= not self.Active1.Checked;
d.Active:=not d.Active;
end;

procedure TForm1.Savepositions1Click(Sender: TObject);
begin
d.SavePosition;
end;

procedure TForm1.Loadpositions1Click(Sender: TObject);
begin
d.LoadPosition;
end;

end.
