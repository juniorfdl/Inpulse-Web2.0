unit Server.Controller.Sistema.Login;

interface

uses
  //Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants,
  System.Classes, //Vcl.Graphics,
  //Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Server.Base.Crud,
  System.JSON, Server.Models.Cadastros.Operadores, jsonbr,
  ormbr.container.objectset, //ormbr.jsonutils.datasnap,
  Generics.Collections;

type
  TLogin = class(TServerBaseCrud)
  private
    { Private declarations }
    FContainer: TContainerObjectSet<TOperadores>;
    function RegistraEntrada(pOperador:Integer):String;
  protected
    Function GetObjTabela(const AValue: TJSONObject): TObject; override;
    function GetContainer: TObject; override;
  public
    { Public declarations }
    function Login(NOME, PWD: String): TJSONObject;
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

uses Infotec.Utils;
{ TLogin }

function TLogin.GetContainer: TObject;
begin
  if FContainer = nil then
    FContainer := TContainerObjectSet<TOperadores>.Create(FConnection);

  Result := FContainer;

  // fContainer.FindWhere()
end;

function TLogin.GetObjTabela(const AValue: TJSONObject): TObject;
begin
  Result := TJSONBr.JsonToObject<TOperadores>(AValue.ToJSON);
end;

function TLogin.Login(NOME, PWD: String): TJSONObject;
var
  // vObj: TOperadores;
  vListRet: TObjectList<TOperadores>;
  vJsonStr: string;
begin
  try
    Conectar('');
    try
      vListRet := FContainer.FindWhere('LOGIN = ' + QuotedStr(NOME) +
        ' AND SENHA = ' + QuotedStr(PWD)+ ' AND ATIVO = ''SIM'' ');

      if (not Assigned(vListRet)) or (vListRet.Count = 0) then
        raise Exception.Create('Usuário não encontrado!');

      vListRet[0].CODIGOENTRADA := RegistraEntrada(vListRet[0].id);

      with FConnection.ExecuteSQL
        ('select ASTERISK_USERID, ASTERISK_LOGIN, ASTERISK_SENHA from operadores where CODIGO = '
        + vListRet[0].id.ToString) do
      begin
        if RecordCount > 0 then
        begin
          vListRet[0].Registrar.ASTERISK_USERID :=
            fieldByName('ASTERISK_USERID').AsString;
          vListRet[0].Registrar.ASTERISK_LOGIN :=
            fieldByName('ASTERISK_LOGIN').AsString;
          vListRet[0].Registrar.ASTERISK_SENHA :=
            fieldByName('ASTERISK_SENHA').AsString;

        end;
      end;

      with FConnection.ExecuteSQL
        ('SELECT LOCAL_GRAVACAO, ASTERISK_PROXY, ASTERISK_SERVER, ASTERISK_PORTA,'
        + ' SIP_EMITE_BIP, SIP_VOLUME_AUTOMATICO, DDD_LOCAL, OPERADORA_LOCAL,SIP_ID, ' +
        ' SIP_KEY, SIP_MODO, PESQUISAR_CLIENTES_NO_ATIVO FROM parametros LIMIT 1 ')
        do
      begin
        if RecordCount > 0 then
        begin
          vListRet[0].Registrar.LOCAL_GRAVACAO := fieldByName('LOCAL_GRAVACAO')
            .AsString + '\' + NOME + '\';
          vListRet[0].Registrar.ASTERISK_PROXY :=
            fieldByName('ASTERISK_PROXY').AsString;
          vListRet[0].Registrar.ASTERISK_SERVER :=
            fieldByName('ASTERISK_SERVER').AsString;
          vListRet[0].Registrar.ASTERISK_PORTA :=
            fieldByName('ASTERISK_PORTA').AsString;
          vListRet[0].Registrar.SIP_EMITE_BIP :=
            fieldByName('SIP_EMITE_BIP').AsString;
          vListRet[0].Registrar.SIP_VOLUME_AUTOMATICO :=
            fieldByName('SIP_VOLUME_AUTOMATICO').AsString;
          vListRet[0].Registrar.DDD_LOCAL := fieldByName('DDD_LOCAL').AsString;
          vListRet[0].Registrar.OPERADORA_LOCAL :=
            fieldByName('OPERADORA_LOCAL').AsString;
          vListRet[0].Registrar.Usa_ddds_diferentes :=
            fieldByName('OPERADORA_LOCAL').AsString;
          vListRet[0].Registrar.LICENSEUSER :=
            fieldByName('SIP_ID').AsString;
          vListRet[0].Registrar.LICENSEKEY :=
            fieldByName('SIP_KEY').AsString;
           vListRet[0].Registrar.SIP_MODO :=
            fieldByName('SIP_MODO').AsString;
            vListRet[0].Registrar.PESQUISA_CLIENTE_ATIVO :=
            fieldByName('PESQUISAR_CLIENTES_NO_ATIVO').AsString;

        end;
      end;

      Result := TInfotecUtils.ObjectToJsonObject(vListRet[0]) as TJSONObject;

//      vJsonStr := TJSONBr.ObjectToJsonString<TOperadores>(vListRet[0]);
//      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(vJsonStr), 0) as TJSONArray;
    finally
      if FConnection.IsConnected then
        FConnection.Disconnect;
    end;
  except
    on e: Exception do
    begin
      Writeln(e.message);
      raise;
//      raise Exception.Create(e.message + ExtractFilePath(Application.ExeName));
    end;
  end;
end;

function TLogin.RegistraEntrada(pOperador:Integer):String;
var
  vSql:String;
  CodigoEntrada:Integer;
begin
  try
    CodigoEntrada := 0;
    WITH FConnection.ExecuteSQL('SELECT MAX(codigo) as codigo FROM login_ativo_receptivo ') DO
    begin
      if RecordCount > 0 then
      begin
        CodigoEntrada :=  FieldByName('codigo').AsInteger + 1;
      end;
    end;

    Result := CodigoEntrada.ToString;
    vSql := ' INSERT INTO login_ativo_receptivo' +
      ' (CODIGO, OPERADOR, ENTRADA, MODULO ) VALUES (' +
      QuotedStr(Result) + ', ' +
      QuotedStr(pOperador.ToString)
      + ', Now(), '+ QuotedStr('Ativo') +')';

    FConnection.ExecuteDirect(vSql);
  except
    on E: Exception do
    begin
      Writeln(e.message);
      raise;
    end;
  end;
end;

end.
