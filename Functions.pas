unit Functions;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
procedure Ping(IP: String; OutMemo:TMemo);

implementation

uses UPing;

procedure Ping(IP: String; OutMemo:TMemo);
const BUFSIZE = 2000;
var SecAttr    : TSecurityAttributes;
   hReadPipe,
   hWritePipe : THandle;
   StartupInfo: TStartUpInfo;
   ProcessInfo: TProcessInformation;
   Buffer     : Pchar;
   WaitReason,
   BytesRead  : DWord;
begin
with SecAttr do
begin
  nlength              := SizeOf(TSecurityAttributes);
  binherithandle       := true;
  lpsecuritydescriptor := nil;
end;
if Createpipe (hReadPipe, hWritePipe, @SecAttr, 0) then
begin
  Buffer  := AllocMem(BUFSIZE + 1);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.hStdOutput  := hWritePipe;
  StartupInfo.hStdInput   := hReadPipe;
  StartupInfo.dwFlags     := STARTF_USESTDHANDLES +
                             STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;
   OutMemo.Lines.Add('Подождите немного..........');
  if CreateProcess(nil,
     PChar('ping.exe '+IP),
     @SecAttr,
     @SecAttr,
     true,
     NORMAL_PRIORITY_CLASS,
     nil,
     nil,
     StartupInfo,
     ProcessInfo) then
    begin
      repeat
        WaitReason := WaitForSingleObject( ProcessInfo.hProcess,100);
        Application.ProcessMessages;
      until (WaitReason <> WAIT_TIMEOUT);
      UPing.frmPING.ProgressBar1.Max:=BUFSIZE;
      Repeat
        BytesRead := 0;
        ReadFile(hReadPipe, Buffer[0], BUFSIZE, BytesRead, nil);
        Buffer[BytesRead]:= #0;
        OemToAnsi(Buffer,Buffer);
        OutMemo.Lines.Clear;
        OutMemo.Text := OutMemo.text + String(Buffer);
      until (BytesRead < BUFSIZE);
    end;
  FreeMem(Buffer);
  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(hReadPipe);
  CloseHandle(hWritePipe);
end;
end;

end.
