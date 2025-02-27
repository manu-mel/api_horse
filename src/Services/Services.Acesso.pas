unit Services.Acesso;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, System.JSON, FireDAC.Comp.DataSet, DataSetConverter4D, DataSetConverter4D.Impl,FireDAC.Phys.PGDef,
  FireDAC.Phys.PG, Classes.AuthClaims, JOSE.Core.JWT, JOSE.Core.Builder, System.DateUtils;

type
  TServicesAcesso = class(TProvidersConnection)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetID(sID: String): String;
    function Post(sBody: String): String;
  end;

var
  ServicesAcesso: TServicesAcesso;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TServicesAcesso.GetID(sID: String): String;
var
  oQry: TFDQuery;
  oArray: TJSONArray;
begin
  oQry := TFDQuery.Create(nil);

  try
    oQry.Connection := Conexao;

    oQry.Close;
    oQry.SQL.Add('SELECT first_name, last_name');
    oQry.SQL.Add('FROM staff');
    oQry.SQL.Add('WHERE staff_id = ' + QuotedStr(sID));
    oQry.Open;

    if oQry.IsEmpty then
      raise Exception.Create('Nenhum registro encontrado.');

    oArray := TConverter.New.DataSet(oQry).AsJSONArray;

    Result := oArray.ToJSON;

    FreeAndNil(oArray);
  finally
    oQry.Close;
    FreeAndNil(oQry);
  end;
end;

function TServicesAcesso.Post(sBody: String): String;
var
  oQry: TFDQuery;
  oArray: TJSONArray;
  oObj: TJSONObject;
  sEmail, sSenha, sToken: string;
  oJWT: TJWT;
  oClaims: TAuthClaims;
begin
  oQry := TFDQuery.Create(nil);

  try
    oQry.Connection := Conexao;

    oArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(sBody),0) as TJSONArray;
    oObj := oArray.Items[0] as TJSONObject;

    if not oObj.TryGetValue('email',sEmail) then
      raise Exception.Create('e-mail inv�lido.');

    if not oObj.TryGetValue('password',sSenha) then
      raise Exception.Create('senha inv�lida.');

    oQry.Close;
    oQry.SQL.Clear;
    oQry.SQL.Add('SELECT first_name, last_name');
    oQry.SQL.Add('FROM staff');
    oQry.SQL.Add('WHERE first_name = ' + QuotedStr(sEmail));
    oQry.SQL.Add('AND last_name = ' + QuotedStr(sSenha));
    oQry.Open;

    oJWT := TJWT.Create(TAuthClaims);

    try
      oClaims := TAuthClaims(oJWT.Claims);

      oClaims.Expiration := IncHour(Now, 5);

      oClaims.Email    := oQry.FieldByName('first_name').AsString;
      oClaims.Password := oQry.FieldByName('last_name').AsString;

      sToken := TJOSE.SHA256CompactToken('my-token', oJWT);

      oObj := TJSONObject.Create;

      oObj.AddPair('access_token', TJSONString.Create(sToken));
      oObj.AddPair('expires_in',TJSONNumber.Create(18000));
      oObj.AddPair('token_type',TJSONString.Create('Bearer'));

      oArray := TJSONArray.Create;
      oArray.Add(oObj);

      Result := oArray.ToJSON;
    finally
      FreeAndNil(oJWT);
    end;
  finally
    FreeAndNil(oArray);
    oQry.Close;
    FreeAndNil(oQry);
  end;
end;

end.
