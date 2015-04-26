unit PortEnter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  Tportform = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    PortGen:byte;
  end;
const
  INI_NAME='Data.ini';

var
  portform: Tportform;
  ini:TIniFile;
implementation

uses Swich;

{$R *.dfm}

procedure Tportform.Button1Click(Sender: TObject);
begin
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  ini.WriteString('Swich'+intToStr (SwichForm.GenerMessSw),'Port'+IntToStr(PortGen),Edit1.Text);
  ini.Free;
  SwichForm.portArray[PortForm.PortGen].Picture.LoadFromFile('.\pic\connected.bmp');
  Close;
end;

procedure Tportform.Button2Click(Sender: TObject);
begin
Close;
end;

end.
