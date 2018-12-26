program SS13_WP;

uses
  Vcl.Forms,
  SS13_WP_main in 'SS13_WP_main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
