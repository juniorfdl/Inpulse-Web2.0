unit Infotec.Utils;

interface

uses System.SysUtils, System.JSON, System.Generics.Collections, GBJSON.Interfaces, GBJSON.Helper;

type
  TInfotecUtils = class
    class function ObjectToJson(pObject: TObject): String;
    class function ObjectToJsonObject(pObject: TObject): TJSONValue;
    class function ObjectToJsonArray<T: class, constructor>(pObject: TObjectList<T>): TJSONArray;
    class function RemoverEspasDuplas(const psValue: string): string;
  end;

implementation

{ TInfotecUtils }

class function TInfotecUtils.ObjectToJson(pObject: TObject): String;
begin
  Result := pObject.ToJSONString(true);
end;

class function TInfotecUtils.ObjectToJsonArray<T>(pObject: TObjectList<T>): TJSONArray;
begin
   Result := TGBJSONDefault.Deserializer<T>.ListToJSONArray(pObject);
end;

class function TInfotecUtils.ObjectToJsonObject(pObject: TObject): TJSONValue;
begin
  Result := pObject.ToJSONObject;

  if Result = nil then
  begin
    Writeln('Erro: Result = nil:  ' + ObjectToJson(pObject));
  end;

end;

class function TInfotecUtils.RemoverEspasDuplas(const psValue: string): string;
begin
  Result := StringReplace(psValue, '"', ' ', [rfReplaceAll]);
end;

end.
