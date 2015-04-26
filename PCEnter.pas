unit PCEnter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls;

type
  TPCDataEnter = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ShowData(Sender: TObject);
  private
    { Private declarations }
  public
   pcGener:byte;
  end;

const
INI_NAME='Data.ini';

var
  PCDataEnter: TPCDataEnter;
  ini:TIniFile;
implementation

{$R *.dfm}
procedure TPcDataEnter.Button1Click(Sender: TObject);
begin
////////////////////////Save Data//////////////////////////////////////
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  ini.WriteString('PC'+IntToStr(pcGener),'DataExist','');
  ini.WriteString ('PC'+IntToStr(pcGener),'DNS',Edit1.Text);
  ini.WriteString ('PC'+IntToStr(pcGener),'Place',Edit3.Text);
  ini.WriteString ('PC'+IntToStr(pcGener),'Note',Edit4.Text);
ini.Free;
Self.Close;
end;

procedure TPcDataEnter.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TPcDataEnter.ShowData(Sender: TObject);
begin
 /////////filling data on Edit fields///////////////
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  if ini.ValueExists('PC'+IntToStr(pcGener),'DataExist') then
     begin
       Edit1.Text:=ini.ReadString('PC'+IntToStr(pcGener),'DNS','') ;
       Edit3.Text:=ini.ReadString('PC'+IntToStr(pcGener),'Place','');
       Edit4.Text:=ini.ReadString('PC'+IntToStr(pcGener),'Note','');

     end
     else
      begin
       Edit1.Text:='';
       Edit3.Text:='';
       Edit4.Text:='';
      end;
ini.Free;
end;



end.
