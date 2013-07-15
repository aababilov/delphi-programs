program Japanese;

uses
  Forms,
  Main in 'Main.pas' {JapaneseForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TJapaneseForm, JapaneseForm);
  Application.Run;
end.
