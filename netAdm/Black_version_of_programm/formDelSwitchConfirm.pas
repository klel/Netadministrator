unit formDelSwitchConfirm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmDelSwitchConfirm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDelSwitchConfirm: TfrmDelSwitchConfirm;
  res: Shortint;
  password: string;

implementation

uses Math;

{$R *.dfm}

procedure TfrmDelSwitchConfirm.FormCreate(Sender: TObject);
begin
  res:=0;
  password:='delete';
end;

procedure TfrmDelSwitchConfirm.Button1Click(Sender: TObject);
begin
  if Edit1.Text=password then
   begin
    res:=1;
    Edit1.text:='';
    frmDelSwitchConfirm.Close;
   end
   else Edit1.Text:='';
end;

procedure TfrmDelSwitchConfirm.Button2Click(Sender: TObject);
begin
  res:=0;
  Edit1.text:='';
  frmDelSwitchConfirm.Close;
end;

end.
