unit uServerModule;

interface

uses
  System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer,
  DataSnap.DSAuth,
  DataSnap.DSSession,
  System.Generics.Collections,
  uServerContainer, ormbr.rest.Json, Inpulse.SIP.Models.Resgistrar,
  ormbr.jsonutils.DataSnap, Vcl.Forms;

type
  TGetSIP = class(TDSServerModule)
  private
    { Private declarations }
    FSession: TDSSession;
    FConnectionKey: string;
    FMasterKey, FEmpresaKey: string;
    procedure AddKeys;
    procedure DeleteKeys;
    procedure GeneratorKeys;
    procedure RecoversKeys;
    procedure ControleDeSessao;
    procedure addLog(Erro: String; Arquivo: string = '');
  public
    { Public declarations }
    function UpdateLigar(const pParams: TJSONObject): TJSONObject;
    function UpdateDesligar(const pParams: TJSONObject): TJSONObject;
    function UpdateRegistrar(const pParams: TJSONObject): TJSONObject;
    function UpdateState(const pParams: TJSONObject): TJSONObject;
    function UpdateTransferir(const pParams: TJSONObject): TJSONObject;
    function UpdateEnviarDTMF(const pParams: TJSONObject): TJSONObject;
  end;

implementation

// uses
// uFormServer;

{$R *.dfm}
{ TServerMethods1 }

procedure TGetSIP.AddKeys;
begin
  { GeneratorKeys;
    TServerContainer1.GetDictionary.Add(FConnectionKey,
    TFactoryFireDAC.Create(FDConnection1, dnFirebird));
    FConnection := TServerContainer1.GetDictionary.Items[FConnectionKey]
    as TFactoryFireDAC;
    TServerContainer1.GetDictionary.Add(FMasterKey,
    TContainerObjectSet<TSisUsuario>.Create(FConnection, 10));
    TServerContainer1.GetDictionary.Add(FEmpresaKey,
    TContainerObjectSet<TSisEmpresa>.Create(FConnection, 10)); }
end;

procedure TGetSIP.ControleDeSessao;
begin
  DeleteKeys;
  AddKeys;
  RecoversKeys;
end;

procedure TGetSIP.DeleteKeys;
begin
  { GeneratorKeys;
    if TServerContainer1.GetDictionary.ContainsKey(FConnectionKey) then
    TServerContainer1.GetDictionary.Remove(FConnectionKey);
    if TServerContainer1.GetDictionary.ContainsKey(FMasterKey) then
    TServerContainer1.GetDictionary.Remove(FMasterKey);

    if TServerContainer1.GetDictionary.ContainsKey(FEmpresaKey) then
    TServerContainer1.GetDictionary.Remove(FEmpresaKey); }
end;

function TGetSIP.UpdateDesligar(const pParams: TJSONObject): TJSONObject;
var
  vJsonStr: String;
  vobj: TModelLigar;
begin
  try
    TServerContainer1.Desligar;
    vobj := TModelLigar.Create;
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := TORMBrJSONUtil.JSONStringToJSONObject(vJsonStr);
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

function TGetSIP.UpdateEnviarDTMF(const pParams: TJSONObject): TJSONObject;
var
  vobj: TModelLigar;
  vJsonStr: String;
begin
  try
    vobj := TORMBrJson.JsonToObject<TModelLigar>(pParams.ToJSON);
    TServerContainer1.EnviarDTMF(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := TORMBrJSONUtil.JSONStringToJSONObject(vJsonStr);
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

procedure TGetSIP.GeneratorKeys;
begin
  { FSession := TDSSessionManager.GetThreadSession;
    FConnectionKey := 'Connection_' + IntToStr(FSession.id);
    FEmpresaKey := 'Empresa_' + IntToStr(FSession.id); }
end;

function TGetSIP.UpdateLigar(const pParams: TJSONObject): TJSONObject;
var
  vobj: TModelLigar;
  vJsonStr: String;
begin
  try
    vobj := TORMBrJson.JsonToObject<TModelLigar>(pParams.ToJSON);
    TServerContainer1.Ligar(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := TORMBrJSONUtil.JSONStringToJSONObject(vJsonStr);
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

procedure TGetSIP.RecoversKeys;
begin
  { GeneratorKeys;
    FConnection := TServerContainer1.GetDictionary.Items[FConnectionKey]
    as TFactoryFireDAC;
    FContainerUsuario := TServerContainer1.GetDictionary.Items[FMasterKey]
    as TContainerObjectSet<TSisUsuario>;
    FContainerEmpresa := TServerContainer1.GetDictionary.Items[FEmpresaKey]
    as TContainerObjectSet<TSisEmpresa>; }
end;

function TGetSIP.UpdateRegistrar(const pParams: TJSONObject): TJSONObject;
var
  vobj: TRegistrar;
  vJsonStr: String;
begin
  try
    vobj := TORMBrJson.JsonToObject<TRegistrar>(pParams.ToJSON);
    TServerContainer1.Registrar(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := TORMBrJSONUtil.JSONStringToJSONObject(vJsonStr);
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

function TGetSIP.UpdateState(const pParams: TJSONObject): TJSONObject;
var
  vobj: TModelState;
  vJsonStr: String;
begin
  try
    vobj := TORMBrJson.JsonToObject<TModelState>(pParams.ToJSON);
    vJsonStr := TServerContainer1.GetState(vobj);
    vobj.StateDescricao := vJsonStr;
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := TORMBrJSONUtil.JSONStringToJSONObject(vJsonStr);
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

function TGetSIP.UpdateTransferir(const pParams: TJSONObject): TJSONObject;
var
  vobj: TModelLigar;
  vJsonStr: String;
begin
  try
    vobj := TORMBrJson.JsonToObject<TModelLigar>(pParams.ToJSON);
    TServerContainer1.Transferir(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := TORMBrJSONUtil.JSONStringToJSONObject(vJsonStr);
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

procedure TGetSIP.addLog(Erro: string; Arquivo: string = '');
var
  CaminhoPrograma: String;
begin
  try
    CaminhoPrograma := ExtractFilePath(Application.ExeName);
    with TStringList.Create do
      try
        if Arquivo = '' then
          Arquivo := 'LogErro_' + FormatDateTime('yyyymmdd', now) + '.txt';

        Arquivo := CaminhoPrograma + Arquivo;

        if FileExists(Arquivo) then
          LoadFromFile(Arquivo);

        Add(#13 + DateTimeToStr(now) + #13 + Erro);

        SaveToFile(Arquivo);
      finally
        Free;
      end;
  except
  end;
end;

Initialization

RegisterClass(TGetSIP);

end.
