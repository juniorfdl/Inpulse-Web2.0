unit Infotec.Ativo.Utils;

interface

uses System.SysUtils, System.Generics.Collections, System.JSON;

type
  TExceptionSQL = Class(Exception);

  TUtils = class
    class var oAllParams: TDictionary<string, string>;
    class var oTabelaParametros: TDictionary<string, string>;
    class var bHTTPS: boolean;
    class function GetCaminhoBase: string;
    class function GetHost: string;
    class function GetPort: Integer;
    class function GetLog: String;
    class procedure GetAllParams;
    class function GetErroToJson(E: Exception): TJSONObject;
    class function ParseJson(poJson: TJSONObject): TJSONObject; overload;
    class function ParseJson(poJson: TJSONArray): TJSONArray; overload;
    class function ProcessarEndPoint(poProc: TFunc<TJSONValue>): TJSONValue; overload;
    class function GetValorParametros(const psNomeParametro: string): string;
    class function GetValueJson(poJson: TJSONValue; psPath: string): string;
    class function GetFolderTemp: string;
    class procedure SalvarBase64(const psfileBase64, psfilename: string);
    class function GetHttps: Boolean;
  end;

implementation

uses //Winapi.Windows, Winapi.Messages,
  System.NetEncoding,
  System.Classes;

const
  sAPPLOG = 'log';
  sAPPPORT = 'port';
  sAPPHOST = 'host';
  sDATABASE = 'database';
  nPORT_DEFAUL = 9000;
  sHOST_DEFAULT = '0.0.0.0';
  sAPPHTTPS = 'https';

{ TUtils }

class procedure TUtils.GetAllParams;
var
  I: integer;
  sParamKey, sParamValue: string;
  oList: TStringList;
begin
  oAllParams := TDictionary<string, string>.Create();

  if not FileExists('config.txt') then
    Exit;

  oList := TStringList.Create;
  try
    oList.LoadFromFile('config.txt');
    for i := 0 to Pred(oList.Count) do
    begin
      sParamValue := oList[i];
      sParamKey := sParamValue.Substring(0, Pred(Pos(':', sParamValue)));
      sParamValue := sParamValue.Substring(Pos(sParamKey, sParamValue) + Length(sParamKey));
      oAllParams.Add(sParamKey, sParamValue);
    end;
  finally
    oList.Free;
  end;
  //port:1234 log:logfull database:Server=localhost;Port=3306;Database=crm_sgr;User_Name=root;Password=root;DriverID=MySQL;
end;

class function TUtils.GetCaminhoBase: string;
begin
  Result := GetEnvironmentVariable(sDATABASE);

  if (Result.IsEmpty) then
    oAllParams.TryGetValue(sDATABASE, Result);

  if Result.IsEmpty then
    raise Exception.Create('Informar o caminho da base de dados.');
end;

class function TUtils.GetErroToJson(E: Exception): TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
          ('{"Erro": "' + E.Message + '"} '), 0) as TJSONObject;
end;

class function TUtils.GetHost: string;
begin
  Result := GetEnvironmentVariable(sAPPHOST);

  if (Result.IsEmpty) then
    oAllParams.TryGetValue(Trim(sAPPHOST), Result);

  if (Result.IsEmpty) then
    Result := sHOST_DEFAULT;
end;

class function TUtils.GetHttps: Boolean;
var
  sHTTPS: string;
begin
  Result := GetEnvironmentVariable('HTTPS') = 'S';

  if (not Result) then
  begin
    oAllParams.TryGetValue(sAPPHTTPS, sHTTPS);
    Result := Trim(sHTTPS) = 'S';
  end;

  Self.bHTTPS := Result;
end;

class function TUtils.GetPort: Integer;
var
  sPORT: string;
begin
  Result := StrToIntDef(GetEnvironmentVariable('appport'), 0);

  if (Result = 0) then
  begin
    oAllParams.TryGetValue(sAPPPORT, sPORT);
    Result := StrToIntDef(Trim(sPORT), 0);
  end;

  if (Result = 0) then
    Result := nPORT_DEFAUL;
end;

class function TUtils.GetValorParametros(const psNomeParametro: string): string;
begin

end;

class function TUtils.GetValueJson(poJson: TJSONValue; psPath: string): string;
var
  sRetorno: string;
begin
  sRetorno := EmptyStr;
  poJson.TryGetValue(psPath, sRetorno);
  Result := sRetorno;
end;

class function TUtils.ParseJson(poJson: TJSONObject): TJSONObject;
var
  sJson: string;
begin
  sJson := LowerCase(poJson.ToJSON);
  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(sJson), 0) as TJSONObject;
end;

class function TUtils.ParseJson(poJson: TJSONArray): TJSONArray;
var
  sJson: string;
begin
  sJson := LowerCase(poJson.ToJSON);
  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(sJson), 0) as TJSONArray;
end;

class function TUtils.ProcessarEndPoint(poProc: TFunc<TJSONValue>): TJSONValue;
begin
  
end;

class procedure TUtils.SalvarBase64(const psfileBase64, psfilename: string);
var
  lInStream : TStringStream;
  lOutStream : TMemoryStream;
begin
  lInStream := TStringStream.Create(psfileBase64);
  lOutStream := TMemoryStream.Create;
  try
    lInStream.Position := 0;
    TNetEncoding.Base64.Decode(lInStream, lOutStream);
    lOutStream.Position := 0;
    lOutStream.SaveToFile(psfilename);
  finally
    FreeAndNil(lInStream);
    FreeAndNil(lOutStream);
  end;
end;

class function TUtils.GetLog: String;
var
  sLog: string;
begin
  Result := GetEnvironmentVariable(sAPPLOG);

  if (Result.IsEmpty) and oAllParams.TryGetValue(sAPPLOG, sLog) then
    Result := Trim(sLog);
end;

class function TUtils.GetFolderTemp: string;
//var
//  I: DWord;
begin
  Result := '\';
  {I := 4096;
  SetLength(result, I);
  SetLength(result, GetTempPath(I, PChar(result)));}
end;

Initialization
  TUtils.GetAllParams;

Finalization
  FreeAndNil(TUtils.oAllParams);

end.


