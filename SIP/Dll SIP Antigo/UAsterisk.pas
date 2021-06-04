unit UAsterisk;

interface

uses SIPActiveXLib_TLB, Classes, SysUtils, StrUtils, Graphics, Dialogs, ShellAPI,
  Forms, Windows, Comctrls, Variants, Controls, ADODB, Extctrls, iniFiles;

  //TIPOS DE DADOS
type
  TVolume = integer;

type
  TTiposRamalStatus = (rsLivre, rsDiscando, rsRecebendo, rsChamando, rsEmLinha, rsTransferindo, rsIndisponivel, rsDesconectada);

type
  TRamalStatus = set of TTiposRamalStatus;

  //EVENTOS
type
  TEventOnPowerChange = procedure(var NewPower: Integer; Sender: TObject) of object;

type
  TEventOnVolumeChange = procedure(var NewVolume: Integer; Sender: TObject) of object;

type
  TEventOnStatusChange = procedure(Status: TRamalStatus; Sender: TObject) of object;

type
  TEventOnGetCodecList = procedure(CodecName: string; Position: Integer; Selected: Boolean) of object;

type
  TAsterisk = class(Tcomponent)
  private
    FGravarLigacoesInterno: Boolean;
    FArquivoGravacao: string;
    FFoneCliente: string;
    FLocalHostName: string;
    FOnGetCodecList: TEventOnGetCodecList;
    fCodigoLigacao: string;
    fLigacaoRecebida: TDateTime;
    fNroLigacaoRecebida: string;
    procedure SetGravarLigacoesInterno(const Value: Boolean);
    procedure SetArquivoGravacao(const Value: string);
    procedure SetFoneCliente(const Value: string);
    procedure SetLocalHostName(const Value: string);
    function GetNroLigacaoRecebida: string;
  public
    Registrado: Boolean;
    EmEspera: Boolean;
    Liberar: Boolean;
    Codecs: TStrings;
    Gravando: Boolean;
    constructor Create(Aowner: Tcomponent); override;
    function Inicializar(UserID, LoginID, DisplayName, Password: string): Boolean;
    procedure Registrar;
    procedure Discar(Destino: string);
    procedure LogoffRegistro;
    procedure ColocarEspera;
    procedure TirarEspera;
    procedure Terminar;
    procedure Desligar;
    procedure Transferir(Destino: string);
    procedure Atender;
    procedure EnviarDTMF(DTMF: WideString);
    procedure IniciarGravacao;
    procedure PararGravacao;
    procedure ListarCodecs;
    procedure SetActiveCodecList(CodecPosition: Integer);
    procedure UnselectAllCodec;
    function IsInitialized: Boolean;
    destructor Destroy; override;
  private
    vASTERISK_PROXY,
      vASTERISK_SERVER,
      vASTERISK_PORTA,
      vSIP_EMITE_BIP,
      vSIP_VOLUME_AUTOMATICO: string;
    SipClient: TSIPClientCtl;
    FVolAutoFalantes: TVolume;
    FVolMic: TVolume;
    FMicMute, GravarLog: Boolean;
    FAutoFalanteMute: Boolean;
    FAutoFalantePower: Integer;
    FMicPower: Integer;
    TimerUpdate: TTimer;
    FOnAutoFalantePowerChange: TEventOnPowerChange;
    FOnMicPowerChange: TEventOnPowerChange;
    FOnMicVolumeChange: TEventOnVolumeChange;
    FOnAutoFalanteVolumeChange: TEventOnVolumeChange;
    OldMicVol: Integer;
    OldAutoFalanteVol: Integer;
    FStatus: TRamalStatus;
    FStatusString: string;
    FOnStatusChange: TEventOnStatusChange;
    FLocalGravacoes: TFilename;
    FGravarLigacoes: Boolean;

    procedure OnFalhouReg(Sender: TObject);
    procedure OnRegOK(Sender: TObject);
    procedure SetVolAutoFalantes(const Value: TVolume);
    procedure SetVolMic(const Value: TVolume);
    procedure SetAutoFalanteMute(const Value: Boolean);
    procedure SetMicMute(const Value: Boolean);
    procedure SetAutoFalantePower(const Value: Integer);
    procedure SetMicPower(const Value: Integer);
    procedure OnTimerUpdate(Sender: TObject);
    procedure SetStatus(const Value: TRamalStatus);
    procedure OnDTMF(ASender: TObject; const sFromURI: WideString; nLine: Integer; nSignal: Integer);
    procedure SIPOnAlerting(ASender: TObject; const sFromURI: WideString; nLine: Integer);
    procedure SIPOnConnected(ASender: TObject; const sFromURI: WideString; nLine: Integer);
    procedure SIPOnDisconnect(ASender: TObject; const sFromURI: WideString; nLine: Integer);
    procedure SetLocalGravacoes(const Value: TFilename);
    procedure SetGravarLigacoes(const Value: Boolean);
    property GravarLigacoesInterno: Boolean read FGravarLigacoesInterno write SetGravarLigacoesInterno default True;
  published
    property VolMic: TVolume read FVolMic write SetVolMic;
    property VolAutoFalantes: TVolume read FVolAutoFalantes write SetVolAutoFalantes;
    property MicMute: Boolean read FMicMute write SetMicMute;
    property AutoFalanteMute: Boolean read FAutoFalanteMute write SetAutoFalanteMute;
    property MicPower: Integer read FMicPower write SetMicPower;
    property AutoFalantePower: Integer read FAutoFalantePower write SetAutoFalantePower;
    property OnMicPowerChange: TEventOnPowerChange read FOnMicPowerChange write FOnMicPowerChange;
    property OnAutoFalantePowerChange: TEventOnPowerChange read FOnAutoFalantePowerChange write FOnAutoFalantePowerChange;
    property OnAutoFalanteVolumeChange: TEventOnVolumeChange read FOnAutoFalanteVolumeChange write FOnAutoFalanteVolumeChange;
    property OnMicVolumeChange: TEventOnVolumeChange read FOnMicVolumeChange write FOnMicVolumeChange;
    property Status: TRamalStatus read FStatus write SetStatus default [rsLivre];
    property StatusString: string read FStatusString;
    property OnStatusChange: TEventOnStatusChange read FOnStatusChange write FOnStatusChange;
    property LocalGravacoes: TFilename read FLocalGravacoes write SetLocalGravacoes;
    property GravarLigacoes: Boolean read FGravarLigacoes write SetGravarLigacoes default False;
    property ArquivoGravacao: string read FArquivoGravacao write SetArquivoGravacao;
    property FoneCliente: string read FFoneCliente write SetFoneCliente;
    property LocalHostName: string read FLocalHostName write SetLocalHostName;
    property OnGetCodecList: TEventOnGetCodecList read FOnGetCodecList write FOnGetCodecList;
    property CodigoLigacao: string read fCodigoLigacao write fCodigoLigacao;
    property LigacaoRecebida: TDateTime read fLigacaoRecebida write fLigacaoRecebida;
    property NroLigacaoRecebida: string read GetNroLigacaoRecebida write fNroLigacaoRecebida;
  end;

implementation

uses uDataModule, DB, ufunctions, UFuncionalidades_telefonicas;

{ TAsterisk }

procedure TAsterisk.ColocarEspera;
begin
  SipClient.Hold;
  EmEspera := True;
end;

procedure TAsterisk.TirarEspera;
begin
  SipClient.Unhold;
  EmEspera := False;
end;
constructor TAsterisk.Create;
begin
  inherited;
  Registrado := False;
  vASTERISK_PROXY := '';
  vASTERISK_SERVER := '';
  vASTERISK_PORTA := '';
  with TADOQuery.Create(nil) do
  try
    Connection := DM.CONECT;
    SQL.Clear;
    SQL.Text := 'SELECT ASTERISK_PROXY, ASTERISK_SERVER, ASTERISK_PORTA, SIP_EMITE_BIP, SIP_VOLUME_AUTOMATICO FROM parametros LIMIT 1';
    Open;

    vASTERISK_PROXY := Fields[0].AsString;
    vASTERISK_SERVER := Fields[1].AsString;
    vASTERISK_PORTA := Fields[2].AsString;
    vSIP_EMITE_BIP := Fields[3].AsString;
    vSIP_VOLUME_AUTOMATICO := Fields[4].AsString;
    Close;
  finally
    Free;
  end;

  try
    SipClient := TSIPClientCtl.Create(nil);
    SipClient.OnRegistrationSuccess := OnRegOK;
    SipClient.OnRegistrationFailure := OnFalhouReg;
    SipClient.OnAlerting := SIPOnAlerting;
    SipClient.OnConnected := SIPOnConnected;
    SipClient.OnTerminatedLine := SIPOnDisconnect;
    SipClient.OnDTMF := OnDTMF;

    {TimerUpdate := TTimer.Create(nil);
    TimerUpdate.Enabled := True;
    TimerUpdate.Interval := 1;
    TimerUpdate.OnTimer := OnTimerUpdate;}
    Status := [rsLivre];
  except
    on E: Exception do
    begin
      ShowMessageDesenv('Problema ao criar SIP' + #13 + e.ClassName + #13 + e.Message);
      addLog('Problema ao criar SIP' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;

end;

procedure TAsterisk.Discar(Destino: string);
var
  ListaCodec: TStringList;
  I: Integer;
begin
  if not Assigned(SipClient) or not SipClient.IsInitialized then
  begin
    Application.MessageBox('Conexão não inicializada, não foi possível discar.', '', MB_ICONINFORMATION);
    Exit;
  end;

  if not Registrado then
  begin
    Application.MessageBox('Ramal não registrado, não foi possível discar.', 'Sistema', MB_ICONINFORMATION);
    Exit;
  end;

  try //busca codec do operador
    SipClient.DeselectAllVoiceCodecs;

    dm.qrAux.SQL.Clear;
    dm.qrAux.SQL.Add('SELECT CODEC FROM operadores');
    dm.qrAux.SQL.Add('WHERE CODIGO = ' + OPERADOR_CODIGO);
    dm.qrAux.Open;

    if not vazio(dm.qrAux.FieldByName('CODEC').AsString) then
    begin
      ListaCodec := TStringList.Create;
      try
        ExtractStrings([','], [' '], PChar(dm.qrAux.FieldByName('CODEC').AsString), ListaCodec);
        for i := 0 to (ListaCodec.Count - 1) do
          SipClient.SelectVoiceCodec(StrToInt(ListaCodec.Strings[i]));
      finally
        FreeAndNil(ListaCodec);
      end;
    end;
    dm.qrAux.Close;
  except
    on e: Exception do
    begin
      addLog('Erro SipClient.SelectVoiceCodec' + #13 + e.ClassName + #13 + e.Message);
      Status := [rsDesconectada];
    end;
  end;

  try
    addLog('TAsterisk.Discar destino '+ Destino);
    SipClient.Connect(Destino + '@' + SipClient.RegistrationProxy);
    Status := [rsDiscando]; 
  except
    on e: Exception do
    begin
      PararGravacao;
      addLog('Erro ao discar' + #13 + e.ClassName + #13 + e.Message);
      Status := [rsDesconectada];
    end;
  end; 

end;

procedure TAsterisk.Desligar;
begin
  Liberar := True;
  try
    if Assigned(SipClient) then
      if SipClient.IsInitialized then
      begin
        PararGravacao;
        SipClient.Disconnect;
      end;
    Status := [rsLivre];
  except
    on e: Exception do
    begin
      ShowMessageDesenv('Erro ao desligar' + #13 + e.ClassName + #13 + e.Message);
      addLog('Erro ao desligar' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;

end;

function TAsterisk.Inicializar(UserID, LoginID, DisplayName, Password: string): Boolean;
var
  MyFile: TiniFile;
  RegisterExpiration:Integer;
begin
  if Assigned(SipClient) then
    if SipClient.IsInitialized then
    begin
      try
        SipClient.Shutdown;
      except
        on e: Exception do
        begin
          ShowMessageDesenv('Erro ao Shutdown' + #13 + e.ClassName + #13 + e.Message);
          addLog('Erro ao shutdown' + #13 + e.ClassName + #13 + e.Message);
        end;
      end;
      Application.ProcessMessages;
    end;
    
  MyFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Cfg.ini');
  GravarLog := MyFile.ReadString('SIP', 'GRAVAR_LOG', '') = 'SIM';
  
  if MyFile.ReadString('CFG', 'CFGSIP', '') = 'VONO' then
  begin
    SipClient.RegistrationProxy := 'vono.net.br';
    SipClient.OutboundProxy := 'vono.net.br:1571';
    SipClient.UDPPort := 5060
  end
  else
  begin
    SipClient.RegistrationProxy := vASTERISK_PROXY;
    SipClient.OutboundProxy := vASTERISK_SERVER;

    if StrToIntDef(vASTERISK_PORTA,0) > 0 then
      SipClient.UDPPort := StrToInt(vASTERISK_PORTA);

    if MyFile.ReadString('CFG', 'TCPPort', '') <> '' then
    begin
       SipClient.TCPPort := StrToInt(MyFile.ReadString('CFG', 'TCPPort', ''));
    end;

    if MyFile.ReadString('CFG', 'RtpPortStart', '') <> '' then
    begin
       SipClient.RtpPortStart:= StrToInt(MyFile.ReadString('CFG', 'RtpPortStart', ''));
    end;    

  end;
  if UserID <> '' Then
  begin
    SipClient.UserID := UserID;
    SipClient.LoginID := LoginID;
    SipClient.DisplayName := DisplayName;
    SipClient.Password := Password;
//   SipClient.RegisterExpiration := 0;
   // peterlongo
    SipClient.RegisterExpiration := 1800;
    SipClient.PlayRingtone := vSIP_EMITE_BIP = 'S';
  end;

  SipClient.AGC := False;
  SipClient.AEC := False;

  //parametros ID do cliente (desde que com licença fullversion) e Chave de licença do cliente (desde que com licença fullversion)
  SipClient.SetLicenseKey('demo', '123');

  if not SipClient.IsInitialized then
  try
    SipClient.Initialize(LocalHostName);
  except
    on e: Exception do
    begin
      ShowMessageDesenv('Erro ao inicializar' + #13 + e.ClassName + #13 + e.Message);
      addLog('Erro ao inicializar' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;

  if MyFile.ReadString('CFG', 'CFGSIP', '') = 'VONO' then
    SipClient.EnableTURN('vono.net.br:1571', 5038, LoginID, Password)
  else
    SipClient.EnableTURN(vASTERISK_SERVER, 5038, LoginID, Password);

  SipClient.RegisterExpiration := 1800;
  RegisterExpiration := StrToIntDef(MyFile.ReadString('CFG', 'RegisterExpiration', '0'), 0);

  if RegisterExpiration > 0 then
   SipClient.RegisterExpiration := RegisterExpiration;

  SipClient.PlayRingtone := vSIP_EMITE_BIP = 'S';
  FreeAndNil(MyFile);

  Result := SipClient.IsInitialized;

  if Result then
  begin
    ListarCodecs;
    if vSIP_VOLUME_AUTOMATICO = 'S' then
    begin
      SipClient.MicrophoneVolume := 0;
      SipClient.SpeakerVolume := 0;

      VolMic := SipClient.MicrophoneVolume;
      VolAutoFalantes := SipClient.SpeakerVolume;

      FOnAutoFalanteVolumeChange(FVolAutoFalantes, Self);
      FOnMicVolumeChange(FVolMic, Self);
      FOnStatusChange(Status, Self);
    end;
  end;

end;

procedure TAsterisk.Terminar;
begin
  try
    if SipClient.IsInitialized then
      SipClient.Shutdown;
  except
    on e: Exception do
    begin
      ShowMessageDesenv('Erro Shutdown' + #13 + e.ClassName + #13 + e.Message);
      addLog('Erro ao shutdown' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;
end;

procedure TAsterisk.OnFalhouReg(Sender: TObject);
begin
  Application.MessageBox('Falha ao Registrar com o servidor asterisk.', 'Sistema', MB_ICONINFORMATION);
  Registrado := False;
end;

procedure TAsterisk.OnRegOK(Sender: TObject);
begin
  Registrado := not False;

end;

procedure TAsterisk.OnTimerUpdate(Sender: TObject);
begin
  {if vSIP_VOLUME_AUTOMATICO = 'S' then
  try
    MicPower := Round(SipClient.MicrophoneEnergy);
    AutoFalantePower := Round(SipClient.SpeakerEnergy);
    if VolAutoFalantes < SipClient.SpeakerVolume then
      VolAutoFalantes := SipClient.SpeakerVolume;
    if VolMic < SipClient.MicrophoneVolume then
      VolMic := SipClient.MicrophoneVolume;
  except
    ShowMessageDesenv(' TAsterisk.OnTimerUpdate');
  end;}
end;

procedure TAsterisk.Registrar;
begin
  if not Assigned(SipClient) or not SipClient.IsInitialized then
  begin
    Application.MessageBox('Conexão não inicializada, não foi possivel registrar.', 'Sistema', MB_ICONINFORMATION);
    Exit;
  end;
  SipClient.Register;
  Registrado := true;
end;

procedure TAsterisk.LogoffRegistro;
begin
  try
    if SipClient.IsInitialized then
      SipClient.UnRegister;
  except
    on e: Exception do
    begin
      addLog('Erro ao unRegister' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;
  Registrado := False;
end;

procedure TAsterisk.SetAutoFalanteMute(const Value: Boolean);
begin
  FAutoFalanteMute := Value;

  if Value then
    OldAutoFalanteVol := VolAutoFalantes;

  if SipClient.IsInitialized then
    SipClient.SpeakerMuted := Value;

  if not Value then
    VolAutoFalantes := OldAutoFalanteVol;
end;

procedure TAsterisk.SetAutoFalantePower(const Value: Integer);
begin
  FAutoFalantePower := Value;
  FOnAutoFalantePowerChange(FAutoFalantePower, Self);
end;

procedure TAsterisk.SetMicMute(const Value: Boolean);
begin
  FMicMute := Value;

  if Value then
    OldMicVol := VolMic;

  if SipClient.IsInitialized then
    SipClient.MicrophoneMuted := Value;

  if not Value then
    VolMic := OldMicVol;
end;

procedure TAsterisk.SetMicPower(const Value: Integer);
begin
  FMicPower := Value;
  FOnMicPowerChange(FMicPower, Self);
end;

procedure TAsterisk.SetVolAutoFalantes(const Value: TVolume);
begin
  try
    FVolAutoFalantes := Value;

    if Value > 100 then
      FVolAutoFalantes := 100;

    if Assigned(FOnAutoFalanteVolumeChange) then
      FOnAutoFalanteVolumeChange(FVolAutoFalantes, Self);

    if SipClient.IsInitialized then
      SipClient.SpeakerVolume := FVolAutoFalantes;
  except
  end;
end;

procedure TAsterisk.SetVolMic(const Value: TVolume);
begin
  if SipClient.IsInitialized then
  begin
    FVolMic := Value;

    if Value > 100 then
      FVolMic := 100;

    try
      if Assigned(FOnAutoFalanteVolumeChange) then
        FOnMicVolumeChange(FVolMic, Self);
    except
      on e: Exception do
      begin
        addLog('Erro ao SetVolMic' + #13 + e.ClassName + #13 + e.Message);
      end;
    end;

    SipClient.MicrophoneVolume := FVolMic;
  end;
end;


procedure TAsterisk.Transferir(Destino: string);
begin
  try
    if SipClient.IsInitialized then
      SipClient.TransferCall(Destino + '@' + SipClient.RegistrationProxy);
    Status := Status + [rsTransferindo];
  except
    on e: Exception do
    begin
      ShowMessageDesenv('Erro ao Transferir' + #13 + e.ClassName + #13 + e.Message);
      addLog('Erro ao transferir' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;      
end;

destructor TAsterisk.Destroy;
begin
  try
    if SipClient.IsInitialized then
    begin
      SipClient.UnRegister;
    end;
    
  finally
    FreeAndNil(SipClient);
  end;
  FreeAndNil(TimerUpdate);
  inherited;
end;

procedure TAsterisk.Atender;
begin
  try
    if SipClient.IsInitialized then
      SipClient.AcceptCall;
  except
    on e: Exception do
    begin
      ShowMessageDesenv('Erro ao Atender' + #13 + e.ClassName + #13 + e.Message);
      addLog('Erro ao atender' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;
end;

procedure TAsterisk.SIPOnAlerting(ASender: TObject;
  const sFromURI: WideString; nLine: Integer);
begin
  try
    if GravarLog then
      addLog(sFromURI+' - '+IntToStr(nLine), 'logsip' + FormatDateTime('yyyymmdd', now) + '.txt');

    if rsLivre in Status then
    begin
      if pos('@', sFromURI) > 0 then
        FoneCliente := sFromURI;
      Status := [rsRecebendo, rsChamando]; //chamando e recebendo ligação
    end;

    if rsDiscando in Status then
      Status := [rsDiscando, rsChamando]; //Disquei e agora ta chamando
  except
    on E: Exception do
    begin
      addLog('Erro ao uAsterisk.SIPOnAlerting' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;


end;

procedure TAsterisk.SetStatus(const Value: TRamalStatus);
begin
  if (FStatus = [rsDiscando, rsChamando]) and (Value = [rsLivre]) then
  begin
    if not Liberar then
    begin
      FStatusString := 'Ocupado.';
      FStatus := Value;
    end
    else
    begin
      FStatusString := 'Ramal livre.';
    end;
  end
  else
  begin
    FStatus := Value;

    if Status = [rsRecebendo, rsChamando] then
      FStatusString := 'Recebendo ligação';

    if Status = [rsDiscando, rsChamando] then
      FStatusString := 'Chamando...';

    if Status = [rsEmLinha] then
      FStatusString := 'Em conversação...';

    if Status = [rsLivre] then
      FStatusString := 'Ramal livre.';

    if Status = [rsDiscando] then
      FStatusString := 'Discando...';

    if Status = [rsTransferindo] then
      FStatusString := 'Transferindo...';

    if Status = [rsIndisponivel] then
      FStatusString := 'Indisponível.';
  end;

//   SetVolAutoFalantes(100);
  try
    if (FStatus = [rsDiscando]) or (FStatus = [rsLivre]) or (Status = [rsDiscando, rsChamando]) or (Status = [rsChamando]) then
//      SetVolAutoFalantes(0) //30
    begin
      if vSIP_VOLUME_AUTOMATICO = 'S' then
      begin
        SipClient.MicrophoneVolume := 0;
        SipClient.SpeakerVolume := 0;

        VolMic := SipClient.MicrophoneVolume;
        VolAutoFalantes := SipClient.SpeakerVolume;

        if SipClient.IsInitialized then
        begin
          FOnAutoFalanteVolumeChange(FVolAutoFalantes, Self);
          FOnMicVolumeChange(FVolMic, Self);
          FOnStatusChange(Status, Self);
        end;
      end;
    end
    else
      if Status = [rsEmLinha] then
      begin
        if vSIP_VOLUME_AUTOMATICO = 'S' then
        begin
          SipClient.MicrophoneVolume := 80;
          SipClient.SpeakerVolume := 100;

          VolMic := SipClient.MicrophoneVolume;
          VolAutoFalantes := SipClient.SpeakerVolume;

          if SipClient.IsInitialized then
          begin
            FOnAutoFalanteVolumeChange(FVolAutoFalantes, Self);
            FOnMicVolumeChange(FVolMic, Self);
            FOnStatusChange(Status, Self);
          end;
        end;
      end;
  except
    on e: Exception do
    begin
      addLog('Erro ao SetStatus' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;

  if Assigned(FOnStatusChange) then
    FOnStatusChange(Status, Self);

  if (rsEmLinha in Status) then
  try
    if not Gravando then
      IniciarGravacao;
  except
  end;

  if (Status = [rsLivre]) and (Gravando) then
  try
    PararGravacao;
  except
  end;

  Liberar := False;
end;

procedure TAsterisk.SIPOnConnected(ASender: TObject;
  const sFromURI: WideString; nLine: Integer);
begin
  Status := [rsEmLinha];
end;

procedure TAsterisk.SIPOnDisconnect(ASender: TObject;
  const sFromURI: WideString; nLine: Integer);
begin
  Status := [rsLivre];
end;

procedure TAsterisk.EnviarDTMF(DTMF: WideString);
begin
  try
    if SipClient.IsInitialized then
      SipClient.SendDTMF(DTMF);
  except
    on E: Exception do
    begin
      ShowMessageDesenv(E.Message);
      addLog('Erro ao enviar DTMF' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;
end;

procedure TAsterisk.SetLocalGravacoes(const Value: TFilename);
begin
  FLocalGravacoes := Value;
  GravarLigacoesInterno := True;

  if not DirectoryExists(Value) then
  begin
    if not ForceDirectories(Value) then
    begin
      Application.MessageBox(Pchar('Não foi possivel encontrar ou criar o diretório de gravações em: ' + #13 + Value + #13 + 'As ligações desta sessão não serão gravadas'), 'Sistema', MB_ICONINFORMATION);
      GravarLigacoesInterno := False;
    end;
  end;
end;

procedure TAsterisk.SetGravarLigacoes(const Value: Boolean);
begin
  FGravarLigacoes := Value;
end;

procedure TAsterisk.IniciarGravacao;
begin
  Application.ProcessMessages;
  if (rsEmLinha in Status) or (rsDiscando in Status) or (rsChamando in Status) then
  try
    if GravarLigacoesInterno and GravarLigacoes then
    try
      ArquivoGravacao := Trim(CodigoLigacao) + '_' + FormatDateTime('dd-mm-yyyy_HH.NN.SS', LigacaoRecebida) + '.wav';

      if SipClient.IsInitialized then
        SipClient.StartRecording(LocalGravacoes + ArquivoGravacao);
      Gravando := True;
    except
      on E: Exception do
      begin
        addLog('Erro ao Iniciar gravacao' + #13 + e.ClassName + #13 + e.Message);
        ShowMessageDesenv('Erro ao IniciarGravacao' + #13 + e.ClassName + #13 + e.Message);
      end;
    end;
  finally

  end;


end;

procedure TAsterisk.PararGravacao;
begin

  if Gravando then
    if SipClient.IsInitialized then
    try
      Gravando := False;
      SipClient.StopRecording; // aqui da erro
    except
    end;
end;

procedure TAsterisk.SetGravarLigacoesInterno(const Value: Boolean);
begin
  FGravarLigacoesInterno := Value;
end;

procedure TAsterisk.SetArquivoGravacao(const Value: string);
begin
  if Trim(Value) = '' then
    FArquivoGravacao := FormatDateTime('yyyymmddHHNNSS', now) + '.wav'
  else
    FArquivoGravacao := Value;
end;

procedure TAsterisk.SetFoneCliente(const Value: string);
begin
  FFoneCliente := copy(value, 2, pos('"<', Value) - 2);
end;

procedure TAsterisk.SetLocalHostName(const Value: string);
begin
  FLocalHostName := Value;
end;

procedure TAsterisk.ListarCodecs;
var
  Count, I: Integer;
begin
  if SipClient.IsInitialized then
  try
    if not Assigned(Codecs) then
      Codecs := TStringList.Create;
    Count := SipClient.VoiceCodecCount;

    SipClient.SelectAllVoiceCodecs;

    Codecs.Clear;
    for I := 0 to Count - 1 do
    begin
      Codecs.Add(SipClient.GetVoiceCodecName(I));

      if Assigned(FOnGetCodecList) then
        FOnGetCodecList(SipClient.GetVoiceCodecName(I), I, True);
    end;
  finally
    FreeAndNil(Codecs);
  end;
end;

procedure TAsterisk.SetActiveCodecList(CodecPosition: Integer);
begin
  try
    if SipClient.IsInitialized then
      SipClient.SelectVoiceCodec(CodecPosition);
  except
    on e: Exception do
    begin
      ShowMessageDesenv('Erro SelectVoiceCodec' + #13 + e.ClassName + #13 + e.Message);
      addLog('Erro ao SelectVoiceCodec' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;
end;

procedure TAsterisk.UnselectAllCodec;
begin
  try
    if SipClient.IsInitialized then
      SipClient.DeselectAllVoiceCodecs;
  except
    on e: Exception do
    begin
      ShowMessageDesenv('Erro DeselectAllVoiceCodecs' + #13 + e.ClassName + #13 + e.Message);
      addLog('Erro ao DeselectAllVoiceCodecs' + #13 + e.ClassName + #13 + e.Message);
    end;
  end;
end;

function TAsterisk.IsInitialized: Boolean;
begin
  Result := SipClient.IsInitialized;
end;

function TAsterisk.GetNroLigacaoRecebida: string;
begin

  try
    addLogLigacao('Recebida: ' + SipClient.RemoteURI[0]);
    Result := SipClient.RemoteURI[0];
  //  Result := '"2007"<sip:2007@192.168.25.170>';
    Result := copy(Result, pos('<sip:', Result) + 5, 100);
    Result := copy(Result, 1, pos('@', Result) - 1);
    Result := trim(Result);
  except
    on e: Exception do
      addLogLigacao('Recebida: ' + e.message);
  end;
//  '"2007"<sip:2007@192.168.25.170>'
end;

procedure TAsterisk.OnDTMF(ASender: TObject; const sFromURI: WideString;
  nLine: Integer; nSignal: Integer);
begin
  if GravarLog then
    addLog(sFromURI+' - '+IntToStr(nLine)+' - '+IntToStr(nSignal), 'logsipDTMF' + FormatDateTime('yyyymmdd', now) + '.txt');

end;

end.

