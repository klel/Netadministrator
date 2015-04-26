unit UExec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFExec = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FExec: TFExec;

implementation

{$R *.dfm}

procedure TFExec.Button1Click(Sender: TObject);
begin
if ComboBox1.ItemIndex=-1 then
begin
  WinExec(pchar('psexec.exe '+Edit1.Text+' '+Edit2.Text), sw_show);
  WinExec(pchar('pause'), sw_show);
end
  else WinExec(pchar('cmd psexec.exe '+Edit1.Text+' -i '+Edit2.Text), sw_show);
 WinExec(pchar('pause'), sw_show);
end;



end.
