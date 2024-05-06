program DVDRental;

uses
  Vcl.SvcMgr,
  Main.Service in 'src\Main.Service.pas' {MainService: TService},
  Providers.Connection in 'src\Providers\Providers.Connection.pas' {ProvidersConnection: TDataModule},
  Services.Acesso in 'src\Services\Services.Acesso.pas' {ServicesAcesso: TDataModule},
  Controllers.Acesso in 'src\Controllers\Controllers.Acesso.pas',
  Classes.AuthClaims in 'src\Classes\Classes.AuthClaims.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TMainService, MainService);
  Application.CreateForm(TProvidersConnection, ProvidersConnection);
  Application.CreateForm(TServicesAcesso, ServicesAcesso);
  Application.Run;
end.
