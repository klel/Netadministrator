program Project2;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Main},
  Unit2 in 'Unit2.pas' {Comp: TDataModule},
  Unit3 in 'Unit3.pas' {FIOEnter},
  Unit4 in 'Unit4.pas' {PostEnter},
  Unit5 in 'Unit5.pas' {About};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TComp, Comp);
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TFIOEnter, FIOEnter);
  Application.CreateForm(TPostEnter, PostEnter);
  Application.CreateForm(TAbout, About);
  Application.Run;
end.
