unit Server.Base.Crud;

interface

uses
  System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth,

  FireDAC.Comp.Client,
  dbebr.factory.interfaces,
  dbebr.factory.firedac,
  Server.Base.Connection,
  Server.Models.Base.TabelaBase,
  dbcbr.mapping.attributes,
  dbcbr.types.mapping,
  ormbr.types.lazy,
  ormbr.types.nullable,
  dbcbr.mapping.register,
  System.Rtti, Server.Models.Base.Consulta,
  Generics.Collections,
  ormbr.objects.utils,
  ormbr.container.objectset.interfaces,
  ormbr.objects.helper;

type
  TServerBaseCrud = class(TDSServerModule)
  private
    { Private declarations }
    FContainer:TObject;

    Function MontarWhere(pConsulta:TConsulta):String;
  Protected
    FConnection: IDBConnection;
    procedure Conectar(const pBase:String);
    Function GetObjTabela(const AValue: TJSONObject): TObject;  virtual;
    function GetId:Integer; virtual;
    function GetContainer: TObject; virtual;
  public
    { Public declarations }
    CodFonia:String;
    function updateGravar(const AValue: TJSONObject): TJSONObject;
    function updateDeletar(const AValue: TJSONObject): TJSONString;
    function updateConsulta(const AValue: TJSONObject): TJSONArray;

    destructor Destroy;
  end;

implementation

{$R *.dfm}

uses System.StrUtils, jsonbr, ormbr.json;

function TServerBaseCrud.GetObjTabela(const AValue: TJSONObject): TObject;
begin
  // Obrigatorio implementar na class filho
  Result := nil;
end;

function TServerBaseCrud.MontarWhere(pConsulta: TConsulta): String;
var
  vWhere:TConsultaWhere;
begin
  if Assigned(pConsulta.Where) then
  begin
    Result := ' 0 = 0 ';
    for vWhere in pConsulta.Where do
    begin
      Result := Result + ' ' +vWhere.Sinal + ' ' + vWhere.Campo
       + ' ' + vWhere.Condicao
       + ' ' + QuotedStr(vWhere.Valor);
    end;
  end;
end;

procedure TServerBaseCrud.Conectar(const pBase: String);
begin
  if FConnection = nil then
  begin
    with TBaseConnection.Create(pBase) do
    begin
      FConnection:= Connection;
      self.CodFonia := CodFonia;
    end;
  end;

  FContainer := GetContainer;
end;

destructor TServerBaseCrud.Destroy;
begin
end;

function TServerBaseCrud.GetContainer: TObject;
begin
  Result := fContainer;
end;

Function TServerBaseCrud.GetId: Integer;
var
  vObj: TObject;
begin
  // implementar na class filho caso precise um incrementador de ID
  vObj := FContainer.MethodCall('Find', []).AsObject;
  vObj := vObj.MethodCall('Last', []).AsObject;
  Result := TTabelaBase(vObj).id + 1;
end;

function TServerBaseCrud.updateConsulta(const AValue: TJSONObject): TJSONArray;
var
 vObjBase: TObject;
 vObjConsulta: TConsulta;
 vJsonStr, vWhere: String;
 LMasterList: TObjectList<TObject>;
begin
  TJSONBr.JsonToObject(AValue.ToJSON, vObjConsulta);
  Conectar(vObjConsulta.DataBase);
  try
    vWhere := MontarWhere(vObjConsulta);

    LMasterList := TObjectList<TObject>.Create;
    if vWhere <> '' then
      vObjBase := (FContainer.MethodCall('FindWhere', [vWhere, '']).AsObject)
    else
      vObjBase := (FContainer.MethodCall('Find', []).AsObject);

    LMasterList := TObjectList<TObject>(vObjBase);

    vJsonStr := TORMBrJson.ObjectToJsonString(vObjBase);
    Result := TORMBrJson.JSONStringToJSONArray(vJsonStr);
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TServerBaseCrud.updateDeletar(const AValue: TJSONObject): TJSONString;
var
  vObjBase: TTabelaBase;
begin
  vObjBase := TTabelaBase(GetObjTabela(AValue));
  Conectar(vObjBase.DataBase);
  try
    vObjBase := TTabelaBase(FContainer.MethodCall('FindID', [vObjBase.id]).AsObject);

    if not Assigned(vObjBase) then
      raise Exception.Create('Registro não encontrado!');

    FContainer.MethodCall('Delete', [vObjBase]);
    Result := TJSONString.Create('Registro excluído com sucesso!');
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TServerBaseCrud.updateGravar(const AValue: TJSONObject): TJSONObject;
var
 vObjBase,vObjBaseUpdate: TTabelaBase;
 vObjRetorno:TObject;
 vJsonStr:String;
 vOpeInsert: Boolean;
begin
  vObjBase := TTabelaBase(GetObjTabela(AValue));
  Conectar(vObjBase.DataBase);
  try
    if vObjBase.id = 0 then
    begin
      vOpeInsert:= True;
      vObjBase.id := GetId;
    end;

    if vOpeInsert then
    begin
      FContainer.MethodCall('Insert', [vObjBase]);
    end else
    begin
      vObjBaseUpdate := TTabelaBase(FContainer.MethodCall('FindID', [vObjBase.id]).AsObject);
      FContainer.MethodCall('Modify', [vObjBaseUpdate]);
      FContainer.MethodCall('Update', [vObjBase]);
    end;

    if vObjBase.id > 0 then
    begin
      vObjRetorno := FContainer.MethodCall('FindID', [vObjBase.id]).AsObject;

      if not Assigned(vObjRetorno) then
        raise Exception.Create('Problema ao gravar os dados!');

      vJsonStr := TORMBrJson.ObjectToJsonString(vObjRetorno);
    end
    else begin
      vJsonStr := TORMBrJson.ObjectToJsonString(vObjBase);
    end;

    TJSONBr.JsonToObject(vJsonStr, Result);
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

end.

