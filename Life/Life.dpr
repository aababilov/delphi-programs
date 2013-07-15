program Life;

uses
  Forms,
  Main in 'Main.pas' {LifeForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLifeForm, LifeForm);
  Application.Run;
end.
