unit Controllers.Acesso;

interface

procedure Registry;

implementation

uses Horse, Horse.Commons, System.JSON, SysUtils, Services.Acesso;

procedure DoGetAcessoID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Acesso: TServicesAcesso;
  sResponse, sID: String;
begin
  Acesso := TServicesAcesso.Create(nil);

  try
    try
      sID := Req.Params['id'];

      sResponse := Acesso.GetID(sID);

      Res.Send(TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(sResponse),0) as TJSONArray).Status(THTTPStatus.OK);
    except
      on E: exception do
      begin
        Res.Send(E.Message).Status(THTTPStatus.BadRequest);
      end;
    end;
  finally
    FreeAndNil(Acesso);
  end;
end;

procedure DoPostAcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Acesso: TServicesAcesso;
  sResponse: String;
begin
  Acesso := TServicesAcesso.Create(nil);

  try
    try
      sResponse := Acesso.Post(Req.Body);

      Res.Send(TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(sResponse),0) as TJSONArray).Status(THTTPStatus.OK);
    except
      on E: exception do
      begin
        Res.Send(E.Message).Status(THTTPStatus.BadRequest);
      end;
    end;
  finally
    FreeAndNil(Acesso);
  end;

end;

procedure Registry;
begin
  THorse.Get('/Acesso/:id', DoGetAcessoID);
  THorse.Post('/Acesso', DoPostAcesso);
end;

end.
