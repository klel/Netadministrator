unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Menus;

type
  TPostEnter = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Button3: TButton;
    Button4: TButton;
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
  PostEnter: TPostEnter;

implementation

uses Unit2;



{$R *.dfm}

procedure TPostEnter.Button1Click(Sender: TObject);
begin
Close;
end;



procedure TPostEnter.Button2Click(Sender: TObject);
begin
if Comp.ADOFio.Modified then
   Comp.ADOFio.Post;
Application.MessageBox(PChar('Данный успешно занесены\удалены!'),'Записано',MB_OK);
Close;
end;

procedure TPostEnter.Button3Click(Sender: TObject);
begin
Comp.ADOPost.Insert;
DbGrid1.SetFocus;
end;

procedure TPostEnter.Button4Click(Sender: TObject);
begin
Comp.ADOPost.Delete;
end;

procedure TPostEnter.N1Click(Sender: TObject);
begin
Comp.ADOPost.Insert;
DbGrid1.SetFocus;
end;

procedure TPostEnter.N2Click(Sender: TObject);
begin
Comp.ADOPost.Delete;
end;

end.
