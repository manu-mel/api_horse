unit Classes.AuthClaims;

interface

uses
  JOSE.Core.JWT, JOSE.Types.JSON;

type
  TAuthClaims = class(TJWTClaims)
  private
    function GetEmail: string;
    procedure SetEmail(const Value: string);

    function GetPassword: string;
    procedure SetPassword(const Value: string);
  public
    property Email: string read GetEmail write SetEmail;
    property Password: string read GetPassword write SetPassword;
  end;

implementation

{ TAuthClaims }

function TAuthClaims.GetEmail: string;
begin
  Result := TJSONUtils.GetJSONValue('email', FJSON).AsString;
end;

function TAuthClaims.GetPassword: string;
begin
  Result := TJSONUtils.GetJSONValue('password', FJSON).AsString;
end;

procedure TAuthClaims.SetEmail(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('email', Value, FJSON);
end;

procedure TAuthClaims.SetPassword(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('password', Value, FJSON);
end;

end.
