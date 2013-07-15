program VeroProj;

uses
  Forms,
  Verounit in 'Verounit.pas' {FMain},
  ParamRot in 'ParamRot.pas' {Parametres};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TParametres, Parametres);
  Application.Run;
end.
