unit uRotinasSIPAntigo;

interface

uses uInterfaceSIP, Windows, SysUtils, Inpulse.SIP.Models.Resgistrar;

type
  tMetodoSIP = function(const pParam: TObject): PAnsiChar; //stdcall;

type
  TRotinasSIPAntigo = class(TInterfacedObject, ISip)
  private
    DLLProg:Cardinal;
    MetodoSIP: tMetodoSIP;
  public
    function Ligar(const pObj: TObject):String;
    function Transferir(const pObj: TObject):String;
    function EnviarDTMF(const pObj: TObject):String;
    function Desligar:String;
    function Registrar(const pObj:TObject):String;
    function GetState:String;

    constructor create;
    destructor destroy;
    class function New(pDLLProg:Cardinal): ISip;
  End;

implementation

{ TRotinasSIPAntigo }

constructor TRotinasSIPAntigo.create;
begin
  inherited;
end;

class function TRotinasSIPAntigo.New(pDLLProg:Cardinal): ISip;
begin
  Result := Self.create;
  TRotinasSIPAntigo(Result).DLLProg := pDLLProg;
end;

function TRotinasSIPAntigo.Registrar(const pObj:TObject): String;
var
  vRetorno:PAnsiChar;
begin
  if DLLProg = 0 then exit;

  @MetodoSIP := GetProcAddress(DLLProg, PAnsiChar('Registrar'));
  try
    vRetorno := MetodoSIP(TRegistrar(pObj));

    if vRetorno <> '' then
      raise Exception.Create(vRetorno);

  except
    on E: Exception do
      raise Exception.Create(e.message);
  end;

end;

function TRotinasSIPAntigo.Transferir(const pObj: TObject): String;
var
  vRetorno:PAnsiChar;
begin
  if DLLProg = 0 then exit;

  @MetodoSIP := GetProcAddress(DLLProg, PAnsiChar('Transferir'));
  try
    vRetorno := MetodoSIP(TModelLigar(pObj));

    if vRetorno <> '' then
      raise Exception.Create(vRetorno);

  except
    on E: Exception do
      raise Exception.Create(e.message);
  end;
end;

function TRotinasSIPAntigo.Desligar: String;
var
  vRetorno:PAnsiChar;
begin
  if DLLProg = 0 then exit;

  @MetodoSIP := GetProcAddress(DLLProg, PAnsiChar('Desligar'));
  try
    vRetorno := MetodoSIP(nil);

    if vRetorno <> '' then
      raise Exception.Create(vRetorno);

  except
    on E: Exception do
      raise Exception.Create(e.message);
  end;
end;

destructor TRotinasSIPAntigo.destroy;
begin
end;

function TRotinasSIPAntigo.EnviarDTMF(const pObj: TObject): String;
var
  vRetorno:PAnsiChar;
begin
  if DLLProg = 0 then exit;

  @MetodoSIP := GetProcAddress(DLLProg, PAnsiChar('EnviarDTMF'));
  try
    vRetorno := MetodoSIP(TModelLigar(pObj));

    if vRetorno <> '' then
      raise Exception.Create(vRetorno);

  except
    on E: Exception do
      raise Exception.Create(e.message);
  end;
end;

function TRotinasSIPAntigo.GetState: String;
var
  vRetorno:WideString;
begin
  if DLLProg = 0 then exit;

  @MetodoSIP := GetProcAddress(DLLProg, PAnsiChar('GetState'));
  try
    vRetorno := MetodoSIP(TModelLigar(nil));

    if Pos('ERRO',UpperCase(Pchar(vRetorno))) > 0 then
      raise Exception.Create(vRetorno)
    else
      Result := vRetorno;
  except
    on E: Exception do
      raise Exception.Create(e.message);
  end;
end;

function TRotinasSIPAntigo.Ligar(const pObj: TObject): String;
var
  vRetorno:PAnsiChar;
begin
  if DLLProg = 0 then exit;

  @MetodoSIP := GetProcAddress(DLLProg, PAnsiChar('Ligar'));
  try
    vRetorno := MetodoSIP(TModelLigar(pObj));

    if vRetorno <> '' then
      raise Exception.Create(vRetorno);

  except
    on E: Exception do
      raise Exception.Create(e.message);
  end;

end;

end.
