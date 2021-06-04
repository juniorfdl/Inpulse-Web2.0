unit Server.Functions.Telefone;

interface

uses Server.Functions.Diversas, System.SysUtils;

type
  TFunctionsTelefone = class
  public
    class function Valido(const pFone:String):Boolean;
  end;


implementation

{ TFunctionsTelefone }

class function TFunctionsTelefone.Valido(const pFone: String): Boolean;
var
 vFone:String;
begin
  vFone := TFunctionsDiversos.SomenteNumeros(pFone);

  if Copy(vFone,1,1) = '0' then
    vFone := Copy(vFone,2,20);

  Result := not (Length(vFone) < 10);

  if Result then
    Result := StrToFloatDef(vFone, -99) <> -99;
end;

end.
