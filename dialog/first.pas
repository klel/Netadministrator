unit first;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, XPMan;

type
  TFfrm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Button1: TButton;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ffrm: TFfrm;

implementation

uses dialog1;

{$R *.dfm}

procedure TFfrm.Button1Click(Sender: TObject);
begin
dlgform1.Show;
ShowWindow (handle,0);
end;

end.
