unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if CopyFile ('C:\Documents and Settings\klimov.en\Рабочий стол\PsTools.Zip','\\192.168.0.3\mv-club',true)
then ShowMessage ('Copy')
else ShowMessage ('nonCopy');
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  fl:TStringList;
begin
  fl:=TStringList.Create;
  fl.LoadFromFile();
end;

end.
