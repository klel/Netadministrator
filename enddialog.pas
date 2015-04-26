unit enddialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;
Const N = 100;

type
  Tenddlg = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  enddlg: Tenddlg;
  x, y, c:  array[1..N] of integer;
implementation

{$R *.dfm}





end.
