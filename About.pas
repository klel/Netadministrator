unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAboutfrm = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Aboutfrm: TAboutfrm;

implementation

{$R *.dfm}

procedure TAboutfrm.Button1Click(Sender: TObject);
begin
Close;
end;

end.
