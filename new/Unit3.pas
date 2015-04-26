unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Menus;

type
  TFIOEnter = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIOEnter: TFIOEnter;

implementation

uses Unit2;



{$R *.dfm}

procedure TFIOEnter.Button1Click(Sender: TObject);
begin
Close;
end;



procedure TFIOEnter.Button2Click(Sender: TObject);
begin
if Comp.ADOFio.Modified then
   Comp.ADOFio.Post;
Application.MessageBox(PChar('Данный успешно занесены\удалены!'),'Записано',MB_OK);
Close;
end;





procedure TFIOEnter.Button3Click(Sender: TObject);
begin
Comp.ADOFio.Insert;
DbGrid1.SetFocus;
end;

procedure TFIOEnter.Button4Click(Sender: TObject);
begin
Comp.ADOFIO.Delete;
end;

procedure TFIOEnter.N1Click(Sender: TObject);
begin
Comp.ADOFio.Insert;
DbGrid1.SetFocus;
end;

procedure TFIOEnter.N2Click(Sender: TObject);
begin
Comp.ADOFIO.Delete;
end;

end.
