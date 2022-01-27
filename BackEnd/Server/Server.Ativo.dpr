program Server.Ativo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  {$IFDEF MSWINDOWS}
  {$IFDEF DEBUG}
  {$IFDEF WIN32}
  {$ENDIF }
  {$ENDIF }
  Winapi.Windows,
  {$ENDIF }
  {$IFDEF LINUX}
  Posix.Signal,
  {$ENDIF }
  System.SysUtils,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  IdSSLOpenSSL,
  System.IOUtils,
  Web.HTTPApp,
  Web.WebBroker,
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
  Server.Models.Cadastros.Unidades in 'Models\Cadastros\Server.Models.Cadastros.Unidades.pas',
  Infotec.Utils in 'Utils\Infotec.Utils.pas';

type
  TGetSSLPassword = class
    procedure OnGetSSLPassword(var APassword: {$IF CompilerVersion < 27}AnsiString{$ELSE}string{$ENDIF});
  end;

  TSSLHelper = class
     procedure QuerySSLPort(APort: Word; var VUseSSL: boolean);
  end;

procedure TGetSSLPassword.OnGetSSLPassword(var APassword: {$IF CompilerVersion < 27}AnsiString{$ELSE}string{$ENDIF});
begin
  APassword := 'infotec';
end;

procedure TSSLHelper.QuerySSLPort(APort: Word; var VUseSSL: boolean);
begin
  VUseSSL := TUtils.bHTTPS;
end;

var
  oServer: TIdHTTPWebBrokerBridge;
  sCaminhoBase: string;
  nAPP_PORT: Integer;
  sHOST: string;
  CloseApp: Boolean;
  bHTTPS: Boolean;
  shttp: string;

  LGetSSLPassword: TGetSSLPassword;
  LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
  LSSLHelper: TSSLHelper;

  {$IFDEF MSWINDOWS}
  function HandleSignals(dwCtrlType: DWORD): BOOL; stdcall;
  begin
    Result := False;
    if Winapi.Windows.CTRL_C_EVENT = dwCtrlType then
    begin
      CloseApp := True;
      Result := True;
    end;
  end;
  {$ENDIF}
  {$IFDEF LINUX}
  procedure HandleSignals(SigNum: Integer); cdecl;
  begin
    case SigNum of
      SIGINT, SIGKILL: CloseApp := True;
    end;
  end;
  {$ENDIF}


begin
  try
    Writeln('Iniciando Servidor . . .');
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;

    sCaminhoBase := TUtils.GetCaminhoBase;
    nAPP_PORT := TUtils.GetPort;
    sHOST := TUtils.GetHost;
    bHTTPS := TUtils.GetHttps;
    shttp := 'HTTP';

    LGetSSLPassword := nil;
    LSSLHelper := nil;
    oServer := TIdHTTPWebBrokerBridge.Create(nil);
    oServer.Bindings.Clear;

    if bHTTPS then
    begin
      LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(oServer);
      LIOHandleSSL.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
      LIOHandleSSL.SSLOptions.Method := sslvTLSv1_2;
      LIOHandleSSL.SSLOptions.Mode := sslmServer;
      LIOHandleSSL.SSLOptions.CertFile := 'certificate.pem';
      LIOHandleSSL.SSLOptions.KeyFile := 'key.pem';
      LIOHandleSSL.OnGetPassword := LGetSSLPassword.OnGetSSLPassword;
      oServer.IOHandler := LIOHandleSSL;      
      Writeln('HTTPS Ativo');
      shttp := 'HTTPS';
    end;

    oServer.DefaultPort := nAPP_PORT;
    oServer.Active := True;

    Writeln('Base: ' + sCaminhoBase);
    Writeln('APP: ' + ExtractFileName(ParamStr(0)));

    Writeln('Running on: '+sHttp+'://' + sHOST + ':' + nAPP_PORT.ToString);
    Readln(sCaminhoBase);

    CloseApp := False;

    while (not CloseApp) do
      Sleep(1000);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      Readln(sCaminhoBase);
    end;
  end;
end.
