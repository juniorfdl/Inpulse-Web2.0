unit Server.Controller.Ativo;

interface

uses
  //Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants,
  System.Classes, //Vcl.Graphics,
  //Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Server.Base.Crud,
  Server.Models.Cadastros.Clientes,
//  dbebr.container.objectset,
//  dbebr.rest.json,
  dbebr.factory.interfaces,
  dbebr.factory.firedac,
  ormbr.container.objectset.interfaces,
  ormbr.container.objectset,
  jsonbr,
  System.json,
  //ormbr.jsonutils.datasnap, ormbr.factory.interfaces,
  Server.Models.Cadastros.Contatos, Server.Models.Cadastros.FonesCampanha,
  Generics.Collections,  strUtils,
  Server.Models.Ativo.DadosLigacao.factory, Server.Models.Ativo.Start,
  Server.Models.Cadastros.Resultados, Server.Models.Cadastros.FaseContato,
  Server.Models.Cadastros.ConfigMail,
  Server.Controller.ConsistirFinalizarLigacaoFactory,
  System.DateUtils, Server.Functions.Diversas,
  Server.Models.Movimentos.CampanhasClientes, Server.Models.Cadastros.Operadores,
  Server.Models.Cadastros.Cidades, Server.Models.Cadastros.MotivosPausa,
  Server.Models.Cadastros.PausasRealizadas, Server.Models.Cadastros.FoneAreas,
  Server.Models.Cadastros.ClientesGravar, Server.Models.Ativo.Agenda,
  Server.Models.Ativo.DadosLigacao, udmEmail, Server.Models.Cadastros.Grupos,
  Server.Models.Cadastros.Midias, Server.Models.Cadastros.Segmentos,
  Server.Models.Cadastros.Cargos, System.NetEncoding;

type
  TAtivo = class(TServerBaseCrud)
  private
    { Private declarations }
    fOPERADOR: Integer;
    LigaRepresentante: Boolean;
    OrderBy: String;
    FiltroDDD: String;
    FiltroEstado: String;
    fObjCli: TClientes;
    fCOD_ACAO: Integer;
    fResultado: TResultados;
    FIDELIZARCOTACAO: Boolean;

    FContainer: TContainerObjectSet<TClientes>;
    FContainerCampanhasCliente: TContainerObjectSet<TCampanhasClientes>;
    fCampanhasCliente:TCampanhasClientes;
    fCodigoLigacao: Integer;
    fCodigoCliente: Integer;
    function GetIdProximaLigacao: Integer;
    function GetLigacaoNaoFinalizada: Integer;
    function ExecSql_Q1: Integer;
    function ExecSql_Q0: Integer;
    function ExecSql_Q2: Integer;

    function ValidaFusoHorario: String;
    procedure GetParamOperador;
    procedure setCodigoLigacao(const Value: Integer);
    function EOperadorCotacao(var Resultado: Integer;
      OperadorAtual, Cliente: string): string;
    procedure FidelizarContatos;
    function GetProdutividade(pOperador: String): String;
    function GetPedidosFechados(pOperador: String): String;
    function BuscaLigacoesDiscadasDia: String;
    function iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
    function GetFidelizacoesCliente(pCliente: Integer;
      var rBaseQuantidade: Integer): Integer;

    property CodigoLigacao: Integer read fCodigoLigacao write setCodigoLigacao;
    property CodigoCliente: Integer read fCodigoCliente write fCodigoCliente;

    procedure PreencheDadosLigacao(var pCliente: TClientes);
    function MontaFone(pCliente: TClientes):String;
    function GetStart(const pBaseDados: String): TJSONObject;
    function ProximaLigacao(const AValue: TJSONObject): TJSONValue;

    function GetNomeLoginOperador(pOperador: Integer):String;
    function FinalizarLigacao(const AValue: TJSONObject): TJSONObject;
    function GravarDadosCliente(const pid:Integer; const AValue: TJSONObject) :integer;
    procedure VerificaDataAcao;
    procedure CriaFidelizacao(pOperador, pChamada, pCliente, pResQtdeFidelizar
      : Integer; pResContato, pResFideliza, pFidelizado: Boolean);
    procedure ExecutaAcao(pResultado, pACao: Integer);

    function GetCidades(const pUF: String; const pBaseDados: String): TJSONArray;
    function GravarPausa(const AValue: TJSONObject): TJSONObject;
    function GetAgenda(const AValue: TJSONObject): TJSONArray;
    function GetHistoricoCliente(const pCLIENTE: String; const pBaseDados: String): TJSONArray;
    function GetPropostasCliente(const pCliente:String; pDataInicial, pDataFinal:TDateTime;
      const pUtilizadas, pBaseDados: String): TJSONArray;
    function ConfirmaVenda(const AValue: TJSONObject): TJSONObject;
    function EnviarEmail(const AValue: TJSONObject): TJSONObject;
    procedure GravarHistoricoCli;
    function GravarContato(const AValue: TJSONObject): TJSONObject;
    function DeletarContato(const AValue: TJSONObject): TJSONObject;
    function UploadFile(const AValue: TJSONObject): TJSONObject;

    function NovaAgenda(const AValue: TJSONObject): string;

    procedure Liberar_operadores_ligacoes;
    procedure Travar_operadores_ligacoes;
    function GetSQLSingle(pSQL, pCampo:String):Variant;
  protected
    Function GetObjTabela(const AValue: TJSONObject): TObject; override;
    function GetContainer: TObject; override;
  public
    { Public declarations }
    function updateProximaLigacao(const AValue: TJSONObject): TJSONValue;
    function updateFinalizarLigacao(const AValue: TJSONObject): TJSONObject;
    function DadosRecebendoLigacao(pFone, CaminhoBD, operador: string):TJsonObject;
    function BuscaDadosRecebendoLigacao(pCodCli, caminhobd, operador: string): TJsonObject;
    function PesquisaClientes(pfiltro, CaminhoBD: string; page : integer  = 1):TJSONArray;
    function Start(const pBaseDados: String): TJSONObject;
    function SetStatusLigacao(const pStatus: String; pOperador:Integer; const pBaseDados: String): Integer;
    function Cidades(const pUF: String; const pBaseDados: String): TJSONArray;
    function Campanhas(const pBaseDados: String): TJSONArray;
    function updateGravarPausa(const AValue: TJSONObject): TJSONObject;
    function GetDate:Double;
    function updateAgenda(const AValue: TJSONObject): TJSONArray;
    function HistoricoCliente(const pCLIENTE: String; const pBaseDados: String): TJSONArray;
    function DescricaoStatus(const pCodDescricao: String; const pBaseDados: String): string;
    function PropostasCliente(const pCliente:String; pDataInicial, pDataFinal:TDateTime;
      const pUtilizadas: String; const pBaseDados: String): TJSONArray;
    function updateConfirmaVenda(const AValue: TJSONObject): TJSONObject;
    function updateEnviarEmail(const AValue: TJSONObject): TJSONObject;
    function updateGravarContato(const AValue: TJSONObject): TJSONObject;
    function updateDeletarContato(const AValue: TJSONObject): TJSONObject;
    function updateuploadFile(const AValue: TJSONObject): TJSONObject;
    function updateNovoAgendamento(const AValue: TJSONObject): TJSONObject;
  end;

var
  Ativo: TAtivo;

implementation

uses Server.Models.Cadastros.Campanhas, Server.Models.Cadastros.Unidades,
  ormbr.json, Infotec.Utils;

{$R *.dfm}

{ TAtivo }

procedure TAtivo.Liberar_operadores_ligacoes;
var
  vCODIGO:Integer;
begin
  if fOPERADOR > 0 then
  begin
    WITH FConnection.ExecuteSQL(' select max(CODIGO) as CODIGO from operadores_ligacoes where fim is null and OPERADOR = '
      + fOPERADOR.ToString) DO
    begin
      if RecordCount > 0 then
      begin
        vCODIGO := fieldByName('CODIGO').AsInteger;
      end;
    end;

    if vCODIGO > 0 then    
     FConnection.ExecuteDirect(' UPDATE operadores_ligacoes SET FIM = NOW() '
      +' WHERE CODIGO = ' + vCODIGO.ToString);
  end;
end;

procedure TAtivo.Travar_operadores_ligacoes;
begin
  if fOPERADOR > 0 then
    FConnection.ExecuteDirect(' INSERT INTO operadores_ligacoes (OPERADOR) VALUES (' + fOPERADOR.ToString + ')');
end;

function TAtivo.updateAgenda(const AValue: TJSONObject): TJSONArray;
begin
  try
    Result := GetAgenda(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateAgenda: ' + e.message);
    end;
  end;
end;

function TAtivo.updateConfirmaVenda(const AValue: TJSONObject): TJSONObject;
begin
  try
    Result := ConfirmaVenda(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateConfirmaVenda: ' + e.message);
    end;
  end;
end;

function TAtivo.updateDeletarContato(const AValue: TJSONObject): TJSONObject;
begin
  try
    Result := DeletarContato(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateDeletarContato: ' + e.message);
    end;
  end;
end;

function TAtivo.updateEnviarEmail(const AValue: TJSONObject): TJSONObject;
begin
  try
    Result := EnviarEmail(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateEnviarEmail: ' + e.message);
    end;
  end;
end;

function TAtivo.Campanhas(const pBaseDados: String): TJSONArray;
var
  xSql: String;
  vUnidades: Tunidades;
  vListUnidades: TObjectList<Tunidades>;
begin
  Conectar(pBaseDados);
  try
    vListUnidades := TObjectList<Tunidades>.Create;
    try
      xSql := ' select CODIGO, DESCRICAO from unidades ';
      with FConnection.ExecuteSQL(xSql) do
      begin
        while NotEof do
        begin
          vUnidades:= Tunidades.Create;
          vUnidades.id := fieldByName('CODIGO').AsInteger;
          vUnidades.Descricao := fieldByName('DESCRICAO').AsString;
          vListUnidades.Add(vUnidades);
        end;
      end;

      Result := TInfotecUtils.ObjectToJsonArray<TUnidades>(vListUnidades);
    finally
      vListUnidades.Free;
    end;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.Cidades(const pUF, pBaseDados: String): TJSONArray;
begin
  try
    Result := GetCidades(pUF, pBaseDados);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.Cidades: ' + e.message);
    end;
  end;
end;

function TAtivo.ConfirmaVenda(const AValue: TJSONObject): TJSONObject;
begin

end;

procedure TAtivo.CriaFidelizacao(pOperador, pChamada, pCliente,
  pResQtdeFidelizar: Integer; pResContato, pResFideliza, pFidelizado: Boolean);
var
  vQtdFidelizar, vCodigoFid: Integer;
begin
  if (not pResFideliza) and (not pFidelizado or not pResContato) then
    exit;

  vQtdFidelizar := 0;
  vCodigoFid := 0;

  with FConnection.ExecuteSQL
    ('SELECT CODIGO, QTDE_FIDELIZAR FROM FIDELIZACOES WHERE CLIENTE = ' +
    pCliente.ToString + ' ORDER BY CODIGO DESC LIMIT 1 ') do
  begin
    if RecordCount > 0 then
    begin
      vQtdFidelizar := fieldByName('QTDE_FIDELIZAR').AsInteger;
      vCodigoFid := fieldByName('CODIGO').AsInteger;
    end;
  end;

  if (pResFideliza) and (pResQtdeFidelizar >= vQtdFidelizar - 1) then
  Begin
    vQtdFidelizar := pResQtdeFidelizar;
    vCodigoFid := 0;
  end
  else
  begin
    vQtdFidelizar := vQtdFidelizar - 1;
  end;

  if ((pResContato) and (vCodigoFid > 0) AND (vQtdFidelizar >= 0)) or
    ((pResFideliza) and (vQtdFidelizar > 0)) then
  Begin

    Try
      FConnection.ExecuteDirect
        ('INSERT INTO FIDELIZACOES (cliente, cc_codigo, cod_origem, qtde_fidelizar, dt_criacao, operador_criacao)VALUES('
        + IntToStr(pCliente) + ', ' + IntToStr(pChamada) + ', ' +
        IntToStr(vCodigoFid) + ', ' + IntToStr(vQtdFidelizar) + ', ' +
        QuotedStr(FormatDateTime('yyyy-mm-dd HH:NN:SS', Now)) + ', ' +
        pOperador.ToString + ')');
    except
      on e: exception do
        TFunctionsDiversos.ShowMessageDesenv('Erro ao inserir fidelizacoes' +
          #13 + e.ClassName + #13 + e.message);
    end;
  end;
end;

function TAtivo.DadosRecebendoLigacao(pFone, CaminhoBD, operador: string): TJsonObject;
var
  xSql, where: String;
  fObjCli: TClientes;
begin
  Result := nil;
  fObjCli := TClientes.create;
  fOPERADOR := StrToInt(operador);
  Conectar(CaminhoBD);
  try
    if pFone.Length <= 9 then
      where := ' concat(FONE1) = ' + QuotedStr(pFone) + ' or ' +
               ' concat(FONE2) = ' + QuotedStr(pFone) + ' or ' +
               ' concat(FONE3) = ' + QuotedStr(pFone)
    else
      where := ' concat((select p.OPERADORA_LOCAL from parametros p limit 1), AREA1, FONE1) = ' + QuotedStr(pFone) + ' or ' +
               ' concat((select p.OPERADORA_LOCAL from parametros p limit 1), AREA2, FONE2) = ' + QuotedStr(pFone) + ' or ' +
               ' concat((select p.OPERADORA_LOCAL from parametros p limit 1), AREA3, FONE3) = ' + QuotedStr(pFone);
    if FContainer.FindWhere(where).Count > 0 then
    begin
      fObjCli := FContainer.FindWhere(where).First;
        xSql := ' Select CODIGO from CAMPANHAS_CLIENTES where CONCLUIDO = ''NAO'' and CLIENTE = ' +
        IntToStr( fObjCli.id );

      with FConnection.ExecuteSQL(xSql) do
       CodigoLigacao := FieldByName('CODIGO').AsInteger;
      if CodigoLigacao > 0 then
        PreencheDadosLigacao(fObjCli);
    end;

    Result := TInfotecUtils.ObjectToJsonObject(fObjCli) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.DeletarContato(const AValue: TJSONObject): TJSONObject;
var
  fobj: TContatos;
begin
  fobj := TInfotecUtils.JsonToObject<TContatos>(AValue.ToJSON);
  Conectar(fobj.DataBase);
  try
    TContainerObjectSet<TContatos>.Create(FConnection).Delete(fobj);
    Result := TInfotecUtils.ObjectToJsonObject(fobj) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.DescricaoStatus(const pCodDescricao,
  pBaseDados: String): string;
var
  xSql: String;
  temp: integer;
  fObjCli: TStatusSIP;
begin
  if pCodDescricao = '' then
    Exit;
  Conectar(pBaseDados);
  try
      fObjCli := TStatusSIP.Create;    
      
      try
        temp := StrToInt( pCodDescricao );
        xSql := ' select descricao from status_sip where cod_status_sip =  ' + pCodDescricao;
        with FConnection.ExecuteSQL(xSql) do
        begin
          fObjCli.DESCRICAOSTATUS := fieldByName('DESCRICAO').AsString;
          fObjCli.CODSTATUS := pCodDescricao;
          Result := fieldByName('DESCRICAO').AsString;   
        end;    
      except on E: Exception do
        begin
          if Pos('Registered', pCodDescricao) > 0 then
           Result := 'Conectado - Ramal Disponível'
          else
            Result := pCodDescricao;
        end;
      end;

  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.ExecSql_Q0: Integer;
var
  Isql: IDBResultSet;
begin
  Isql := FConnection.ExecuteSQL
    (' set @CODIGO = 0; UPDATE campanhas_clientes CCC SET  CCC.concluido = ''SIM'', CCC.OPERADOR_LIGACAO = '
    + IntToStr(fOPERADOR) +
    ' WHERE CCC.CODIGO = (@CODIGO:= (SELECT cc.CODIGO FROM (SELECT CODIGO, CLIENTE, CAMPANHA, '
    + ' DT_AGENDAMENTO, OPERADOR_LIGACAO, AGENDA, ORDEM, OPERADOR, FONE1 FROM campanhas_clientes WHERE '
    + ' CONCLUIDO = ''NAO'' AND DT_AGENDAMENTO <= NOW() ' +
    ' AND LENGTH(FONE1) >= 10 AND((OPERADOR_LIGACAO IS NULL)OR(OPERADOR_LIGACAO = 0)) '
    + ' AND((OPERADOR IS NULL) OR(OPERADOR = 0)) ' +
    ' AND AGENDA IN(-200, -102, -250, -240, -260, -270) ' +
    ' AND OPERADOR <> -2) cc, ' +
    ' campanhas c, campanhasxoperadores co, clientes c_ WHERE c_.CODIGO = cc.CLIENTE '
    + ' AND DATE(c.DATA_INI) <= DATE(NOW()) ' + ' AND cc.CAMPANHA = c.CODIGO ' +
    ' AND co.CAMPANHA = cc.CAMPANHA ' + ' AND co.OPERADOR = 2 ' +
    ' AND c_.OPERADOR <> -2 ' + ' AND c_.ATIVO = ''SIM'' ' +
    ' AND NOT EXISTS(SELECT ec.CIDADE FROM excecoes_cidade ec WHERE ec.CIDADE = c_.CIDADE) '
    + ' AND NOT EXISTS(SELECT ee.ESTADO FROM excecoes_estado ee WHERE ee.ESTADO = c_.ESTADO) '
    + ' AND NOT EXISTS(SELECT e.COD_ERP FROM excecoes e WHERE e.COD_ERP = c_.COD_ERP) '
    + ' AND NOT EXISTS(SELECT es.CODIGO FROM excecoes_segmentos es WHERE es.SEGMENTO = c_.SEGMENTO) '
    + ValidaFusoHorario() + FiltroDDD + FiltroEstado + ' ORDER BY ' + OrderBy +
    ' LIMIT 1)); SELECT COALESCE(@CODIGO,0) AS CODIGO; ');

  if (Isql.RecordCount > 0) then
  begin
    Result := Isql.fieldByName('CODIGO').AsInteger;
  end
  else
    Result := 0;
end;

function TAtivo.ExecSql_Q1: Integer;
var
  xSql: String;
  Isql: IDBResultSet;
begin
  xSql := ' set @CODIGO = 0; UPDATE campanhas_clientes CCC SET  CCC.concluido = ''SIM'', CCC.OPERADOR_LIGACAO = '
    + IntToStr(fOPERADOR) +
    ' WHERE CCC.CODIGO = (@CODIGO := (SELECT cc.CODIGO FROM (SELECT CODIGO,CLIENTE, '
    + ' OPERADOR, CAMPANHA,DT_AGENDAMENTO,OPERADOR_LIGACAO,AGENDA, ORDEM,FONE1 FROM campanhas_clientes '
    + ' WHERE CONCLUIDO = ''NAO'' AND DT_AGENDAMENTO <= NOW() AND LENGTH(FONE1) >= 10 '
    + ' AND COALESCE(OPERADOR_LIGACAO, 0) = 0 ' +
    ' AND AGENDA IN(-200, -102, -250, -240, -260, -270) ';

  if (LigaRepresentante) then
  begin
    xSql := xSql + ' AND (OPERADOR = ' + IntToStr(fOPERADOR) +
      ' OR OPERADOR = -2) ';
  end
  else
  begin
    xSql := xSql + ' AND OPERADOR = ' + IntToStr(fOPERADOR);
  end;

  xSql := xSql +
    ' ) cc, campanhas c, clientes c_ WHERE c_.CODIGO = cc.CLIENTE AND ' +
    ' c_.ATIVO = ''SIM'' AND cc.CAMPANHA = c.CODIGO ' +
    ' AND NOT EXISTS(SELECT ec.CIDADE from excecoes_cidade ec WHERE ec.CIDADE = c_.CIDADE) '
    + ' AND NOT EXISTS(SELECT ee.ESTADO from excecoes_estado ee WHERE ee.ESTADO = c_.ESTADO) '
    + ' AND NOT EXISTS(SELECT e.COD_ERP from excecoes e WHERE e.COD_ERP = c_.COD_ERP) '
    + ValidaFusoHorario() + ' ORDER BY ' + OrderBy + ' LIMIT 1 )); ' +
    ' SELECT COALESCE(@CODIGO,0) as CODIGO; ';

  Isql := FConnection.ExecuteSQL(xSql);

  if Isql.RecordCount = 1 then
    Result := Isql.fieldByName('CODIGO').AsInteger
  else
    Result := 0;
end;

function TAtivo.ExecSql_Q2: Integer;
var
  Isql: IDBResultSet;
  mQuery:TStringList;
begin
   mQuery:= TStringList.Create;
   mQuery.Add('set @CODIGO = 0;');
   mQuery.Add('UPDATE                                             ');
   mQuery.Add('	campanhas_clientes CCC                                    ');
   mQuery.Add('SET                                                         ');
   mQuery.Add('	CCC.concluido = ''SIM'',                                    ');
   mQuery.Add('	CCC.OPERADOR_LIGACAO = ' + IntToStr(fOPERADOR));
   mQuery.Add('WHERE                                                         ');
   mQuery.Add('	CCC.CODIGO = (@CODIGO := (                                  ');
   mQuery.Add('										SELECT                           ');
   mQuery.Add('											cc.CODIGO                     ');
   mQuery.Add('										FROM                             ');
   mQuery.Add('											(                              ');
   mQuery.Add('												SELECT                      ');
   mQuery.Add('													CODIGO,                    ');
   mQuery.Add('													CLIENTE,                   ');
   mQuery.Add('													OPERADOR,                  ');
   mQuery.Add('													CAMPANHA,                  ');
   mQuery.Add('													DT_AGENDAMENTO,             ');
   mQuery.Add('													OPERADOR_LIGACAO,           ');
   mQuery.Add('													AGENDA,                     ');
   mQuery.Add('													ORDEM,                      ');
   mQuery.Add('													FONE1                      ');
   mQuery.Add('											FROM                             ');
   mQuery.Add('												campanhas_clientes            ');
   mQuery.Add('											WHERE                             ');
   mQuery.Add('												CONCLUIDO = "NAO"              ');
   mQuery.Add('												AND DT_AGENDAMENTO <= NOW() ');
   mQuery.Add('												AND LENGTH(FONE1) >= 10         ');
   mQuery.Add('												AND (                            ');
   mQuery.Add('														(OPERADOR_LIGACAO IS NULL)  ');
   mQuery.Add('														OR                       ');
   mQuery.Add('														(OPERADOR_LIGACAO = 0)  ');
   mQuery.Add('													 )                    ');
   mQuery.Add('											   AND (                            ');
   mQuery.Add('													   (OPERADOR IS NULL)  ');
   mQuery.Add('													OR                       ');
   mQuery.Add('													   (OPERADOR = 0)  ');
   mQuery.Add('												      )                    ');
   mQuery.Add('											   AND OPERADOR <> -2               ');
   mQuery.Add('											) cc,                      ');
   mQuery.Add('											campanhas c,               ');
   mQuery.Add('											campanhasxoperadores co,   ');
   mQuery.Add('											clientes c_                ');
   mQuery.Add('										WHERE                         ');
   mQuery.Add('											c_.CODIGO = cc.CLIENTE       ');
   mQuery.Add('											AND DATE(c.DATA_INI) <= DATE(NOW())  ');
   mQuery.Add('											AND cc.CAMPANHA = c.CODIGO   ');
   mQuery.Add('											AND co.CAMPANHA = cc.CAMPANHA ');
   mQuery.Add('											AND co.OPERADOR = ' + IntToStr(fOPERADOR));
   mQuery.Add('											AND c_.OPERADOR <> -2   ');
   mQuery.Add('											AND c_.ATIVO = ''SIM''    ');
   mQuery.Add('											AND c.PAUSADA = ''NAO''     ');
   mQuery.Add(ValidaFusoHorario());
   mQuery.Add('											' + FiltroDDD);
   mQuery.Add('											' + FiltroESTADO);
   mQuery.Add('											AND NOT EXISTS (SELECT ec.CIDADE FROM excecoes_cidade ec WHERE ec.CIDADE = c_.CIDADE) ');
   mQuery.Add('											AND NOT EXISTS (SELECT ee.ESTADO FROM excecoes_estado ee WHERE ee.ESTADO = c_.ESTADO)  ');
   mQuery.Add('											AND NOT EXISTS (SELECT e.COD_ERP FROM excecoes e WHERE e.COD_ERP = c_.COD_ERP)         ');
   mQuery.Add('											AND NOT EXISTS (SELECT es.CODIGO FROM excecoes_segmentos es WHERE es.SEGMENTO = c_.SEGMENTO)');
   mQuery.Add('										ORDER BY       ');
   mQuery.Add('											' + OrderBy);
   mQuery.Add('										LIMIT ');
   mQuery.Add('											1 ');
   mQuery.Add('									)');
   mQuery.Add('						); ');
   mQuery.Add(' SELECT COALESCE(@CODIGO,0) as CODIGO ');

  Isql := FConnection.ExecuteSQL(mQuery.Text);

  if Isql.RecordCount = 1 then
    Result := Isql.fieldByName('CODIGO').AsInteger
  else
    Result := 0;
end;

procedure TAtivo.ExecutaAcao(pResultado, pACao: Integer);
var
  vSql, vOPERADOR, vFIDELIZA, vFONE1, vFONE2, vFONE3,
  vDESC_FONE1, vDESC_FONE2, vDESC_FONE3: String;
  vOrdem, vRESULTADO, vAGENDA: Integer;
  vDT_AGENDAMENTO: TDateTime;

  procedure GravarRediscar;
  begin
    {if (fObjCli.DadosLigacao.Finalizar.ALTA_PRIORIDADE = 'S') or
      (fResultado.prioridade = 'SIM') then
      vAGENDA := '-200'  //ou 270?
    else
      vAGENDA := '-100';}

    vFONE1 := fObjCli.DadosLigacao.Finalizar.TELEFONE;
    vAGENDA := -270;
    vDT_AGENDAMENTO := Now;

    vOrdem := FConnection.ExecuteSQL
      ('SELECT min(ORDEM) as ordem FROM campanhas_clientes')
      .fieldByName('ORDEM').AsInteger - 1;

    vOPERADOR := fObjCli.DadosLigacao.OPERADOR;
  end;

  procedure GetFones;
  var
    vobj:TFonesCampanha;
  begin
    for vobj in fObjCli.FonesCampanha do
    begin
      if vFONE1 = EmptyStr then
        vFONE1 := vobj.TELEFONE
      else
      if vFONE2 = EmptyStr then
        vFONE2 := vobj.TELEFONE
      else
      if vFONE3 = EmptyStr then
        vFONE3 := vobj.TELEFONE;
    end;
  end;

  procedure AtualizaCadCliFiltro;
  begin
    FConnection.ExecuteDirect('UPDATE clientes SET DT_AGENDAMENTO = '
      + QuotedStr(FormatDateTime('yyyy-mm-dd',vDT_AGENDAMENTO))
      +', COD_RESULTADO = ' + QuotedStr(vRESULTADO.ToString)
      +', ULTI_RESULTADO = NOW() '
      +' WHERE CODIGO = ' + QuotedStr(fObjCli.id.ToString));
  end;

  procedure RemoveAgendamentosDuplicados;
  begin
    try
      FConnection.ExecuteDirect('CALL PR_REMOVE_AGENDAMENTOS_DUPLICADOS()');
    except
      on E: Exception do
        TFunctionsDiversos.ShowMessageDesenv('CALL PR_REMOVE_AGENDAMENTOS_DUPLICADOS() - ' + E.message);
    end;
  end;

  function FidelizaNoFinalizar:Boolean;
  begin
    Result := FConnection.ExecuteSQL(' SELECT FINALIZANOFINALIZAR FROM parametros ')
      .fieldByName('FINALIZANOFINALIZAR').AsString = 'S';
  end;

  function OperadorPrimeiroContato:Boolean;
  begin
    Result := FConnection.ExecuteSQL(' SELECT AgendaNoContato FROM parametros ')
      .fieldByName('AgendaNoContato').AsString = 'S';
  end;

  procedure ExecutarResultadoEVENDA;
  begin
    if (FidelizaNoFinalizar and (fResultado.EVENDA = 'SIM')) or OperadorPrimeiroContato then
    begin
      FConnection.ExecuteDirect('UPDATE clientes SET OPERADOR = ' + QuotedStr(fObjCli.DadosLigacao.OPERADOR)
        + ' WHERE CODIGO = ' + QuotedStr(IntToStr(fObjCli.id)));

      FConnection.ExecuteDirect('UPDATE campanhas_clientes SET OPERADOR = '
        + QuotedStr(fObjCli.DadosLigacao.OPERADOR)
        +' WHERE CLIENTE = ' + QuotedStr(IntToStr(fObjCli.id))
        + ' AND CONCLUIDO = "NAO"');

      if fResultado.ECONTATO = 'SIM' then
      begin
        FConnection.ExecuteDirect('UPDATE historico_cli SET OPERADOR = '
          + QuotedStr(fObjCli.DadosLigacao.NOME_OPERADOR) + ' WHERE CLIENTE = '
          + QuotedStr(IntToStr(fObjCli.id)));
      end;
    end;
  end;

  procedure GravarCompra;
  begin
    {if (InsereCompra) and (Evenda(Ultimo_Resultado)) then
      begin
        if not tblCompras.Active then
          tblCompras.Open;
        tblCompras.Append;
        tblComprasCLIENTE.AsInteger := cliente;
        tblComprasOPERADOR.AsString := OPERADOR_CODIGO;
        tblComprasDATA.AsDateTime := Now;

        try
          Application.CreateForm(TfrmInsereCompra, frmInsereCompra);
          frmInsereCompra.ShowModal;
        finally
          FreeAndNil(frmInsereCompra);
        end;
      end;}
  end;

begin
  fCampanhasCliente:= TCampanhasClientes.create;

  vDT_AGENDAMENTO := fObjCli.DadosLigacao.Finalizar.DATA +
          StrToTimeDef(fObjCli.DadosLigacao.Finalizar.HORA,0);

  vFIDELIZA := 'N';
  vAGENDA := 0;
  vOrdem := 0;
  vRESULTADO := fObjCli.DadosLigacao.Finalizar.RESULTADO;
  vOPERADOR := fObjCli.OPERADOR.ToString;

  if pACao <> 6 then
  begin
    FConnection.ExecuteDirect
      ('UPDATE clientes SET ATIVO = "SIM" WHERE CODIGO = ' +
      fObjCli.id.ToString);
  end
  else begin
    FConnection.ExecuteDirect
      ('UPDATE clientes SET ATIVO = "NAO" WHERE CODIGO = ' +
      fObjCli.id.ToString);
    exit;
  end;

  GetFones();

  case pACao of
    1: // REDISCAR
      begin
        if fObjCli.DadosLigacao.Finalizar.TELEFONE <> '' then
          vFONE1 := TFunctionsDiversos.SomenteNumeros(fObjCli.DadosLigacao.Finalizar.TELEFONE);

        GravarRediscar;
        vFIDELIZA := 'S';
      end;
    2, 7: // AGENDA COMPARTILHADA - INFORMA HORA E DATA ... 7 =  ENVIO DE EMAIL
      begin
        vOPERADOR := EOperadorCotacao(vRESULTADO,
          fObjCli.DadosLigacao.OPERADOR,
          fObjCli.id.ToString);

        if FIDELIZARCOTACAO then
          vFIDELIZA := 'S';
      end;
    3,4,5,13,9,11,12,14: // AGENDA AUTOMÁTICA  20 MINUTOS
      begin
        vOPERADOR := EOperadorCotacao(vRESULTADO,
          fObjCli.DadosLigacao.OPERADOR,
          fObjCli.id.ToString);

        if FIDELIZARCOTACAO then
          vFIDELIZA := 'S';

        if (fObjCli.DadosLigacao.Finalizar.ALTA_PRIORIDADE = 'S') or
            (fResultado.prioridade = 'SIM') then
          vAGENDA := -200
        else
          vAGENDA := 0;
      end;
    8:
      begin
        vAGENDA := -240;
        vFIDELIZA := 'S';
        if fObjCli.DadosLigacao.Finalizar.OperadorDelegar >= 0 then
          vOPERADOR := fObjCli.DadosLigacao.Finalizar.OperadorDelegar.ToString;
      end;
  end;

  if (fObjCli.DadosLigacao.Finalizar.ALTA_PRIORIDADE = 'S')
    or (fResultado.prioridade = 'SIM') then
  begin
    if vAGENDA > -200 then
      vAGENDA := -200;
  end;

  fCampanhasCliente.Cliente:= fObjCli.id;
  fCampanhasCliente.DT_RESULTADO := '0000-00-00';
  fCampanhasCliente.Campanha := fObjCli.DadosLigacao.COD_CAMPANHA;


  fCampanhasCliente.DT_AGENDAMENTO := vDT_AGENDAMENTO;
  fCampanhasCliente.CONCLUIDO:= 'NAO';
  fCampanhasCliente.FONE1:= TFunctionsDiversos.SomenteNumeros(vFONE1);
  fCampanhasCliente.FONE2:= TFunctionsDiversos.SomenteNumeros(vFONE2);
  fCampanhasCliente.FONE3:= TFunctionsDiversos.SomenteNumeros(vFONE3);
  fCampanhasCliente.ORDEM:= vOrdem;
  fCampanhasCliente.OPERADOR:= StrToIntDef(vOPERADOR,0);
  fCampanhasCliente.AGENDA:= vAGENDA;
  fCampanhasCliente.OPERADOR_LIGACAO:= 0;
  fCampanhasCliente.FIDELIZA := vFIDELIZA;

  FContainerCampanhasCliente:= TContainerObjectSet<TCampanhasClientes>.Create(FConnection);
  FContainerCampanhasCliente.Insert(fCampanhasCliente);

  if pACao <> 6 then
    AtualizaCadCliFiltro;

  RemoveAgendamentosDuplicados;

  ExecutarResultadoEVENDA;

  GravarCompra;
end;

function TAtivo.EnviarEmail(const AValue: TJSONObject): TJSONObject;
var
  fobj: TConfigMail;
  dmEmail: TdmEmail;
begin
  fobj := TInfotecUtils.JsonToObject<TConfigMail>(AValue.ToJSON);

  Conectar(fobj.DataBase);
  try
    fobj.OPERADOR_NAME :=
    FConnection.ExecuteSQL
     ('SELECT NOME FROM operadores WHERE CODIGO = ' +
     fobj.OPERADOR).GetFieldValue('NOME');

    dmEmail:= TdmEmail.Create(nil);
    dmEmail.EnviarEmail(fobj);

    Result := TInfotecUtils.ObjectToJsonObject(fObjCli) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.EOperadorCotacao(var Resultado: Integer;
  OperadorAtual, Cliente: string): string;
var
  UNIDADE_Cliente, Contador: Integer;
  DATA_ULTIMA_TRANSFERENCIA: String;
  vLogFidelizar, vSql: String;
begin

  if FConnection.ExecuteSQL(' SELECT CARTEIRA_FIXA_OPERADOR FROM parametros ')
    .fieldByName('CARTEIRA_FIXA_OPERADOR').AsString = 'S' then
  begin
    Result := IntToStr(fObjCli.OPERADOR);
    FIDELIZARCOTACAO := true;
    vLogFidelizar := ' CARTEIRA_FIXA_OPERADOR=SIM ';
    exit;
  end;

  Contador := 0;
  FIDELIZARCOTACAO := False;

  Result := OperadorAtual;

  if FConnection.ExecuteSQL
    ('SELECT r.FIDELIZARCOTACAO FROM resultados r WHERE FIDELIZARCOTACAO = "SIM" AND CODIGO = '
    + QuotedStr(IntToStr(Resultado))).RecordCount = 0 then // se não é cotação
  begin
    vLogFidelizar := vLogFidelizar + '||' + 'RESULTADO: ' + IntToStr(Resultado)
      + ' NÃO FIDELIZA';
    UNIDADE_Cliente := FConnection.ExecuteSQL
      (' select COD_UNIDADE from clientes where CODIGO = ' + QuotedStr(Cliente))
      .fieldByName('COD_UNIDADE').AsInteger;

    with FConnection.ExecuteSQL
      (' SELECT a.DATA_HORA FROM transferencia_clientes a INNER JOIN ' +
      ' transferencia_clientes_itens b ON a.CODIGO = b.CODIGO WHERE b.CLIENTE = '
      + QuotedStr(Cliente) + ' ORDER BY a.DATA_HORA DESC LIMIT 1 ') do
    begin
      if RecordCount = 0 then
        DATA_ULTIMA_TRANSFERENCIA := ''
      else
      begin
        DATA_ULTIMA_TRANSFERENCIA := ' AND cc.DATA_HORA_LIG > ' +
          QuotedStr(FormatDateTime('yyyy-mm-dd HH:NN:SS',
          fieldByName('DATA_HORA').AsDateTime));
        vLogFidelizar := vLogFidelizar + '||' + 'DATA_ULTIMA_TRANSFERENCIA: ' +
          FormatDateTime('yyyy-mm-dd HH:NN:SS', fieldByName('DATA_HORA')
          .AsDateTime);
      end;
    end;

    vSql := 'SELECT r.FIDELIZARCOTACAO, cc.OPERADOR_LIGACAO, ca.UNIDADE, r.QTDE_FIDELIZARCOTACAO FROM campanhas_clientes cc ,resultados r, campanhas ca '
      + ' WHERE ca.CODIGO = cc.CAMPANHA and r.CODIGO = cc.RESULTADO AND cc.CLIENTE = '
      + QuotedStr(Cliente) + DATA_ULTIMA_TRANSFERENCIA +
      ' AND r.ECONTATO = ''SIM'' ORDER BY cc.CODIGO DESC LIMIT 50 ';

    with FConnection.ExecuteSQL(vSql) do
    begin
      if RecordCount = 0 then
        vLogFidelizar := vLogFidelizar + '||LIGAÇÕES SEM CONTATO';

      while NotEof do
      begin
        Contador := Contador + 1;

        if fieldByName('QTDE_FIDELIZARCOTACAO').AsInteger > 0 then
          if Contador > fieldByName('QTDE_FIDELIZARCOTACAO').AsInteger then
          begin
            vLogFidelizar := vLogFidelizar + '||QTDE_FIDELIZARCOTACAO: ' +
              fieldByName('QTDE_FIDELIZARCOTACAO').AsString +
              ' MENOR QUE NR DE CONTATOS';
            break;
          end;

        if (fieldByName('UNIDADE').AsInteger <> UNIDADE_Cliente) and
          (fieldByName('OPERADOR_LIGACAO').AsString <> fObjCli.DadosLigacao.OPERADOR) then
        begin
          vLogFidelizar := vLogFidelizar + '||UNIDADE DIFERENTE:' +
            fieldByName('UNIDADE').AsString + ' <> ' +
            IntToStr(UNIDADE_Cliente);
          break;
        end
        else if fieldByName('FIDELIZARCOTACAO').AsString = 'SIM' then
        begin
          Result := fieldByName('OPERADOR_LIGACAO').AsString;
          FIDELIZARCOTACAO := true;
          vLogFidelizar := vLogFidelizar +
            '||FIDELIZARCOTACAO=SIM OPERADOR: ' + Result;
          break;
        end;
      end
    end;

  end
  else
  begin
    Result := fObjCli.DadosLigacao.OPERADOR;
    FIDELIZARCOTACAO := true;
    vLogFidelizar := vLogFidelizar +
      '||FIDELIZARCOTACAO RESULTADO=SIM OPERADOR: ' + Result;
  end;

  {if vLogFidelizar <> '' then
    addLog('  Cliente: ' + Cliente + vLogFidelizar,
      'LogFideliza_' + FormatDateTime('yyyymmdd', Now) + '.txt');}

  if FConnection.ExecuteSQL('SELECT 1 FROM resultados WHERE EVENDA = "SIM" AND CODIGO = '
   + QuotedStr(fObjCli.DadosLigacao.Finalizar.RESULTADO.ToString)).RecordCount > 0 then
  Result := fObjCli.DadosLigacao.OPERADOR;
end;

function TAtivo.FinalizarLigacao(const AValue: TJSONObject): TJSONObject;
var
  vSql: String;
  vObj:TJSONObject;
  vListaPropostas: TPropostasClientes;
  vDATA_HORA_LIG: TDateTime;
begin
  fObjCli := TInfotecUtils.JsonToObject<TClientes>(AValue.ToJSON);
  fOPERADOR := fObjCli.DadosLigacao.OPERADOR.ToInteger;
  Conectar(fObjCli.DataBase);
  try
    Liberar_operadores_ligacoes;

    TConsistirFinalizarLigacaoFactory.Execute(fObjCli, FConnection);

    if StrToTimeDef(fObjCli.DadosLigacao.Finalizar.Hora,0) <= 0 then
      fObjCli.DadosLigacao.Finalizar.HORA := TimeToStr(TimeOf(Now));

    VerificaDataAcao;

    fObjCli.DadosLigacao.NOME_OPERADOR := GetNomeLoginOperador(fOPERADOR);

    fObjCli.id := GravarDadosCliente(fObjCli.id, AValue);

    if (fObjCli.DadosLigacao.Finalizar.TELEFONE <> '') then
    begin
      if Copy(fObjCli.DadosLigacao.Finalizar.TELEFONE,1,1) = '0' then
        fObjCli.DadosLigacao.Finalizar.TELEFONE := Copy(fObjCli.DadosLigacao.Finalizar.TELEFONE,2,20);

      if Length(fObjCli.DadosLigacao.Finalizar.TELEFONE) > 9 then
      begin
        fObjCli.DadosLigacao.Finalizar.TELEFONE := Copy(fObjCli.DadosLigacao.Finalizar.TELEFONE,1,2)
        +' '+Copy(fObjCli.DadosLigacao.Finalizar.TELEFONE,3,20);
      end;
    end;

    vSql := 'UPDATE historico_cli SET DATAHORA_FIM = ' +
      QuotedStr(FormatDateTime('yyyy-mm-dd HH:NN:SS', Now)) + ', TELEFONE = ' +
      QuotedStr(fObjCli.DadosLigacao.Finalizar.TELEFONE) + ', OBSERVACAO = ' +
      QuotedStr(fObjCli.DadosLigacao.Finalizar.OBSERVACAO) + ', RESULTADO = ' +
      QuotedStr(fObjCli.DadosLigacao.Finalizar.Resultado.ToString);

    if fObjCli.DadosLigacao.Finalizar.FASE_CONTATO > 0 then
      vSql := vSql + ', CODIGO_FASE_CONTATO = ' +
        fObjCli.DadosLigacao.Finalizar.FASE_CONTATO.ToString;

    vSql := vSql + ' WHERE CLIENTE = ' + fObjCli.id.ToString +
      ' and COALESCE(RESULTADO,0) = 0 AND COALESCE(DATAHORA_FIM,0) = 0 ';

    FConnection.ExecuteDirect(vSql);

    vDATA_HORA_LIG := fObjCli.DadosLigacao.DATA_INICIO;

    if vDATA_HORA_LIG = 0 then
    begin
      vDATA_HORA_LIG := GetSQLSingle(' select TEMPO as DATA_HORA_LIG from operadores_status WHERE STATUS_ATUAL IN (1,2) AND OPERADOR = '
       + fOPERADOR.ToString, 'DATA_HORA_LIG');

      if vDATA_HORA_LIG = 0 then
        vDATA_HORA_LIG := Now
      else
        vDATA_HORA_LIG := DateOf(Now) + vDATA_HORA_LIG;
    end;

    vSql := 'UPDATE campanhas_clientes SET RESULTADO = ' +
      QuotedStr(fObjCli.DadosLigacao.Finalizar.Resultado.ToString) +
      ', DT_RESULTADO = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', Now)) +
      ', DATA_HORA_LIG = if(coalesce(DATA_HORA_LIG,0) > 0, DATA_HORA_LIG, ' +
          QuotedStr(FormatDateTime('yyyy-mm-dd HH:NN:SS', vDATA_HORA_LIG)) + ')' +
      ', TELEFONE_LIGADO = ' + QuotedStr(fObjCli.DadosLigacao.Finalizar.TELEFONE) +
      ', DATA_HORA_FIM = ' + QuotedStr(FormatDateTime('yyyy-mm-dd HH:NN:SS', Now)) +
      ', CONCLUIDO = ''SIM'' WHERE CODIGO = ' +
      QuotedStr(fObjCli.DadosLigacao.CODIGO.ToString);
    FConnection.ExecuteDirect(vSql);

    vSql := ' UPDATE login_ativo_receptivo SET SAIDA = NOW(), ' +
      ' TEMPO_LOGADO = SEC_TO_TIME(TIME_TO_SEC(NOW()) - TIME_TO_SEC(ENTRADA)), ' +
      ' LIGACOES_OK = COALESCE(LIGACOES_OK,0) + 1 ' +
      ' WHERE CODIGO = ' + QuotedStr(fObjCli.DadosLigacao.CODIGOENTRADA);
     FConnection.ExecuteDirect(vSql);

    fResultado := TContainerObjectSet<TResultados>.Create(FConnection)
      .Find(fObjCli.DadosLigacao.Finalizar.Resultado);

    CriaFidelizacao(StrToIntDef(fObjCli.DadosLigacao.OPERADOR, 0),
      fObjCli.DadosLigacao.CODIGO, fObjCli.id, fResultado.QTDE_FIDELIZARCOTACAO,
      fResultado.ECONTATO = 'SIM', fResultado.FIDELIZARCOTACAO = 'SIM',
      fObjCli.DadosLigacao.FIDELIZA = 'S');

    ExecutaAcao(fObjCli.DadosLigacao.Finalizar.Resultado, fCOD_ACAO);

    FidelizarContatos;

    if (fResultado.PROPOSTA = 'SIM')and(fObjCli.DadosLigacao.Finalizar.VALOR_PROPOSTA > 0) then
    begin
      vSql := 'INSERT INTO PROPOSTAS (LIGACAO, VALOR)VALUE('+fObjCli.DadosLigacao.CODIGO.ToString
        +','+QuotedStr(StringReplace(FormatFloat('0.00', fObjCli.DadosLigacao.Finalizar.VALOR_PROPOSTA),',','.',[]))
        +')';
      FConnection.ExecuteDirect(vSql);
    end;

    if (fResultado.EVENDA = 'SIM')and(Assigned(fObjCli.DadosLigacao.Finalizar.COMPRAS)) then
    begin
      vSQL:= 'select * from compras where descricao = '
       + QuotedStr(fObjCli.DadosLigacao.Finalizar.COMPRAS.DESCRICAO);

      if FConnection.ExecuteSQL(vSQL).RecordCount > 0 then
        raise Exception.Create('Já existe uma compra com a descrição cadastrada!');

      vSql := 'INSERT INTO COMPRAS (CLIENTE, DATA, VALOR, DESCRICAO, OPERADOR)VALUE('
        +fObjCli.id.ToString+',now(), '
        +QuotedStr(StringReplace(FormatFloat('0.00', fObjCli.DadosLigacao.Finalizar.COMPRAS.VALOR),',','.',[]))
        +', '+ QuotedStr(fObjCli.DadosLigacao.Finalizar.COMPRAS.DESCRICAO)
        +', '+ fObjCli.DadosLigacao.OPERADOR+')';
      FConnection.ExecuteDirect(vSql);

      for vListaPropostas in fObjCli.DadosLigacao.Finalizar.COMPRAS.DadosPropostasCliente do
      begin
        if vListaPropostas.UTILIZAR = 'true' then
        begin
          vSql := ' insert into propostas_compras values(' + vListaPropostas.CODIGO.ToString
            + ', (SELECT MAX(CODIGO) from COMPRAS) ) ';
          FConnection.ExecuteDirect(vSql);
        end;
      end;
    end;

    //historico
    GravarHistoricoCli;

    Result := TInfotecUtils.ObjectToJsonObject(fObjCli) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

procedure TAtivo.FidelizarContatos;
begin
  //
end;

function TAtivo.GetAgenda(const AValue: TJSONObject): TJSONArray;
var
  xSql: String;
  vAgenda: TAgendaOperador;
  vListAgenda: TObjectList<TAgendaOperador>;
  vFiltro: TAgendaFiltros;
begin
  vFiltro := TInfotecUtils.JsonToObject<TAgendaFiltros>(AValue.ToJSON);
  Conectar(vFiltro.DataBase);
  try
    vListAgenda := TObjectList<TAgendaOperador>.Create;
    try
      xSql := ' SELECT cc.CODIGO,	c.NOME AS CAMPANHA,	TRIM(cli.RAZAO) AS CLIENTE, '
      +' cli.COD_ERP,	cc.DT_AGENDAMENTO,	cc.CONCLUIDO, '
      +' cc.CLIENTE AS CODIGO_CLIENTE, cc.MANUAL,  '
      +' (select COALESCE(cr.cor, ' + QuotedStr('#0000000') + ' ) from campanha_clientes_cor cr where cr.AGENDA = cc.AGENDA) as COR  FROM campanhas_clientes cc, '
	    +' clientes cli, campanhas c '
      +' WHERE cli.CODIGO = cc.CLIENTE '
	    +' AND c.CODIGO = cc.CAMPANHA	AND CC.CONCLUIDO = ''NAO'' AND cc.OPERADOR = '+vFiltro.OPERADOR;

      if vFiltro.EM_ATRASO = 'True' then
      begin
        xSql := xSql +' AND cc.DT_AGENDAMENTO < ' + QuotedStr(FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));
      end;

      if vFiltro.DATA_INICIAL <> '' then
      begin
        xSql := xSql +' AND cc.DT_AGENDAMENTO >= ' + QuotedStr(
          Copy(vFiltro.DATA_INICIAL,1,10));
      end
      else begin
        xSql := xSql +' AND cc.DT_AGENDAMENTO >= '
        + QuotedStr(FormatDateTime('dd/mm/yyyy', Now-30));
      end;


      if vFiltro.DATA_FINAL <> '' then
      begin
        xSql := xSql +' AND cc.DT_AGENDAMENTO <= ' +
          QuotedStr(Copy(vFiltro.DATA_FINAL,1,10)+ ' 23:59:59');
      end;

      if vFiltro.COD_ERP <> '' then
      begin
        xSql := xSql +' AND cli.COD_ERP = '+ vFiltro.COD_ERP;
      end;

      if vFiltro.CLIENTE_ATIVO = 'SIM' then
      begin
        xSql := xSql +' AND cli.ATIVO = ''SIM'' ';
      end;

      if vFiltro.CLIENTE_ATIVO = 'NAO' then
      begin
        xSql := xSql +' AND cli.ATIVO = ''NAO'' ';
      end;

      if vFiltro.CLIENTE_EXCECAO = 'SIM' then
      begin
        xSql := xSql +'  and ( exists (select ee.estado from excecoes_estado ee where ee.estado = cli.estado)' + #13 +
        '  or  exists (select ec.cidade from excecoes_cidade ec where ec.cidade = cli.cidade)' + #13 +
        '  or  exists (select e.cod_erp from excecoes e where e.cod_erp = cli.cod_erp)' + #13 +
        '  or  exists (select es.codigo from excecoes_segmentos es where es.segmento = cli.SEGMENTO))';
      end;

      if vFiltro.CLIENTE_EXCECAO = 'NAO' then
      begin
        xSql := xSql + '  and (not exists (select ee.estado from excecoes_estado ee where ee.estado = cli.estado)' + #13 +
        '  and not exists (select ec.cidade from excecoes_cidade ec where ec.cidade = cli.cidade)' + #13 +
        '  and not exists (select e.cod_erp from excecoes e where e.cod_erp = cli.cod_erp)' + #13 +
        '  and not exists (select es.codigo from excecoes_segmentos es where es.segmento = cli.SEGMENTO))';
      end;

      xSQL := xSQL + ' ORDER BY cc.DT_AGENDAMENTO DESC ';

      with FConnection.ExecuteSQL(xSql) do
      begin
        while NotEof do
        begin
          vAgenda:= TAgendaOperador.Create;
          vAgenda.MANUAL := fieldByName('MANUAL').AsString;
          vAgenda.CAMPANHA := fieldByName('CAMPANHA').AsString;
          vAgenda.COD_ERP := fieldByName('COD_ERP').AsInteger;
          vAgenda.CLIENTE := fieldByName('CLIENTE').AsString;
          vAgenda.CODIGO := fieldByName('CODIGO').AsInteger;
          vAgenda.CONCLUIDO := fieldByName('CONCLUIDO').AsString;
          vAgenda.DT_AGENDAMENTO := fieldByName('DT_AGENDAMENTO').AsDateTime;
          vAgenda.CODIGO_CLIENTE := fieldByName('CODIGO_CLIENTE').AsInteger;
          vAgenda.COR := fieldByName('COR').AsString;
          vListAgenda.Add(vAgenda);
        end;
      end;

      Result := TInfotecUtils.ObjectToJsonArray<TAgendaOperador>(vListAgenda);
    finally
      vListAgenda.Free;
    end;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.GetCidades(const pUF, pBaseDados: String): TJSONArray;
var
  vListCidades: TObjectList<TCidades>;
begin
  Result := nil;

  if pUF = '' then
    raise exception.Create('Nenhum Estado Informado!');

  Conectar(pBaseDados);
  try

    vListCidades := TObjectList<TCidades>.Create;
    try
      vListCidades := TContainerObjectSet<TObjectList<TCidades>>.Create(FConnection)
        .Find(' UF = '+QuotedStr(pUF));

      Result := TInfotecUtils.ObjectToJsonArray<TCidades>(vListCidades);
    finally
      vListCidades.Free;
    end;

  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.GetContainer: TObject;
begin
  if FContainer = nil then
    FContainer := TContainerObjectSet<TClientes>.Create(FConnection);

  Result := FContainer;
end;

function TAtivo.GetDate: Double;
begin
  Result := Now;
end;

function TAtivo.GetHistoricoCliente(const pCLIENTE,
  pBaseDados: String): TJSONArray;
var
  xSql: String;
  vHistoricoCliente: THistoricoCliente;
  vListHistoricoCliente: TObjectList<THistoricoCliente>;
begin
  Conectar(pBaseDados);
  try
    vListHistoricoCliente := TObjectList<THistoricoCliente>.Create;
    try

      xSql := ' select cc.CODIGO, cc.campanha, o.nome as operador_ligacao, cc.TELEFONE_LIGADO, '
      +' cc.RESULTADO, r.NOME as res_nome, r.ECONTATO, r.FIDELIZARCOTACAO, uni.DESCRICAO as UNIDADE, '
      +' cc.DATA_HORA_LIG, h.observacao, cr.COR  from campanhas_clientes cc '
      +' left join resultados r on r.CODIGO = cc.resultado '
      +' left join operadores o on o.codigo = cc.operador_ligacao '
      +' left join historico_cli h on h.codigo = cc.codigo '
      +' left join campanhas cam on cam.CODIGO = cc.CAMPANHA '
      +' left join unidades uni on uni.CODIGO = cam.UNIDADE '
      +' left join campanha_clientes_cor cr on cr.AGENDA = cc.AGENDA'
      +' where cc.cliente = '+pCLIENTE+' and concluido = ''SIM'' order by cc.codigo desc ';
      //+' limit 10 ';

      with FConnection.ExecuteSQL(xSql) do
      begin
        while NotEof do
        begin
          vHistoricoCliente:= THistoricoCliente.Create;
          vHistoricoCliente.CODIGO := fieldByName('CODIGO').AsInteger;
          vHistoricoCliente.CAMPANHA := fieldByName('CAMPANHA').AsInteger;
          vHistoricoCliente.TELEFONE_LIGADO := fieldByName('TELEFONE_LIGADO').AsString;
          vHistoricoCliente.OPERADOR_LIGACAO := fieldByName('operador_ligacao').AsString;
          vHistoricoCliente.RESULTADO := fieldByName('RESULTADO').AsInteger;
          vHistoricoCliente.RES_NOME := fieldByName('RES_NOME').AsString;
          vHistoricoCliente.ECONTATO := fieldByName('ECONTATO').AsString;
          vHistoricoCliente.FIDELIZARCOTACAO := fieldByName('FIDELIZARCOTACAO').AsString;
          vHistoricoCliente.OBSERVACAO := TInfotecUtils.RemoverEspasDuplas(fieldByName('OBSERVACAO').AsString);
          vHistoricoCliente.DATA_HORA_LIG := fieldByName('DATA_HORA_LIG').AsDateTime;
          vHistoricoCliente.UNIDADE := fieldByName('UNIDADE').AsString;
          vHistoricoCliente.COR := fieldByName('COR').AsString;
          vListHistoricoCliente.Add(vHistoricoCliente);
        end;
      end;

      Result := TInfotecUtils.ObjectToJsonArray<THistoricoCliente>(vListHistoricoCliente);
    finally
      vListHistoricoCliente.Free;
    end;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.GetIdProximaLigacao: Integer;
begin
  Result := GetLigacaoNaoFinalizada();

  if (Result = 0) then
    Result := ExecSql_Q1();

  if (Result = 0) then
    Result := ExecSql_Q0();

  if (Result = 0) then
    Result := ExecSql_Q2();
end;

function TAtivo.GetLigacaoNaoFinalizada: Integer;
var
  xSql: String;
  Isql: IDBResultSet;
begin
  xSql := ' SELECT cc.CODIGO FROM campanhas_clientes cc inner join clientes cli on cli.CODIGO = cc.CLIENTE '
    + ' WHERE cc.CONCLUIDO = ''SIM'' AND coalesce(cc.RESULTADO,0) = 0 AND cc.DATA_HORA_LIG >= 0 '
    + '  AND cc.OPERADOR_LIGACAO = ' + IntToStr(fOPERADOR) +
    ' and cli.ATIVO = ''SIM'' LIMIT 1; ';

  Isql := FConnection.ExecuteSQL(xSql);

  if Isql.RecordCount = 1 then
    Result := Isql.GetFieldValue('CODIGO')
  else
    Result := 0;
end;

function TAtivo.GetNomeLoginOperador(pOperador: Integer): String;
begin
  Result := FConnection.ExecuteSQL('SELECT LOGIN FROM operadores where codigo = ' + pOperador.ToString)
    .GetFieldValue('LOGIN');
end;

function TAtivo.GetObjTabela(const AValue: TJSONObject): TObject;
begin
  Result := TInfotecUtils.JsonToObject<TClientes>(AValue.ToJSON);
end;

procedure TAtivo.GetParamOperador;
var
  vRet: String;
begin
  OrderBy := FConnection.ExecuteSQL('SELECT ORDERBY FROM parametros')
    .GetFieldValue('ORDERBY');

  LigaRepresentante := FConnection.ExecuteSQL
    ('SELECT LIGA_REPRESENTANTE FROM operadores WHERE CODIGO = ' +
    IntToStr(fOPERADOR)).GetFieldValue('LIGA_REPRESENTANTE') = 'SIM';

  with FConnection.ExecuteSQL
    (' SELECT GROUP_CONCAT(DDD) as DDD FROM ddd_operadores WHERE OPERADOR = ' +
    IntToStr(fOPERADOR)) do
  begin
    if RecordCount > 0 then
      vRet := fieldByName('DDD').AsString;
  end;

  if vRet <> '' then
    FiltroDDD := ' AND LEFT(cc.FONE1,2) IN (' + vRet + ') '
  else
    FiltroDDD := '';

  vRet := FConnection.ExecuteSQL
    ('SELECT GROUP_CONCAT(ESTADO) as ESTADO FROM estados_operadores WHERE OPERADOR = '
    + IntToStr(fOPERADOR)).fieldByName('ESTADO').AsString;

  if vRet <> '' then
  begin
    FiltroEstado := vRet.Replace(',', ''',''');
    FiltroEstado := ' AND c_.ESTADO IN  (' + FiltroEstado + ') ';
  end
  else
    FiltroEstado := '';
end;

function TAtivo.GetSQLSingle(pSQL, pCampo: String): Variant;
begin
  with FConnection.ExecuteSQL(pSQl) do
  begin
    if RecordCount > 0 then
      Result := FieldByName(pCampo).AsVariant;
  end;
end;

function TAtivo.GetStart(const pBaseDados: String): TJSONObject;
var
  vStart: TAtivoStart;
  vResultado: TResultados;
begin
  vStart := TAtivoStart.Create;

  Conectar(pBaseDados);
  try
    vStart.Resultados := TContainerObjectSet<TResultados>.Create(FConnection)
      .FindWhere(' CODIGO > -1 ', 'NOME');
    vStart.FaseContato := TContainerObjectSet<TFaseContato>.Create
      (FConnection).Find;
    vStart.ConfigMail := TContainerObjectSet<TConfigMail>.Create
      (FConnection).Find;

    vStart.Operadores := TContainerObjectSet<TOperadores>.Create
      (FConnection).FindWhere(' ATIVO = ''SIM'' ');

    vStart.FoneAreas := TContainerObjectSet<TFoneAreas>.Create
      (FConnection).FindWhere(' CODIGO <> '''' ');

    vStart.MotivosPausa := TContainerObjectSet<TMotivosPausa>.Create
      (FConnection).Find;

    vStart.Grupos := TContainerObjectSet<TGrupos>.Create
      (FConnection).Find;

    vStart.Midias := TContainerObjectSet<TMidias>.Create
      (FConnection).Find;

    vStart.Segmentos := TContainerObjectSet<TSegmentos>.Create
      (FConnection).Find;

    for vResultado in vStart.Resultados do
    begin
      vResultado.DESCRICAO_ACAO := FConnection.ExecuteSQL
        (' SELECT DESCRICAO FROM ACOES WHERE CODIGO = ' +
        vResultado.COD_ACAO.ToString).fieldByName('DESCRICAO').AsString
    end;

    vStart.Cargos := TContainerObjectSet<TCargos>.Create
      (FConnection).Find;

    Result := TInfotecUtils.ObjectToJsonObject(vStart) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.GravarContato(const AValue: TJSONObject): TJSONObject;
var
  fobj, vObjBaseUpdate: TContatos;
begin
  fobj := TInfotecUtils.JsonToObject<TContatos>(AValue.ToJSON);

  Conectar(fobj.DataBase);
  try
    if fobj.id = 0 then
    begin
      with FConnection.ExecuteSQL(' SELECT MAX(CODIGO) as COD FROM CONTATOS ') DO
      begin
        if RecordCount > 0 then
        begin
          fobj.id := fieldByName('COD').AsInteger;
        end;
      end;

      fobj.id := fobj.id + 1;
      TContainerObjectSet<TContatos>.Create(FConnection).Insert(fobj);
    end
    else begin
      with TContainerObjectSet<TContatos>.Create(FConnection) do
      begin
        vObjBaseUpdate := Find(fobj.id);
        Modify(vObjBaseUpdate);
        Update(TInfotecUtils.JsonToObject<TContatos>(AValue.ToJSON));
      end;
    end;

    Result := TInfotecUtils.ObjectToJsonObject(fObj) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.GravarDadosCliente(const pid:Integer; const AValue: TJSONObject) : integer;
var
  vObjBaseUpdate, obj, jsonObject: TClientesGravar;
  TempObject: TObjectList<TClientesGravar>;
   objCli: TClientesGravar;


   function removeMascara(s: string): string;
   begin
     result := stringReplace(stringReplace(stringReplace(s, '/', '', [rfReplaceAll]),
                             '.', '', [rfReplaceAll]),
                             '-', '', [rfReplaceAll]) ;
   end;
    procedure CadastraCliente;
    var
      sql, where: string;
     begin
     objCli := TClientesGravar.create;
     vObjBaseUpdate  := (TInfotecUtils.JsonToObject<TClientesGravar>(AValue.ToJSON));

     objCli.RAZAO := vObjBaseUpdate.RAZAO;
     objCli.FANTASIA := vObjBaseUpdate.FANTASIA;
     objCli.PESSOA := vObjBaseUpdate.PESSOA;
     objCli.Ativo := '1';
     objCli.CPF_CNPJ  := removeMascara(vObjBaseUpdate.CPF_CNPJ);
     objCli.IE_RG := vObjBaseUpdate.IE_RG;
     //objCli.COD_ERP := EmptyParam;
     objCli.OPERADOR  := vObjBaseUpdate.OPERADOR;
     objCli.OBS_OPERADOR := vObjBaseUpdate.OBS_OPERADOR;
     objCli.OBS_ADMIN  :='';
     objCli.FONE1 :=vObjBaseUpdate.FONE1;
     objCli.FONE2 :=vObjBaseUpdate.FONE2;
     objCli.FONE3 :=vObjBaseUpdate.FONE3;
     objCli.DESC_FONE1 := vObjBaseUpdate.DESC_FONE1;
     objCli.DESC_FONE2 := vObjBaseUpdate.DESC_FONE2;
     objCli.DESC_FONE3 := vObjBaseUpdate.DESC_FONE3;
     objCli.AREA1   :=vObjBaseUpdate.AREA1;
     objCli.AREA2  := vObjBaseUpdate.AREA2;
     objCli.AREA3    := vObjBaseUpdate.AREA3;
     objCli.END_RUA  := '';
     objCli.CIDADE  := '';
     objCli.BAIRRO  := ''  ;
     objCli.ESTADO  :='';
     objCli.CEP   := '';
     objCli.COMPLEMENTO  := '';
     objCli.CONTATO_MAIL := vObjBaseUpdate.CONTATO_MAIL;
     objCli.WEBSITE   := '';
     objCli.EMAIL := vObjBaseUpdate.EMAIL;
     objCli.COD_UNIDADE := vObjBaseUpdate.COD_UNIDADE;
     objCli.COD_CAMPANHA  := vObjBaseUpdate.COD_UNIDADE * 4;
    // objCli.COD_MIDIA := 0;
    // objCli.SEGMENTO  := 0;
     objCli.FAX := '';
     objCli.DESCFAX := '';
     //objCli.AREAFAX := 0;

     objCli.EMAIL  := vObjBaseUpdate.EMAIL;
     objCli.CONTATO_MAIL  := vObjBaseUpdate.CONTATO_MAIL;

    end;
begin
  jsonObject  := (TInfotecUtils.JsonToObject<TClientesGravar>(AValue.ToJSON));
  with TContainerObjectSet<TClientesGravar>.Create(FConnection) do
    begin
      vObjBaseUpdate := Find(pid);
      if not Assigned(vObjBaseUpdate)then
      begin
       TempObject := FindWhere(' CPF_CNPJ = ' + QuotedStr(jsonObject.CPF_CNPJ));
       if TempObject.Count > 0  then
        raise Exception.Create('CPF/CNPJ ja cadastrado');
       CadastraCliente;
       Insert(objCli);
       Result := FConnection.ExecuteSQL('SELECT MAX(CODIGO) as COD FROM clientes ').GetFieldValue('COD');
    end
      else
      begin
        Modify(vObjBaseUpdate);
        Result := pId;
        jsonObject.COD_CAMPANHA := vObjBaseUpdate.COD_CAMPANHA;
        jsonObject.COD_UNIDADE := vObjBaseUpdate.COD_UNIDADE;
        Update(jsonObject);
      end;
    end;
end;

procedure TAtivo.GravarHistoricoCli;
var
  vSql, vFase, vObs, vFone, ativo_receptivo:String;
  CodCampanha: integer;
  function GetCodigoCampanha: integer;
  begin
    Result := FConnection.ExecuteSQL('SELECT CODIGO as COD FROM campanhas_clientes where cliente = '
    + fObjCli.id.ToString).GetFieldValue('COD');
  end;
  function GetNomeOperador: string;
  begin
   Result :=    FConnection.ExecuteSQL('SELECT NOME FROM operadores where codigo = '
    + fObjCli.DadosLigacao.OPERADOR).GetFieldValue('NOME');
  end;
begin
  vFase := fObjCli.DadosLigacao.Finalizar.FASE_CONTATO.ToString;
  if fObjCli.DadosLigacao.ATIVO_RECEP = '' then
    ativo_receptivo := 'ATIVO'
  else
    ativo_receptivo := fObjCli.DadosLigacao.ATIVO_RECEP;

  if vFase = EmptyStr then
    vFase := 'NULL';

  if fObjCli.DadosLigacao.Finalizar.OBSERVACAO = EmptyStr then
    vObs := 'NULL'
  else
    vObs := QuotedStr(fObjCli.DadosLigacao.Finalizar.OBSERVACAO);

  if fObjCli.DadosLigacao.Finalizar.TELEFONE <> EmptyStr then
    vFone := fObjCli.DadosLigacao.Finalizar.TELEFONE
  else
    vFone := fObjCli.AREA1+fObjCli.FONE1;

  if fObjCli.DadosLigacao.DATA_INICIO = 0 then
    fObjCli.DadosLigacao.DATA_INICIO := Now;
  if fObjCli.DadosLigacao.CODIGO = 0 then
  begin
    CodCampanha := GetCodigoCampanha;
    CodigoLigacao := CodCampanha;
    //PreencheDadosLigacao(fObjCli);
  end
  else
    CodCampanha := fObjCli.DadosLigacao.CODIGO;


  vSql := ' INSERT INTO historico_cli '
    +' (CAMPANHA, ATIVO_RECEP, OPERADOR, DATAHORA_INICIO, DATAHORA_FIM, RESULTADO,TELEFONE, '
    +' OBSERVACAO,CLIENTE,CODIGO_FASE_CONTATO,CC_CODIGO) VALUES '
    +' ('+QuotedStr(fObjCli.DadosLigacao.CARTEIRA) //fObjCli.DadosLigacao.CAMPANHA
    +', ' + QuotedStr(ativo_receptivo) + ', '+QuotedStr(GetNomeOperador)
    +', '+QuotedStr(FormatDateTime('yyyy-mm-dd HH:NN:SS', fObjCli.DadosLigacao.DATA_INICIO))
    +', NOW(), '+QuotedStr(fObjCli.DadosLigacao.Finalizar.Resultado.ToString)
    +','+ QuotedStr(vFone)
    +','+ vObs
    +','+fObjCli.id.ToString
    +','+vFase
    +','+CodCampanha.ToString+') ';

   FConnection.ExecuteDirect(vSql);
end;

function TAtivo.GravarPausa(const AValue: TJSONObject): TJSONObject;
var
  fobjPausa: TPausasRealizadas;
  vTEMPO_MAX_SEG:Double;
  vDataaux:TDateTime;
begin
  fobjPausa := TInfotecUtils.JsonToObject<TPausasRealizadas>(AValue.ToJSON);
  Conectar(fobjPausa.DataBase);
  try
    fobjPausa.TIPO := 'ATIVO';
    fobjPausa.EXCEDEU := 'NAO';
    fobjPausa.DATA_HORA_FIM := now;
    fobjPausa.DATA_HORA := fobjPausa.DataInicioPausa;
    vTEMPO_MAX_SEG := 0;

    WITH FConnection.ExecuteSQL(' SELECT TEMPO_MAX_SEG FROM MOTIVOS_PAUSA WHERE CODIGO = '
      + fobjPausa.COD_PAUSA.ToString) DO
    begin
      if RecordCount > 0 then
      begin
        vTEMPO_MAX_SEG := fieldByName('TEMPO_MAX_SEG').AsInteger;
      end;
    end;

    if vTEMPO_MAX_SEG > 0 then
      vTEMPO_MAX_SEG := vTEMPO_MAX_SEG / 24 / 60;

    vDataaux := fobjPausa.DATA_HORA + vTEMPO_MAX_SEG;

    if vDataaux < fobjPausa.DATA_HORA_FIM then
    begin
      fobjPausa.TEMPO_EXEDIDO := vDataaux - fobjPausa.DATA_HORA_FIM;
    end;

    WITH FConnection.ExecuteSQL(' SELECT MAX(CODIGO) AS CODIGO FROM PAUSAS_REALIZADAS ') DO
    begin
      if RecordCount > 0 then
      begin
        fobjPausa.id := fieldByName('CODIGO').AsInteger;
      end;
    end;
    fobjPausa.id := fobjPausa.id + 1;

    TContainerObjectSet<TPausasRealizadas>.Create(FConnection).Insert(fobjPausa);

    Result := TInfotecUtils.ObjectToJsonObject(fobjPausa) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.HistoricoCliente(const pCLIENTE,
  pBaseDados: String): TJSONArray;
begin
  try
    Result := GetHistoricoCliente(pCLIENTE, pBaseDados);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.HistoricoCliente: ' + e.message);
    end;
  end;
end;

function TAtivo.iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
begin
  if Condicao then
    Result := Verdadeiro
  else
    Result := Falso;
end;


function TAtivo.MontaFone(pCliente: TClientes): String;
var
  USAR_DDD, Prefixo, Operadora, varPrefixo, varFone:String;
  ExistsCidade:Boolean;
  pFone, vADD_REM_ZERO_USADDD_NAO: String;
begin
  pFone:= pCliente.DadosLigacao.FONE;
  Result := pFone;
  TFunctionsDiversos.ShowMessageDesenv('Result: 1' + Result);

  Prefixo :=
  FConnection.ExecuteSQL(' SELECT DDD_LOCAL FROM parametros ')
      .fieldByName('DDD_LOCAL').AsString;

  Operadora :=
    FConnection.ExecuteSQL(' SELECT OPERADORA_LOCAL FROM parametros ')
      .fieldByName('OPERADORA_LOCAL').AsString;

  varPrefixo := Copy(pFone, 1, 2);
  varFone := Copy(pFone, 3, 10);

  ExistsCidade := FConnection.ExecuteSQL(
   ' SELECT a.CODIGO FROM cidades a inner join cidades_ddd b on b.cidade = a.CODIGO where a.NOME = '
   + QuotedStr(pCliente.CIDADE)).RecordCount > 0;
   
  TFunctionsDiversos.ShowMessageDesenv('ExistsCidade : ' + iif(ExistsCidade, 'SIM', 'NAO'));	 

  USAR_DDD := FConnection.ExecuteSQL('SELECT USAR  FROM ddds_diferentes WHERE DDD = '
          + QuotedStr(Prefixo) + ' AND CIDADE = ' + QuotedStr(pCliente.CIDADE)).FieldByName('USAR').AsString;
  if USAR_DDD = '' then
    USAR_DDD := 'NAO';
  TFunctionsDiversos.ShowMessageDesenv('USAR_DDD : ' + USAR_DDD);

  if (varPrefixo = Prefixo) and not (ExistsCidade) then
    begin
      if (pCliente.CIDADE <> EmptyStr) then
      begin
        varFone := iif(USAR_DDD = 'SIM', Operadora, '') +
          iif(USAR_DDD = 'SIM', Prefixo, '') + varFone;
      end
      else
      begin
        VarFone := varFone; //Nova Lei SP
      end;
      Result := VarFone;	  
    end
    else
    begin
      if (pCliente.CIDADE <> EmptyStr) and (varPrefixo = Prefixo) then
      begin
        Result := Operadora + iif(USAR_DDD = 'SIM', varPrefixo, '') + varFone; //Nova Lei SP
      end
      else
      begin
        Result := Operadora + varPrefixo + varFone; //Nova Lei SP
      end;
    end;

    if (Length(Result) in [8, 9]) and (copy(Result, 1, 1) <> '0') then
    begin
      Result := CodFonia + Result;
      //vLogGetFone := vLogGetFone + #13 + ' (Length(Result) in [8, 9]) and (copy(Result, 1, 1) <> ''0'') Result = (' + Result + ')';
    end;

  vADD_REM_ZERO_USADDD_NAO := FConnection.ExecuteSQL(' SELECT ADD_REM_ZERO_USADDD_NAO FROM parametros ')
      .fieldByName('ADD_REM_ZERO_USADDD_NAO').AsString;

  TFunctionsDiversos.ShowMessageDesenv('ADD_REM_ZERO_USADDD_NAO = ' + vADD_REM_ZERO_USADDD_NAO);
  if (USAR_DDD = 'NAO')or(USAR_DDD = 'NÃO') then
  begin
    if vADD_REM_ZERO_USADDD_NAO = 'R' then
    begin
      if Copy(Result,1,1) = '0' then
        Result := trim(Copy(Result,2,15));
    end
    else if vADD_REM_ZERO_USADDD_NAO = 'A' then
    begin
      Result := '0' + Result;
    end;
  end;

	TFunctionsDiversos.ShowMessageDesenv('Result: 1' + Result);
end;

function TAtivo.NovaAgenda(const AValue: TJSONObject): String;
var
  Data, Hora, Prioridade, cliente, DataHora, sql: String;
  fs: TFormatSettings;
  NovaDataAgendamento: TDateTime;

begin
  try
    fs := TFormatSettings.Create;
    fs.DateSeparator := '/';
    fs.ShortDateFormat := 'dd/mm/YYYY';
    fs.TimeSeparator := ':';
    fs.LongTimeFormat := 'hh:mm';
    Prioridade := AValue.GetValue('PRIORIDADE').Value;
    Data :=  Copy(AValue.GetValue('DATA').Value, 1, 10);
    if Assigned(AValue.GetValue('HORA')) then
      Hora :=  (AValue.GetValue('HORA').Value)
    else
      Hora := FormatDateTime('hh:mm', Now);
    NovaDataAgendamento := StrToDateTime(Data+' ' +Hora);
    DataHora := FormatDateTime('yyyy-mm-dd hh:mm',NovaDataAgendamento);
    cliente := AValue.GetValue('CLIENTE').Value;
    Result := 'UPDATE campanhas_clientes cc SET DT_AGENDAMENTO = '
          + QuotedStr(DataHora)
          + ', cc.AGENDA = ' + prioridade
          +' WHERE cc.CLIENTE = ' + (cliente)
          +' and cc.CONCLUIDO = ' + QuotedStr('NAO');

  except
  on e: exception do
        TFunctionsDiversos.ShowMessageDesenv('Erro ao fazer novo agendamento' +
          #13 + e.message);
  end;

end;

function TAtivo.BuscaDadosRecebendoLigacao(pCodCli, caminhobd,
  operador: string): TJsonObject;
var
  xSql, where: String;
  fObjCli: TClientes;
begin

  Result := nil;
  fObjCli :=TClientes.create;
  fOPERADOR := StrToInt(operador);
  Conectar(CaminhoBD);
  try
    where := ' CODIGO = ' + (pCodCli);
    if FContainer.FindWhere(where).Count > 0 then
    begin
      fObjCli := FContainer.FindWhere(where).First;
        xSql := ' Select CODIGO from CAMPANHAS_CLIENTES where CONCLUIDO = ''NAO'' and CLIENTE = ' +
        IntToStr( fObjCli.id );

      with FConnection.ExecuteSQL(xSql) do
       CodigoLigacao := FieldByName('CODIGO').AsInteger;
      if CodigoLigacao > 0 then
        PreencheDadosLigacao(fObjCli);
    end;
    if fObjCli.OPERADOR = 0 then
      fObjCli.OPERADOR := fOPERADOR;

    Result := TInfotecUtils.ObjectToJsonObject(fObjCli) as TJSONObject;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.BuscaLigacoesDiscadasDia: String;
var
  x: String;
begin
  result := '0';

  x:= 'Select count(cc.OPERADOR_LIGACAO) AS LIGACOES'
    +' from campanhas_clientes cc '
    +' where cc.DT_RESULTADO = DATE(now()) AND '
    +'      cc.OPERADOR_LIGACAO = ' + IntToStr(fOPERADOR);

  with FConnection.ExecuteSQL(x) do
  begin
    if RecordCount > 0 then
    begin
      Result := fieldByName('LIGACOES').AsString;
    end;
  end;

end;


function TAtivo.PesquisaClientes(pfiltro, CaminhoBD: string; page : integer  = 1): TJSONArray;
var
  xSql, where: String;
  fObjCliList: TObjectList<TClientes>;
  i, initLimit, finalLimit: integer;
  fObjCli: TClientes;
  function Isnumber(str: string): boolean;
  var
    int: integer;
  begin
    try
      int := StrToInt(str);
      Result := true;
    except on E: Exception do
      Result := false;
    end;
  end;
begin
  Result := nil;
  finalLimit := page * 100;
  if finalLimit - 100 = 0 then
    initLimit :=  1
  else
    initLimit := (finalLimit - 100);

  fObjCliList := TObjectList<TClientes>.Create;;
  Conectar(CaminhoBD);
  try
    xsql := ' SELECT C.CODIGO, C.RAZAO, C.FANTASIA, C.CPF_CNPJ, c.FONE1, c.FONE2, c.FONE3 , ' +
            ' c.cod_erp, c.email, c.contato_mail FROM CLIENTES C' +
            ' where c.ativo =	''SIM''   ';
    if pfiltro <> '' then
    begin
      where := ' and ( '+ IfThen(IsNumber(pfiltro),' c.CODIGO = ' + (pfiltro) + ' or ', '') +
               ' C.RAZAO Like ' + QuotedStr('%'+pfiltro+'%') + ' or ' +
               ' C.CPF_CNPJ Like ' + QuotedStr('%'+pfiltro+'%') + ' or ' +
               ' c.FONE1 Like ' + QuotedStr('%'+pfiltro+'%') + ' or ' +
               ' c.FONE2 Like ' + QuotedStr('%'+pfiltro+'%') + ' or ' +
               ' c.FONE3 Like ' + QuotedStr('%'+pfiltro+'%')+
               ' ) ' ;// + ' or ' +   +
      if initLimit = 1 then   initLimit := 0 ;
      xsql := xsql + where + ' order by c.razao limit ' +
       IntToStr(initLimit) + ','+
       IntToStr(finalLimit);
       with FConnection.ExecuteSQL(xSql) do
      BEGIN
        while NotEof do
        begin
          fObjCli := Tclientes.create;
          fObjCli.id := FieldByName('CODIGO').AsInteger;
          fObjCli.RAZAO := FieldByName('RAZAO').AsString;
          fObjCli.FANTASIA := FieldByName('FANTASIA').AsString;
          fObjCli.CPF_CNPJ := FieldByName('CPF_CNPJ').AsString;
          fObjCli.cod_erp := FieldByName('COD_ERP').asinteger;
          fObjCli.email := FieldByName('email').AsString;
          fObjCli.contato_mail := FieldByName('CONTATO_MAIL').AsString;
          fObjCli.FONE1 := FieldByName('FONE1').AsString;
          fObjCli.FONE2 := FieldByName('FONE2').AsString;
          fObjCli.FONE2 := FieldByName('FONE2').AsString;
          fObjCliList.Add(fObjCli)
        end;
      END;

    end
    else
    begin
      xsql := xsql + ' order by c.razao limit ' + IntToStr(initLimit) + ','+ IntToStr(finalLimit);
      with FConnection.ExecuteSQL(xSql) do
      BEGIN
        while NotEof do
        begin
          fObjCli := Tclientes.create;
          fObjCli.id := FieldByName('CODIGO').AsInteger;
          fObjCli.RAZAO := FieldByName('RAZAO').AsString;
          fObjCli.FANTASIA := FieldByName('FANTASIA').AsString;
          fObjCli.CPF_CNPJ := FieldByName('CPF_CNPJ').AsString;
          fObjCli.cod_erp := FieldByName('COD_ERP').asinteger;
          fObjCli.email := FieldByName('email').AsString;
          fObjCli.contato_mail := FieldByName('CONTATO_MAIL').AsString;
          fObjCli.FONE1 := FieldByName('FONE1').AsString;
          fObjCli.FONE2 := FieldByName('FONE2').AsString;
          fObjCli.FONE2 := FieldByName('FONE2').AsString;
          fObjCliList.Add(fObjCli)
        end;
      END;
    end;

    Result := TInfotecUtils.ObjectToJsonArray<TClientes>(fObjCliList);
  finally
    begin
      if FConnection.IsConnected then
        FConnection.Disconnect;
      fObjCliList.Free;
    end;

  end;

end;

procedure TAtivo.PreencheDadosLigacao(var pCliente: TClientes);
var
  x, vEXIBIR_PEDIDOS_FECHADOS, vEXIBIR_PRODUTIVIDADE: String;
  vContato: TContatos;
  vFonesCampanha: TFonesCampanha;
  vItemCompra: TObjectList<TObject>;
  vResultSetCompras: IDBResultSet;
  vListContatos: TObjectList<TContatos>;
  vTempoTotal: TDateTime;
  vAno, vMes, vDia, vMin, vSeg, vMile, vHora: Word;
  vFidelizacao, vBaseFidelizacoes: Integer;
begin
  x := 'SELECT a.CODIGO, a.FONE1, coalesce(a.DESC_FONE1, c.DESC_FONE1) as DESC_FONE1, '
    + ' coalesce(a.DESC_FONE2, c.DESC_FONE2) as DESC_FONE2, coalesce(a.DESC_FONE3, c.DESC_FONE3) as DESC_FONE3, '
    + ' a.FONE2, a.FONE3, a.CLIENTE, a.OPERADOR, b.DESCRICAO as CAMPANHA, a.DT_AGENDAMENTO, a.OPERADOR_LIGACAO, '
    + ' a.AGENDA, a.ORDEM, d.PRIORIDADE, d.PAUSADA, d.NOME as CARTEIRA, ' +
    ' e.DESCRICAO as GRUPO, f.DESCRICAO as ORIGEM, g.NOME as MIDIA, ' +
    ' h.NOME as SEGMENTO, i.NOME as NOME_OPERADOR, a.FIDELIZA, c.COD_CAMPANHA, a.AGENDA, ' +
    ' c.EMAIL, c.CONTATO_MAIL ' +
    ' FROM campanhas_clientes a  ' +
    ' inner join clientes c on c.CODIGO = a.CLIENTE ' +
    ' left join unidades b on b.CODIGO = a.CAMPANHA ' +
    ' left join campanhas d on d.CODIGO = c.COD_CAMPANHA ' +
    ' left join grupos e on e.CODIGO = c.GRUPO ' +
    ' left join ORIGENS_SGR f on f.CODIGO = c.ORIGEM ' +
    ' left join MIDIAS g on g.CODIGO = c.COD_MIDIA ' +
    ' left join segmentos h on h.CODIGO = c.SEGMENTO ' +
    ' left join operadores i on i.CODIGO = c.OPERADOR' + ' WHERE a.CODIGO = ' +
    IntToStr(CodigoLigacao);

  with FConnection.ExecuteSQL(x) do
  begin
    if RecordCount > 0 then
    begin
      pCliente.DadosLigacao.CAMPANHA := fieldByName('CAMPANHA').AsString;
      pCliente.DadosLigacao.CARTEIRA := fieldByName('CARTEIRA').AsString;
      pCliente.DadosLigacao.EMAIL := fieldByName('EMAIL').AsString;
      pCliente.DadosLigacao.CONTATO_MAIL := fieldByName('CONTATO_MAIL').AsString;

      if Fieldbyname('AGENDA').AsInteger = -200 then
      begin
       pCliente.DadosLigacao.prioridade := 'Alta';
      end
      else if Fieldbyname('AGENDA').AsInteger = -250 then
      begin
        pCliente.DadosLigacao.prioridade := 'Supervisor';
      end
      else
      begin
        pCliente.DadosLigacao.prioridade := 'Normal';
      end;

      pCliente.DadosLigacao.FIDELIZA := fieldByName('FIDELIZA').AsString;
      pCliente.DadosLigacao.COD_CAMPANHA := fieldByName('COD_CAMPANHA')
        .AsInteger;

      pCliente.DadosLigacao.GRUPO := fieldByName('GRUPO').AsString;
      pCliente.DadosLigacao.ORIGEM := fieldByName('ORIGEM').AsString;
      pCliente.DadosLigacao.MIDIA := fieldByName('MIDIA').AsString;

      pCliente.DadosLigacao.SEGMENTO := fieldByName('SEGMENTO').AsString;
      pCliente.DadosLigacao.NOME_OPERADOR :=
        fieldByName('NOME_OPERADOR').AsString;
      pCliente.DadosLigacao.OPERADOR := fieldByName('OPERADOR').AsString;
      pCliente.DadosLigacao.FONE := fieldByName('FONE1').AsString;

      pCliente.DadosLigacao.LIG_EFETUADAS := BuscaLigacoesDiscadasDia;
    end;
  end;

  pCliente.DadosLigacao.CODIGO := CodigoLigacao;

  if pCliente.DadosLigacao.FONE = EmptyStr then
    pCliente.DadosLigacao.FONE := pCliente.AREA1+pCliente.FONE1;

  pCliente.DadosLigacao.Finalizar.TELEFONE := MontaFone(pCliente);

  x := ' select A.*, B.DESCRICAO AS CARGO_DESCRICAO, A.EMAIL from CONTATOS A LEFT JOIN CARGOS B ON B.CODIGO = A.CARGO '
    + ' where A.CLIENTE = ' + pCliente.id.ToString();

  vListContatos := TContainerObjectSet<TContatos>.Create(FConnection)
        .FindWhere(' CLIENTE = '+pCliente.id.ToString());

  for vContato in vListContatos do
  begin
    with FConnection.ExecuteSQL('SELECT DESCRICAO FROM CARGOS WHERE CODIGO = ' + vContato.CARGO.ToString) do
    begin
      if RecordCount > 0 then
        vContato.CARGO_DESCRICAO := FieldByName('DESCRICAO').AsString;
    end;
  end;

  pCliente.Contatos := vListContatos;

  with FConnection.ExecuteSQL
    (' SELECT CODIGO, FONE, TIPO_CONTATO, TIPO_FONE FROM fones_campanha_cli WHERE CLIENTE = '
    + pCliente.id.ToString()) do
  begin
    while NotEof do
    begin
      vFonesCampanha := TFonesCampanha.Create;
      vFonesCampanha.TELEFONE := fieldByName('FONE').AsString;
      vFonesCampanha.TIPO_FONE := fieldByName('TIPO_FONE').AsString;
      pCliente.FonesCampanha.Add(vFonesCampanha);
    end;
  end;

  vResultSetCompras := FConnection.ExecuteSQL
    (' SELECT * FROM (SELECT  CODIGO, DATA, DESCRICAO, VALOR, ' +
    ' FORMA_PGTO FROM compras WHERE CLIENTE = ' + pCliente.id.ToString() +
    ' AND OPERADOR is null  UNION ALL ' +
    ' SELECT  NULL AS CODIGO, NULL AS DATA, IF(IFNULL(CODIGO,0) = 0,'''',''TOTAL DE COMPRAS''), '
    + ' SUM(VALOR) AS VALOR, '''' AS FORMA_PGTO FROM compras WHERE CLIENTE = ' +
    pCliente.id.ToString() +
    ' AND OPERADOR is null) COMPRAS ORDER BY DATA DESC, CODIGO DESC ');

  while vResultSetCompras.NotEof do
  begin
    vItemCompra := TObjectList<TObject>.Create;

    if vResultSetCompras.fieldByName('CODIGO').AsString <> '' then
    begin
      with FConnection.ExecuteSQL('SELECT CODPROD, DESCRICAO, QDT, UN_MEDIDA, '
        + ' VALOR_UN, DESCONTO FROM itens_compra WHERE NOTA = ' +
        vResultSetCompras.fieldByName('CODIGO').AsString +
        ' ORDER BY DESCRICAO ') do
      begin
        while NotEof do
        begin
          vItemCompra.Add(TFactoryComprasItem.CriarComprasItem
            (fieldByName('DESCONTO').AsFloat, fieldByName('QDT').AsInteger,
            fieldByName('DESCRICAO').AsString, fieldByName('UN_MEDIDA')
            .AsString, fieldByName('VALOR_UN').AsFloat,
            fieldByName('CODPROD').AsString));
        end;
      end;
    end;

    pCliente.DadosLigacao.COMPRAS.Add
      (TFactoryCompras.CriarCompras(vResultSetCompras.fieldByName('VALOR')
      .AsFloat, vResultSetCompras.fieldByName('DESCRICAO').AsString,
      vResultSetCompras.fieldByName('CODIGO').AsInteger,
      vResultSetCompras.fieldByName('FORMA_PGTO').AsString,
      vResultSetCompras.fieldByName('DATA').AsDateTime, vItemCompra));

    pCliente.COMPRADisplay := 'Saldo disponível: R$ '+FormatFloat('0.00', pCliente.SALDO_DISPONIVEL)
    +'    Potencial: R$ '+FormatFloat('0.00', pCliente.POTENCIAL)
    +'    Saldo limite: R$ '+FormatFloat('0.00', pCliente.SALDO_LIMITE)
    +'    Dt.últ. compra: ' + iif(pCliente.DATA_ULT_COMPRA > 0, FormatDateTime('dd/mm/yyyy', pCliente.DATA_ULT_COMPRA), '');
  end;

  with FConnection.ExecuteSQL
    (' SELECT E.PROPOSTA, A.CODIGO, A.DT_AGENDAMENTO, A.FONE1, A.FONE2, C.NOME AS OPERADOR, '
    + ' D.NOME AS OPERADOR_LIGACAO, E.NOME AS RESULTADO, A.DT_RESULTADO, B.NOME AS CAMPANHA '
    + ' FROM campanhas_clientes A ' +
    ' INNER JOIN campanhas B ON B.CODIGO = A.CAMPANHA ' +
    ' LEFT JOIN operadores C ON C.CODIGO = A.OPERADOR ' +
    ' LEFT JOIN operadores D ON D.CODIGO = A.OPERADOR_LIGACAO ' +
    ' LEFT JOIN resultados E ON E.CODIGO = A.RESULTADO ' + ' WHERE A.CLIENTE = '
    + pCliente.id.ToString() + ' ORDER BY A.CODIGO DESC ') do
  begin
    while NotEof do
    begin
      pCliente.DadosLigacao.AGENDA.Add
        (TFactoryAgenda.CriarAgenda(fieldByName('CAMPANHA').AsString,
        fieldByName('CODIGO').AsInteger, fieldByName('OPERADOR').AsString,
        fieldByName('DT_AGENDAMENTO').AsDateTime, fieldByName('DT_RESULTADO')
        .AsDateTime, fieldByName('FONE2').AsString, fieldByName('RESULTADO')
        .AsString, fieldByName('FONE1').AsString,
        fieldByName('OPERADOR_LIGACAO').AsString, fieldByName('PROPOSTA').AsString));
    end;
  end;

  with FConnection.ExecuteSQL
    ('SELECT	a.*, b.NOME as FASE_CONTATO, c.NOME as NOME_RESULTADO, cr.COR FROM	historico_cli a '
    + ' left join fase_contato b on b.CODIGO = a.CODIGO_FASE_CONTATO '
    + ' left join resultados c on c.CODIGO = a.RESULTADO '
    + ' left join campanhas_clientes cc on cc.CODIGO = a.CC_CODIGO '
    + ' left join campanha_clientes_cor cr on cr.AGENDA = cc.AGENDA'
    + ' WHERE a.CLIENTE = ' +
    pCliente.id.ToString() + ' ORDER BY CODIGO DESC ') do
  begin
    while NotEof do
    begin
      pCliente.DadosLigacao.Historico.Add
        (TFactoryHistorico.CriarHistorico(fieldByName('ATIVO_RECEP').AsString,
        fieldByName('CAMPANHA').AsString, fieldByName('CODIGO').AsInteger,
        fieldByName('DATAHORA_FIM').AsDateTime, fieldByName('OPERADOR')
        .AsString, fieldByName('DATAHORA_INICIO').AsDateTime,
        fieldByName('NOME_RESULTADO').AsString,
        fieldByName('TELEFONE').AsString,
        TInfotecUtils.RemoverEspasDuplas(fieldByName('OBSERVACAO').AsString),
        fieldByName('COR').AsString
        ));
    end;
  end;

  with FConnection.ExecuteSQL(' SELECT EXIBIR_PRODUTIVIDADE, EXIBIR_PEDIDOS_FECHADOS FROM parametros ') do
  begin
    vEXIBIR_PRODUTIVIDADE := fieldByName('EXIBIR_PRODUTIVIDADE').AsString;
    vEXIBIR_PEDIDOS_FECHADOS := fieldByName('EXIBIR_PEDIDOS_FECHADOS').AsString;
  end;

  if vEXIBIR_PRODUTIVIDADE = 'S' then
  begin
    pCliente.DadosLigacao.PRODUTIVIDADE := GetProdutividade(pCliente.DadosLigacao.OPERADOR);
  end;

  if vEXIBIR_PEDIDOS_FECHADOS = 'S' then
  begin
    pCliente.DadosLigacao.PEDIDOS_FECHADOS := GetPedidosFechados(pCliente.DadosLigacao.OPERADOR);
  end;

  with FConnection.ExecuteSQL(' SELECT ASSINATURA_EMAIL FROM operadores where CODIGO = '
    +fOPERADOR.ToString) do
  begin
    pCliente.DadosLigacao.ASSINATURA := fieldByName('ASSINATURA_EMAIL').AsString;
  end;

  vTempoTotal:= DateOf(now);

  with FConnection.ExecuteSQL
    ('select TIMEDIFF(DATA_HORA_FIM, DATA_HORA_LIG) AS TEMPO from campanhas_clientes '
     +' where CONCLUIDO = ''SIM'' AND DATA_HORA_FIM > 0 '
     +' AND TIMEDIFF(DATA_HORA_FIM, DATA_HORA_LIG) > 0 '
     +' AND DATE(DATA_HORA_LIG)  = DATE(now()) AND OPERADOR_LIGACAO = ' +
     fOPERADOR.ToString) do
  begin
    while NotEof do
    begin
      vTempoTotal := vTempoTotal + fieldByName('TEMPO').AsDateTime;
    end;
  end;

  DecodeDateTime(vTempoTotal, vAno, vMes, vDia, vHora, vMin, vSeg, vMile);
  pCliente.DadosLigacao.TempoTotal.Ano := vAno.ToString;
  pCliente.DadosLigacao.TempoTotal.Mes := vMes.ToString;
  pCliente.DadosLigacao.TempoTotal.Dia := vDia.ToString;
  pCliente.DadosLigacao.TempoTotal.Hora := vHora.ToString;
  pCliente.DadosLigacao.TempoTotal.Minuto := vMin.ToString;
  pCliente.DadosLigacao.TempoTotal.Segundo := vSeg.ToString;

  with FConnection.ExecuteSQL('SELECT COUNT(1) as QTD FROM campanhas_clientes cc WHERE cc.CLIENTE = '
       +QuotedStr(pCliente.id.ToString())
       +' AND cc.DATA_HORA_LIG BETWEEN SUBDATE(NOW(),INTERVAL 7 DAY) AND NOW()') do
  begin
    while NotEof do
    begin
      pCliente.DadosLigacao.LigacoesUlt7Dias := fieldByName('QTD').AsInteger;
    end;
  end;

  vFidelizacao := GetFidelizacoesCliente(pCliente.id, vBaseFidelizacoes);
  pCliente.DadosLigacao.Fidelizacoes := IntToStr(vFidelizacao) + '\' + IntToStr(vBaseFidelizacoes);
end;

function TAtivo.GetFidelizacoesCliente(pCliente: Integer; var rBaseQuantidade : Integer): Integer;
var
  vSql: String;
Begin
  Result := 0;
  rBaseQuantidade := 0;

  vSql := 'SELECT A.QTDE_FIDELIZAR, COALESCE(A.COD_ORIGEM, 0) COD_ORIGEM,'
  + '       COALESCE((SELECT CASE'
  +'       			    WHEN F.OPERADOR_CRIACAO IS NULL THEN'
  +'       			  				R.QTDE_FIDELIZARCOTACAO'
  +'       			  	ELSE F.QTDE_FIDELIZAR'
  +'       			  		END QTDE_FIDELIZAR'
  +'        FROM fidelizacoes F'
  +'        LEFT JOIN campanhas_clientes CC ON CC.CODIGO = F.CC_CODIGO'
  +'                                       AND F.OPERADOR_CRIACAO IS NULL'
  +'        LEFT JOIN resultados R ON R.CODIGO = CC.RESULTADO'
  +'                                       AND F.OPERADOR_CRIACAO IS NULL'
  +'        WHERE F.CLIENTE = A.CLIENTE AND COALESCE(A.COD_ORIGEM, 0) > 0 AND'
  +'       			 (F.COD_ORIGEM IS NULL) OR (F.COD_ORIGEM = 0)'
  +'        ORDER BY F.CODIGO DESC'
  +'        LIMIT 1), 0) QTDE_BASE'
  +' FROM fidelizacoes A '
  +' WHERE A.CLIENTE = ' + IntToStr(pCliente)
  +' ORDER BY CODIGO DESC '
  +' LIMIT 1 ';

  with FConnection.ExecuteSQL(vSql) do
  begin
    while NotEof do
    begin
      if fieldByName('QTDE_FIDELIZAR').AsInteger > 0 then
      begin
        if FieldByName('COD_ORIGEM').AsInteger = 0 then
          rBaseQuantidade := FieldByName('QTDE_FIDELIZAR').AsInteger
        else
          rBaseQuantidade := FieldByName('QTDE_BASE').AsInteger;

        Result := (rBaseQuantidade + 1) - FieldByName('QTDE_FIDELIZAR').AsInteger;
      end;
    end;
  end;
End;

function TAtivo.GetPedidosFechados(pOperador:String):String;
var
 xsql:String;
begin
  xSQl:= 'select count(aa.CODIGO) as qtde, SUM(aa.VALOR) as valor from ( '
        + ' select distinct c.CODIGO, c.VALOR '
        + ' from campanhas_clientes a '
        + ' inner join resultados b on b.CODIGO = a.RESULTADO and b.EPEDIDO= ''SIM'' '
        + ' inner join propostas c on c.LIGACAO = a.CODIGO '
        + ' where a.OPERADOR = ' + pOperador + ' and DATE(a.DT_RESULTADO) = CURRENT_DATE() ) as aa ';

  with FConnection.ExecuteSQL(xSQl) do
  begin
    if Fieldbyname('valor').AsCurrency > 0 then
      Result := FormatFloat('##00', Fieldbyname('qtde').AsInteger) + '/' + FormatFloat('0.,00##', Fieldbyname('valor').AsCurrency)
    else
      Result := '(0)';
  end;
end;

function TAtivo.GetProdutividade(pOperador:String):String;
var
 xsql:String;
begin
  xsql := 'select (SUM(XX.TEMPOEMLINHA)) * 100 / sum(XX.TEMPOLOGADO) as PRODUTIVIDADE '
  +' FROM(SELECT o.CODIGO, o.NOME,(select sum(time_to_sec(l.tempo_logado)) as tempo_logado from login_ativo_receptivo l '
  +' where o.codigo = l.operador '
  +'        and modulo = ''Ativo'' '
  +'        and DATE(entrada) = CURRENT_DATE() '
  +'       ) AS TEMPOLOGADO, '
  +'       (coalesce(( '
  +'           select sum(time_to_sec(cr.LIGACAO_FINALIZADA) - time_to_sec(cr.LIGACAO_RECEBIDA)) '
  +'           from chamadas_receptivo cr '
  +'           where cr.operador = o.codigo '
  +'           and DATE(cr.LIGACAO_RECEBIDA) = CURRENT_DATE() '
  +'         ),0) + '
  +'          coalesce((  '
  +'           select (sum(time_to_sec(data_hora_fim) - time_to_sec(data_hora_lig))) as tempo_falando '
  +'             from campanhas_clientes '
  +'             where '
  +'           OPERADOR_LIGACAO = o.codigo '
  +'           and   '
  +'             DATE(data_hora_lig) = CURRENT_DATE() '
  +'         ),0)) '
  +'     	AS TEMPOEMLINHA  '
  +' FROM operadores o WHERE o.CODIGO = '+pOperador+' )XX ';

  with FConnection.ExecuteSQL(xSQl) do
  begin
    if fieldByName('PRODUTIVIDADE').AsCurrency > 0 then
      Result := formatfloat('0.##', fieldByName('PRODUTIVIDADE').AsCurrency)
    else
      Result := '(0)';
  end;

end;

function TAtivo.GetPropostasCliente(const pCliente:String; pDataInicial,
  pDataFinal:TDateTime; const pUtilizadas,
  pBaseDados: String): TJSONArray;
var
  vListPropostasClientes: TObjectList<TPropostasClientes>;
  x, xDatas:String;
  vObj: TPropostasClientes;
  vResult: IDBResultSet;
begin
  Result := nil;

  if (pDataInicial = 0)or(pDataFinal = 0) then
    xdatas := ' SUBDATE(NOW(),INTERVAL 7 DAY) AND NOW() '
  else
    xDatas := QuotedStr(FormatDateTime('yyyy-mm-dd', (pDataInicial)))
       + ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd', (pDataFinal)));

  if pUtilizadas <> 'true' then
  begin
    xDatas := xDatas + ' AND not exists(select 1 from propostas_compras where PROPOSTA = a.CODIGO limit 1) ';
  end;

  Conectar(pBaseDados);
  try
    vListPropostasClientes := TObjectList<TPropostasClientes>.Create;
    try
      x := ' SELECT b.DT_RESULTADO, c.NOME, a.VALOR, a.CODIGO FROM propostas a inner join campanhas_clientes b on b.CODIGO = a.LIGACAO '
       + ' inner join operadores c on c.CODIGO = b.OPERADOR_LIGACAO where b.CLIENTE = ' + pCliente
       + ' and b.DT_RESULTADO between ' + xDatas
       + ' order by b.DT_RESULTADO ';

      vResult := FConnection.ExecuteSQL(x);
      begin
        while vResult.NotEof do
        begin
          vObj:= TPropostasClientes.Create;
          vObj.CODIGO:= vResult.FieldByName('CODIGO').AsInteger;
          vObj.DATA:= vResult.FieldByName('DT_RESULTADO').AsDateTime;
          vObj.OPERADOR:= vResult.FieldByName('NOME').AsString;
          vObj.VALOR:= vResult.FieldByName('VALOR').AsFloat;
          vObj.UTILIZAR:= 'false';

          if pUtilizadas = 'true' then
          begin
            with FConnection.ExecuteSQL(' select b.VALOR from propostas_compras a inner join compras b on b.CODIGO = a.COMPRA where a.PROPOSTA = '
             + IntToStr(vObj.CODIGO) + ' ORDER BY b.CODIGO DESC limit 1 ') do
            begin
              if RecordCount > 0 then
                vObj.VENDA:= FieldByName('VALOR').AsFloat;
            end;
          end;

          vListPropostasClientes.Add(vObj)
        end;
      end;

      Result := TInfotecUtils.ObjectToJsonArray<TPropostasClientes>(vListPropostasClientes);
    finally
      vListPropostasClientes.Free;
    end;

  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.PropostasCliente(const pCliente:String; pDataInicial, pDataFinal:TDateTime; const pUtilizadas,
  pBaseDados: String): TJSONArray;
begin
  try
    Result := GetPropostasCliente(pCliente, pDataInicial, pDataFinal, pUtilizadas, pBaseDados);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.PropostasCliente: ' + e.message);
    end;
  end;
end;

function TAtivo.ProximaLigacao(const AValue: TJSONObject): TJSONValue;
var
  sDataBase: String;
  fObjCli: TClientes;
begin
  Result := nil;

  AValue.TryGetValue('operador', fOPERADOR);
  AValue.TryGetValue('DATABASE', sDataBase);

  Writeln('ProximaLigacao' + AValue.ToJSON);
  Writeln('fOPERADOR' + fOPERADOR.ToString);
  Conectar(sDataBase);
  try
    GetParamOperador();
    CodigoLigacao := GetIdProximaLigacao();
    Writeln('CodigoLigacao' + CodigoLigacao.ToString);

    if CodigoLigacao = 0 then
      raise exception.Create('Nenhuma ligação localizada!');

    fObjCli := FContainer.Find(CodigoCliente);

    PreencheDadosLigacao(fObjCli);
    Result := TInfotecUtils.ObjectToJsonObject(fObjCli);
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

procedure TAtivo.setCodigoLigacao(const Value: Integer);
begin
  fCodigoLigacao := Value;

  if Value > 0 then
  begin
    CodigoCliente := FConnection.ExecuteSQL
      (' SELECT CLIENTE FROM campanhas_clientes WHERE CODIGO = ' +
      IntToStr(Value)).fieldByName('CLIENTE').AsInteger;
  end;

end;

function TAtivo.SetStatusLigacao(const pStatus: String; pOperador: Integer;
  const pBaseDados: String): Integer;
var
  vstatusOrd:Integer;
  vSql:String;
begin
  if pOperador = 0 then exit;

  //(osOFFLine = 0, osDiscando = 1, osEmConversacao = 2, osEmPausa = 3, osDisponivel = 4);
  vstatusOrd := 0;

  if pos('DISPONIVEL',UpperCase(pStatus)) > 0 then
    vstatusOrd := 4
  else
  if pos('DISCANDO',UpperCase(pStatus)) > 0 then
    vstatusOrd := 1
  else
  if pos('CONVERSA',UpperCase(pStatus)) > 0 then
    vstatusOrd := 2
  else
  if pos('PAUSA',UpperCase(pStatus)) > 0 then
    vstatusOrd := 3;

  fOPERADOR:= pOperador;

  Conectar(pBaseDados);
  try
    if (vstatusOrd = 4) then
      Liberar_operadores_ligacoes
    else
      Travar_operadores_ligacoes;

    try
      FConnection.ExecuteSQL(' insert into operadores_status values ('
        + pOperador.ToString + ', ' + IntToStr(vstatusOrd)
        + ', now()) ON DUPLICATE KEY UPDATE STATUS_ATUAL = ' + IntToStr(vstatusOrd) + ' , TEMPO = now()');
    except
    end;

    if (vstatusOrd = 0) or (vstatusOrd = 3) then
    begin
      try
        FConnection.ExecuteSQL(' delete from pausas_realizadas where OPERADOR = '
        + pOperador.ToString + ' and DATA_HORA_FIM is null ');
      except
      end;
    end;

    Result := vstatusOrd;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.Start(const pBaseDados: String): TJSONObject;
begin
  try
    Result := GetStart(pBaseDados);
  except
    on e: exception do
      raise exception.Create('TAtivo.Start: ' + e.message);
  end;
end;

function TAtivo.updateFinalizarLigacao(const AValue: TJSONObject): TJSONObject;
begin
  try
    Result := FinalizarLigacao(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateFinalizarLigacao: ' + e.message);
    end;
  end;
end;

function TAtivo.updateGravarContato(const AValue: TJSONObject): TJSONObject;
begin
  try
    Result := GravarContato(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateGravarContato: ' + e.message);
    end;
  end;
end;

function TAtivo.updateGravarPausa(const AValue: TJSONObject): TJSONObject;
begin
  try
    Result := GravarPausa(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateGravarPausa: ' + e.message);
    end;
  end;
end;

function TAtivo.updateNovoAgendamento(const AValue: TJSONObject): TJSONObject;
var
  Sql: string;
begin
  Conectar(AValue.GetValue('DATABASE').Value);
  try
    try
      Sql := NovaAgenda(AValue);
      FConnection.ExecuteDirect(Sql);
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes('{"RESULT":"OK"}'), 0) as TJSONObject;
    except
      on e: exception do
      begin
        TFunctionsDiversos.ShowMessageDesenv(e.message);
        raise exception.Create('TAtivo.updateNovoAgendamento: ' + e.message);
      end;
    end;
  finally
    if FConnection.IsConnected then
      FConnection.Disconnect;
  end;
end;

function TAtivo.updateProximaLigacao(const AValue: TJSONObject): TJSONValue;
begin
  try
    Result := ProximaLigacao(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateProximaLigacao: ' + e.message);
    end;
  end;
end;

function TAtivo.updateuploadFile(const AValue: TJSONObject): TJSONObject;
begin
  try
    Result := UploadFile(AValue);
  except
    on e: exception do
    begin
      TFunctionsDiversos.ShowMessageDesenv(e.message);
      raise exception.Create('TAtivo.updateuploadFile: ' + e.message);
    end;
  end;
end;

function TAtivo.UploadFile(const AValue: TJSONObject): TJSONObject;
var
  vObj:TAnexo;
  lInStream, lOutStream: TStringStream;
begin
  vObj:= TAnexo.Create;
  vObj.NOME := 'OK';

  lInStream:= TStringStream.Create(AValue.GetValue('ARQUIVO').Value);
  lInStream.Position := 0;

  lOutStream:= TStringStream.Create;
  TNetEncoding.Base64.Encode(lInStream, lOutStream);
  lOutStream.Position := 0;
  lOutStream.SaveToFile('temp\teste.doc');

  Result := TInfotecUtils.ObjectToJsonObject(vObj) as TJSONObject;
end;

function TAtivo.ValidaFusoHorario: String;
var
  Isql: IDBResultSet;
  vFUSO_HORARIO: String;
begin
  vFUSO_HORARIO := FConnection.ExecuteSQL('SELECT FUSO_HORARIO FROM parametros')
    .GetFieldValue('FUSO_HORARIO');

  if (vFUSO_HORARIO = 'S') then
  begin
    Isql := FConnection.ExecuteSQL
      ('SELECT H.ENTRADA_1, H.SAIDA_1 FROM  HORARIOS H, OPERADORES O  WHERE O.CODIGO = '
      + IntToStr(fOPERADOR) + ' AND O.HORARIO = H.CODIGO ');

    if Isql.RecordCount > 0 then
    begin
      Result := ' AND (coalesce(c_.ESTADO,'''') = '''' OR (SELECT ADDTIME(CURTIME(), TIME_FORMAT(CONCAT(FUSOHORARIO,'':00:00''), ''%H:%i:%s'')) HORA '
        + ' FROM uf WHERE uf.UF = c_.ESTADO) BETWEEN TIME_FORMAT(' +
        QuotedStr(Isql.GetFieldValue('ENTRADA_1')) +
        ', ''%H:%i:%s'') AND TIME_FORMAT(' +
        QuotedStr(Isql.GetFieldValue('SAIDA_1')) + ', ''%H:%i:%s'')) ';
    end;
  end;
end;

procedure TAtivo.VerificaDataAcao;
begin
  fCOD_ACAO := FConnection.ExecuteSQL
    (' SELECT COD_ACAO FROM RESULTADOS WHERE CODIGO = ' +
    fObjCli.DadosLigacao.Finalizar.Resultado.ToString).fieldByName('COD_ACAO')
    .AsInteger;

  case fCOD_ACAO of
    3: // AGENDA AUTOMÁTICA  20 MINUTOS
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncMinute(Now, 20);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
    4: // AGENDA AUTOMÁTICA 1 MES
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncMonth(Now, 1);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
    5: // AGENDA AUTOMÁTICA 6 MESES
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncMonth(Now, 6);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
// 'Criar Rotina da Acao 6 em tela'
    // 6:
    // begin
    // Query.SQL.Clear;
    // Query.SQL.Add('SELECT');
    // Query.SQL.Add('	cli.CODIGO');
    // Query.SQL.Add('FROM');
    // Query.SQL.Add('	clientes cli,');
    // Query.SQL.Add('	campanhas_clientes cc,');
    // Query.SQL.Add('	resultados r');
    // Query.SQL.Add('WHERE');
    // Query.SQL.Add('	cc.CLIENTE = cli.CODIGO');
    // Query.SQL.Add('	AND r.CODIGO = cc.RESULTADO');
    // Query.SQL.Add('	AND r.ECONTATO = "SIM"');
    // Query.SQL.Add('	AND cli.CODIGO = ' +
    // QuotedStr(IntToStr(ClienteCadastro)));
    // Query.SQL.Add('GROUP BY     ');
    // Query.SQL.Add('	cli.CODIGO');
    // Query.Open;
    // if not Query.IsEmpty then
    // begin
    // if Application.MessageBox
    // ('Este cliente já foi contatado antes, ao excluir da lista de chamadas você pode estar perdendo um cliente em potencial.'
    // + #13 + 'Deseja continuar a exclusão da lista?', 'Sistema',
    // MB_ICONQUESTION + MB_DEFBUTTON1 + MB_YESNO) = idno then
    // begin
    // exit;
    // end;
    // end;
    // end;
    9: // AGENDA COMPARTILHADA - AUTOMATICO 15 DIAS
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncDay(Now, 15);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
    11, 14: // AGENDA COMPARTILHADA - AUTOMATICO 1 DIA
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncDay(Now, 1);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
    12: // AGENDA COMPARTILHADA - AUTOMATICO 7 DIA
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncDay(Now, 7);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
    13: // AGENDA AUTOMÁTICA 3 MES
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncMonth(Now, 3);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
    15: // AGENDA COMPARTILHADA - AUTOMATICO 2 MESES
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncMonth(Now, 2);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
    16: // AGENDA COMPARTILHADA - AUTOMATICO 1 ANO
      begin
        fObjCli.DadosLigacao.Finalizar.DATA := IncYear(Now, 1);
        fObjCli.DadosLigacao.Finalizar.HORA :=
          TimeToStr(TimeOf(fObjCli.DadosLigacao.Finalizar.DATA));
      end;
  end;

  { if StrToDate(FormatDateTime('dd/mm/yyyy', now)) = DateEdit1.Date then
    begin
    if (Ultima_ACao <> 1) and (Ultima_ACao <> 6) and (Ultima_ACao <> 10) then
    begin
    if not (Application.MessageBox('Deseja realmente agendar esta ligação para hoje?', 'Sistema', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1) = IDYES) then
    begin
    Exit;
    end;
    end;
    end;
    if Assigned(frmAtivo) then
    begin
    if frmAtivo.LigacoesUlt7Dias >= 7 then
    begin
    if DateEdit1.Date <= (Now + 7) then
    begin
    if not (Application.MessageBox(Pchar('Este Cliente possui muitos agendamentos nos ultimos sete dias' + #13
    + 'Você realmente deseja agendar uma nova ligação para ' + DateEdit1.Text + ':' + MaskEdit1.Text + '?'),
    'Sistema', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1) = IDYES) then
    Exit;
    end;
    end;
    end; }



end;

end.
