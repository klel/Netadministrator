unit UPing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ButtonGroup;

type
  TfrmPING = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StatusBar1: TStatusBar;
    ProgressBar1: TProgressBar;
    ButtonGroup1: TButtonGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPING: TfrmPING;

implementation

uses Functions;

{$R *.dfm}

procedure TfrmPING.BitBtn1Click(Sender: TObject);
var
  i:integer;
begin
 if Edit1.Text>'' then
   begin
     memo1.Lines.Clear;
     progressbar1.Position:=0;
     Functions.Ping (Edit1.Text,Memo1);
     for i := 0 to progressbar1.max  do  progressbar1.Position:=i;
   end
 else
     ShowMessage ('Введите ip или имя хоста, который Вы хотите пинговать!');

end;


procedure TfrmPING.BitBtn2Click(Sender: TObject);
begin
if Edit1.Text>'' then
  WinExec(pchar('ping.exe '+Edit1.Text+' -t'), sw_show)
 else
     ShowMessage ('Введите ip или имя хоста, который Вы хотите пинговать!');
end;

procedure TfrmPING.FormShow(Sender: TObject);
begin
label1.Font.Size:=9;
Label1.Caption:='ping — утилита для проверки '+#13+
                 'соединений в сетях на основе TCP/IP';

end;

end.
