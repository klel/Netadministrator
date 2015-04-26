unit PingUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Ping, Spin, Buttons, ComCtrls, ToolWin, Mask;

type
  TPingForm = class(TForm)
    Ping1: TPing;
    RichEdit1: TRichEdit;
    Panel1: TPanel;
    Label2: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Ping1DnsLookupDone(Sender: TObject; Error: Word);
    procedure Ping1EchoReply(Sender, Icmp: TObject; Error: Integer);
    procedure Ping1EchoRequest(Sender, Icmp: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PingForm: TPingForm;

implementation

{$R *.DFM}

procedure TPingForm.Button1Click(Sender: TObject);
begin
 RichEdit1.Lines.Add('Посик ''' + Edit1.Text + '''');
 Ping1.Size:=StrToInt(Edit2.Text);
 Ping1.TimeOut:=StrToInt(Edit3.Text);
 Ping1.TTL:=StrToInt(Edit4.Text);
 Ping1.DnsLookup(Edit1.Text);
end;

procedure TPingForm.Ping1DnsLookupDone(Sender: TObject; Error: Word);
begin
 if Error <> 0 then
  begin
   RichEdit1.Lines.Add('Хост не найден ''' + Edit1.Text + '''');
   Exit;
  end;

 RichEdit1.Lines.Add('Хост ''' + Edit1.Text + ''' - ' + Ping1.DnsResult);
 RichEdit1.Lines.Add('');

 Ping1.Address := Ping1.DnsResult;
 Ping1.Ping;
end;

procedure TPingForm.Ping1EchoReply(Sender, Icmp: TObject; Error: Integer);
begin
 if Error = 0 then
  RichEdit1.Lines.Add('Немогу выполнить операцию ping: '+Ping1.ErrorString)
 else
  RichEdit1.Lines.Add('Получено ' + IntToStr(Ping1.Reply.DataSize)+' байт от '+Ping1.HostIP+' за ' + IntToStr(Ping1.Reply.RTT)+' милисекунд');
end;

procedure TPingForm.Ping1EchoRequest(Sender, Icmp: TObject);
begin
 RichEdit1.Lines.Add('Посылка ' + IntToStr(Ping1.Size) +
     ' байтов на ' + Ping1.HostName);
end;

end.
