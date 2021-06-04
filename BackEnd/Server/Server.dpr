program Server;
// {$APPTYPE GUI}

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Server.Base.Crud in 'Base\Server.Base.Crud.pas' {ServerBaseCrud: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  Server.Models.Cadastros.Operadores in 'Models\Cadastros\Server.Models.Cadastros.Operadores.pas',
  Server.Base.Connection in 'Base\Server.Base.Connection.pas',
  Server.Interfaces.Tabela in 'Interfaces\Server.Interfaces.Tabela.pas',
  Server.Models.Base.TabelaBase in 'Models\Base\Server.Models.Base.TabelaBase.pas',
  Server.Models.Base.Consulta in 'Models\Base\Server.Models.Base.Consulta.pas',
  Server.Controller.Cadastro.Contatos in 'Controller\Cadastro\Server.Controller.Cadastro.Contatos.pas' {Contatos: TDSServerModule},
  Server.Models.Cadastros.Clientes in 'Models\Cadastros\Server.Models.Cadastros.Clientes.pas',
  Server.Models.Ativo.DadosLigacao in 'Models\Ativo\Server.Models.Ativo.DadosLigacao.pas',
  Server.Models.Cadastros.FonesCampanha in 'Models\Cadastros\Server.Models.Cadastros.FonesCampanha.pas',
  Server.Models.Ativo.DadosLigacao.Factory in 'Models\Ativo\Factory\Server.Models.Ativo.DadosLigacao.Factory.pas',
  Server.Models.Cadastros.Resultados in 'Models\Cadastros\Server.Models.Cadastros.Resultados.pas',
  Server.Models.Ativo.Start in 'Models\Ativo\Server.Models.Ativo.Start.pas',
  Server.Models.Cadastros.FaseContato in 'Models\Cadastros\Server.Models.Cadastros.FaseContato.pas',
  Server.Models.Cadastros.ConfigMail in 'Models\Cadastros\Server.Models.Cadastros.ConfigMail.pas',
  Server.Controller.ConsistirFinalizarLigacao in 'Controller\Ativo\Server.Controller.ConsistirFinalizarLigacao.pas',
  Server.Controller.ConsistirFinalizarLigacaoFactory in 'Controller\Ativo\Server.Controller.ConsistirFinalizarLigacaoFactory.pas',
  Server.Functions.Telefone in 'Functions\Server.Functions.Telefone.pas',
  Server.Functions.Diversas in 'Functions\Server.Functions.Diversas.pas',
  Server.Models.Movimentos.CampanhasClientes in 'Models\Movimentos\Server.Models.Movimentos.CampanhasClientes.pas',
  Inpulse.SIP.Models.Resgistrar in '..\..\SIP\Models\Inpulse.SIP.Models.Resgistrar.pas',
  Server.Models.Cadastros.Cargos in 'Models\Cadastros\Server.Models.Cadastros.Cargos.pas',
  Server.Controller.Ativo in 'Controller\Ativo\Server.Controller.Ativo.pas' {Ativo: TDSServerModule},
  Server.Controller.Sistema.Login in 'Controller\Sistema\Server.Controller.Sistema.Login.pas' {Login: TDSServerModule},
  Server.Models.Cadastros.MotivosPausa in 'Models\Cadastros\Server.Models.Cadastros.MotivosPausa.pas',
  Server.Models.Cadastros.PausasRealizadas in 'Models\Cadastros\Server.Models.Cadastros.PausasRealizadas.pas',
  Server.Models.Cadastros.FoneAreas in 'Models\Cadastros\Server.Models.Cadastros.FoneAreas.pas',
  Server.Models.Cadastros.ClientesGravar in 'Models\Cadastros\Server.Models.Cadastros.ClientesGravar.pas',
  Server.Models.Ativo.Agenda in 'Models\Ativo\Server.Models.Ativo.Agenda.pas',
  udmEmail in 'Controller\Ativo\udmEmail.pas' {dmEmail: TDataModule},
  Server.Models.Cadastros.Grupos in 'Models\Cadastros\Server.Models.Cadastros.Grupos.pas',
  Server.Models.Cadastros.Midias in 'Models\Cadastros\Server.Models.Cadastros.Midias.pas',
  Server.Models.Cadastros.Segmentos in 'Models\Cadastros\Server.Models.Cadastros.Segmentos.pas',
  Server.Models.Cadastros.Contatos in 'Models\Cadastros\Server.Models.Cadastros.Contatos.pas',
  Server.Controller.Cadastro.Cidades in 'Controller\Cadastro\Server.Controller.Cadastro.Cidades.pas' {Cidades: TDSServerModule},
  Server.Models.Cadastros.Cidades in 'Models\Cadastros\Server.Models.Cadastros.Cidades.pas',
  Infotec.Ativo.Utils in 'Infotec.Ativo.Utils.pas',
  Server.Models.Cadastros.Campanhas in 'Models\Cadastros\Server.Models.Cadastros.Campanhas.pas',
  Server.Models.Cadastros.Unidades in 'Models\Cadastros\Server.Models.Cadastros.Unidades.pas';

{$R *.res}

var
  oServer: TIdHTTPWebBrokerBridge;
  sCaminhoBase: string;
  nAPP_PORT: Integer;
  sHOST: string;
begin
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;

    sCaminhoBase := TUtils.GetCaminhoBase;
    nAPP_PORT := TUtils.GetPort;
    sHOST := TUtils.GetHost;

    oServer := TIdHTTPWebBrokerBridge.Create(nil);
    oServer.Bindings.Clear;
    oServer.DefaultPort := nAPP_PORT;
    oServer.Active := True;

    Writeln('Base: ' + sCaminhoBase);
    Writeln('APP: ' + ExtractFileName(ParamStr(0)));
    Writeln('Running on: http://' + sHOST + ':' + nAPP_PORT.ToString);
    Readln(sCaminhoBase);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  // Application.Initialize;
  // Application.CreateForm(TFormServer, FormServer);
  // Application.CreateForm(TdmEmail, dmEmail);
  // Application.CreateForm(TLogin, Login);
  // Application.Run;
end.
