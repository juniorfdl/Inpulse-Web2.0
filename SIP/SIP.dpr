program SIP;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uFormServer in 'uFormServer.pas' {Form1},
  uServerModule in 'uServerModule.pas' {GetSIP: TDSServerModule},
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  uWebModule in 'uWebModule.pas' {WebModule1: TWebModule},
  uInterfaceSIP in 'Controller\uInterfaceSIP.pas',
  uRotinasSIP in 'Controller\uRotinasSIP.pas',
  SipPhoneUnit in 'Controller\SipPhoneUnit.pas' {SipPhoneForm},
  uRotinasSIPAntigo in 'Controller\uRotinasSIPAntigo.pas',
  Inpulse.SIP.Models.Resgistrar in 'Models\Inpulse.SIP.Models.Resgistrar.pas',
  SIPVoipSDK_TLB in 'Controller\SIPVoipSDK_TLB.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;

  Application.Initialize;
  Application.Title := 'Ligação Sip';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
