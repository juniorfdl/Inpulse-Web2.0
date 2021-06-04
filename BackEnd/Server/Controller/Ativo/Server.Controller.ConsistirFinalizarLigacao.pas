unit Server.Controller.ConsistirFinalizarLigacao;

interface

uses //Winapi.Windows, Winapi.Messages,
  System.SysUtils, Server.Models.Cadastros.Clientes,
  FireDAC.Comp.Client,
  dbebr.factory.interfaces,
  dbebr.factory.firedac,
  ormbr.container.objectset.interfaces,
  ormbr.container.objectset,
//  ormbr.container.objectset,
  Server.Models.Cadastros.Resultados,
//  ormbr.factory.interfaces,
  Server.Functions.Telefone;

type
  TConsistirFinalizarLigacao = class(TInterfacedObject)
  private
    fConnection: IDBConnection;
    fObjCli: TClientes;
    function TemProposta(const CodigoLigacao:Integer):boolean;
    function ExigeFaseContato:Boolean;
    function ExigeObservacao(const CodigoContato:Integer):Boolean;
    function ExigeData:Boolean;
  public
    constructor Create(const pObjCli: TObject; const pConnection: IDBConnection);
    destructor Destroy; override;
    procedure Execute();
  end;

implementation

{ TConsistirFinalizarLigacao }

constructor TConsistirFinalizarLigacao.Create(const pObjCli: TObject; const pConnection: IDBConnection);
begin
  fConnection := pConnection;
  fObjCli:= TClientes(pObjCli);
end;

destructor TConsistirFinalizarLigacao.Destroy;
begin
  inherited;
end;

procedure TConsistirFinalizarLigacao.Execute();
var
  vResultado: TResultados;
  vCOD_ACAO:Integer;
begin

  if ExigeData then
  begin
    if fObjCli.DadosLigacao.Finalizar.DATA < StrToDate('01/01/1900') then
    begin
      raise Exception.Create('Informe a data do agendamento!');
    end;

  end;

  if fObjCli.DadosLigacao.Finalizar.RESULTADO <= 0 then
  begin
    raise Exception.Create('Informe o resultado da chamada!');
  end;

  fConnection := fConnection;
  TContainerObjectSet<TResultados>.Create(fConnection).Find('');

  vResultado := TContainerObjectSet<TResultados>.Create(fConnection).Find (fObjCli.DadosLigacao.Finalizar.RESULTADO);

  if (vResultado.PROPOSTA = 'SIM')and(not TemProposta(fObjCli.DadosLigacao.CODIGO)) then
  begin
    raise Exception.Create('Não é possível finalizar a chamada sem informar o valor da proposta!');
  end;

  if (fObjCli.DadosLigacao.Finalizar.FASE_CONTATO = 0)and(ExigeFaseContato) then
  begin
    raise Exception.Create('Não é possível finalizar a chamada sem informar a fase do contato!');
  end;

  if (fObjCli.DadosLigacao.Finalizar.OBSERVACAO = EmptyStr)and(ExigeObservacao(fObjCli.DadosLigacao.Finalizar.FASE_CONTATO)) then
  begin
    raise Exception.Create('É obrigatório informar a observação para essa fase de contato!');
  end;

  vCOD_ACAO := FConnection.ExecuteSQL
    (' SELECT COD_ACAO FROM RESULTADOS WHERE CODIGO = ' +
    fObjCli.DadosLigacao.Finalizar.Resultado.ToString).fieldByName('COD_ACAO')
    .AsInteger;

  if vCOD_ACAO = 1 then
  if (not TFunctionsTelefone.Valido(fObjCli.DadosLigacao.Finalizar.TELEFONE)) then
  begin
    raise Exception.Create('Telefone inválido, por favor verifique!');
  end;
end;

function TConsistirFinalizarLigacao.ExigeData: Boolean;
Var
 vCOD_ACAO:Integer;
begin
  vCOD_ACAO := fConnection.ExecuteSQL(' SELECT COD_ACAO FROM RESULTADOS WHERE CODIGO = '
    +fObjCli.DadosLigacao.Finalizar.RESULTADO.ToString).FieldByName('COD_ACAO').AsInteger;

  result := vCOD_ACAO in [2,7,8];
end;

function TConsistirFinalizarLigacao.ExigeFaseContato: Boolean;
begin
  Result :=
  fConnection.ExecuteSQL(' select 1 from parametros where EXIGIR_FASE_CONTATO = ''SIM'' ').RecordCount > 0;
end;

function TConsistirFinalizarLigacao.ExigeObservacao(
  const CodigoContato: Integer): Boolean;
begin
  Result :=
  fConnection.ExecuteSQL(' select 1 from fase_contato WHERE EXIGE_OBSERVACAO = ''SIM'' AND CODIGO = '
    + CodigoContato.ToString).RecordCount > 0;
end;

function TConsistirFinalizarLigacao.TemProposta(
  const CodigoLigacao: Integer): boolean;
begin
  Result := fObjCli.DadosLigacao.Finalizar.VALOR_PROPOSTA > 0;
  //Result :=
  //fConnection.ExecuteSQL(' SELECT 1 FROM propostas WHERE LIGACAO = '+ fObjCli.DadosLigacao.CODIGO.ToString).RecordCount > 0;
end;

end.
