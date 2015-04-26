unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Menus, ComCtrls, Mask, OleServer, WordXP,
  RpRave, RpDefine, RpCon, RpConDS, RpBase, RpSystem, RpRender, RpRenderPDF,
  RpRenderRTF, ImgList, ExtCtrls, jpeg, Buttons,ShellApi;

type
  TMain = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    Label5: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    rDate: TDateTimePicker;
    Label6: TLabel;
    Button5: TButton;
    DateEdit: TDBEdit;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    RvDataSetConnection1: TRvDataSetConnection;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    RvRenderRTF1: TRvRenderRTF;
    N6: TMenuItem;
    MVHelp1: TMenuItem;
    N7: TMenuItem;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    ControlBar1: TControlBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure ChangeDate(Sender: TObject);
    procedure CopyDate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Create(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure MVHelp1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses Unit2, Unit3, Unit4, Unit5;

{$R *.dfm}





procedure TMain.Button1Click(Sender: TObject);
begin
 FioEnter.ShowModal;
end;

procedure TMain.Button2Click(Sender: TObject);
begin
PostEnter.ShowModal;
end;

procedure TMain.Button3Click(Sender: TObject);
begin
  FioEnter.ShowModal;
end;

procedure TMain.Button4Click(Sender: TObject);
begin
  PostEnter.ShowModal;
end;


procedure TMain.Button5Click(Sender: TObject);
begin
 if (Application.MessageBox(PChar('Сформировать заявку?'),'Заявка',MB_OKCANCEL)= idOK) and (Comp.ADOTable1.Modified)
   then
      begin
        Comp.ADOTable1.Post;
          {with RvSystem1 do
              begin
                DoNativeOutput:= False;
                RenderObject:= RvRenderRtf1;
                OutputFileName:= 'request.rtf';
              end;}
        RvProject1.Execute;
      end

end;



procedure TMain.N3Click(Sender: TObject);
begin
PostEnter.ShowModal;
end;

procedure TMain.N4Click(Sender: TObject);
begin
Close;
end;

procedure TMain.N5Click(Sender: TObject);
begin
FIOEnter.ShowModal;
end;

procedure TMain.ChangeDate(Sender: TObject);
begin
DateEdit.Text:= DateToStr(rDate.Date);
end;

procedure TMain.CopyDate(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
DateEdit.Text:= DateToStr(rDate.Date);
end;




procedure TMain.Create(Sender: TObject);
begin
Comp.ADOTable1.Insert;
end;

procedure TMain.N7Click(Sender: TObject);
begin
About.ShowModal;
end;

procedure TMain.BitBtn1Click(Sender: TObject);
begin
FIOEnter.ShowModal;
end;

procedure TMain.BitBtn2Click(Sender: TObject);
begin
PostEnter.ShowModal;
end;

procedure TMain.BitBtn3Click(Sender: TObject);
begin
Close;
end;

procedure TMain.BitBtn4Click(Sender: TObject);
begin
ShellExecute(Main.Handle,nil,'help.docx',nil,nil,SW_RESTORE);
end;

procedure TMain.MVHelp1Click(Sender: TObject);
begin
ShellExecute(Main.Handle,nil,'help.docx',nil,nil,SW_RESTORE);
end;

end.
