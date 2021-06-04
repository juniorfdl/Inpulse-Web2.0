program SIPDW;

uses
  Vcl.Forms,
  uServer in 'uServer.pas' {fServer},
  uDMServer in 'uDMServer.pas' {DMServer: TDataModule},
  Inpulse.SIP.Models.Resgistrar in '..\SIP\Models\Inpulse.SIP.Models.Resgistrar.pas',
  uInterfaceSIP in '..\SIP\Controller\uInterfaceSIP.pas',
  uRotinasSIPAntigo in '..\SIP\Controller\uRotinasSIPAntigo.pas';
  //SIPVoipSDK_TLB in '..\SIP\Controller\SIPVoipSDK_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Sip';
  Application.CreateForm(TfServer, fServer);
  Application.CreateForm(TDMServer, DMServer);
  Application.Run;
end.
