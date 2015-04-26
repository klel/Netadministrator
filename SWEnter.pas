unit SWEnter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, IniFiles;

type
  TSwDataEnter = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    procedure Button1Click(Sender: TObject);
    procedure ShowData(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
    swGener:byte;

  end;

const
  INI_NAME='Data.ini';

var
  SwDataEnter: TSwDataEnter;
  ini:TIniFile;


implementation

uses DataAcc;

{$R *.dfm}

procedure TSwDataEnter.Button1Click(Sender: TObject);
var
  ch:byte;
  i:byte;
begin
////////////////////////Save Data//////////////////////////////////////
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  ch:=StrToInt(Edit2.Text);
  ini.WriteString('Swich'+IntToStr(swGener),'DataExist','');
  ini.WriteInteger('Swich'+IntToStr(swGener),'ColPort',ch);
  ini.WriteString ('Swich'+IntToStr(swGener),'Brand',Edit1.Text);
  ini.WriteString ('Swich'+IntToStr(swGener),'Place',Edit3.Text);
  ini.WriteString ('Swich'+IntToStr(swGener),'Inventary',Edit4.Text);
    For i:=1 to ch do
      ini.WriteString('Swich'+IntToStr(swGener),'port'+intToStr(i),'');
ini.Free;
Self.Close;
end;

procedure TSwDataEnter.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TSwDataEnter.ShowData(Sender: TObject);
begin
 /////////filling data on Edit fields///////////////
  Ini:=TiniFile.Create(extractfilepath(Application.ExeName)+INI_NAME);
  if ini.ValueExists('Swich'+IntToStr(swGener),'DataExist') then
     begin
       Edit1.Text:=ini.ReadString('Swich'+IntToStr(swGener),'Brand','') ;
       Edit3.Text:=ini.ReadString('Swich'+IntToStr(swGener),'Place','');
       Edit4.Text:=ini.ReadString('Swich'+IntToStr(swGener),'Inventary','');
       Edit2.Text:=IntToStr(ini.ReadInteger('Swich'+IntToStr(swGener),'ColPort',8));
     end
     else
      begin
         Edit1.Text:='';
       Edit3.Text:='';
       Edit4.Text:='';
       Edit2.Text:='8';
      end;
ini.Free;
end;

end.
