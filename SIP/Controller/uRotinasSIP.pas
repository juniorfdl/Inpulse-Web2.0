unit uRotinasSIP;

interface

uses uInterfaceSIP, SipPhoneUnit;

type
  TRotinasSIP = class(TInterfacedObject, ISip)
    function Ligar(const pObj:TObject):String;
    function Transferir(const pObj:TObject):String;
    function EnviarDTMF(const pObj:TObject):String;
    function Desligar:String;
    function Registrar(const pObj:TObject):String;
    function GetState:String;
    constructor create;
  End;

implementation

{ TRotinasSIP }

constructor TRotinasSIP.create;
begin
  inherited;
  if not Assigned(SipPhoneForm) then
    SipPhoneForm := TSipPhoneForm.Create(nil);
end;

function TRotinasSIP.Desligar: String;
begin
  Result := TSipPhoneForm.Desligar('');
end;

function TRotinasSIP.EnviarDTMF(const pObj: TObject): String;
begin
//
end;

function TRotinasSIP.GetState: String;
begin
 //
end;

function TRotinasSIP.Ligar(const pObj:TObject): String;
begin
  Result := TSipPhoneForm.Ligar(pObj);
end;

function TRotinasSIP.Registrar(const pObj:TObject): String;
begin

end;

function TRotinasSIP.Transferir(const pObj: TObject): String;
begin
  //Result := TSipPhoneForm.Transferir(pObj);
end;

end.
