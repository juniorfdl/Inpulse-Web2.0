unit Infotec.Utils;

interface

uses System.SysUtils, System.JSON, System.Generics.Collections, GBJSON.Interfaces, GBJSON.Helper,
  System.Classes;

type
  TInfotecUtils = class
    class function ObjectToJson(pObject: TObject): String;
    class function ObjectToJsonObject(pObject: TObject): TJSONValue;
    class function ObjectToJsonArray<T: class, constructor>(pObject: TObjectList<T>): TJSONArray;
    class function RemoverEspasDuplas(const psValue: string): string;
    class function JsonToObject<T: class, constructor>(const psJSon: string): T;
  end;

implementation

{ TInfotecUtils }

class function TInfotecUtils.JsonToObject<T>(const psJSon: string): T;
begin
  Result := TGBJSONDefault.Serializer<T>.JsonStringToObject(psJSon);
end;

class function TInfotecUtils.ObjectToJson(pObject: TObject): String;
begin
  Result := pObject.ToJSONString(true);
end;

class function TInfotecUtils.ObjectToJsonArray<T>(pObject: TObjectList<T>): TJSONArray;
begin
   Result := TGBJSONDefault.Deserializer<T>.ListToJSONArray(pObject);
end;

class function TInfotecUtils.ObjectToJsonObject(pObject: TObject): TJSONValue;
{$IFDEF DEBUG}
var
  oJson: TStringList;
{$ENDIF}
begin
  Result := pObject.ToJSONObject;

  if not Assigned(Result) then
  begin
    {$IFDEF DEBUG}
      oJson:= TStringList.Create;
      try
        oJson.Text := pObject.ToJSONString();
        oJson.SaveToFile('JsonErro.Json');
      finally
        FreeAndNil(oJson);
      end;
    {$ENDIF}

    Writeln('Erro: Result = nil:  ' + ObjectToJson(pObject));
  end;

end;

class function TInfotecUtils.RemoverEspasDuplas(const psValue: string): string;
begin
  Result := StringReplace(psValue, '"', ' ', [rfReplaceAll]);
end;

end.
