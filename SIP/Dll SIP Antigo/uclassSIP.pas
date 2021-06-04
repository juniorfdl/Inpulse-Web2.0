unit uclassSIP;

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
  TclassSIP = class
  private
    FLocalGravacoes: string;
    GravarLigacoesInterno: Boolean;
    procedure SetLocalGravacoes(const Value: string);
  private
    fOPERADOR_CODIGO: Integer;
    fCodigoLigacao: Integer;
    fOPERADOR_NAME: string;
    SipClient: TSIPClientCtl;
    fUserID: string;
    fPassword: string;
    fDisplayName: string;
    fLoginID: string;
    fASTERISK_PROXY: string;
    fASTERISK_SERVER: string;
    fASTERISK_PORTA: string;
    fRtpPortStart: string;
    fTCPPort: string;
    fSIP_EMITE_BIP: string;
    fLocalHostName: string;
    fSIP_VOLUME_AUTOMATICO: string;
    FVolMic: TVolume;
    FVolAutoFalantes: TVolume;
    FOnMicVolumeChange: TEventOnVolumeChange;
    FOnAutoFalanteVolumeChange: TEventOnVolumeChange;
    FOnStatusChange: TEventOnStatusChange;
    FStatus: TRamalStatus;
    Codecs: TStrings;
    FOnGetCodecList: TEventOnGetCodecList;
    Liberar, Gravando, Registrado: Boolean;
    FStatusString, FoneCliente: string;
    FMicMute: Boolean;
    FAutoFalanteMute: Boolean;
    FAutoFalantePower: Integer;
    FMicPower: Integer;
    FOnMicPowerChange: TEventOnPowerChange;
    FOnAutoFalantePowerChange: TEventOnPowerChange;
    procedure ListarCodecs;
    procedure SetVolMic(const Value: TVolume);
    procedure SetVolAutoFalantes(const Value: TVolume);

    procedure SetStatus(const Value: TRamalStatus);
    procedure IniciarGravacao;
    procedure PararGravacao;
    procedure OnFalhouReg(Sender: TObject);
    procedure OnRegOK(Sender: TObject);
    procedure SIPOnAlerting(ASender: TObject; const sFromURI: WideString; nLine: Integer);
    procedure SIPOnConnected(ASender: TObject; const sFromURI: WideString; nLine: Integer);
    procedure SIPOnDisconnect(ASender: TObject; const sFromURI: WideString; nLine: Integer);
    procedure SetAutoFalanteMute(const Value: Boolean);
    procedure SetAutoFalantePower(const Value: Integer);
    procedure SetMicMute(const Value: Boolean);
    procedure SetMicPower(const Value: Integer);
    procedure StatusChange(pStatus: TRamalStatus; Sender: TObject);

    procedure AFPowerChange(var NewPower: Integer; Sender: TObject);
    procedure MicPowerChange(var NewPower: Integer; Sender: TObject);
    procedure MicVolChange(var NewVolume: Integer; Sender: TObject);
    procedure AFVolChange(var NewVolume: Integer; Sender: TObject);
  public
    property LocalGravacoes: string read FLocalGravacoes write SetLocalGravacoes;
    property CodigoLigacao: Integer read fCodigoLigacao write fCodigoLigacao;
    property OPERADOR_NAME: string read fOPERADOR_NAME write fOPERADOR_NAME;
    property OPERADOR_CODIGO: Integer read fOPERADOR_CODIGO write fOPERADOR_CODIGO;

    property UserID: string read fUserID write fUserID;
    property LoginID: string read fLoginID write fLoginID;
    property DisplayName: string read fDisplayName write fDisplayName;
    property Password: string read fPassword write fPassword;
    property ASTERISK_PROXY: string read fASTERISK_PROXY write fASTERISK_PROXY;
    property ASTERISK_SERVER: string read fASTERISK_SERVER write fASTERISK_SERVER;
    property ASTERISK_PORTA: string read fASTERISK_PORTA write fASTERISK_PORTA;
    property TCPPort: string read fTCPPort write fTCPPort;
    property RtpPortStart: string read fRtpPortStart write fRtpPortStart;
    property SIP_EMITE_BIP: string read fSIP_EMITE_BIP write fSIP_EMITE_BIP;
    property LocalHostName: string read fLocalHostName write fLocalHostName;
    property SIP_VOLUME_AUTOMATICO: string read fSIP_VOLUME_AUTOMATICO write fSIP_VOLUME_AUTOMATICO;

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
    property OnStatusChange: TEventOnStatusChange read FOnStatusChange write FOnStatusChange;

    property StatusString: string read FStatusString;
    function ConfSIP: PAnsiChar;
    function Desligar: PAnsiChar;
    function Discar(Fone, CIDADE, DESC_FONE: string): PAnsiChar;
    procedure LogoffRegistro;
    Function GetState: PAnsiChar;
    function EnviarDTMF(DTMF: String):PAnsiChar;
    function Transferir(Destino: String):PAnsiChar;

    constructor create();
    destructor destroy();
  end;

implementation

uses ufuncoes;

{ TclassSIP }

function TclassSIP.ConfSIP: PAnsiChar;
begin
  Result := '';
  try
    try
      if Assigned(SipClient) then
        if SipClient.IsInitialized then
          SipClient.Shutdown;
    except
      on e: Exception do
      begin
        //raise Exception.Create(e.message);
        doSaveLog('Erro ao shutdown' + #13 + e.Message);
        FreeAndNil(SipClient);
      end;
    end;

    try
      if not Assigned(SipClient) then
        SipClient := TSIPClientCtl.Create(nil);
    except
      on e: Exception do
      begin
        raise Exception.Create(e.message);
        //doSaveLog('Erro ao shutdown' + #13 + e.Message);
        //FreeAndNil(SipClient);
      end;
    end;

    SipClient.OnRegistrationSuccess := OnRegOK;
    SipClient.OnRegistrationFailure := OnFalhouReg;
    SipClient.OnAlerting := SIPOnAlerting;
    SipClient.OnConnected := SIPOnConnected;
    SipClient.OnTerminatedLine := SIPOnDisconnect;
    //SipClient.OnDTMF := OnDTMF;

    OnMicPowerChange := MicPowerChange;
    OnAutoFalantePowerChange := AFPowerChange;
    OnAutoFalanteVolumeChange := AFVolChange;
    OnMicVolumeChange := MicVolChange;
    OnStatusChange := StatusChange;

    {TimerUpdate := TTimer.Create(nil);
    TimerUpdate.Enabled := True;
    TimerUpdate.Interval := 1;
    TimerUpdate.OnTimer := OnTimerUpdate;}
    Status := [rsLivre];

    SipClient.RegistrationProxy := ASTERISK_PROXY;
    SipClient.OutboundProxy := ASTERISK_SERVER;

    if StrToIntDef(ASTERISK_PORTA, 0) > 0 then
      SipClient.UDPPort := StrToInt(ASTERISK_PORTA);

    if TCPPort <> '' then
    begin
      SipClient.TCPPort := StrToInt(TCPPort);
    end;

    if RtpPortStart <> '' then
    begin
      SipClient.RtpPortStart := StrToInt(RtpPortStart);
    end;
    SipClient.UserID := UserID;
    SipClient.LoginID := LoginID;
    SipClient.DisplayName := DisplayName;
    SipClient.Password := Password;
    SipClient.RegisterExpiration := 1800;
    SipClient.PlayRingtone := SIP_EMITE_BIP = 'S';
    SipClient.AGC := False;
    SipClient.AEC := False;
    SipClient.SetLicenseKey('demo', '123');

    if not SipClient.IsInitialized then
    begin
      if LocalHostName = EmptyStr then
        LocalHostName := GetIP;

      SipClient.Initialize(LocalHostName);
    end;

    SipClient.EnableTURN(ASTERISK_SERVER, 5038, LoginID, Password);

    SipClient.RegisterExpiration := 1800;
    SipClient.PlayRingtone := SIP_EMITE_BIP = 'S';

    if SipClient.IsInitialized then
    begin
      ListarCodecs;
      if SIP_VOLUME_AUTOMATICO = 'S' then
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

  except
    on E: Exception do
    begin
      //doSaveLog('Problema ao criar SIP' + #13 + e.Message);
      Result := Pchar(e.Message);
      //raise Exception.Create(e.message);
    end;
  end;
end;

procedure TclassSIP.ListarCodecs;
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

constructor TclassSIP.create;
begin
  Registrado := False;
//  ConfSIP;
end;

function TclassSIP.Discar(Fone, CIDADE, DESC_FONE: string): PAnsiChar;
begin
  Result := '';

  if not Assigned(SipClient) or not SipClient.IsInitialized then
  begin
    doSaveLog('Conexão não inicializada, não foi possível discar.');
    Result := 'Conexão não inicializada, não foi possível discar.';
    Exit;
  end;

  try
    //Fone := GetDiscaFone(Fone,'', '');
    doSaveLog(Fone + '@' + SipClient.RegistrationProxy);
    SipClient.Connect(Fone + '@' + SipClient.RegistrationProxy);
    //VolMic := 10;
    //VolAutoFalantes := 10;

    Status := [rsDiscando];
    //DM.CONECT.Execute('INSERT INTO operadores_ligacoes (OPERADOR) VALUES (' + OPERADOR_CODIGO + ')');
  except
    on e: Exception do
    begin
      Result := Pchar(e.Message);
      doSaveLog('Erro ao discar' + #13 + e.Message);
      Status := [rsDesconectada];
    end;
  end;
end;

Function TclassSIP.EnviarDTMF(DTMF: String):PAnsiChar;
begin
  Result := '';
  try
    if SipClient.IsInitialized then
      SipClient.SendDTMF(DTMF);
  except
    on E: Exception do
    begin
      Result := Pchar(e.Message);
      doSaveLog('Erro ao EnviarDTMF' + #13 + e.Message);
    end;
  end;
end;

function TclassSIP.Transferir(Destino: String):PAnsiChar;
begin
  Result := '';
  try
    if SipClient.IsInitialized then
      SipClient.TransferCall(Destino + '@' + SipClient.RegistrationProxy);
      
    Status := Status + [rsTransferindo];
  except
    on e: Exception do
    begin
      Result := Pchar(e.Message);
      doSaveLog('Erro ao Transferir' + #13 + e.Message);
    end;
  end;
end;


procedure TclassSIP.SetVolMic(const Value: TVolume);
begin
  if SipClient.IsInitialized then
  begin
    FVolMic := Value;

    if Value > 100 then
      FVolMic := 100;

    try
      if Assigned(FOnMicVolumeChange) then
        FOnMicVolumeChange(FVolMic, Self);
    except
      on e: Exception do
      begin
        doSaveLog('Erro ao SetVolMic' + #13 + e.Message);
      end;
    end;

    SipClient.MicrophoneVolume := FVolMic;
  end;
end;

procedure TclassSIP.SetVolAutoFalantes(const Value: TVolume);
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

procedure TclassSIP.SetStatus(const Value: TRamalStatus);
begin
  if (FStatus = [rsChamando]) and (Value = [rsLivre]) then
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

    if Status = [rsRecebendo] then
      FStatusString := 'Recebendo ligação';

    if Status = [rsChamando] then
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
      if SIP_VOLUME_AUTOMATICO = 'S' then
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
        if SIP_VOLUME_AUTOMATICO = 'S' then
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
      doSaveLog('Erro ao SetStatus' + #13 + e.ClassName + #13 + e.Message);
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

procedure TclassSIP.IniciarGravacao;
var
  ArquivoGravacao: string;
begin
  if (rsEmLinha in Status) or (rsDiscando in Status) or (rsChamando in Status) then
  try
    if GravarLigacoesInterno then
    try
      ArquivoGravacao := IntToStr(CodigoLigacao) + '_' + FormatDateTime('dd-mm-yyyy_HH.NN.SS', Now) + '.wav';

      if SipClient.IsInitialized then
        SipClient.StartRecording(LocalGravacoes + ArquivoGravacao);
      Gravando := True;
    except
      on E: Exception do
      begin
        //addLog('Erro ao Iniciar gravacao' + #13 + e.ClassName + #13 + e.Message);
        //ShowMessageDesenv('Erro ao IniciarGravacao' + #13 + e.ClassName + #13 + e.Message);
        raise Exception.Create(e.message);
      end;
    end;
  finally

  end;
end;

procedure TclassSIP.PararGravacao;
begin
  {QQuery := TADOQuery.Create(nil);
  try
    QQuery.Connection := DM.CONECT;
    QQuery.SQL.Clear;
    QQuery.SQL.Text := ' select max(CODIGO) as CODIGO from operadores_ligacoes where fim is null and OPERADOR = ' + OPERADOR_CODIGO;
    QQuery.open;

    if QQuery.FieldByName('CODIGO').AsInteger > 0 then
    begin
      DM.CONECT.Execute('UPDATE operadores_ligacoes SET FIM = NOW() WHERE CODIGO = ' + QQuery.FieldByName('CODIGO').AsString);
    end;
    QQuery.close;
  finally
    freeandnil(QQuery);
  end;}

  if Gravando then
    if SipClient.IsInitialized then
    try
      Gravando := False;
      SipClient.StopRecording; // aqui da erro
    except
    end;
end;

procedure TclassSIP.OnFalhouReg(Sender: TObject);
begin
  doSaveLog('Falha ao Registrar com o servidor asterisk.');
  Registrado := False;
end;

procedure TclassSIP.OnRegOK(Sender: TObject);
begin
  Registrado := True;
end;

procedure TclassSIP.LogoffRegistro;
begin
  try
    if SipClient.IsInitialized then
      SipClient.UnRegister;
  except
    on e: Exception do
    begin
      doSaveLog('Erro ao unRegister' + #13 + e.Message);
    end;
  end;
  Registrado := False;
end;

procedure TclassSIP.SIPOnAlerting(ASender: TObject;
  const sFromURI: WideString; nLine: Integer);
begin
  try
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
      doSaveLog('Erro ao uAsterisk.SIPOnAlerting' + #13 + e.Message);
    end;
  end;
end;

procedure TclassSIP.SIPOnConnected(ASender: TObject;
  const sFromURI: WideString; nLine: Integer);
begin
  Status := [rsEmLinha];
end;

procedure TclassSIP.SIPOnDisconnect(ASender: TObject;
  const sFromURI: WideString; nLine: Integer);
begin
  Status := [rsLivre];
end;

procedure TclassSIP.SetAutoFalanteMute(const Value: Boolean);
begin
  FAutoFalanteMute := Value;
end;

procedure TclassSIP.SetAutoFalantePower(const Value: Integer);
begin
  FAutoFalantePower := Value;
end;

procedure TclassSIP.SetMicMute(const Value: Boolean);
begin
  FMicMute := Value;
end;

procedure TclassSIP.SetMicPower(const Value: Integer);
begin
  FMicPower := Value;
end;


procedure TclassSIP.StatusChange(pStatus: TRamalStatus; Sender: TObject);
begin
//  Status := pStatus;

  {Self.Caption := Trim(Asterisk.StatusString);

  if Assigned(frmAtivo) then
  begin
    frmAtivo.Caption := Trim(Asterisk.StatusString);
    frmAtivo.lblStatus.Caption := frmAtivo.Caption;
    frmAtivo.Lig.Ativa := (Status = [rsEmLinha]);
  end}

  //SetStatusOperador(Asterisk.StatusString);

end;

function TclassSIP.Desligar: PAnsiChar;
begin
  Liberar := True;
  Result := '';
  try
    if Assigned(SipClient) then
      if SipClient.IsInitialized then
      begin
        PararGravacao;
        SipClient.Disconnect;
      end;
  except
    on e: Exception do
    begin
      doSaveLog('Erro ao desligar' + #13 + e.Message);
      Result := Pchar(e.Message);
    end;
  end;
end;

procedure TclassSIP.AFPowerChange(var NewPower: Integer; Sender: TObject);
begin

end;

procedure TclassSIP.AFVolChange(var NewVolume: Integer; Sender: TObject);
begin

end;

procedure TclassSIP.MicPowerChange(var NewPower: Integer; Sender: TObject);
begin

end;

procedure TclassSIP.MicVolChange(var NewVolume: Integer; Sender: TObject);
begin

end;

destructor TclassSIP.destroy;
begin
  LogoffRegistro;
end;

procedure TclassSIP.SetLocalGravacoes(const Value: string);
begin
  FLocalGravacoes := Value;
  GravarLigacoesInterno := True;
  if not DirectoryExists(Value) then
  begin
    if not ForceDirectories(Value) then
    begin
      raise Exception.Create('Não foi possivel encontrar ou criar o diretório de gravações em: ' + #13
        + Value + #13 + 'As ligações desta sessão não serão gravadas');
      GravarLigacoesInterno := False;
    end;
  end;
end;

function TclassSIP.GetState: PAnsiChar;
var
  iPos:Integer;
  LineText:String;
  LineCod:Integer;
  vIsPlaying:WordBool;
  vCallState: INteger;
begin
  //(rsLivre, rsDiscando, rsRecebendo, rsChamando, rsEmLinha, rsTransferindo, rsIndisponivel, rsDesconectada)

  if SipClient = nil then
  begin
    //Status := [rsDesconectada];
    Result := '';
    exit;
  end;

  iPos := 0;
  SipClient.Update;
  LineText := SipClient.LineResponseText[iPos];
  LineCod := SipClient.LineResponseCode[iPos];
  vIsPlaying := SipClient.IsPlaying;
  vCallState := SipClient.CallState[iPos];

  case LineCod of
    0:begin
       //if fStatus = [rsEmLinha] then
       //  Status := [rsDesconectada]
       //else
       Status := [rsLivre];
    end;
    //200: Status := [rsDiscando];
    183,180: Status := [rsChamando];
    200: Status := [rsEmLinha];
    240: Status := [rsTransferindo];
    250: Status := [rsIndisponivel];

    {0 = livre
183 - Processo - chamando
180 chamando
200 - OK
vCallState
9 - resistrado/fechado
0,1 - chamando
2 - Ok
}
  end;

  Result := PChar(FStatusString);

  //SipClient.PhoneLine;
  //SipClient.Identity;
end;

end.

