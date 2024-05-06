unit Providers.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.PGDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TProvidersConnection = class(TDataModule)
    Driver: TFDPhysPgDriverLink;
    Conexao: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProvidersConnection: TProvidersConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
