unit dialog1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, ExtCtrls;

type
  Tdlgform1 = class(TForm)
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgform1: Tdlgform1;
  reg:Tregistry;

implementation

uses enddialog, first;

{$R *.dfm}

procedure Tdlgform1.Button1Click(Sender: TObject);
begin
  if RadioButton1.Checked then
     begin
       reg:=TRegistry.Create;            //not finished
       try
          reg.RootKey:=HKEY_LOCAL_MACHINE;
          reg.OpenKey('software\diploma\',true );
          reg.WriteBool('cisco',true);
          reg.WriteBool('simple',true);
          reg.Free;
          enddlg.Show;
          ShowWindow (handle,0);
        except
          ShowMessage ('Ошибка работы с реестром');
          reg.Free;
        end
       end
  else
  if RadioButton2.Checked then
      begin
        reg:=TRegistry.Create;
        try
          reg.RootKey:=HKEY_LOCAL_MACHINE;
          reg.OpenKey('software\diploma\',true );
          reg.WriteBool('execflag',false);
          reg.WriteBool('simple',true);
          reg.WriteBool('cisco',false);
          //ShowMessage('created');
          reg.WriteInteger('ColSwiches',0);
          reg.Free;
          enddlg.Show;
          ShowWindow (handle,0);
        except
          ShowMessage ('Ошибка работы с реестром');
          reg.Free;
        end;
      end;
end;

procedure Tdlgform1.Button2Click(Sender: TObject);
begin
dlgform1.Close;
end;

procedure Tdlgform1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ffrm.Close;
end;

procedure Tdlgform1.RadioButton1Click(Sender: TObject);
begin
 Button1.Enabled:=True;
end;

procedure Tdlgform1.RadioButton2Click(Sender: TObject);
begin
 Button1.Enabled:=True;
end;

end.
