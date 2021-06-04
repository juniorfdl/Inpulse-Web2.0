library DllSipAntigo;

uses
  SysUtils,
  Classes,
  uclassSIP in 'uclassSIP.pas',
  Inpulse.SIP.Models.Resgistrar in '..\Models\Inpulse.SIP.Models.Resgistrar.pas',
  ufuncoes in 'ufuncoes.pas';

{$R *.res}

var
  vClassSip: TclassSIP;
  DDD_LOCAL : String;
  OPERADORA_LOCAL : String;
  Usa_ddds_diferentes : String;

procedure CriarClass;
begin
  if not Assigned(vClassSip) then
    vClassSip:= TclassSIP.create;
end;

function Ligar(const pParam: TObject):PAnsiChar;
var
  vObj: TModelLigar;
begin
  vObj := TModelLigar(pParam);
  CriarClass;

  try
    vClassSip.OPERADOR_NAME := vObj.NomeOperador;
    vClassSip.CodigoLigacao := StrToIntDef(vObj.CodigoLigacao,0);
    //vObj.Telefone := '051998718387';
    Result := vClassSip.Discar(vObj.Telefone,'', '');
  except
    on e: Exception do
      Result := Pchar(e.message);
  end;
end;

function Desligar(const pParam: TObject):PAnsiChar;
begin
  CriarClass;

  try
    Result := vClassSip.Desligar;
  except
    on e: Exception do
      Result := Pchar(e.message);
  end;
end;

//function Registrar(const pParam: array of PAnsiChar):PAnsiChar;
function Registrar(const pParam: TObject):PAnsiChar;
var
  vObj:TRegistrar;
begin
  vObj := TRegistrar(pParam);

  CriarClass;
  try
    vClassSip.ASTERISK_PROXY := vObj.ASTERISK_PROXY;
    vClassSip.ASTERISK_SERVER := vObj.ASTERISK_SERVER;
    vClassSip.ASTERISK_PORTA := vObj.ASTERISK_PORTA;
    vClassSip.SIP_EMITE_BIP := vObj.SIP_EMITE_BIP;
    vClassSip.SIP_VOLUME_AUTOMATICO := vObj.SIP_VOLUME_AUTOMATICO;

    vClassSip.UserID := vObj.ASTERISK_USERID;
    vClassSip.LoginID := vObj.ASTERISK_LOGIN;
    vclassSIP.Password := vObj.ASTERISK_SENHA;
    vclassSIP.DisplayName := vObj.ASTERISK_USERID;
    vclassSIP.LocalGravacoes := vObj.LOCAL_GRAVACAO;
    DDD_LOCAL := vObj.DDD_LOCAL;
    OPERADORA_LOCAL := vObj.OPERADORA_LOCAL;
    Usa_ddds_diferentes := vObj.Usa_ddds_diferentes;
    Result := vClassSip.ConfSIP;
  except
    on e: Exception do
      Result := Pchar(e.message);
  end;
end;

function DesRegistrar(const pParam: TObject):PAnsiChar;
begin
  CriarClass;

  try
    vClassSip.LogoffRegistro;
  except
    on e: Exception do
      Result := Pchar(e.message);
  end;
end;

function GetState(const pParam: TObject):PAnsiChar;

begin
  CriarClass;

  try
    Result := vClassSip.GetState;
  except
    on e: Exception do
      Result := Pchar(e.message);
  end;
end;

function Transferir(const pParam: TObject):PAnsiChar;
var
  vObj: TModelLigar;
begin
  vObj := TModelLigar(pParam);
  CriarClass;

  try
    Result := vClassSip.Transferir(vObj.Telefone);
  except
    on e: Exception do
      Result := Pchar(e.message);
  end;
end;

function EnviarDTMF(const pParam: TObject):PAnsiChar;
var
  vObj: TModelLigar;
begin
  vObj := TModelLigar(pParam);
  CriarClass;

  try
    Result := vClassSip.EnviarDTMF(vObj.Telefone);
  except
    on e: Exception do
      Result := Pchar(e.message);
  end;
end;



exports EnviarDTMF, Transferir, Ligar, Desligar, Registrar, DesRegistrar, GetState;

begin
end.
